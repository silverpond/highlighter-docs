+++
title = "Register an Appliance"
description = "Approve one appliance and connect its video channel to Highlighter Cloud"
date = 2026-07-24T08:00:00+00:00
updated = 2026-07-24T08:00:00+00:00
weight = 10
draft = false
+++

An account administrator must approve each appliance before it can report to
Highlighter Cloud. The proof of concept supports one new appliance with one
video channel. Registration creates one Device and one Data Source in your
account. The appliance keeps its enrollment key and Cloud credential locally;
you do not need to copy either value.

## Before you begin

Check that:

- the appliance can reach your Highlighter Cloud URL over HTTPS;
- exactly one video camera and its playback address are configured;
- you can sign in to Highlighter as an account administrator.

## Register

On the appliance, run:

```console
sudo highlighter-appliance register
```

The command displays an activation URL, a short code, and a two-word comparison
phrase. Leave it running while you complete approval.

1. Open the activation URL and sign in.
2. Enter the short code if the URL did not fill it in.
3. Confirm that the comparison phrase in the browser exactly matches the
   phrase shown by the appliance.
4. Review the hostname, video channel, playback address, and enrollment-key
   thumbprint.
5. Enter the Device and Data Source names.
6. Approve the registration.

The appliance proves possession of its enrollment key, installs its Cloud
credential and manifest, and verifies the credential against Cloud. Its monitor
then begins reporting a heartbeat. If you deny the request or the code expires,
run the registration command again to receive a new code.

## Check registration

Run:

```console
sudo highlighter-appliance status
```

A healthy registration reports an active credential and Cloud authentication
as `ok`. In Highlighter, open **Data Sources** to see the new video source and
**Operations** to see the appliance heartbeat.

The same persisted identity and credential are reused after a restart; browser
approval is not repeated.

## POC limitations

This proof of concept does not provide credential rotation, reconnect, reset,
existing-Device adoption, multiple channels, or an appliance management page.
Do not delete files from `/var/lib/highlighter-appliance`: rerunning `register`
does not recover or replace a lost registration. Contact the appliance
engineering team if local registration state is damaged or the credential must
be replaced.
