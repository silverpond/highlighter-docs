+++
title = "Coordinate Systems for Imported Entities"
description = "Tell Highlighter which coordinate reference system your KML, Shapefile, or CSV coordinates are in, so imported entities land in the right place."
date = 2026-09-01T00:00:00+00:00
updated = 2026-09-01T00:00:00+00:00
draft = false
weight = 50
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "A latitude and longitude only means something once you know which coordinate reference system it was measured in. Highlighter asks you, because your file will not say."
toc = true
top = false
+++

## Why Highlighter asks

A pair of numbers like `152.974695, -27.496579` is not a position on its own. It is
a position *in a particular coordinate reference system* (CRS) — a model of the
Earth's shape, and a datum fixing that model to the ground. The same two numbers in
two different systems can be metres apart.

The catch is that most exchange formats do not record which system they used:

- **KML** is specified as WGS84, but plenty of real exports are not. Queensland's
  QSpatial asset register, for example, exports GDA94 in a `.kml` — a perfectly
  ordinary file with no hint that its numbers mean something different.
- **CSV** columns of degrees carry no system at all.
- **Shapefiles** are the exception: they ship a `.prj` sidecar that states it.

If Highlighter guesses wrong, nothing fails. The import succeeds, the entities
appear on the map, and every one of them is quietly in the wrong place. So when you
import entity coordinates, you tell Highlighter what the file holds.

## Where to set it

Every import path takes an **EPSG code** — the standard numeric identifier for a
coordinate reference system. Leaving it blank means **4326 (WGS84)**, which keeps
existing imports behaving as they always have. That default is there for
compatibility; it is not Highlighter's opinion about your file.

### KML and Shapefile imports in a workflow

Set it once on the **task definition** that drives the import step:

1. Go to **Develop → Task Definitions** and create or edit a task definition.
2. Choose the task type — `KmlToEntity::EntityDetection` or
   `DbfToEntity::EntityDetection`.
3. Fill in **Source Coordinate System (EPSG)**.

Every import that runs through that step then reads its coordinates in that system.

### Shapefiles: upload the `.prj` and skip the guesswork

If you upload a shapefile's `.prj` sidecar alongside its `.dbf`, Highlighter reads
the coordinate system straight out of it and ignores the task definition's setting.
The two files must share a base name — `poles.dbf` and `poles.prj` — so that a
submission carrying several shapefiles matches each to its own sidecar.

Highlighter uses the *geographic* system named in the `.prj` (its `GEOGCS` or
`GEOGCRS` entry), because the importer reads degrees out of the attribute columns
rather than from the projected geometry. Both WKT dialects are understood.

If the `.prj` names a system Highlighter does not recognise, the import **stops with
an error** rather than falling back to WGS84. Send the file to your Highlighter
contact and the system can be added.

### Importing a KML from an object class page

1. Open **Entities**, choose your object class, and select the **Admin** tab.
2. Under **Import**, set the **External ID Type**, set **Source Coordinate System
   (EPSG)**, and choose your `.kml` file.

### Bulk-creating cases from a CSV

The bulk case CSV can carry `entity_gps_latitude` and `entity_gps_longitude`
columns. In the upload dialog, set **GPS coordinate system (EPSG)** to whatever
those columns are in.

### From the CLI

`hl task-definition create` takes `--entity-source-srid`:

```bash
hl --profile myaccount task-definition create \
  --name "Import Pole Entities" \
  --task-type "KmlToEntity::EntityDetection" \
  --object-class-id <OBJECT_CLASS_UUID> \
  --entity-external-id-type "Pole" \
  --entity-external-id-field-name "SITE_LABEL" \
  --entity-source-srid 4283
```

`hl task-definition list` shows `source_srid` for any definition that sets one.

### From the API

The `createEntity`, `updateEntity`, and `bulkUpdateEntities` mutations take a
`coordinatesSrid` argument alongside `coordinates`:

```graphql
mutation {
  createEntity(
    name: "Pole 10191760"
    coordinates: "POINT(152.974695 -27.496579)"
    coordinatesSrid: 4283
  ) {
    entity { id }
    errors
  }
}
```

`createTaskDefinition` takes `entitySourceSrid` for the same purpose.

## Common EPSG codes

| Code | System | Where it is used |
|---|---|---|
| `4326` | WGS84 | The global default, and what most GPS devices report |
| `4283` | GDA94 | Australia, pre-2020 survey data and asset registers |
| `7844` | GDA2020 | Australia, current national datum |
| `4269` | NAD83 | United States and Canada |
| `4258` | ETRS89 | Europe |
| `4167` | NZGD2000 | New Zealand |

If you do not know which one your file uses, ask whoever produced it. It is worth
the email — see below for what it costs to guess.

## How to tell when coordinates are in the wrong system

A wrong coordinate system does not look like corruption. It looks like everything
being slightly, consistently, wrong:

- Entities sit a **constant distance and bearing** from where they should be — the
  same offset across the whole dataset, not scattered noise.
- The offset is small enough to look like GPS error but too consistent to be it.
  Reading Australian GDA94 data as WGS84 puts everything about **1.5 metres**
  north-east of the truth.
- **Geolocation case matching** starts missing files, or matching them to a
  neighbouring asset, because the search radius is measured from the wrong centre.
- Distances and areas calculated between entities are subtly off.

If you see a fixed offset like this in already-imported data, the fix is a one-off
correction rather than a re-import — contact your Highlighter representative, who
will need to know which system the original file was in.

## What Highlighter stores

Imported coordinates are converted on the way in and stored in one consistent
system, so entities from different sources can be compared and searched together.
That system is the current national datum for your region — GDA2020 in Australia,
and its equivalents elsewhere — which for practical purposes matches what a modern
GPS receiver reports.

You do not need to convert anything yourself. Declare what your file holds, and
Highlighter does the rest.
