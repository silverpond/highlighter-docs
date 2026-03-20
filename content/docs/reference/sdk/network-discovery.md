+++
title = "Network Device Discovery"
description = "Discover IP cameras and devices on your network using mDNS/Bonjour with the Highlighter SDK"
date = 2025-12-17T08:00:00+00:00
updated = 2025-12-17T08:00:00+00:00
draft = false
weight = 50
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Use mDNS/Bonjour to discover IP cameras and network devices, find devices by MAC address or serial number, and automate network inventory."
toc = true
top = false
+++

## Overview

The Highlighter SDK includes powerful network discovery capabilities that use mDNS (Multicast DNS) / Zeroconf to discover devices on your local network. This is particularly useful for:

- **Finding IP cameras** (HIKVISION, AXIS, DAHUA, and others)
- **Network inventory** - discovering all devices on your network
- **Camera setup automation** - bulk provisioning of cameras
- **Device troubleshooting** - locating devices by MAC address or serial number

The implementation uses the Python `zeroconf` library for cross-platform mDNS service discovery, making it work reliably on **Linux, macOS, and Windows** without requiring additional system packages.

## How It Works

The discovery process works in the following steps:

1. **mDNS Discovery**: Uses the `zeroconf` library to discover mDNS/Bonjour services on the network
2. **Service Browsing**: Browses for camera-related service types (`_http._tcp`, `_psia._tcp`, `_CGI._tcp`)
3. **Camera Filtering**: Filters results to find HIKVISION, AXIS, DAHUA, and other camera services
4. **Information Extraction**: Extracts IP address, hostname, port, and serial number from service records
5. **MAC Address Lookup**: Uses the ARP table (`ip neighbor` or `arp`) to find MAC addresses for discovered IPs
6. **Matching**: Searches for devices matching provided criteria (MAC address or serial number)

## Prerequisites

- **Highlighter SDK** installed (see [Getting Started](../getting-started-with-highlighter-sdk/))
- **Python 3.12+**
- **Network requirements**: Devices must be on the same subnet and have mDNS/Bonjour enabled
- The `zeroconf` Python library is automatically included with the SDK

## Quick Start

```bash
# List all cameras on the network
hl datasource discover list

# Find a camera by MAC address
hl datasource discover find --mac 80:BE:AF:F9:78:17

# Find a camera by serial number
hl datasource discover find --serial GB2148455

# Batch lookup multiple cameras and save to CSV
hl datasource discover batch --file macs.txt --output cameras.csv
```

## Command Reference

### `hl datasource discover list`

List all devices discovered on the local network.

**Usage:**
```bash
hl datasource discover list [OPTIONS]
```

**Options:**
- `--show-mac / --no-show-mac` - Show MAC addresses (requires ARP access, default: True)
- `-t, --timeout SECONDS` - Discovery timeout in seconds (default: 5)
- `--service-type TYPE` - mDNS service type to query (repeatable)
- `--keyword KEYWORD` - Filter services by keyword (repeatable)
- `--max-mac-workers N` - Maximum concurrent MAC resolution tasks (default: 8)

**Examples:**

```bash
# List all cameras on the network
hl datasource discover list

# List without MAC addresses (faster, no elevated permissions needed)
hl datasource discover list --no-show-mac

# Extend discovery timeout for slower networks
hl datasource discover list --timeout 10

# Discover ONVIF cameras
hl datasource discover list --service-type _onvif._tcp.local. --keyword ONVIF
```

**Example Output:**
```
Discovering devices on the network...

Found 3 device(s):

1. DS-2CD2686G2T-IZS20231208AAWRAX6597176
   IP:       10.1.1.91:80
   Hostname: DS-2CD2686G2T-IZS20231208AAWRAX6597176.local
   Serial:   GB2148455
   MAC:      80:BE:AF:F9:78:17

2. HIK-Camera-2
   IP:       10.1.1.90:80
   Hostname: camera-2.local
   MAC:      80:BE:AF:F9:77:FE
```

