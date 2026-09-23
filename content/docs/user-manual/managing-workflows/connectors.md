+++
title = "Connectors"
description = "Notify external systems when something happens in Highlighter, using HTTP webhooks, email, or Slack, and check delivery from the connector page."
date = 2026-09-04T08:00:00+00:00
updated = 2026-09-23T08:00:00+00:00
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

When authentication is set, the URL must use `https`, so the token is not sent in clear text. There is no exemption for local addresses — to test against a local endpoint, leave **Authentication** on `None`.

Changing the URL of a connector that stores a token requires you to re-enter the token, so a credential issued for one destination is never sent to another.

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

The **Case Ready** event is the exception: it sends a versioned case document instead of this wrapper. See [Case Ready Webhook](#case-ready-webhook).

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
| Case Ready | A case moves from draft to ready |

### Narrowing an Event

Four events accept a filter, shown directly beneath the event once you tick it. Leave a filter empty to react to everything.

- **Assessment Finalised** — *Only these object classes*. The connector fires only when the assessment contains an annotation of one of the chosen classes.
- **Tasks Added To Machine Assessment Step** — *Only these steps*.
- **Finished Tasks In Machine Assessment Step** — *Only these steps*.
- **Case Ready** — *Only these workflows* and *Only these workflow orders*. When both are set, a case must match both. Case Ready also has two settings that change what each notification contains rather than which cases are sent. See [Choosing What a Case Carries](#choosing-what-a-case-carries).

Each filter applies to every notification type the connector uses.

## Case Ready Webhook

A connector subscribed to **Case Ready** is notified once for each case that moves from **draft** to **ready**. This covers a case you mark ready yourself (see [Mark a Case Ready or Draft](../managing-workflow-orders/#mark-a-case-ready-or-draft)) and cases moved to ready together, such as with the order's **Mark all ready** button. A case is only announced once: marking it draft and then ready again does not send a second notification.

A case is announced only if all of these are true:

- it has a title,
- it has at least one file or data source, and
- it has a submission.

A case that fails any of these checks still becomes ready, but no notification is sent for it.

Cases created before the Case Ready event was released in September 2026 are never announced, even if they are marked ready later.

### Choosing What a Case Carries

Two more settings appear beneath **Case Ready**. They decide what the entities in each notification look like, not which cases are sent:

- **Only these object classes** — which entities are listed in `entities`. The candidates are the case's own entity and any entity annotated or given an attribute value in the case's latest submission. Leave it empty to list every one of them.
- **Publish these entity attributes** — attributes to include on every listed entity. Each becomes a key named after the attribute in camelCase, so *Condition Grade* becomes `conditionGrade`. Leave it empty to send only each entity's `id`, `externalId`, `externalIdType` and `objectClass`.

The connector page shows these as *Only these object classes* and *Published entity attributes*. Because the settings belong to the connector, two connectors subscribed to Case Ready can receive different documents for the same case.

### What Is Sent

For an **HTTP Request** connector, the body is a versioned JSON document describing the case:

```json
{
  "schemaVersion": "1.0",
  "type": "case_ready",
  "id": "018f3478-9d2a-7f6b-b75d-20bbba3d8972",
  "createdAt": "2026-08-31T02:14:22.481Z",
  "payload": {
    "case": {
      "id": "018f3478-9d2a-7f6b-b75d-20bbba3d8972",
      "shortId": "cse_B47M2QxR9vKd3TnL-a8fWe",
      "title": "Leaning stack in travel aisle",
      "description": "Stack is leaning into the marked travel aisle and may fall.",
      "state": "ready",
      "createdAt": "2026-08-31T02:14:18.640Z",
      "updatedAt": "2026-08-31T02:14:22.481Z",
      "triggeredAt": "2026-08-31T02:14:18.120Z",
      "triggerReason": "conditionGrade == 'high'",
      "workflowId": "d1e1a9ec-1f0e-4f36-9d0a-0f4c2a6c8f11",
      "workflowName": "OH&S asset review",
      "workflowOrderId": "3fbd92b8-ced3-4cdc-9b24-91b8ce225343",
      "workflowOrderName": "Melbourne asset alerts",
      "subject": { "id": "9609404e-9fa4-4373-9ad9-56ac8151f2c6", "name": "Asset 874231" },
      "entities": [
        {
          "id": "9609404e-9fa4-4373-9ad9-56ac8151f2c6",
          "externalId": "ASSET-874231",
          "externalIdType": "asset_id",
          "objectClass": "machine",
          "conditionGrade": { "value": "high", "occurredAt": "2026-08-31T02:14:18.120Z" }
        }
      ],
      "dataSources": [
        {
          "id": "0e285e4e-1395-4d94-87f9-c934329f8384",
          "name": "Aisle 07 front camera",
          "serialNumber": "CAM-0007",
          "sourceType": "mediamtx",
          "contentType": "video_stream",
          "device": {
            "id": "779c51c4-ad1e-44f5-8701-51d92ea3d527",
            "externalId": "VEHICLE-07",
            "externalIdType": "vehicle_id"
          }
        }
      ],
      "latestSubmission": {
        "id": "27f73c2f-f420-47f1-bb87-d9274d9475f7",
        "status": "completed",
        "occurredAtFrom": "2026-08-31T02:14:18.120Z",
        "occurredAtTo": "2026-08-31T02:14:18.120Z"
      },
      "files": [
        {
          "id": "c82d1743-1f0a-4c8e-9a55-2d6b7c9f4411",
          "type": "image",
          "recordedAt": "2026-08-31T02:14:18.120Z",
          "url": "https://<media host>/<key>?X-Amz-Signature=<signature>&X-Amz-Expires=<seconds>"
        }
      ],
      "url": "https://<account>.<host>/assess?case_id=<case id>&layout=auto"
    }
  }
}
```

- Every `id` is a UUID, including `workflowId`. Timestamps are UTC ISO 8601 with milliseconds.
- `subject` is the entity the case is about, or `null` if the case has none. It is always sent, even when **Only these object classes** leaves it out of `entities`. The other items in `entities` give context only.
- `triggerReason` is the trigger that opened the case, or `null` for a case opened without one.
- `objectClass` is the entity's object class name in lower case.
- `conditionGrade` in the example is one published entity attribute. Each attribute is sent as an object with its `value` and when it was observed (`occurredAt`). The value is the enum value for an enum attribute, and otherwise the stored value as text. An entity with no value for a published attribute still has the key, set to `null`, so every entity has the same shape.
- `externalId` and `externalIdType` are `null` for an entity with no external identity.
- `dataSources` is in no particular order, so tell sources apart by `sourceType` (such as `mediamtx`, `rtmp`, `manual_upload` or `external_api`) and `contentType` (such as `video_stream`, `image` or `observation`). `device` is `null` for a data source with no device.
- `latestSubmission.occurredAtFrom` and `occurredAtTo` can be `null`.
- `files[].url` is a pre-signed link you can download directly until it expires. If Highlighter cannot sign a file, its `url` is `null` and the case is still sent.
- `url` opens the case in the Assessment Editor at `/assess`. The older `/annotate` address opens the same editor, so existing links keep working.

The request also carries these headers:

| Header | Value |
|---|---|
| `Authorization` | `Bearer <token>`, when the connector uses bearer token authentication |
| `Idempotency-Key` | The case ID |
| `X-Highlighter-Event-Id` | The case ID |

Email and Slack connectors subscribed to **Case Ready** send their usual notification rather than this document.

### Handling Repeats

Delivery is *at least once*. A retried request can reach you more than once, so treat `Idempotency-Key` as the alert ID. If you see a key again, answer with a `2xx` status and do not start the same work twice.

Retries follow the rules in [When Highlighter Retries](#when-highlighter-retries). Like every HTTP Request delivery, Highlighter does not follow redirects, waits up to 5 seconds to connect, and waits up to 30 seconds for a response.

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

- **HTTP Request** — a `5xx` response, `429 Too Many Requests` or `408 Request Timeout` is retried, as are client-side timeouts and connection failures. Any other `4xx`, such as `404 Not Found` or `403 Forbidden`, is treated as a configuration problem and is not retried.
- **Email** — a busy or unreachable mail server is retried. Other failures are not.
- **Slack** — rate limiting and Slack server errors are retried. Other errors, such as an unknown channel, are not. An authentication failure also marks the Slack workspace as needing attention.

Retries back off progressively, from a few seconds to several hours, over a maximum of 15 attempts across roughly two days. After that the notification is marked Failed.

Notifications you trigger yourself, including the test button, are delivered immediately rather than queued, so they are never retried.
