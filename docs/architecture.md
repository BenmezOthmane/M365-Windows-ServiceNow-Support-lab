# Architecture

## Overview
The lab combines Microsoft 365, Entra ID, ServiceNow, on-premises
Active Directory, Windows endpoints, and PowerShell automation.

```text
Microsoft 365 / Entra ID
          │
          │
      ServiceNow
          │
          ▼
      MID Server
          │
          ▼
      PowerShell
          │
          ▼
 Active Directory
          │
     ┌────┴────┐
     ▼         ▼
WIN-USER-01  WIN-USER-02
```

## JML Joiner Flow
ServiceNow Service Portal
          ↓
Catalog Request
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

The Joiner workflow provisions the user according to the submitted
department, including:

- AD account creation
- OU assignment
- Department
- Job title
- Department group membership
