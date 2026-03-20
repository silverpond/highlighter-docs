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

{% code_tabs(tabs="CMD,PowerShell") %}
```
python -m venv venv
venv\Scripts\activate.bat
venv\Scripts\python.exe -m pip install -U pip
venv\Scripts\python.exe -m pip install highlighter-sdk
```

```powershell
python -m venv venv
venv\Scripts\Activate.ps1
venv\Scripts\python.exe -m pip install -U pip
venv\Scripts\python.exe -m pip install highlighter-sdk
```
{% end %}

### NixOS

```
nix-shell
# Then follow the normal Linux setup
```

### GPU inference

Several SDK extras—`sam3`, `predictors`, `yolo`, `tracker`, and `ort`—depend on PyTorch and/or ONNX Runtime. By default, `pip` will install the **CPU-only** builds of these packages. If your machine is configured for CUDA and you want GPU-accelerated inference, install the GPU variants **before** the SDK so that `pip` recognises them as already satisfied.

#### PyTorch (for `sam3`, `predictors`, `yolo`, `tracker`)

Install PyTorch with CUDA support first. Check the [PyTorch install matrix](https://pytorch.org/get-started/locally/) for the command matching your CUDA version. For example, with CUDA 12.6:

```bash
pip install torch --index-url https://download.pytorch.org/whl/cu126
```

Then install the SDK extra as normal:

```bash
pip install highlighter-sdk[sam3]
```

Because `torch` is already present, `pip` will skip the CPU-only version that would otherwise be pulled in.

#### ONNX Runtime (for `predictors`, `yolo`, `ort`)

For ONNX-based capabilities, install the GPU provider package before the SDK:

```bash
pip install onnxruntime-gpu
pip install highlighter-sdk[predictors]
```

`onnxruntime-gpu` satisfies the `onnxruntime` dependency declared by the SDK, so `pip` will not replace it with the CPU-only build.

#### Verifying GPU availability

After installation you can confirm that both frameworks can see your GPU:

```bash
python -c "import torch; print('CUDA available:', torch.cuda.is_available())"
python -c "import onnxruntime as ort; print('Providers:', ort.get_available_providers())"
```

## Setup Highlighter API Credentials

See [Highlighter API Credentials](../highlighter-credentials/)

## Using the CLI

Use `hl --help` to list the individual commands. Use `hl COMMAND --help`
for help on specific commands. Some commands are nested so,
`hl COMMAND SUB_COMMAND --help` may be required.

The CLI supports headless management of many system resources, allowing you to list and delete entities like Cases, Experiments, and Workflows directly from the terminal. See [CLI Resource Management](../cli-resource-management/) for details.

Below is how to download an data-file using the cli.

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Replace 12345 with a DataFile ID from your Highlighter account
# -o will save the resulting DataFile to your cwd
hl data-file read -i 12345 -o .
```

```powershell
# Replace 12345 with a DataFile ID from your Highlighter account
# -o will save the resulting DataFile to your cwd
hl data-file read -i 12345 -o .
```
{% end %}

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


