+++
title = "Workflow Taxonomy Management"
description = "Manage workflow taxonomies in Highlighter including importing, exporting, and working with taxon groups for efficient classification and data organization."
date = 2025-11-24T08:00:00+00:00
updated = 2025-11-24T08:00:00+00:00
draft = false
weight = 45
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Workflow taxonomy defines the structure of object classes and attributes that agents use to assess and classify data. Taxon groups organize these classifications for efficient data processing.'
toc = true
top = false
+++

## What is Workflow Taxonomy?

Workflow taxonomy is the structured schema that defines what agents (both human and machine) can detect and classify in your assessment workflows. It consists of:

- **Object Classes**: The types of objects or entities being detected (e.g., Bridge, Vehicle, Person)
- **Entity Attributes**: Properties or characteristics of those objects (e.g., Condition, Color, Size)
- **Attribute Values**: Specific values for those properties (e.g., Good, Fair, Poor)
- **Taxon Groups**: Organized collections of classifications that link object classes with their attributes

## Taxon Groups

Taxon groups are collections of predefined classifications (taxons) that combine object classes with their attribute values. They help standardize assessments and ensure consistency across your organization.

### Types of Taxon Groups

**Main Taxon Groups**
- Used for primary object classification
- Include display names and sort order
- Define the main categories agents will use

**Non-Main Taxon Groups**
- Used for additional attributes and characteristics
- Link to main object classes
- Provide extended classification capabilities

### Use Cases

Taxon groups are particularly useful for:

- **Standardized Classifications**: Ensuring all team members use the same terminology
- **Complex Taxonomies**: Managing hierarchical or multi-attribute classifications
- **Quality Control**: Maintaining consistency across large labeling projects
- **Workflow Templates**: Reusing classification schemes across multiple workflows

## Importing and Exporting Taxon Groups

You can import and export taxon groups to:

- Share taxonomies between workflows
- Backup your classification schemes
- Transfer configurations between environments
- Standardize taxonomies across your organization

### Accessing Import/Export Features

1. Navigate to your assessment workflow
2. Click the **Develop** tab in the top ribbon
3. Select the **Taxonomy** tab in the sidebar
4. Use the **Export Taxonomy** or **Import Taxonomy** buttons

### Exporting Taxon Groups

The export feature creates a structured file containing:
- Object class definitions
- Entity attributes and their values
- Taxon group configurations
- Workflow-specific settings

The exported file can be imported into other workflows or stored as a backup.

### Importing Taxon Groups

When importing taxon groups:

1. Click the **Import Taxonomy** button
2. Select your taxonomy file
3. Choose your import mode:
   - **Merge**: Add to existing taxonomy without removing current definitions
   - **Replace**: Replace the entire workflow taxonomy with the imported version
4. Optionally enable **Dry Run** to preview changes before applying them

The import process will:
- Match existing records by UUID to avoid duplicates
- Create missing object classes and attributes
- Update workflow-specific configurations
- Preserve data integrity through validation

## Performance Improvements

Recent enhancements have significantly improved the speed and efficiency of taxon group imports and exports:

### What Changed (November 2025)

The import and export processes have been optimized to use bulk database operations instead of processing records individually. This architectural improvement results in:

- **Faster Import Times**: Large taxon groups import up to 10x faster
- **Reduced Server Load**: More efficient use of database resources
- **Better Reliability**: Improved error handling and transaction management
- **Enhanced Testing**: Comprehensive round-trip validation ensures data integrity

### Technical Improvements

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

## Best Practices

### Organizing Taxon Groups

- **Clear Naming**: Use descriptive names that indicate the purpose of each taxon group
- **Logical Structure**: Group related classifications together
- **Documentation**: Include descriptions for complex taxonomies
- **Version Control**: Export taxonomies regularly to maintain backups

### Managing Large Taxonomies

- **Modular Design**: Break complex taxonomies into manageable taxon groups
- **Incremental Updates**: Use merge mode for adding to existing taxonomies
- **Test Imports**: Use dry-run mode to validate large imports before applying
- **Performance**: Take advantage of bulk import capabilities for large taxonomies

### Workflow Consistency

- **Standard Templates**: Create reusable taxonomy templates for common workflows
- **Cross-Workflow Sharing**: Export and import to maintain consistency across similar workflows
- **Regular Reviews**: Periodically review and update taxonomies as business needs evolve
- **Training**: Ensure team members understand your taxonomy structure

## Troubleshooting

### Import Issues

If you encounter issues during import:

- **Validation Errors**: Check that your taxonomy file format matches the expected structure
- **Duplicate Names**: Ensure object class and attribute names don't conflict with existing definitions
- **Account Mismatch**: Verify you're importing into the correct account
- **Permission Errors**: Confirm you have the necessary permissions to import taxonomies

### Export Issues

If exports fail or seem incomplete:

- **Browser Compatibility**: Use a modern browser for downloading exported files
- **File Size**: Very large taxonomies may take longer to export
- **Network Issues**: Ensure stable network connection for large exports

### Performance Considerations

For optimal performance:

- **Batch Operations**: Import large taxonomies during off-peak hours if possible
- **Network Speed**: Ensure good network connectivity for large file uploads
- **File Preparation**: Validate CSV files before importing to avoid errors mid-process

## Related Documentation

- [Creating Assessment Workflows](../creating-assessment-workflows/) - Learn about workflow design
- [Exporting Data](../exporting-data/) - Export assessment results
- [Assessment Workflow Concepts](../../concepts/assessment-workflow/) - Understand workflow fundamentals
