+++
title = "Evaluating Agents from the CLI"
description = "Use hl agent evaluate to run an agent against a reference dataset and save the comparison on a research plan in one command."
date = 2026-07-14T00:00:00+00:00
updated = 2026-07-14T00:00:00+00:00
draft = false
weight = 75
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Automate the whole evaluate-an-agent loop: reference dataset in, saved evaluation comparison out."
toc = true
top = false
+++

## Overview

Evaluating a new agent or model against a reference dataset normally involves
several manual steps: create a workflow order, add the reference data to it,
run the agent over the created tasks, snapshot the agent's submissions as a new
dataset, and finally save a comparison between the two datasets on a research
plan (evaluation).

`hl agent evaluate` performs all of those steps in one command:

```bash
hl agent evaluate agent-def.json \
    --reference-dataset-id 123 \
    --workflow-id 456 \
    --evaluation-id 78
```

1. Creates a workflow order on the workflow, named `Eval run: <agent> on <dataset> <timestamp>`.
2. Populates it from the reference dataset.
3. Runs the agent definition on exactly the tasks that were created — tasks
   belonging to other orders on the same workflow are never touched.
4. Snapshots the agent's completed submissions as a locked dataset named
   `Eval output: <agent> on <dataset> <timestamp>`.
5. Saves an evaluation comparison (reference dataset vs agent output) on the
   research plan, then prints a link to it. Open the comparison's **Generate**
   link in the research plan's *Saved Comparisons* tab to view the confusion
   matrix and metrics.

`AGENT_DEFINITION` is a local agent definition file or a published
MachineAgentVersion UUID. Because the agent reads its input from tasks, the
definition must start with an `AssessmentRead` element.

## Options

| Option | Description |
|---|---|
| `--reference-dataset-id` | Dataset holding the reference (baseline) submissions. Required. |
| `--workflow-id` | Workflow whose step the agent serves; the new order is created on it. Required. |
| `--evaluation-id` | Evaluation (research plan) the comparison is saved on. Required. |
| `--case-input files\|submissions` | What the order's cases start from: the reference dataset's bare data files (default — the agent starts from a clean slate), or clones of its full submissions (the agent sees the reference annotations). |
| `--step-id` | Step the agent serves. Only needed when the order creates tasks on more than one step. |
| `--overlap` | Annotation overlap for two annotations to count as the same entity (default 0.5). |
| `--object-class-uuid` | Object classes to evaluate (repeatable). Defaults to the workflow's object classes. |
| `--focus annotation\|entity` | Whether comparisons match on annotation overlap or entity identity (default `annotation`). |
| `--name` | Overrides the run name used in the created order and dataset names. |

## Failure behaviour

The command checks every prerequisite up front — the agent definition is
valid and task-driven, the dataset, workflow and research plan exist, the
reference dataset has submissions, and the connected Highlighter server
supports the required API — and exits before creating anything if a check
fails.

If a later step fails anyway (for example, a task the agent could not
process), the command stops before creating a partial comparison dataset and
prints a catalog of everything it created — the workflow order, its cases and
tasks, and the comparison dataset if one was created — along with how to
inspect or delete them.
