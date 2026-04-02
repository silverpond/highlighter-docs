+++
title = "Workflow Taxonomy Management"
description = "Manage workflow taxonomies in Highlighter using Schema CSVs, taxon group CSVs, and JSON import/export for efficient classification and data organization."
date = 2025-11-24T08:00:00+00:00
updated = 2026-03-26T08:00:00+00:00
draft = false
weight = 45
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Workflow taxonomy defines the structure of object classes and attributes that agents use to assess and classify data. Manage your taxonomy using Schema CSVs for structure, taxon group CSVs for constrained values, or JSON for full snapshots.'
toc = true
top = false
+++

## What is Workflow Taxonomy?

Workflow taxonomy is the structured schema that defines what agents (both human and machine) can detect and classify in your assessment workflows. It consists of:

- **Object Classes**: The types of objects or entities being detected (e.g., Pipe, Valve, Bridge)
- **Entity Attributes**: Properties or characteristics of those objects (e.g., Material, Condition, Notes)
- **Attribute Values**: Specific values for constrained properties (e.g., Steel, PVC, Copper)
- **Taxon Groups**: Organized collections of classifications that link object classes with their attribute values

## Accessing the Taxonomy Tab

1. Navigate to your assessment workflow
2. Click the **Develop** tab in the top ribbon
3. Select the **Taxonomy** tab in the sidebar

From here you can manage your taxonomy using three complementary approaches:

| Approach | Best for | Buttons |
|---|---|---|
| **Schema CSV** | Defining object classes and their attributes (structure) | Export Schema CSV, Import Schema CSV |
| **Taxon Group CSV** | Defining constrained attribute values (e.g., dropdown options) | Existing taxon group import/export |
| **JSON** | Full taxonomy snapshots including all settings and UUIDs | Export JSON, Import JSON |

## Managing Taxonomy with Schema CSVs

Schema CSVs let you define and edit your workflow's object classes and attributes in a spreadsheet. This is the recommended way to set up or modify the structure of your taxonomy.

### Schema CSV Format

The Schema CSV uses the following columns:

| Column | Required | Description |
|---|---|---|
| `object_class` | Yes | Name of the object class (e.g., Pipe, Valve) |
| `attribute` | Yes | Name of the entity attribute (e.g., Material, Notes) |
| `value_type` | No | Data type of the attribute (e.g., `enum`, `string`, `integer`, `float`, `boolean`). Defaults to `string` if omitted. |
| `required` | No | Whether the attribute is required (`true` or `false`) |
| `format` | No | Display format (e.g., `multiline` for text areas) |
| `multiline_rows` | No | Number of rows for multiline fields (e.g., `3`) |

Here is an example Schema CSV:

```csv
object_class,attribute,value_type,required,format,multiline_rows
Pipe,Material,enum,true,,
Pipe,Diameter,float,true,,
Pipe,Notes,string,false,multiline,3
Valve,Material,enum,true,,
Valve,Type,enum,true,,
Valve,Notes,string,false,multiline,3
```

Each row defines one attribute on one object class. An object class appears on multiple rows if it has multiple attributes.

### Exporting a Schema CSV

Export your current taxonomy structure to review it or use it as a starting point for edits:

1. On the **Taxonomy** tab, click **Export Schema CSV**
2. A CSV file downloads with all current object classes and their attribute settings
3. Open it in any spreadsheet application (Excel, Google Sheets, etc.)

### Importing a Schema CSV

Import a Schema CSV to create or update your taxonomy structure:

1. On the **Taxonomy** tab, click **Import Schema CSV**
2. In the modal that appears, drag and drop your CSV file or click to browse
3. Click **Import** to apply the changes

The import process will:

- **Create** new object classes and attributes that don't already exist
- **Update** existing attributes if their settings have changed (e.g., changing `required` from `false` to `true`)
- **Preserve** existing data — the import does not remove object classes or attributes that are absent from the CSV
- **Set sort order** based on row position in the CSV

> **Note:** If the same attribute name appears multiple times with different `value_type` values, the import will fail with a validation error. Each attribute name must have a consistent value type across all object classes.

