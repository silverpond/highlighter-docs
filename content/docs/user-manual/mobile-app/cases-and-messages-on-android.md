+++
title = "Cases and messages on Android"
description = "Use the Highlighter Android app's dashboard, browse and search your cases, create and edit cases, open a case's files, and read and reply to case messages."
date = 2026-10-07T08:00:00+00:00
updated = 2026-10-15T00:00:00+00:00
draft = false
weight = 12
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Follow your cases from the field: see what is active, open a case and its files, and talk to the rest of the team about it."
toc = true
top = false
+++

On Android you can browse, search, create and edit cases, and message on them.
Archiving a case, and changing the location of one that already exists, are done
in the Highlighter web app. The app also has no map yet, so there is no Map tab,
no map inside a case, and no sorting by distance.

## Dashboard

The **Dashboard** is the first screen after signing in.

- **Four stat cards** — Total Cases, Ready, Processing and Completed. The counts
  cover the cases the app has loaded so far. A **+** after a number means there
  are more cases still to load, so the true figure is at least that.
- **Recent Messages** — the newest messages from any of your cases. **View All**
  opens the full message list.
- **Recent Cases** — the first four cases in the list. **View All** opens the
  Cases tab.

The Dashboard shows the same list of cases as the Cases tab. If you have
searched or re-sorted there, the counts and Recent Cases here reflect that. The
status filter does not change the Dashboard.

Tap the refresh control in the header to reload; beside it the header shows how
long ago the cases were last updated. If the cases cannot be loaded, the screen
shows *Couldn't load dashboard* and a **Try Again** button.

## The Cases list

The **Cases** tab lists every case you have access to. Each row shows a
thumbnail, the case title, its status and importance, its location, its date,
and the newest message on it, when there is one. The case's reference is shown
beside the date when it differs from the title.

- **Search** — typing in the search box searches on the server, so it matches
  cases that have not been loaded yet.
- **Sort** — **Most Recent** (most recently discussed first) or **Importance**
  (most important first).
- **Filter** — narrows the list to a single status, or **All**. The statuses are
  Draft, Ready, Processing, Paused, Completed, Cancelled and Failed.
- **Pull down** to refresh. **Scrolling** to the end loads more cases.

If a refresh fails, the cases you already had stay on screen under the notice
*"Couldn't refresh. These cases are from earlier."* If the next page fails to
load, the list ends with *"Couldn't load more cases. Try Again"*.

When a search or filter matches nothing, **Clear Search and Filters** resets
both.

## Creating a case

Tap the **+** beside the **Cases** heading, or **Create Case** when you have no
cases yet. The **Create New Case** form asks for:

- **Case Title** — required.
- **Description** — optional.
- **Workflow Order** — required. Pick a workflow, then one of its orders. The
  form remembers the last order you used, so the next case starts with it.
- **Location** — optional. This is the entity the case is about. Search for it
  or choose **No location**. It cannot be changed after the case is
  created.
- **Importance** — Very Low, Low, Medium, High or Critical. Starts at Low.
- **Status** — Draft, Ready, Processing, Paused, Completed, Cancelled or Failed.
  Starts at Draft.

**Create Case** is enabled once the title and workflow order are filled in. When
the case is saved the form closes and the app says *Case created*. If
Highlighter refuses it, the form stays open and shows why.

## Editing a case

Open the case, tap the **⋮** menu in its header and choose **Edit Case**. The
**Edit Case** form changes the title, description, importance and status. The
location is shown but cannot be changed.

Tap **Save Changes**. If nothing was changed, the form just closes. Otherwise
the app says *Case saved*, or keeps the form open and shows why the change was
refused. If the refusal arrives after you have closed the form, the app shows
*Case not saved* with the reason.

## Inside a case

Tapping a case opens it. The header carries the case title and a **Share**
button, which hands a text summary of the case — reference, status, location and
file counts — to another app. Below it are three tabs. A case reopens on the tab
you last left it on.

### Overview

**Case info** — the case's location, when it has one, and its importance.

**Summary** — the number of **data points** on the case (its attached files) and
the number of **devices** those files came from.

### Messages

The conversation on the case. See [Case messages](#case-messages) below.

### Data

Every file attached to the case; the tab's label carries the count. Each row
shows where and when the file was captured.

Tapping a row opens the **data point** screen:

- A preview of the photo, which you can pinch to zoom.
- Its **Location**, when it was **Captured**, and the **Device** it came from.
  A detail the file does not carry reads *Not recorded*.
- **Open Original** hands the full file to another app on the device. If none
  can open it, the app says so.
- **Share** hands a text summary of the data point to another app.

## Case messages

Open a case and choose the **Messages** tab. Messages appear as a conversation,
oldest first, your own on one side and everyone else's on the other.

Only the most recent messages are loaded. When a case has older ones, the
conversation starts with *Showing the most recent messages.* A case with no
conversation yet reads *No messages yet*.

To add a message, type into the **Message** field at the bottom and tap the send
arrow. The message is posted to Highlighter, so it is visible to everyone else
on the case — on the web as well as on mobile. Pull down to refresh the
conversation.

A message you have started typing is kept if you switch tabs or leave the case,
and is waiting when you open that case again.

If the conversation cannot be loaded, the tab shows the reason and a **Try
Again** button.

### All messages

**View All** beside **Recent Messages** on the Dashboard opens the **Messages**
list: messages from every case you have access to, newest first, each row naming
the case it belongs to.

- **Tap a row** to open that case with its Messages tab selected. **Back**
  returns to the list with your search still in place.
- **Search** matches message text, author and case name. It searches the
  messages loaded so far, so clear the search and scroll to load older ones.
- Scrolling to the end loads older messages.
- If a refresh fails, the messages you already had stay on screen under
  *"Couldn't refresh. These messages are from earlier."*

The Dashboard refreshes Recent Messages every time you return to it.
