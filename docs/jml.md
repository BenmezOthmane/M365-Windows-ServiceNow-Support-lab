## JML Joiner Automation

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

![ServiceNow Joiner Catalog Item](../screenshots/jml/servicenow-catalog-item.png)

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

![JML Flow Designer](../screenshots/jml/servicenow-flow.png)

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

The PowerShell automation provisions the account in Active Directory
according to the employee information submitted through ServiceNow.

The following attributes are configured:

- Name
- Username
- User Principal Name
- Department
- Job Title
- Organizational Unit
- Account status
- Department group membership

  
10. Department → OU / Group Mapping

The automation maps each department to its corresponding
Organizational Unit and Active Directory group.

| Department | Organizational Unit | AD Group |
|---|---|---|
| IT | OU=IT,OU=Users,OU=Genitech | GG-IT-ServiceDesk |
| HR | OU=HR,OU=Users,OU=Genitech | GG-HR-Users |
| Sales | OU=Sales,OU=Users,OU=Genitech | GG-Sales-Users |
| Finance | OU=Finance,OU=Users,OU=Genitech | GG-Finance-Users |

This mapping allows the onboarding workflow to automatically place
the new employee in the appropriate OU and department group.


11. End-to-End Execution

The complete Joiner workflow was tested from the ServiceNow Service
Portal through to Active Directory.

### Execution Sequence

```text
ServiceNow Service Portal
        ↓
JML - New Employee (Joiner)
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
```
The test was successfully completed and the resulting Active Directory account was created and configured according to the submitted request.


12. Validation

After execution, the resulting Active Directory account was verified.

The validation covered:

- User creation
- Username
- User Principal Name
- Department
- Job Title
- Account status
- Organizational Unit
- Department group membership

The validation confirmed that the information submitted through ServiceNow was correctly reflected in Active Directory.


13. Troubleshooting

During implementation, several integration issues were identified
and resolved.

### Incorrect Action Input Mapping

Some Action inputs were initially mapped incorrectly.

For example, the Job Title input was temporarily mapped to the
Department variable.

The mapping was corrected so that each Action input receives the
corresponding Catalog Variable.

### PowerShell Variable Handling

The initial PowerShell execution used an incorrect method for
retrieving the Flow Designer variables.

The execution was corrected to use the PowerShell variables exposed
by the ServiceNow PowerShell step.

### Result

After correcting the mappings and PowerShell variable handling,
the complete Joiner workflow executed successfully.


14. Security Considerations

This implementation was developed for a controlled lab environment.

The following production considerations should be applied before
using a similar workflow in a production environment:

- Do not hard-code passwords.
- Use secure credential management.
- Apply least-privilege permissions.
- Protect ServiceNow and MID Server credentials.
- Validate all user-supplied input.
- Maintain audit logs.
- Apply appropriate approval controls.
- Never commit real credentials or secrets to GitHub.

  
15. Evidence

The following evidence documents the implemented Joiner workflow.

| Evidence | File |
|---|---|
| ServiceNow Catalog Item | `02-servicenow-catalog-item.png` |
| Flow Designer | `03-servicenow-flow.png` |
| Custom Action | `04-servicenow-action.png` |
| Successful Execution | `05-jml-execution-success.png` |
| Active Directory Result | `06-ad-user-created.png` |


16. Implementation Status

### Completed

- [x] ServiceNow Joiner Catalog Item
- [x] Catalog variables
- [x] Flow Designer workflow
- [x] Custom AD provisioning Action
- [x] MID Server integration
- [x] PowerShell provisioning
- [x] Department-to-OU mapping
- [x] Department-to-group mapping
- [x] Active Directory account provisioning
- [x] End-to-end testing
- [x] Active Directory validation

### Current Status

**Joiner automation: Implemented and successfully validated.**
