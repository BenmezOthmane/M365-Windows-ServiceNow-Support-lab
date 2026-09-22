# Troubleshooting

This document records the main issues encountered during the lab implementation and their solutions.

## ServiceNow → PowerShell

### Issue
PowerShell returned:

`FirstName is required`

### Cause
Flow Designer Action inputs were not mapped correctly, and the PowerShell step was using incorrect variable references.

### Solution
- Corrected the Action input mappings.
- Used the PowerShell Step variables directly.
- Re-tested the Joiner workflow successfully.

---

## Action Input Mapping

### Issue
Some Action inputs were empty during execution.

### Cause
Catalog variables were incorrectly mapped to Action inputs.

### Solution
Verified and corrected the mappings for:

- First Name
- Last Name
- Username
- Department
- Job Title
- User Principal Name

---

## Active Directory Provisioning

### Issue
Incorrect or missing user attributes during testing.

### Solution
The PowerShell script was updated to validate:

- Required inputs
- Department
- OU existence
- AD group existence
- Existing usernames

The final test successfully created the user with the correct OU, attributes, and group membership.

---

## Microsoft Entra ID Synchronization

### Issue
The on-premises AD user was not immediately visible in Entra ID.

### Solution
Verified the AD → Microsoft Entra synchronization process and confirmed that the created identity was synchronized successfully.

---

## Result

The main integration issues were resolved and the complete workflow was successfully tested:

```text
ServiceNow
   ↓
Flow Designer
   ↓
MID Server
   ↓
PowerShell
   ↓
Active Directory
   ↓
Microsoft Entra ID
