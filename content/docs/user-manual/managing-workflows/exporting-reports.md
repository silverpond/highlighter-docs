+++
title = "Exporting Reports"
description = "Export assessment workflow data into CSV reports with flexible formatting options including attribute values, confidences, and annotations layouts."
date = 2023-09-26T08:00:00+00:00
updated = 2023-09-26T08:00:00+00:00
draft = false
weight = 50
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = ''
toc = true
top = false
+++

Follow these steps to export assessment workflow data into a report CSV.

## Navigate to Export Function

1. Go to the assessment workflow you want to download data from
2. Click the **Admin** tab

## Configure Export Options

The left panel is titled "Export". Choose options for the following fields:

### Assessments
Select the scope of assessments to include in your export:

- **All Assessments**: Export all assessments for each file (e.g., if each file was processed by a machine assessment stage and then reviewed by a human, this will include both the machine assessment and the human assessment)
- **Latest Assessments**: Export only the most recent assessment on each file (e.g., this would only include the human assessment if it came after the machine assessment)

### Layout
Choose the data format for your export:

#### Attribute Values and Confidences
- Downloads data in **long format** with one row per attribute value
- Each annotation's location polygon is considered an attribute of that annotation, so it gets its own row
- The entity ID column can be used to group the annotation location and all related attributes
- The confidence of all attributes is included in the confidence column

#### Annotations
- Downloads data in **wide format** with one row per annotation and a column for each attribute
- The confidence column only refers to the confidence of the annotation location polygon
- The confidence of other attributes is **not included** in this export format

#### Files
- Downloads the original image files as a ZIP archive
- Files are exported with standardized naming: `<external-id>_<workflow[-order]-name>_<count>.<suffix>`
- Example filename: `000003112442_8492192_1.jpg`
- Does not include annotation data - only the original files

#### Annotated Files (select workflow order)
- Downloads image files with annotations visually overlaid/drawn on them
- Requires selecting a specific workflow order from the Order dropdown
- Files are delivered as a ZIP archive via email link when ready
- Shows visual representation of all annotations on each image

### Data Source
- If you have used multiple data sources for the workflow, select one here to filter the export to only include files from a single data source
- Leave blank to include all data sources

### Order
- If you have used multiple workflow orders for the workflow, select one here to filter the export to only include files from a single workflow order
- Leave blank to include all workflow orders

## Export the Data

Click **Export CSV** to download the CSV report of assessments in the workflow.

## Export Format Notes

**Long Format (Attribute Values and Confidences):**
- One row per attribute value
- Entity ID column groups related attributes
- Includes confidence for all attributes
- More detailed but potentially larger file size

**Wide Format (Annotations):**
- One row per annotation
- Column for each attribute
- Only location polygon confidence included
- More compact but less detailed confidence information

**Files Export:**
- ZIP archive containing original image files only
- Standardized filename format for easy organization
- No annotation data included
- Useful for archiving or transferring original source files

**Annotated Files Export:**
- ZIP archive delivered via email
- Visual annotations overlaid on original images
- Requires workflow order selection for proper context
- Ideal for review, presentation, or sharing annotated results