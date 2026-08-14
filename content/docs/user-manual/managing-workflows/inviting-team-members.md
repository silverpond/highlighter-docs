+++
title = "Inviting Team Members"
description = "Learn how to invite new users to your Highlighter account from the Team Members page, manage their roles, and resend or revoke access."
date = 2026-08-14T08:00:00+00:00
updated = 2026-08-14T08:00:00+00:00
draft = false
weight = 5
sort_by = "weight"
template = "docs/page.html"

[extra]
lead = "Add new people to your Highlighter account and control their account-wide role from the Team Members page."
toc = true
top = false
+++

## Overview

Before a user can be assigned to workflows, workflow orders, or steps (see [Assigning Contributors to Workflows](../assigning-contributors/)), they must first exist as a member of your Highlighter account. The **Team Members** page is where account administrators add new users, send them an email invitation, assign their account-wide role, and manage their access over time.

## Who Can Manage Team Members

Access to the Team Members page and the ability to add, invite, edit, or deactivate users depends on your account role's permissions. If you don't see an "Add New Member" button, your role doesn't have permission to manage the team — contact your Highlighter administrator.

## Navigating to Team Members

1. Click your User Name in the bottom left to open the Account Settings menu
2. Click **Manage Team**

This takes you to the Team Members page, which lists every user in your account along with their role, active status, invitation status, and last sign-in date.

## Inviting a New User

1. **Click "Add New Member"**
   - Found at the top right of the Team Members page
   - If your account has reached its user limit for your current plan, this button is replaced with a disabled notice — you'll need to upgrade your plan to add more users

2. **Fill in the New User Form**
   - **Email** — the address the invitation will be sent to
   - **Display Name** — how the user will appear throughout Highlighter
   - **Role** — the account-wide role to assign (e.g. Contributor, Project Manager). This controls what the user can see and do across the account
   - **Expires** — optionally set a date after which this user's access automatically expires
   - **Color** — the color used to represent this user's annotations and activity
   - **Password** — a temporary password is required to create the account; use the password generator button to create a random one, or set your own. The invited user sets their own password when they accept the invitation

   > **Adding an existing user**: If you enter the email address of a user who already exists in Highlighter (e.g. they belong to another account), they'll be added to your account with the role you select instead of a new account being created.

3. **Click "Save"**
   - The user is created and appears in the Team Members list
   - This does **not** automatically send an invitation email — see the next step

## Sending the Invitation

A newly created user needs an invitation email before they can sign in.

1. Find the user in the Team Members list
2. In the **Invite** column, click **Invite**
3. An invitation email is sent to the user's email address, and the **Invited?** column updates to "Yes"

The user follows the link in the email to set their own password and accept the invitation. Once they do, the **Accepted?** column updates to "Yes" and the Invite button is replaced with a `-`, since no further action is needed.

> **Resending an invitation**: If a user hasn't accepted their invitation yet, the **Invite** button remains available so you can resend the email — useful if the original invitation expired or was lost.

## Editing a User

Click **Edit** next to a user to change their display name, email, role, expiry date, color, or password. You cannot change your own role from this page.

## Deactivating and Reactivating Users

- **Deactivate**: Click **Deactivate** next to a user to revoke their access immediately. Deactivated users appear greyed out in the list and can no longer sign in.
- **Activate**: Click **Activate** next to a deactivated (or expired) user to restore their access.

You cannot deactivate your own account from this page.

## Understanding the Team Members Table

| Column | Meaning |
|---|---|
| Active | Whether the user's account is currently enabled |
| Invited? | Whether an invitation email has been sent |
| Accepted? | Whether the user has followed the invitation link and set a password |
| Last seen | The date of the user's most recent sign-in, or "Never" |
| Expires In | Time remaining before the user's access automatically expires, or "Never" |

## Related Documentation

- [Assigning Contributors to Workflows](../assigning-contributors/) — once a user is a team member, assign them to specific workflows, orders, and steps
