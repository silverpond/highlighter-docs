+++
title = "Evaluation"
description = "Evaluating agents and the assessment process in Highlighter"
date = 2021-05-01T08:00:00+00:00
updated = 2021-05-01T08:00:00+00:00
draft = false
weight = 500
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Evaluation is the continual analysis of the performance of the assessment process and work completed by Agents.'
toc = true
top = false
+++

[Evaluation](../evaluation/) aims to provide data about how the claims are generated in the Assessment Process, while [Monitoring & Reporting](../monitoring/) aims to provide the data out of the Assessment Process itself. The purpose of the evaluation is to identify areas of improvement in the Assessment Process itself, and the purpose of monitoring & reporting is to understand the subject under assessment.


## Metrics
A metric is a time-ordered measurable value of the performance of the work being completed. Metrics can be used to measure all kinds of things about the agent or the work being completed. For example:
* Accuracy
* Processing Time
* Throughput
* Model Size
* RAM usage

Highlighter provides certain metrics by default such as Accuracy, though you can create your own metric and upload data points via our API.

## Data Points
A data point is a value of the metric at a point in time. You can see a metric as a variable, and the data points as values for that variable over time.

## Datasets
Datasets represent the work being completed, and helps us to perform apples-to-apples comparisons on metrics such as accuracy, latency or throughput.

## Metric Types
The list of standard metrics calculated by Highlighter are listed below:

#### Accuracy

Accuracy is the fraction of claims (EAVTs) that our agents got right, which is the total number of correct claims divided by the total number of claims.


$$
 Precision = {\frac{True\ Positives + True\ Negatives} {True\ Positives + True\ Negatives + False\ Positives + False\ Negatives}}
$$

The Accuracy metric has challenges with class-imbalanced datasets, so consider using Precision and Recall metrics to have a better understanding of performance.


#### Precision

Precision is the fraction of positive claims (EAVTs) that are actually correct.

$$
 Precision = {\frac{True\ Positives} {{True\ Positives} + False\ Positives} }
$$


#### Recall

Recall is the fraction of actual positive claims (EAVTs) that were identified.

$$
 Recall = {\frac{True\ Positives} {{True\ Positives} + False\ Negatives} }
$$


#### Null Rate
Null rate is the fraction of null claims over all claims

$$
 Null\ Rate = {\frac{Nulls} {True\ Positives + True\ Negatives + False\ Positives + False\ Negatives}}
$$



#### Compliance Rate
The compliance rate is the fraction of all claims that meet the assessment process’s taxonomy. This rate is used to measure errors in the agent’s ability to comply with an assessment process’s taxonomy.


#### Processing Time

Processing time is the time it takes for an agent to complete an assessment. The processing time could measure the time it takes to complete one claim, or a set of multiple claims (for example a human reviewing an image and updating multiple claims).


#### Throughput

Throughput is a measure of the amount of work in the system. We can measure the work done by agents or the assessment process. The amount of work can be measured by claim, submission, file or task.

#### Model Size

Model size is the size in bytes that the model software artefact takes up on disk.
