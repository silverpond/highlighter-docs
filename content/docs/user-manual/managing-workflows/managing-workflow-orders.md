+++
title = "Managing Workflow Orders"
description = "Approve or return Workflow Orders to draft, mark Cases ready or draft, schedule daily Cases, and duplicate an existing Order in Highlighter AI."
date = 2026-07-28T08:00:00+00:00
updated = 2026-09-23T08:00:00+00:00
draft = false
weight = 12
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = ''
toc = true
top = false
+++

Once a Workflow Order exists you can manage its lifecycle and that of its Cases from the 'Orders' tab of your Workflow and from the Order's own page. This covers approving an Order (and returning it to draft), marking individual Cases ready (and back to draft), scheduling daily Cases for chosen entities, and duplicating an Order.

- <a href="#order-and-case-states">Order and Case States</a>
- <a href="#approve-or-return-an-order-to-draft">Approve or Return an Order to Draft</a>
- <a href="#mark-a-case-ready-or-draft">Mark a Case Ready or Draft</a>
- <a href="#schedule-daily-cases">Schedule Daily Cases</a>
- <a href="#duplicate-a-workflow-order">Duplicate a Workflow Order</a>

## Order and Case States

A Workflow Order is either **draft** or **approved**. Draft is a work-in-progress state you can keep editing; approving an Order marks it as finished and records who approved it and when.

Within an Order, each Case is either **draft** or **ready** (among other processing states). A draft Case is not yet released for work; marking a Case ready releases it into the Workflow's steps so it can be assessed.

## Approve or Return an Order to Draft

Open the Order's page. If the Order is in draft, click **Approve** to move it to the approved state. If the Order is approved, click **Mark Draft** to return it to draft and clear the recorded approval.

Approving or returning an Order to draft is a governance action on the Order itself — it does not on its own release Cases for work or pull them back. To withdraw a specific Case from work, mark that Case draft (see below).

## Mark a Case Ready or Draft

On the Order's page, each Case row has a button reflecting its current state:

- **Mark Ready** — releases a draft Case into the Workflow's steps so it can be assessed.
- **Mark Draft** — returns a ready Case to draft and withdraws it from work, so it no longer appears as available to assess. Marking the Case ready again re-releases it.

## Schedule Daily Cases

An Order can create a new Case for each of a set of entities every day. For example, you can use it for a daily inspection of the same sites or assets.

1. Open the Order's page and find the **Scheduled Case Creation** section.
2. In **Entities**, search for and select the entities that should get a daily Case.
3. Click **Save schedule**. The page confirms *Scheduled case creation updated.*

Each night at midnight (Melbourne time), Highlighter creates one Case for each selected entity, marks it **ready**, and releases it into the Workflow's steps so it can be assessed. The new Cases appear in the Order's list of Cases like any other.

- The schedule runs only while the Order is approved (or processing). While the Order is in draft, nothing is created, and missed days are not made up later.
- Each entity gets at most one scheduled Case per day.

To stop the schedule, remove every entity from **Entities** and click **Save schedule**. The page confirms *Scheduled case creation disabled.*

Scheduling is unavailable when the Workflow has **Require unique entity per workflow order** turned on, since that setting allows only one Case per entity in an Order. The section says so instead of showing the form.

## Duplicate a Workflow Order

Duplicating an Order gives you a fast way to re-run the same set of Cases and files without rebuilding the Order by hand.

You can duplicate an Order from either place:

- the **Orders** tab of the Workflow — click the **Duplicate** button on the Order's row, or
- the Order's page — click the **Duplicate** button in the header.

The new Order is created as a **draft** and unlocked, carrying the original's configuration (Original Source URL filter, case-matching strategy, radius, planned start) along with its associated task definitions and permissions. Every Case is copied as a **draft** Case — regardless of the original Case's state — holding the same data files as its original, via a fresh, unassessed submission. No prior assessment data or annotations are carried over. The copy is named `Copy of <name>`, with a number appended if that name is already taken.

The copy's Cases are populated in the background, so the new Order may briefly show no Cases immediately after you duplicate it — refresh the page to see them appear. Because the copy starts in draft, nothing is processed until you approve the Order and mark its Cases ready.

The copy keeps the original's [scheduled entities](#schedule-daily-cases). As a draft, it creates no scheduled Cases until you approve it.
