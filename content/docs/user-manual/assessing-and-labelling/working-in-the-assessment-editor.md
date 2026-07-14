+++
title = "Working in the Assessment Editor"
description = "Hone your skills in assessment Editor tools: use pointer, annotation, zoom, panels, and shortcuts to efficiently annotate and submit cases in Highlighter AI."
date = 2023-09-26T08:00:00+00:00
updated = 2026-07-14T08:00:00+00:00
draft = false
weight = 5
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

Working in the Assessment Editor requires access to your tools

- <a href="#use-assessment-editor-tools">Use Assessment Editor tools</a>
- <a href="#access-the-file-list">Access The File List</a>
- <a href="#access-the-objects-panel">Access The Objects Panel</a>
- <a href="#edit-annotation-attributes">Edit Annotation Attributes</a>
- <a href="#edit-stable-attributes">Edit Stable Attributes</a>
- <a href="#work-with-shadow-entities">Work With Shadow Entities</a>
- <a href="#jump-to-the-first-object">Jump To The First Object</a>
- <a href="#select-items-and-delete-the-rest">Select Items And Delete The Rest</a>
- <a href="#set-annotation-view-options">Set Annotation View Options</a>
- <a href="#show-and-hide-annotations-tracks">Show And Hide Annotations/Tracks</a>
- <a href="#submit-assessments">Submit Assessments</a>

## Use Assessment Editor tools

The assessment editor tools are laid out across in the top toolbar.

### Pan, Select, And Edit Annotations
The Pan tool (shortcut key: 'h') is active when you open the editor. Drag the canvas to move around, or click an annotation to select it without opening its edit handles. The canvas shows a hand cursor in Pan, changing to a pointer over annotations you can click.

Use the Select Annotation tool (shortcut key: 'q') when you want to select or edit geometry. Click an annotation to select it, or drag across the canvas to select every annotation intersecting the rectangle. Hold Shift while clicking or rectangle-selecting to add annotations to the current selection. Selected annotation geometry exposes handles for direct editing. In an editable assessment, hold Alt/Option while dragging selected annotations to move them.

To move the canvas without leaving your current tool, hold Ctrl on Windows or Linux, or Command on macOS, while dragging. You can also drag with the middle mouse button. While either temporary pan is engaged the cursor changes to the hand, and panning does not change the current selection or annotation geometry.

### Use The Annotation Tools
The annotation tools are grouped into a dropdown. The first one is the Bounding Box Annotation tool (shortcut key: 'w'), allowing you to draw rectangles. Click once to start, move your mouse until you see the rectangle you want, then click again to stop.

The second tool is the Polygon Annotation Tool (shortcut key: 'e'). This allows you to draw polygons of any shape. Click once to start, then click again to set the next point, keep clicking to set more points, then hit enter to finish. The polygon will automatically join back to your first point.

The third tool is the Line Annotation Tool (shortcut key: 'y'). This allows you draw lines. Click once to start, then click again to finish your line.

Once you have selected a tool within this group, it remains on top of the dropdown group for easy access later.

### Zoom
All tools allow you to zoom in and out using the scroll wheel of your mouse. You can also click the magnifying glass tools with the plus and minus inside.

## Access The File List
Access the list of currently loaded files in your case by clicking the little pull-out arrow at the left of the screen. Once open, click the little pull-in arrow to close again. This can also be toggled using shortcut key 'l'.

## Access the Objects Panel
Access the objects panel using the little pull-out arrow at the right of the screen. Once open, click the little pull-in arrow to close again.

## Edit Annotation Attributes
The Objects Panel lists the attributes of the selected annotation (or, for video, its track). To change them, open the attribute editor by clicking the "Edit" button at the bottom of the panel, or by pressing shortcut key 'i'.

The edit form opens with its first field already focused, so you can fill it in from the keyboard without reaching for the mouse:

- Attributes with predefined options are dropdowns; other attributes are text or number fields. The focused field is outlined so you can always see where keyboard input will go.
- Press Tab to move from one field to the next, and on to the "Update" button.
- Confirm your changes by clicking "Update", or by pressing Enter while the "Update" button is focused. The panel then returns to its read-only view showing the saved values.

To close the form without saving, click the "X" at the top of the panel.

## Edit Stable Attributes

Some attributes change only slowly — think of an asset condition that should not flip from "ok" to "deteriorated" within the few seconds you are watching it. An administrator can mark such an attribute as **stable** by giving it a stability window (the length of time a value is expected to hold). Highlighter then treats readings that disagree within that window as conflicts to resolve, rather than as a genuine change over time.

