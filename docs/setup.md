# Lab Setup

## Environment

| Component | Role |
|---|---|
| DC01 | Active Directory + DNS |
| WIN-USER-01 | Windows 10 Pro |
| WIN-USER-02 | Windows 10 Pro |
| ServiceNow | ITSM & Workflow |
| MID_DC01_GENITECH | ServiceNow MID Server |
| PowerShell | AD Automation |
| Microsoft Entra ID | Cloud Identity |

**Domain:** `genitech.lab`

### AD Structure

```text
Genitech
└── Users
    ├── HR
    ├── Sales
    ├── Finance
    └── IT
```

## Main AD Groups
- GG-HR-Users
- GG-Sales-Users
- GG-Finance-Users
- GG-IT-ServiceDesk

The environment provides the infrastructure required for Windows endpoint support, Microsoft 365 administration, ServiceNow
workflows, and identity automation.

## Current Status
- Active Directory + DNS
- Windows endpoints
- ServiceNow
- MID Server
- PowerShell automation
- Microsoft Entra ID
- JML Joiner workflow
