###-------------------------------------
### Project variables
###-------------------------------------
variable "avatar" {
  description = "Path to avatar image file. Image must be 192x192 pixels and less than 200kb"
  type        = string
  default     = ""
}
variable "builds_access_level" {
  description = "Set the builds access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "enabled"
}
variable "ci_forward_deployment_enabled" {
  description = "When a new deployment job starts, skip older deployment jobs that are still pending."
  type        = bool
  default     = true
}
variable "ci_forward_deployment_rollback_allowed" {
  description = "Allow job retries even if the deployment job is outdated."
  type        = bool
  default     = false
}
# ci_id_token_sub_claim_components type = list(string) v17.10 we're on 17.5.4
variable "default_branch" {
  description = "The default branch for the project."
  type        = string
  default     = "main"
}
variable "description" {
  description = "A description of the project."
  type        = string
}
variable "emails_enabled" {
  description = "Enable email notifications."
  type        = bool
  default     = true
}
variable "environments_access_level" {
  description = "Set the environments access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "disabled"
}
variable "feature_flags_access_level" {
  description = "Set the feature flags access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "disabled"
}
variable "group_runners_enabled" {
  description = "Enable group runners for this project."
  type        = bool
  default     = true
}
variable "infrastructure_access_level" {
  description = "Set the infrastructure access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "enabled"
}
variable "issues_access_level" {
  description = "Set the issues access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "disabled"
}
variable "merge_commit_template" {
  description = "Template used to create merge commit message in merge requests."
  type        = string
  default     = <<MERGE
### Description
<Insert your PR description here>

### How-to Test
<Insert information on how to test this PR>

### Commits in this MR
%%{all_commits}

# DO NOT EDIT BELOW THIS LINE
/assign_reviewer @devs-we-want-to-review
MERGE
}
variable "model_experiments_access_level" {
  description = "Set visibility of machine learning model experiments. Valid values are disabled, private, enabled."
  type        = string
  default     = "disabled"
}
variable "model_registry_access_level" {
  description = "Set visibility of machine learning model registry. Valid values are disabled, private, enabled."
  type        = string
  default     = "disabled"
}
variable "monitor_access_level" {
  description = "Set the monitor access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "enabled"
}
variable "name" {
  description = "The name of the project."
  type        = string
}
variable "namespace_id" {
  description = "The namespace (group or user) of the project."
  type        = string
  default     = ""
}
variable "public_jobs" {
  description = "If true, jobs can be viewed by non-project members."
  type        = bool
  default     = false
}
variable "push_prevent_secrets" {
  description = "GitLab will reject any files that are likely to contain secrets."
  type        = bool
  default     = true
}
variable "repository_access_level" {
  description = "Set the repository access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "enabled"
}
variable "requirements_access_level" {
  description = "Set the requirements access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "enabled"
}
#squash_commit_template
variable "squash_option" {
  description = "Squash commits when merge request is merged. Valid values are never (Do not allow), always (Require), default_on (Encourage), or default_off (Allow). The default value is default_off (Allow)."
  type        = string
  default     = "default_on"
}
variable "topics" {
  description = "The list of topics for the project."
  type        = set(string)
  default     = []
}
variable "visibility_level" {
  description = "Set to public to create a public project. Valid values are private, internal, public."
  type        = string
  default     = "internal"
}
variable "wiki_access_level" {
  description = "Set the wiki access level. Valid values are disabled, private, enabled."
  type        = string
  default     = "disabled"
}

### Approval rules - any
# applies_to_all_protected_branches
# approvals_required
# name
# rule_type
#   applies_to_all_protected_branches = true
#   approvals_required                = 1
#   name                              = "Any name"
#   rule_type                         = "any_approver"

###-------------------------------------
### Branch Protection variables
###-------------------------------------
variable "branch_allow_force_push" {
  description = "Can be set to true to allow users with push access to force push."
  type        = bool
  default     = false
}
variable "branch_code_owner_approval_required" {
  description = "Can be set to true to require code owner approval before merging."
  type        = bool
  default     = true
}
variable "branch_merge_access_level" {
  description = "Access levels allowed to merge. Valid values are: no one, developer, maintainer, admin."
  type        = string
  default     = "developer"
}
variable "branch_push_access_level" {
  description = "Access levels allowed to push. Valid values are: no one, developer, maintainer, admin."
  type        = string
  default     = "developer"
}
variable "branch_unprotect_access_level" {
  description = "Access levels allowed to unprotect. Valid values are: developer, maintainer, admin."
  type        = string
  default     = "developer"
}

###-------------------------------------
### Integration variables
###-------------------------------------
variable "wiki_url" {
  description = "External Wiki URL"
  type        = string
  default     = ""
}

###-------------------------------------
### MR Approvals
###-------------------------------------
variable "mr_approval_disable_overriding_approvers_per_merge_request" {
  description = "Set to true to disable overriding approvers per merge request."
  type        = bool
  default     = false
}
variable "mr_approval_merge_requests_author_approval" {
  description = "Set to true to allow merge requests authors to approve their own merge requests."
  type        = bool
  default     = false
}
variable "mr_approval_merge_requests_disable_committers_approval" {
  description = "Set to true to disable merge request committers from approving their own merge requests."
  type        = bool
  default     = true
}
variable "mr_approval_reset_approvals_on_push" {
  description = "Set to true to remove all approvals in a merge request when new commits are pushed to its source branch."
  type        = bool
  default     = true
}
variable "environments" {
  description = "Deployment environments"
  type = map(object({
    auto_stop_setting  = optional(string)
    description        = string
    protected          = optional(bool, false)
    approval_access    = optional(string, "developer")
    required_approvals = optional(number, 1)
    deploy_access      = optional(string, "developer")
    tier               = optional(string, "development")
  }))
  default = {
    "production" = {
      description = "Production Environment"
      protected   = true
      tier        = "production"
    }
  }
}