Stable attributes behave differently in the attribute editor:

- **One value for the whole entity.** When an attribute is stable and its stability window covers the entity's lifetime, it holds a single value across *all* of the entity's annotations (for example, the views of the same object across multiple cameras), instead of being set separately on each frame or view. Editing it once updates it for the entity everywhere. (If the window is shorter, the value is stable only within that window and can change over longer periods.)
- **The effective value is always shown.** Even when the value was set on a different annotation or view, the dropdown still shows the entity's current value, so you always see what the entity actually claims.
- **A marker shows when a value came from another view.** If the value was set on a different annotation, its control is outlined in orange and shows a "set on another view ↪ jump to it" link. Click the link to jump straight to the annotation that holds the value (when several views hold it, the link seeks to the one nearest the current playhead). In the read-only attribute view, this occurrence is flagged with a small "other view" link.
- **Stable attributes can be left empty.** You may leave a stable attribute blank while you work. Required attributes are still enforced when you submit — and a required stable attribute set on *any* of the entity's annotations satisfies the requirement for the whole entity. If a required value is missing on submit, the editor jumps to the relevant annotation and highlights the attribute so you can fill it in.
- **Setting a value makes it the entity's value for that stability window.** When you edit the attribute on the view you are working on and choose a value, that value becomes the entity's value for the stability window. Any *other* views that held a **conflicting** (different) value within that window are cleared, so the conflict is resolved in favor of your new value. Views that already held the **same** value do not conflict and are left as they are. Leaving the value unchanged leaves it on the annotation where it was originally set.

Highlighter prevents a stable attribute from holding two different values within a single stability window in one submission: a value must hold for at least a window before it can change. If your window is as wide as the entity's whole lifetime, the value cannot change at all and is treated as a single entity-wide value.

## Work With Shadow Entities

