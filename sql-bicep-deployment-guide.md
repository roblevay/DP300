# Azure SQL Server + Database Deployment with Bicep (PowerShell Guide)

This guide shows a full working example of:

- Loading the Az PowerShell module  
- Logging into Azure  
- Creating a resource group  
- Deploying a Bicep template that creates:
  - A logical Azure SQL Server  
  - A Basic-tier Azure SQL Database  
- Removing the resource group afterwards  

---

## 1. Load the Az Module

```powershell
Import-Module Az
```

(Optional) Verify installed version:

```powershell
Get-Module Az -ListAvailable
```

---

## 2. Sign in to Azure

```powershell
Connect-AzAccount
```

(Optional) Select the correct subscription:

```powershell
Set-AzContext -SubscriptionName "Your Subscription Name"
```

---

## 3. Create a Resource Group

We create a test resource group called **testrg**:

```powershell
New-AzResourceGroup -Name "testrg" -Location "WestEurope"
```

---

## 4. Ensure Bicep CLI is Available

Azure CLI may already have Bicep installed:

```powershell
az bicep install
```

If PowerShell cannot find `bicep.exe`, add it to PATH for this session:

```powershell
$env:PATH += ";C:\Users\student\.azure\bin"
```

Verify:

```powershell
bicep --version
```

---

## 5. Create the Bicep Template File

Save this as:

```
C:\labfiles\sql-server-and-db.bicep
```

### sql-server-and-db.bicep

```bicep
param location string = resourceGroup().location

@description('Logical SQL server name (must be globally unique).')
param sqlServerName string

@description('SQL admin login name.')
param adminLogin string = 'sqladminuser'

@secure()
@description('SQL admin password.')
param adminPassword string

@description('Database name.')
param databaseName string = 'testdatabase'

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    publicNetworkAccess: 'Enabled'
    minimalTlsVersion: '1.2'
  }
}

resource sqlDb 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: databaseName
  parent: sqlServer
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648 // 2 GB
  }
}

@description('FQDN for the SQL Server.')
output serverFqdn string = '${sqlServer.name}.${environment().suffixes.sqlServerHostname}'

@description('Resource name for the created database.')
output databaseResourceName string = sqlDb.name
```

---

## 6. Deploy SQL Server + Database with PowerShell

Run this from the folder where the Bicep file exists:

```powershell
cd C:\labfiles
```

Then deploy:

```powershell
$rg = "testrg"

# Create a long unique server name starting with "testserver"
$serverName = "testserver$(Get-Date -Format 'yyyyMMddHHmmss')$(Get-Random -Maximum 9999)"

New-AzResourceGroupDeployment `
  -ResourceGroupName $rg `
  -TemplateFile ".\sql-server-and-db.bicep" `
  -sqlServerName $serverName `
  -adminLogin "sqladminuser" `
  -adminPassword (ConvertTo-SecureString "myS3cret2027" -AsPlainText -Force) `
  -databaseName "testdatabase"
```

After deployment you will get output similar to:

- SQL Server FQDN  
- Database resource name  

Example:

```
testserver202602111530451234.database.windows.net
```

---

## 7. Delete the Resource Group (Cleanup)

When finished, remove everything:

```powershell
Remove-AzResourceGroup -Name "testrg" -Force
```

This deletes:

- SQL Server  
- SQL Database  
- All resources inside the group  

---

## Done 🎉

You now have a full working deployment + cleanup workflow using:

- PowerShell  
- Bicep  
- Azure SQL Server + Basic Database  
