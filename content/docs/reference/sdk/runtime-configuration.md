+++
title = "Runtime Configuration File"
description = "Choose which Highlighter runtime configuration file the SDK and hl CLI load, with --highlighter-config-path or HL_CONFIG_PATH, and check it with hl config show."
date = 2026-10-14T00:00:00+00:00
updated = 2026-10-14T00:00:00+00:00
draft = false
weight = 85
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "The runtime configuration file holds settings for running agents on this machine, such as thread counts for ONNX Runtime and video decoding. Use it to tune a machine without changing an agent definition."
toc = true
top = false
+++

## Overview

The runtime configuration is a TOML file, separate from your credentials and profiles (see [Highlighter SDK Credentials](../highlighter-credentials/)). Every `hl` command and agent started with `hl agent start` loads it once, when it starts.

A section and its settings look like this:

```toml
[onnxruntime]
intra_op_num_threads = 1

[video_io]
pyav_stream_thread_count = 1
```

Both settings default to `0`, which lets ONNX Runtime and FFmpeg pick their own thread counts.

## Choosing the File

The SDK uses the first of these that is set:

1. The `--highlighter-config-path` option. It belongs to `hl` itself, so it goes before the command name, e.g. `hl --highlighter-config-path /etc/highlighter/config agent start …`.
2. The `HL_CONFIG_PATH` environment variable. An empty value counts as unset.
3. `~/.highlighter/config`. If `HL_DIR` is set, the file is `config` in that directory instead.

A leading `~` in either path is expanded.

`HL_CONFIG_PATH` is useful for services that start agents, such as a systemd unit, where adding an option to every command is awkward:

```bash
export HL_CONFIG_PATH=/etc/highlighter/config
hl agent start …
```

From SDK version 2.6.94, `hl agent start` and every other command honour `HL_CONFIG_PATH`. Earlier versions ignored it and loaded `~/.highlighter/config`.

## When the File Is Missing

- **The default file**: it is created with default values, and the command carries on.
- **A file named by `--highlighter-config-path` or `HL_CONFIG_PATH`**: the command stops with exit code 2 instead of falling back to the defaults:

  ```text
  Failed to load configuration: Config file not found at /etc/highlighter/config. Specify a valid file with --highlighter-config-path or HL_CONFIG_PATH, or unset HL_CONFIG_PATH and omit --highlighter-config-path to use defaults.
  ```

A file that does not parse, or holds an invalid value such as a negative thread count, also stops the command with exit code 2 and says what is wrong.

## Checking Which File Is Loaded

`hl config show` prints the configuration in effect, as TOML. Its `config_path` line names the file that was loaded:

```bash
hl --color-off config show
```

Run it in the same environment as the agent, for example as the service's user with the service's environment variables, to confirm the agent will pick up the file you expect.

Use `--filter` to print one section, or one setting by its dotted path:

```bash
hl config show --filter onnxruntime
hl config show --filter video_io.pyav_stream_thread_count
```

Some settings can also be set with environment variables, which take precedence over the file. `hl config show` reflects them.
