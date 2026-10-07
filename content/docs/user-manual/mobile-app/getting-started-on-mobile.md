+++
title = "Getting started on mobile"
description = "Install the Highlighter iOS app, sign in to your Highlighter account, and register your iPhone or iPad as a Highlighter device."
date = 2026-09-01T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 1
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Sign in to your Highlighter account from your phone and register the phone as a device, so the imagery it captures has somewhere to land."
toc = true
top = false
+++

The Highlighter iOS app runs on iPhone and iPad.

The app does not have an account system of its own. It signs in to the same
Highlighter account you use in the browser, and everything it shows you comes
from that account.

## First launch

Opening the app for the first time shows the **Welcome** screen. Tap **Login**
to sign in to your Highlighter account.

Under the button the screen says where you are about to sign in — *Signing in at*
followed by the address of the Highlighter the app is pointed at — and that
continuing means agreeing to the **Terms of Service** and **Privacy Policy**. Tap
either name to read it inside the app.

### Choosing which Highlighter to sign in at

Most people never need this. If you have been told to use a different
Highlighter, tap the gear in the top corner of the Welcome screen. The **Server**
screen lists the ones this version of the app knows about — **Staging** and
**Production** — with a tick beside the current one. Tap the one you were told to
use, then **Done**.

Changing it signs you out and clears the cases, messages and queued imagery the
app was holding, because they belong to the Highlighter they came from.

The screen does not ask which account to use. You choose that while signing in,
from the accounts you belong to.

## Signing in

Tap **Login**, then **Continue to Sign In**. The app opens Highlighter's own web
sign-in page.

When sign-in succeeds the browser window closes and the app takes you to the
Dashboard. Your session is remembered on the device, so on later launches you go
straight to the Dashboard without signing in again. Opening the app with no
signal does not sign you out: the app keeps your session and tries again when it
next comes to the front.

If sign-in fails, the app shows a **Login Failed** message with the reason.
Dismissing the browser window without signing in is not an error — you are
simply returned to the previous screen.

## Registering this device

Highlighter treats a phone as a **device**: a named source of data attached to
your account. Registering the phone creates that record on the server, and it is
what gives the photos and video you capture somewhere to be filed.

Registering is not part of signing in. Do it from the **Profile** tab: under
**Registered Devices**, tap **Add Device**. Tapping your avatar on the Dashboard
also shows whether this device is registered, with a **Register Device** button
that takes you to the Profile tab.

On the **Register Device** screen:

1. Give the device a **name** — something a colleague would recognise, such as
   "John's iPhone 15 Pro".
2. The **device type** is fixed at *Mobile Camera*. This is the phone itself, so
   there is nothing to choose.
3. Tap **Register Device**.

When registration succeeds the screen closes and the device appears under
**Registered Devices** with its name and the ID the server assigned, marked
**In Use**. If it fails, a **Registration Failed** message gives the reason.

### If registration is refused

Creating a device requires a Highlighter role permission that the Contributor
role does not carry. If you see *"Your Highlighter role can't register
devices"*, ask an account owner or manager to register the device for you, or to
change your role.

### If you have already chosen where your photos go

If you have already picked a destination by hand for photos from this phone (see
[Capturing and uploading media](../capturing-and-uploading-media/)), registering
the device changes where the *next* photos go. The app asks *Change where this
iPhone's photos go?* before it does, and explains:

- Photos already uploaded stay where they are.
- New photos from this phone go to a data source for each of its cameras
  instead.
- Photos from anything else that cannot identify itself keep going to the
  destination you chose.

You do not need to register the phone again on later launches. The registration
lives on the server, and the app recovers it when you sign in.

## Registering more than one device

**Add Device** on the Profile tab registers additional devices — see
[Profile and device settings](../profile-and-device-settings/).
