+++
title = "Selecting and acting on items"
description = "Focus and inspect records, entities, and data sources, gather a multi-selection, and act on it — create a workflow order, merge entities, or work through cases."
date = 2026-06-19T08:00:00+00:00
updated = 2026-07-13T08:00:00+00:00
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

A single **click** on a record or entity *focuses* it: it opens that item's
detail panel on the right. *Selecting* is separate — you build a
**multi-selection** by box-selecting on the map, shift-clicking grid cards or tree
rows, or adding items one at a time. Closing a detail panel clears the focus but
leaves your selection intact.

When more than one item is selected, the **Selected Items** panel appears on the
right listing each item, and the status bar shows how many entities, records,
and data sources are selected.

## Detail panels

The detail panel opens on the right for a **record**, **entity**, or **data
source**. From it you can view and edit the item's details, jump to related
items, locate the item on the map, and — for a data source — open its
**recordings**.

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

## Cases

The **Cases** panel lists the [cases](../../concepts/assessment-workflow/)
relevant to the current data along with their status, so you can track and work
through the items moving through your workflows without leaving the dashboard.
