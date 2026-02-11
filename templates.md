

---

# 🔹 Förutsättningar

Du behöver:

```powershell
Connect-AzAccount
```

Och ev. välja subscription:

```powershell
Set-AzContext -SubscriptionName "Din Subscription"
```

---

# ✅ 1️⃣ Skapa Resource Group

```powershell
New-AzResourceGroup `
    -Name "testrg" `
    -Location "WestEurope"
```

---

