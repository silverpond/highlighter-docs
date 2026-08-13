+++
title = "Working on the map"
description = "Use the Operations Dashboard map tools to pan and rotate the camera, box-select items, place or draw new entities, and open the current view in the editor."
date = 2026-06-19T08:00:00+00:00
updated = 2026-08-13T08:00:00+00:00
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
  it. Hold **alt** while selecting to add to the current selection instead of
  replacing it. The selected items appear in the
  [Selected Items panel](../selecting-and-acting/).
- **Place point entity (w)** — click on the map to drop a new point entity.
- **Draw polygon entity (e)** — draw a region to create a new entity with that
  shape.
- **Layers (r)** — open the layers pane to manage saved-query
  [layers](../exploring-data/).

Placing or drawing an entity creates it immediately and adds it to your data,
ready to inspect or include in a workflow order.

## Locating items

Opening an item from another surface — a grid card, the entity tree, or a
detail panel — can recentre and zoom the map to that item and briefly pulse its
location so it is easy to spot.

## Opening the current view in the editor

When you zoom in far enough, an **Open in Editor** button appears over the map.
It opens the [Assessment Editor](../../assessing-and-labelling/) loaded with
everything inside the current map view and date range, so you can move straight
from spotting something to assessing or labelling it.
