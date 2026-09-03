+++
title = "What's New in Highlighter"
description = "Recent updates, new features, and improvements to Highlighter AI platform"
date = 2025-11-19T08:00:00+00:00
updated = 2026-09-03T00:00:00+00:00
draft = false
weight = 15
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Stay informed about the latest features, enhancements, and improvements to the Highlighter platform."
toc = true
top = false
+++


## Filtered Case Exports with `--where`

**Release Date:** September 2026

`hl case export` can now download exactly the files you need instead of an
entire case. Pass a small, SQL-like `--where` expression and the server
resolves the selection before a single byte is downloaded.

### What's New

- **`--where`**: filter by exact file or datasource identity, content type,
  and a recorded-time window (e.g. one camera for a 15-minute period).
- **`--dry-run`**: print the resolved file metadata, sizes, and durations as
  JSON without creating a directory or downloading anything.
- **`hl case export-fields`**: discover the fields, types, operators, and
  limits supported by your server, in table or JSON form.

### Getting Started

```bash
hl case export --id <CASE_ID> \
  --where "data_source_uuid = '<SOURCE_UUID>' AND content_type = 'VIDEO' AND recorded_period OVERLAPS ('2026-08-06T07:35:00+10:00', '2026-08-06T07:50:00+10:00')" \
  --output-dir ./exports
```

See the [CLI reference](/docs/reference/sdk/cli-resource-management/) for the
full field list and option rules.

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
