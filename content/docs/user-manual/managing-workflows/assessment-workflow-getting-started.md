+++
title = "Assessment Workflows"
description = "Get started with Highlighter AI's Assessment Workflows. Configure data sources, AI and human assessment steps, routing logic, and launch scalable workflows for operational clarity."
date = 2025-05-01T08:00:00+00:00
updated = 2025-11-19T08:00:00+00:00
draft = false
weight = 3
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Learn how to create and configure your first assessment workflow in Highlighter through this comprehensive tutorial."
toc = true
top = false
+++

## Overview

This tutorial will guide you through creating a complete assessment workflow from start to finish. You'll learn how to set up data sources, configure assessment steps, assign reviewers, and monitor progress.

## Prerequisites

Before starting this tutorial, ensure you have:
- Access to a Highlighter platform account
- Administrator or workflow creator permissions
- Sample data files to work with
- Basic understanding of your assessment requirements

## Tutorial Goals

By the end of this tutorial, you will have:
- Created a functional assessment workflow
- Configured both machine and human assessment steps
- Set up data routing and quality controls
- Launched your first workflow order
- Monitored workflow performance

## Step 1: Planning Your Workflow

### Define Your Objectives
Before creating the workflow, clearly define:
- **Purpose**: What are you trying to assess or evaluate?
- **Input Data**: What type of data will you be processing?
- **Output Goals**: What decisions or classifications do you need?
- **Quality Standards**: What level of accuracy is required?

### Example Scenario
For this tutorial, we'll create a workflow that:
- Processes uploaded images for quality assessment
- Uses AI to detect potential issues automatically
- Routes questionable images to human reviewers
- Generates final approval/rejection decisions

## Step 2: Creating the Workflow

### Access the Workflow Builder
1. Log into your Highlighter platform
2. Navigate to the "Workflows" section
3. Click "Create New Workflow"

### Basic Workflow Configuration
1. **Workflow Name**: "Image Quality Assessment"
2. **Description**: "Automated quality assessment of uploaded images with human review escalation"

The workflow builder provides a visual, node-based interface where you can drag and drop different types of steps and connect them together to create your assessment workflow.

## Step 3: Configuring Assessment Steps

Highlighter workflows consist of four types of steps that you can connect together:

1. **Data Source Steps**: Import data from configured data sources
2. **Machine Assessment Steps**: Automated processing using AI agents
3. **Human Assessment Steps**: Manual review and annotation queues
4. **Filter Steps**: Filter data based on criteria without creating tasks

### Data Source Step
1. **Step Type**: Data Source
2. **Configuration**:
   - Select an existing data source from your project
   - In the **Assign Contributors** field, assign users who can manage this data source step
   - The step name will automatically match your data source name

Data source steps serve as entry points to your workflow, importing files and creating cases that flow through subsequent steps.

### Machine Assessment Step
1. **Step Name**: "AI Quality Analysis"
2. **Step Type**: Machine Assessment
3. **Configuration**:
   - Select a task definition that specifies what the machine agent should do
   - Link to a specific machine agent version
   - Configure cloud instance settings (if using cloud-hosted agents)

Machine assessment steps automatically process cases using AI agents. You can monitor:
- Task statistics (pending, running, failed, success)
- Cloud instance status (if applicable)
- Agent logs and performance metrics

After processing, cases automatically flow to the next connected step(s) in your workflow.

### Human Assessment Step
1. **Step Name**: "Expert Review"
2. **Step Type**: Human Assessment
3. **Configuration**:
   - **Queue Name**: Name for this assessment step (required)
   - **Assignees**: Select contributor users who can work on tasks in this step (multi-select)
   - **Previous Step**: Connect to the upstream step in your workflow (optional)
   - **Batch Size**: Configure how many items a reviewer sees at once
   - **Queue Capacity**: Set maximum concurrent tasks (optional - unlimited if not specified)
   - **Consumable**: Enable/disable consumable queue behavior
   - **Lockable**: Enable/disable task locking mechanism

Human assessment steps create manual review tasks that appear in the assigned reviewers' work queues.

### Filter Step
1. **Step Type**: Filter
2. **Configuration**:
   - See your admin to configure filters.

Filter steps route cases without creating tasks. They automatically pass matching cases to the next connected step, allowing you to implement conditional routing logic in your workflow.

## Step 4: Workflow Logic and Routing

### Connecting Steps
In the visual workflow builder, connect your steps together by drawing a connection from one step to the next. Workflows follow a linear flow where each step connects to one next step.

**Example Flow**:
Data Source → Machine Assessment → Filter Step → Human Review

