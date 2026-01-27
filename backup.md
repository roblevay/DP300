
# 🧪 Backup database to Azure

## Start
Log on to the default SQL Server on your virtual machine. Verify that you have a database called Adventureworks2017



---

## 🛠️ Step 1 – Create a Storage Account in Azure

1. Log in to the Azure portal at portal.azure.com
2. In the search field, type **Storage** and then select **Storage accpunts**
3. Click **Create**
4. Create a storage account in the **Contoso-rg** resource group with the name **storagedp300xx** where xx is your initials or any other unique name

## 🛠️ Step 2 – Create a container in the Storage Account 
1. Select hte newly created storage account **storagedp300xx**
2. Under **Data storage**, select **Containers**
3. Click **Add container**
4. Fill out the name **backups** and click **Create**



## 🛠️ Step 3 – Create a Storage Account in Azure

1. In **SQL Server Management Studio**, in Object Explorer, select the database **Adventureworks2017**
2. At **Destination**, select **URL**
3. Click **Add**
4. Click **New Container**
5. Click ***Sign In** and then sign in to Azure. Close the web page when signed in
6. At **Select Storage Account**, select the account created earlier. **storagedp300xx** where xx is your initials or any other unique name
7. At **Select Blob Container**, select **backups**
8. Click **Create Credential**
9. Click **OK** and then **OK** again
10. Click **OK** to perform the backup




