+++
title = "Selecting and acting on items"
description = "Focus and inspect records, entities, and data sources, gather a multi-selection, and act on it — create a workflow order, merge entities, edit or reparent entities, or work through cases."
date = 2026-06-19T08:00:00+00:00
updated = 2026-08-13T08:00:00+00:00
draft = false
weight = 5
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Click an item to inspect it, gather several into a multi-selection, and act on the whole group."
toc = true
top = false
+++

## Focusing versus selecting

A single **click** on a record, entity, or data source selects and focuses it:
it opens that item's detail panel on the right. Hold
**Shift** while clicking map features, grid cards, or tree rows to add or remove
an item without changing the focused detail. With the Select tool active, drag
a box on the map to select every record, entity, and data source inside it;
hold Shift while starting the drag to add them to your existing selection. Map
clusters remain navigation controls and are not selectable.

Closing a detail panel clears only the focus and leaves the selection intact.
Press **Escape** when no selection drag is active to clear the selection.

A selection holds at most 500 items. A drag that would take you past that is
refused whole — your existing selection stays as it was, and a message tells you
how many items the drag covered. Zoom in or drag a smaller area to stay under
the limit. Nothing is silently dropped, so what the panel lists is always
exactly what you selected.

When more than one item is selected, the **Selected Items** panel appears on the
right. It lists every kind in selection order, shows per-kind counts, and lets
you open or remove individual items, clear the selection, create a workflow
order from selected entities, or merge compatible selected entities. Actions
that cannot use the current selection remain disabled with an explanation.

## Detail panels

The detail panel opens on the right for a **record**, **entity**, or **data
source**. From it you can view and edit the item's details, jump to related
items, locate the item on the map, and — for a data source — open its
**recordings**.

Use **Open in Editor** in a data source's actions menu to open it in the
[Assessment Editor](../../assessing-and-labelling/) with the dashboard's
current date range. An entity's actions menu groups editor links by **Device**
and **Subject** data sources. Choose **Automatic layout** to let Highlighter
arrange the editor, or choose a saved layout by name.

You can reach the same editor views from the **Hierarchy** panel. Right-click
an entity and choose **Open in Editor** for the automatic arrangement, or
**Open in Editor with Layout** followed by a saved layout. These links also
carry the dashboard's current date range into the editor.

## Create a workflow order

With one or more entities selected, **Create workflow order** opens a dialog
that builds an order from the selection. Choose an **Object Class** and a
**Workflow**, and optionally a **Name**. Only the selected entities of the
chosen object class are added as cases, so a mixed selection is filtered down to
the class you pick. See [Managing Workflows](../../managing-workflows/) for what
happens to an order once it is created.

## Merge entities

When two or more entities are really the same thing, **Merge entities** combines
them. A **survivor** is auto-selected (you can change it); annotations on the
other entities are reassigned to the survivor, and the non-survivor entities are
deleted. No entity is renamed. Because the non-survivors are removed, review the
survivor choice before confirming the merge.

## Assign a parent entity

Entities can be organised into a hierarchy — for example, poles grouped under a
site. With one or more entities selected, **Edit entities** opens a dialog
whose **Parent entity** field moves every selected entity under the chosen
parent. An entity that already has a parent is moved under the new one,
together with its own descendants.

You can also **drag a row in the hierarchy tree onto another entity** to move
it under that entity, or **onto the panel's "Entities" header** to remove its
parent and move it back to the top level. If the dragged entity is part of the
current selection, the whole selection moves with it. Targets that can't
accept the drop — the entities' current parent, or the header when they have
no parent — show no drop highlight. While dragging, a label next to the cursor
describes what the drop would do (for example *Move 2 entities under "Site A"*
or *Remove parents*). After the move, the hierarchy tree expands to reveal the
moved entities and scrolls them into view.

To change or clear a single entity's parent instead, open its detail panel and
edit the **Parent** field.

## Cases

The **Cases** panel lists the [cases](../../concepts/assessment-workflow/)
relevant to the current data along with their status, so you can track and work
through the items moving through your workflows without leaving the dashboard.