### How Cases Flow
- When a case completes a step, it automatically moves to the next connected step
- All completed cases from a step proceed to the next step
- Filter steps evaluate cases and only allow those matching the filter criteria to proceed to the next step. Unmatched cases skip all remaining steps and are marked as complete
- This allows you to control which cases require human review vs. which can be automatically completed

## Step 5: Testing Your Workflow

Once you've configured your workflow steps and connections:

1. **Save Your Workflow**: Click the Save button in the workflow builder to persist your configuration
2. **Create a Workflow Order**: Navigate to the workflow and create a new workflow order to begin processing
3. **Add Test Data**: Start with a small batch of representative data to verify the workflow functions as expected
4. **Monitor Progress**: Use the step statistics to track cases as they move through your workflow
5. **Verify Results**: Check that cases are being processed correctly at each step

## Step 6: Running Your Workflow

### Creating Workflow Orders
To process data through your workflow:

1. **Create a New Workflow Order**: From the workflow page, create a new order
2. **Add Files**: Upload or import files into the workflow order
3. **Case Matching** (if applicable): Choose how to match imported files to existing entities:
   - By geolocation
   - By ingestion path (folder structure)
   - No matching (create new cases)
4. **Start Processing**: Once files are added, cases will begin flowing through your workflow automatically

### Managing Active Workflows
- **Monitor Statistics**: Each step shows counts of pending, running, failed, and successful tasks
- **User Assignment**: Ensure reviewers are assigned to human assessment steps so they can access their work queues
- **Machine Agents**: For machine assessment steps, verify that agents are running and processing tasks
- **Add More Data**: You can add additional files to existing workflow orders as needed

## Step 7: Monitoring Your Workflow

### Task Statistics by Step
Each workflow step displays real-time statistics:
- **Pending Tasks**: Tasks waiting to be processed
- **Running Tasks**: Tasks currently being processed
- **Failed Tasks**: Tasks that encountered errors (last 7 days)
- **Successful Tasks**: Tasks that completed successfully (last 7 days)

### Machine Assessment Monitoring
For machine assessment steps, you can monitor:
- **Agent Status**: Whether agents are running, stopped, or failed
- **Instance Information**: Cloud instance details if using cloud-hosted agents
- **Agent Logs**: View execution logs to debug issues
- **Processing Rate**: Track how quickly tasks are being completed

### Human Assessment Monitoring
For human assessment steps, you can view:
- **Contributor Statistics**: See how many tasks each reviewer has checked out and completed
- **Available Tasks**: Track how many tasks are available for review
- **Assigned Orders**: View which reviewers are assigned to which workflow orders

### Optimization
Based on monitoring data, you can:
- Adjust user assignments if workload is unbalanced
- Start or stop machine agents as needed for processing

## Troubleshooting Common Issues

### Low Throughput
- **Check Machine Agents**: Ensure machine agents are running and not in a failed state
- **Verify User Assignment**: Make sure reviewers are assigned to human assessment steps
- **Review Filter Criteria**: Check if filters are too restrictive and blocking cases
- **Monitor Failed Tasks**: Investigate and retry any failed tasks

### Tasks Not Progressing
- **Check Step Connections**: Verify steps are properly connected in the workflow builder
- **Review Filter Logic**: Ensure filter criteria are correctly configured to pass cases
- **Verify Data Source**: Confirm files were successfully imported into the workflow order
- **Check Task Leasing**: Ensure tasks aren't stuck in a locked/leased state

## Next Steps

Now that you've created your first workflow, you can:

1. **Configure Taxonomy**: Define object classes, attributes, and taxon groups for your specific classification needs
2. **Add Team Members**: Invite users to your workflow and assign them roles and permissions
3. **Develop Machine Agents**: Create custom machine assessment agents with training artifacts and inference configurations
4. **Create Datasets**: Build curated collections from annotations for training and evaluation
5. **Create Multiple Workflows**: Build different workflows for different assessment needs

## Additional Resources

- [**Creating Assessment Workflows**](/docs/user-manual/managing-workflows/creating-assessment-workflows/): Detailed guide on workflow concepts and architecture
- [**Human Assessment Steps**](/docs/user-manual/managing-workflows/human-assessment-steps/): Learn more about configuring human review queues
- [**Machine Assessment Steps**](/docs/user-manual/managing-workflows/machine-assessment-steps/): Deep dive into machine agent configuration
- [**Working in the Assessment Editor**](/docs/user-manual/assessing-and-labelling/working-in-the-assessment-editor/): Guide for reviewers performing assessments

You've successfully created your first assessment workflow in Highlighter.
