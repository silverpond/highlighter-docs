+++
title = "How To Create and Edit a Machine Agent"
description = "How to Create and Edit a Machine Agent"
date = 2021-05-01T08:00:00+00:00
updated = 2021-05-01T08:00:00+00:00
draft = false
weight = 100
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = 'Learn to use the Highlighter Agent Designer'
toc = true
top = false
+++

In this guide you'll create a new Agent, add Capabilities, and connect the Capabilities together to make your Agent ready to deploy.

### Create an Agent

1. Navigate to the Assessment Process you want to add an Agent to (create a new Assessment Process if you need).
2. Navigate to the "Stage Definition" tab of your new Process and under "Machine Assessments" click "New Machine Assessment Stage".
3. Give your new Stage a name and click "Save Machine Assessment Stage".
4. Looking at your new Machine Assessment Stage, click "Edit" on the top right of the page. You're now in the Agent Designer!

### Add Capabilities

You should now be looking at a blank Agent. By default it has two nodes: "Pipeline Inputs" and "Pipeline Outputs". You can drag these around.

{{ resize_image(path="docs/how-to-guides/new-agent.png", width=700, height=1, op="fit_width") }}

<br/>
<br/>

To add a Capability to the Agent, click on "Add Capability" in the top right. You will see a list of Capabilities; select a "detector" Capability from the list. Clicking the detector will add it to the Agent as a node that you can drag around.

> Note: Different capabilities will be available depending on what has been previously created in your account. To create a new capability see your account administrator.

To add edges between the nodes, hover your mouse over the "Pipeline Inputs" node. An output port will appear on the right, which you can grab and drag towards the input of the detector. Dropping the new edge on the input port of the detector will add the edge to the Agent.

You can add edges to the "Pipeline Outputs" node by dragging the outputs of the detector and dropping the new edge on the "Pipeline Outputs" node. These edges represent data that your Agent will return.

The new ports on the "Pipeline Inputs" and "Pipeline Outputs" nodes are given the names of the ports you have connected them to, but you can edit these names by clicking on them.

{{ resize_image(path="docs/how-to-guides/new-agent-with-detector.png", width=700, height=1, op="fit_width") }}

### Configure your Capabilities

Double-click on the detector Capability, or click the hamburger icon next to its title. This will bring up the detailed attributes and editable parameters of the Capability.

You can remove a Capability from your Agent by clicking "Remove Capability" on this detailed view.

### 🎉

Congratulations! You have created and edited an Agent in Highlighter.
