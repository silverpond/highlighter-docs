+++
title = "Working in the Assessment Editor"
description = "Hone your skills in assessment Editor tools: use pointer, annotation, zoom, panels, and shortcuts to efficiently annotate and submit cases in Highlighter AI."
date = 2023-09-26T08:00:00+00:00
updated = 2026-07-20T08:00:00+00:00
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
- <a href="#select-annotations-and-delete-the-rest">Select Annotations And Delete The Rest</a>
- <a href="#set-annotation-view-options">Set Annotation View Options</a>
- <a href="#show-and-hide-annotations-tracks">Show And Hide Annotations/Tracks</a>
- <a href="#submit-assessments">Submit Assessments</a>

## Use Assessment Editor tools

The assessment editor tools are laid out across in the top toolbar.

### Pan, Select, And Edit Annotations
The Pan tool (shortcut key: 'h') is active when you open the editor. Drag the canvas to move around, or click an annotation to select it without opening its edit handles. The canvas shows a hand cursor in Pan, changing to a pointer over annotations you can click.

Use the Select Annotation tool (shortcut key: 'q') when you want to select or edit geometry. Click an annotation to select it, or drag across the canvas to select every annotation intersecting the rectangle. Hold Shift while clicking or rectangle-selecting to add annotations to the current selection. Selected annotation geometry exposes handles for direct editing.

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

- **Reveal on hover.** Move your pointer over a hidden entity to temporarily reveal it and show its labels.
- **Promote by clicking.** Click a revealed shadow entity to promote its **whole entity** back into the active set — every annotation of that entity becomes fully visible, appears in the entities list, and will be saved on submit. (Promoting works on the whole entity so an object is never left split between the canvas and the shadow layer.) To put a promoted entity back into the shadows, select it and press **Shift + S** (see below).
  - If the annotation you click carries a stable attribute value that differs from the entity's current value, Highlighter prompts you to either keep the entity's existing value or adopt the promoted one (so it does not create a conflict within the stability window). Where the entity has no value yet, the promoted value is adopted silently.
- **Shadow the whole entity manually.** Shadowing any annotation shadows **every** annotation of its entity, so the object leaves the active set together. You can do this from several places:
  - Select one or more tracks and press **Shift + S** (or choose "Shadow selected" from the menu).
  - Click the shadow (eye-off) button in the attribute editor header, next to "Locate", while editing an annotation.
  - Click the shadow button on an entity in the entities panel.

  The two buttons ask you to confirm first, since they shadow the whole entity rather than the single annotation you started from.
- **Works on any step.** Manual shadowing and unshadowing are deliberate actions you can take on **any** step, whether or not the step is configured to filter entities. (Step configuration only controls which entities are shadowed *automatically* when a case first loads.)

Shadow classification is per session — it is recalculated each time the queue loads and is not persisted.

## Jump To The First Object

When you open a case, the editor jumps playback to the start of the **first identified object** — the earliest-starting annotation or track — so you land on something to assess straight away instead of at the start of the raw data window, which is often before any object appears. The timeline scrolls to match.

- **Shadowed annotations/tracks are skipped.** The jump targets the first *visible* object, ignoring any entities that are [shadowed](#work-with-shadow-entities) for your current task. If a case has no visible objects, playback stays at the start.
- **In a queue, this is on by default.** While assessing through a queue, you land on the first object automatically. To turn it off — for example, to always start at the beginning of the data — add `jump_to_first_track=false` to the URL.
- **Outside a queue, it is opt-in.** When you open a case directly (a deep link with `case_id`), playback starts at the beginning of the data unless you add `jump_to_first_track=true` to the URL.
- **An explicit start time always wins.** If the URL already specifies a position with `at_time=`, the editor seeks there and does not jump to the first object.

## Select Annotations And Delete The Rest
With the pointer tool active, click an annotation to select it, and Shift-click other annotations to add them to the selection. To select many annotations at once, hold Shift and drag out a box on the canvas — every annotation completely inside the box is added to the selection. Plain dragging (without Shift) still pans the canvas.

Once you have a selection, right-click anywhere on the canvas (or open the Edit menu in the top toolbar) and choose:

- **Delete Other Annotations** — keeps only the selected annotations and deletes every other annotation.
- **Delete Other Entities** — keeps every annotation belonging to the same entities as the selected annotations, and deletes the annotations of all other entities.

Both actions ask for confirmation before deleting, and can be undone with Ctrl+Z (one annotation at a time). As with other edits, nothing is permanently removed until you submit the assessment.

Deleting annotations (through these actions, the Delete key, or the trash button in the entities panel) can strand an entity-level value: an attribute that is stable for the entity, where every annotation holding its value is being deleted while the entity keeps other annotations. When that would happen, the confirmation dialog lists each at-risk value with a checkbox and a picker — tick the values you want to keep and choose which surviving annotation to move each one onto. Unticked values are deleted along with their annotations.

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
