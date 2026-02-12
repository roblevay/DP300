---

# 🧪 Copy and Restore Azure SQL Database

## Start

Log on to the Azure portal and verify that you have:

- A resource group called **contoso-rg**
- An Azure SQL Database called **AdventureWorksLT**

---

## 🛠️ Step 1 – Create a Copy of the Database

1. Log in to the Azure portal at  
   **https://portal.azure.com**

2. In the search bar, type **Resource groups**  
   and select **contoso-rg**

3. In the resource list, select the database  
   **AdventureWorksLT**

4. In the top menu, click **Copy**

5. On the Create SQL Database page, configure:

   - **Database name:** `AdventureWorksLTCopy`
   - **Server:** Same as the source database
   - **Compute + storage:** Keep default settings

6. Click **Review + Create**

7. Click **Create**

8. Wait until deployment is completed.

9. Verify that you now see both:

   - `AdventureWorksLT`
   - `AdventureWorksLTCopy`

---

## 🛠️ Step 2 – Delete the Original Database

1. Go back to the database  
   **AdventureWorksLT**

2. Click **Delete** in the top menu

3. Type the database name to confirm deletion

4. Click **Delete**

5. Wait until the database is removed

---

---

## 🛠️ Step 3 – Restore the Database from the Latest Backup

When an Azure SQL Database has been deleted, it cannot be restored directly from the database page.

Instead, you must restore it from the **SQL server** using the **Deleted databases** feature.

---

### 4. Open the SQL Server

1. In the Azure portal, search for **SQL servers**

2. Select the server where the database was hosted  
   (the same server that previously contained `AdventureWorksLT`)

---

### 5. Locate Deleted Databases

1. In the left menu of the SQL server, scroll down to:

   **Data management → Deleted databases**

2. Click **Deleted databases**

3. Locate the deleted database:

   - `AdventureWorksLT`

---

### 6. Restore the Database

1. Select **AdventureWorksLT**

2. Click **Restore**

3. Configure the restore settings:

   - **Restore point:** Select the most recent available restore time
   - **Database name:** `AdventureWorksLT`
   - **Target server:** Same server as before
   - **Compute + storage:** Keep default settings

4. Click **Review + Create**

5. Click **Create**

---

### 7. Verify the Restore

1. Wait until the deployment is completed

2. Go to **SQL databases**

3. Confirm that the database `AdventureWorksLT` is available again and online

---

## 🎉 Result

The database has been successfully restored from the latest automatic backup using point-in-time restore.

---
