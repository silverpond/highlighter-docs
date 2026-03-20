+++
title = "Data Source Management CLI"
description = "Manage Highlighter data sources via CLI with smart matching, templates, and bulk operations"
date = 2025-12-17T08:00:00+00:00
updated = 2025-12-17T08:00:00+00:00
draft = false
weight = 60
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Create, import, export, and manage data sources in Highlighter Cloud using the command-line interface with smart matching and templates."
toc = true
top = false
+++

## Overview

The `hl datasource` command group provides comprehensive tools for managing data sources in Highlighter Cloud. Data sources represent video streams, cameras, or other media inputs that feed into Highlighter workflows.

**Key capabilities:**

- **Cloud Operations** - Create, list, view, update, and delete data sources
- **Import/Export** - Sync data sources between local files and Highlighter Cloud
- **Smart Matching** - Automatically match local and cloud data sources by ID, UUID, name, or URI
- **Templates** - Use predefined templates for common camera configurations
- **Bulk Operations** - Import and manage multiple data sources efficiently
- **Network Integration** - Export discovered devices directly as data sources

## Prerequisites

- **Highlighter SDK** installed (see [Getting Started](../getting-started-with-highlighter-sdk/))
- **API Credentials** configured (see [Highlighter API Credentials](../highlighter-credentials/))
- **Cloud Access** - Active Highlighter Cloud account with appropriate permissions

## Command Overview

```
hl datasource
├── discover          # Network device discovery (see Network Discovery guide)
├── list             # List data sources from cloud or local file
├── view             # View details of a single data source
├── create           # Create a new data source
├── update           # Update an existing data source
├── delete           # Delete a data source
├── import           # Import local data sources to cloud
└── export           # Export cloud data sources to local file
```

For network discovery commands, see [Network Device Discovery](../network-discovery/).

## Quick Start

```bash
# List all data sources from cloud
hl datasource list

# Create a new data source
hl datasource create --name "Camera-Front-Entrance" \
  --source-uri "rtsp://10.1.1.100:554/stream"

# Export all data sources to a file
hl datasource export --output my-cameras.json

# Import data sources from file
hl datasource import --file my-cameras.json --create-missing
```

---

## Cloud Operations

### `hl datasource list`

List data sources from Highlighter Cloud or a local file.

**Usage:**
```bash
hl datasource list [OPTIONS]
```

**Options:**
- `--file, -f PATH` - Local file path (if not specified, queries cloud)
- `--format [table|json|csv|stream]` - Output format (default: table)
- `--stream-template PATH` - Template JSON for stream definitions (used with `--format=stream`)

**Examples:**

```bash
# List all data sources from cloud
hl datasource list

# List from local file
hl datasource list --file cameras.json

# JSON output
hl datasource list --format json

# CSV output for spreadsheet import
hl datasource list --format csv

# Generate stream definitions for Aiko workflows
hl datasource list --format stream --stream-template stream-template.json
```

**Table Output (default):**
```
Data sources from cloud (15 total):

1. Camera-Front-Entrance
   ID:   1234
   UUID: 550e8400-e29b-41d4-a716-446655440000

2. Camera-Loading-Dock
   ID:   1235
   UUID: 6ba7b810-9dad-11d1-80b4-00c04fd430c8
```

**JSON Output:**
```json
[
  {
    "id": 1234,
    "uuid": "550e8400-e29b-41d4-a716-446655440000",
    "name": "Camera-Front-Entrance"
  },
  {
    "id": 1235,
    "uuid": "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
    "name": "Camera-Loading-Dock"
  }
]
```

**Stream Template Feature:**

Create a template file `stream-template.json`:
```json
{
  "data_sources": "({source_uri})",
  "subgraph_name": "{name}",
  "custom_field": "value-{id}"
}
```

Then generate stream definitions:
```bash
hl datasource list --format stream --stream-template stream-template.json
```

---

### `hl datasource view`

View detailed information about a single data source.

**Usage:**
```bash
hl datasource view [OPTIONS]
```

**Options:**
- `--id ID` - Data source ID
- `--uuid UUID` - Data source UUID
- `--name, -n NAME` - Data source name
- `--format [table|json]` - Output format (default: table)

