+++
title = "Creating Workflow Orders"
description = "Creating Workflow Orders in Highlighter"
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

Work in a Highlighter Workflow can be divided up into Workflow Orders. Each Workflow Order can represent a particular grouping of data files that you want to keep separate. This might be for the purpose of ingesting them, tracking their flow through Highlighter, or exporting assessment results for them separately.

Workflow Orders are a way of dividing up the work of your Assessment Workflow into manageable chunks. Each Workflow Order can match a certain subset of the data in your process' data source, allowing you to handle the processing of different groupings of data separately.

A Workflow Order funnels work through a sequence of Workflow Stages. For example, the sequence might be Data Source -> Machine Assessment Stage -> Human Assessment Stage. The following instructions assume your sequence of Workflow stages has already been set up, and includes a data source as the first stage.

- <a href="#navigate-to-the-workflow-orders-page">Navigate To The Workflow Orders Page</a>
- <a href="#manually-create-workflow-orders">Manually Create Workflow Orders</a>
- <a href="#bulk-create-workflow-orders">Bulk-Create Workflow Orders</a>

## Navigate To The Workflow Orders Page

Click 'Develop' in the top navigation then click 'Workflows' under 'Assessments' in the side navigation. Then click the 'Orders' tab.

## Manually Create Workflow Orders

### Create New Workflow Order
Click the 'New Order' button then fill out the required fields.
<ul>
  <li><em>Name</em> - A name is created for you with the current date and time but this can be altered or replaced if needed.</li>
  <li><em>Lock and prevent addition of new files to order</em> - Locked orders are unchangeable once they are created, and new files cannot be added.</li>
  <li><em>Original Source URL Filter</em> - The original source URL filter defines a path within the folder structure of the S3 bucket belonging to the Workflow's data source. Only files with source URLs matching this path will be added to the Workflow Order. This allows you to group files in the folder structure of the data source into separate process orders.</li>
</ul>

Click the 'Review Order' button.

### Review Order
Check the data presented including number of files matched and the list of matched folders. If you need to make changes, you can click the 'Back to New Order' button. Otherwise click 'Create and Approve Order'.

You will be returned to your Workflow page with a message indicating whether it was successful. Scroll down again to the 'Orders' section and locate the new Workflow Order in the list.

## Bulk-Create Workflow Orders
You can also create Workflow Orders in bulk by uploading a CSV. This saves time and reduces errors when you have a lot of Orders to create.

### Upload via CSV

Navigate to the Orders page as <a href="#navigate-to-the-workflow-orders-page">above</a> and click the 'Create via CSV' button.

### Select a CSV and set options

You will see instructions about the format of CSV required. Once you have created your CSV, click the 'Select CSV' button and choose your CSV file.

Also set the 'State of Orders' dropdown to indicate whether you want the new Workflow Orders to be created as 'draft' or 'approved'. The state of an order is a way to indicate whether it's a work-in-progress that you will make further changes to, or whether it's finished and approved.

Then click 'Create Orders' and you'll be redirected to your orders page, with a message indicating the results, for example:<blockquote>Successfully imported orders: 30 total, 30 created, 0 skipped due to same name, 0 skipped due to same filter original source url.</blockquote> You can change your CSV and try again - only orders that don't already exists in the system will be created.

