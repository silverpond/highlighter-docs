+++
title = "Map and locations"
description = "See uploaded files plotted on a map in the Highlighter mobile app, filter by case, and understand how the app records where your phone is."
date = 2026-09-01T08:00:00+00:00
updated = 2026-10-07T08:00:00+00:00
draft = false
weight = 5
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Where your uploaded imagery was captured, and where the phone reporting it was."
toc = true
top = false
+++

## The Map tab

The **Map** tab plots every uploaded file that carries coordinates, across all
of your cases. Each file is a pin, and each case with located files gets a pin
of its own at the centre of them, labelled with the case and how many files it
has on the map.

- **Filter by case** — the **Case / Location** control at the top narrows the
  map to a single case, or shows **All cases**.
- **Tap a file's pin** to open a popup with the data point's number, where and
  when it was captured and the device it came from, plus **View Full Details**
  and **Export**.
- The refresh control in the header reloads the map's data.

If nothing can be plotted, the map says *"No case GPS data available"* — or *"No
GPS data for this case"* when a case is selected — and offers **Refresh Map**.
Many files have no GPS position — phone photos often do, camera imagery
frequently does not — and the app shows what is actually there rather than
guessing a location.

## A case's own map

An open case has its own **Map** tab showing just that case's files, with
**Map** and **Satellite** styles. It works the same way: tap a pin to inspect
the data point behind it.

## Cases near you

The Cases list can be sorted by **Nearest**, which ranks cases by the distance
from the phone to each case's location and shows that distance on the row. See
[Dashboard and cases](../dashboard-and-cases/).

## Where the phone is

The **Profile** tab has a **Location** section. It is a readout, not something
you fill in.

The app takes a position from the phone's GPS and writes it to this device's
record in Highlighter when imagery is sent. The same position is what **Nearest**
sorting measures from. The section shows the most recent
fix and when it was last sent to Highlighter, so you can see what the app is
collecting without reading the privacy policy.

Location access is **when in use** only — the app never asks for background
location, because everything it reports happens while somebody is holding the
phone.

- If access has not been asked for yet, the section offers **Allow Location
  Access**.
- If it has been denied, it offers **Open Settings**.

The app works without location access. Files simply arrive without a position on
them, nothing is written to the device's record, and the Cases list cannot be
sorted by Nearest.

Signing out clears the reported position along with the device registration, so
nothing carries over into the next person's session on the same phone.
