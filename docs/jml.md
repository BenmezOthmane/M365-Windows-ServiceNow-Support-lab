# JML Joiner Automation

1. Purpose

This document describes the implementation and validation of the
Joiner automation workflow built as part of the
Microsoft 365 & Windows Endpoint Support Lab.

The objective was to automate the onboarding of a new employee
from a ServiceNow request to Active Directory provisioning.

The implemented workflow is:

ServiceNow → MID Server → PowerShell → Active Directory

The workflow was implemented, tested, and successfully validated in the lab environment.

2. Implemented Architecture

The implemented Joiner workflow consists of the following components:

- ServiceNow Service Portal
- ServiceNow Catalog Item
- Flow Designer
- Custom ServiceNow Action
- MID Server
- PowerShell
- Active Directory

### Workflow

Service Portal
      ↓
ServiceNow Catalog Request
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

3. Joiner Workflow

The implemented workflow follows these steps:

1. A new employee request is submitted through the ServiceNow Service Portal.
2. The request is associated with the `JML - New Employee (Joiner)` Catalog Item.
3. Flow Designer retrieves the submitted catalog variables.
4. The variables are passed to the `AD - Provision New User` custom action.
5. The action executes the PowerShell provisioning process through the MID Server.
6. PowerShell validates the submitted information.
7. The Active Directory user is created and configured.
8. The account is placed in the appropriate Organizational Unit.
9. The user is added to the corresponding department group.
10. The resulting account is validated.
    
4. ServiceNow Catalog Item

The Joiner process is initiated through the following ServiceNow
Catalog Item:

`JML - New Employee (Joiner)`

### Variables

| Variable | Purpose |
|---|---|
| First Name | Employee first name |
| Last Name | Employee last name |
| Username | Active Directory username |
| Department | Employee department |
| Job Title | Employee job title |
| User Principal Name | Active Directory UPN |

5. Flow Designer

The Catalog Item is connected to the following Flow:

`JML - Joiner - AD User Creation`

The flow is triggered by a Service Catalog request.

### Main Flow

Service Catalog Trigger
        ↓
Get Catalog Variables
        ↓
AD - Provision New User
        ↓
PowerShell Execution
        ↓
Active Directory

6. Custom Action

A custom global Action was created to handle the Active Directory
provisioning process.

Action name:

`AD - Provision New User`

### Action Inputs

| Action Input | Source |
|---|---|
| First_Name | first_name |
| Last_Name | Last_name |
| Sam_Account_Name | Username |
| Department | Department |
| Job_Title | Job_Title |
| User_Principal_Name | user_principal_name |

7. MID Server

The ServiceNow workflow uses the following MID Server to execute
the on-premises automation:

`MID_DC01_GENITECH`

The MID Server provides the execution path between ServiceNow
and the Windows environment hosting Active Directory.

The execution path is:

ServiceNow
   ↓
MID Server
   ↓
PowerShell
   ↓
Active Directory

8. PowerShell Automation

The Active Directory provisioning logic is implemented in:

`automation/JML/New-EnterpriseUserOnboarding.ps1`

The script is responsible for:

- Validating input parameters
- Validating the department
- Determining the target Organizational Unit
- Determining the appropriate department group
- Checking whether the account already exists
- Creating or updating the AD account
- Setting the required user attributes
- Adding the user to the appropriate group
- Performing post-provisioning validation
  
9. Active Directory Provisioning
10. Department → OU / Group Mapping
11. End-to-End Execution
12. Validation
13. Troubleshooting
14. Security Considerations
15. Evidence
16. Implementation Status
