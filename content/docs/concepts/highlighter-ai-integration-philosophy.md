+++
title = "Agents"
description = "Introduction to Agents"
date = 2021-05-01T08:00:00+00:00
updated = 2021-05-01T08:00:00+00:00
draft = false
weight = 100
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Agents are people and machines that work on the tasks in an assessment process, or work on developing and monitoring the assessment process itself.'
toc = true
top = false
+++

## Tasks

Agents work on tasks specified in an asssessment process. Typically in Highlighter this is assessing incoming data from a data sources, though it is possible for agents to take actions outside of assessing incoming data eg., sending an email, updating data in a 3rd party system etc.

## Capabilities

Capabilities are skills that agents have that carry out work in Highlighter. Find out more about [capabilities →](../capabilities/).

## Deploy to Assessment Processes

When you want an agent to get some work done, you deploy them to [assessment processes](../assessment-process/) in Highlighter to complete tasks.

## People Agents

An assessment task can be carried out by people through the use of Highlighter's Assessment Tool. They can also learn how to perform the assessment by reviewing the taxonomy in the system.

Another common task are for people on your team to work on

## Machine Agents

Machine agents are software programs, often machine learning models, which can be deployed in Highlighter's cloud or on your servers to perform assessment tasks. They are taught to perform assessments according to the taxonomy defined in Highlighter.

### Deployment of Machine Agents

You can deploy machine agents to different locations to perform work depending on the needs of your solution.


|Location|Machine Agents|
|-|-|
|<div style="width:300px">Highlighter Cloud</div>|<div style="width:150px">Supported</div>|
|On-Premise Server|Supported|
|Edge Device|Supported|

|Platform|Machine Agents|
|-|-|
|<div style="width:360px">Linux</div>|<div style="width:150px">Supported</div>|
|Windows|Supported through [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)|

|Language|Machine Agents|
|-|-|
|<div style="width:300px">Python</div>|<div style="width:150px">Supported</div>|
|Golang|Upcoming Release|


### Training

To train a machine agent, there are three options:

1. Use a pre-trained machine learning model, e.g from [HuggingFace](https://huggingface.co/models) and upload the model artefact to run in Highlighter

2. Train your own machine learning model and upload the model artefact to run in Highlighter

3. Train a machine learning model using Highlighter

### Monitoring & Evaluation

Evaluation is the analysis of the efficiency or effectiveness of an agent in carrying out an assigned task. This could include a measurement of how well the agent is carrying out the tasks eg., time taken, cost, accuracy.

Where an evaluation is an analysis conducted at one point in time, monitoring is the continuous analysis of the efficiency and effectiveness of an agent in carrying out a task.

#### People

In addition to measuring accuracy, we allow agents to record their time in timesheets to help with evaluating how well they're carrying out their task.

#### Machines

Highlighter tracks the resource usage of each agent. Resource usage can be measured in:
* Seconds it takes for a machine to complete work
* Number of seconds in a file processed (eg., audio, video)
* Words processed
* Tokens processed by an LLM
