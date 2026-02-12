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

## 🛠️ Step 3 – Restore the Database from Backup

1. In the Azure portal, search for **Azure SQL databases**

2. Click **+ Create**

3. Select the tab **Restore**

4. Configure the restore settings:

   - **Source database:** Select the deleted database  
     `AdventureWorksLT`
   - **Restore point:** Choose the most recent available time
   - **Database name:** `AdventureWorksLT`
   - **Server:** Same original server
   - **Compute + storage:** Keep default settings

5. Click **Review + Create**

6. Click **Create**

---

## ⏳ Step 4 – Verify the Restore

1. Wait until deployment completes

2. Confirm that:

   - `AdventureWorksLT` is available again
   - The database status is **Online**

3. (Optional) Open **Query editor** and verify data

---

## 🎉 Result

You have successfully:

- Created a copy of an Azure SQL Database
- Deleted the original database
- Restored the database from the latest available backup

This demonstrates Azure SQL automatic backup and point-in-time restore functionality.

---
