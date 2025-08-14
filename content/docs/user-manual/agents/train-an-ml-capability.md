+++
title = "Train an ML Capability"
description = "The following document is a detailed tutorial guiding you through creating a _Capability_ by training an deep learning model using Highlighter"
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

The steps are as follows:

  1. [Create a capability](#create-a-capability): Define the inputs/outputs of the capability
  2. [Create datasets](#create-datasets): Create an immutable snapshot of the data used to train/test the model
  3. [Configure the training run](#configure-the-training-run): Select the type of model you wish to train and configure it
  4. [Schedule training](#schedule-training): 
  5. [Inspect training metrics](#inspect-training-metrics):
  6. [Deploy the capability](#deploy-the-capability)

## Create a Capability

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


## Create datasets

  1. From the **Develop** tab select **Datasets** and create an empty dataset with a useful name
  2. From the **Develop** tab select **Search**
  3. Check **Only latest submissions**
  4. Use the other fields to search for the desired data
  5. Click **+ Add to Dataset** and select your dataset


## Configure the training run

  1. From the **Develop** tab select **Training** then click **Train new model**
  2. Select the **Capability** (Model) whose interface this training run should follow. This will determine the output classes of the trained model and filtering that will be performed on the dataset prior to training.
  3. Name the Training run, select the datasets for each split. _The train set cannot have any overlay with the dev or test set_
    - Train: Used the train the model
    - Dev: Holdout set used to compute the metrics during training
    - Test: [Optional] Additional holdout set typically used to compute metrics for academic reporting.
4. Select the **Model Template**
5. Apply overrides


## Schedule training

  1. Click **Train**
  2. If training;
    a. Succeeds, you will receive an email with a link to the training metrics and the training run artefact.
    b. Fails, you will receive an email about the failure


## Inspect training metrics

## Deploy the capability



