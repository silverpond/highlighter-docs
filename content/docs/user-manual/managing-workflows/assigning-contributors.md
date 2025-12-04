+++
title = "Assigning Contributors to Workflows"
description = "Learn how to assign contributors at the workflow, workflow order, and step levels to control access and enable team collaboration in Highlighter."
date = 2025-11-19T08:00:00+00:00
updated = 2025-11-19T08:00:00+00:00
draft = false
weight = 45
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Control access to workflows, workflow orders, and specific steps by assigning users at multiple levels."
toc = true
top = false
+++

## Overview

Highlighter uses a three-tier assignment system to control who can access and work on different parts of your workflows. Understanding these levels is essential for properly configuring team access.

## The Three-Tier Assignment System

When assigning contributors to do work in Highlighter, you may need to make assignments at up to three different levels depending on your use case:

### 1. Workflow-Level Assignment (Required for Workflow Order Access)
Users must be assigned to a workflow before they can be assigned to any workflow orders within that workflow.

### 2. Workflow Order-Level Assignment (Optional but Common)
Once a user is assigned to a workflow, they can be assigned to specific workflow orders to restrict access.

### 3. Step-Level Assignment (Optional, Specific Step Types)
For data source and human assessment steps, you can assign specific users who will work on tasks in those steps.

## Level 1: Assigning Users to a Workflow

This is the foundational assignment level. Users must be assigned to a workflow to access its workflow orders.

### Steps to Assign Users to a Workflow

1. **Navigate to the Workflow**
   - Go to the Workflows section
   - Select the workflow where you want to add users

2. **Open the Admin Tab**
   - Click on the "Admin" tab in the workflow view

3. **Add Users**
   - In the right panel, you'll see a "Permissions" section
   - Click "Add User to Workflow" to assign an existing user
   - Or click "Create User and Add to Workflow" to create a new user and assign them simultaneously
   - Select the user(s) you want to add

4. **Confirm Assignment**
   - The user will now appear in the workflow's permissions list
   - They can now be assigned to workflow orders within this workflow

## Level 2: Assigning Users to a Workflow Order

After users are assigned to the workflow, you can optionally assign them to specific workflow orders to control access.

### Steps to Assign Users to a Workflow Order

1. **Prerequisite: Assign to Workflow First**
   - The user must already be assigned to the parent workflow (see Level 1 above)
   - If they aren't, assign them to the workflow first

2. **Navigate to the Workflow Order**
   - Go to the workflow
   - Click on the "Orders" tab
   - Select the specific workflow order

3. **Add Users to the Order**
   - On the right side panel, you'll see a "Permissions" section
   - Click "Add User to Order" to assign a user
   - Or click "Create User and Add to Order" to create and assign simultaneously
   - Select the user(s) from those already assigned to the workflow

4. **Access Control Behavior**
   - **Before any users are added**: All users assigned to the workflow can access the order
   - **After adding at least one user**: Only the specifically assigned users can access the order

## Level 3: Assigning Users to Specific Steps

For data source and human assessment steps, you can assign specific users who will be able to work on tasks in those steps.

### Assigning Users to Data Source Steps

Data source step assignments control who can upload files through that step.

1. **Navigate to the Step**
   - Go to your workflow
   - Click on the "Steps" tab
   - Click on the data source step you want to configure (or create a new one)

2. **Assign Contributors**
   - In the step configuration form, locate the "Assign Contributors" field
   - Select the users who should be able to upload files for this step
   - Multiple users can be selected

3. **Save the Step**
   - Click "Save" to confirm the assignments
   - Assigned contributors will be able to upload files for this data source step

### Assigning Users to Human Assessment Steps

Human assessment step assignments control who can work on review tasks in those steps.

1. **Navigate to the Step**
   - Go to your workflow
   - Click on the "Steps" tab
   - Click on the human assessment step you want to configure (or create a new one)

2. **Assign Users**
   - In the step configuration form, locate the "Assignees" field
   - Select the users who should be able to work on tasks for this step
   - Multiple users can be selected

3. **Save the Step**
   - Click "Save" to confirm the assignments
   - Assigned users will be able to see and work on tasks in their work queue for this step

## Common Assignment Scenarios

### Scenario 1: Open Access Workflow
All team members can work on any workflow order:
- Assign all users to the workflow (Level 1)
- Don't assign users to individual workflow orders
- Result: All workflow users can access all orders

### Scenario 2: Restricted Workflow Orders
Different teams work on different workflow orders:
- Assign all users to the workflow (Level 1)
- Assign specific users to each workflow order (Level 2)
- Result: Users can only access their assigned orders

### Scenario 3: Specialized Step Assignments
Specific users handle uploads or reviews:
- Assign all users to the workflow (Level 1)
- Optionally assign users to workflow orders (Level 2)
- Assign specific users to data source or human assessment steps (Level 3)
- Result: Only assigned users can upload files or work on review tasks for those steps

## Monitoring Contributor Activity

On the Steps tab of a workflow, you can view which users are assigned to each step:

- For **data source steps**: View assigned contributors who can upload files
- For **human assessment steps**: View assignees and see their activity statistics including:
  - Number of tasks checked out
  - Number of submissions completed
  - Number of assigned orders
  - Number of available tasks

## Troubleshooting

### Common Issues

**User Cannot Access a Workflow Order**
- **Check workflow assignment first**: Verify the user is assigned to the parent workflow in the Admin tab
- **Check order-specific permissions**: If any users have been added to the workflow order, verify this user is also added
- Remember: Users must be assigned to the workflow before they can be assigned to orders

**User Cannot See Tasks in a Human Assessment Step**
- **Check step assignment**: Verify the user is assigned in the step's configuration under "Assignees"
- **Check workflow order access**: Ensure the user has access to the workflow order containing the tasks (see above)
- **Verify tasks exist**: Check that there are actually pending tasks in that step

**User Cannot Upload Files to a Data Source Step**
- **Check step assignment**: Verify the user is assigned to the data source step under "Assign Contributors"
- **Check workflow access**: Ensure the user is assigned to the workflow
- **Verify step configuration**: Confirm the data source step is properly configured

**Cannot Add User to Workflow Order**
- **Prerequisite missing**: The user must first be assigned to the parent workflow
- **Solution**: Go to the workflow's Admin tab and add the user to the workflow first, then try adding them to the order

**Too Many or Too Few People Have Access**
- **Workflow order permissions behavior**: Remember that workflow orders have an "all or restricted" model:
  - If no users are assigned to an order, all workflow users can access it
  - Once you add even one user to an order, only assigned users can access it
- **Review your assignments**: Check who is assigned at each level (workflow, order, step)

### Getting Help

For additional assistance with contributor assignments:
- Review this three-tier assignment guide thoroughly
- Check the [Human Assessment Steps](/docs/user-manual/managing-workflows/human-assessment-steps/) documentation
- Check the [Creating Workflow Orders](/docs/user-manual/managing-workflows/creating-workflow-orders/) documentation
- Contact your Highlighter administrator

## Related Documentation

- [Human Assessment Steps](../human-assessment-steps/)
- [Creating Assessment Workflows](../creating-assessment-workflows/)
- [Creating Workflow Orders](../creating-workflow-orders/)
- [Machine Assessment Steps](../machine-assessment-steps/)
