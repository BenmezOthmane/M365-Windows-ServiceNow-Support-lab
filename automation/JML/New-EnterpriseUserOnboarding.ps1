param(
    [string]$FirstName,
    [string]$First_Name,

    [string]$LastName,
    [string]$Last_Name,

    [string]$SamAccountName,
    [string]$Sam_Account_Name,

    [string]$Department,

    [string]$JobTitle,
    [string]$Job_Title,

    [string]$UserPrincipalName,
    [string]$User_Principal_Name
)

Import-Module ActiveDirectory

# ============================================================
# Normalize alternative parameter names
# ============================================================

if ([string]::IsNullOrWhiteSpace($FirstName) -and
    -not [string]::IsNullOrWhiteSpace($First_Name)) {
    $FirstName = $First_Name
}

if ([string]::IsNullOrWhiteSpace($LastName) -and
    -not [string]::IsNullOrWhiteSpace($Last_Name)) {
    $LastName = $Last_Name
}

if ([string]::IsNullOrWhiteSpace($SamAccountName) -and
    -not [string]::IsNullOrWhiteSpace($Sam_Account_Name)) {
    $SamAccountName = $Sam_Account_Name
}

if ([string]::IsNullOrWhiteSpace($JobTitle) -and
    -not [string]::IsNullOrWhiteSpace($Job_Title)) {
    $JobTitle = $Job_Title
}

if ([string]::IsNullOrWhiteSpace($UserPrincipalName) -and
    -not [string]::IsNullOrWhiteSpace($User_Principal_Name)) {
    $UserPrincipalName = $User_Principal_Name
}

# ============================================================
# Default Department
# ============================================================

if ([string]::IsNullOrWhiteSpace($Department)) {
    $Department = "HR"
}

# ============================================================
# Required field validation
# ============================================================

if ([string]::IsNullOrWhiteSpace($FirstName)) {
    throw "FirstName is required."
}

if ([string]::IsNullOrWhiteSpace($LastName)) {
    throw "LastName is required."
}

if ([string]::IsNullOrWhiteSpace($SamAccountName)) {
    throw "SamAccountName is required."
}

if ([string]::IsNullOrWhiteSpace($UserPrincipalName)) {
    throw "UserPrincipalName is required."
}

# ============================================================
# Department validation
# ============================================================

$validDepartments = @(
    "HR",
    "Sales",
    "Finance",
    "IT"
)

if ($validDepartments -notcontains $Department) {
    throw "Invalid Department: $Department. Valid values are: HR, Sales, Finance, IT."
}

# ============================================================
# Department → OU mapping
# ============================================================

$TargetOU = "OU=$Department,OU=Users,OU=Genitech,DC=genitech,DC=lab"

# ============================================================
# Department → Group mapping
# ============================================================

$DepartmentGroups = @{
    "HR"      = "GG-HR-Users"
    "Sales"   = "GG-Sales-Users"
    "Finance" = "GG-Finance-Users"
    "IT"      = "GG-IT-ServiceDesk"
}

$TargetGroup = $DepartmentGroups[$Department]

# ============================================================
# Verify OU exists
# ============================================================

$OUExists = Get-ADOrganizationalUnit `
    -Identity $TargetOU `
    -ErrorAction SilentlyContinue

if (-not $OUExists) {
    throw "Target OU does not exist: $TargetOU"
}

# ============================================================
# Verify Group exists
# ============================================================

$GroupExists = Get-ADGroup `
    -Identity $TargetGroup `
    -ErrorAction SilentlyContinue

if (-not $GroupExists) {
    throw "Target group does not exist: $TargetGroup"
}

# ============================================================
# Check if user already exists
# ============================================================

$ExistingUser = Get-ADUser `
    -Filter "SamAccountName -eq '$SamAccountName'" `
    -Properties Department,Title,UserPrincipalName,DistinguishedName `
    -ErrorAction SilentlyContinue

# ============================================================
# Create new user
# ============================================================

if (-not $ExistingUser) {

    Write-Host "Creating new AD user: $SamAccountName"

    # LAB ONLY:
    # Replace this with a secure credential mechanism in production.
    $TemporaryPassword = Read-Host `
        "Enter temporary password" `
        -AsSecureString

    New-ADUser `
        -Name "$FirstName $LastName" `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $SamAccountName `
        -UserPrincipalName $UserPrincipalName `
        -Department $Department `
        -Title $JobTitle `
        -Path $TargetOU `
        -AccountPassword $TemporaryPassword `
        -Enabled $true `
        -ChangePasswordAtLogon $true

    Write-Host "SUCCESS: User $SamAccountName created."
}

# ============================================================
# Existing user handling
# ============================================================

else {

    Write-Host "User already exists: $SamAccountName"

    $CurrentOU = (
        $ExistingUser.DistinguishedName `
        -replace '^CN=[^,]+,',''
    )

    if ($CurrentOU -ne $TargetOU) {

        Write-Host "Moving user to target OU..."

        Move-ADObject `
            -Identity $ExistingUser.DistinguishedName `
            -TargetPath $TargetOU

        Write-Host "SUCCESS: User moved to $TargetOU"
    }

    Set-ADUser `
        -Identity $SamAccountName `
        -Department $Department `
        -Title $JobTitle `
        -UserPrincipalName $UserPrincipalName
}

# ============================================================
# Add user to department group
# ============================================================

Add-ADGroupMember `
    -Identity $TargetGroup `
    -Members $SamAccountName `
    -ErrorAction SilentlyContinue

Write-Host "SUCCESS: User added to $TargetGroup."

# ============================================================
# Final verification
# ============================================================

$FinalUser = Get-ADUser `
    -Identity $SamAccountName `
    -Properties Department,Title,UserPrincipalName,Enabled,DistinguishedName

Write-Host ""
Write-Host "========================================"
Write-Host "JML JOINER COMPLETED"
Write-Host "========================================"

Write-Host "Name:              $($FinalUser.Name)"
Write-Host "Username:          $($FinalUser.SamAccountName)"
Write-Host "UPN:               $($FinalUser.UserPrincipalName)"
Write-Host "Department:        $($FinalUser.Department)"
Write-Host "Job Title:         $($FinalUser.Title)"
Write-Host "Enabled:           $($FinalUser.Enabled)"
Write-Host "OU:                $($FinalUser.DistinguishedName)"
Write-Host "Department Group:  $TargetGroup"

Write-Host "========================================"
