+++
title = "Quality and Compliance Framework"
description = "Quality and Compliance Framework"
date = 2021-05-01T08:00:00+00:00
updated = 2021-05-01T08:00:00+00:00
draft = false
weight = 100
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = ''
toc = true
top = false
+++

Silverpond is committed to delivering high-quality solutions and services that consistently meet and exceed client expectations. Our approach to **Quality Management** is holistically integrated within our certified **Information Security Management System (ISMS)** and Highlighter's support of the **Artificial Intelligence Management System (AIMS)** framework.

Rather than pursuing **ISO 9001**, we’ve built a system grounded in **ISO 27001** and **ISO 42001** that delivers the same principles:

- Consistency  
- Reliability  
- Risk management  
- Continual improvement  

This system is composed of two key pillars:

### ISO/IEC 27001 Certified ISMS  
Our ISMS provides the foundational governance and process controls for our entire operation, ensuring the security, integrity, and availability of our products and client data. This certification demonstrates our commitment to rigorous, audited operational standards.

### Highlighter as an AI Management System (AIMS)  
For our AI-specific services and the Highlighter platform, we operationalize the principles of the **ISO/IEC 42001** standard. This ensures our AI development and deployment processes are transparent, accountable, and focused on delivering high-quality, responsible outcomes.

Below, we detail how this integrated system addresses your specific requirements for **Quality Management**.


## ISO/IEC 27001 Certified ISMS  
Our ISO 27001 certification provides strong evidence of our capacity to comply with quality assurance requirements through the following mechanisms inherent in the standard:

- Process-Oriented Approach: ISO 27001 mandates the establishment, implementation, maintenance, and continual improvement of documented processes. This includes critical areas relevant to quality, such as:
- Secure Software Development Lifecycle (SDLC): Our structured development practices integrate security and quality checks at each stage, from requirements gathering and design through to testing, deployment, and maintenance. Our processes also identify, track, and remediate defects (nonconforming outputs) throughout the SDLC, which include:
    - comprehensive testing (unit, integration, system, security, and user acceptance testing) designed to uncover defects.
    - a formal bug tracking system to record, prioritize, and manage the resolution of all identified issues
    - root cause analysis for critical defects to prevent recurrence.
    - verification of fixes before deployment to ensure issues are effectively resolved.
- Monitoring, Measurement, Analysis, and Evaluation: Our SDLC is not static; it's continuously improved through:
    - In-Process Metrics: Tracking metrics such as code quality scans, test coverage, and build success rates during development.
    - Code Reviews & Quality Gates: Implementing peer code reviews and automated quality gates via our Continuous Integration system to ensure adherence to coding standards and identify potential issues early.
    - Post-Deployment Monitoring: Monitoring system performance and user feedback post-release to identify any emergent quality issues or areas for improvement.
    - Incident Management: Structured procedures for managing and resolving incidents ensure that any issues affecting service quality are addressed effectively.
- Risk Management: A core component of ISO 27001 is a comprehensive risk assessment and treatment process. While focused on information security, these risk management principles are also applied to ensure the reliability, availability, and integrity of our Highlighter solution, which are key aspects of service quality.
- Documentation and Record-Keeping: ISO 27001 requires thorough documentation of processes, controls, and records of activities. This ensures consistency, traceability, and supports quality audits and reviews.
- Management Responsibility & Review: The standard mandates clear management responsibility for the ISMS and regular management reviews. These reviews assess the effectiveness of our systems, including aspects directly impacting quality, and drive continual improvement.

## Highlighter as an AI Management System (AIMS) supporting ISO 42001
With regard to ISO 42001, Highlighter provides the centralized platform and interconnected subsystems necessary to implement the normative controls outlined in Annex A of the standard.
Here are some key domains of ISO 42001 and how Highlighter supports it:

- AI System Lifecycle Management (ISO/IEC 42001 Annex A.6)
The standard requires documented processes for every stage of the AI system lifecycle. Highlighter is built around this principle.
    - Requirements and Specification (A.6.2.2): Our Services Methodology begins with workshops to define the business case, success criteria, and desired workflow, ensuring requirements are documented in Highlighter and signed off before development begins.
    - Data Management (A.7): Highlighter’s Schema and Data Collection subsystems provide a structured way to manage data, track provenance, and document its use for training, validation, and testing, directly supporting data quality and governance requirements.
    - Verification and Validation (A.6.2.4): The Evaluation subsystem is designed to continuously monitor agent performance against predefined metrics (e.g., accuracy, cost-effectiveness). This provides the objective evidence needed to validate AI models before and during deployment.
    - Deployment, Operation, and Monitoring (A.6.2.5, A.6.2.6): Highlighter manages the deployment of human and AI agents into production workflows. Its integrated nature ensures that performance is continuously monitored, and the Visualization subsystem provides dashboards and reports to track this, fulfilling the need for ongoing operational oversight.

- Risk and Impact Assessment (ISO/IEC 42001 Clause 6.1, Annex A.5)
A central tenet of ISO 42001 is the assessment of risks and potential impacts on individuals and society.
    - AI System Impact Assessment (A.5): Highlighter provides the necessary transparency to conduct these assessments. By documenting the data sources (Schema), the logic of the AI agent (Agent Development), and its performance (Evaluation), an organization can formally assess potential impacts like bias or unfairness.
    - Risk Treatment: Highlighter allows for defining clear, auditable responses to identified risks. For example, if a model's confidence is low, the system can automatically route the task to a human expert for review in our Assessment Editor, mitigating the risk of an incorrect automated decision. This provides a clear mechanism for human oversight.

- Information and Transparency for Interested Parties (ISO/IEC 42001 Annex A.8)
The standard mandates that organizations provide clear information to users and stakeholders.
    - System Documentation (A.8.2): Because every workflow, data schema, agent, and action is defined and managed within Highlighter, the system serves as a "single source of truth." It provides the provenance and context for how a decision was made and what action was taken, enabling the generation of clear, auditable reports for users, management, or regulators.
    - Communication of Incidents (A.8.4): The centralized logging and monitoring within Highlighter facilitate the timely identification and reporting of incidents, such as performance degradation or unexpected model behavior.

- Continual Improvement (ISO/IEC 42001 Clause 10)
The "Enterprise Journey" enabled by Highlighter is a direct embodiment of the continual improvement cycle. Highlighter enables the PDCA (Plan-Do-Check-Act) cycle by:
    * PLAN: Plan and standardise organisational workflows and taxonomies
    * DO: Execute perception tasks and actions consistently.
    * CHECK: Aggregate and compare data to evaluate agent performance
    * ACT: Use feedback and metrics to refine agent performance and further optimize the system

    This structured maturity path provides tangible evidence of a commitment to continual improvement as required by the standard.