**Note:** Must provide exactly one of `--id`, `--uuid`, or `--name`.

**Examples:**

```bash
# View by ID
hl datasource view --id 1234

# View by UUID
hl datasource view --uuid 550e8400-e29b-41d4-a716-446655440000

# View by name
hl datasource view --name "Camera-Front-Entrance"

# JSON output
hl datasource view --id 1234 --format json
```

---

### `hl datasource create`

Create a new data source in Highlighter Cloud.

**Usage:**
```bash
hl datasource create [OPTIONS]
```

**Options:**
- `--name, -n NAME` - Data source name (required)
- `--source-uri, -u URI` - Source URI (e.g., `rtsp://hostname:554/stream`)
- `--format [table|json]` - Output format (default: table)

**Examples:**

```bash
# Create with name only
hl datasource create --name "Camera-New"

# Create with name and URI
hl datasource create --name "Camera-Front-Entrance" \
  --source-uri "rtsp://10.1.1.100:554/stream"

# JSON output
hl datasource create --name "Camera-New" --format json
```

---

### `hl datasource update`

Update an existing data source in Highlighter Cloud.

**Usage:**
```bash
hl datasource update [OPTIONS]
```

**Options:**
- `--id ID` - Data source ID
- `--uuid UUID` - Data source UUID
- `--name, -n NAME` - New name
- `--source-uri, -u URI` - New source URI
- `--format [table|json]` - Output format (default: table)

**Note:** Must provide either `--id` or `--uuid` to identify the data source.

**Examples:**

```bash
# Update name by ID
hl datasource update --id 1234 --name "Camera-Front-Entrance-Updated"

# Update URI by UUID
hl datasource update --uuid 550e8400-e29b-41d4-a716-446655440000 \
  --source-uri "rtsp://10.1.1.91:554/Streaming/Channels/101"

# Update both name and URI
hl datasource update --id 1234 \
  --name "Camera-New-Name" \
  --source-uri "rtsp://10.1.1.92:554/stream"
```

---

### `hl datasource delete`

Delete a data source from Highlighter Cloud.

**Usage:**
```bash
hl datasource delete [OPTIONS]
```

**Options:**
- `--id ID` - Data source ID
- `--uuid UUID` - Data source UUID
- `--yes, -y` - Skip confirmation prompt

**Note:** Must provide either `--id` or `--uuid`.

**Examples:**

```bash
# Delete by ID (with confirmation)
hl datasource delete --id 1234

# Delete by UUID (skip confirmation)
hl datasource delete --uuid 550e8400-e29b-41d4-a716-446655440000 --yes
```

---

## Import and Export

### `hl datasource export`

Export data sources from Highlighter Cloud to a local JSON file.

**Usage:**
```bash
hl datasource export [OPTIONS]
```

**Options:**
- `--output, -o PATH` - Output file path (required)
- `--limit N` - Limit number of data sources to export
- `--template NAME` - Associate exported data sources with a template

**Examples:**

```bash
# Export all data sources
hl datasource export --output all-cameras.json

# Export first 10 data sources
hl datasource export --output sample-cameras.json --limit 10

# Export with template association
hl datasource export --output rtsp-cameras.json --template rtsp
```

**Output Format:**
```json
{
  "data_sources": [
    {
      "id": 1234,
      "uuid": "550e8400-e29b-41d4-a716-446655440000",
      "name": "Camera-Front-Entrance",
      "source_uri": null,
      "mac": null,
      "serial": null,
      "hostname": null,
      "ip": null,
      "port": null,
      "template": null
    }
  ],
  "metadata": {
    "created_at": "2025-12-17T10:30:00",
    "updated_at": "2025-12-17T10:30:00"
  }
}
```

---

### `hl datasource import`

Import data sources from a local file to Highlighter Cloud with smart matching and deduplication.

**Usage:**
```bash
hl datasource import [OPTIONS]
```

**Options:**
- `--file, -f PATH` - Local JSON file to import (required)
- `--create-missing` - Create data sources that don't exist in cloud
- `--update-existing` - Update matched data sources with local values
- `--match-by [id|uuid|name|source_uri|auto]` - Matching strategy (default: auto)
- `--output, -o PATH` - Save updated file with cloud IDs/UUIDs