---

### `hl datasource discover find`

Find a specific device by MAC address or serial number.

**Usage:**
```bash
hl datasource discover find [OPTIONS]
```

**Options:**
- `-m, --mac MAC` - MAC address to search for (format: `XX:XX:XX:XX:XX:XX` or `XX-XX-XX-XX-XX-XX`)
- `-s, --serial SERIAL` - Serial number to search for
- `-t, --timeout SECONDS` - Discovery timeout (default: 5)
- `--service-type TYPE` - mDNS service type to query (repeatable)
- `--keyword KEYWORD` - Filter services by keyword (repeatable)
- `--max-mac-workers N` - Maximum concurrent MAC resolution tasks (default: 8)

**Note:** You must provide either `--mac` or `--serial`.

**Examples:**

```bash
# Find camera by MAC address
hl datasource discover find --mac 80:BE:AF:F9:78:17

# Find camera by serial number
hl datasource discover find --serial GB2148455

# Use alternative MAC format
hl datasource discover find --mac 80-be-af-f9-78-17
```

**Example Output:**
```
Discovering devices on the network...
Found device:
  Service:  DS-2CD2686G2T-IZS20231208AAWRAX6597176
  IP:       10.1.1.91
  Port:     80
  Hostname: DS-2CD2686G2T-IZS20231208AAWRAX6597176.local
  Serial:   GB2148455
  MAC:      80:BE:AF:F9:78:17

IP Address: 10.1.1.91
```

The final line (`IP Address: ...`) is designed for easy script capture.

---

### `hl datasource discover batch`

Perform bulk device lookup by MAC addresses with flexible output options.

**Usage:**
```bash
hl datasource discover batch [OPTIONS] [MAC_ADDRESSES...]
```

**Options:**
- `-f, --file PATH` - File containing MAC addresses (one per line)
- `-o, --output PATH` - Write results to a file
- `--format [csv|datasource]` - Output format (default: csv)
- `--csv / --no-csv` - Include CSV header (default: True)
- `--quiet / --no-quiet` - Suppress progress messages (default: False)
- `--show-hostname / --no-show-hostname` - Include hostname column (default: True)
- `-t, --timeout SECONDS` - Discovery timeout (default: 5)
- `--max-mac-workers N` - Maximum concurrent MAC resolution tasks (default: 8)

See [Data Source Management CLI](../data-source-cli/) for additional options when using `--format datasource`.

**Input Methods:**

1. **From file:**
   ```bash
   hl datasource discover batch --file macs.txt
   ```

2. **From command line:**
   ```bash
   hl datasource discover batch 80:BE:AF:F9:78:17 80:BE:AF:F9:77:FE
   ```

3. **From stdin:**
   ```bash
   cat macs.txt | hl datasource discover batch
   ```

**MAC Address File Format:**

Create a file `macs.txt` with one MAC address per line:
```
80:be:af:f9:78:17
80:be:af:f9:77:fe
50:e5:38:c7:8a:17
# Comments are allowed
50:e5:38:c7:8a:2f
```

Lines starting with `#` are treated as comments and ignored.

**CSV Output:**

```bash
hl datasource discover batch --file macs.txt
```

Output:
```csv
MAC,IP,Hostname
80:BE:AF:F9:78:17,10.1.1.91,DS-2CD2686G2T-IZS20231208AAWRAX6597176.local
80:BE:AF:F9:77:FE,10.1.1.90,camera-2.local
50:E5:38:C7:8A:17,not_found,
```

If a MAC address is not found, it shows `not_found` in the IP column.

**Save to File:**

```bash
hl datasource discover batch --file macs.txt --output network-inventory.csv
```

---

## Scripting and Automation

The discovery commands are designed to be script-friendly.

### Script-Friendly Features

- **Predictable output**: CSV format with consistent column ordering
- **Preserves input order**: Results match the order of requested MAC addresses
- **Quiet mode**: Suppress progress messages with `--quiet`
- **Exit status**: Non-zero exit code on errors

