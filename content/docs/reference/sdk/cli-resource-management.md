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

The Highlighter CLI (`hl`) has been expanded to support full lifecycle management of core system resources. This allows for "headless" operation, automation scripts, and cleanup tasks without needing to access the web interface.

You can now manage the following entities directly from your terminal:

*   **Cases**: `hl case`
*   **Entities**: `hl entity`
*   **Workflows**: `hl workflow` & `hl workflow-order`
*   **Experiments & Training**: `hl experiment`, `hl evaluation`, `hl training-run`
*   **Pipelines**: `hl pipeline-instance`

## Common Operations

Most resource command groups support a standard set of operations:

*   **List**: View resources with filtering options.
*   **Delete**: Remove resources (including bulk deletion).

Use the `--help` flag with any command to see available options.

```bash
hl case --help
hl experiment list --help
```

## Cases

Manage the cases (tasks) within your workflows.

```bash
# List cases in a specific workflow order
hl case list --workflow-order-id <ORDER_ID>

# Delete a specific case
hl case delete --id <CASE_ID>
```

## Workflows & Orders

Manage the structure of your projects.

```bash
# List all workflows
hl workflow list

# List orders within a workflow
hl workflow-order list --workflow-id <WORKFLOW_ID>

# Delete a workflow order (and all its cases)
hl workflow-order delete --id <ORDER_ID>
```

## Experiments & Research

Manage your model development lifecycle.

```bash
# List experiments associated with a research plan
hl experiment list --research-plan-id <PLAN_ID>

# Delete a training run
hl training-run delete --id <RUN_ID>

# Manage evaluations
hl evaluation list
```

## Entities

Manage the underlying entities (objects) tracked by the system.

```bash
# Delete an entity
hl entity delete --id <ENTITY_ID>
```
