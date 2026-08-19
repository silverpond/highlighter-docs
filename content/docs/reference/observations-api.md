+++
title = "Observations API"
description = "Retrieve time-ranged observation readings from Highlighter data sources."
date = 2026-08-19T00:00:00+00:00
updated = 2026-08-19T00:00:00+00:00
draft = false
weight = 10
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Retrieve a paginated time series of observations stored by your Highlighter agents."
toc = true
top = false
+++

## Overview

`GET /api/observations.json` returns observation readings recorded in Avro files
for the data sources that your account can view. Use it to retrieve a time series
without first importing those readings into an assessment workflow.

The endpoint returns readings in chronological order. The start of the requested
time range is inclusive and the end is exclusive.

## Authentication

Create an access token from your user profile as described in
[Highlighter SDK Credentials](../sdk/highlighter-credentials/). Send it in the
`Authorization` header using the `Token` scheme. Your user must be allowed to
view the data source.

```bash
export HL_BASE_URL="https://YOUR_ACCOUNT.highlighter.ai"
export HL_API_TOKEN="YOUR_ACCESS_TOKEN"
```

## Request parameters

| Parameter | Required | Description |
| --- | --- | --- |
| `from` | Yes | Inclusive ISO 8601 timestamp. Fractional seconds are supported. |
| `to` | Yes | Exclusive ISO 8601 timestamp, later than `from`. |
| `data_source_uuid[]` | No | Repeat this parameter to restrict results to one or more observation data sources. If omitted, all visible observation data sources are included. |
| `entity_attribute[]` | No | Repeat this parameter to restrict results to one or more entity-attribute names. |
| `limit` | No | Positive integer page size. Defaults to 5,000 and is capped at 50,000. |
| `cursor` | No | Opaque value returned in `next_cursor`. Send it unchanged to retrieve the next page. |

Use the same time range and filters on every request in a paginated sequence.

```bash
curl --get "$HL_BASE_URL/api/observations.json" \
  -H "Authorization: Token $HL_API_TOKEN" \
  --data-urlencode 'from=2026-08-19T00:00:00.000000Z' \
  --data-urlencode 'to=2026-08-19T01:00:00.000000Z' \
  --data-urlencode 'data_source_uuid[]=ef9f5ad6-f1a4-447d-9094-019e89c5e0f4' \
  --data-urlencode 'entity_attribute[]=temperature' \
  --data-urlencode 'limit=1000'
```

## Response and pagination

The response contains an `items` array and a `next_cursor`. A non-null cursor
means another page is available. Pass it as the `cursor` parameter while keeping
the original `from`, `to`, and filters.

```json
{
  "items": [
    {
      "entity_id": "c57e11c2-11ea-42d7-b636-7b634b0212aa",
      "datasource": "Zone 2 Agent",
      "datasource_uuid": "ef9f5ad6-f1a4-447d-9094-019e89c5e0f4",
      "entity_attribute": "temperature",
      "timestamp": "2026-08-19T00:10:00.000Z",
      "value": 22,
      "confidence": 1.0
    }
  ],
  "next_cursor": "MTc3NjU1NzQwMDAwMDAwMDoxMjM6MA"
}
```

Each item has these fields:

| Field | Description |
| --- | --- |
| `entity_id` | Identifier of the entity associated with the reading. |
| `datasource` | Current name of the data source that recorded the reading. |
| `datasource_uuid` | Stable UUID of that data source. |
| `entity_attribute` | Name of the measured attribute. |
| `timestamp` | Reading time in UTC. |
| `value` | Recorded value. An enumerated attribute is returned as its enum value. |
| `confidence` | Confidence recorded with the reading. |

## Limits and errors

The requested time range may span at most 500 observation files. Narrow the
range or filter by `data_source_uuid[]` if the endpoint returns a 400 response
for exceeding that limit.

A 400 response also indicates a missing or malformed time, cursor, or limit.
Authentication and data-source permissions are required. If a selected file
cannot be downloaded or decoded, the endpoint fails rather than returning a
partial page; retry after the storage or file problem is resolved.
