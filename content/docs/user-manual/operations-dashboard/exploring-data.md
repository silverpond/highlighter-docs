+++
title = "Finding the data you need"
description = "Narrow what the Operations Dashboard shows using scopes, a date range and timeline, search filters, saved-query layers, and map viewport filters."
date = 2026-06-19T08:00:00+00:00
updated = 2026-07-27T08:00:00+00:00
draft = false
weight = 3
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Combine scopes, time, search filters, layers, and the map viewport to show exactly the data you care about."
toc = true
top = false
+++

The Map and Grid show a filtered slice of your data. Several controls work
together to narrow that slice.

## Records and entities

Two scope buttons control what the Map and Grid show:

- **Records** — the source media (images, video, and other files) ingested by
  your data sources.
- **Entities** — the objects detected and tracked across that media, coloured
  by object class.

You can show records, entities, or both at once.

## Date range and timeline

- The **date range** picker in the top bar limits results to a time window.
- Opening the **Timeline** strip shows when records and entities occur on two
  tracks. **Drag** the selector to set the date range, use the **wheel** to
  zoom, and **shift + wheel** to scroll through time.

## Search and filters

The **search** bar builds filter pills that narrow results by taxonomy and
attributes — for example `class:` to match an object class or `condition:` to
match an attribute condition. Typing in the search bar also filters the entity
**Hierarchy** panel.

### Jump to a case

Paste a **case ID** (such as `cse_…`) into the search bar to go straight to that
case. Highlighter looks it up and shows the matching case with two actions:

- **Open in Assessment Editor** — open the case for assessing or labelling.
- **Show related records and entities** — filter the dashboard to that case,
  re-centre the map on the case's subject entity, and open that entity's
  [detail panel](../selecting-and-acting/#detail-panels) on the right.

## Layers

Saved queries can be shown as toggleable map **layers**. Open the layers pane
from the map toolbar to enable or hide each layer and adjust its **Layer
settings**, letting you overlay or compare different slices of data.

## Map viewport filters

From the menu, the **Map Viewport Filters** let you restrict other surfaces to
only what is currently inside the map view. You can independently apply the map
viewport to the **grid**, the **hierarchy** (entity tree), **recordings**, the
**timeline**, and **cases** — so panning and zooming the map narrows those
panels too.
