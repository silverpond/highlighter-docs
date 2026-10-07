+++
title = "Inspecting Agent Definitions"
description = "View an agent definition's graph and capability parameters in the terminal, and edit global and per-stream values, with hl agent show."
date = 2026-10-07T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 80
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Use hl agent show to see how the capabilities in a local agent definition are connected and which value each parameter will actually take for each stream."
toc = true
top = false
+++

## Overview

`hl agent show` opens a local agent definition in an interactive terminal screen. It draws the agent's graph, lists every capability with its parameters, and shows where each value comes from. You can also edit values and save them back to the JSON files.

It reads only the JSON you give it. It does not start the agent, contact Highlighter, or need credentials. It is available from SDK version 2.6.90.

## Opening a Definition

```bash
# View an agent definition on its own
hl agent show agent.json

# View it together with the streams it will run
hl agent show agent.json -s tasks.json
```

The agent definition must be a `.json` file.

`-s` / `--stream-definitions-file` names a task JSON file: a JSON list with one object per stream. With it, the screen shows one column of values per stream, headed by the stream's `stream_name` and its position in the file (such as `front-gate:0`), so you can compare streams side by side. To show only some of the streams, add a selection in square brackets:

```bash
hl agent show agent.json -s "tasks.json[0,2]"         # by position, counting from 0
hl agent show agent.json -s "tasks.json[front-gate]"  # by stream_name
```

Quote the argument so your shell does not interpret the brackets.

When the agent's graph has more than one subgraph, a stream is matched to a capability by its `subgraph_name`. A selected stream whose `subgraph_name` is missing or unknown is ignored, with a warning.

## Reading the Screen

The screen opens on the **capabilities** view: the graph at the top, then an outline of the capabilities and a table of the selected capability's parameters.

A parameter can be set in several places. The table shows the value that wins for each stream, in this order:

1. The stream's own capability-qualified key, such as `"Detector.confidence": 0.4` in the task JSON.
2. The capability's `parameters` in the agent definition.
3. An unqualified key on the stream, such as `"confidence": 0.4`.
4. The agent definition's top-level `parameters`.

A parameter that is set in none of these shows `—`. The value under the cursor, and the full location in the JSON it came from, appear below the table.

## Keys

| Key | Action |
|---|---|
| `Tab` | Switch between the capability outline and the parameter rows |
| `j` / `k` or `↓` / `↑` | Move to the next or previous capability or parameter |
| `h` / `l` or `←` / `→` | Choose the stream whose value is active |
| `Enter` | Edit the selected value |
| `a` | Open the agent's top-level parameters |
| `g` | Open the read-only graph view |
| `c` | Collapse or expand the graph above the table |
| `p` | Show or hide each node's parameters in the graph |
| `?` | Help |
| `q` or `Esc` | Go back to the capabilities view; from there, quit |

## Editing Values

Press `Enter` on a parameter. When streams are loaded you are asked for the edit target:

- `g` — **global**. Sets the value in the capability's `parameters` in the agent definition, and removes any override of that parameter from every stream, so all streams take the new value.
- `s` — **stream**. Sets a capability-qualified override (`"<Capability>.<parameter>"`) on the selected stream only.

The bottom line then shows the current value. Delete it with `Backspace`, type the new value as JSON — `0.4`, `true`, `"text"`, `[1, 2]`, `null` — and press `Enter` to accept or `Esc` to cancel. Invalid JSON is rejected with a message and nothing changes. Without streams loaded, an edit is always global.

Edits in the agent parameters view (`a`) set the agent definition's top-level `parameters`.

## Saving

Nothing is written while you edit. The bottom line shows `unchanged` or `MODIFIED - press q to exit`. When you quit with unsaved edits you are asked `Save changes? [y/N]`:

- `y` writes the agent definition, and the task JSON file if you gave one. Each file is replaced in one step, so an interrupted save cannot leave a half-written file.
- Any other key quits without saving.

After the screen closes, the command prints `Changes saved.`, `No changes saved.`, or a note that your changes were not saved.
