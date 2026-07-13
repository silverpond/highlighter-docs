+++
title = "What's New in Highlighter"
description = "Recent updates, new features, and improvements to Highlighter AI platform"
date = 2025-11-19T08:00:00+00:00
updated = 2026-07-14T08:00:00+00:00
draft = false
weight = 15
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Stay informed about the latest features, enhancements, and improvements to the Highlighter platform."
toc = true
top = false
+++


## Box-Select and Bulk Delete in the Assessment Editor

**Release Date:** July 2026

The assessment editor now supports selecting many annotations at once and deleting everything else in a couple of clicks.

### What Changed

- **Box select**: with the pointer tool active, hold Shift and drag out a box on the canvas to add every annotation completely inside it to the selection. Plain dragging still pans the canvas.
- **Right-click menu**: right-clicking the canvas opens a context menu with two bulk actions, also available from the Edit menu:
  - **Delete Other Annotations** keeps only the selected annotations.
  - **Delete Other Entities** keeps every annotation belonging to the same entities as the selection.

Both actions ask for confirmation and are undoable, and nothing is permanently removed until the assessment is submitted. See [Working in the Assessment Editor](/docs/user-manual/assessing-and-labelling/working-in-the-assessment-editor/#select-annotations-and-delete-the-rest) for details.

Deletions also now protect entity-level values: when a deletion would remove every annotation holding a stable attribute value while its entity survives, the confirmation lists each at-risk value so you can keep it by moving it onto a surviving annotation of your choice.

## Shadow Entities in the Assessment Editor

**Release Date:** June 2026

Assessment steps can now hide entities that aren't relevant to the task at hand, letting assessors focus while still keeping useful inferences from earlier stages.

### What's New

- Administrators can enable **Shadow Entities** on a human assessment step and add **Key Attribute** rules that define which carried-over entities stay visible. Entities matching no rule are shadowed (hidden on the canvas, and left out of the entities list and timeline).
- Assessors can **hover** to reveal a shadowed entity and **click** to promote its **whole entity** back into the active set. To shadow an entity, press **Shift + S**, use the shadow button in the attribute editor header, or use the shadow button on an entity in the entities panel — each shadows the whole entity, and manual shadowing works on any step.
- Shadowed entities are kept on the case but are not saved on submit unless promoted.

See [Human Assessment Steps](../../user-manual/managing-workflows/human-assessment-steps/#shadow-entities) and [Work With Shadow Entities](../../user-manual/assessing-and-labelling/working-in-the-assessment-editor/#work-with-shadow-entities).

## Stable Attributes in the Assessment Editor

**Release Date:** June 2026

Attributes that change only slowly can now be modelled as **stable**, so Highlighter treats readings that disagree within a short window as conflicts to resolve rather than as real change.

### What's New

- An entity attribute can be given a **stability window**. Within that window, a stable attribute holds a single value, and conflicting readings are resolved to one value.
- In the assessment editor, a stable attribute is edited once for the whole entity (across all of its views), always shows the entity's effective value, and marks values set on another view with a "jump to it" link.
- Stable attributes can be left empty while working; required ones are enforced across the entity at submit time.

See [Stable Attributes](../../user-manual/managing-workflows/workflow-taxonomy-management/#stable-attributes) and [Edit Stable Attributes](../../user-manual/assessing-and-labelling/working-in-the-assessment-editor/#edit-stable-attributes).

## Taxon Group Import/Export Performance

**Release Date:** November 2025

Recent enhancements have significantly improved the speed and efficiency of taxon group imports and exports.

### What Changed

The import and export processes have been optimized to use bulk database operations instead of processing records individually. This architectural improvement results in:

- **Faster Import Times**: Large taxon groups import up to 10x faster
- **Reduced Server Load**: More efficient use of database resources
- **Better Reliability**: Improved error handling and transaction management
- **Enhanced Testing**: Comprehensive round-trip validation ensures data integrity

### Technical Details

The optimization includes:

1. **Bulk Data Operations**: CSV parsing and data collection happens outside database transactions for better performance
2. **Efficient Database Queries**: Records are created and updated in batches rather than one-by-one
3. **Optimized Lookups**: Entity attributes, object classes, and enums are fetched in bulk with indexed lookups
4. **Transaction Optimization**: Database locks are minimized while maintaining data consistency

### What This Means for You

These improvements are transparent to users - you don't need to change how you work with taxon groups. You'll simply experience:

- Faster imports when uploading large taxonomy files
- Quicker exports when backing up or sharing taxonomies
- More responsive workflow taxonomy management
- Improved reliability for large-scale taxonomy operations

The same CSV format and workflow remain unchanged, ensuring backward compatibility with existing taxonomy files.

## Enhanced Contributor Workflow Management

**Release Date:** November 19, 2025

We've significantly improved how contributors are assigned and work across different workflow steps, providing a more unified and reliable experience.

### What's New

Workflow managers can now manage all types of workflow steps using a consistent interface:
- Data source
- Human assessment
- Machine assessment
- Filter

This consolidation makes it easier to manage the setup of workflows without having to learn multiple interfaces.

We've also enhanced the technical infrastructure for assigning contributors to workflow steps.

### Getting Started

To take advantage of these improvements:

1. **Review Your Workflows**: Existing workflows continue to work without changes
2. **Assign Contributors**: Use the enhanced assignment interface for new or existing steps
3. **Learn More**: See our new [Assigning Contributors to Workflow Steps](/docs/user-manual/managing-workflows/assigning-contributors/) documentation


## Stay Updated

For ongoing updates and announcements:
- Check this page regularly for new feature releases
- Subscribe to Highlighter platform updates
- Contact support for questions about new features

## Related Resources

- [Managing Workflows](/docs/user-manual/managing-workflows/)
- [Assigning Contributors to Workflow Steps](/docs/user-manual/managing-workflows/assigning-contributors/)
- [Human Assessment Steps](/docs/user-manual/managing-workflows/human-assessment-steps/)
- [Support](/docs/about/support/)
