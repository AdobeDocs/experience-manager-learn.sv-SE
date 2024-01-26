---
title: Använda steget Skicka e-post för Forms Workflow
description: Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas hur du konfigurerar komponenten för att skicka e-post
feature: Workflow
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
exl-id: 21e58bbc-c1d6-4d41-a4d4-f522a3a5d4a7
last-substantial-update: 2020-06-09T00:00:00Z
duration: 339
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '418'
ht-degree: 0%

---

# Använda steget Skicka e-post för Forms Workflow {#using-send-email-step-of-forms-workflow}

Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas hur du konfigurerar komponenten för att skicka e-post.

>[!VIDEO](https://video.tv.adobe.com/v/21499?quality=12&learn=on)

Som en del av den här artikeln ska vi ta dig igenom följande exempel:

1. En användare fyller i formuläret Time Off Request
1. När formulär skickas aktiveras AEM arbetsflöde
1. AEM använder komponenten Skicka e-post för att skicka ett e-postmeddelande med DoR som en bifogad fil

Innan du använder steget Skicka e-post ska du kontrollera att du har konfigurerat Dag CQ Mail Service från [configMgr](http://localhost:4502/system/console/configMgr). Ange värden som är specifika för din miljö

![Konfigurera daglig CQ Mail-tjänst](assets/mailservice.png)

Som en del av resurserna som är kopplade till den här artikeln får du följande

1. Adaptiv form som utlöser arbetsflödet när det skickas
1. Exempelarbetsflöde som skickar ett e-postmeddelande med DOR som bilaga
1. OSGi-paketet som skapar metadataegenskaperna

Så här kör du exemplet på datorn:

1. [Distribuera Developing with service user bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

1. [Hämta och installera setvalue-paketet](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)Paketet innehåller koden för att skapa metadataegenskaperna som en del av arbetsflödets processteg.
1. [Konfigurera daglig CQ Mail-tjänst](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/notification.html)
1. [Importera och installera resurser som är associerade med den här artikeln med hjälp av pakethanteraren i CRX](assets/emaildoraemformskt.zip)
1. Starta [adaptiv form](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled). Fyll i de obligatoriska fälten och skicka.
1. Du bör få ett e-postmeddelande med DocumentOfRecord som en bilaga

Utforska [arbetsflödesmodell](http://localhost:4502/editor.html/conf/global/settings/workflow/models/emaildor.html)

Ta en titt på arbetsflödets processsteg. Den anpassade kod som är associerad med processsteget skapar egenskapsnamn för metadata och anger värden från skickade data. Dessa värden används sedan av komponenten för att skicka e-post.

>[!NOTE]
>
>I AEM Forms 6.5 och senare behöver du inte den här anpassade koden för att skapa metadataegenskaper. Använd variabelfunktionerna i AEM

Kontrollera att fliken Bifogade filer i komponenten Skicka e-post är konfigurerad enligt skärmbilden nedan
![Fliken Skicka e-postbilaga](assets/sendemailcomponentconfigure.jpg)Värdet &quot;DOR.pdf&quot; måste matcha värdet som anges i dokumentsökvägen som anges i alternativen för att skicka det anpassade formuläret.
