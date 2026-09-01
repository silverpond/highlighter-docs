+++
title = "Getting started on mobile"
description = "Install the Highlighter iOS app, sign in to your Highlighter account, and register your iPhone or iPad as a Highlighter device."
date = 2026-09-01T08:00:00+00:00
updated = 2026-09-01T08:00:00+00:00
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

The screen also states, under the buttons, that continuing means agreeing to the
Terms of Service and Privacy Policy. Both documents can be read inside the app.

## Signing in

Tap **Login**, then **Continue to Sign In**. The app opens Highlighter's own web
sign-in page.

When sign-in succeeds the browser window closes and the app takes you on to the
main screens. Your session is remembered on the device, so on later launches you
go straight to the Dashboard without signing in again.

If sign-in fails, the app shows a **Login Failed** message with the reason.
Dismissing the browser window without signing in is not an error — you are
simply returned to the previous screen.

## Registering this device

Highlighter treats a phone as a **device**: a named source of data attached to
your account. Registering the phone creates that record on the server, and it is
what gives the photos and video you capture somewhere to be filed.

On the **Register Device** screen:

1. Give the device a **name** — something a colleague would recognise, such as
   "John's iPhone 15 Pro".
2. The **device type** is fixed at *Mobile Camera*. This is the phone itself, so
   there is nothing to choose.
3. Tap **Register Device**.

You have to be signed in to register, because the device is registered to your
account. If you are not, the screen says so and offers a **Sign In** button that
returns you here afterwards.

When registration succeeds the app confirms it and shows the **device name** and
the **device ID** the server assigned. Tap **Continue** to go on to the
Dashboard.

### If registration is refused

Creating a device requires a Highlighter role permission that the Contributor
role does not carry. If you see *"Your Highlighter role can't register
devices"*, ask an account owner or manager to register the device for you, or to
change your role.

### If you have already chosen where your photos go

If you have already picked a destination by hand for photos from this phone (see
[Capturing and uploading media](../capturing-and-uploading-media/)), registering
the device changes where the *next* photos go. The app warns you before it does:

- Photos already uploaded stay where they are.
- New photos from this phone go to a data source for each of its cameras
  instead.
- Photos from anything else that cannot identify itself keep going to the
  destination you chose.

You do not need to register the phone again on later launches. The registration
lives on the server, and the app recovers it when you sign in.

## Registering more than one device

You can register additional devices later from the **Profile** tab — see
[Profile and device settings](../profile-and-device-settings/).
