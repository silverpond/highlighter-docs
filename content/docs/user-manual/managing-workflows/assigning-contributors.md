+++
title = "Assigning Contributors to Workflow Steps"
description = "Learn how to assign contributors to different workflow steps in Highlighter AI, including data sources, human assessment steps, and quality control tasks."
date = 2025-11-19T08:00:00+00:00
updated = 2025-11-19T08:00:00+00:00
draft = false
weight = 45
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Assign contributors to workflow steps and manage their access to data sources, assessment queues, and review tasks."
toc = true
top = false
+++

## Overview

The Contributor role enables team members to work across different types of workflow steps with a unified interface. Contributors can be assigned to data sources and human assessment steps, allowing flexible team-based workflow execution.

## What is a Contributor?

A Contributor is a user role that allows individuals to:
- Work on assigned workflow steps
- Upload data using data source steps
- Review and assess items in human assessment queues

## Assigning Contributors to Workflow Steps

### Prerequisites
- Workflow with defined steps
- Users with Contributor role permissions
- Appropriate access rights to the workflow

### Assignment Process

1. **Navigate to Workflow Configuration**
- Open your assessment workflow
- Select the workflow step where you want to assign contributors
- Access the step configuration panel

2. **Select Contributors**
- In the step settings, locate the "Assigned Contributors" section
- Choose from available users with Contributor role
- Add multiple contributors if the workload requires team collaboration

3. **Save Configuration**
- Confirm the contributor assignments
- The system will immediately grant access to assigned contributors

### Monitoring Contributor Activity

On the Steps tab of a workflow, you can monitor step performance and track progress with the following metrics:

- **Assigned Agents**: Number of contributors assigned to the step
- **Active Agents**: Current activity level (varies by step type):
  - Human assessment steps: Number of tasks currently being worked on
  - Machine assessment steps: Number of running instances
- **Total**: Total number of tasks in the step
- **Pending**: Number of tasks waiting to be processed
- **Succeeded**: Number of successfully completed tasks

These metrics help you monitor workload distribution, identify bottlenecks, and ensure contributors have an appropriate amount of work assigned.

## Troubleshooting

### Common Issues

**Contributors Cannot See Assigned Tasks**
- Verify contributor role permissions are correctly set
- Confirm the contributor is assigned to the correct workflow step
- Check that tasks are available in the queue
- Ensure the workflow step is active

**Assignment Changes Not Taking Effect**
- Refresh the workflow configuration
- Verify changes were saved correctly
- Check for any validation errors in the assignment
- Contact support if issues persist

**Workload Imbalance**
- Review task distribution settings
- Adjust assignment methods if needed
- Consider adding or removing contributors
- Monitor queue metrics regularly

### Getting Help

For additional assistance with contributor assignments:
- Consult your workflow administrator
- Review the Human Assessment Steps documentation
- Contact Highlighter support team
- Check the troubleshooting guide

## Related Documentation

- [Human Assessment Steps](../human-assessment-steps/)
- [Creating Assessment Workflows](../creating-assessment-workflows/)
- [Creating Workflow Orders](../creating-workflow-orders/)
- [Machine Assessment Steps](../machine-assessment-steps/)
