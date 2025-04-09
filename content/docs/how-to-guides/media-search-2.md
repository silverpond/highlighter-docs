+++
title = "Media Search"
description = "Using the media search page in Highlighter"
date = 2023-09-26T08:00:00+00:00
updated = 2023-09-26T08:00:00+00:00
draft = false
weight = 10
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

Once data has been uploaded and processed in Highlighter, it is common to look for files to download, or to add to new orders for processing. You can jump to those subtasks below:

- <a href="#search-for-files">Search for files</a>
- <a href="#download-files">Download files</a>
- <a href="#add-files-to-a-process-order">Add files to a process order</a>

## Find the page

Click 'Develop' in the top navigation then click 'Media' => 'Search' in the side navigation.

## Search for files

#### Set search filters

On the left of the page are filters that let you to look at your files in different ways. Set your desired filters then click the 'Search' button at the bottom to see files matching those filters. For example, to see files that match Data Source 'My data source', choose that data source in the Data Sources dropdown then click Search. You can choose multiple filters.

For more information about individual filters, see <a href="#filters">Filters</a> below.

#### See search results

In the top left you see a summary of the number of files you are currently seeing. For example if you see '100 of 450 files', that means you currently have 450 results for your current search criteria, but you are only seeing 100 of them because they are paginated. Click a number to go to that page of results, click the Next/Prev buttons, or the First/Last buttons.

To change the number of results per page, see the section below <a href="#results-per-page">Results Per Page</a>.

## Take actions

Once you have your results, you can take a variety of actions.

#### Take actions on a single file

1. View a single file by clicking the eye icon on a file thumbnail.
2. Edit a single file in the annotation tool by clicking the pencil icon on the file thumbnail. This option is only available if an assessment process filter is set.
3. Download a single file clicking the download icon on the file thumbnail.

#### Download files

Download all files by clicking the 'Download Files' button. Files will be downloaded one by one. Your browser might prompt you to allow multiple downloads from this site - click 'Allow'. To cancel the download, close the browser window/tab.

This will only download files shown on the current page of results. Download the rest of the files by advancing to each page in turn as described in the <a href="#see-search-results">See search results</a> section, and clicking the 'Download Files' button there.

This process can be helped by increasing the number of results shown on each page as described in the <a href="#filter-results-per-page">Filter results per page</a> section.

#### Add files to a process order

To add files to a process order, click the 'Add to Order' button. In the dialog box that appears, select the desired order, then click 'Add Files To Order'. You will see a message confirming the files have been added, or with any errors.

## Filters

#### Hide/Show overlays

Click the 'Hide/Show Overlays' button to hide/show the overlays on individual files that contain annotations/bounding boxes.

#### Reset filters

Use the 'Reset' button to reset all filters.

#### See only the latest submissions

Tick the 'Only Latest Submissions' box to only show results where the filter criteria occur in the latest assessments on a file.

#### Filter by File IDs

Enter one or more IDs of desired files in the 'File ID(s)' box to show results where that matches the Highlighter database ID of files. Comma-separate to use multiple IDs.

#### Filter by Original Source URL

Enter all or part of the original source URL of desired files. This will match the text in the URL from which the file was original ingested into Highlighter.

#### Filter by Content Types

Choose one or more from a list of file content types, for example image, video, audio etc.

#### Filter by File Metadata Key

Choose a desired key that exists in the metadata of files. This is used in conjuction with the next filter, File Metadata Value.

#### Filter by File Metadata Value

Choose the desired value of the key provided above in File Metadata Key.

#### Filter by Data Sources

Choose one or more data sources that contain desired files.

#### Filter by Human Assessment Stages

Choose one or more human assessment stages containing desired files.

#### Filter by Checked Out By Users

Choose one or more users who have checked out desired files in a human assessment stage.

#### Filter by Completed in Queue status

Choose whether files have been completed in a human assessment stage or not.

#### Filter by Datasets

Choose one or more datasets containing desired files.

#### Filter by Assessment Processes

Choose one or more assessment processes containing desired files.

#### Filter by Assessment Process Orders

Choose one or more assessment process orders containing desired files. To use this filter, you need to also set the Assessment Process filter, as above, to the process that contains the selected assessment process order.

#### Filter by Capabilities

Choose one or more capabilities that have made machine assessments on desired files.

#### Filter by Training Runs

Choose one or more training runs that have made machine assessments on desired files.

#### Filter by Machine Assessment Stages

Choose one or more machine assessment stages containing desired files.

#### Filter by Object Classes

Choose one or more object classes contained in assessments on desired files.

#### Filter by Object Class intersection

Choose one or more object classes whose annotations physically intersect annotations of the main object class, from the ‘Object Classes’ dropdown above.

#### Filter by Object Classes not contained

Choose one or more object classes to return file results with annotations that don't contain them.

#### Filter by users who have submitted

Choose one or more users who made assessments on desired files.

#### Filter by roles that have submitted

Choose one or more roles of users who made assessments on desired files.

#### Filter by users who have made annotations

Choose one or more users who made annotations on desired files.

#### Filter by Annotation Status

Choose a status of annotations made on desired files.

#### Filter by Attributes

Choose one or more attributes present in assessments made on desired files. For each attribute chosen, another input will appear allowing you to select a value for that attribute. The type of the attribute dictates th type of the new input. For example if you choose a string attribute, the new input that appears will be a text box, if you choose an enum attribute, the new input will be a dropdown.

#### Filter by Object Status

Choose an object status of assessments made on desired files. For example, if you choose 'Object Identified', files will be returned that have assessments containing annotations.

#### Filter by assessments that are flagged

Choose a flagged status on assessments made on desired files. For example, if you choose 'Yes', files will be returned that contained flagged assessments.

#### Filter by Files Added data range

Define a date range within which desired files were added.

#### Filter by Assessment Submitted date range

Define a date range within which assessments were made on desired files.

#### Filter Results Per Page
To change the number of results per page, scroll down the bottom of the filters section to the Results Per Page dropdown. Choose the desired number of results per page, then click Search. Note - the more results per page, the longer the page will take to load. If the page times out before loading, reduce the number of results per page.
