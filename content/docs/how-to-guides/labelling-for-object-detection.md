+++
title = "Labelling for Object Detection"
description = "Labelling for Object Detection in Highlighter"
date = 2023-09-26T08:00:00+00:00
updated = 2023-09-26T08:00:00+00:00
draft = false
weight = 10
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

When training an object detection model, you will often need to do some labelling first. This guide covers some of the features common to labelling for object detection.

- <a href="#navigate-to-the-assessment-editor">Navigate To The Assessment Editor</a>

## Navigate To The Assessment Editor

When you first log in to Highlighter, you should see your assessment dashboard. If not, click the 'Assess' link in the top navigation. Click the button in the main pane that says 'Start Task' or 'Continue Task'. This will take you to the Assessment Editor to start work. You will see this button if you have been assigned a work queue. If you don't see it, please contact your Highlighter project manager.

## Drawing a Bounding Box

1. Select the Bounding Box tool. *Todo, add image of icon*
...

## Best Practices
- **Consistency**: Use the same criteria for labeling across all images (e.g., include only fully visible objects).
- **Accuracy**: Ensure bounding boxes are precise and labels are correct.
- **Clarity**: If an object is ambiguous, consult the provided guidelines or a supervisor.
- **Efficiency**: Work systematically, but prioritize quality over speed.

## Common Issues to Avoid
- **Loose Bounding Boxes**: Boxes should be snug, not oversized.
- **Incorrect Labels**: Verify the class before saving.
- **Missing Objects**: Ensure no objects from the class list are overlooked.
- **Duplicate Boxes**: Avoid labeling the same object twice.
