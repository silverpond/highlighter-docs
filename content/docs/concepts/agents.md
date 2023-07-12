+++
title = "Agents"
description = "Introduction to Agents"
date = 2021-05-01T08:00:00+00:00
updated = 2021-05-01T08:00:00+00:00
draft = false
weight = 40
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Agents are people and machines that work on the tasks in an assessment process.'
toc = true
top = false
+++

## Tasks

Agents work on tasks specified in an asssessment process. Typically in Highlighter this is assessing incoming data from a data sources, though it is possible for agents to take actions outside of assessing incoming data eg., sending an email, updating data in a 3rd party system etc.

## Capabilities

Capabilities refer to the specific skills, abilities, functions, or competencies that allow the agent (be it a person, or a machine, or a team that combines the two) to perform tasks effectively and contribute towards the successful completion of the assessment. Capabilities allow designers to build an assessment process of competent agents to carry out the work.

## People Agents

An assessment task can be carried out by people through the use of Highlighter's Assessment Tool. They can also learn how to perform the assessment by reviewing the taxonomy in the system.

## Machine Agents

Machine agents are software programs, often machine learning models, which can be deployed in Highlighter's cloud or on your servers to perform assessment tasks. They are taught to perform assessments according to the taxonomy defined in Highlighter.

### Training

To train a machine agent, there are three options:

1. Use a pre-trained machine learning model, e.g from [HuggingFace](https://huggingface.co/models) and upload the model artefact to run in Highlighter

2. Train your own machine learning model and upload the model artefact to run in Highlighter

3. Train a machine learning model using Highlighter
