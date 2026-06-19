+++
title = "Map, grid, and dashboard views"
description = "The three ways the Operations Dashboard shows your data — an interactive map, a grid of thumbnails, and a summary dashboard of tiles and worklists."
date = 2026-06-19T08:00:00+00:00
updated = 2026-06-19T08:00:00+00:00
draft = false
weight = 2
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Switch the main area between a map, a grid of thumbnails, and a summary dashboard — three views of the same underlying data."
toc = true
top = false
+++

The buttons at the top of the page switch the main area between three views.
The **Map** and **Grid** buttons sit with the view tools on the right; the
**Dashboard** button sits on the left next to the scope buttons. The Map and
Grid show the same filtered results — the
[scopes and filters](../exploring-data/) you choose apply to both.

## Map view

The Map plots geolocated **records** and detected **entities** on an
interactive map. Entities are coloured by their object class, so you can read
the spread of classes at a glance.

- **Click** a marker to focus that item and open its
  [detail panel](../selecting-and-acting/).
- **Hover** a marker for a quick preview.
- A tile-loading indicator shows while map imagery streams in.
- The map toolbar lets you pan, box-select, and place or draw entities — see
  [Working on the map](../working-on-the-map/).

## Grid view

The Grid shows the same results as a wall of thumbnail cards — a **Detection
Gallery** for entities, or a **Records Gallery** for records. It is the quickest way
to scan previews and pick items visually. The result count is shown in the
header.

- **Entity cards** show the entity name and its object class with a colour dot.
- **Record cards** show the title and content type.
- **Click** a card to focus it and open its detail panel; **double-click** a
  record to open it.
- Selected cards are marked with a tick. You can add cards to a
  [multi-selection](../selecting-and-acting/) without opening them.
- If nothing matches, the grid explains whether the query returned no results
  or failed.

## Dashboard view

The Dashboard is an at-a-glance summary of recent activity and the work waiting
for you. A **Refresh** control re-reads the latest figures.

**Summary tiles** across the top cover recent activity, for example:

- **Files uploaded** in the last 90 days.
- **Assessments** in the last 90 days, split into Total, Human, and Machine.
- **Tasks created** in the last 90 days, with Succeeded, Failed, and Active
  Agents.
- **Inventory** — Objects Tracked, Training Runs, Object Classes, and
  Capabilities.

**Worklists** below the tiles help you pick up work:

- **My Assessment Tasks** — your queues, with the number of tasks available and
  a **Start Task** action.
- **Outstanding Human Assessments** — by process and step, showing the agents
  assigned and progress.
- **Machine Assessments** — active machine work by process and step, with task,
  pending, and running counts.
