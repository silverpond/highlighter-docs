+++
title = "Uploading photos on Android"
description = "Get inspection photos from an Android phone or tablet into Highlighter — pick them by hand with Upload Photos, or let Media Sync find and upload new imagery automatically."
date = 2026-10-07T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 13
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Two ways to get the photos on the device into Highlighter: pick them yourself, or have the app watch the photo library and send new imagery on its own."
toc = true
top = false
+++

The **Media** section of the **Profile** tab chooses how photographs reach
Highlighter.

| Route | Use it when |
| --- | --- |
| **Upload Photos** | You want to send particular photos |
| **Media Sync** | You want new inspection imagery on this device to arrive by itself |

Both read the same photo library, so only one is used at a time. Switching
between them does not interrupt uploads already in progress.

On Android the app uploads photos. It cannot yet attach a file to a particular
case, record video, or receive images shared from another app.

## Where a photo goes

Every photo is matched to a **data source** by the serial number of the camera
that took it, read from the photo itself. A camera Highlighter has not seen
before gets a new data source.

Photos with no camera serial number in them — which is most phone and tablet
photos, until the [device is registered](../getting-started-on-android/#registering-this-device)
— cannot be matched. The app asks you where they should go **once**, and uses
that answer for every such photo afterwards. See
[Choosing a data source](#choosing-a-data-source).

## Upload Photos — picking by hand

**Profile → Media → Upload Photos**, then **Choose Photos**, and pick what you
want. Highlighter only sees the photos you pick; nothing else on the device is
read.

Before the first pick, Android asks for photo access. This is so the photos you
pick keep their location — without it, Android removes the GPS position from
them. Choosing **Allow limited access** with nothing selected is enough. If you
refuse, the photos still upload, without a position.

After a pick the screen reports how many were added, how many were already in
Highlighter, and how many could not be read. Then:

- **Needs a data source** — photos with no camera serial number, waiting for you
  to choose where they go.
- **Where these go** — the destination currently used for photos with no camera
  serial number, with **Change**.
- **Your uploads** — what you have picked and how far each has got. Highlighter
  holds these on the device until they are uploaded, so it is safe to leave the
  screen or close the app.

If you find yourself picking the same photos every day, **Set Up Media Sync** at
the bottom of the screen is the standing alternative.

## Media Sync — watching the library

**Profile → Media → Turn on Media Sync** has the app find inspection imagery in
the device's photo library on its own.

### Setting it up

Media Sync needs access to **all** photos. It only reads them; it never changes
or deletes them.

- If access has not been given, the screen shows *Photo access needed* with
  **Allow Photo Access**, or **Open Settings** if it was refused earlier.
- If you chose **Allow limited access**, the screen warns *Selected photos only*:
  the app can see only the photos you picked, so it will not find new imagery by
  itself. Tap **Change Access** and allow all photos.

Then tap **Start Media Sync**. There is nothing else to configure.

Photos already on the device when you set it up are left alone; only new imagery
is synced.

### What you see afterwards

- **Status** — *Matched by camera serial*, how many photos have uploaded and how
  many are queued, and how much is safely stored on the device. Uploads continue
  whenever there is a connection. Below that, each camera's data source with what
  has uploaded and what is still to go; **Change** points a camera's imagery at
  a different data source.
- **Check Again** — look for new photos now.
- **Needs review** — imagery that might not be inspection material, held rather
  than imported on its own. **Import** or **Dismiss** each one.
- **Needs a data source** — photos with no camera serial number, waiting for a
  destination.
- **Needs attention** — anything that failed, with **Try Again**.
- **Can't find your photos?** — a reminder to transfer the photos from the
  camera to this device first, because no app can see photos left on a memory
  card.

### Settings

- **Sync photos automatically** — find, copy and upload new imagery without
  being asked.
- **Upload on Wi-Fi only** — imagery is still copied and queued on mobile data,
  but held back from uploading until the device is on Wi-Fi. Turning it off
  releases what was waiting.
- **Rescan whole library** — send anything this device has not uploaded yet,
  including photos that were on it before Media Sync was set up.

## Choosing a data source

The **Choose Data Source** sheet lists the data sources on your account —
cameras appear as *Camera* followed by their serial number. Tap one, or type a
name under **Or create a new one** and tap **Create Data Source**.

The choice is shared: it is used by both Upload Photos and Media Sync, and
changing it in one changes it in the other.

## Turning Media Sync off

Selecting **Upload Photos** while Media Sync is on asks *Turn off Media Sync?*
Choosing **Turn Off and Pick Photos** stops the app watching the library.
Anything already uploading finishes, and you can turn Media Sync back on from
the same place at any time.
