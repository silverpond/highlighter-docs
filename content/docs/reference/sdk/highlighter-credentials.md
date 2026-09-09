+++
title = "Highlighter SDK Credentials"
description = "How to create a set credentials for interacting with Highlighter via the CLI or Python SDK"
date = 2024-03-12T08:00:00+00:00
updated = 2026-09-09T08:00:00+00:00
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

1. Click your name and email at the bottom of the left sidebar to open the account dropdown
1. Click **Profile** in the dropdown
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

#### Option 3: Profiles stored by the CLI

`hl profile create` stores a profile in your operating system's credential
store, so the API token never sits in a file you have to protect yourself:

```bash
hl profile create \
  --name compuglobalhypermeganet \
  --api-token d000d0d0d0d0d0d0d000d0d0d0d0d0d0 \
  --endpoint-url https://compuglobalhypermeganet.highlighter.ai/graphql
```

All three options are required. On a machine with no OS keyring, the command
stops rather than quietly writing the token to disk, and tells you what to do
instead: set `HL_WEB_GRAPHQL_API_TOKEN` and `HL_WEB_GRAPHQL_ENDPOINT` (the
option above, suited to CI), or accept a local plaintext fallback by passing
`--allow-plaintext` or setting `HL_ALLOW_PLAINTEXT_PROFILE_STORE=1`. The
fallback file is `~/.highlighter/profiles.secrets.toml`, and every command that
reads it warns that it holds credentials in plaintext.

##### Rotating a token or moving an account

`hl profile update` changes the fields you name and leaves the rest of the
profile alone, so rotating a token does not mean re-entering the endpoint:

```bash
# Rotate the token, keep the endpoint
hl profile update --name compuglobalhypermeganet --api-token <NEW_TOKEN>

# Point an existing profile at a different account
hl profile update --name compuglobalhypermeganet --endpoint-url https://other-account.highlighter.ai/graphql
```

Only `--name` is required. Pass `--api-token`/`-t`, `--endpoint-url`/`-u`, or
both; anything you leave out keeps its current value, and any cloud credentials
on the profile are preserved. Passing neither is an error rather than a silent
no-op, and updating a profile that does not exist tells you to create it first.
`update` writes the profile back the same way `create` does, so on a machine
with no OS keyring it needs the same `--allow-plaintext` opt-in.

