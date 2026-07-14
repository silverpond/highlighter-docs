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
- <a href="#work-with-multiple-selected-items">Work With Multiple Selected Items</a>
- <a href="#delete-annotations-and-entities">Delete Annotations And Entities</a>
- <a href="#edit-annotation-attributes">Edit Annotation Attributes</a>
- <a href="#set-annotation-view-options">Set Annotation View Options</a>
- <a href="#show-and-hide-annotations-tracks">Show And Hide Annotations/Tracks</a>
- <a href="#submit-assessments">Submit Assessments</a>

## Use Assessment Editor tools

The assessment editor tools are laid out across in the top toolbar.

### Select Annotations

Choose the Select tool (shortcut key: 'q') to select annotations while the media is paused:

- Click an annotation to select it and clear the previous selection.
- Hold Shift while clicking to add or remove one annotation from the selection.
- Drag a rectangle to select every visible annotation shape it touches. Hold Shift while dragging to add the matches to the current selection.
- Click empty space to clear the selection, or press Escape when you are not drawing or dragging a selection rectangle.

### Pan The Canvas

Choose the Hand tool (shortcut key: 'h'), then drag to move the canvas without changing the selection. The mouse wheel and zoom buttons continue to control zoom. In an editable assessment, Alt-drag a selected annotation while using the Select tool to move the annotation itself.

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

## Work With Multiple Selected Items

When you select two or more files, annotations/tracks, or entities, the **Selected items** panel replaces the single-annotation Objects Panel on the right. Your current annotation focus is retained, so its attributes return when the selection is reduced to that one annotation again.

Use the type buttons at the top of Selected items to choose which kind is listed and which actions are shown. This filters the panel only; it does not remove the other selected items. Scroll inside the item list to review larger selections, click a row to focus it, or use the × button to remove that item from the selection.

The available actions depend on what is selected:

- **Reassign tracks** moves only the directly selected tracks to a chosen entity. Other tracks belonging to their original entities stay where they are.
- **New entity** moves the directly selected tracks to a new entity. With one annotation selected, the same action remains available in the Objects Panel header.
- **Split view** is available for exactly two selected tracks from different files.
- **Merge entities** combines directly selected entities by moving all of their tracks to one chosen survivor in the current assessment.
- **Join** and **Union** retain their existing track operations and appear under the additional-actions menu when applicable.
- **Selected files from submission** removes directly selected files from this submission. Tracks that exist only in those files are removed; tracks that continue in retained files are trimmed. If a removed track is the last holder of a stable entity value, you can preserve it on a surviving track before continuing.
- **Selected entities** removes every annotation belonging to the directly selected entities from this submission.

Destructive choices are grouped under **Delete** at the bottom of the panel. Each option shows the files, annotations, or entities it will affect. Deletion still asks for confirmation and, when a stable entity value would otherwise be lost, lets you choose where to preserve that value. Each confirmed action is one undo step.

Assessment deletion changes the current submission: it removes annotations or
removes a file from that submission. It does not permanently delete the
account-wide file or entity records. Use Monitor Operations when you intend to
delete those canonical records.

## Delete Annotations And Entities

Delete the current selection with Delete or Backspace, **Edit → Delete**, or the trash button beside an annotation in the Objects panel. The entity delete button removes every annotation in that entity.

The Edit menu and canvas context menu also provide two bulk actions:

- **Delete Other Annotations** keeps only the selected annotations, including when an entity is partly selected.
- **Delete Other Entities** keeps every annotation belonging to an entity that has at least one selected annotation.

Highlighter shows the number of affected annotations and entities before deleting. If the deletion would remove the last annotation holding an active entity-level value, the confirmation lists that value and lets you preserve it on a surviving annotation. Review any conflicting-value warning before confirming.

The whole confirmed deletion is one action. Press Ctrl+Z once to restore all deleted annotations, preserved values, and the selection from before the command.

## Edit Annotation Attributes
The Objects Panel lists the attributes of the selected annotation (or, for video, its track). To change them, open the attribute editor by clicking the "Edit" button at the bottom of the panel, or by pressing shortcut key 'i'.

The edit form opens with its first field already focused, so you can fill it in from the keyboard without reaching for the mouse:

- Each enum attribute is a dropdown; other attributes are text or number fields. The focused field is outlined so you can always see where keyboard input will go.
- Press Tab to move from one field to the next, and on to the "Update" button.
- Confirm your changes by clicking "Update", or by pressing Enter while the "Update" button is focused. The panel then returns to its read-only view showing the saved values.

To close the form without saving, click the "X" at the top of the panel.

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
