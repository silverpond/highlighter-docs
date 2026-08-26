+++
title = "Highlighter SDK Credentials"
description = "How to create a set credentials for interacting with Highlighter via the CLI or Python SDK"
date = 2024-03-12T08:00:00+00:00
updated = 2026-08-26T08:00:00+00:00
draft = false
weight = 1
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Learn to configure credentials for interacting with Highlighter via the CLI or Python SDK'
toc = true
top = false
+++

This guide will help you to configure the credentials needed to interact with
Highlighter via the CLI or the Python SDK.


### Create an API Token

1. Click the user icon on the right of the top ribbon {{ resize_image(path="docs/user-manual/resources/user-icon.png", width=200, height=1, op="fit_width") }}
1. Click your name at the top of the dropdown
2. Scroll to the bottom and click **Request Access Token** and save it somewhere safe

#### Option 1: Environment Variables

This is a quick and simple solution if you're only interacting with a single
Highlighter account.

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
export HL_WEB_GRAPHQL_API_TOKEN=###
export HL_WEB_GRAPHQL_ENDPOINT=https://YOUR_HIGHLIGHTER_ACCOUNT.highlighter.ai/graphql
```

```powershell
$env:HL_WEB_GRAPHQL_API_TOKEN = "###"
$env:HL_WEB_GRAPHQL_ENDPOINT = "https://YOUR_HIGHLIGHTER_ACCOUNT.highlighter.ai/graphql"
```
{% end %}

For example

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
export HL_WEB_GRAPHQL_API_TOKEN=d000d0d0d0d0d0d0d000d0d0d0d0d0d0
export HL_WEB_GRAPHQL_ENDPOINT=https://compuglobalhypermeganet.highlighter.ai/graphql
```

```powershell
$env:HL_WEB_GRAPHQL_API_TOKEN = "d000d0d0d0d0d0d0d000d0d0d0d0d0d0"
$env:HL_WEB_GRAPHQL_ENDPOINT = "https://compuglobalhypermeganet.highlighter.ai/graphql"
```
{% end %}

#### Option 2: Highlighter Profiles

If you're dealing with multiple Highlighter accounts you can use
a profiles yaml file in at `~/.highlighter-profiles.yaml`

```yaml
# ~/.highlighter-profiles.yaml

compuglobalhypermeganet:
  api_token: d000d0d0d0d0d0d0d000d0d0d0d0d0d0
  endpoint_url: https://compuglobalhypermeganet.highlighter.ai/graphql

...
```

You can now use the `--profile compuglobalhypermeganet` option when using the CLI or
`HLClient.from_profile(...)` if using the Python SDK

##### Selecting a default profile

`hl profile set <name>` sets the default profile for the current project
(written to `./.hl_config`); add `--global` to set it for your user. Without a
name, the command shows an interactive menu of the available profiles.
`hl profile list` shows every available profile and the store it lives in:

- **Secure profiles**, created with `hl profile create` and kept in your
  operating system's credential store.
- **Legacy profiles**, the plaintext YAML file described above
  (`~/.highlighter-profiles.yaml`, or the path in `HL_PROFILES_YAML`).

If the same name exists in both stores, the secure profile wins. Selecting a
legacy profile prints a warning that it is stored in plaintext and should be
migrated:

```bash
hl profile migrate --path ~/.highlighter-profiles.yaml
```

A default profile must stay resolvable for later commands, so `hl profile set`
refuses to select a legacy profile that was only found through a one-off
`--profiles-path` argument: migrate it first, or export `HL_PROFILES_YAML` to
point at the file. A legacy profiles file that cannot be read or parsed is
reported as an error naming the file, rather than silently appearing as
"no profiles".

