# A github action for ghsettings

This action runs ghsettings to configure organisation wide repository settings

## Features

* Repo settings
* Team access
* Collaborator Access
* Branch Protections

# Usage

To apply settings to other reposotories the MU\_GITHUB\_TOKEN requires admin permissions

## Example usage

* Create an action to run ghsettings

```yaml
on:
  push:
    branches:
    - master
    paths:
    - 'repo_config/**'
  schedule:
    - cron:  '0 * * * *'

name: ghsettings

jobs:
  ghsettings:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: mkrakowitzer/actions-ghsettings@v1.1
    env:
     MU_GITHUB_TOKEN: ${{ secrets.MU_GITHUB_TOKEN }}
     GITHUB_ORG: myorgname
```

create a `repo_config` directory inside this repo. One file per repo you are managing:

Example `test.yaml`

```yaml
repository:
  # Repository Name
  name: test2

  # A short description of the repository that will show up on GitHub
  description: test2 description of repo

  # A URL with more information about the repository
  homepage: https://example.github.io/

  # Either `true` to make the repository private, or `false` to make it public.
  private: false

  # Either `true` to enable issues for this repository, `false` to disable them.
  has_issues: true

  # Either `true` to enable projects for this repository, or `false` to disable them.
  # If projects are disabled for the organization, passing `true` will cause an API error.
  has_projects: true

  # Either `true` to enable the wiki for this repository, `false` to disable it.
  has_wiki: true

  # Updates the default branch for this repository.
  default_branch: master

  # Either `true` to allow squash-merging pull requests, or `false` to prevent
  # squash-merging.
  allow_squash_merge: true

  # Either `true` to allow merging pull requests with a merge commit, or `false`
  # to prevent merging pull requests with merge commits.
  allow_merge_commit: true

  # Either `true` to allow rebase-merging pull requests, or `false` to prevent
  # rebase-merging.
  allow_rebase_merge: true

  # Delete branch on merge
  delete_branch_on_merge: true

# Collaborators: give specific users access to this repository.
collaborators:
  - username: username1
    # Note: Only valid on organization-owned repositories.
    # The permission to grant the collaborator. Can be one of:
    # * `pull` - can pull, but not push to or administer this repository.
    # * `push` - can pull and push, but not administer this repository.
    # * `admin` - can pull, push and administer this repository.
    # * `maintain` - 
    # * `triage` - 
    permission: triage
  - username: username2
    permission: admin

# Teams: give specific users access to this repository.
teams:
  - name: platform
    # The permission to grant the team. Can be one of:
    # * `pull` - can pull, but not push to or administer this repository.
    # * `push` - can pull and push, but not administer this repository.
    # * `admin` - can pull, push and administer this repository.
    # * `maintian` - 
    # * `triage` - 
    permission: maintain
  - name: everyone
    permission: pull

branches:
  - name: master
    # Require pull request reviews before merging
    # When enabled, all commits must be made to a non-protected branch and
    # submitted via a pull request with the required number of approving 
    # reviews and no changes requested before it can be merged into a branch
    # that matches this rule.
    requiresApprovingReviews: true

    # Required number of approvers
    requiredApprovingReviewCount: 1

    # Dismiss stale pull request approvals when new commits are pushed
    # New reviewable commits pushed to a matching branch will dismiss pull request review approvals.
    dismissesStaleReviews: true

    # Require review from Code Owners
    # Require an approved review in pull requests including files with a designated code owner.
    requiresCodeOwnerReviews: true

    # Require status checks to pass before merging
    # Choose which status checks must pass before branches can be merged into a branch that matches this rule.
    # When enabled, commits must first be pushed to another branch, then merged or pushed directly to a branch
    # that matches this rule after status checks have passed.
    requiresStatusChecks: true

    # The names of the status checks
    requiredStatusCheckContexts:
    - foo
    - bar

    # Require branches to be up to date before merging
    # This ensures pull requests targeting a matching branch have been tested with the latest code.
    # This setting will not take effect unless at least one status check is enabled.
    requiresStrictStatusChecks: true

    # Commits pushed to matching branches must have verified signatures.
    requiresCommitSignatures: true

    # Restrict who can push to matching branches
    # Specify people, teams or apps allowed to push to matching branches. Required status checks will still prevent these people, teams and apps from merging if the checks fail.
    restrictsPushes: false

    # Restrict who can push to matching branches
    # Specify people, teams or apps allowed to push to matching branches. Required status checks will still prevent these people, teams and apps from merging if the checks fail.
    # TODO: Lookup Ids of users, teams etc
    pushActorIds: []

    # Include administrators
    # Enforce all configured restrictions above for administrators.
    isAdminEnforced: true
```

# Limitations
Currently ghsettings manages the repo, collaborators, teams and branches. Removing any of these maps, removes any manually added users, groups and branches

