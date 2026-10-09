+++
title = "Getting started on Android"
description = "Install the Highlighter Android app, sign in to your Highlighter account, and register your phone or tablet as a Highlighter device."
date = 2026-10-07T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 11
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Sign in to your Highlighter account from an Android phone or tablet and register it as a device, so the photos it sends have somewhere to land."
toc = true
top = false
+++

The Highlighter Android app runs on phones and tablets with **Android 11 or
later**.

The app does not have an account system of its own. It signs in to the same
Highlighter account you use in the browser, and everything it shows you comes
from that account.

**Note:**
The Android app is in a field trial. It is not in Google Play; builds are sent
to trial participants directly. It does not yet do everything the web app does —
each page says what is missing.

## First launch

Opening the app shows the **Welcome** screen. Tap **Login** to sign in to your
Highlighter account.

Under the button the screen says where you are about to sign in — *Signing in at*
followed by the name of the Highlighter the app is pointed at — and that
continuing means agreeing to the **Terms of Service** and **Privacy Policy**. Tap
either name to read it inside the app.

### Choosing which Highlighter to sign in at

Most people never need this. If you have been told to use a different
Highlighter, tap the cog in the corner of the Welcome screen. The **Server**
screen lists the ones this version of the app knows about — **Staging** and
**Production**. Tap the one you were told to use, then **Close**.

Changing it signs you out, and clears the photos the app was still holding to
upload, because they belong to the Highlighter they were queued for.

## Signing in

Tap **Login**. The app opens Highlighter's own web sign-in page in a browser
tab. You type your email and password there, not into the app, so multi-factor
authentication and single sign-on work as they do on the web.

When sign-in succeeds the browser tab closes and the app takes you to the
Dashboard. Your session is remembered on the device, so on later launches you go
straight to the Dashboard.

If sign-in fails, the reason is shown on the Welcome screen. If the device has
no browser the app can use, it says *"No browser is available to sign in with.
Install or enable one, then try again."*

## Getting around

The bar at the bottom has three tabs:

| Tab | What it is |
| --- | --- |
| **Dashboard** | Case counts, recent messages, and recent cases |
| **Cases** | The full list of your cases, searchable and filterable |
| **Profile** | The server you are signed in at, this device, how photos reach Highlighter, sign out |

Each tab keeps its place while you visit another.

## Registering this device

Highlighter treats a phone or tablet as a **device**: a named source of data
attached to your account. Registering it creates that record on the server and
gives the photos from its own cameras a data source each.

1. Open the **Profile** tab. Under **This device**, tap **Register this
   device**.
2. Give the device a **name** a colleague would recognise.
3. The **device type** is fixed at *Mobile Camera*.
4. Tap **Register Device**.

When registration succeeds you are returned to the Profile tab, where **This
device** now shows the device's name and the ID the server assigned.

You do not need to register again on later launches. The registration lives on
the server, and the app asks for it back when it starts and when you sign in.

### If registration is refused

Creating a device requires a Highlighter role permission that the Contributor
role does not carry. If you see *"Your Highlighter role can't register
devices"*, ask an account owner or manager to register the device for you, or to
change your role. Any other failure shows a **Registration Failed** message with
the reason.

### If you have already chosen where your photos go

If you have already picked a destination by hand for photos from this device
(see [Uploading photos on Android](../uploading-photos-on-android/)), registering
it changes where the *next* photos go. The app asks *Change where this device's
photos go?* first, and explains:

- Photos already uploaded stay where they are.
- New photos from this device go to a data source for each of its cameras
  instead.
- Photos from anything else that cannot identify itself keep going to the
  destination you chose.

## Signing out

Tap **Sign out** at the bottom of the **Profile** tab. It takes effect straight
away, without asking you to confirm.

Signing out also discards any photos still waiting to upload and the copies the
app was holding of them, so one person's photos can never be uploaded under the
next person's account. Photos that had already finished uploading are
unaffected.
