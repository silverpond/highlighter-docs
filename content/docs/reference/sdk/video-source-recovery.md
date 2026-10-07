+++
title = "Video Source Retries and End-of-File Behaviour"
description = "Configure how a Highlighter agent's video source retries network errors and what it does when a video reaches its end, with retry_network_errors and restart_on_eof."
date = 2026-10-07T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 90
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "The video source capability decides separately whether to retry a network error and whether to start again when a video ends."
toc = true
top = false
+++

## Overview

An agent's `VideoDataSource` capability reads both live streams, such as an RTSP camera, and finite videos, such as a file. Two things can interrupt it, and they need different handling:

- **A network error** — the connection drops or a read times out. Retrying usually helps.
- **End of file** — the source has no more frames. For a live stream this means the feed stopped and should be opened again. For a finite video it means the work is finished.

From SDK version 2.6.90 these are two independent settings. Before that, one setting covered both, so a finite video fetched over HTTPS looked like a live stream: when it ended it was reopened and decoded again from the first frame, forever, and the agent never moved on to its next task.

## Settings

Both settings live in the `retries` parameter of `VideoDataSource`:

| Setting | Default | Meaning |
|---|---|---|
| `retry_network_errors` | unset | Retry when opening or reading the source fails with a network or FFmpeg error. |
| `restart_on_eof` | unset | When the source ends, open it again from the beginning and carry on. For a finite video this processes the whole video again. |
| `enabled` | unset | Older shorthand. Supplies the value for whichever of the two settings above is unset. |
| `max` | `5` | Maximum number of retries. A negative value retries forever. |
| `backoff_multiplier` | `1.0` | Multiplier for the exponential wait between retries. |
| `backoff_min` | `1.0` | Shortest wait between retries, in seconds. |
| `backoff_max` | `10.0` | Longest wait between retries, in seconds. |

A separate `VideoDataSource` parameter, `is_streaming_source`, says whether the source is live (`true`) or finite (`false`).

For example, to keep retrying a camera forever and reopen it whenever the feed ends:

```json
{
  "name": "VideoDataSource",
  "parameters": {
    "is_streaming_source": true,
    "retries": {
      "retry_network_errors": true,
      "restart_on_eof": true,
      "max": -1,
      "backoff_max": 30.0
    }
  }
}
```

## How Unset Values Are Resolved

Each of `retry_network_errors` and `restart_on_eof` is resolved on its own, in this order:

1. The value you set explicitly.
2. Otherwise, the value of `retries.enabled`, if set.
3. Otherwise, `true` for a live source and `false` for a finite one.

Whether a source is live is decided by `is_streaming_source` when you set it. When you leave it unset, a source is treated as live if its address uses a network scheme — `rtsp://`, `rtmp://`, `http://`, `https://`, `udp://`, `rtp://`, `tcp://`, `srt://`, `rist://`, `ftp://` and their variants — and as finite if it is a local file or in-memory video.

Because the address alone cannot tell a live HTTPS feed from a video file downloaded over HTTPS, set `is_streaming_source` to `false` when you point a video source at a finite file by URL. Videos that Highlighter hands to an agent from uploaded data files are already marked finite.

## What Happens in Each Case

| Event | Live source | Finite source |
|---|---|---|
| Network error while reading a frame, `retry_network_errors` on | The source is reopened, then the read is retried | The read is retried on the open video; the video is not reopened at the first frame |
| Network error, `retry_network_errors` off | The error stops the source | The error stops the source |
| End of file, `restart_on_eof` on | A new session is opened | The video is processed again from the first frame |
| End of file, `restart_on_eof` off | The source completes | The source completes |

Reaching the end of a frame selection you asked for is always completion. It is never treated as end of file, so `restart_on_eof` does not repeat it.

## Existing Configurations

Agent definitions that set only `retries.enabled` keep working: `enabled: true` still turns both behaviours on, and `enabled: false` turns both off. An explicit `retry_network_errors` or `restart_on_eof` always wins over `enabled`.

The one change to watch for is a definition that sets nothing and reads a finite video over a network address. Set `is_streaming_source: false`, or `restart_on_eof: false`, to make it complete at the end of the video.
