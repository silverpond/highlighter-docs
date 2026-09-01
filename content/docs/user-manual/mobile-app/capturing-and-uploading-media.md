+++
title = "Capturing and uploading media"
description = "Three ways to get photos and video from an iPhone into Highlighter — attaching media to a case, picking photos by hand, and Media Sync watching the library."
date = 2026-09-01T08:00:00+00:00
updated = 2026-09-01T08:00:00+00:00
draft = false
weight = 4
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Getting imagery off the phone and into Highlighter — attached to a case, picked by hand, or synced automatically from the library."
toc = true
top = false
+++

The mobile app has three routes for imagery, for three different jobs.

| Route | Use it when | Where it lives |
| --- | --- | --- |
| **Add Data** | You want a photo or video attached to a specific case | The **+** button in the tab bar |
| **Upload Photos** | You want to send a handful of photos from the library | **Profile → Media** |
| **Media Sync** | You want everything this phone captures to arrive by itself | **Profile → Media** |

**Upload Photos** and **Media Sync** both read the same iOS photo library, so
only one of them is active at a time. The app presents them as a choice, and
switching between them does not interfere with uploads already in flight.

## Add Data — attaching media to a case

Tap the **+** in the middle of the tab bar.

1. **Related Case** — pick the case this belongs to. The picker searches your
   cases, and can create a new one.
2. **Add Media** — choose **Photo** or **Video**.
   - *Photo* lets you **Take Photo** with the camera or **Choose from Library**.
   - *Video* picks an existing video from the library.
3. Tap **Save Data**.

**Save Data** stays disabled until there is both a case and something to upload.
Media you attach but never save is discarded when you close the sheet.

## Upload Photos — picking by hand

**Profile → Media → Upload Photos** opens a screen for sending specific photos.

Tap **Choose Photos** and pick what you want. Highlighter only sees the photos
you pick — nothing else on the device is read, and no library-wide permission is
requested.

The picked photos are copied by Highlighter onto the device first, then queued
for upload. They are held on the device until they have been uploaded, so it is
safe to leave the screen or close the app. Anything that fails shows in the
queue with a **Try Again** button.

If you find yourself picking the same photos every evening, the screen offers
**Set Up Media Sync** as the standing alternative.

## Media Sync — watching the library

**Profile → Media → Turn on Media Sync** hands the whole photo library over, so
new inspection imagery reaches Highlighter without anyone choosing it.

### Setting it up

Media Sync needs **full** photo library access. iOS's *Selected Photos* option
looks like it is working and then never finds anything, because newly
transferred imagery is not in the selection — the app warns you when it detects
this and offers **Open Settings** to fix it.

Setup is a single commitment: tap **Start Media Sync**. There is nothing to
configure, because where each photo goes is decided by the camera serial number
in the photo itself.

Photos already on the device when you set it up are left alone; only new imagery
is synced.

### What you see afterwards

The Media Sync screen shows the running state:

- **Matched by camera serial** — how imagery is being routed, with a per-camera
  breakdown of what has uploaded and what is still to go. **Change** redirects a
  camera to a different data source.
- **Progress** — how many files have uploaded, how many are queued, and how much
  is safely stored on the device. Uploads continue when connectivity allows.
- **Needs review** — imagery that might not be inspection material, held rather
  than imported on its own. **Import** or **Dismiss** each one.
- **Needs a destination** — photos whose metadata carries no camera serial
  number, which is most phone imagery. You choose a destination **once**, and it
  stands for every serial-less photo after it. The same standing choice is used
  by Upload Photos, and changing it in either place changes it in both.
- **Problems** — anything that failed, with **Try Again**.
- **Check Again** — rescan now.

### Settings

- **Sync photos automatically** — the master switch. Turned off, the app still
  records what a scan finds but copies and uploads none of it. Photos you picked
  by hand are outside this switch and upload regardless.
- **Upload on Wi-Fi only** — imagery is still copied and queued on cellular, but
  held back from uploading until the phone is on Wi-Fi. Inspection frames run
  10–50 MB each and a field day is measured in gigabytes, so this matters on a
  metered plan.
- **Rescan whole library** — send anything this device has not uploaded yet.

## Choosing a data source

Both Upload Photos and Media Sync ask where imagery should go when they cannot
work it out. The **Choose Data Source** sheet lists the data sources on your
account — cameras appear by serial number — and can **Create Data Source** for a
new one named on the spot.

## Turning Media Sync off

Selecting **Upload Photos** while Media Sync is set up and collecting asks you
to confirm first. Media Sync stops watching the library, anything already
uploading finishes, and you can turn it back on from the same screen at any
time.