When a step is configured to filter entities (see [Human Assessment Steps](../../managing-workflows/human-assessment-steps/#shadow-entities)), entities carried over from earlier assessment stages that are not relevant to your current task are **shadowed** — kept on the case but hidden from view so they stay out of your way. For example, a "vehicle damage" stage can shadow the trees and pedestrians detected by an earlier "object detection" stage while still showing the vehicles.

Shadowed entities:

- Are hidden on the canvas (drawn invisibly) rather than removed.
- Do not appear in the entities list or on the timeline.
- Are **not** saved when you submit, unless you promote them first.

You can still work with them:

- **Reveal on hover.** Move your pointer over a hidden entity to temporarily reveal it and show its labels (a "Shadow entity" hint appears).
- **Promote by clicking.** Click a revealed shadow entity to promote it back into the active set — it becomes fully visible, appears in the entities list, and will be saved on submit. Promotion acts on the whole entity: every shadowed annotation of that entity returns together, so an object is never split between the canvas and the shadows. To put a promoted entity back into the shadows, select it and press **Shift + S** (see below).
  - If the annotation you promote carries a stable attribute value that differs from the entity's current value, Highlighter prompts you to either keep the entity's existing value or adopt the promoted one (so it does not create a conflict within the stability window). Where the entity has no value yet, the promoted value is adopted silently.
- **Shadow selected entities manually.** Select one or more tracks and press **Shift + S** (or choose "Shadow selected" from the menu) to move them out of the active set yourself. Like promotion, this acts on whole entities: every annotation of each selected entity leaves the active set together.

Shadow classification is per session — it is recalculated each time the queue loads. When you submit, entities still in the shadows are dropped from your submission entirely: they do not carry forward to later stages and will not reappear (even as shadows) when the case is next opened, so promote anything you want to keep before submitting.

## Jump To The First Object

When you open a case, the editor jumps playback to the start of the **first identified object** — the earliest-starting annotation or track — so you land on something to assess straight away instead of at the start of the raw data window, which is often before any object appears. The timeline scrolls to match.

- **Shadowed annotations/tracks are skipped.** The jump targets the first *visible* object, ignoring any entities that are [shadowed](#work-with-shadow-entities) for your current task. If a case has no visible objects, playback stays at the start.
- **In a queue, this is on by default.** While assessing through a queue, you land on the first object automatically. To turn it off — for example, to always start at the beginning of the data — add `jump_to_first_track=false` to the URL.
- **Outside a queue, it is opt-in.** When you open a case directly (a deep link with `case_id`), playback starts at the beginning of the data unless you add `jump_to_first_track=true` to the URL.
- **An explicit start time always wins.** If the URL already specifies a position with `at_time=`, the editor seeks there and does not jump to the first object.

## Select Items And Delete The Rest
You can select more than one thing at a time, and mix files, annotations, and
entities in a single selection. Clicking an item starts a fresh selection with
just that item. Hold **Shift** while clicking to add items to the selection —
or remove ones you have already picked — without losing your place: the file
you have open and the annotation you are editing stay as they are. Select files
from the Data Sources panel or the heading of the file you are viewing,
annotations from the canvas, the timeline, the entity list, or the
similar-tracks window, and entities from the entity list or tree.

To select many annotations at once, use the Select Annotation tool to drag a box around
them — every visible annotation the box touches becomes your new selection.
Hold Shift as you start the drag to add them to what you already have; files
and entities you selected earlier stay selected. Annotations hidden as
[shadows](#work-with-shadow-entities) are never picked up by a box.

While you have items selected, the **Selected Items** panel opens on the right
— the same panel used in the Operations Dashboard. (The one exception is a single
selected annotation, which shows its attribute panel instead.) The panel counts
what you have selected, lets you jump to or remove individual items, clear the
selection, and run the actions that apply to the selected files, annotations,
or entities. In a completed assessment you can still select and inspect items,
but actions that would change the submission are disabled.

### Keep Only The Selected Annotations

Select the annotations you want to keep, then right-click anywhere on the
canvas (or open the Edit menu in the top toolbar) and choose **Delete Other
Annotations**. Every annotation outside your selection is deleted — including
any other annotations belonging to the same entities as the ones you kept.

### Keep Only The Selected Entities

To keep whole objects instead of individual annotations, make your selection
and choose **Delete Other Entities** from the same right-click or Edit menu.
Every entity you selected — plus the entity of each selected annotation — keeps
all of its annotations, and the annotations of every other entity are deleted.
Use this when you have selected only one view of an object but want to keep all
of its views.

Both actions ask you to confirm before deleting anything, and are greyed out
when there is nothing for them to delete. If you change your mind, a single
Ctrl+Z brings everything back — the deleted annotations, your selection, and
any values that were moved. As with other edits, nothing is permanently removed
until you submit the assessment.

Deleting annotations — whether with these actions, the Delete key, or the trash
button in the entities panel — can sometimes take an entity's recorded value
with it. For example, a [stable attribute](#edit-stable-attributes) like a
condition may have been set on the one annotation you are deleting, even though
the entity keeps its other annotations. When that would happen, the
confirmation dialog lists each value at risk. Keep a value ticked and choose
which of the remaining annotations should carry it, and Highlighter moves it
there; untick it to let the value be deleted along with its annotation.

## Set Annotation View Options
Set annotation view options by clicking the View menu in the top toolbar, then clicking 'Annotation'. You will see a menu of options which you can toggle on or off.

Set the visibility of each of these options individually:
- Fill - the coloured fill of the annotation
- Border - the border around the annotation
- Label - shows a summary of known annotation attributes
- Attributes - detailed listing of known annotation attributes

Options stay set even after reloading the page, or moving to new cases or data files.

## Show And Hide Annotations/Tracks
Show or hide all annotations/tracks (including associated text) by clicking the View menu, then "Show/hide annotations/tracks" (shortcut key 'f'). Hidden annotations/tracks are still submitted.

What is the difference between annotations and tracks? If you are working with images for example, you will work with annotations. However if you are working with video for example, annotations are grouped together into tracks, that stretch over time.

## Submit Assessments
Submit assessments by clicking the "Submit" button. Next to that button is a dropdown menu which has other options including "Skip" and "Flag and Submit".

### Skip
The skip option allows you to temporarily skip the current item/case. The assessment editor will load the next item, and then the next, and so on - you can continue working as normal through your assessment queue. You can even skip more items. When you want to get back your skipped items, just reload your browser window. Then all skipped items will appear again in the order you skipped them.

What is a case? A case is a collection of data files that will be assessed together. They can be of different media types, for example images, video, text and so on. You can see the list of data files in your case by choosing the View menu then "Show/hide left panel" (shortcut key 'l').

### Flag And Submit
This allows you to submit your assessments, and add in a short message. This message appears prominantly at various places around Highlighter, for example in the Media Search page. It allows you to signal something about this submission, for example that it contains an image that is too dark, and so on.
