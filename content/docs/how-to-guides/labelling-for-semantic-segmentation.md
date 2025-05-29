+++
title = "Labelling for Semantic Segmentation"
description = "Labelling for Semantic Segmentation in Highlighter"
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

When training a semantic segmentation model, you will often need to do some labelling first. This guide covers some of the features common to labelling for semantic segmentation.

- <a href="#navigate-to-the-assessment-editor">Navigate To The Assessment Editor</a>
- <a href="#draw-a-polygon">Draw A Polygon</a>
- <a href="#use-best-practices">Use Best Practices</a>
- <a href="#avoid-common-issues">Avoid Common Issues</a>

## Navigate To The Assessment Editor

When you first log in to Highlighter, you should see your assessment dashboard. If not, click the 'Assess' link in the top navigation. Click the button in the main pane that says 'Start Task' or 'Continue Task'. This will take you to the Assessment Editor to start work. You will see this button if you have been assigned a work queue. If you don't see it, please contact your Highlighter project manager.

## Draw a Polygon

1. Select the Polygon tool. ![Polygon tool](../polygon-tool.png)

## Use Best Practices
- **Precision**: Trace object boundaries as accurately as possible to avoid mislabeled pixels.
- **Consistency**: Apply the same labeling criteria across all images (e.g., consistent class definitions).
- **Clarity**: Consult guidelines or a supervisor for ambiguous regions or objects.
- **Efficiency**: Work systematically, prioritizing quality over speed.

## Avoid Common Issues
- **Inaccurate Boundaries**: Ensure masks align with object edges, avoiding gaps or overlaps.
- **Incorrect Labels**: Verify the class for each region before saving.
- **Missed Regions**: Ensure no objects or areas from the class list are overlooked.
- **Overlapping Masks**: Avoid assigning multiple classes to the same pixel unless specified.
