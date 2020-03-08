# Homebrew Formula Audit Action

An action that audits your [Homebrew formula](https://brew.sh) using the built-in `brew audit` command. Audit problems identified will be annotated with inline annotations for easy correction.

![Example of an audit action with inline annotations](audit-example.png)

## Usage

```yaml
name: Audit Homebrew Formula
on:
  push:
    branches: master
  pull_request: []
jobs:
  tests:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: jonchang/audit-action@master
```
