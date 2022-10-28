---
title: Skicka e-post om inskickning av anpassat formulär
seo-title: Sending Email on Adaptive Form Submission
description: Skicka bekräftelsemeddelande via e-post när formulär skickas in på ett adaptivt sätt med skicka-e-postkomponenten
seo-description: Send confirmation email on adaptive form submission using the send email component
uuid: 6c9549ba-cb56-4d69-902c-45272a8fd17e
feature: Adaptive Forms
topics: authoring, integrations
audience: developer
doc-type: article
activity: use
discoiquuid: 1187357f-2f36-4a04-b708-44bb9c174fb5
topic: Development
role: Developer
level: Beginner
exl-id: 19c5aeec-2893-4ada-b6df-b80c4be2468a
last-substantial-update: 2020-07-07T00:00:00Z
source-git-commit: 7a2bb61ca1dea1013eef088a629b17718dbbf381
workflow-type: tm+mt
source-wordcount: '214'
ht-degree: 0%

---

# Skicka e-post om inskickning av anpassat formulär {#sending-email-on-adaptive-form-submission}

En vanlig åtgärd är att skicka ett bekräftelsemeddelande via e-post till den som skickat in det anpassade formuläret. För att uppnå detta väljer vi&quot;Skicka e-post&quot; som skicka-åtgärd.

Du kan använda e-postmallen eller bara skriva i e-postmeddelandets brödtext, vilket visas på skärmbilden nedan.

Observera syntaxen för att infoga formulärfältsvärden i e-postmeddelandet.Vi har också möjlighet att inkludera formulärbilagor i e-postmeddelandet genom att markera kryssrutan &quot;inkludera bilagor&quot; i konfigurationsegenskaperna.

När det adaptiva formuläret skickas får mottagaren ett e-postmeddelande.

![SendEmail](assets/sendemailaction.gif)

## Konfigurationer krävs {#configurations-needed}

Du måste konfigurera Day CQ Mail-tjänsten. Detta kan konfigureras genom att peka webbläsaren till [Felix Configuration Manager](http://localhost:4502/system/console/configMgr)

På skärmbilden visas konfigurationsegenskaperna för Adobe-e-postservern.

![mailservice](assets/mailservice.png)

Följ dessa anvisningar om du vill prova detta på servern:

* [Importera resurserna](assets/timeoffrequest.zip) som är associerad med den här artikeln i AEM med hjälp av pakethanteraren.

* Öppna [TimeOffRequestForm](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled).

* Fyll i informationen.Se till att du anger en giltig e-postadress i e-postfältet.

* Skicka formuläret.