**Matching Strategies:**

- `auto` - Try matching by ID → UUID → source_uri → name (default, recommended)
- `id` - Match only by ID field
- `uuid` - Match only by UUID field
- `name` - Match only by name field
- `source_uri` - Match only by source URI field

**Examples:**

```bash
# Import with auto-matching (read-only, shows what would match)
hl datasource import --file cameras.json

# Create missing data sources
hl datasource import --file cameras.json --create-missing

# Update existing and create missing
hl datasource import --file cameras.json --create-missing --update-existing

# Match only by name
hl datasource import --file cameras.json --match-by name --create-missing

# Save updated file with cloud IDs
hl datasource import --file cameras.json --create-missing --output cameras-with-ids.json
```

**Deduplication Behavior:**

The import command prevents creating duplicate data sources:

- If a data source with the same `source_uri` already exists in cloud, it will be matched and not duplicated
- Use `--update-existing` to update the matched data source with new values
- Without `--update-existing`, matched data sources are skipped

**Complete Workflow Example:**

```bash
# 1. Discover cameras and export to file
hl datasource discover batch --file macs.txt \
  --format datasource \
  --output cameras.json

# 2. Review the file (optional)
cat cameras.json

# 3. Import to cloud (creates new data sources)
hl datasource import --file cameras.json --create-missing

# 4. Save file with cloud IDs for future updates
hl datasource import --file cameras.json --output cameras-synced.json

# 5. Later, update existing data sources
hl datasource import --file cameras-synced.json --update-existing
```

---

## Templates

Templates provide reusable configuration patterns for common camera types and protocols.

### What are Templates?

A template defines:
- **source_uri_pattern** - URI pattern with placeholders like `{ip}`, `{port}`, `{path}`
- **name_pattern** - Optional name pattern with placeholders
- **default_port** - Default port if not provided by device
- **default_path** - Default path component for URIs
- **fields** - Field requirements and defaults

### Built-in Templates

List available templates:

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Templates are stored in the SDK
ls $(python -c "import highlighter.datasource; import os; print(os.path.dirname(highlighter.datasource.__file__))")/templates/
```

```powershell
# Templates are stored in the SDK
$dir = python -c "import highlighter.datasource; import os; print(os.path.dirname(highlighter.datasource.__file__))"
Get-ChildItem "$dir\templates\"
```
{% end %}

### Using Templates with Discovery

Templates are most commonly used with network discovery to generate data source entries:

```bash
# Use built-in RTSP template
hl datasource discover batch --file macs.txt \
  --format datasource \
  --template rtsp \
  --output cameras.json

# Use custom template file
hl datasource discover batch --file macs.txt \
  --format datasource \
  --template ./my-custom-template.json \
  --output cameras.json
```

### Template Structure

Example template (`rtsp.json`):

```json
{
  "name": "rtsp",
  "description": "Standard RTSP camera stream",
  "source_uri_pattern": "rtsp://{ip}:{port}{path}",
  "name_pattern": "{name}",
  "default_port": 554,
  "default_path": "/stream",
  "fields": {
    "ip": {
      "required": true,
      "type": "string"
    },
    "port": {
      "required": false,
      "type": "integer",
      "default": 554
    }
  }
}
```

### Available Placeholders

Templates support these placeholders:

- `{ip}` - Device IP address
- `{hostname}` - Device hostname
- `{port}` - Device port
- `{serial}` - Device serial number
- `{mac}` - Device MAC address
- `{service_name}` - mDNS service name
- `{name}` - Custom name (if provided in batch input)
- `{path}` - Path component (from template default_path)

### Custom Patterns Without Templates

You can also use custom patterns directly without creating a template file:

```bash
hl datasource discover batch --file macs.txt \
  --format datasource \
  --uri-pattern "rtsp://{ip}:554/Streaming/Channels/101" \
  --name-pattern "Camera-{serial}" \
  --output cameras.json
