+++
title = "Exporting Data"
description = "Export assessment workflow data into CSV reports with flexible formatting options including attribute values, confidences, and annotations layouts, and flexible file downloads."
date = 2023-09-26T08:00:00+00:00
updated = 2026-08-10T08:00:00+00:00
draft = false
weight = 50
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = ''
toc = true
top = false
+++

Follow these steps to export assessment workflow data into a report CSV, or to download files.

## Navigate to Export Function

1. Go to the assessment workflow you want to download data from
2. Click the **Admin** tab

## Configure Export Options

The left panel is titled "Export". Choose options for the following fields:

### Assessments
Select the scope of assessments to include in your export:

- **All Assessments**: Export all assessments for each file (e.g., if each file was processed by a machine assessment step and then reviewed by a human, this will include both the machine assessment and the human assessment)
- **Latest Assessments**: Export only the most recent assessment on each file (e.g., this would only include the human assessment if it came after the machine assessment)

### Layout
Choose the data format for your export:

#### Attribute Values and Confidences
- Downloads data in **long format** with one row per attribute value
- Each annotation's location polygon is considered an attribute of that annotation, so it gets its own row
- The entity ID column can be used to group the annotation location and all related attributes
- The confidence of all attributes is included in the confidence column
- More detailed but potentially larger file size

#### Annotations
- Downloads data in **wide format** with one row per annotation and a column for each attribute
- The confidence column only refers to the confidence of the annotation location polygon
- The confidence of other attributes is **not included** in this export format
- More compact but less detailed confidence information

#### Files

- Downloads the original image files as a ZIP archive
- Files are exported with standardized naming: `<external-id (padded to 12 digits)>_<workflow[-order]-name>_<count>.<suffix>`
- Example filename: `000003112442_8492192_1.jpg`
- Does not include annotation data - only the original files
- Useful for archiving or transferring original source files

Selecting **Files** changes the export button to **Export Case Files**. Click it to open the **Export Case Files** dialog, then click **Download Files** to download the ZIP.

##### Customize the ZIP path

In the **Export Case Files** dialog, the **Folder path template (inside ZIP)** field controls the folder structure and filenames inside the ZIP. Use Liquid-style variables and `/` to create folders. Click **Show available variables** to see the list in the dialog.

For example:

`{{ WORKFLOW_ORDER_NAME }}/{{ CASE_EXTERNAL_ID }}/{{ FILENAME }}`

produces entries such as `8492192/3112442/000003112442_8492192_1.jpg`.

The following variables are available:

- `WORKFLOW_NAME`: Project or workflow name
- `WORKFLOW_ORDER_NAME`: Workflow order name, or the workflow name if no order is selected
- `CASE_ID`: Case database ID
- `CASE_SHORT_ID`: Case short ID
- `CASE_EXTERNAL_ID`: Case external ID; if blank, falls back to the case entity's external ID, then the case short ID
- `FILE_UUID`: File unique identifier
- `FILE_COUNT`: File number within the case, starting at 1
- `FILE_EXT`: File extension, such as `.jpg` or `.png`
- `ORIGINAL_FILENAME`: Original uploaded filename
- `FILENAME`: Default generated filename

If the field is left blank, files are placed at the ZIP root using the default filename pattern shown above.

Templates support plain variables only, and only the variables listed above - an unrecognised variable is rejected. Tags (`{% ... %}`), filters (`{{ TOKEN | filter }}`), and `${TOKEN}` syntax are not supported. Invalid path characters are replaced with underscores; unsafe paths, including absolute paths and paths containing `..`, are rejected. When a template is invalid, the download fails with a message explaining what was wrong.

##### Set a default ZIP path template for the workflow

If you always want the same folder structure, save it once for the whole workflow instead of typing it for each export:

1. On the **Admin** tab, find the **Workflow Settings** panel on the right
2. Enter your template in **Default case files ZIP path template**
3. Click **Save Workflow Settings**

The saved template pre-fills the **Folder path template (inside ZIP)** field every time you open the **Export Case Files** dialog, and you can still edit it there to override it for a single export. Leave the setting blank to clear it. The same validation rules apply - an invalid template is rejected with an error message and the previous setting is kept.

#### Annotated Files (select workflow order)

- Downloads image files with annotations visually overlaid/drawn on them
- Requires selecting a specific workflow order from the Order dropdown
- Files are delivered as a ZIP archive via email link when ready
- Shows visual representation of all annotations on each image
- Ideal for review, presentation, or sharing annotated results

### Data Source
- If you have used multiple data sources for the workflow, select one here to filter the export to only include files from a single data source
- Leave blank to include all data sources

### Order
- If you have used multiple workflow orders for the workflow, select one here to filter the export to only include files from a single workflow order
- Leave blank to include all workflow orders

## Export the Data

Click **Export CSV** to download the CSV report of assessments in the workflow.
