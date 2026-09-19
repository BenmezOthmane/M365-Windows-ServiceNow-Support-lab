# Microsoft 365 & Windows Endpoint Support Lab

An enterprise-style IT support lab combining **Microsoft 365, Windows endpoints, Active Directory, ServiceNow, PowerShell, and JML automation**.

The project simulates common workplace support operations, identity administration, endpoint troubleshooting, incident management, and automated Joiner/Mover/Leaver workflows.

## Architecture

```text
Microsoft 365 / Entra ID
          │
          │
     ServiceNow
          │
      MID Server
          │
     PowerShell
          │
     Active Directory
          │
    Windows Endpoints
```

## Environment

* **Microsoft 365 E5 Developer**
* **Microsoft Entra ID**
* **Exchange Online**
* **Microsoft Teams**
* **OneDrive**
* **Active Directory + DNS**
* **Windows 10 Pro Endpoints**
* **ServiceNow**
* **ServiceNow MID Server**
* **PowerShell**

## Lab Users

Existing AD users are reused across the lab:

```text
admin
it.adam
it.sophia
hr.ahmed
hr.sara
sales.lina
sales.youssef
finance.nadia
finance.omar
```

M365-specific groups and test configurations are added when required by individual scenarios.

## Support Scenarios

The lab covers realistic enterprise support cases:

| ID     | Scenario                 |
| ------ | ------------------------ |
| INC001 | Outlook / Email Issue    |
| INC002 | Shared Mailbox Access    |
| INC003 | Teams Access Issue       |
| INC004 | OneDrive Synchronization |
| INC005 | Windows Performance      |
| INC006 | DNS Resolution           |
| INC007 | Printer Issue            |
| INC008 | Account Lockout          |
| INC009 | VPN Connectivity         |
| INC010 | Phishing Report          |

Each scenario follows an operational workflow:

```text
Incident
   ↓
Investigation
   ↓
Troubleshooting
   ↓
Resolution
   ↓
Documentation
```

## JML Automation

The project also implements automated **Joiner, Mover, and Leaver** workflows using ServiceNow, MID Server, PowerShell, and Active Directory.

```text
ServiceNow Request
       ↓
    MID Server
       ↓
   PowerShell
       ↓
Active Directory
```

## Repository Structure

```text
M365-windows-servicenow-support-lab/
│
├── README.md
├── docs/
│   ├── architecture.md
│   ├── setup.md
│   ├── troubleshooting.md
│   ├── jml.md
│   └── lessons-learned.md
│
├── scenarios/
│   ├── INC001-outlook-email/
│   ├── INC002-shared-mailbox/
│   ├── INC003-teams/
│   ├── INC004-onedrive/
│   ├── INC005-windows-performance/
│   ├── INC006-dns/
│   ├── INC007-printer/
│   ├── INC008-account-lockout/
│   ├── INC009-vpn/
│   └── INC010-phishing/
│
├── automation/
│   ├── JML/
│   └── PowerShell/
│
└── screenshots/
```

## Skills Demonstrated

* Microsoft 365 Administration
* Entra ID & Identity Management
* Windows Endpoint Support
* Active Directory & DNS
* ServiceNow ITSM
* Incident Management & Troubleshooting
* PowerShell Automation
* JML Automation
* Documentation & Knowledge Management
* Least Privilege & Access Management

