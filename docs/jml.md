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
```

## ServiceNow

A Catalog Item was created:

JML - New Employee (Joiner)

The request collects:
| Variable            | Purpose             |
| ------------------- | ------------------- |
| First Name          | Employee first name |
| Last Name           | Employee last name  |
| Username            | AD username         |
| Department          | Employee department |
| Job Title           | Employee role       |
| User Principal Name | AD UPN              |

The Flow Designer workflow retrieves these values and passes them to
the custom AD - Provision New User Action.

## Active Directory Provisioning

The PowerShell automation is implemented in:

automation/JML/New-EnterpriseUserOnboarding.ps1

The script handles:

- Input validation
- AD user creation/update
- OU assignment
- Department and job title configuration
- Department group membership
- Account validation

## Department Mapping
| Department | OU                                | AD Group            |
| ---------- | --------------------------------- | ------------------- |
| IT         | `OU=IT,OU=Users,OU=Genitech`      | `GG-IT-ServiceDesk` |
| HR         | `OU=HR,OU=Users,OU=Genitech`      | `GG-HR-Users`       |
| Sales      | `OU=Sales,OU=Users,OU=Genitech`   | `GG-Sales-Users`    |
| Finance    | `OU=Finance,OU=Users,OU=Genitech` | `GG-Finance-Users`  |

## Microsoft Entra ID Synchronization

The lab uses a hybrid identity configuration with on-premises
Active Directory synchronized to Microsoft Entra ID.

The synchronization was successfully configured and validated.
Active Directory
       ↓
Synchronization
       ↓
Microsoft Entra ID

This allows users created and managed in the on-premises Active
Directory environment to be represented in the cloud identity
environment.

The synchronized user can be verified in Microsoft Entra ID with
its corresponding identity and directory information.

## MID Server

The workflow uses:

MID_DC01_GENITECH

The MID Server provides the execution path between ServiceNow and the
on-premises Windows environment.

## End-to-End Validation

The implemented workflow was tested from the ServiceNow Service
Portal through to Active Directory.

Validation confirmed:

- ServiceNow request submission
- Flow Designer execution
- MID Server execution
- PowerShell provisioning
- AD account creation
- OU assignment
- Department/group assignment
- Microsoft Entra ID synchronization

Result: The Joiner provisioning and identity synchronization
workflow was successfully implemented and validated.

## Evidence

Screenshots are stored under:
- screenshots/ServiceNow/
- screenshots/M365/

Evidence includes:

- ServiceNow Joiner Catalog Item
- Flow Designer
- Custom Action
- Successful execution
- Active Directory user
- Microsoft Entra ID synchronized user

## Security

This is a controlled lab implementation.

Production implementations should use secure credential management,
least-privilege permissions, input validation, auditing, and should
never store real credentials in source control.

## Status
- ServiceNow Joiner Catalog Item
- Flow Designer workflow
- MID Server integration
- PowerShell automation
- AD user provisioning
- OU and group assignment
- Active Directory → Microsoft Entra ID synchronization
- End-to-end testing
- Identity validation
 
Current milestone: Joiner automation and hybrid identity
synchronization successfully implemented and validated.
