---
title: Använda Skicka e-post-steget i Forms Workflow
description: Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas hur du konfigurerar komponenten för att skicka e-post
feature: Workflow
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
exl-id: 21e58bbc-c1d6-4d41-a4d4-f522a3a5d4a7
last-substantial-update: 2020-06-09T00:00:00Z
duration: 314
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '418'
ht-degree: 0%

---

# Använda Skicka e-post-steget i Forms Workflow {#using-send-email-step-of-forms-workflow}

Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas hur du konfigurerar komponenten för att skicka e-post.

>[!VIDEO](https://video.tv.adobe.com/v/21499?quality=12&learn=on)

Som en del av den här artikeln ska vi ta dig igenom följande exempel:

1. En användare fyller i formuläret Time Off Request
1. När formulär skickas aktiveras AEM Workflow
1. I AEM Workflow används komponenten Send Email för att skicka ett e-postmeddelande med DoR som en bilaga

Innan du använder steget Skicka e-post måste du konfigurera Day CQ Mail Service från [configMgr](http://localhost:4502/system/console/configMgr). Ange värden som är specifika för din miljö

![Konfigurera daglig CQ-e-posttjänst](assets/mailservice.png)

Som en del av resurserna som är kopplade till den här artikeln får du följande

1. Adaptiv form som utlöser arbetsflödet när det skickas
1. Exempelarbetsflöde som skickar ett e-postmeddelande med DOR som bilaga
1. OSGi-paketet som skapar metadataegenskaperna

Så här kör du exemplet på datorn:

1. [Distribuera Developing with service user bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

1. [Hämta och installera setvalue-paketet](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)Det här paketet innehåller koden för att skapa metadataegenskaperna som en del av arbetsflödets processsteg.
1. [Konfigurera daglig CQ-e-posttjänst](https://helpx.adobe.com/se/experience-manager/6-5/sites/administering/using/notification.html)
1. [Importera och installera resurser som är associerade med den här artikeln med hjälp av pakethanteraren i CRX](assets/emaildoraemformskt.zip)
1. Starta det [adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled). Fyll i de obligatoriska fälten och skicka.
1. Du bör få ett e-postmeddelande med DocumentOfRecord som en bilaga

Utforska [arbetsflödesmodellen](http://localhost:4502/editor.html/conf/global/settings/workflow/models/emaildor.html)

Ta en titt på arbetsflödets processsteg. Den anpassade kod som är associerad med processsteget skapar egenskapsnamn för metadata och anger värden från skickade data. Dessa värden används sedan av komponenten för att skicka e-post.

>[!NOTE]
>
>I AEM Forms 6.5 och senare behöver du inte den här anpassade koden för att skapa metadataegenskaper. Använd variabelfunktionerna i AEM Workflow

Kontrollera att fliken Bifogade filer i komponenten Skicka e-post är konfigurerad enligt skärmbilden nedan
![Fliken Skicka e-postbilaga](assets/sendemailcomponentconfigure.jpg)Värdet DOR.pdf måste matcha det värde som anges i dokumentsökvägen som anges i alternativen för att skicka formulär som kan anpassas.
