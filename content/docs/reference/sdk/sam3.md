+++
title = "Segment Anything Model 3 (SAM3)"
description = "Reference documentation for the SAM3 inference capability."
date = 2025-02-11T08:00:00+00:00
updated = 2026-03-30T08:00:00+00:00
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

### Installation

SAM3 requires additional dependencies not included in the base Highlighter SDK. Install them with the `sam3` extra:

```bash
pip install highlighter-sdk[sam3]
```

### Model weights

When running SAM3 locally, there are two ways to obtain the weights:

**Option 1: Download from Highlighter (recommended)**

If you have the Highlighter CLI installed, you can download the weights directly from Highlighter using the SAM3 training-run artefact:

```bash
hl training-run artefact read -u be3fd409-73a2-48b1-81e0-3a2e492f246c -s sam3.pt
```

This downloads the `sam3.pt` weights file to your current directory. You can then reference this path in the `model_path` parameter of your agent configuration.

> **Note:** When using SAM3 as a [built-in capability in the Agent Designer](#using-sam3-in-the-agent-designer), the weights are downloaded automatically via the pre-configured `training_run_artefact_id` — no manual download is required.

**Option 2: Download from Hugging Face**

Alternatively, you can download the weights manually from [Hugging Face](https://huggingface.co/facebook/sam3) (the `sam3.pt` file contains the weights).

## Prompting mechanisms

For detailed guidance on writing more informed prompts for this model, please refer to the [official SAM3 documentation](https://github.com/facebookresearch/sam3).

**Crucially, when used with Highlighter, every single prompt you provide to the capability—whether text or geometric—must be accompanied by an `object_class_id`. The capability must assign an object class to every entity it identifies.**

### Text prompts

You can define text prompts using the capability's `prompts.text` parameter. These text strings are applied automatically to every frame the capability processes. Specifically, each text prompt must provide both the `prompt` string and its corresponding `object_class_id` UUID (see [testing SAM3](#testing-sam3) for structure).

### Dynamic geometric prompts

Geometric prompts are provided as inputs to the capability accompanying the image (rather than set as parameters like text prompts).

To do this, an upstream capability must emit an `Entity` containing an `Observation` (which holds your `object_class_id` as a UUID) and an `Annotation` (which holds the `Polygon`, `MultiPolygon`, or `Point` geometry). You can provide these entities to the capability via inputs named `positive_prompt_entities` and `negative_prompt_entities`, which are used during frame processing to explicitly _include_ or _exclude_ regions.

### Prompt batching and execution

When the SAM3 capability processes a frame, it gathers all of your static text prompts and any dynamic geometric prompts it received from upstream capabilities. 

To run efficiently, it then groups these prompts based on their `object_class_id`. All text descriptions and visual exemplars (boxes/points) that share an `object_class_id` are batched together. The model then performs a single inference pass for that combined concept, ensuring that all your hints work together to find the target object.

## Initialisation and parameters

When configuring SAM3 within a broader agent definition, all parameters to the capability should be qualified inside a `parameters` dictionary. Here are the available options:

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `model_path` | `str` | `None` | The _local_ file path to the SAM3 PyTorch weights (e.g., `weights/sam3.pt`). You must provide either this or a training run artefact ID. |
| `training_run_artefact_id` | `uuid.UUID` | `None` | The UUID of a Highlighter training run artefact if you are downloading weights from HL cloud. |
| `confidence_threshold` | `float` | `0.4` | The minimum confidence score required to retain a detection. |
| `nms_iou_threshold` | `float` | `0.7` | The mask Intersection over Union (IoU) threshold for Non-Maximum Suppression (NMS). If two segmentations overlap by more than this ratio, the segmentation with the lower confidence score is discarded. |
| `max_detections` | `int` | `300` | The maximum number of entities the model will return per frame. |
| `max_image_size` | `int` | `1024` | Input images with their longest side exceeding this value are downscaled before inference to limit GPU memory usage. Masks are resized back to original dimensions afterwards. |
| `prompts` | `object` | `{}` | An object for defining prompts. For static text prompts, use the `text` key with a list of prompt objects, each with a `prompt` (string) and an `object_class_id` (UUID). |

## Resource usage

SAM3 is efficient for its size, but its performance depends heavily on the hardware it is running on. For standard single-image inference, running SAM3 on a GPU with at least 4 GB of VRAM is sufficient. However, for real-time applications or high-throughput batching, a GPU with 8 GB to 11 GB of VRAM (e.g., an NVIDIA GTX 1080 Ti or better) is highly recommended. CPU inference is supported but will be significantly slower. Memory usage scales with the `max_image_size` parameter and the number of simultaneous prompts being processed.

## Using SAM3 in the Agent Designer

SAM3 is available as a **built-in capability** in the Highlighter [Agent Designer](../../user-manual/agents/creating_and_editing_agents/).

### Adding SAM3 to your agent

1. Open the Agent Designer for your Machine Agent (see [How To Create and Edit a Machine Agent](../../user-manual/agents/creating_and_editing_agents/)).
2. Click **Add Capability** in the top right.
3. Under **Built-In Capabilities**, select **SAM3**.

The SAM3 node will appear on the canvas with three input ports and one output port:

| Port | Direction | Description |
| :--- | :--- | :--- |
| `data_samples` | Input | The image frames to process. Connect this to your **Pipeline Inputs**. |
| `positive_prompt_entities` | Input | Optional geometric prompts from an upstream capability to _include_ regions. |
| `negative_prompt_entities` | Input | Optional geometric prompts from an upstream capability to _exclude_ regions. |
| `entities` | Output | The detected segmentation entities. Connect this to **Pipeline Outputs** or a downstream capability. |

### Configuring prompts

The SAM3 node includes an inline prompt configuration widget. To add a text prompt:

1. Use the **Add object class...** dropdown to select an object class from your workflow.
2. The object class is added to the prompt list with a text input field pre-filled with the class name.
3. Edit the text field to customise the prompt description — this is the text the model uses to identify the object (e.g., change "Tree" to "a large deciduous tree with green foliage").
4. To remove a prompt, click the **✕** button next to it.

Prompt changes are saved automatically. Each prompt pairs a text description with an `object_class_id`, which the model uses to label the entities it detects (see [prompting mechanisms](#prompting-mechanisms) for details).

### Model weights

When SAM3 is added as a built-in capability, its deployment parameters are pre-configured with a `training_run_artefact_id` pointing to the hosted SAM3 weights. The SDK will download these weights automatically at runtime.

## Example capability configuration (SDK)

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
    "confidence_threshold": 0.2
  }
}
```

## Testing SAM3

To verify the SAM3 capability locally, you can use the following agent configuration. This example uses a local image as source and writes the output to both a JSON file and a rendered image with the detected polygons overlaid.

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
    "(ImageRead SAM3 EntityRenderFile)"
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
        "confidence_threshold": 0.2
      }
    },
    {
      "name": "EntityRenderFile",
      "input": [
        { "name": "data_samples", "type": "list" },
        { "name": "entities", "type": "dict" }
      ],
      "output": [],
      "deploy": {
        "local": {
          "module": "highlighter.agent.capabilities.targets"
        }
      },
      "parameters": {
        "per_frame_output_file": "data_out/sam3/frame_{task_id}_{frame_id}.json",
        "per_frame_render_file": "data_out/sam3/frame_{task_id}_{frame_id}.jpg",
        "polygon_width": 4,
        "polygon_color": "#00ff00"
      }
    }
  ]
}
```

</details>

### Running the agent

Once saved, you can run the agent locally against one or more images using the Highlighter CLI:

```bash
hl agent start agent.json test_image.png
```

This will process each image and save the results to the `data_out/sam3/` directory: a JSON file containing the raw Highlighter entities and a JPEG with the detected polygons rendered on the source image.

