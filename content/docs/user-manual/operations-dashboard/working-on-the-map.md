+++
title = "Working on the map"
description = "Use the Operations Dashboard map tools to pan and rotate the camera, box-select items, place or draw new entities, and open the current view in the editor."
date = 2026-06-19T08:00:00+00:00
updated = 2026-10-09T08:00:00+00:00
draft = false
weight = 4
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "The map toolbar lets one tool own the map at a time — move the camera, select items, or add entities directly on the map."
toc = true
top = false
+++

The map has a toolbar down its left edge. Only one tool is active at a time;
choosing a tool deactivates the others. Each tool also has a keyboard shortcut.

## Map tools

- **Pan / rotate camera (h)** — the default. Drag to pan; **shift + drag** to
  rotate. Use this to move around and frame an area.
- **Select entities (q)** — drag a rectangle to box-select everything inside
  it. Hold **shift** while selecting to add to the current selection instead of
  replacing it. The selected items appear in the
  [Selected Items panel](../selecting-and-acting/).
- **Place point entity (w)** — click on the map to place a new point entity.
- **Draw polygon entity (e)** — outline a region to create a new entity with
  that shape.
- **Layers (r)** — open the layers pane to manage saved-query
  [layers](../exploring-data/).

## Adding an entity

Entities that have a place in the world — a site, a building, a zone, an asset
— can be added straight onto the map.

1. Choose **Place point entity (w)** and click the entity's position, or choose
   **Draw polygon entity (e)** and click each corner of its outline, then
   **double-click** to finish the shape. A polygon needs at least three
   corners; a status bar at the top of the map counts them as you go.
2. Fill in the **New Entity** card that opens:
   - **Object Class** — what kind of thing the entity is. This decides its
     colour on the map and which workflows can use it.
   - **Name** — how the entity is listed in the hierarchy, cases, and reports.
   - **External ID** and **External ID Type** — optional. Use them when the
     entity is already tracked under an identifier in another system, so the
     two can be matched up.
3. Click **Create**. A confirmation appears and the entity is added to the
   map and the hierarchy, ready to inspect or include in a workflow order.

Press **Esc**, or click **Cancel** in the status bar or the card, to abandon a
shape or an entity you have not yet created. Nothing is saved until you click
**Create**.

A new entity starts at the top level of the hierarchy. To place it under
another entity, see
[Assign a parent entity](../selecting-and-acting/#assign-a-parent-entity).

To change an entity afterwards, open its
[detail panel](../selecting-and-acting/#detail-panels). **Edit** changes its
name, external ID, and parent, and **Set Location** lets you click a new
position for it on the map.

For a worked example that adds a whole site, see
[Setting up a new site for monitoring and reporting](../setting-up-a-new-site/).

## Basemap

Buttons at the bottom left of the map switch the basemap between **Dark**,
**Satellite**, and **Streets**. **Satellite** is the easiest to work from when
you are finding a site by eye or tracing an outline. Satellite imagery is not
live, so something built recently may not appear on it yet.

## Locating items

Opening an item from another surface — a grid card, the entity tree, or a
detail panel — can recentre and zoom the map to that item and briefly pulse its
location so it is easy to spot.

## Opening the current view in the editor

When you zoom in far enough, an **Open in Editor** button appears over the map.
It opens the [Assessment Editor](../../assessing-and-labelling/) loaded with
everything inside the current map view and date range, so you can move straight
from spotting something to assessing or labelling it.
