+++
title = "Register an Appliance"
description = "Approve an appliance, map its video channels, and manage its credential"
weight = 10
draft = false
+++

An account administrator must approve each appliance before it can report to
Highlighter Cloud. Registration creates a Device and the selected Data Sources
in your account. The appliance keeps its enrollment key and Cloud credential
locally; you do not need to copy either value.

## Before you begin

Check that:

- the appliance can reach your Highlighter Cloud URL over HTTPS;
- its video channels and playback address are configured; and
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
4. Review the proposed Device name, placement, timezone, and playback address.
5. Select the video channels to create or map to existing Data Sources.
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
as `ok`. In Highlighter, open **Appliances** to view the Device, selected Data
Sources, credential state, and last contact time.

The same persisted identity and credential are reused after a restart; browser
approval is not repeated.

## Rotate the credential

To replace the runtime credential without interrupting authentication, run:

```console
sudo highlighter-appliance credentials rotate
```

The appliance installs the replacement and restarts its monitor. Cloud keeps
the previous credential valid until it receives a heartbeat authenticated by
the replacement and the appliance acknowledges the change. Retrying the command
after a network interruption resumes the same rotation.

## Local recovery commands

`sudo highlighter-appliance credentials clear` removes the credential and
enrollment key while retaining the installation identity and manifest. Use it
only when following a reconnect or credential-loss recovery procedure.

`sudo highlighter-appliance factory-reset --yes` removes all local appliance
identity. It is destructive and requires a new administrator-approved
registration.
