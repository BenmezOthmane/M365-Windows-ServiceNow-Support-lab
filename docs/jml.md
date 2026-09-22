# JML Joiner Automation

## Overview

Implemented and successfully tested an automated **Joiner** workflow
using:

`ServiceNow → Flow Designer → MID Server → PowerShell → Active Directory`

The workflow automates the onboarding of a new employee from a
ServiceNow request to Active Directory provisioning.

## Workflow

```text
ServiceNow Service Portal
        ↓
JML - New Employee (Joiner)
        ↓
Flow Designer
        ↓
AD - Provision New User
        ↓
MID Server
        ↓
PowerShell
        ↓
Active Directory
