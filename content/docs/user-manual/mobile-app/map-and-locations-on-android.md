+++
title = "Map and locations on Android"
description = "See your cases and their files on a map in the Highlighter Android app, filter to one case, and sort the Cases list by distance from the device."
date = 2026-10-19T00:00:00+00:00
updated = 2026-10-19T00:00:00+00:00
draft = false
weight = 13
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Where your cases are, where their imagery was captured, and which case is closest to you."
toc = true
top = false
+++

## The Map tab

The **Map** tab shows your cases and their files on a map.

- Each **case** has a blue pin, labelled with the case title and how many of its
  files are on the map. The pin is at the case's location, or, for a case with
  no location, at the centre of its files.
- Each **file** that carries coordinates has an orange pin.

The map shows the cases the Cases list has loaded so far. Scroll further down
the Cases list to bring more onto the map.

- **Filter by case** — the **Case / Location** control at the top narrows the
  map to a single case, or shows **All cases**.
- **Tap a file's pin** to open a card with the data point's number, its
  filename, and where and when it was captured. **View Full Details** opens the
  data point screen, with **Open Original** and **Share**.
- **Tap a case's pin** to show its label.
- The refresh control in the header reloads the map's data.
- **Full screen** opens the map over the header, tabs and bottom bar, which
  helps on a phone held sideways. **Exit full screen** returns.

If nothing can be shown, the map says *"No case GPS data available"*, or *"No
GPS data for this case"* when a case is selected, and offers **Refresh Map**.
Many files have no GPS position, and a case has none until it is given a
location that has one. The app shows only what is there rather than guessing.

## A case's map

An open case has its own **Map** tab, showing just that case's location and
files, with **Map** and **Satellite** styles. Tap a file's pin to inspect the
data point behind it. **Full screen** works here too.

A case with nothing to show reads *"No GPS data for this case"*.

## Cases near you

The Cases list can be sorted by **Nearest**, which ranks cases by the distance
from the device to each case's location and shows that distance on the row. It
is the order the list opens in. See
[Cases and messages on Android](../cases-and-messages-on-android/#nearest-and-location-access).

## Location access

The app asks for the device's location the first time you open the Cases tab.
It uses it to sort by **Nearest**, to show distances, and to mark where you are
on the maps, and only while the app is open. The position goes to Highlighter
only to rank the list; it is not saved on this device's record.

The app works without location access: the Cases list uses **Most Recent**
instead, and the maps still show your cases and files. Choosing **Nearest**
from the sort control asks again; once Android stops asking, turn location on
for Highlighter in Android's Settings.
