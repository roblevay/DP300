
# 🧪 Backup database to Azure

## Start
Log on to the default SQL Server on your virtual machine. Verify that you have a database called Adventureworks2017



---

## 🛠️ Step 1 – Create a Storage Account in Azure

1. Log in to the Azure portal at portal.azure.com
2. 
3. Expand **SQL Server Agent** > **Jobs**.
4. Right-click **Jobs** > **New Job**.
5. Name the job: `Backup Adventureworks`.
6. Add a step:
   - Type: Transact-SQL
   - Command:

```sql
BACKUP DATABASE AdventureWorks
TO DISK = 'C:\DemoDatabases\AdventureWorks.bak'
WITH INIT;
```
