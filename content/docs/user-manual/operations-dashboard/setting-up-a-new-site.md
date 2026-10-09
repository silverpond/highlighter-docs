+++
title = "Setting up a new site for monitoring and reporting"
description = "Step-by-step guide to adding a new site to the Operations Dashboard: draw its entities on the map, nest them in the hierarchy, connect data sources, and add the site to a daily scheduled workflow order."
date = 2026-10-09T08:00:00+00:00
updated = 2026-10-09T08:00:00+00:00
draft = false
weight = 6
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Add a new site, its sub-areas, and their data sources, then include the site in a daily report — all from the web app."
toc = true
top = false
+++

This guide walks through everything needed to bring a new physical site — a
facility, a depot, a plant, a property — into Highlighter so that it appears on
the Operations Dashboard and is included in scheduled reporting. It assumes the
account already has at least one site set up the same way, with a workflow that
produces the report. If you are starting from nothing, see
[Creating Assessment Workflows](../../managing-workflows/creating-assessment-workflows/)
first.

The steps are:

1. [Draw the site on the map](#1-draw-the-site-on-the-map)
2. [Draw the areas inside it](#2-draw-the-areas-inside-the-site)
3. [Nest the areas under the site](#3-nest-the-areas-under-the-site)
4. [Create a data source for each area](#4-create-a-data-source-for-each-area)
5. [Check the hierarchy](#5-check-the-hierarchy)
6. [Add the site to the daily schedule](#6-add-the-site-to-the-daily-schedule)
7. [Run a report now](#7-run-a-report-now-optional)
8. [Review the result](#8-review-the-result)

## Before you start

Have these to hand:

- **Where the site is.** You will find it on the map by eye, so know its
  neighbours or have coordinates ready.
- **The names you will use.** Decide the site name and the names of its areas
  before creating anything. The same names are used in the hierarchy, in
  reports, and often in the system the data comes from, so a name that differs
  between them is awkward to correct later. If a site is likely to be renamed
  or renumbered, settle that first.
- **The object classes.** The site and its areas each need an
  [object class](../../managing-workflows/workflow-taxonomy-management/) — for
  example one class for sites and another for the buildings or zones inside
  them. Use the same classes as your existing sites.
- **How the data arrives.** For each area, know which external feed, camera, or
  bucket provides its data. For an external feed, the data must already be
  flowing into Highlighter under a known site and location name.

## 1. Draw the site on the map

1. Open **Operate** in the top navigation to reach the Operations Dashboard,
   and switch to the **Map** view.
2. Pan and zoom to the site. Existing sites are drawn as coloured shapes; hover
   or click one to see which it is. Switching the basemap to **Satellite**
   (bottom left of the map) makes it much easier to find the right spot.
3. Choose **Draw polygon entity (e)** in the map toolbar.
4. Click each corner of the site boundary, then **double-click** to finish.
5. In the **New Entity** card, choose the site's **Object Class**, enter its
   **Name**, and click **Create**.

See [Adding an entity](../working-on-the-map/#adding-an-entity) for the card's
fields and how to cancel a shape. If the site is too new to show on the
[satellite imagery](../working-on-the-map/#basemap), draw an approximate
boundary from its neighbours; it only needs to be good enough to find and
select the site.

## 2. Draw the areas inside the site

Repeat the same steps for each area inside the site that you want reported on
separately — each building, zone, or line. Zoom in first so the shapes are
easy to place, and choose the object class used for areas rather than the one
used for sites.

Create these area entities even when no cameras are installed there yet. If a
report should comment on each area separately, each area needs its own entity
for its data to hang from.

## 3. Nest the areas under the site

New entities are created at the top level of the hierarchy. Move each area
under its site so the site and its areas are treated as one group:

- Open the **Hierarchy** panel and drag each area's row onto the site's row, or
- Select all of the areas (hold **Shift** while clicking), choose
  **Edit entities** in the **Selected Items** panel, and set **Parent entity**
  to the site.

See [Assign a parent entity](../selecting-and-acting/#assign-a-parent-entity).

This is a good moment to check your existing sites too. Areas that were never
nested under their site still sit at the top level of the hierarchy and can be
dragged into place the same way.

## 4. Create a data source for each area

A [data source](../../data-management/creating-data-sources/) tells Highlighter
where an area's data comes from. Create one for each area:

1. Click the **Settings** (gear) button in the Operations Dashboard top bar to
   reach the **Develop** area, then click **Data Sources** under **Media** in
   the side navigation.
2. Open the data source of an equivalent area at an existing site and note its
   settings. Copying a working example is the most reliable way to get a new
   one right.
3. Click **New Data Source** and fill it in to match, changing the **Name**,
   the source URI, and the **Default Subject**.
4. Set **Default Subject** to the area entity you drew in step 2. This is what
   links the data to the area.
5. Click **Save Data Source**, and repeat for the remaining areas.

For data read from an external feed, such as sensor or controller readings,
set **Source Type** to **External api** and enter a **Site URI** — see
[External API data sources](../../data-management/creating-data-sources/#external-api-data-sources)
for its format.

The **Device** field is optional and can be filled in later. It is not needed
for reporting; see
[Default subject and device](../../data-management/creating-data-sources/#default-subject-and-device).

## 5. Check the hierarchy

Back on the Operations Dashboard, open the **Hierarchy** panel and expand the
new site. Each area should be listed under the site, and each data source
under its area.

If the data sources are missing, make sure the panel is showing default
subject data sources — see
[Default subject and device](../../data-management/creating-data-sources/#default-subject-and-device).
If a data source appears under the wrong area, edit it and correct its
**Default Subject**.

This check matters because a report for the site only sees the data sources
nested beneath it.

## 6. Add the site to the daily schedule

1. Click the **Settings** (gear) button, open the workflow that produces the
   report, and click its **Orders** tab.
2. Open the order that carries the daily schedule.
3. Scroll down to **Scheduled Case Creation**.
4. In **Entities**, search for and select the new site. A row for the site
   appears below, where you can choose its data sources.
5. Click **Save schedule**.

From the next run, the site gets its own case every night, covering the
previous calendar day. See
[Schedule Daily Cases](../../managing-workflows/managing-workflow-orders/#schedule-daily-cases)
for exactly when cases are created, and
[Add or Remove an Entity](../../managing-workflows/managing-workflow-orders/#add-or-remove-an-entity)
for taking a site off the schedule between production runs.

## 7. Run a report now (optional)

The schedule first runs at the next midnight. To see a result sooner, create a
case for the site by hand:

1. On the Operations Dashboard, hold **Shift** and click the site and one of
   its areas, then choose **Create workflow order** with the site's
   **Object Class** and the reporting **Workflow**. The area is only there to
   open the action and is left out of the order; see
   [Create a workflow order](../selecting-and-acting/#create-a-workflow-order).
2. Open the new order from the workflow's **Orders** tab and click
   **Mark Ready** on its case. Cases created this way start as drafts, so
   nothing runs until you do.

A machine step that analyses a full day of data can take several minutes. The
case's progress through each step is shown on the order page — refresh it to
see the latest state.

Orders are only a way of grouping cases. You can keep every site in one order
or use one order per site; choose whichever makes the cases easiest to find.

## 8. Review the result

Open the case in the Assessment Editor with the pencil (**Assess Case**) button
on its row of the order page, or from the **Cases** panel on the Operations
Dashboard: click the case there, then its name in the detail panel.

- **The report.** Files the agent produces, such as a written report, are
  attached to the case and listed with the case's other files. Refresh the
  page if the agent finished after you opened the case.
- **The chat.** Switch the view selector at the top left of the editor pane
  from **Editor** to **Chat** to see what the agent did and to ask follow-up
  questions. Mention an agent with `@` to direct a question to it.
  While the agent is replying, the chat shows *Assistant is working…*; a
  detailed answer can take a few minutes.

A first report for a new site is the best test of the setup. Read it for
statements about **missing data** before reading anything else — see below.

## Troubleshooting

**The report says data is missing for an area.** Work through these in order:

1. Is there a data source for that area, and is the area its
   **Default Subject**? ([Step 5](#5-check-the-hierarchy).)
2. Does the data source's URI name the site and location exactly as the
   incoming data does, including spelling, spacing, and capitalisation?
3. Was the data arriving for the whole period the report covers? A feed that
   was connected partway through a day only has data from that point on, so
   the first day's report is often incomplete. Earlier history is not always
   loaded when a feed is first connected.

**Nothing happened after creating an order.** The case is still a draft; click
**Mark Ready** on it ([step 7](#7-run-a-report-now-optional)).

**No case was created overnight.** Check the conditions in
[Schedule Daily Cases](../../managing-workflows/managing-workflow-orders/#schedule-daily-cases):
the order must be approved and the site listed under
**Scheduled Case Creation**.

**The site was created under the wrong name.** Rename the entity from its
detail panel: click **Actions** (**⋯**), then **Edit**. If the incoming data is
also labelled with the old name, the feed's configuration and the data source
URIs need to change to match; contact
[Highlighter support](../../../about/support/) to rename data that has already
been stored.

**You want reports for days that have already passed.** See
[Cases for Earlier Days](../../managing-workflows/managing-workflow-orders/#cases-for-earlier-days).
Ask for one case per day rather than one covering the whole period, so each
day's data sits beside its own assessment.

## Related

- [Working on the map](../working-on-the-map/) — the drawing tools in detail.
- [Creating data sources](../../data-management/creating-data-sources/) — every
  field on the data source form.
- [Managing Workflow Orders](../../managing-workflows/managing-workflow-orders/) —
  approving orders, marking cases ready, and scheduling.
