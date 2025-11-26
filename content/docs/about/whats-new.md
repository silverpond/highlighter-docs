+++
title = "What's New in Highlighter"
description = "Recent updates, new features, and improvements to Highlighter AI platform"
date = 2025-11-19T08:00:00+00:00
updated = 2025-11-19T08:00:00+00:00
draft = false
weight = 15
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Stay informed about the latest features, enhancements, and improvements to the Highlighter platform."
toc = true
top = false
+++

## November 2025

### Enhanced Contributor Workflow Management

**Release Date:** November 19, 2025

We've significantly improved how contributors are assigned and work across different workflow steps, providing a more unified and reliable experience.

#### What's New

**Unified Contributor Interface**

Contributors can now work seamlessly across all types of workflow steps using a consistent interface:
- Data source steps
- Human assessment steps
- Machine assessment oversight
- Filter and quality control steps

This consolidation makes it easier for team members to navigate between different types of tasks without learning multiple interfaces.

**Improved Assignment Reliability**

We've enhanced the technical infrastructure for assigning contributors to workflow steps. The system now correctly handles user assignments across all account contexts, preventing assignment failures and ensuring contributors have reliable access to their assigned tasks.

**Better Workflow Architecture**

The underlying workflow architecture has been streamlined into a unified Steps system that:
- Provides consistent behavior across all step types
- Maintains full backward compatibility with existing configurations
- Simplifies workflow administration and management

#### Benefits for Users

**For Workflow Administrators:**
- More reliable contributor assignment process
- Consistent interface for managing all step types
- Reduced complexity in workflow configuration

**For Contributors:**
- Unified experience across different workflow step types
- More reliable access to assigned tasks
- Consistent tools and navigation

**For System Integrators:**
- Improved API consistency for user assignments
- Better reliability when managing workflows programmatically

#### Getting Started

To take advantage of these improvements:

1. **Review Your Workflows**: Existing workflows continue to work without changes
2. **Assign Contributors**: Use the enhanced assignment interface for new or existing steps
3. **Learn More**: See our new [Assigning Contributors to Workflow Steps](../../user-manual/managing-workflows/assigning-contributors/) documentation

#### Technical Details

For administrators and developers interested in the technical details:

- User assignment logic has been updated to use the correct scope when resolving user IDs
- The `ProjectStage` model now properly handles contributor assignments across all contexts
- All step types (data source, human assessment, machine assessment, filter) use the same assignment mechanism

No database migrations or configuration changes are required. The improvements are automatically available to all users.

#### Backward Compatibility

These enhancements maintain full compatibility with:
- Existing workflow configurations
- Data source steps with pre-existing assignments
- Current API integrations
- Existing contributor role permissions

## Stay Updated

For ongoing updates and announcements:
- Check this page regularly for new feature releases
- Subscribe to Highlighter platform updates
- Contact support for questions about new features

## Related Resources

- [Managing Workflows](../../user-manual/managing-workflows/)
- [Assigning Contributors to Workflow Steps](../../user-manual/managing-workflows/assigning-contributors/)
- [Human Assessment Steps](../../user-manual/managing-workflows/human-assessment-steps/)
- [Support](../support/)
