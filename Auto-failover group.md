---

# 🧪 Create a failover group

## Start

Log on to the Azure portal and verify that you have an Azure SQL Database called **AdventureWorksLT**.



---

## 🛠️ Step 1 – 

1. Log in to the Azure portal at  
   **https://portal.azure.com**

2. Go to the database AdventureworksLT on one of the servers

3. Go to **replicas**

4. To the right of the Readable replica, click the three dots and select **stop replication**
5. Confirm with ***Yes**

The repliation is now stopped

---

---

## 🛠️ Step 2 – Create a Secondary Server in Another Region (If not already created)

1. In the Azure portal, click **Create a resource**

2. Search for **SQL server** and click **Create**

3. Configure the server with the following settings:

   - **Server name:** `dp300-failover-xx`
     (where `xx` are your initials or any unique value)
   - **Region:** Choose a different region than your primary server
   - **Authentication method:** Use SQL authentication
   - **Server admin login:** `sqladmin`
   - **Password:** (same or new password)

4. Click **Review + Create**

5. Click **Create**

Wait until the server deployment is completed.

---

## 🛠️ Step 3 – Create a Failover Group

1. In the Azure portal, search for **SQL servers**

2. Select the primary SQL server that hosts the database  
   **AdventureWorksLT**

3. In the left menu under **Settings**, select  
   **Failover groups**

4. Click **+ Add group**

---

## 🛠️ Step 4 – Configure the Failover Group

1. Enter a name for the failover group:

   - `fg-adventureworks`

2. Under **Secondary server**, click **Choose server**

3. Select the secondary server you created earlier:  
   `dp300-failover-xx`

4. Click **Select**

---

## 🛠️ Step 5 – Add the Database to the Failover Group

1. Under **Databases**, click **Add database**

2. Select **AdventureWorksLT**

3. Click **Select**

Azure will now configure geo-replication automatically.

---

## 🛠️ Step 6 – Configure Failover Policy

1. Choose the failover policy:

   - **Automatic failover**
   - Set grace period (e.g., 1 hour)

   OR

   - **Manual failover** (recommended for lab environments)

2. Click **Create**

---

## ⏳ Step 7 – Wait for Synchronization

1. Go to the Failover group overview

2. Verify that:

   - Replication status = **Healthy**
   - Secondary database status = **Synchronized**

This may take a few minutes.

---

## 🛠️ Step 8 – Test a Manual Failover

1. In the failover group, click **Failover**

2. Confirm the operation

3. Wait for the roles to switch:

   - Secondary becomes Primary
   - Primary becomes Secondary

4. Verify that the database is now active in the secondary region

---

## 🛠️ Step 9 – (Optional) Fail Back

1. Click **Failover** again

2. Confirm to switch back to the original primary region

---

## 🎉 Result

You have successfully:

- Created a secondary SQL server in another region
- Configured a Failover Group
- Enabled geo-replication
- Tested manual failover

Your database is now protected against regional outages.

---
