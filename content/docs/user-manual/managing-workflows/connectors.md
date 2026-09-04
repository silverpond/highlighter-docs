+++
title = "Connectors"
description = "Notify external systems when something happens in Highlighter, using HTTP webhooks, email, or Slack, and check delivery from the connector page."
date = 2026-09-04T08:00:00+00:00
updated = 2026-09-04T08:00:00+00:00
draft = false
weight = 60
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = ''
toc = true
top = false
+++

A connector tells an outside system that something has happened in Highlighter. When a workflow event occurs — a case is completed, an assessment is finalised, files are imported — every connector subscribed to that event sends a notification.

Each connector combines two choices:

- **Notification types** — how the message is delivered: an HTTP request, an email, or a Slack message. A connector can use more than one at once.
- **Subscribed events** — what the connector reacts to.

Connectors are listed under **Act → Connectors**.

## Creating a Connector

1. Go to **Connectors** and click **New Connector**.
2. Tick one or more **Notification Types**. Each one reveals only the fields it needs.
3. Tick the **Subscribed Events** the connector should react to.
4. Click **Save Connector**.

### HTTP Request

Sends the event to a URL of your choosing.

- **URL** — where the request is sent.
- **Authentication** — `None`, or `Bearer token` to send an `Authorization: Bearer …` header.
- **Bearer Token** — the token itself. It is stored encrypted and is never shown again. Leave the field blank when editing to keep the existing token.

When authentication is set, the URL must use `https`, so the token is not sent in clear text. Addresses on `localhost` and `127.0.0.1` are exempt, so you can test against a local endpoint.

The request is a `POST` with a JSON body and `Content-Type: application/json`:

```json
{
  "event": "project_file_completed",
  "payload": {
    "case_id": 123,
    "project_id": 4
  }
}
```

The `event` field names the subscribed event that fired. The contents of `payload` vary by event.

### Email

Sends the event as an email.

- **Email Settings** — a JSON object configuring the message. Recognised keys are `email_address`, `email_subject`, `email_message`, `email_content_type`, `include_image`, `include_annotations`, `include_image_metadata`, `format_image_metadata`, and `include_image_link`.
- **Annotations To Attach** — when annotations are included, restricts the attached annotation crops to the object classes you choose. Leave it empty to attach all of them.

An email with no address, subject, or message is not sent.

### Slack

Posts the event to a Slack channel.

- **Slack Provider** — the connected Slack workspace. If none is listed, use the **Connect a Slack workspace** link to authorise one.
- **Slack Channel** — the destination channel, searchable once a provider is selected.

## Subscribed Events

A connector can subscribe to any combination of the following:

| Event | Fires when |
|---|---|
| Manually Triggerable | You trigger the connector yourself, rather than automatically |
| File Created | A file is added |
| Assessment Finalised | An assessment is submitted as final |
| Data Source Files Imported | A data source finishes importing files |
| Human File Assessment End of Queue | An assessor reaches the end of a queue |
| Tasks Added To Machine Assessment Step | Tasks are queued for a machine assessment step |
| Finished Tasks In Machine Assessment Step | Every task in a machine assessment step has finished |
| Train Requested For Training Run | Training is requested |
| Cancel Requested For Training Run | Training is cancelled |
| File Completed in Workflow | A case completes its workflow |
| Cloud Agent Crash Loop Detected | A cloud agent repeatedly crashes |
| Case Message Created | A message is added to a case |

### Narrowing an Event

Three events accept a filter, shown directly beneath the event once you tick it. Leave a filter empty to react to everything.

- **Assessment Finalised** — *Only these object classes*. The connector fires only when the assessment contains an annotation of one of the chosen classes.
- **Tasks Added To Machine Assessment Step** — *Only these steps*.
- **Finished Tasks In Machine Assessment Step** — *Only these steps*.

Each filter applies to every notification type the connector uses.

## Testing a Connector

The connector page has a **Send Test Notification** button. It sends a dummy payload through every notification type the connector has enabled and reports the result immediately, so you can confirm a URL, token, or Slack channel without waiting for a real event.

The test leaves no trace: its events are removed afterwards and do not appear in the connector's history or its counts. A test that fails is not retried — the error is reported to you instead.

## Checking Deliveries

Each connector page shows four counts:

- **Pending** — created but not yet delivered. Normally brief; a figure that does not fall means notifications are being generated but nothing is delivering them.
- **Accepted** — delivered successfully.
- **Retrying** — delivery failed and another attempt is scheduled.
- **Failed** — delivery failed and will not be attempted again.

Beneath them, the **Events** table lists each delivery, newest first, showing when it happened, which event fired, how it was sent, its status, how many attempts have been made, and either the error returned or the identifier the receiving service gave back.

### When Highlighter Retries

A failure that might succeed later is retried; one that cannot is not.

- **HTTP Request** — a `5xx` response or `429 Too Many Requests` is retried, as are timeouts and connection failures. Any other `4xx`, such as `404 Not Found` or `403 Forbidden`, is treated as a configuration problem and is not retried.
- **Email** — a busy or unreachable mail server is retried. Other failures are not.
- **Slack** — rate limiting and Slack server errors are retried. Other errors, such as an unknown channel, are not. An authentication failure also marks the Slack workspace as needing attention.

Retries back off progressively, from a few seconds to several hours, over a maximum of 15 attempts across roughly two days. After that the notification is marked Failed.

Notifications you trigger yourself, including the test button, are delivered immediately rather than queued, so they are never retried.
