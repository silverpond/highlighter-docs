+++
title = "Profile and device settings"
description = "Your account details, registered devices, media route, location readout and sign-out in the Highlighter mobile app."
date = 2026-09-01T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 6
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Everything about this phone and the account it is signed in to, on one screen."
toc = true
top = false
+++

The **Profile** tab holds your account details, which Highlighter the app is
talking to, the devices you have registered,
how imagery gets off this phone, what the app knows about its location, and
sign-out.

## Account details

- **Email** — the address on your Highlighter account, read-only. It comes from
  your signed-in session, and there is no way to change it from the app.
- **Password** — shown as *Reset on the web*. Tapping it opens Highlighter's own
  password reset page. Because sign-in happens on the web, the app has no
  password to show and none to change.

## Environment

A read-only pair of lines that say where your data is going, which is worth
quoting when you report a problem:

- The name and address of the Highlighter the app is signed in at.
- The app's version and build number.

To sign in at a different Highlighter, sign out and use the gear on the Welcome
screen — see [Getting started on mobile](../getting-started-on-mobile/).

## Registered devices

The devices registered to your account from this app, each with its name and
device ID, with the one currently in use marked **In Use**. Tap a row to make it the current device.

**Add Device** registers another one — the same form described in
[Getting started on mobile](../getting-started-on-mobile/).

A phone that has not been registered reads *"You have not registered a device"*.
Registration lives on the server, so signing in on a phone that has been
registered before recovers it without you doing anything.

## Media

Chooses how photographs reach Highlighter — **Upload Photos** (pick them by
hand) or **Media Sync** (hand over the library). They read the same photo
library, so only one is used at a time. See
[Capturing and uploading media](../capturing-and-uploading-media/).

## Location

A readout of the phone's most recent GPS fix and when it was last sent to
Highlighter, with the controls to grant or fix location access. See
[Map and locations](../map-and-locations/).

## Sign out

**Sign Out** ends the session on this phone. You are asked to confirm, because
you will need to sign in again to see your cases.

Signing out also clears the cases and messages the app was holding, any imagery
still queued to upload, this phone's device registration and its reported
position, so nothing of yours carries into the next person's session. The device itself still exists on the server — it belongs
to the account, not to the app — but nothing about it survives into the next
session on the phone.

## Legal documents

The Terms of Service and Privacy Policy are readable inside the app from the
links at the bottom of the Welcome screen.
