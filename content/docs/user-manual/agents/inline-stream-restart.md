+++
title = "Inline Stream Restart"
description = "Configure automatic restart of failed inline Aiko streams with capped exponential backoff."
date = 2026-08-05T08:00:00+00:00
updated = 2026-08-05T08:00:00+00:00
draft = false
weight = 110
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Automatic recovery for failed inline streams"
toc = true
top = false
+++

When an agent processes inline inputs (files, URLs, or stream definitions)
through an Aiko pipeline, a Capability may return `StreamEvent.ERROR`,
causing the stream to terminate. **Inline stream restart** is an opt-in
feature that automatically tears down and recreates only the failed stream,
leaving all other streams running without interruption.

## What it applies to

Inline stream restart applies **only** to inline streams created by
`HLAgent.run_inline_inputs` (i.e. when you pass `--files`, `--urls`, or
`stream_definitions` to `hl agent start` or `Runtime.run`).

It does **not** retry durable Highlighter Tasks. Failed Tasks are recorded
as `FAILED` once; retrying failed work is modelled by creating a new retry
Task linked to the original.

## Enabling restart globally

Restart is **disabled by default**. Enable it via environment variables:

```bash
export HL_AGENT_INLINE_STREAM_RESTART_ENABLED=true
# Optional: tune the backoff (defaults shown)
export HL_AGENT_INLINE_STREAM_RESTART_INITIAL_BACKOFF_SECS=1.0
export HL_AGENT_INLINE_STREAM_RESTART_MAX_BACKOFF_SECS=30.0
```

Or via the `Runtime.run` API:

```python
from highlighter.core.config import InlineStreamRestartPolicy

runtime.run(
    stream_definitions=[...],
    inline_stream_restart=InlineStreamRestartPolicy(
        enabled=True,
        initial_backoff_secs=1.0,
        max_backoff_secs=30.0,
    ),
)
```

## Per-stream overrides

Individual stream definitions can partially override the global policy.
Fields not specified fall back to the effective global or `Runtime.run`
policy.

```json
{
  "subgraph_name": "CameraOne",
  "data_sources": "(rtsp://camera/one)",
  "inline_stream_restart": {
    "enabled": true,
    "max_backoff_secs": 60.0
  }
}
```

Precedence (highest first):

1. Per-stream `inline_stream_restart` fields
2. `Runtime.run` policy (when supplied)
3. `HighlighterRuntimeConfig.agent.inline_stream_restart`

The `inline_stream_restart` and `subgraph_name` keys are stripped from the
stream definition before it reaches Aiko Capability parameter resolution.

## Restart behaviour

- Only streams terminating in `StreamState.ERROR` are restarted.
- Normal completion (`StreamState.STOP`) is never restarted.
- The failed stream is fully torn down (Capabilities, recorders, data
  schemes, per-stream caches) before its ID is reused.
- The recreated stream retains the same stream ID, graph path, Capability
  parameters, response queue, and shared `TaskContext`.
- Frame numbering resets to zero on each restart.
- Restarting one stream does not pause, recreate, or otherwise affect any
  other stream.

### Replay semantics

The original input is reopened rather than resumed from a checkpoint:

- **Files and finite URLs** start again from the beginning and may repeat
  outputs.
- **Live URLs** reconnect to their current live position.
- **In-memory or one-shot sources** that cannot be replayed should disable
  restart.

### Response queue

Existing `ERROR` messages and diagnostics on the response queue are
preserved. A later response with the same stream ID belongs to the
restarted attempt.

## Backoff

When enabled, a failed stream retries indefinitely using capped exponential
backoff:

```
delay = min(initial_backoff_secs * 2 ** (consecutive_failures - 1), max_backoff_secs)
```

The failure counter resets to zero once the restarted stream completes a
frame in `StreamState.RUN`. An error during stream creation (before the
first successful frame) continues increasing the backoff.

Restarts are cancelled if shutdown or cancellation begins (e.g. SIGTERM,
`Runtime.shutdown`, or `HLAgent.accepting_tasks` becoming false).
