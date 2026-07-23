+++
title = "Register a Highlighter Appliance"
description = "Connect a Highlighter Appliance to Highlighter Cloud and review its discovered Data Sources."
date = 2026-07-23T08:00:00+00:00
updated = 2026-07-23T08:00:00+00:00
draft = false
weight = 20
sort_by = "weight"
template = "docs/page.html"

[extra]
toc = true
top = false
+++

A Highlighter Appliance connects cameras and other local streams to
Highlighter Cloud. Registration creates a Device for the appliance and one
Data Source for each stream you approve.

Registration does not require copying a user API token onto the appliance. A
technician starts registration at the appliance, then an account administrator
reviews and approves it in Highlighter.

## Before you start

You need:

- console or SSH access to the appliance with permission to run `sudo`;
- the appliance's Highlighter Cloud URL configured by its administrator;
- a Highlighter account administrator available to approve the request; and
- network access from the appliance to Highlighter Cloud over HTTPS.

The appliance does not need an inbound port.

## Start registration on the appliance

Run:

```console
sudo highlighter-appliance register
```

The command displays:

- a Highlighter activation URL;
- an eight-character appliance code;
- a two-word comparison value; and
- the time remaining before the code expires.

Keep the command running while an administrator completes the browser steps.
The appliance waits for approval and installs its credential after approval.

## Approve the appliance in Highlighter

Only an account administrator can approve or deny registration.

1. Open the URL shown by the appliance. If prompted, sign in. Highlighter
   returns you to the activation page after sign-in.
2. Enter the appliance code if the URL did not fill it in.
3. Compare the appliance code and two-word comparison value in the browser
   with the values in the appliance terminal.
4. Check **I confirm the appliance code and comparison value match the
   appliance** only if both values match exactly.
5. Review the hostname, software version, capabilities, and stream count.
   These are claims from the appliance, so confirm that they describe the
   appliance you intend to register.
6. Set the appliance name, parent or site, timezone, and playback address.
   Choose an **Existing Device** only when deliberately reconnecting or
   adopting that Device.
7. Review every discovered stream. All streams, including likely test streams,
   are initially selected. You can:
   - exclude a stream;
   - edit its Data Source name;
   - choose a default subject;
   - add comma-separated tags; or
   - explicitly map it to an existing Data Source.
8. Check the exact Device and Data Source counts in the confirmation message,
   then click **Approve registration**.

Choose **Deny** if the comparison does not match, the appliance is unfamiliar,
or its proposed streams are unexpected. Start a fresh registration from the
appliance after a denial or expired code.

### Understand stream reconciliation

The review table labels each stream:

- **New** creates a Data Source.
- **Existing** keeps the current mapping.
- **Changed** highlights a difference between the local claim and Cloud.
- **Missing locally** identifies a previously mapped Cloud source that is not
  in the new inventory.
- **Conflict** requires you to correct the Device or Data Source mapping before
  approval.

The channel key and structural fields are read-only. When adopting an existing
Data Source, Highlighter keeps its structural fields and existing data.

## Follow registration progress

After approval, Highlighter waits for the appliance to prove possession of its
enrollment key and install its credential. Return to the appliance terminal if
the browser remains on **Waiting for the appliance**.

When enrollment finishes, the page links to:

- the Appliance details page;
- its Data Sources; and
- Operations.

Go to **Develop → Media → Appliances** at any time to see the fleet. Registration,
credential, and operational status are separate:

- **Registration** shows provisioning and connection lifecycle.
- **Credential** shows whether the appliance credential is active, rotating,
  failed, expired, or revoked.
- **Operational** summarizes appliance and stream reports.

**Waiting for first report** means registration completed but Cloud has not
received runtime health yet. It is different from an explicit degraded or
failed report. Open an Appliance to inspect credential installation,
heartbeat, MediaMTX, signalling, storage, and per-source progress.

## Check or recover local registration state

View local state without displaying the credential:

```console
sudo highlighter-appliance status
sudo highlighter-appliance status --json
```

Use reconnect when an administrator intends to approve the appliance again:

```console
sudo highlighter-appliance reconnect
```

To remove the local enrollment key and bearer credential while retaining the
installation identity:

```console
sudo highlighter-appliance credentials clear
```

Use this when repairing credential state and then run `reconnect`. It does not
delete the Device, Data Sources, or historical data in Cloud.

A factory reset removes all local appliance identity and requires explicit
confirmation:

```console
sudo highlighter-appliance factory-reset --yes
```

Use factory reset only when the appliance must become a new local
installation. Cloud records are retained; an administrator must explicitly
select the intended existing Device and Data Sources if the reset appliance
should adopt them.

The CLI never prints the private enrollment key or bearer credential.
