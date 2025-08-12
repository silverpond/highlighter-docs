+++
title = "Getting Started"
description = "How to get started with the Highlighter Python SDK"
date = 2025-02-27T08:00:00+00:00
updated = 2025-02-27T08:00:00+00:00
draft = false
weight = 0
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "How to get started with the Highlighter Python SDK"
toc = true
top = false
+++

This guide will help you install and configure the Highlighter Python SDK


## Steps

  - [Install the Highlighter SDK](#install-the-highlighter-sdk)
  - [Setup Highlighter API Credentials](#setup-highlighter-api-credentials)
  - [Using the CLI](#using-the-cli)
  - [Using the Python API](#using-the-python-api)


## Install the Highlighter SDK

### Linux|Mac

```
python -m venv venv
source venv/bin/activate
pip install -U pip
pip install -e .
```


### Windows

```
python -m venv venv
venv\Scripts\activate.bat
venv\Scripts\python.exe -m pip install -U pip
venv\Scripts\python.exe -m pip install -e .
```

### NixOS

```
nix-shell
# Then follow the normal Linux setup
```


## Setup Highlighter API Credentials

See [Highlighter API Credentials](../highlighter-credentials/)

## Using the CLI

Use `hl --help` to list the individual commands. Use `hl COMMAND --help`
for help on specific commands. Some commands are nested so,
`hl COMMAND SUB_COMMAND --help` may be required.

Below is how to download an data-file using the cli.

**Note: on Windows replace `/` with `\`**
```
# Replace 12345 with a DataFile ID from your Highlighter account
# -o will save the resulting DataFile to your cwd
hl data-file read -i 12345 -o .
```

## Using the Python API

See [Download And Write Datasets](../download-and-writer-datasets-locally/)

## What's next

See [Scaffolding new Highlighter agents](../highlighter-scaffolds/)


