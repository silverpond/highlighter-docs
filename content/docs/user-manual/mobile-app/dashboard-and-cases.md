+++
title = "Dashboard and cases"
description = "Get around the Highlighter mobile app — the Dashboard, the Cases list, and everything on a case: overview, messages, data, and map."
date = 2026-09-01T08:00:00+00:00
updated = 2026-09-01T08:00:00+00:00
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

## Dashboard

The Dashboard summarises your account at a glance:

- **Four stat cards** — Total Cases, Ready, Processing, and Completed, counted
  across your cases.
- **Recent Messages** — the newest few messages from any of your cases. **View
  All** opens the full message inbox.
- **Recent Cases** — the four most recently active cases. **View All** switches
  to the Cases tab.

"Recent" means recently *active* rather than recently created: cases are ordered
by the most recent discussion on them.

Pull down to refresh, or tap the refresh control in the header — the header also
shows how long ago the list was last updated. Tapping your avatar opens a small
summary sheet showing whether this device is registered, with a shortcut to
register or edit it.

## The Cases list

The **Cases** tab lists every case you have access to, newest activity first.
Each row shows the case title, its status, its location if it has one, its
reference code and date, and a preview of the most recent message on it.

- **Search** — typing in the search box searches on the server, so it matches
  cases that have not been loaded yet, including partial reference codes.
- **Filter** — the filter control narrows the list to a single status. The
  statuses are Draft, Ready, Processing, Paused, Completed, Cancelled and
  Failed.
- **Scrolling** loads more cases as you reach the end of the list.
- **Long-press a row** for **Share**, **Edit** and **Archive** actions.

If the list cannot be loaded, the screen shows the server's own reason and a
**Try Again** button.

## Inside a case

Tapping a case opens it. The header carries the case title and status, an
overflow menu with **Edit Case**, **Share** and **Export**, and four tabs.

### Overview

**Case info** — the case's location, address and coordinates, when it has them.
A case's location lives on its entity, and many cases have none; the app leaves
those blank rather than inventing an address.

**Summary** — the number of **data points** on the case (its attached files) and
the number of **devices** those files came from.

### Messages

The conversation on the case. See [Case messages](../case-messages/).

### Data

Every file attached to the case, numbered, each row showing its filename, the
coordinates it was captured at (or *No GPS data*) and its capture date (or *No
capture date*).

Tapping a row opens the **data point detail** screen with a full preview of the
photo or video, its notes, and **Share** and **Export** actions.

### Map

The case's files plotted on a map, with **Map** and **Satellite** styles. Only
files that carry coordinates appear. Tapping a pin opens the data point, with a
shortcut through to its full details.

## Creating and editing cases

The **+** on the Cases list, and **Edit Case** on an open case, both open a form
with a title, description, location, category, priority, status, and summary
counts for data points and devices.

**Note:**
Cases created or edited on the phone are held for the current session on the
device only — they are not yet posted back to Highlighter. Create cases you want
everyone to see in the Highlighter web app. This is a known limitation of the
current app.
