# Lab Setup

## 1. Overview

This document describes the infrastructure and services configured
for the Microsoft 365 & Windows Endpoint Support Lab.

The environment was built to simulate an enterprise IT support and
identity administration environment combining:

- Microsoft 365
- Microsoft Entra ID
- ServiceNow
- ServiceNow MID Server
- Active Directory
- DNS
- Windows endpoints
- PowerShell automation

The lab provides the infrastructure required to practice both
day-to-day IT support scenarios and enterprise identity workflows.

---

# 2. Lab Environment

The core on-premises environment is hosted in VMware.

| Component | Role | Address / Identifier |
|---|---|---|
| DC01 | Active Directory + DNS | 192.168.50.5 |
| WIN-USER-01 | Windows 10 Pro Endpoint | 192.168.50.21 |
| WIN-USER-02 | Windows 10 Pro Endpoint | 192.168.50.22 |
| ServiceNow MID Server | ServiceNow ↔ On-Premises integration | `MID_DC01_GENITECH` |

The lab Active Directory domain is:

```text
genitech.lab
```

The Active Directory structure uses the following main organizational
units:

Genitech
└── Users
    ├── HR
    ├── Sales
    ├── Finance
    └── IT

3. Active Directory
3.1 Domain

The Windows Server environment provides the Active Directory Domain
Services infrastructure.

Domain:
genitech.lab

DC01 provides:
Active Directory Domain Services
DNS
User and group management
Organizational Unit management
Authentication for domain users

4. Active Directory Organizational Structure
The lab uses department-based Organizational Units.

OU=Genitech
└── OU=Users
    ├── OU=HR
    ├── OU=Sales
    ├── OU=Finance
    └── OU=IT

5. Active Directory Groups
Department-based security groups were created to represent initial
department access.

| Department | Security Group    |
| ---------- | ----------------- |
| HR         | GG-HR-Users       |
| Sales      | GG-Sales-Users    |
| Finance    | GG-Finance-Users  |
| IT         | GG-IT-ServiceDesk |

The Joiner automation uses this mapping when provisioning new users.

6. Existing User Structure

The lab contains users representing different departments and
administrative roles.

Examples include:
IT
├── it.adam
└── it.sophia

HR
├── hr.ahmed
└── hr.sara

Sales
├── sales.lina
└── sales.youssef

Finance
├── finance.nadia
└── finance.omar

Additional test accounts may be created during automation testing.

7. Windows Endpoints
Two Windows 10 Pro endpoints are included in the lab:
WIN-USER-01
WIN-USER-02

The endpoints are joined to the genitech.lab domain.

They are used to simulate typical enterprise endpoint support
scenarios such as:

Windows troubleshooting
Account and authentication issues
DNS troubleshooting
Application issues
Connectivity problems
User support

8. ServiceNow

ServiceNow is used as the ITSM platform for the project.

The lab uses ServiceNow for:

Incident management
Service requests
Catalog items
Workflow automation
JML requests

The Joiner automation uses a Service Catalog Item named:
JML - New Employee (Joiner)

9. MID Server

A ServiceNow MID Server was configured to provide connectivity
between the ServiceNow instance and the on-premises Windows
environment.

MID Server:
MID_DC01_GENITECH

The MID Server is hosted on:
dc01.genitech.lab

Its primary role in the current implementation is to execute
PowerShell automation against the on-premises Active Directory
environment.

10. PowerShell

PowerShell is used as the automation layer for Active Directory
administration.

The Joiner provisioning script is stored in the lab at:
C:\Scripts\New-EnterpriseUserOnboarding.ps1

The script is responsible for:

- Input validation
- User provisioning
- OU selection
- Department mapping
- Group membership
- Attribute configuration
- Post-provisioning validation

automation/JML/

11. Microsoft 365 / Entra ID

The lab also includes Microsoft 365 and Microsoft Entra ID components
for identity and endpoint support practice.

The current tenant uses:
genitechlab.onmicrosoft.com

The environment is used to practice:

User and group administration
Identity management
Authentication
Security settings
Microsoft 365 administration
Integration with the broader IT support workflow

Microsoft Entra ID is used alongside the on-premises Active Directory
environment to represent a hybrid identity environment.

12. Hybrid Identity

The lab combines:
On-Premises Identity
        │
        ▼
Active Directory
        │
        ▼
Microsoft Entra ID

Users synchronized from the on-premises Active Directory can therefore
be represented in the Microsoft Entra environment.

This provides a more realistic enterprise identity administration
scenario than using an isolated cloud-only environment.

13. ServiceNow ↔ Active Directory Integration

The current automation path is:
ServiceNow
     │
     ▼
Flow Designer
     │
     ▼
Custom Action
     │
     ▼
MID Server
     │
     ▼
PowerShell
     │
     ▼
Active Directory

This integration is the foundation of the implemented JML Joiner
workflow.

Detailed Joiner implementation is documented separately in:
docs/jml.md

##14. Security and Lab Considerations

This environment is a controlled lab and is designed for learning,
testing, and portfolio development.

Production environments would require additional controls such as:

- Secure credential management
- Dedicated service accounts
- Least-privilege permissions
- Secret management
- Approval workflows
- Detailed auditing
- Password randomization
- Secure PowerShell execution
- Monitoring and alerting

No production credentials or secrets should be stored in the
repository.

##15. Setup Status

The following core components have been configured for the current
project:

 - Active Directory
 - DNS
 - Organizational Units
 - Department security groups
 - Windows 10 domain endpoints
 - ServiceNow
 - ServiceNow MID Server
 - PowerShell automation environment
 - Microsoft Entra ID
 - Microsoft 365 environment
 - ServiceNow → MID Server → PowerShell → AD integration
 - JML Joiner workflow

The current documented automation milestone is the successfully
implemented and tested Joiner workflow.
