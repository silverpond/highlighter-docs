+++
title = "Setting Up a Workflow via CLI"
description = "Create task definitions, machine assessment steps, and workflow orders entirely from the command line — no web UI required."
date = 2026-04-02T00:00:00+00:00
updated = 2026-04-02T00:00:00+00:00
draft = false
weight = 55
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Automate workflow setup from the command line — useful for scripted deployments and repeatable data import pipelines."
toc = true
top = false
+++

## Overview

The Highlighter CLI (`hl`) lets you set up a complete machine import workflow without touching the web interface. This is particularly useful for:

- Scripting repeatable import pipelines
- Setting up workflows programmatically in CI/CD
- Automating batch data ingestion

This guide covers the full setup flow: creating a task definition, adding a machine assessment step to an existing workflow, creating a workflow order, and uploading files to trigger processing.

## Prerequisites

- `hl` CLI installed and configured (`hl --version`)
- A profile set up in `~/.highlighter-profiles.yaml` (see [Highlighter Credentials](/docs/reference/sdk/highlighter-credentials/))
- An existing workflow with a data source step
- The UUID of the object class for entities you want to create

## Step 1: Find Your Workflow

```bash
hl --profile myaccount workflow list
```

Note the `ID` of the workflow you want to add the machine step to.

## Step 2: Create a Task Definition

A task definition configures what the machine assessment step does — which machine agent runs, what object class to create entities for, and how to map fields from the source file.

```bash
hl --profile myaccount task-definition create \
  --name "Import Pole Entities" \
  --task-type "KmlToEntity::EntityDetection" \
  --object-class-id <OBJECT_CLASS_UUID> \
  --entity-external-id-type "Pole" \
  --entity-external-id-field-name "SITE_LABEL"
```

Note the `id` from the response — you'll need it for the next step.

### Supported task types

| `--task-type` | Description |
|---|---|
| `KmlToEntity::EntityDetection` | Import entities from KML files |
| `DbfToEntity::EntityDetection` | Import entities from DBF (Shapefile attribute) files |
| `Review` | Human review (no machine agent) |

### List existing task definitions

```bash
hl --profile myaccount task-definition list
```

## Step 3: Add a Machine Assessment Step

```bash
hl --profile myaccount step create-machine-assessment \
  --name "Import Entities" \
  --workflow-id <WORKFLOW_ID> \
  --task-definition-id <TASK_DEFINITION_UUID>
```

The appropriate machine agent is assigned automatically from the task type. No manual agent selection is required.

The response includes the new step ID. If you need to chain this step after another, use `--previous-step-id <STEP_ID>`.

## Step 4: Create a Workflow Order

A workflow order groups the files you want to process in this run.

```bash
hl --profile myaccount workflow-order create \
  --name "Pole Import 2026-04" \
  --workflow-id <WORKFLOW_ID> \
  --state approved
```

Note the `id` from the response.

To check existing orders for a workflow:

```bash
hl --profile myaccount workflow-order list --workflow-id <WORKFLOW_ID>
```

## Step 5: Upload Files and Trigger Processing

Upload your data files to the data source, then add them to the workflow order. Adding files creates cases and triggers machine assessment tasks automatically:

```bash
# Upload files to the data source
hl --profile myaccount data-file create \
  --data-source-uuid <DATA_SOURCE_UUID> \
  --data-file-dir ./my_files/
# Outputs a JSON map of local path → file ID

# Add files to the workflow order — this creates cases and triggers processing
# (hl task create wraps the addFilesToWorkflowOrder mutation)
hl --profile myaccount task create \
  --workflow-order-id <ORDER_ID> \
  --file-ids <FILE_ID_1> \
  --file-ids <FILE_ID_2>
```

## Step 6: Verify Results

After processing, check that entities were created:

```bash
# Count all entities of the expected type
hl --profile myaccount entity count --external-id-type Pole

# List the most recent entities
hl --profile myaccount entity list \
  --external-id-type Pole \
  --limit 10
```

## Full Example Script

```bash
#!/usr/bin/env bash
set -euo pipefail

PROFILE="myaccount"
WORKFLOW_ID="1234"
OBJECT_CLASS_UUID="868bbe70-c549-42ed-be6e-fb65b8d52ebd"
DATA_SOURCE_UUID="abc123"
FILES_DIR="./import_files/"

# Note: create commands always output JSON, so no --format flag is needed.

# 1. Create task definition
TD=$(hl --profile "$PROFILE" task-definition create \
  --name "Import Pole Entities $(date +%Y-%m)" \
  --task-type "KmlToEntity::EntityDetection" \
  --object-class-id "$OBJECT_CLASS_UUID" \
  --entity-external-id-type "Pole" \
  --entity-external-id-field-name "SITE_LABEL")

TD_ID=$(echo "$TD" | python3 -c "import sys,json; print(json.load(sys.stdin)['taskDefinition']['id'])")
echo "Created task definition: $TD_ID"

# 2. Add machine assessment step
hl --profile "$PROFILE" step create-machine-assessment \
  --name "Import Entities" \
  --workflow-id "$WORKFLOW_ID" \
  --task-definition-id "$TD_ID"

# 3. Create workflow order
ORDER=$(hl --profile "$PROFILE" workflow-order create \
  --name "Import $(date +%Y-%m-%d)" \
  --workflow-id "$WORKFLOW_ID" \
  --state approved)

ORDER_ID=$(echo "$ORDER" | python3 -c "import sys,json; print(json.load(sys.stdin)['workflowOrder']['id'])")
echo "Created order: $ORDER_ID"

# 4. Upload files
UPLOAD=$(hl --profile "$PROFILE" data-file create \
  --data-source-uuid "$DATA_SOURCE_UUID" \
  --data-file-dir "$FILES_DIR")

FILE_IDS=$(echo "$UPLOAD" | python3 -c "
import sys, json
m = json.load(sys.stdin)['data_file_path_to_id']
print(' '.join(f'--file-ids {v}' for v in m.values()))
")

# 5. Add files to the workflow order — creates cases and triggers processing
eval "hl --profile '$PROFILE' task create --workflow-order-id '$ORDER_ID' $FILE_IDS"

echo "Done. Check results with:"
echo "  hl --profile $PROFILE entity count --external-id-type Pole"
```
