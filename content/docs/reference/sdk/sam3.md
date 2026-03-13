+++
title = "Segment Anything Model 3 (SAM3)"
description = "Reference documentation for the SAM3 inference capability."
date = 2025-02-11T08:00:00+00:00
updated = 2026-03-12T08:00:00+00:00
draft = false
weight = 200
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "A multimodal segmentation capability providing zero-shot identification of objects via text, boxes, and points."
toc = true
top = false
+++

The SAM3 capability allows you to use Meta's Segment Anything Model 3 in your Highlighter agents. It provides an interface for identifying and segmenting objects using a combination of text descriptions, bounding boxes, and point coordinates.

SAM3 is specifically designed for "Promptable Concept Segmentation". This means that you can prompt the model with a text phrase or an image exemplar (a bounding box around an example of an object in the image), and it will segment all other instances of that concept within the frame.

## Prerequisites

SAM3 weights are not bundled with the Highlighter SDK by default due to licensing. To access the weights, you must download them manually from [Hugging Face](https://huggingface.co/facebook/sam3) (the `sam3.pt` file contains the weights).

## Prompting mechanisms

For detailed guidance on writing more informed prompts for this model, please refer to the [official Ultralytics SAM3 documentation](https://docs.ultralytics.com/models/sam-3/).

**Crucially, when used with Highlighter, every single prompt you provide to the capability—whether text or geometric—must be accompanied by an `object_class_id`. Because the capability must assign an object class to every mask it generates, any prompt missing a valid UUID for this ID will be silently discarded, failing to produce segmentation masks.**

### Text prompts

You can define text prompts using the capability's `prompts.text` parameter. These text strings are applied automatically to every frame the capability processes. Specifically, each text prompt must provide both the `prompt` string and its corresponding `object_class_id` UUID (see [testing SAM3](#testing-sam3) for structure).

### Dynamic geometric prompts

Geometric prompts are provided as inputs to the capability accompanying the image (rather than set as parameters like text prompts).

To do this, an upstream capability must emit an `Entity` containing an `Observation` (which holds your `object_class_id` as a UUID) and an `Annotation` (which holds the `Polygon`, `MultiPolygon`, or `Point` geometry). You can provide these entities to the capability via inputs named `positive_prompt_entities` and `negative_prompt_entities`, which are used during frame processing to explicitly _include_ or _exclude_ regions for mask generation.

### Prompt batching and execution

When the SAM3 capability processes a frame, it gathers all of your static text prompts and any dynamic geometric prompts it received from upstream capabilities. 

To run efficiently, it then groups these prompts based on their `object_class_id`. All text descriptions and visual exemplars (boxes/points) that share an `object_class_id` are batched together. The model then performs a single inference pass for that combined concept, ensuring that all your hints work together to find the target object.

## Initialisation and parameters

When configuring SAM3 within a broader agent definition, all parameters to the capability should be qualified inside a `parameters` dictionary. Here are the available options:

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `model_path` | `str` | `None` | The _local_ file path to the SAM3 PyTorch weights (e.g., `weights/sam3.pt`). You must provide either this or a training run artefact ID. |
| `training_run_artefact_id` | `uuid.UUID` | `None` | The UUID of a Highlighter training run artefact if you are downloading weights from HL cloud. |
| `conf` | `float` | `0.4` | The minimum confidence score required to retain a detection. |
| `iou` | `float` | `0.7` | The Intersection over Union (IoU) threshold for Non-Maximum Suppression (NMS). If two masks overlap by more than this ratio, the mask with the lower confidence score is discarded. |
| `max_det` | `int` | `300` | The maximum number of masks the model will return per frame. |
| `max_imgsz` | `int` | `1036` | The upper bound for the longest dimension of the input image. You can use this to ensure that large images are not being compressed before inference. |
| `prompts` | `object` | `{}` | An object for defining prompts. For static text prompts, use the `text` key with a list of prompt objects, each with a `prompt` (string) and an `object_class_id` (UUID). |

## Resource usage

SAM3 is efficient for its size, but its performance depends heavily on the hardware it is running on. For standard single-image inference, running SAM3 on a GPU with at least 4 GB of VRAM is sufficient. However, for real-time applications or high-throughput batching, a GPU with 8 GB to 11 GB of VRAM (e.g., an NVIDIA GTX 1080 Ti or better) is highly recommended. CPU inference is supported but will be significantly slower. Memory usage scales with the `max_imgsz` parameter and the number of simultaneous prompts being processed.

## Example capability configuration

The following JSON snippet demonstrates how to configure the SAM3 capability as a standalone element:

```json
{
  "name": "SAM3",
  "input": [
    { "name": "data_samples", "type": "list" },
    { "name": "entities", "type": "dict" }
  ],
  "output": [
    { "name": "entities", "type": "dict" }
  ],
  "deploy": {
    "local": {
      "module": "highlighter.agent.capabilities.sam3",
      "class_name": "SAM3"
    }
  },
  "parameters": {
    "model_path": "weights/sam3.pt",
    "prompts": {
      "text": [
        {
          "prompt": "leaves",
          "object_class_id": "00000000-0000-0000-0000-000000000000"
        }
      ]
    },
    "conf": 0.2
  }
}
```

## Testing SAM3

To verify the SAM3 capability locally, you can use the following agent configuration. This example uses a local image as source and writes the output to a JSON file.

If you haven't set up the Highlighter SDK, see the [Getting Started guide](../getting-started-with-highlighter-sdk/).

### Example agent definition

<details>
<summary>Save this as <code>agent.json</code>:</summary>

```json
{
  "version": 0,
  "name": "sam3_local",
  "runtime": "python",
  "graph": [
    "(ImageRead SAM3 JsonWrite)"
  ],
  "parameters": {},
  "elements": [
    {
      "name": "ImageRead",
      "input": [
        { "name": "data_samples", "type": "list" },
        { "name": "entities", "type": "dict" }
      ],
      "output": [
        { "name": "data_samples", "type": "list" },
        { "name": "entities", "type": "dict" }
      ],
      "deploy": {
        "local": {
          "module": "highlighter.agent.capabilities.sources",
          "class_name": "ImageDataSource"
        }
      },
      "parameters": {}
    },
    {
      "name": "SAM3",
      "input": [
        { "name": "data_samples", "type": "list" },
        { "name": "entities", "type": "dict" }
      ],
      "output": [
        { "name": "entities", "type": "dict" }
      ],
      "deploy": {
        "local": {
          "module": "highlighter.agent.capabilities.sam3",
          "class_name": "SAM3"
        }
      },
      "parameters": {
        "model_path": "weights/sam3.pt",
        "prompts": {
          "text": [
            {
              "prompt": "leaves",
              "object_class_id": "00000000-0000-0000-0000-000000000000"
            }
          ]
        },
        "conf": 0.2
      }
    },
    {
      "name": "JsonWrite",
      "input": [
        { "name": "data_samples", "type": "list" },
        { "name": "entities", "type": "dict" }
      ],
      "output": [],
      "deploy": {
        "local": {
          "module": "highlighter.agent.capabilities.targets",
          "class_name": "EntityWriteFile"
        }
      },
      "parameters": {
        "per_frame_output_file": "data_out/sam3/frame_{task_id}_{frame_id}.json"
      }
    }
  ]
}
```

</details>

### Running the agent

Once saved, you can run the agent locally against one or more images using the Highlighter CLI.
While your specific environment may require minor adjustments, the following command is designed to accommodate most standard development circumstances:

```bash
hl agent start agent.json path/to/images/*
```

This will process each image and save the results (segmentation masks for "leaves") as JSON files in the `data_out/sam3/` directory (configured via the parameter to the `JsonWrite` capability in the agent definition).
