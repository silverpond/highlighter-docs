+++
title = "Set Recording Retention"
description = "Choose how long a Highlighter appliance keeps its camera recordings before deleting them."
date = 2026-09-11T08:00:00+00:00
updated = 2026-09-11T08:00:00+00:00
draft = false
weight = 20
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

## Overview

An appliance records each of its cameras continuously to local disk. Recordings
are written as fragmented MP4 segments and deleted automatically once they are
older than the configured retention, so the disk holds a moving window rather
than growing without limit.

Retention is **14 days** unless you set it. You can change that default for the
whole appliance, and override it for an individual camera.

## Change the default retention

Set `services.videoStore.recordDeleteAfter` in the appliance's host module:

```nix
services.videoStore.recordDeleteAfter = "30d";
```

The value is a duration string — for example `30m`, `7d`, or `30d`. It is passed
through to the media server, which applies it to every camera that does not set
its own.

## Override retention for one camera

Each camera may carry its own `recordDeleteAfter`. A camera that sets one keeps
its recordings for that long; a camera that leaves it unset falls back to the
appliance default above.

```nix
services.videoStore.recordDeleteAfter = "30d";

services.videoStore.cameras = [
  {
    name = "front-gate";
    source = "rtsp://admin:__CAMERA_PASSWORD__@192.168.1.10:554/stream";
  }
  {
    name = "loading-dock";
    source = "rtsp://admin:__CAMERA_PASSWORD__@192.168.1.11:554/stream";
    recordDeleteAfter = "7d";   # keep less of this camera
  }
];
```

Here `front-gate` keeps 30 days and `loading-dock` keeps 7.

To stop recording a camera altogether while still streaming it, set
`record = false` on that camera. Retention then has nothing to act on for it.

## Where the recordings are kept

Recordings are written under `services.videoStore.storagePath`, which defaults
to `/var/lib/videostore`, in a directory per camera named after the camera's
`name`, with one file per segment named for the time the segment started.

Retention only governs how long those files survive on the appliance. Anything
already uploaded to Highlighter Cloud is unaffected by it.

## Apply the change

Retention is part of the appliance's configuration, so it takes effect when you
deploy that configuration:

```bash
nix-build default.nix
./result switch
```

`switch` activates the new configuration immediately and makes it the boot
default. The media server restarts as part of the switch, which briefly
interrupts recording; the recordings already on disk are kept.

## Choosing a value

Disk usage grows with retention, camera count, resolution, and frame rate — a
longer window on many cameras can fill the appliance's disk. Raise retention in
steps and check free space on the appliance after each change, rather than
jumping to a long window on a full set of cameras.
