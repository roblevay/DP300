Open this folder in Visual Studio Code

   ```url
   https://github.com/MicrosoftLearning/dp-300-database-administrator.git
````

Save the content to **c:\Labfiles** on your computer

---

## Setup your SQL Server in Azure

Log in to Azure and check if you already have an Azure SQL Server instance running.

> [!TIP]
> ✅ If you already have a SQL Server instance in Azure, **skip this section**.

1. In VS Code, open the cloned repository from the previous section.

2. Right-click **`/Allfiles/Labs`** and select **Open in Integrated Terminal**.

3. Sign in using Azure CLI:

   ```bash
   az login
   ```

   > [!NOTE]
   > 🌐 A browser window will open. Sign in using your Azure credentials.

4. Create the resource group, SQL server, and database:

   ```bash
   cd ./Setup
   ./deploy-sql-database.ps1
   ```

   > [!NOTE]
   > 🧩 Defaults used by the script:
   >
   > * Resource group: **`contoso-rg`** (or an existing RG starting with `contoso-rg`)
   > * Region: **West US 2** (`westus2`)
   > * Admin password: random **12-character** password (meets Azure complexity rules)
   >
   > You can override with `-rgName`, `-location`, and `-sqlAdminPw`.

   > [!NOTE]
   > 🔥 The script also adds your **current public IP** to the SQL Server firewall rules.

5. When the script completes, note the:

   * Resource group name
   * SQL server name
   * Database name
   * Admin username + password

---

## Create an Automation Account

1. Open the Azure portal: [https://portal.azure.com](https://portal.azure.com)

2. Search for **Automation Accounts** → select **+ Create**

3. Enter:

   * **Resource Group:** `<Your resource group>`
   * **Automation account name:** `autoAccount`
   * **Region:** Use the default

4. Select **Review + Create** → **Create**

> [!NOTE]
> ⏳ Your automation account may take a few minutes to create.

---

## Connect to an existing Azure SQL Database

1. In Azure portal, search for **SQL databases**
2. Select **`AdventureWorksLT`**
3. Select **Query editor (preview)**
4. Sign in with the database admin credentials → **OK**
5. A new tab may open:

   * Select **Add client IP**
   * Select **Save**
   * Return to the previous tab and select **OK** again

> [!WARNING]
> If you see: *Client with IP address ‘x.x.x.x’ is not allowed to access the server*, you must add your current public IP to the SQL Server firewall rules.

If you need to set firewall rules:

1. Select **Set server firewall** from the database **Overview** page
2. Select **Add your current IPv4 address**
3. Select **Save**
4. Return to **AdventureWorksLT → Query editor (preview)** and sign in again

Next, load and run the lab script:

6. In Query editor, select **Open query**

7. Browse to:

   ```text
   C:\LabFiles\dp-300-database-administrator\Allfiles\Labs\Module13
   ```

8. Open **`usp_AdaptiveIndexDefrag.sql`**

9. Delete `USE msdb` and `GO` (lines 5–6), then select **Run**

10. Expand **Stored Procedures** to confirm they were created ✅

---

## Configure Automation Account assets

You’ll configure required assets for the runbook.

1. Search for **Automation Accounts**
2. Select **`autoAccount`**
3. Go to **Shared Resources → Modules → Browse gallery**
4. Search for **SqlServer**
5. Select **SqlServer** → **Select**
6. Choose the latest runtime version → **Import**

### Create a credential

1. Go to **Shared Resources → Credentials**

2. Select **+ Add a Credential**

3. Enter:

   * **Name:** `SQLUser`
   * **User name:** `sqladmin`
   * **Password:** `<Strong password (12+ chars, uppercase, lowercase, number, special)>`
   * **Confirm password:** `<Re-enter>`

4. Select **Create**

---

## Create a PowerShell runbook

1. Go to **SQL databases** → select **`AdventureWorksLT`**
2. On the Overview page, copy the **Server name** (typically starts with `dp300-lab…`)
3. Search for **Automation Accounts** → select **`autoAccount`**
4. Go to **Process Automation → Runbooks**
5. Select **+ Create a runbook**

> [!NOTE]
> 🧠 Two runbooks may already exist — created automatically during deployment.

6. Set:

   * **Name:** `IndexMaintenance`
   * **Runbook type:** PowerShell
   * **Runtime version:** Latest
     Then select **Review + Create** → **Create**.

7. Paste this script into the editor:

   ```powershell
   $AzureSQLServerName = ''
   $DatabaseName = 'AdventureWorksLT'
      
   $Cred = Get-AutomationPSCredential -Name "SQLUser"
   $SQLOutput = $(Invoke-Sqlcmd -ServerInstance $AzureSQLServerName -UserName $Cred.UserName -Password $Cred.GetNetworkCredential().Password -Database $DatabaseName -Query "EXEC dbo.usp_AdaptiveIndexDefrag" -Verbose) 4>&1

   Write-Output $SQLOutput
   ```

> [!NOTE]
> 🧩 This PowerShell runbook executes `dbo.usp_AdaptiveIndexDefrag` using `Invoke-Sqlcmd` and retrieves the stored credential via `Get-AutomationPSCredential`.

8. On the first line, paste in your Azure SQL **server name**.
9. Select **Save** → **Publish** → **Yes**

✅ The runbook is now published.

---

## Create a schedule for the runbook

Schedule the runbook to run regularly.

1. In the **IndexMaintenance** runbook, select **Schedules**
2. Select **+ Add a schedule**
3. Select **Link a schedule to your runbook**
4. Select **+ Add a schedule**
5. Enter:

   * **Name:** `DailyIndexDefrag`
   * **Description:** Daily Index defrag for AdventureWorksLT database.
   * **Starts:** 4:00 AM (next day)
   * **Time zone:** Your local time zone
   * **Recurrence:** Recurring
   * **Recur every:** 1 day
   * **Set expiration:** No

> [!NOTE]
> 🕓 Start time is 4:00 AM the next day, recurring daily, never expires.

6. Select **Create** → **OK**
7. Confirm the schedule is linked ✅

---

## Cleanup resources

If you don’t need the Azure SQL Server anymore, clean up resources.

### Delete the resource group

1. In Azure portal, open **Resource groups**
2. Select the lab resource group
3. Select **Delete resource group**
4. Type the resource group name to confirm
5. Select **Delete**
6. Wait for deletion to complete
7. Close Azure portal

### Delete the lab resources only

If you used an existing resource group and want to keep it:

1. Open **Resource groups**
2. Select the resource group
3. Select all resources prefixed with the SQL Server name you specified
4. Select **Delete**
5. Type `delete` to confirm
6. Select **Delete** again
7. Wait for deletion to complete
8. Close Azure portal

### Delete the LabFiles folder

If you created a new LabFiles folder and no longer need it:

1. Open File Explorer → `C:\`
2. Right-click **LabFiles** → **Delete**
3. Confirm **Yes**

---

## Completion

✅ You have successfully completed this lab.

By completing this exercise you’ve automated index defragmentation on a SQL Server database to run every day at **4:00 AM**.

```
```

