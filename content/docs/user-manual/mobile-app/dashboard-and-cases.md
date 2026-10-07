+++
title = "Dashboard and cases"
description = "Get around the Highlighter mobile app — the Dashboard, the Cases list, and everything on a case: overview, messages, data, and map."
date = 2026-09-01T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 2
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "The Dashboard is where the app opens; the Cases list and case detail screens are where the work is."
toc = true
top = false
+++

## Getting around

The app has a floating tab bar with four tabs and a **+** button in the middle:

| Tab | What it is |
| --- | --- |
| **Dashboard** | Case counts, recent messages, and recent cases |
| **Cases** | The full list of your cases, searchable and filterable |
| **+** | Add data — attach a photo or video to a case |
| **Map** | Every uploaded file that carries coordinates, plotted |
| **Profile** | Your account, your devices, media settings, location, sign out |

If the phone loses connectivity, a red **"Offline — showing saved data"** banner
appears across the top. You keep what was already loaded, and the app reloads
your cases by itself when the connection comes back.

Each tab keeps its place while you visit another. A search you had narrowed, a
case you had open and a message you had started typing are still there when you
come back.

## Dashboard

The Dashboard summarises your account at a glance:

- **Four stat cards** — Total Cases, Ready, Processing, and Completed, counted
  across your cases.
- **Recent Messages** — the three newest messages from any of your cases. **View
  All** opens the full message inbox.
- **Recent Cases** — the first four cases in the order the Cases tab is
  currently sorted by. **View All** switches to the Cases tab.

Pull down to refresh, or tap the refresh control in the header — the header also
shows how long ago the list was last updated. Tapping your avatar opens a small
summary sheet showing whether this device is registered, its name and its last
known location, with a shortcut to the Profile tab to register or change it.

## The Cases list

The **Cases** tab lists every case you have access to. Each row shows the case
title, its status and importance, its location if it has one and how far away
that is, its date, and a preview of the most recent message on it.

- **Search** — typing in the search box searches on the server, so it matches
  cases that have not been loaded yet, including partial reference codes.
- **Filter** — the filter control narrows the list to a single status, or
  **All**. The statuses are Draft, Ready, Processing, Paused, Completed,
  Cancelled and Failed.
- **Sort** — the sort control orders the list one of three ways. The ranking is
  done by Highlighter across all your cases, not just the ones loaded so far.
  - **Nearest** — closest to where the phone is now. This is the order the app
    starts in. It needs location access; until the phone has a position, the
    list stays in Most Recent order, and if access has been refused the option
    reads *Nearest unavailable*.
  - **Most Recent** — most recently discussed first, with cases nobody has
    messaged last.
  - **Importance** — most important first, newest first among equals.
- **Scrolling** loads more cases as you reach the end of the list.
- **Swipe a row** right for **Edit**, or left for **Archive**. Archiving sets
  the case to Cancelled in Highlighter.

If the list cannot be loaded, the screen shows the server's own reason and a
**Try Again** button.

## Inside a case

Tapping a case opens it. The header carries the case title and status, an
overflow menu with **Edit Case** and **Export**, and four tabs. The app
remembers which tab of a case you had open, and any message you had started
typing there, when you leave the case and come back.

### Overview

**Case info** — the case's importance, its description, and its location,
address and coordinates, when it has them.
A case's location lives on its entity, and many cases have none; the app leaves
those blank rather than inventing an address.

**Summary** — the number of **data points** on the case (its attached files) and
the number of **devices** those files came from.

### Messages

The conversation on the case. See [Case messages](../case-messages/).

### Data

Every file attached to the case, numbered — the tab's label carries the count — each row showing its filename, the
coordinates it was captured at (or *No GPS data*) and its capture date (or *No
capture date*).

Tapping a row opens the **data point detail** screen with a full preview of the
photo or video, where and when it was captured, the device it came from, its
notes, and an **Export** action. Tap the preview to see it full screen.

### Map

The case's files plotted on a map, with **Map** and **Satellite** styles. Only
files that carry coordinates appear. Tapping a pin opens the data point, with a
shortcut through to its full details.

## Creating and editing cases

The **+** on the Cases list opens **Create New Case**. **Edit Case** on an open
case, or **Edit** on a swiped row, opens the same form for an existing one.

| Field | Notes |
| --- | --- |
| **Case Title** | Required. |
| **Description** | Optional. |
| **Workflow Order** | Required for a new case: choose a workflow, then one of its orders. A case has to be filed under an order. Not shown when editing. |
| **Location** | The entity the case is about. Search for an existing one, or tap **New location** to create one with a name and, optionally, an object class. It is fixed once the case is created, so it is read-only when editing. |
| **Importance** | Very Low, Low, Medium, High or Critical. |
| **Status** | Draft, Ready, Processing, Paused, Completed, Cancelled or Failed. |

Tap **Create Case** or **Save Changes**. The case is saved to Highlighter, so it
appears for everyone on the web as well as on the phone. If Highlighter refuses
the change, the form shows the reason and keeps what you typed.
