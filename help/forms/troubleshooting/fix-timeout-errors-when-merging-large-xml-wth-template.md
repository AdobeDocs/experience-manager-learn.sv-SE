---
title: Åtgärda timeout-fel när stora xml-datafiler slås samman med xdp-mallen
description: Sammanfoga stora XML-filer med mallar i AEM Forms
type: Troubleshooting
role: Admin
level: Intermediate
version: 6.5
feature: Output Service,Forms Service
topic: Administration
jira: KT-11091
exl-id: 933ec5f6-3e9c-4271-bc35-4ecaf6dbc434
duration: 42
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '178'
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
