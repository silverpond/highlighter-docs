+++
title = "Case Matching Strategies"
description = "Configure case matching strategies in Highlighter workflow orders to automatically associate files with entities using geolocation, ingestion path, or manual assignment methods."
date = 2025-12-05T08:00:00+00:00
updated = 2025-12-05T08:00:00+00:00
draft = false
weight = 15
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Learn how to configure case matching strategies to automatically associate (match) files to entities in your workflow orders."
toc = true
top = false
+++

## What is Case Matching?

Case matching is the process of automatically associating uploaded data files with specific entities in your workflow. This is essential when you have multiple entities (such as utility poles, buildings, or equipment) and need to organize incoming files by which entity they relate to.

When files are added to a workflow order, Highlighter can automatically determine which entity each file belongs to based on the case matching strategy you configure. This automation saves significant time compared to manually organizing files.

## Case Matching Strategies

Highlighter offers three case matching strategies for workflow orders:

- **[Geolocation](#geolocation-strategy)**: Match files to entities based on GPS coordinates
- **[Ingestion Path](#ingestion-path-strategy)**: Match files to entities based on folder structure in file paths
- **[None](#none-strategy)**: No automatic matching (manual assignment only)

Each strategy has different requirements, benefits, and use cases.

## Geolocation Strategy

### Overview

The Geolocation strategy matches files to entities by comparing the GPS coordinates embedded in the file's metadata (EXIF data for images) with the GPS coordinates of entities that already have cases in your workflow order.

### How It Works

1. When files are added to the workflow order, Highlighter extracts GPS coordinates from the file metadata
2. For each file, the system searches for existing cases whose entities have GPS coordinates within the specified radius
3. If a case exists for an entity with GPS coordinates within the maximum radius, the file is added to that case
4. Files that don't have GPS data or don't match any entities are treated as non-matches

### Requirements

- **GPS Metadata**: Files must contain valid GPS coordinates in their metadata (e.g., EXIF data for images)
- **Maximum Radius To Matched Entity**: You must specify the maximum distance (in meters) within which a file will be matched to an entity
- **Pre-existing Cases**: Entities must already have cases in the workflow order for files to be matched to them
- **Entities with GPS**: Case entities must have valid GPS coordinates for files to be matched to them

### Configuration

When creating or editing a workflow order:

1. Set **Case Matching Strategy** to "Geolocation"
2. Set **Maximum Radius To Matched Entity** to your desired radius in meters
   - Smaller radius = more precise matching but fewer matches
   - Larger radius = more matches but potential for incorrect associations
3. Optionally enable **Create Cases For Non-Matches** to handle files that don't match any entity

### Example Use Cases

- **Infrastructure Inspection**: Drone photos of utility poles where each pole's location is known and files are captured nearby
- **Site Surveys**: Photos taken at known locations during field surveys
- **Asset Monitoring**: Images captured at fixed locations over time

### Best Practices

- **Choose Appropriate Radius**: Consider the accuracy of your GPS data and the spacing between entities
  - For fixed infrastructure like poles: 5-50 meters depending on density
  - For buildings or larger assets: 50-200 meters
  - For general site surveys: Based on site boundaries
- **Verify GPS Data**: Ensure your files contain valid GPS coordinates before upload
- **Ensure Entity GPS Coordinates**: Verify that your entities have valid GPS coordinates set before creating cases
- **Create Cases First**: Set up cases for your entities before uploading files to enable matching

### Limitations

- Only matches files to entities with existing pre-processing cases
- Requires accurate GPS metadata in files
- Requires entities to have valid GPS coordinates (entities without GPS coordinates will not be matched)
- May not work well in areas with:
  - Dense entity placement (risk of incorrect matching)
  - Poor GPS accuracy
  - Indoor locations where GPS data is unreliable

## Ingestion Path Strategy

### Overview

The Ingestion Path strategy matches files to entities based on the folder structure in the file's original source URL or path. This method uses the immediate parent folder name as an identifier (external_id) to look up the corresponding entity.

### How It Works

1. When files are added to the workflow order, Highlighter extracts the parent folder name from each file's path
2. The system looks up entities in your account with a matching external_id
3. If a matching entity exists and has a pre-processing case in the workflow order, the file is added to that case
4. Files in folders that don't match any entity external_id are treated as non-matches

### Path Structure

For a file path like: `s3://bucket-name/order-folder/pole-001/image.jpg`

- **Parent folder**: `pole-001` (extracted as the entity identifier)
- **Lookup**: System searches for an entity with `external_id = "pole-001"`
- **Match**: If found and has a case, the file is added to that case

### Requirements

- **Structured File Paths**: Files must be organized in folders where the folder name matches the entity's external_id
- **Entity External IDs**: Entities must have external_id values set that match the folder names
- **Pre-existing Cases**: Entities must already have cases in the workflow order for files to be matched to them

### Configuration

When creating or editing a workflow order:

1. Set **Case Matching Strategy** to "Ingestion path"
2. Organize your file uploads so each entity's files are in a folder named with that entity's external_id
3. Optionally enable **Create Cases For Non-Matches** to handle files that don't match any entity

### Example Use Cases

- **Pre-organized Data**: Files already organized by entity ID in your storage system
- **Structured Data Collection**: Field teams using a structured folder naming convention
- **Batch Processing**: Large datasets organized by asset identifiers
- **No GPS Data**: Files that don't contain location metadata

### Folder Structure Examples

**Simple Structure**:
```
order-2024-q1/
├── pole-001/
│   ├── front.jpg
│   └── back.jpg
├── pole-002/
│   ├── front.jpg
│   └── back.jpg
└── pole-003/
    └── overview.jpg
```

**S3 Bucket Structure**:
```
s3://inspection-data/
├── project-a/
│   ├── asset-12345/
│   │   ├── photo1.jpg
│   │   └── photo2.jpg
│   └── asset-67890/
│       └── photo1.jpg
```

**Nested Structure** (only immediate parent folder is used):
```
project/
└── order-folder/
    ├── entity-abc/
    │   └── subfolder/
    │       └── file.jpg  → matches entity-abc
    └── entity-xyz/
        └── file.jpg      → matches entity-xyz
```

### Best Practices

- **Consistent Naming**: Use consistent, unique external_id values for entities
- **Clear Folder Structure**: Organize files with one folder per entity
- **Avoid Special Characters**: Use simple alphanumeric identifiers (hyphens and underscores are fine)
- **Document Convention**: Maintain documentation of your naming convention for team consistency
- **URL Encoding**: The system handles URL-encoded paths (e.g., spaces as %20)

### Limitations

- Only matches files to entities with existing pre-processing cases
- Requires structured, consistent folder organization
- Uses only the immediate parent folder name (not nested paths)
- Folder names must exactly match entity external_id values
- Does not work for files uploaded directly to root folders (minimum depth required)

## None Strategy

### Overview

The None strategy disables automatic file-to-entity matching. Files are not automatically associated with entities when added to the workflow order.

### How It Works

1. Files are added to the workflow order without entity associations
2. Cases are created for individual files (if "Create Cases For Non-Matches" is enabled)
3. Entity associations can be managed manually if needed

### Requirements

- No specific requirements for file metadata or organization
- Enable **Create Cases For Non-Matches** if you want cases created for uploaded files

### Configuration

When creating or editing a workflow order:

1. Set **Case Matching Strategy** to "None"
2. Enable **Create Cases For Non-Matches** to create cases for uploaded files (recommended)

### Example Use Cases

- **General File Processing**: Workflows that don't require entity association
- **Manual Assignment**: Cases where entity association will be determined later manually
- **Single-Entity Orders**: Workflow orders focused on a single entity or no specific entity

## Create Cases For Non-Matches

### Overview

The "Create Cases For Non-Matches" setting determines what happens to files that don't match any entity:

- **Enabled**: Non-matching files get their own cases created (one file per case, no entity association)
- **Disabled**: Non-matching files are not imported into the workflow order

### When to Enable

Enable this setting when you want to:
- Process all uploaded files, even if they don't match entities
- Review non-matching files manually to determine proper entity association
- Avoid losing data from files that failed to match

### When to Disable

Disable this setting when you want to:
- Only process files that successfully match to known entities
- Maintain strict entity organization requirements
- Avoid creating cases for stray or misplaced files

### Behavior by Strategy

**Geolocation Strategy**:
- Non-matches include: files without GPS data, files too far from any entity, files near entities without cases

**Ingestion Path Strategy**:
- Non-matches include: files in folders that don't match any entity external_id, files from entities without cases

**None Strategy**:
- All files are treated as non-matches (no matching attempted)

## Workflow Order Setup

### Step-by-Step Process

1. **Navigate to Workflow Orders**
   - Click 'Develop' in the top navigation
   - Click 'Workflows' under 'Assessments' in the side navigation
   - Click the 'Orders' tab
   - Click 'New Order'

2. **Configure Basic Settings**
   - Enter a name for your workflow order
   - Set the lock status if desired
   - Set the Original Source URL Filter if needed

3. **Choose Case Matching Strategy**
   - Select your preferred strategy: Geolocation, Ingestion path, or None
   - Review the help text describing each option

4. **Configure Strategy-Specific Settings**

   **For Geolocation**:
   - Set "Maximum Radius To Matched Entity" in meters
   - Decide whether to enable "Create Cases For Non-Matches"

   **For Ingestion Path**:
   - Ensure your entities have external_id values set
   - Ensure your files are organized in folders matching those external_id values
   - Decide whether to enable "Create Cases For Non-Matches"

   **For None**:
   - Enable "Create Cases For Non-Matches" if you want cases created for files

5. **Review and Create**
   - Click "Review Order"
   - Verify the settings and matched files count
   - Click "Create and Approve Order"

### Creating Pre-existing Cases

For Geolocation and Ingestion Path strategies to work, you need cases for your entities before uploading files.

**Option 1: Bulk Create via CSV**
1. Navigate to your workflow order
2. Use the bulk case creation feature
3. Upload a CSV with entity information (entity_id or entity_external_id)

**Option 2: Manual Case Creation**
1. Create cases individually through the UI
2. Associate each case with the appropriate entity

**Option 3: API Integration**
Use the Highlighter API to programmatically create cases for entities

## Troubleshooting

### Files Not Matching with Geolocation

**Check**:
- Files have valid GPS metadata (use EXIF viewer tools)
- Maximum radius is large enough to reach entities
- Entities have cases in the workflow order
- Entities have valid GPS coordinates set
- GPS coordinates are accurate (not default/placeholder values)
- Cases are in "pre-processing" state (not completed or failed)

### Files Not Matching with Ingestion Path

**Check**:
- Folder names exactly match entity external_id values (case-sensitive)
- Entities exist in your account with those external_id values
- Files are not in root or too-shallow folders (minimum depth required)
- URL encoding is not causing mismatch (system handles this, but verify paths)
- Entities have cases in the workflow order
- Cases are in "pre-processing" state

### No Cases Created for Non-Matches

**Check**:
- "Create Cases For Non-Matches" is enabled
- Workflow order is not locked
- Workflow has stages configured after the data source

### All Files Treated as Non-Matches

**Geolocation**:
- Verify files contain GPS metadata
- Check maximum radius setting is appropriate
- Ensure entities have geographic coordinates set

**Ingestion Path**:
- Verify folder structure matches entity external_id values
- Check entities exist with correct external_id values
- Review file paths for correct structure

## Choosing the Right Strategy

| Strategy | Best For | Requirements | Pros | Cons |
|----------|----------|--------------|------|------|
| **Geolocation** | Field data with GPS, known locations, outdoor assets | GPS metadata, entity coordinates | Automatic, location-based, flexible collection | Requires GPS data, accuracy limitations |
| **Ingestion Path** | Pre-organized data, structured collection, batch processing | Folder organization, external IDs | Works without GPS, deterministic, simple | Requires folder organization, manual setup |
| **None** | General processing, manual assignment, single entity | None | Flexible, no constraints | No automation, manual work required |

### Decision Guide

**Choose Geolocation if**:
- Your files contain GPS metadata (drone photos, geotagged images)
- You're working with spatially distributed entities
- Entity locations are known and relatively fixed
- File capture locations may vary slightly

**Choose Ingestion Path if**:
- Your files are already organized by entity in folders
- You have a reliable external ID system
- Files don't have GPS data
- You need deterministic, reproducible matching
- Field teams can follow folder naming conventions

**Choose None if**:
- You don't need automatic entity association
- You'll assign entities manually later
- Your workflow focuses on general file processing
- Entity relationships are complex or undefined

## Best Practices

### General Recommendations

1. **Plan Before Upload**: Choose your strategy before uploading files and organize accordingly
2. **Test with Small Batches**: Verify matching works correctly with a small test batch before bulk upload
3. **Monitor Results**: Review match rates and non-matches to identify issues
4. **Document Conventions**: Maintain clear documentation of naming conventions and requirements
5. **Train Your Team**: Ensure field teams and data collectors understand the requirements

### Data Quality

1. **Validate GPS Data**: Check that GPS coordinates are accurate and present
2. **Standardize External IDs**: Use consistent, unique identifiers for entities
3. **Clean File Paths**: Ensure folder structures are clean and consistent
4. **Regular Audits**: Periodically review non-matches to identify systematic issues

### Workflow Design

1. **Create Cases First**: Set up your entity cases before bulk file upload
2. **Enable Non-Match Handling**: Decide your approach for non-matching files early
3. **Use Appropriate Radius**: For geolocation, balance precision vs. coverage
4. **Structure for Success**: For ingestion path, establish folder conventions upfront

By understanding and properly configuring case matching strategies, you can automate the organization of files in your workflow orders, saving time and ensuring consistent entity associations throughout your assessment process.
