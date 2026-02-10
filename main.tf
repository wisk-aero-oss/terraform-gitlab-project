/**
 * # terraform-gitlab-project
 *
 * [![Releases](https://img.shields.io/github/v/release/wisk-aero-oss/terraform-gitlab-project)](https://github.com/wisk-aero-oss/terraform-gitlab-project/releases)
 *
 * [Terraform Module Registry](https://registry.terraform.io/modules/wisk-aero-oss/project/gitlab)
 *
 * Terraform module for managing a GitLab project
 *
 * ## Features
 *
 * - Manage GitLab projects with customizable settings
 * - Configure branch protections and merge request approval rules
 * - Integrate with external wikis
 * - Define project environments and protected environments
 *
 */

###-----------------------------
### Manage Project
###-----------------------------
resource "gitlab_project" "self" {
  name = var.name

  builds_access_level                    = var.builds_access_level
  avatar                                 = var.avatar
  avatar_hash                            = var.avatar != "" ? filesha256(var.avatar) : ""
  ci_forward_deployment_enabled          = var.ci_forward_deployment_enabled
  ci_forward_deployment_rollback_allowed = var.ci_forward_deployment_rollback_allowed
  description                            = var.description
  emails_enabled                         = var.emails_enabled
  environments_access_level              = var.environments_access_level
  feature_flags_access_level             = var.feature_flags_access_level
  group_runners_enabled                  = var.group_runners_enabled
  infrastructure_access_level            = var.infrastructure_access_level
  issues_access_level                    = var.issues_access_level
  merge_commit_template                  = var.merge_commit_template
  model_experiments_access_level         = var.model_experiments_access_level
  model_registry_access_level            = var.model_registry_access_level
  monitor_access_level                   = var.monitor_access_level
  namespace_id                           = var.namespace_id
  path                                   = var.path
  public_jobs                            = var.public_jobs
  repository_access_level                = var.repository_access_level
  requirements_access_level              = var.requirements_access_level
  squash_option                          = var.squash_option
  topics                                 = var.topics
  visibility_level                       = var.visibility_level
  wiki_access_level                      = var.wiki_access_level
  push_rules {
    #author_email_regex            = "@gitlab.com$"
    #branch_name_regex             = "(feat|fix)\\/*"
    #commit_committer_check        = true
    #commit_committer_name_check   = true
    #commit_message_negative_regex = "ssh\\:\\/\\/"
    #commit_message_regex          = "(feat|fix):.*"
    #deny_delete_tag               = false
    #file_name_regex               = "(jar|exe)$"
    #max_file_size                 = 4
    #member_check                  = true
    prevent_secrets = var.push_prevent_secrets
    #reject_non_dco_commits        = false
    #reject_unsigned_commits       = false
  }
}

resource "gitlab_branch_protection" "default" {
  project                      = gitlab_project.self.id
  branch                       = var.default_branch
  allow_force_push             = var.branch_allow_force_push
  code_owner_approval_required = var.branch_code_owner_approval_required
  merge_access_level           = var.branch_merge_access_level
  push_access_level            = var.branch_push_access_level
  unprotect_access_level       = var.branch_unprotect_access_level
  depends_on                   = [gitlab_project.self]
}
resource "gitlab_project_approval_rule" "any_approver" {
  project                           = gitlab_project.self.id
  applies_to_all_protected_branches = true
  approvals_required                = 1
  name                              = "Any name"
  rule_type                         = "any_approver"
  depends_on                        = [gitlab_project.self]
}
# TODO: Replace with Confluence integration when provider has it
resource "gitlab_project_integration_external_wiki" "wiki" {
  count             = var.wiki_url == "" ? 0 : 1
  project           = gitlab_project.self.id
  external_wiki_url = var.wiki_url
  depends_on        = [gitlab_project.self]
}
resource "gitlab_project_level_mr_approvals" "self" {
  project                                        = gitlab_project.self.id
  disable_overriding_approvers_per_merge_request = var.mr_approval_disable_overriding_approvers_per_merge_request
  merge_requests_author_approval                 = var.mr_approval_merge_requests_author_approval
  merge_requests_disable_committers_approval     = var.mr_approval_merge_requests_disable_committers_approval
  reset_approvals_on_push                        = var.mr_approval_reset_approvals_on_push
  depends_on                                     = [gitlab_project.self]
}

resource "gitlab_project_environment" "self" {
  for_each = {
    for k, env in var.environments : k => env
    if !startswith(gitlab_project.self.id, "gitlab-profile")
    && var.environments_access_level == "enabled"
  }
  #auto_stop_setting = "" # only for test environment
  description = each.value.description
  name        = each.key
  project     = gitlab_project.self.id
  tier        = each.value.tier
}
resource "gitlab_project_protected_environment" "self" {
  for_each = {
    for k, env in var.environments : k => env
    if env.protected && !startswith(gitlab_project.self.id, "gitlab-profile")
    && var.environments_access_level == "enabled"
  }
  environment = gitlab_project_environment.self[each.key].name
  project     = gitlab_project_environment.self[each.key].project
  approval_rules = [
    {
      access_level       = each.value.approval_access
      required_approvals = each.value.required_approvals
    }
  ]
  deploy_access_levels_attribute = [
    {
      access_level = each.value.deploy_access
    },
  ]
}
