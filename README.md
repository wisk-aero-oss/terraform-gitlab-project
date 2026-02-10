
<!-- BEGIN_TF_DOCS -->
# terraform-gitlab-project

[![Releases](https://img.shields.io/github/v/release/wisk-aero-oss/terraform-gitlab-project)](https://github.com/wisk-aero-oss/terraform-gitlab-project/releases)

[Terraform Module Registry](https://registry.terraform.io/modules/wisk-aero-oss/project/gitlab)

Terraform module for managing a GitLab project

## Features

- Manage GitLab projects with customizable settings
- Configure branch protections and merge request approval rules
- Integrate with external wikis
- Define project environments and protected environments

## Usage

Basic usage of this module is as follows:

```hcl
module "example" {
    source = "wisk-aero-oss/project/gitlab"
    # Recommend pinning every module to a specific version
    # version = "x.x.x"
    # Required variables
        description =
        name =
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | >= 18.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 18.8.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [gitlab_branch_protection.default](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/branch_protection) | resource |
| [gitlab_project.self](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project) | resource |
| [gitlab_project_approval_rule.any_approver](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_approval_rule) | resource |
| [gitlab_project_environment.self](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_environment) | resource |
| [gitlab_project_integration_external_wiki.wiki](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_integration_external_wiki) | resource |
| [gitlab_project_level_mr_approvals.self](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_level_mr_approvals) | resource |
| [gitlab_project_protected_environment.self](https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project_protected_environment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_avatar"></a> [avatar](#input\_avatar) | Path to avatar image file. Image must be 192x192 pixels and less than 200kb | `string` | `""` | no |
| <a name="input_branch_allow_force_push"></a> [branch\_allow\_force\_push](#input\_branch\_allow\_force\_push) | Can be set to true to allow users with push access to force push. | `bool` | `false` | no |
| <a name="input_branch_code_owner_approval_required"></a> [branch\_code\_owner\_approval\_required](#input\_branch\_code\_owner\_approval\_required) | Can be set to true to require code owner approval before merging. | `bool` | `true` | no |
| <a name="input_branch_merge_access_level"></a> [branch\_merge\_access\_level](#input\_branch\_merge\_access\_level) | Access levels allowed to merge. Valid values are: no one, developer, maintainer, admin. | `string` | `"developer"` | no |
| <a name="input_branch_push_access_level"></a> [branch\_push\_access\_level](#input\_branch\_push\_access\_level) | Access levels allowed to push. Valid values are: no one, developer, maintainer, admin. | `string` | `"developer"` | no |
| <a name="input_branch_unprotect_access_level"></a> [branch\_unprotect\_access\_level](#input\_branch\_unprotect\_access\_level) | Access levels allowed to unprotect. Valid values are: developer, maintainer, admin. | `string` | `"developer"` | no |
| <a name="input_builds_access_level"></a> [builds\_access\_level](#input\_builds\_access\_level) | Set the builds access level. Valid values are disabled, private, enabled. | `string` | `"enabled"` | no |
| <a name="input_ci_forward_deployment_enabled"></a> [ci\_forward\_deployment\_enabled](#input\_ci\_forward\_deployment\_enabled) | When a new deployment job starts, skip older deployment jobs that are still pending. | `bool` | `true` | no |
| <a name="input_ci_forward_deployment_rollback_allowed"></a> [ci\_forward\_deployment\_rollback\_allowed](#input\_ci\_forward\_deployment\_rollback\_allowed) | Allow job retries even if the deployment job is outdated. | `bool` | `false` | no |
| <a name="input_default_branch"></a> [default\_branch](#input\_default\_branch) | The default branch for the project. | `string` | `"main"` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the project. | `string` | n/a | yes |
| <a name="input_emails_enabled"></a> [emails\_enabled](#input\_emails\_enabled) | Enable email notifications. | `bool` | `true` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | Deployment environments | <pre>map(object({<br/>    auto_stop_setting  = optional(string)<br/>    description        = string<br/>    protected          = optional(bool, false)<br/>    approval_access    = optional(string, "developer")<br/>    required_approvals = optional(number, 1)<br/>    deploy_access      = optional(string, "developer")<br/>    tier               = optional(string, "development")<br/>  }))</pre> | <pre>{<br/>  "production": {<br/>    "description": "Production Environment",<br/>    "protected": true,<br/>    "tier": "production"<br/>  }<br/>}</pre> | no |
| <a name="input_environments_access_level"></a> [environments\_access\_level](#input\_environments\_access\_level) | Set the environments access level. Valid values are disabled, private, enabled. | `string` | `"disabled"` | no |
| <a name="input_feature_flags_access_level"></a> [feature\_flags\_access\_level](#input\_feature\_flags\_access\_level) | Set the feature flags access level. Valid values are disabled, private, enabled. | `string` | `"disabled"` | no |
| <a name="input_group_runners_enabled"></a> [group\_runners\_enabled](#input\_group\_runners\_enabled) | Enable group runners for this project. | `bool` | `true` | no |
| <a name="input_infrastructure_access_level"></a> [infrastructure\_access\_level](#input\_infrastructure\_access\_level) | Set the infrastructure access level. Valid values are disabled, private, enabled. | `string` | `"enabled"` | no |
| <a name="input_issues_access_level"></a> [issues\_access\_level](#input\_issues\_access\_level) | Set the issues access level. Valid values are disabled, private, enabled. | `string` | `"disabled"` | no |
| <a name="input_merge_commit_template"></a> [merge\_commit\_template](#input\_merge\_commit\_template) | Template used to create merge commit message in merge requests. | `string` | `"### Description\n<Insert your PR description here>\n\n### How-to Test\n<Insert information on how to test this PR>\n\n### Commits in this MR\n%{all_commits}\n\n# DO NOT EDIT BELOW THIS LINE\n/assign_reviewer @devs-we-want-to-review\n"` | no |
| <a name="input_model_experiments_access_level"></a> [model\_experiments\_access\_level](#input\_model\_experiments\_access\_level) | Set visibility of machine learning model experiments. Valid values are disabled, private, enabled. | `string` | `"disabled"` | no |
| <a name="input_model_registry_access_level"></a> [model\_registry\_access\_level](#input\_model\_registry\_access\_level) | Set visibility of machine learning model registry. Valid values are disabled, private, enabled. | `string` | `"disabled"` | no |
| <a name="input_monitor_access_level"></a> [monitor\_access\_level](#input\_monitor\_access\_level) | Set the monitor access level. Valid values are disabled, private, enabled. | `string` | `"enabled"` | no |
| <a name="input_mr_approval_disable_overriding_approvers_per_merge_request"></a> [mr\_approval\_disable\_overriding\_approvers\_per\_merge\_request](#input\_mr\_approval\_disable\_overriding\_approvers\_per\_merge\_request) | Set to true to disable overriding approvers per merge request. | `bool` | `false` | no |
| <a name="input_mr_approval_merge_requests_author_approval"></a> [mr\_approval\_merge\_requests\_author\_approval](#input\_mr\_approval\_merge\_requests\_author\_approval) | Set to true to allow merge requests authors to approve their own merge requests. | `bool` | `false` | no |
| <a name="input_mr_approval_merge_requests_disable_committers_approval"></a> [mr\_approval\_merge\_requests\_disable\_committers\_approval](#input\_mr\_approval\_merge\_requests\_disable\_committers\_approval) | Set to true to disable merge request committers from approving their own merge requests. | `bool` | `true` | no |
| <a name="input_mr_approval_reset_approvals_on_push"></a> [mr\_approval\_reset\_approvals\_on\_push](#input\_mr\_approval\_reset\_approvals\_on\_push) | Set to true to remove all approvals in a merge request when new commits are pushed to its source branch. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the project. | `string` | n/a | yes |
| <a name="input_namespace_id"></a> [namespace\_id](#input\_namespace\_id) | The namespace (group or user) of the project. | `string` | `""` | no |
| <a name="input_path"></a> [path](#input\_path) | The path of the project | `string` | `null` | no |
| <a name="input_public_jobs"></a> [public\_jobs](#input\_public\_jobs) | If true, jobs can be viewed by non-project members. | `bool` | `false` | no |
| <a name="input_push_prevent_secrets"></a> [push\_prevent\_secrets](#input\_push\_prevent\_secrets) | GitLab will reject any files that are likely to contain secrets. | `bool` | `true` | no |
| <a name="input_repository_access_level"></a> [repository\_access\_level](#input\_repository\_access\_level) | Set the repository access level. Valid values are disabled, private, enabled. | `string` | `"enabled"` | no |
| <a name="input_requirements_access_level"></a> [requirements\_access\_level](#input\_requirements\_access\_level) | Set the requirements access level. Valid values are disabled, private, enabled. | `string` | `"enabled"` | no |
| <a name="input_squash_option"></a> [squash\_option](#input\_squash\_option) | Squash commits when merge request is merged. Valid values are never (Do not allow), always (Require), default\_on (Encourage), or default\_off (Allow). The default value is default\_off (Allow). | `string` | `"default_on"` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | The list of topics for the project. | `set(string)` | `[]` | no |
| <a name="input_visibility_level"></a> [visibility\_level](#input\_visibility\_level) | Set to public to create a public project. Valid values are private, internal, public. | `string` | `"internal"` | no |
| <a name="input_wiki_access_level"></a> [wiki\_access\_level](#input\_wiki\_access\_level) | Set the wiki access level. Valid values are disabled, private, enabled. | `string` | `"disabled"` | no |
| <a name="input_wiki_url"></a> [wiki\_url](#input\_wiki\_url) | External Wiki URL | `string` | `""` | no |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
