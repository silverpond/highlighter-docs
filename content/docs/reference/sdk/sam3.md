+++
title = "Segment Anything Model 3 (SAM3)"
description = "Reference documentation for the SAM3 inference capability."
date = 2025-03-11T08:00:00+00:00
updated = 2025-03-11T08:00:00+00:00
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

SAM3 weights are not bundled with the Highlighter SDK by default due to licensing. To access the weights, you must download them manually from [Hugging Face](https://huggingface.co/facebook/sam3) (e.g., `sam3.pt`).

## Prompting mechanisms

For detailed guidance on writing more informed prompts for this model, please refer to the [official Ultralytics SAM3 documentation](https://docs.ultralytics.com/models/sam-3/).

**Crucially, every single prompt you provide to the capability—whether text or geometric—must be accompanied by an `object_class_id`. Because the capability must assign an object class to every mask it generates, any prompt missing a valid UUID for this ID will be silently discarded, failing to produce segmentation masks.**

### Static text prompts

You can define text concepts statically using the capability's `prompts.text` parameter. These text strings are applied automatically to every frame the capability processes. Specifically, each text prompt must provide both the `prompt` string and its corresponding `object_class_id` UUID (see [example capability configuration](#example-capability-configuration) for structure).

### Dynamic geometric prompts

Static geometric prompts are forbidden in the capability configuration. Because each frame is assumed to be an arbitrary image, hardcoding the same bounding box or point prompt for every frame is not supported. Therefore, boxes and points must be provided dynamically. 

To do this, an upstream capability must emit an `Entity` containing an `Observation` (which holds your `object_class_id` as a UUID) and an `Annotation` (which holds the `Polygon`, `MultiPolygon`, or `Point` geometry). You can provide these entities to the capability via inputs named `positive_prompt_entities` and `negative_prompt_entities`, which are used during frame processing to explicitly _include_ or _exclude_ regions for mask generation.

### Prompt batching and execution

When the SAM3 capability processes a frame, it gathers all of your static text prompts and any dynamic geometric prompts it received from upstream capabilities. 

To run efficiently, it then groups these prompts based on their `object_class_id`. All text descriptions and visual exemplars (boxes/points) that share an `object_class_id` are batched together. The model then performs a single inference pass for that combined concept, ensuring that all your hints work together to find the target object.

## Initialisation and parameters

When configurating SAM3 within a broader agent definition, all parameters to the capability should be qualified inside a `parameters` dictionary. Here are the available options:

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `model_path` | `str` | `None` | The _local_ file path to the SAM3 PyTorch weights (e.g., `weights/sam3.pt`). You must provide either this or a training run artefact ID. |
| `training_run_artefact_id` | `uuid.UUID` | `None` | The UUID of a Highlighter training run artefact if you are downloading weights from HL cloud. |
| `conf` | `float` | `0.4` | The minimum confidence score required to retain a detection. |
| `iou` | `float` | `0.7` | The Intersection over Union (IoU) threshold for Non-Maximum Suppression (NMS). If two masks overlap by more than this ratio, the mask with the lower confidence score is discarded. |
| `max_det` | `int` | `300` | The maximum number of masks the model will return per frame. |
| `max_imgsz` | `int` | `1036` | The upper bound for the longest dimension of the input image. You can use this to ensure that large images are not being compressed before inference. |
| `prompts` | `SAM3Prompts` | `[]` | A list of text concepts to detect. Each item requires a `prompt` (string) and an `object_class_id` (UUID). |

## Example capability configuration

The following JSON snippet demonstrates the capability configuration for SAM3. This block represents a single pipeline element that you would include within an agent definition. Both initialisation and runtime parameters are passed inside the capability's `parameters` dictionary.

```json
{
  "name": "SAM3",
  "input": [
    {
      "name": "data_samples",
      "type": "list"
    },
    {
      "name": "positive_prompt_entities",
      "type": "dict"
    },
    {
      "name": "negative_prompt_entities",
      "type": "dict"
    }
  ],
  "output": [
    {
      "name": "entities",
      "type": "dict"
    }
  ],
  "deploy": {
    "local": {
      "module": "highlighter.agent.capabilities.sam3",
      "class_name": "SAM3"
    }
  },
  "parameters": {
    "model_path": "sam3.pt",
    "conf": 0.45,
    "iou": 0.6,
    "max_det": 100,
    "prompts": {
      "text": [
        {
          "prompt": "person",
          "object_class_id": "123e4567-e89b-12d3-a456-426614174000"
        },
        {
          "prompt": "vehicle",
          "object_class_id": "987e6543-e21b-34c5-b678-426614174111"
        }
      ]
    }
  }
}
```

When deployed within your agent definition, this configuration will prompt SAM3 to produce segmentation masks for all "person"-s and "vehicle"-s on every image received.
