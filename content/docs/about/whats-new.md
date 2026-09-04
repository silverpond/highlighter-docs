+++
title = "What's New in Highlighter"
description = "Recent updates, new features, and improvements to Highlighter AI platform"
date = 2025-11-19T08:00:00+00:00
updated = 2026-09-04T08:00:00+00:00
draft = false
weight = 15
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Stay informed about the latest features, enhancements, and improvements to the Highlighter platform."
toc = true
top = false
+++


## Connector Improvements

**Release Date:** September 2026

Connectors, which notify external systems when something happens in Highlighter, have been reworked to make them easier to configure and to show what has actually been delivered.

### What Changed

- **A simpler form.** Choosing a notification type now reveals only the fields it needs, instead of presenting every field for every configuration. Object classes and steps are chosen from searchable lists rather than typed as JSON, and each event's filter appears directly beneath that event.
- **Authenticated webhooks.** HTTP Request connectors can send a bearer token. The token is stored encrypted, is never displayed again, and requires an `https` address unless the endpoint is local.
- **Send a test notification.** A button on the connector page delivers a dummy payload through every enabled notification type and reports the outcome, so a URL, token, or Slack channel can be checked without waiting for a real event.
- **See what happened.** The connector page now lists its delivery history with the event, how it was sent, its status, the number of attempts, and any error returned, alongside counts of pending, accepted, retrying, and failed notifications.
- **Better retries.** Failures that might succeed later, such as a server error or a rate limit, are retried; failures that cannot succeed, such as a missing endpoint, are reported instead of being retried for days. Transient mail server problems are now retried rather than silently discarded.
- **The UI Path option has been removed** from the connector form.

### Action Required

**HTTP Request connectors now send a JSON body.** Previously the request body was form-encoded while its header advertised JSON, which meant numbers and booleans arrived as text and nested values needed special decoding. The body now matches the header:

```json
{"event": "project_file_completed", "payload": {"case_id": 123}}
```

If you receive Highlighter webhooks, check that your endpoint parses a JSON body before this release reaches your environment.

See [Connectors](/docs/user-manual/managing-workflows/connectors/) for full details.

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
