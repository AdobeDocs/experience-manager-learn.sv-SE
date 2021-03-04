---
title: Skicka e-post om inskickning av anpassat formulär
seo-title: Skicka e-post om inskickning av anpassat formulär
description: Skicka bekräftelsemeddelande via e-post när formulär skickas in på ett adaptivt sätt med skicka-e-postkomponenten
seo-description: Skicka bekräftelsemeddelande via e-post när formulär skickas in på ett adaptivt sätt med skicka-e-postkomponenten
uuid: 6c9549ba-cb56-4d69-902c-45272a8fd17e
feature: adaptiva formulär
topics: authoring, integrations
audience: developer
doc-type: article
activity: use
discoiquuid: 1187357f-2f36-4a04-b708-44bb9c174fb5
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '233'
ht-degree: 0%

---


# Skickar e-post om inskickning av anpassat formulär {#sending-email-on-adaptive-form-submission}

En vanlig åtgärd är att skicka ett bekräftelsemeddelande via e-post till den som skickat in det anpassade formuläret. För att uppnå detta väljer vi&quot;Skicka e-post&quot; som skicka-åtgärd.

Du kan använda e-postmallen eller bara skriva i e-postmeddelandets brödtext, vilket visas på skärmbilden nedan.

Observera syntaxen för att infoga formulärfältsvärden i e-postmeddelandet.Vi har också möjlighet att inkludera formulärbilagor i e-postmeddelandet genom att markera kryssrutan &quot;inkludera bilagor&quot; i konfigurationsegenskaperna.

När det adaptiva formuläret skickas får mottagaren ett e-postmeddelande.

![SendEmail](assets/sendemailaction.gif)

## Konfigurationer som behövs {#configurations-needed}

Du måste konfigurera Day CQ Mail-tjänsten. Detta kan konfigureras genom att peka din webbläsare till [Felix Configuration Manager](http://localhost:4502/system/console/configMgr)

På skärmbilden visas konfigurationsegenskaperna för Adobe-e-postservern.

![mailservice](assets/mailservice.png)

Följ dessa anvisningar om du vill prova detta på servern:

* [Importera de ](assets/timeoffrequest.zip) resurser som är associerade med den här artikeln i AEM med pakethanteraren.

* Öppna [TimeOffRequestForm](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled).

* Fyll i informationen.Se till att du anger en giltig e-postadress i e-postfältet.

* Skicka formuläret.
