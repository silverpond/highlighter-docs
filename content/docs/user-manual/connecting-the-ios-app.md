+++
title = "Connecting the iOS App"
description = "Sign in once in your browser, approve the Highlighter iOS app for one account, and control how the connection is used and disconnected."
date = 2026-08-17T08:00:00+00:00
updated = 2026-08-17T08:00:00+00:00
draft = false
weight = 3
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

The Highlighter app for iOS connects to your Highlighter account through a
secure browser sign-in. You never enter your Highlighter password into the app
itself.

## How the connection works

When the iOS app asks you to sign in:

1. Highlighter opens in your device's browser and shows the usual sign-in page
   (including single sign-in with your organisation's identity provider).
2. After you sign in, Highlighter asks you to approve access for **Highlighter
   for iOS** and to choose **one account** from the accounts you are an active
   member of.
3. Select the account the app should work with and choose **Authorize**.

The approval screen lists only the accounts you currently have an active
membership in. The account you pick is the only account the app can see —
changing your default account in Highlighter later does not change what the
app can access.

## What the app can do

Once connected, the app can use Highlighter's API for the approved account —
the same `api` access that personal access tokens provide. It cannot see your
password, your other accounts, or the web sessions you use in the browser.

Access is time-limited: the app renews its own credentials automatically and
must sign in again if the connection stays unused for 30 days or reaches 90
days of age.

## Disconnecting the app

- **From the app**: use the app's sign-out or disconnect option. The app
  revokes the connection immediately.
- **If you no longer have the app**: the connection expires on its own (after
  30 days unused, and at most 90 days total). If you need it revoked sooner,
  contact your account administrator.

If you suspect the connection is being misused, disconnect it from the app and
contact support. Any access token already issued stops working within 15
minutes at the latest.
