+++
title = "CLI Resource Management"
description = "Manage core Highlighter resources like cases, experiments, and workflows directly from the command line."
date = 2025-03-05T08:00:00+00:00
updated = 2026-04-02T00:00:00+00:00
draft = false
weight = 70
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Perform headless management of your Highlighter environment using the CLI."
toc = true
top = false
+++

## Overview

The Highlighter CLI (`hl`) supports lifecycle management of core system resources, allowing "headless" operation, automation scripts, and cleanup tasks without needing to access the web interface.

You can manage the following resources directly from your terminal:

*   **Cases**: `hl case`
*   **Entities**: `hl entity`
*   **Task Definitions**: `hl task-definition`
*   **Workflow Steps**: `hl step`
*   **Workflows**: `hl workflow` & `hl workflow-order`
*   **Experiments & Training**: `hl experiment`, `hl evaluation`, `hl training-run`
*   **Pipelines**: `hl pipeline-instance`

Use the `--help` flag with any command to see available options:

```bash
hl task-definition --help
hl entity --help
```

## Task Definitions

Task definitions configure how a machine assessment step processes data — which machine agent to use, the object class to create entities for, and how to map fields from the source file.

```bash
# List all task definitions
hl task-definition list

# Filter by task type
hl task-definition list --task-type KmlToEntity::EntityDetection

# Read a single task definition
hl task-definition read --id <UUID>

# Create a task definition
hl task-definition create \
  --name "Import Pole Entities" \
  --task-type "KmlToEntity::EntityDetection" \
  --object-class-id <OBJECT_CLASS_UUID> \
  --entity-external-id-type "Pole" \
  --entity-external-id-field-name "SITE_LABEL"

# Delete a task definition
hl task-definition delete --id <UUID>
```

Supported `--task-type` values:

| Task Type | Description |
|---|---|
| `Review` | Human review step (no machine agent) |
| `KmlToEntity::EntityDetection` | Import entities from KML files |
| `DbfToEntity::EntityDetection` | Import entities from DBF (Shapefile attribute) files |

## Workflow Orders

Workflow orders group a batch of files to be processed through a workflow.

```bash
# List orders for a workflow
hl workflow-order list --workflow-id <WORKFLOW_ID>

# Create a new order
hl workflow-order create \
  --name "Site Survey Batch 1" \
  --workflow-id <WORKFLOW_ID> \
  --state approved

# Create a draft order (files can be added before approving)
hl workflow-order create \
  --name "Pending Import" \
  --workflow-id <WORKFLOW_ID> \
  --state draft

# Delete an order
hl workflow-order delete --id <ORDER_ID>
```

The `--state` flag accepts `draft` or `approved` (default: `approved`).

The optional `--case-matching-strategy` flag controls how files are matched to cases: `geolocation`, `ingestion_path`, or `none`.

## Workflow Steps

### Machine Assessment Steps

Create a machine assessment step and automatically assign its agent based on the task definition:

```bash
hl step create-machine-assessment \
  --name "DBF Entity Import" \
  --workflow-id <WORKFLOW_ID> \
  --task-definition-id <TASK_DEFINITION_UUID>
```

The agent is selected automatically from the task definition's `task_type` — no manual agent assignment required.

To chain this step after an existing step:

```bash
hl step create-machine-assessment \
  --name "DBF Entity Import" \
  --workflow-id <WORKFLOW_ID> \
  --task-definition-id <TASK_DEFINITION_UUID> \
  --previous-step-id <PRECEDING_STEP_ID>
```

## Cases

Manage the cases within your workflows.

```bash
# Create a new case
hl case create --workflow-order-id <ORDER_ID> --name "My Case"

# Delete a specific case
hl case delete --id <CASE_ID>

# Add a message to a case
hl case message create --case-id <CASE_ID> --content "Please review this."
```

## Entities

```bash
# List entities (default: 100 most recent)
hl entity list

# Filter and format
hl entity list \
  --object-class-uuid <UUID> \
  --external-id-type Pole \
  --limit 50 \
  --format json

# Count entities matching filters
hl entity count
hl entity count --external-id-type Pole
hl entity count --object-class-uuid <UUID>

# Delete an entity
hl entity delete --id <ENTITY_ID>
```

`hl entity count` is useful for verifying the result of a bulk import without paging through all records.

## Workflows

```bash
# List workflows
hl workflow list

# Delete a workflow
hl workflow delete --id <WORKFLOW_ID>
```

## Experiments & Research

### Experiments

```bash
# Read experiment details to a markdown file
hl experiment read --id <EXPERIMENT_ID> --save-dir ./output

# Delete an experiment
hl experiment delete --id <EXPERIMENT_ID>
```

### Evaluations

```bash
# List all evaluations
hl evaluation list

# Read a specific evaluation
hl evaluation read --id <EVALUATION_ID>

# Create a new evaluation
hl evaluation create --title "Model v2 Benchmark" --assigned-to-id <USER_ID> \
  --description "Benchmark description" \
  --objective "Measure model accuracy" \
  --evaluation-process "Run inference and score predictions"

# Manage metrics within an evaluation
hl evaluation metric list --evaluation-id <EVALUATION_ID>
hl evaluation metric create --evaluation-id <EVALUATION_ID> --code Accuracy --name "Test Accuracy"

# Record evaluation results
hl evaluation result create --metric-id <METRIC_ID> --value 0.95

# Delete an evaluation
hl evaluation delete --id <EVALUATION_ID>
```

### Training Runs

```bash
# Create a training run
hl training-run create \
  --evaluation-id <EVAL_ID> \
  --experiment-id <EXP_ID> \
  --capability-id <MODEL_ID> \
  --workflow-id <WORKFLOW_ID> \
  --name "Run v1"

# Read training run configuration
hl training-run read <RUN_ID> -o config.yaml

# Delete a training run
hl training-run delete --id <RUN_ID>

# Download a training run artefact
hl training-run artefact read --id <RUN_ID> --artefact-type OnnxOpset14 --save-path ./model.onnx
```

## Pipelines

```bash
# Delete a pipeline instance
hl pipeline-instance delete --id <INSTANCE_ID>
```