+++
title = "Highlighter SDK Credentials"
description = "How to create a set credentials for interacting with Highlighter via the CLI or Python SDK"
date = 2024-03-12T08:00:00+00:00
updated = 2024-03-12T08:00:00+00:00
draft = false
weight = 100
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

1. Click the user icon on the right of the top ribbon {{ resize_image(path="docs/how-to-guides/user-icon.png", width=200, height=1, op="fit_width") }}
1. Click your name at the top of the dropdown
2. Scroll to the bottom and click **Request Access Token** and save it somewhere safe

#### Option 1: Environment Variables

This is a quick and simple solution if you're only interacting with a single
Highlighter account.

```shell
export HL_WEB_GRAPHQL_API_TOKEN=###
export HL_WEB_GRAPHQL_ENDPOINT=https://YOUR_HIGHLIGHTER_ACCOUNT.highlighter.ai/graphql
```

For example

```shell
export HL_WEB_GRAPHQL_API_TOKEN=d000d0d0d0d0d0d0d000d0d0d0d0d0d0
export HL_WEB_GRAPHQL_ENDPOINT=https://compuglobalhypermeganet.highlighter.ai/graphql
```

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

