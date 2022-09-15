---
title: Åtgärda timeout-fel vid sammanfogning av stora xml-datafiler med xdp-mall
description: Sammanfoga stora XML-filer med mallar i AEM Forms
type: Troubleshooting
role: Admin
level: Intermediate
version: 6.5
feature: Output Service,Forms Service
topic: Administration
kt: 11091
source-git-commit: 164741ce5ae7d00f904365589438c2eaaf1e05db
workflow-type: tm+mt
source-wordcount: '185'
ht-degree: 0%

---

# Hur man skapar PDF-filer genom att sammanfoga stora xml-datafiler med xdp-mallar

När du sammanfogar stora xml-datafiler med xdp-mallen kan du se följande fel i loggfilen

```txt
POST /services/OutputService/GeneratePdfOutput HTTP/1.1] com.adobe.fd.output.internal.exception.OutputServiceException AEM_OUT_001_003:Unexpected Exception: client timeout reached org.omg.CORBA.TIMEOUT: client timeout reached
```

Så här åtgärdar du ovanstående fel

## Ändra tidsgränsen för listor

* Stoppa AEM
* Skapa en mapp med namnet **installera** under mappen crx-quickstart i AEM
* Skapa en fil med namnet **org.apache.aries.transaction.config** med följande innehåll aries.transaction.timeout=&quot;1200&quot; under installationsmappen. Du kan ändra timeout-värdet enligt dina önskemål. Timeout-värdet är i sekunder

>[!NOTE]
> När du har skapat konfigurationen org.apache.aries.transaction kan du redigera transaktionens timeout-värden från [configMgr](http://localhost:4502/system/console/configMgr) i stället för att redigera filen


## Ändra inställningar för Jacorb ORB-providern

* [Öppna OSGi ConfigMgr](http://localhost:4502/system/console/configMgr)
* Sök efter **Jacorb ORB Provider**
* Lägg till följande post jacorb.connection.client.pending_reply_timeout=600000 Ovanstående inställning anger timeout för väntande svar (kallas även CORBA-klienttimeout) till 600 sekunder.
* Spara ändringarna
