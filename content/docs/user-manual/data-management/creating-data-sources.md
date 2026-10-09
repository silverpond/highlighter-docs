+++
title = "Creating Data Sources"
description = "Create and edit data sources in the Highlighter web app, link them to an entity with a default subject, and configure External API data sources with a site URI."
date = 2026-10-09T08:00:00+00:00
updated = 2026-10-09T08:00:00+00:00
draft = false
weight = 5
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "A data source tells Highlighter where a stream or collection of data comes from, and which entity it describes."
toc = true
top = false
+++

A **data source** represents one origin of data: a camera stream, a bucket of
files, a manual upload, or a feed of readings from an external system. Records
are ingested through data sources, and a data source can be linked to the
[entity](../../operations-dashboard/exploring-data/#records-and-entities) it
describes so that its data shows up under that entity on the
[Operations Dashboard](../../operations-dashboard/overview/).

This page covers creating data sources in the web app. To create or update many
at once, or to script it, use the
[Data Source CLI](../../../reference/sdk/data-source-cli/).

## Create a data source

1. Click **Develop** in the top navigation, then **Data Sources** under
   **Media** in the side navigation. From the Operations Dashboard, the
   **Settings** (gear) button in the top bar takes you to the Develop area.
2. Click **New Data Source**.
3. Fill in the fields described below and click **Save Data Source**.

When you are adding a data source that should behave like one you already
have, open the existing one first and copy its settings. Only the name, the
source URI, and the default subject usually differ.

## Fields

| Field | Required | What it is for |
| --- | --- | --- |
| **Name** | Yes | How the data source is listed everywhere. Include the site and area so it can be told apart from its siblings. |
| **Content Type** | Yes | The kind of data it carries — for example image, video, or observation readings. |
| **Source Type** | Yes | Where the data comes from. Further fields appear depending on the choice. |
| **Current Timezone** | Yes | The timezone the data is recorded in. Defaults to your browser's timezone; set it to the timezone of the site. |
| **Enable Uptime Tracking** | No | Tracks whether the data source is delivering data, so gaps are visible. |
| **Serial Number**, **MAC Address**, **Device Serial Number** | No | Identifiers of the physical equipment, used to match data sources to discovered hardware. |
| **Device** | No | The piece of equipment the data comes from. See [Default subject and device](#default-subject-and-device). |
| **Default Subject** | No | The entity this data is about. See [Default subject and device](#default-subject-and-device). |
| **Cloud Credential** | No | Shown to admins. The credential used to read from your own bucket; see [Bring Your Own Cloud Bucket](../bring-your-own-cloud-bucket/). |

The source URI field is shown only for source types that need one, and is
labelled to match — for example **S3 Source URI** or **Site URI**.

## Default subject and device

A data source can be linked to two different entities, and they answer
different questions:

- **Default Subject** is what the data is *about*: the room, building, asset,
  or zone being observed. Set this whenever the data describes one particular
  entity. It is what places the data source under that entity in the
  dashboard's **Hierarchy** panel, and it is how an agent reporting on an
  entity finds the data sources that belong to it and to the entities nested
  beneath it.
- **Device** is the equipment the data comes *from*: a camera, a controller, a
  gateway. Set this when you want to track the equipment itself, for example
  to monitor that it is online. It can be left empty and filled in later.

Both must be entities in the same account as the data source.

The Operations Dashboard's **Hierarchy** panel can list data sources by either
link. Open the logo menu, choose **View**, then **Hierarchy Panel**, and pick
**Show Default Subject Data Sources** or **Show Device Data Sources**. Default
subject is shown unless you change it.

## External API data sources

Use the **External api** source type for readings that an integration pushes
into Highlighter from another system — a building management system, a
process controller, a sensor network — rather than files or video.

The **Site URI** identifies which of those readings belong to this data
source. It has up to three parts separated by `/`:

```
<site>/<location>/<attributes>
```

- **site** — the name of the site, exactly as the integration reports it.
- **location** — the area within the site, exactly as the integration reports
  it.
- **attributes** — optional. One attribute name, or several separated by
  commas, to limit the data source to those readings. Leave this part off to
  include every reading for the location.

For example, `Site 1/Zone A` covers every reading from Zone A at Site 1, while
`Site 1/Zone A/temperature,humidity` covers only its temperature and humidity
readings. The URI must contain at least one `/`.

To make more readings available to anything that uses the data source, add
their attribute names to the list, or remove the attributes part altogether.

The site and location must match the incoming readings character for
character. A data source whose URI has a different spelling, spacing, or
capitalisation saves without error but never matches any data. If a new data
source shows no readings, compare its URI with one that works.

With **Enable Uptime Tracking** on, an External API data source counts as up
while a matching reading has arrived within the last 20 minutes.

## Edit a data source

Open the data source from the **Data Sources** list and click its edit button.
Every field above can be changed, including **Default Subject** — which is how
you move a data source to a different entity if it was attached to the wrong
one.

## Related

- [Setting up a new site for monitoring and reporting](../../operations-dashboard/setting-up-a-new-site/) —
  where data sources fit when adding a site end to end.
- [Data Source CLI](../../../reference/sdk/data-source-cli/) — bulk create,
  import, and export.
- [Observations API](../../../reference/observations-api/) — reading
  observation data back out.