```

**Note:** Cannot use both `--template` and custom patterns (`--uri-pattern`/`--name-pattern`) together.

---

## Common Workflows

### Workflow 1: Discover and Import Cameras

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Step 1: Create MAC address file
cat > cameras.txt <<EOF
80:BE:AF:F9:78:17
80:BE:AF:F9:77:FE
50:E5:38:C7:8A:17
EOF

# Step 2: Discover and export to JSON with template
hl datasource discover batch --file cameras.txt \
  --format datasource \
  --template rtsp \
  --output discovered-cameras.json

# Step 3: Review the file
cat discovered-cameras.json

# Step 4: Import to cloud
hl datasource import --file discovered-cameras.json --create-missing

# Step 5: Verify import
hl datasource list
```

```powershell
# Step 1: Create MAC address file
@"
80:BE:AF:F9:78:17
80:BE:AF:F9:77:FE
50:E5:38:C7:8A:17
"@ | Set-Content cameras.txt

# Step 2: Discover and export to JSON with template
hl datasource discover batch --file cameras.txt `
  --format datasource `
  --template rtsp `
  --output discovered-cameras.json

# Step 3: Review the file
Get-Content discovered-cameras.json

# Step 4: Import to cloud
hl datasource import --file discovered-cameras.json --create-missing

# Step 5: Verify import
hl datasource list
```
{% end %}

### Workflow 2: Bulk Update Existing Data Sources

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Step 1: Export current data sources
hl datasource export --output current-cameras.json

# Step 2: Edit the file (update names, URIs, etc.)
vim current-cameras.json

# Step 3: Import with update flag
hl datasource import --file current-cameras.json --update-existing
```

```powershell
# Step 1: Export current data sources
hl datasource export --output current-cameras.json

# Step 2: Edit the file (update names, URIs, etc.)
notepad current-cameras.json

# Step 3: Import with update flag
hl datasource import --file current-cameras.json --update-existing
```
{% end %}

### Workflow 3: Backup and Restore

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Backup all data sources
hl datasource export --output backup-$(date +%Y%m%d).json

# Restore from backup (creates missing, updates existing)
hl datasource import --file backup-20251217.json \
  --create-missing \
  --update-existing
```

```powershell
# Backup all data sources
hl datasource export --output "backup-$(Get-Date -Format 'yyyyMMdd').json"

# Restore from backup (creates missing, updates existing)
hl datasource import --file backup-20251217.json `
  --create-missing `
  --update-existing
```
{% end %}

### Workflow 4: Migrate Between Environments

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
# Export from production
hl datasource export --output prod-cameras.json

# Switch to staging environment (configure different credentials)
export HL_API_URL=https://staging.highlighter.ai

# Import to staging
hl datasource import --file prod-cameras.json --create-missing
```

```powershell
# Export from production
hl datasource export --output prod-cameras.json

# Switch to staging environment (configure different credentials)
$env:HL_API_URL = "https://staging.highlighter.ai"

# Import to staging
hl datasource import --file prod-cameras.json --create-missing
```
{% end %}

---

## Integration with Network Discovery

The data source CLI seamlessly integrates with network discovery. See [Network Device Discovery](../network-discovery/) for complete discovery documentation.

**Quick integration example:**

```bash
# Discover cameras on network and create data sources in one workflow
hl datasource discover batch --file camera-macs.txt \
  --format datasource \
  --template rtsp \
  --output cameras.json

# Import discovered cameras to cloud
hl datasource import --file cameras.json --create-missing

# Verify
hl datasource list
```

**Export formats:**

- `--format csv` - CSV output for spreadsheets and scripts
- `--format datasource` - JSON format ready for import to cloud

---

## Local File Format

Data source files use JSON format with this structure:

```json
{
  "data_sources": [
    {
      "id": 1234,
      "uuid": "550e8400-e29b-41d4-a716-446655440000",
      "name": "Camera-Front-Entrance",
      "source_uri": "rtsp://10.1.1.91:554/stream",
      "mac": "80:BE:AF:F9:78:17",
      "serial": "GB2148455",
      "hostname": "camera.local",
      "ip": "10.1.1.91",
      "port": "554",
      "template": "rtsp"
    }
  ],
  "template": "rtsp",
  "metadata": {
    "created_at": "2025-12-17T10:30:00",
    "updated_at": "2025-12-17T10:30:00"
  }
}
```

