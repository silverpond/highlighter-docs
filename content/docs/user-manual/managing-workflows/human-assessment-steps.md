+++
title = "Human Assessment Steps"
description = "Configure human assessment steps in Highlighter AI, assign contributors, configure queue settings, and monitor task progress for manual review workflows."
date = 2025-05-01T08:00:00+00:00
updated = 2026-06-25T08:00:00+00:00
draft = false
weight = 40
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Learn how to set up human assessment steps where contributors manually evaluate and process data in your workflows."
toc = true
top = false
+++

## Overview

Human assessment steps involve manual review and processing by human experts. These steps are essential for tasks requiring human judgment, quality assurance, edge case handling, and training data creation.

## Creating Human Assessment Steps

### Prerequisites
- Defined review criteria and guidelines
- Trained reviewers with appropriate expertise
- Clear workflow requirements and expectations
- Access to workflow configuration tools

### Basic Setup

When creating a human assessment step, you configure the following:

1. **Queue Name**: Descriptive name for the assessment queue
2. **Step Type**: Select "Human Assessment"
3. **Contributor Assignment**: Assign team members who can work on tasks in this step
4. **Previous Step** (optional): Link this step to a previous step in your workflow
5. **Queue Settings**:
   - **Queue Capacity** (optional): Maximum number of tasks in the queue
   - **Batch Size** (optional): Number of items to display at once
   - **Consumable**: Whether tasks are consumed when completed
   - **Lockable**: Whether tasks can be locked for exclusive access

> **Note**: Contributors work across all workflow step types using a unified interface. See [Assigning Contributors to Workflow Steps](../assigning-contributors/) for detailed assignment instructions.

## Shadow Entities

Shadow entities let you hide entities that aren't relevant to this step so contributors can focus on the task at hand, while still keeping potentially-useful inferences from earlier steps accessible. Entities carried over from previous steps that don't match the step's **key attribute** rules are hidden in the assessment editor instead of being drawn as normal annotations — contributors can reveal an individual one by hovering over it.

When editing a human assessment step, configure shadow entities in the **Shadow Entities** section:

1. Select **Enable Shadow Entities** to turn the feature on for the step.
2. Under **Key Attributes**, add one or more rules describing which entities are relevant:
   - Click **+ Add Key Attribute** to add a rule.
   - Choose an attribute from the dropdown.
   - Optionally choose a specific value, or leave it as **Any value** to match any entity that has that attribute.
   - Use the **×** button to remove a rule.
3. Save the step.

Rules combine with OR logic: an entity stays fully visible if it matches at least one rule, and entities matching no rule are shadowed. With the feature enabled but no rules configured, every carried-over entity is shadowed.

Contributors can bring a shadowed entity back into their working set from the editor — see [Shadow Entities](../../assessing-and-labelling/working-in-the-assessment-editor/#shadow-entities) in *Working in the Assessment Editor*.

## Assigning Contributors

### How to Assign Contributors

Contributors are assigned when creating or editing a human assessment step:

1. Navigate to your workflow and create or edit a human assessment step
2. In the **Assignees** field, select one or more users from your account
3. Assigned contributors will be able to work on tasks for this step
4. Save the step to apply the assignments

### Monitoring Assigned Contributors

On the step details page, you can view information about assigned contributors:

- **Name and Email**: Contributor contact information
- **Checked Out**: Number of tasks currently being worked on
- **Submissions**: Total number of completed submissions
- **Assigned Orders**: Number of workflow orders assigned to the contributor
- **Available Tasks**: Number of tasks available to work on

For step-by-step instructions on assigning contributors, see [Assigning Contributors to Workflow Steps](../assigning-contributors/).

## Using Human Assessment Steps

### Contributor Workflow

Contributors assigned to human assessment steps follow this workflow:

1. **Task Access**
- Log into the Highlighter platform
- Navigate to assigned tasks queue
- Select tasks based on priority and deadline
- Begin review process following guidelines

2. **Review Process**
- **Data Examination**: Thorough review of input data
- **Annotation/Classification**: Apply labels or classifications
- **Quality Assessment**: Evaluate data quality and completeness
- **Decision Making**: Make required judgments or decisions

3. **Task Completion**
- **Result Recording**: Document findings and decisions
- **Quality Verification**: Double-check work for accuracy
- **Submission**: Submit completed reviews
- **Notes Documentation**: Add relevant comments or observations

## Step Management Features

### Available Actions

On the step details page, you can:

- **View Task Statistics**: See total, pending, and succeeded task counts
- **Unlock Remaining Tasks**: Release locked tasks back to the queue
- **View Filters**: See any filters applied to the queue
- **Monitor Contributors**: Track who is working on tasks and their progress

### Workflow Integration

Human assessment steps can be:

- **Connected in Sequence**: Link steps together to create multi-step workflows
- **Combined with Machine Steps**: Use machine assessment before or after human review
- **Filtered**: Apply filters to determine which cases flow to this step

## Best Practices

### Effective Step Configuration
- Use descriptive queue names that clearly indicate the purpose of the step
- Set appropriate batch sizes for your team's review capacity
- Configure queue capacity limits to prevent overwhelming contributors
- Link steps in a logical sequence that matches your workflow process

### Contributor Management
- Assign contributors with relevant expertise to each step
- Monitor the contributor metrics on the step details page
- Balance workload across team members
- Provide clear instructions and training for the assessment tasks

### Workflow Design
- Start with simple single-step workflows before adding complexity
- Use filters to route appropriate cases to each step
- Combine machine and human assessment steps where beneficial
- Monitor task statistics to identify bottlenecks

## Troubleshooting

### Common Issues

**Contributors Cannot Access Tasks**
- Verify the contributor is assigned to the step in the Assignees field
- Check that there are tasks available in the queue (check the Pending count)
- Ensure the workflow step is properly configured and linked to previous steps

**Tasks Not Flowing to the Step**
- Check that the previous step is correctly linked
- Verify any filters are configured correctly
- Ensure tasks exist in the workflow and are being created

**High Task Backlog**
- Check the Pending task count on the step details page
- Consider adding more contributors to the step
- Review if batch size or queue capacity settings are appropriate
- Use the "Unlock Remaining" button if tasks are stuck in a locked state

**Step Configuration Issues**
- Ensure the queue name is set
- Verify contributors are properly assigned
- Check that the step has an associated image queue

### Getting Help

For additional assistance with human assessment steps:
- Review the step details page for current status and metrics
- Check the task statistics to understand workflow health
- Consult your workflow administrator
- Contact Highlighter support team

## Related Documentation

- [Assigning Contributors to Workflow Steps](../assigning-contributors/) - Detailed guide on contributor assignment
- [Creating Assessment Workflows](../creating-assessment-workflows/) - Design effective workflows
- [Machine Assessment Steps](../machine-assessment-steps/) - Combine human and machine assessment
- [Creating Workflow Orders](../creating-workflow-orders/) - Manage workflow execution
- [What's New](../../../about/whats-new/) - Latest platform updates and improvements
