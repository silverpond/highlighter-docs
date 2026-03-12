+++
title = "Getting Started"
description = "How to get started with the Highlighter Python SDK"
date = 2025-02-27T08:00:00+00:00
updated = 2025-12-17T08:00:00+00:00
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
pip install highlighter-sdk
```


### Windows

```
python -m venv venv
venv\Scripts\activate.bat
venv\Scripts\python.exe -m pip install -U pip
venv\Scripts\python.exe -m pip install highlighter-sdk
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

The CLI supports headless management of many system resources, allowing you to list and delete entities like Cases, Experiments, and Workflows directly from the terminal. See [CLI Resource Management](../cli-resource-management/) for details.

Below is how to download an data-file using the cli.

**Note: on Windows replace `/` with `\`**
```
# Replace 12345 with a DataFile ID from your Highlighter account
# -o will save the resulting DataFile to your cwd
hl data-file read -i 12345 -o .
```

### Network Discovery and Data Sources

The Highlighter SDK includes powerful tools for discovering devices on your network and managing data sources:

- **Network Discovery**: Use `hl datasource discover` to find cameras and devices via mDNS/Bonjour
  - Discover all cameras on your network: `hl datasource discover list`
  - Find a camera by MAC address: `hl datasource discover find --mac XX:XX:XX:XX:XX:XX`
  - Batch lookup multiple devices: `hl datasource discover batch --file macs.txt`

- **Data Source Management**: Use `hl datasource` to create, update, and manage data sources in Highlighter Cloud
  - List data sources: `hl datasource list`
  - Create a data source: `hl datasource create --name "Camera-1" --source-uri "rtsp://..."`
  - Import/export data sources: `hl datasource import --file cameras.json --create-missing`

For detailed information, see:
- [Network Device Discovery](../network-discovery/)
- [Data Source Management CLI](../data-source-cli/)

## Using the Python API

See [Download And Write Datasets](../download-and-writer-datasets-locally/)

## What's next

See [Scaffolding new Highlighter agents](../highlighter-scaffolds/)


