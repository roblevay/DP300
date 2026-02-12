---

# 🧪 Export Azure SQL Database to a BACPAC Backup File

## Start

Log on to the Azure portal and verify that you have an Azure SQL Database called **AdventureWorksLT**.

You will export the database into a **.bacpac** file and store it in an Azure Storage Account.

---

## 🛠️ Step 1 – Create a Storage Account in Azure

1. Log in to the Azure portal at  
   **https://portal.azure.com**

2. In the search bar, type **Storage accounts**  
   and select **Storage accounts**

3. Click **+ Create**

4. Create a storage account with the following settings:

   - **Resource group:** `contoso-rg`
   - **Storage account name:** `storagedp300xx`  
     (where `xx` is your initials or any unique name)
   - **Region:** Same region as your SQL Database
   - **Performance:** Standard
   - **Redundancy:** Locally-redundant storage (LRS)

5. Click **Review + Create**

6. Click **Create**

---

## 🛠️ Step 2 – Create a Container in the Storage Account

1. Open the newly created storage account  
   **storagedp300xx**

2. Under **Data storage**, select **Containers**

3. Click **+ Container**

4. Enter the following:

   - **Name:** `backups`
   - **Public access level:** Private (default)

5. Click **Create**

---

## 🛠️ Step 3 – Export the Database to a BACPAC File

1. In the Azure portal, search for **SQL databases**

2. Select the database **AdventureWorksLT**

3. In the top menu, click **Export**

4. On the Export blade, configure the following:

   - **Storage account:** `storagedp300xx`
   - **Container:** `backups`
   - **File name:** `AdventureWorksLT.bacpac`

5. Enter the SQL Server administrator login:

   - **Login:** `sqladmin`
   - **Password:** (your SQL admin password)

6. Click **OK** to start the export

---

## ⏳ Step 4 – Monitor the Export Operation

1. In the Azure portal, click the notification bell (top right)

2. Wait until the export shows:

   ✅ Export completed successfully

---

## ✅ Step 5 – Verify the Backup File in Storage

1. Go back to the storage account  
   **storagedp300xx**

2. Under **Data storage**, select **Containers**

3. Open the container **backups**

4. Verify that you see the file:

   - `AdventureWorksLT.bacpac`

---

## 🎉 Result

You have successfully exported your Azure SQL Database to a **BACPAC backup file** stored in Azure Blob Storage.

This file can later be used to restore or import the database into another SQL Server or Azure SQL Database.

---
