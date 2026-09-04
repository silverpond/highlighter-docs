+++
title = "Case File Export Filtering"
description = "Select case files with a bounded WHERE expression, preview metadata, or download only the matching files."
date = 2026-09-04T08:00:00+00:00
updated = 2026-09-04T08:00:00+00:00
draft = false
weight = 20
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Use the Highlighter CLI or Python SDK to select case files precisely before downloading them."
toc = true
top = false
+++

## Overview

`hl case export` can filter files with a server-owned `--where` expression.
The same selection can be previewed with `--dry-run`, which returns metadata
and size/duration estimates without downloading files or creating an output
directory.

The selection is read-only and account-scoped. It does not modify the case or
generate download URLs during preview.

## Discover the available fields

Run `export-fields` to see the fields, types, operators, and examples supported
by the connected Highlighter server:

```bash
hl case export-fields
```

Use JSON when another program or script will consume the catalog:

```bash
hl case export-fields --format json
```

Version 1 supports these predicates:

| Field | Operators | Example |
| --- | --- | --- |
| `file_id` | `=`, `==` | `file_id = 25900021` |
| `file_uuid` | `=`, `==` | `file_uuid = '22ea3357-1a94-42c5-a4d9-d2ff07a9cd70'` |
| `data_source_id` | `=`, `==` | `data_source_id = 2733` |
| `data_source_uuid` | `=`, `==` | `data_source_uuid = '3d7b98a5-9af8-492f-8f63-5afb4393b883'` |
| `content_type` | `=`, `==` | `content_type = 'VIDEO'` |
| `recorded_period` | `OVERLAPS` | `recorded_period OVERLAPS ('2026-08-06T07:35:00+10:00', '2026-08-06T07:50:00+10:00')` |

Combine predicates with `AND`. Values for `content_type` are case-insensitive;
the canonical form and returned `contentType` use upper-case values such as
`VIDEO`. UUIDs are canonicalized to lower-case.

## Preview a selection

Use `--dry-run` to print matching file metadata without downloading payloads:

```bash
hl case export \
  --id CASE_ID \
  --where "file_id = 25900021 AND content_type = 'VIDEO'" \
  --dry-run
```

The JSON response includes the original and canonical expression, effective
recorded bounds, the selected files, and these totals:

- `totalFiles`
- `knownSizeBytes` and `filesWithUnknownSize`
- `knownDurationSeconds` and `filesWithUnknownDuration`

Each selected file includes metadata such as its ID, UUID, filename, content
type, datasource, recording times, file size, dimensions, frame rate, duration,
and checksum. URLs and original source/storage fields are not returned by this
metadata-only selection.

`--dry-run` requires `--where`. It cannot be combined with `--output-dir`,
`--include-messages`, or `--file-structure`.

## Download a filtered export

Add `--output-dir` when the selection should be downloaded:

```bash
hl case export \
  --id CASE_ID \
  --output-dir ./exports \
  --where "data_source_uuid = '3d7b98a5-9af8-492f-8f63-5afb4393b883' AND content_type = 'VIDEO'"
```

The server resolves the selection before the output directory is created. Only
the matching file UUIDs are downloaded. The export manifest records the
original expression, canonical expression, effective time bounds, and selected
file metadata.

An exact file identity is safe without a recorded period. A datasource
selection needs a finite recorded period, or a complete case occurrence window
of no more than one hour. A recorded period must use timestamps with `Z` or an
explicit UTC offset, and its end must be later than its start.

`--where` cannot be combined with the legacy `--content-type`, `--before`, or
`--after` options. Omit `--where` to use the existing broad case export.

## Python SDK

The Python SDK sends the expression unchanged to the server:

```python
from highlighter.client.case_exports import select_case_files

selection = select_case_files(
    client,
    case_id=case_id,
    where="file_uuid = '22ea3357-1a94-42c5-a4d9-d2ff07a9cd70'",
)

for file in selection.files:
    print(file.uuid, file.content_type, file.file_size)
```

The helper performs only basic transport validation locally. Field validation,
authorization, safety limits, and result limits remain server-owned. The
direct `Case.export(..., where=...)` method uses the same selection and rejects
legacy content-type or time-padding filters instead of silently dropping them.

## Limits and errors

The server limits expressions to 4096 UTF-8 bytes, 64 tokens, 10 predicates,
and 1024 bytes per string literal. A selection returns at most 100 files.

Invalid expressions return a structured `BAD_USER_INPUT` GraphQL error with a
stable error kind and, where applicable, an excerpt with a caret showing the
source location. Common kinds include syntax, unknown-field, invalid-value,
unsafe-window, empty-selection, and too-many-files errors.
