+++
title = "Exporting Workflow Data"
description = "Export workflow data, including case files and CSV results, from Highlighter."
date = 2025-05-01T08:00:00+00:00
updated = 2025-05-01T08:00:00+00:00
draft = false
weight = 20
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

Use the workflow page to export data for an entire workflow or a specific workflow order.

- If you select a workflow order, exports include only that order.
- If no order is selected, exports include all cases in the workflow.

## Navigate to the workflow page

1. Click "Develop" in the top navigation.
2. Click "Workflows" under "Assessments".
3. Open the workflow you want to export.
4. Use the order selector to choose a workflow order (optional).

## Export results as CSV

1. Choose the submissions and layout options.
2. Click "Export CSV".

The CSV export includes assessment results and metadata for the current workflow or selected order.

## Export case files (ZIP)

1. Click "Export Case Files".
2. (Optional) Enter a folder path template.
3. Click "Download Files".

If no template is provided, files are placed at the ZIP root using the default filename pattern:
`<external-id (padded to 12 digits)>_<workflow[-order]-name>_<count>.<ext>`

### Customize the ZIP path

You can control the folder structure inside the ZIP by providing a template. Use Liquid-style
variables like `{{ WORKFLOW_ORDER_NAME }}` and `/` to create folders.

Example:
`{{ WORKFLOW_ORDER_NAME }}/{{ CASE_EXTERNAL_ID }}/{{ FILENAME }}`

Available variables:
- `WORKFLOW_NAME`: Project/workflow name
- `WORKFLOW_ORDER_NAME`: Workflow order name (or workflow name if no order)
- `CASE_ID`: Case database ID
- `CASE_SHORT_ID`: Case short ID
- `CASE_EXTERNAL_ID`: External ID (entity, case, or short ID)
- `CASE_EXTERNAL_ID_PADDED`: External ID zero-padded to 12 digits
- `FILE_UUID`: File unique identifier
- `FILE_COUNT`: File number within the case (1-based)
- `FILE_EXT`: File extension (.jpg, .png, etc.)
- `ORIGINAL_FILENAME`: Original uploaded filename
- `FILENAME`: Default generated filename

Notes:
- Templates only support plain variables. Tags, filters, and `${TOKEN}` syntax are not supported.
- Invalid path characters are sanitized, and unsafe paths (absolute paths or `..`) are rejected.

## Export annotated case files (ZIP)

1. Select a workflow order.
2. Click "Export Annotated Case Files".
3. You will receive an email with a download link when the export is ready.