**Fields:**

- `id` - Cloud data source ID (set after import)
- `uuid` - Cloud data source UUID (set after import)
- `name` - Data source name (required)
- `source_uri` - Source URI (optional, e.g., RTSP URL)
- `mac` - Device MAC address (from discovery)
- `serial` - Device serial number (from discovery)
- `hostname` - Device hostname (from discovery)
- `ip` - Device IP address (from discovery)
- `port` - Device port (from discovery)
- `template` - Template name used (from discovery)

---

## Troubleshooting

### Duplicate data sources

**Problem:** Import creates duplicate data sources instead of matching existing ones.

**Solutions:**
- Use `--match-by source_uri` for explicit URI-based matching
- Review matched data sources with import (without `--create-missing`) first
- Ensure `source_uri` values are consistent (trailing slashes, port numbers, etc.)

### Missing required fields

**Problem:** Template validation fails with missing field errors.

**Solutions:**
- Ensure discovery found all required fields for the template
- Check device discovery output for missing information
- Use custom patterns instead of templates if device lacks required fields
- Create a custom template with appropriate defaults

### Permission errors

**Problem:** Access denied when creating or updating data sources.

**Solutions:**
- Verify Highlighter credentials are configured (see [Highlighter API Credentials](../highlighter-credentials/))
- Check your user has appropriate permissions in Highlighter Cloud
- Ensure network connectivity to Highlighter Cloud API
- Check API token expiration

### Matching issues

**Problem:** Data sources don't match as expected during import.

**Solutions:**
- Use `--match-by auto` (default) for most flexible matching
- Try specific match strategies (`--match-by name` or `--match-by source_uri`)
- Verify field values match exactly (case-sensitive)
- Review import output to see which data sources matched

---

## Environment Variables

Configure Highlighter API access:

- `HL_API_URL` - Highlighter API endpoint (e.g., `https://api.highlighter.ai`)
- `HL_API_TOKEN` - Authentication token
- `HL_CLIENT_ID` - OAuth client ID (if using OAuth authentication)

Set these in your shell:

{% code_tabs(tabs="Bash,PowerShell") %}
```bash
export HL_API_URL=https://api.highlighter.ai
export HL_API_TOKEN=your-token-here
```

```powershell
$env:HL_API_URL = "https://api.highlighter.ai"
$env:HL_API_TOKEN = "your-token-here"
```
{% end %}

Or create a `.env` file in your project directory.

---

## Python API

For programmatic access, use the Python API:

```python
from highlighter.client import HLClient
from highlighter.datasource.service import DataSourceService

# Initialize client
client = HLClient()
service = DataSourceService(client)

# List data sources
cloud_sources = service.fetch_from_cloud()
for source in cloud_sources:
    print(f"{source.id}: {source.name}")

# Create data source
created = service.create(
    name="Camera-1",
    source_uri="rtsp://10.1.1.100:554/stream"
)

# Load local file
from pathlib import Path
local_file = service.load_file(Path("cameras.json"))

# Import to cloud
updated_entries, result = service.import_to_cloud(
    entries=local_file.data_sources,
    create_missing=True,
    update_existing=False
)

print(f"Created: {result.created}, Updated: {result.updated}")
```

See `sdk/python/src/highlighter/datasource/service.py` for complete API documentation.

---

## See Also

- [Network Device Discovery](../network-discovery/) - Discover devices via mDNS/Bonjour
- [Getting Started with Highlighter SDK](../getting-started-with-highlighter-sdk/) - SDK installation and setup
- [Highlighter API Credentials](../highlighter-credentials/) - Configure API access

**Related Python modules:**
- `highlighter.datasource.service` - Data source service layer (sdk/python/src/highlighter/datasource/service.py:1)
- `highlighter.datasource.models` - Data models (sdk/python/src/highlighter/datasource/models.py:1)
- `highlighter.cli.datasource` - CLI commands (sdk/python/src/highlighter/cli/datasource.py:1)
