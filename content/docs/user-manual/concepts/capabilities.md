+++
title = "Capabilities | Highlighter Concepts"
description = "Highlighter AI defines agent capabilities, human or machine skills for data sourcing, assessments, and custom workflows to deliver accurate, scalable insights."
date = 2021-05-01T08:00:00+00:00
updated = 2021-05-01T08:00:00+00:00
draft = false
weight = 300
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Capabilities refer to the specific skills, abilities, functions, or competencies that allow the agent (be it a person, or a machine, or a team that combines the two) to perform tasks effectively and contribute towards the successful completion of the assessment. Capabilities allow designers to build an assessment workflow of competent agents to carry out the work.'
toc = true
top = false
+++

## Common Capabilities in Highlighter

#### Data Sources
Data Sources are capabilities of agents to load data into Highlighter for processing.

|Type|Human Agents|Machine Agents|
|-|-|-|
|Files|Manually Uploaded|Automatically Recorded|
|Streaming Video (RTSP)| N/A| Supported|
|Streaming Video (WebRTC)| N/A| Supported|

#### Assessments
Assessments tasks are sub-tasks of a larger assessment workflow that an organisation wishes to carry out.

|Type|Human Agents|Machine Agents|
|-|-|-|
|Detection| Supported| Supported|
|Classification| Supported| Supported|
|Segmentation| Supported| Supported|
|Lines| Supported| Upcoming Release|
|Key Points| Supported| Upcoming Release|
|Embedding| Not Supported| Upcoming Release|
|Tracking| Supported| Supported|

#### Development
Development tasks are tasks carried out by people to develop an assessment workflow, agent or capability. Some common tasks are:
  * Develop an Assessment Workflow
  * Develop a Machine Agent
  * Develop a Machine Capability
  * Train a person's capability

## Example Custom Capabilities

Every organisation's assessment workflow is unique, and Highlighter allows each organisation to customise capabilities to suit their needs. Here are some example capabilites:
  * identify cross-arms in photos of electricity distribution poles
  * identify fish in videos along with classifying species and measuring their lengths
  * identify diseases in pathology images
  * identify projects in articles of the web