### Batch Scripting Example

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Parse CSV output with hostname (default)
hl datasource discover batch --file macs.txt --quiet | tail -n +2 | while IFS=',' read -r mac ip hostname; do
  if [ "$ip" != "not_found" ]; then
    echo "Camera $mac is at $ip (hostname: $hostname)"
    # Perform actions on each camera
    ping -c 1 "$ip" > /dev/null && echo "  - Online"
  else
    echo "Camera $mac not found on network"
  fi
done
```

```powershell
# Parse CSV output with hostname (default)
hl datasource discover batch --file macs.txt --quiet | Select-Object -Skip 1 | ForEach-Object {
    $parts = $_ -split ','
    $mac = $parts[0]; $ip = $parts[1]; $hostname = $parts[2]
    if ($ip -ne "not_found") {
        Write-Host "Camera $mac is at $ip (hostname: $hostname)"
        # Perform actions on each camera
        if (Test-Connection -ComputerName $ip -Count 1 -Quiet) { Write-Host "  - Online" }
    } else {
        Write-Host "Camera $mac not found on network"
    }
}
```
{% end %}

### Network Inventory Workflow

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Discover all devices and export to CSV
hl datasource discover batch \
  --timeout 10 \
  --output network-inventory.csv \
  $(arp -a | grep -oE '([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}')

# Or from existing ARP table
arp -a | grep -oE '([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' > all-macs.txt
hl datasource discover batch --file all-macs.txt --output inventory.csv
```

```powershell
# Discover all devices and export to CSV
$macs = arp -a | Select-String -Pattern '([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}' -AllMatches |
    ForEach-Object { $_.Matches.Value }
hl datasource discover batch --timeout 10 --output network-inventory.csv $macs

# Or from existing ARP table
arp -a | Select-String -Pattern '([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}' -AllMatches |
    ForEach-Object { $_.Matches.Value } | Set-Content all-macs.txt
hl datasource discover batch --file all-macs.txt --output inventory.csv
```
{% end %}

---

## Advanced Configuration

### Custom Service Types

By default, the discovery tool searches for these service types:
- `_http._tcp.local.` - HTTP services
- `_psia._tcp.local.` - PSIA (camera protocol)
- `_CGI._tcp.local.` - CGI interfaces

You can add additional service types:

```bash
# Discover ONVIF cameras
hl datasource discover list --service-type _onvif._tcp.local.

# Discover multiple service types
hl datasource discover list \
  --service-type _http._tcp.local. \
  --service-type _onvif._tcp.local.
```

### Custom Keywords

The tool filters services by vendor keywords (HIKVISION, AXIS, DAHUA, etc.). Add custom keywords:

```bash
# Add custom vendor keyword
hl datasource discover list --keyword ONVIF

# Multiple keywords
hl datasource discover list --keyword HIKVISION --keyword AXIS
```

### Performance Tuning

```bash
# Increase timeout for slower networks
hl datasource discover list --timeout 10

# Increase MAC resolution concurrency
hl datasource discover batch --file macs.txt --max-mac-workers 16

# Skip MAC resolution for faster discovery
hl datasource discover list --no-show-mac
```

---

## Troubleshooting

### No devices found

1. **Network connectivity**: Ensure devices are on the same network subnet
2. **mDNS/Bonjour enabled**: Check that mDNS/Bonjour is enabled on your devices
3. **mDNS responder running**:
   - Linux: `systemctl status avahi-daemon` (if installed)
   - macOS: mDNS is built-in
   - Windows: Bonjour service should be running
4. **Increase timeout**: Try `--timeout 10` for slower networks
5. **Firewall**: Some networks block multicast traffic (UDP port 5353)
6. **Elevated permissions**: Try `sudo hl datasource discover list`
7. **Skip MAC lookup**: Use `--no-show-mac` if MAC lookups require admin rights

### MAC address shows as "Unknown"

1. **Populate ARP cache**: Ping the device first to populate ARP table
   ```bash
   ping 10.1.1.88
   hl datasource discover list
   ```
