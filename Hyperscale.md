

---

## Azure SQL Database – “vanliga” tiers

### **General Purpose**

* **Max storlek per databas:** **5 TB**
* **Arkitektur:** Compute + lagring (remote storage)
* **Typiskt användningsområde:**
  Affärssystem, webbappar, SaaS, “det mesta”

### **Business Critical**

* **Max storlek per databas:** **4 TB**
* **Arkitektur:** Allt lokalt på snabba SSD:er
* **Typiskt användningsområde:**
  Låg latens, hög IOPS, OLTP med tuffa svarstidskrav

> Skillnaden i maxstorlek beror på hur lagringen är byggd – BC prioriterar prestanda före volym.

---


---

## Hyperscale (kontrast)

* **Max storlek:** **100 TB+**
* **Helt annan arkitektur**
* Det är därför man *byter tier*, inte “bara skalar vidare”.

---

## Tumregler från verkligheten

* **Upp till ~1 TB**
  → General Purpose funkar nästan alltid
* **1–4 TB + extrem OLTP-prestanda**
  → Business Critical
* **>4–5 TB eller snabb tillväxt**
  → Börja planera för Hyperscale
* **>10 TB**
  → Hyperscale eller Managed Instance (beroende på krav)

---

## Viktigt (som ofta glöms)

* Maxstorlek ≠ bra idé att fylla hela vägen
* Index, version store, tempdb-tryck, backup/restore och underhåll blir **påtagligt jobbigare** redan långt innan maxgränsen
* Många “3–4 TB-databaser” mår bättre av:

  * partitionering
  * arkivering
  * eller Hyperscale

---


