+++
title = "Assessment Workflow | Highlighter Concepts"
description = "Assessment Workflows in Highlighter AI systematically process data for evaluation. Define criteria, collect and analyze inputs, report findings, and drive action through iterative review."
date = 2021-05-01T08:00:00+00:00
updated = 2025-11-19T08:00:00+00:00
draft = false
weight = 200
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'An assessment workflow is a systematic sequence of activities within a broader business process designed to evaluate the performance, capabilities, needs, or condition of an entity or asset. Its goal is to generate reliable data for informed decision-making, strategic planning, and continuous improvement within the organization.'
toc = true
top = false
+++

## Business Process
A business process is a series of structured, related activities or tasks performed by people or machines to achieve a specific organizational goal. It involves a defined sequence of work steps, which can be manual, automated, or a combination of both.

These processes can be categorized into three different types:

* Management: These are processes that govern the operation of a system. They include strategic management, corporate governance, business process management, and others.

* Operational: These are the core processes that make up the value stream, such as purchasing, manufacturing, marketing, and sales.

* Supporting: These support the core processes and include accounting, recruitment, technical support, and more.

## Assessment Workflow

An assessment workflow is sub-process of a broader business process which reviews data coming into an organisation to initiate further downstream tasks.

In the context of a business process, an assessment workflow could serve multiple functions, including:

* Assessing the condition or performance of physical or intangible assets
* Measuring customer satisfaction or engagement
* Identifying sales opportunities or leads
* Auditing financial performance or compliance with regulations
* Evaluating the performance of employees, departments, or entire business units

Designing an assessment workflow usually involves several steps, such as defining the assessment criteria, collecting and analyzing relevant data, reporting findings, developing an action plan based on these findings, and regularly reviewing and adjusting the workflow as necessary.

By integrating assessment workflows into broader business processes, organizations can ensure continuous improvement, optimize resource allocation, maintain high standards of quality and compliance, and drive strategic decision-making.

Example Assessment Workflows:
* A patient enters Eastern Medical Clinic to work out why he is feeling ill:
    1. He consults a doctor
    2. The doctor orders a blood test
    3. the blood test is analyzed by a specialist who determines that the patient has an iron deficiency

This 3 step process is an assessment workflow carried out by Eastern Medical Clinic to discover what is wrong with their patients.


## Assessments

Assessments are the individual tasks that an agent carries out when progressing through an Assessment Workflow. These tasks could take the form of:
 * Detection or segmentation which localises objects in sensor data
 * Determining attributes through classifications (or numeric quantities) associated with those localisations. They may take boolean, enum, or numeric values.
 * Embeddings which are numeric vectors representing the semantic information of an object.
 * Identifying unique entities across multiple views across time and space of the same object.
 * Tracks are sets of localised detections in adjacent frames of a video or sections of text, such that each detection in the track captures the same entity.

See [Capabilities](../capabilities/) for more information and examples of the types of tasks agents complete.

Each of these assessments results in data that are claims about the world.

## Claims

Claims is data that results from an assessment performed by an agent. Each claim is a data point about an entity at a point in time eg., species of a fish. Since multiple different agents can assess the same entity, the resulting claims can be in conflict with each other. Currently Highlighter assumes the most recent claim in the assessment of a file is the official claim made (as close to a fact as the system can determine).

Claims, which result from an assessment workflow, are the central information used by the organisation to make decisions and take actions. This data is expected to conform to the Taxonomy specifed in Highlighter. See [Monitoring & Reporting](../monitoring/) for more information on how to review the data output by an Assessment Workflow.