2. **Check ARP table manually**: `ip neighbor` or `arp -a`
3. **Permissions**: You may need elevated permissions for ARP access
4. **Skip MAC resolution**: Use `--no-show-mac` to avoid ARP lookups

### zeroconf library not found

The zeroconf library is automatically included with the Highlighter SDK. If you encounter import errors:

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Reinstall the SDK
pip install --upgrade highlighter-sdk

# Or in a fresh virtual environment
python -m venv venv
source venv/bin/activate
pip install highlighter-sdk
```

```powershell
# Reinstall the SDK
pip install --upgrade highlighter-sdk

# Or in a fresh virtual environment
python -m venv venv
venv\Scripts\Activate.ps1
pip install highlighter-sdk
```
{% end %}

### Slow discovery

1. **Reduce timeout**: Default is 5 seconds, try `--timeout 3` for faster scans
2. **Skip MAC resolution**: Use `--no-show-mac` to avoid ARP lookups
3. **Limit MAC workers**: If system is slow, reduce `--max-mac-workers 4`

---

## Platform-Specific Notes

### Linux

- Works out of the box with the `zeroconf` library
- ARP table access via `ip neighbor` or `arp` commands
- May require `sudo` for network discovery on some systems
- Avahi daemon is optional (zeroconf has pure-Python implementation)

### macOS

- Fully supported, uses native Bonjour infrastructure
- ARP table access via the built-in `arp` command
- Skip MAC resolution with `--no-show-mac` if you don't want elevated privileges
- Works perfectly without any additional configuration

### Windows

- Fully supported via the `zeroconf` library
- Bonjour service recommended (typically installed with iTunes or as standalone)
- Use an elevated terminal (Run as Administrator) for MAC resolution
- Alternatively, use `--no-show-mac` to skip MAC lookups

---

## Integration with Data Sources

The discovery commands integrate seamlessly with data source management. See [Data Source Management CLI](../data-source-cli/) for:

- **Exporting to data source format**: Use `--format datasource` with batch command
- **Templates**: Apply templates to discovered devices
- **Cloud import**: Import discovered devices directly to Highlighter Cloud

**Quick Example:**

```bash
# Discover cameras and export as data sources
hl datasource discover batch --file macs.txt \
  --format datasource \
  --output cameras.json

# Import to Highlighter Cloud
hl datasource import --file cameras.json --create-missing
```

---

## Configuration Internals

For advanced users and automation:

- **Default timeout**: 5 seconds (balances responsiveness and completeness)
- **MAC resolution**: Up to 8 concurrent worker threads
- **Service types and keywords**: Customizable programmatically via `DiscoveryConfig`
- **IPv4 preference**: IPv4 addresses are preferred over IPv6 in output

When embedding discovery in your own Python code:

```python
from highlighter.network.mdns import DiscoveryConfig, discover_devices

config = DiscoveryConfig(
    timeout_seconds=10,
    service_types=["_http._tcp.local.", "_onvif._tcp.local."],
    device_keywords=["HIKVISION", "AXIS", "CUSTOM_VENDOR"],
    max_mac_workers=16
)

devices = discover_devices(config=config, resolve_macs=True)
for device in devices:
    print(f"{device.ip} - {device.mac} - {device.serial}")
```

---

## See Also

- [Data Source Management CLI](../data-source-cli/) - Create, import, and manage data sources
- [Getting Started with Highlighter SDK](../getting-started-with-highlighter-sdk/) - SDK installation and setup
- [Highlighter API Credentials](../highlighter-credentials/) - Configure API access

**Related Python modules:**
- `highlighter.network.mdns` - Core mDNS discovery implementation (sdk/python/src/highlighter/network/mdns.py:1)
- `highlighter.cli.discovery_cli` - CLI helper functions (sdk/python/src/highlighter/cli/discovery_cli.py:1)
- `highlighter.cli.datasource` - Data source commands (sdk/python/src/highlighter/cli/datasource.py:1)
