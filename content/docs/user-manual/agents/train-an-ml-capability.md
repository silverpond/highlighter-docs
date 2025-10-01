+++
title = "Train an ML Capability"
description = "Train an ML capability in Highlighter AI, set up capability inputs/outputs, create snapshot datasets, configure and schedule training runs, inspect metrics, and deploy models efficiently."
date = 2024-03-15T08:00:00+00:00
updated = 2024-03-15T08:00:00+00:00
draft = false
weight = 300
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++


## Prerequisites

This tutorial expects you:

  1. You already have labelled data in a Highlighter _Assessment Workflow_
  2. You are using an existing _Model Template_ (ie: Training a model supported by Highlighter Training, not a custom model)
  3. You have the Highlighter CLI installed and configured
  4. Local [Highlighter Credentials](../../reference/sdk/highlighter-credentials.md)

## Training Workflows

Highlighter supports two approaches for training ML capabilities:

### Web UI Workflow
The traditional approach using the Highlighter web interface:
  1. [Create a capability](#create-a-capability-web-ui): Define the inputs/outputs of the capability
  2. [Create datasets](#create-datasets-web-ui): Create an immutable snapshot of the data used to train/test the model
  3. [Configure the training run](#configure-the-training-run-web-ui): Select the type of model you wish to train and configure it
  4. [Schedule training](#schedule-training-web-ui): 
  5. [Inspect training metrics](#inspect-training-metrics-web-ui):
  6. [Deploy the capability](#deploy-the-capability-web-ui)

### CLI Workflow
The streamlined command-line approach:
  1. [Generate training boilerplate](#generate-training-boilerplate): Create training configuration and download datasets
  2. [Start training](#start-training): Execute the training pipeline
  3. [Export and upload](#export-and-upload): Export model and upload with evaluation metrics

---

## CLI Workflow (Recommended)

**Before you start**: You must either have your Highlighter credentials exported
as environment variables, or use the `--profile NAME` option for all `hl` commands.
In the following examples, it is assumed the credentials are exported. See 
[Highlighter Credentials](../../reference/sdk/highlighter-credentials.md) for more
information.

### Generate Training Boilerplate

First, generate the training configuration and download the required datasets:

```bash
hl generate training-run <TRAINING_RUN_ID> <TRAINER_TYPE> [ML_TRAINING_DIR]
```

**Parameters:**
- `TRAINING_RUN_ID`: The ID of your Highlighter Training Run
- `TRAINER_TYPE`: Currently supports `yolo-det|yolo-seg|yolo-cls` for YOLO detection models
- `ML_TRAINING_DIR`: Directory for training files (default: `./ml_training`)

**Example:**
```bash
hl generate training-run 123 yolo-det ./my_training
```

This command will:
- Create the directory structure at `./my_training/123/`
- Download training, dev, and test datasets
- Generate configuration files
- Create boilerplate training scripts

### Start Training

Execute the training pipeline:

```bash
hl train start [TRAINING_RUN_DIR]
```

**Parameters:**
- `TRAINING_RUN_DIR`: Directory containing training configuration (default: current directory)

**Example:**
```bash
cd ./my_training/123
hl train start
```

This command will:
- Load the training configuration
- Prepare datasets for training
- Execute the full training pipeline
- Generate evaluation metrics
- Output metrics in JSON format
- Provide the next command to upload results

### Export and Upload

After training completes, export the model and upload the artefact with metrics:

```bash
hl train export [TRAINING_RUN_DIR] <CHECKPOINT> <CONFIG>
```

**Parameters:**
- `TRAINING_RUN_DIR`: Directory containing training configuration (default: current directory)
- `CHECKPOINT`: Path to the trained model checkpoint file
- `CONFIG`: Path to the YOLO configuration file

**Example:**
```bash
hl train export . runs/detect/train/weights/best.pt runs/detect/train/args.yaml
```

This command will:
- Export the model to the appropriate format
- Create and upload the training artefact to Highlighter
- Evaluate the model and upload metrics
- Provide URLs to view results in Highlighter

### Optional: Standalone Evaluation

You can also evaluate a model checkpoint separately:

```bash
hl train evaluate [TRAINING_RUN_DIR] <CHECKPOINT> <CONFIG> [--create]
```

**Parameters:**
- `--create`: If set, creates the metric results in the Highlighter Research Plan

---

## Web UI Workflow

### Create a Capability (Web UI)

  1. From the **Develop** tab select **Capabilites/Library** and click **New Capability**
  2. Select a **Capability Type**:
    - `DetectorElement`: Locates and classifies objects within an image using a bounding box or polygon. ie: *Locates all cats and dogs in images and classifies the as cat or dog*
    - `BoxClassifierElement`: Performs classification on regions of an image. Typically downstream of a `DetectorElement`. ie: *Given a collection of cat regions produced by the above cat/dog `DetectorElement`, classify if the cat is evil or not*
    - `BoxEmbedderElement`: Similar to `BoxClassifierElement` but returns embeddings for the regions rather than classifications
  3. Give it a name and description
  4. Refer to below for information on each tab:
     - `DetectorElement`:
        - **Interface**:
           - **inputs**: image
           - **outputs**: entities
        - **Parameters**:
           - ToDo
        - **Model Parameters**:
           - All *Head* set to "0" for now
           - Add each output of your capability  to a different *Position*. Must start at 0 and increment by 1
     - `BoxClassifierElement`:
        - **Interface**:
           - **inputs**: image, entities
           - **outputs**: entities
        - **Parameters**:
           - ToDo
        - **Model Parameters**:
           - All *Head* set to "0" for now
           - Add each output of your capability  to a different *Position*. Must start at 0 and increment by 1
     - `BoxEmbedderElement`:
        - **Interface**:
           - **inputs**: image, entities
           - **outputs**: entities
        - **Parameters**:
           - ToDo
        - **Model Parameters**:
           - All *Head* set to "0" for now
           - Add each output of your capability  to a different *Position*. Must start at 0 and increment by 1


### Create Datasets (Web UI)

  1. From the **Develop** tab select **Datasets** and create an empty dataset with a useful name
  2. From the **Develop** tab select **Search**
  3. Check **Only latest submissions**
  4. Use the other fields to search for the desired data
  5. Click **+ Add to Dataset** and select your dataset


### Configure the Training Run (Web UI)

  1. From the **Develop** tab select **Training** then click **Train new model**
  2. Select the **Capability** (Model) whose interface this training run should follow. This will determine the output classes of the trained model and filtering that will be performed on the dataset prior to training.
  3. Name the Training run, select the datasets for each split. _The train set cannot have any overlay with the dev or test set_
    - Train: Used the train the model
    - Dev: Holdout set used to compute the metrics during training
    - Test: [Optional] Additional holdout set typically used to compute metrics for academic reporting.
4. Select the **Model Template**
5. Apply overrides


### Schedule Training (Web UI)

  1. Click **Train**
  2. If training;
    a. Succeeds, you will receive an email with a link to the training metrics and the training run artefact.
    b. Fails, you will receive an email about the failure


### Inspect Training Metrics (Web UI)

View training progress and metrics through the Highlighter web interface.

### Deploy the Capability (Web UI)

Deploy trained capabilities through the Highlighter web interface.



