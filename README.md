# A github action for ghsettings

This action runs ghsettings to configure organisation wide repository settings

## Features

* Repo settings
* Team access
* Collaborator Access
* Branch Protections

## Example usage

```yaml
on: [push]

name: ghsettings

jobs:
  ghsettings:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: mkrakowitzer/actions-ghsettings@master
    env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
	  GITHUB_ORG: ${{ secrets.GITHUB_ORG }}
```
