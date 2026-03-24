+++
title = "CLI Resource Management"
description = "Manage core Highlighter resources like cases, experiments, and workflows directly from the command line."
date = 2025-03-05T08:00:00+00:00
updated = 2025-03-05T08:00:00+00:00
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

The Highlighter CLI (`hl`) has been expanded to support lifecycle management of core system resources. This allows for "headless" operation, automation scripts, and cleanup tasks without needing to access the web interface.

You can now manage the following entities directly from your terminal:

*   **Cases**: `hl case`
*   **Entities**: `hl entity`
*   **Workflows**: `hl workflow` & `hl workflow-order`
*   **Experiments & Training**: `hl experiment`, `hl evaluation`, `hl training-run`
*   **Pipelines**: `hl pipeline-instance`

## Common Operations

Most resource command groups support a `delete` operation for cleanup. Use the `--help` flag with any command to see available options.

```bash
hl case --help
hl evaluation --help
```

## Cases

Manage the cases (tasks) within your workflows.

```bash
# Create a new case
hl case create --workflow-order-id <ORDER_ID> --name "My Case"

# Delete a specific case
hl case delete --id <CASE_ID>

# Add a message to a case
hl case message create --case-id <CASE_ID> --content "Please review this."
```

## Workflows & Orders

Manage the structure of your projects.

```bash
# Delete a workflow
hl workflow delete --id <WORKFLOW_ID>

# Delete a workflow order
hl workflow-order delete --id <ORDER_ID>
```

## Experiments & Research

Manage your model development lifecycle.

### Experiments

```bash
# Read experiment details to a markdown file
hl experiment read --id <EXPERIMENT_ID> --save-dir ./output

# Delete an experiment
hl experiment delete --id <EXPERIMENT_ID>
```

### Evaluations

Evaluations support a rich set of commands for managing metrics and results.

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
hl training-run create --evaluation-id <EVAL_ID> --experiment-id <EXP_ID> --capability-id <MODEL_ID> --workflow-id <WORKFLOW_ID> --name "Run v1"

# Read training run configuration
hl training-run read --id <RUN_ID> --output config.yaml

# Delete a training run
hl training-run delete --id <RUN_ID>

# Download a training run artefact
hl training-run artefact read --id <RUN_ID> --artefact-type OnnxOpset14 --save-path ./model.onnx
```

## Entities & Pipelines

Manage other core resources.

```bash
# Delete an entity
hl entity delete --id <ENTITY_ID>

# Delete a pipeline instance
hl pipeline-instance delete --id <INSTANCE_ID>
```