### Typical Workflow: Schema CSV + Taxon Group CSVs

For a complete taxonomy setup, use Schema CSVs and taxon group CSVs together:

1. **Import a Schema CSV** to define your object classes and all their attributes with settings (value type, required, format)
2. **Import taxon group CSVs** to define the constrained values for `enum` attributes (e.g., the list of valid materials)

This two-step approach lets you manage structure and constrained values independently, using familiar spreadsheet tools.

## Managing Taxonomy with Taxon Group CSVs

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

### Importing Taxon Group CSVs

When importing taxon groups:

1. Use the taxon group import feature on the **Taxonomy** tab
2. Select your taxon group CSV file
3. Choose your import mode:
   - **Merge**: Add to existing taxonomy without removing current definitions
   - **Replace**: Replace the entire taxonomy with the imported version
4. Optionally enable **Dry Run** to preview changes before applying them

The import process will:
- Match existing records by UUID to avoid duplicates
- Create missing object classes and attributes
- Update workflow-specific configurations
- Preserve data integrity through validation

### Exporting Taxon Group CSVs

The taxon group export creates a structured file containing:
- Object class definitions
- Entity attributes and their values
- Taxon group configurations
- Workflow-specific settings

The exported file can be imported into other workflows or stored as a backup.

## Managing Taxonomy with JSON

For full taxonomy snapshots that include all settings, UUIDs, and configurations, use the JSON import/export:

1. On the **Taxonomy** tab, click **Export JSON** to download a complete taxonomy snapshot
2. Click **Import JSON** to restore or transfer a full taxonomy between workflows

JSON export/import is best suited for:
- **Backups**: Creating complete snapshots of your taxonomy
- **Cross-workflow transfers**: Copying an entire taxonomy configuration to another workflow
- **Environment transfers**: Moving taxonomy between staging and production

## Best Practices

### Setting Up a New Taxonomy

1. Start by drafting your Schema CSV in a spreadsheet — list all object classes and their attributes
2. Import the Schema CSV to create the structure
3. Create taxon group CSVs for any `enum` attributes that need constrained value lists
4. Import the taxon group CSVs to populate the constrained values
5. Export a JSON backup once you're satisfied with the configuration

### Organizing Taxon Groups

- **Clear Naming**: Use descriptive names that indicate the purpose of each taxon group
- **Logical Structure**: Group related classifications together
- **Documentation**: Include descriptions for complex taxonomies
- **Version Control**: Export taxonomies regularly to maintain backups

### Managing Large Taxonomies

- **Schema CSV for Structure**: Use Schema CSVs for bulk changes to object classes and attributes — editing a spreadsheet is faster than making changes one at a time in the UI
- **Modular Design**: Break complex taxonomies into manageable taxon groups
- **Incremental Updates**: Use merge mode for adding to existing taxonomies
- **Test Imports**: Use dry-run mode to validate large taxon group imports before applying
- **Re-import Safely**: Schema CSV import is idempotent — re-importing the same CSV won't create duplicates

### Workflow Consistency

- **Standard Templates**: Create reusable Schema CSV and taxon group CSV templates for common workflows
- **Cross-Workflow Sharing**: Export and import to maintain consistency across similar workflows
- **Regular Reviews**: Periodically review and update taxonomies as business needs evolve
- **Training**: Ensure team members understand your taxonomy structure

## Troubleshooting

### Schema CSV Import Issues

- **Missing Headers**: The CSV must contain at least `object_class` and `attribute` columns. Other columns are optional.
- **Unsupported Value Type**: The `value_type` column must use a valid type (e.g., `string`, `enum`, `integer`, `float`, `boolean`). Check for typos.
- **Conflicting Value Types**: If the same attribute name appears with different `value_type` values in different rows, the import will fail. Ensure each attribute name uses a consistent value type.
- **File Too Large**: Schema CSV files are limited to 1 MB. Split very large schemas into multiple files if needed.
- **File Format**: Ensure the file has a `.csv` extension and is valid CSV (not an Excel `.xlsx` file).

### Taxon Group Import Issues

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
