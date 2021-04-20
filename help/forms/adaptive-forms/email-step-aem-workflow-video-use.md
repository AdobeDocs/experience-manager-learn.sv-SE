---
title: Använda steget Skicka e-post för Forms Workflow
seo-title: Använda steget Skicka e-post för Forms Workflow
description: Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas stegen för hur du konfigurerar komponenten Skicka e-post
seo-description: Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas stegen för hur du konfigurerar komponenten Skicka e-post
uuid: d054ebfb-3b9b-4ca4-8355-0eb0ee7febcb
feature: Workflow
topics: integrations
audience: developer
doc-type: technical video
activity: setup
version: 6.4,6.5
discoiquuid: 3a11f602-2f4c-423a-baef-28824c0325a1
topic: Development
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '497'
ht-degree: 0%

---


# Använda steget Skicka e-post för Formens Workflow {#using-send-email-step-of-forms-workflow}

Steget Skicka e-post introducerades i AEM Forms 6.4. Med det här steget kan vi skapa affärsprocesser eller arbetsflöden som gör att du kan skicka e-postmeddelanden med eller utan bilagor. I följande videofilm visas stegen för hur du konfigurerar komponenten för att skicka e-post.

>[!VIDEO](https://video.tv.adobe.com/v/21499/?quality=9&learn=on)

Som en del av den här artikeln ska vi ta dig igenom följande exempel:

1. En användare fyller i formuläret Time Off Request
1. När formulär skickas aktiveras AEM arbetsflöde
1. AEM använder komponenten Skicka e-post för att skicka ett e-postmeddelande med DoR som en bifogad fil

Innan du använder steget Skicka e-post måste du konfigurera Day CQ Mail Service från [configMgr](http://localhost:4502/system/console/configMgr). Ange värden som är specifika för din miljö

![Konfigurera daglig CQ Mail-tjänst](assets/mailservice.png)

Som en del av resurserna som är kopplade till den här artikeln får du följande

1. Adaptiv form som utlöser arbetsflödet när det skickas
1. Exempelarbetsflöde som skickar ett e-postmeddelande med DOR som bilaga
1. OSGi-paketet som skapar metadataegenskaperna

Så här kör du exemplet på datorn:

1. [Distribuera Developing with service user bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

1. [Hämta och installera setValue-](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)paketet innehåller koden för att skapa metadataegenskaperna som en del av arbetsflödets processteg.
1. [Konfigurera daglig CQ Mail-tjänst](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/notification.html)
1. [Importera och installera resurser som är associerade med den här artikeln med hjälp av pakethanteraren i CRX](assets/emaildoraemformskt.zip)
1. Starta [adaptiv form](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled). Fyll i de obligatoriska fälten och skicka.
1. Du bör få ett e-postmeddelande med DocumentOfRecord som en bifogad fil

Utforska [arbetsflödesmodellen](http://localhost:4502/editor.html/conf/global/settings/workflow/models/emaildor.html)

Ta en titt på arbetsflödets processsteg. Den anpassade kod som är associerad med processsteget skapar egenskapsnamn för metadata och anger värden från skickade data. Dessa värden används sedan av komponenten för att skicka e-post.

>[!NOTE]
>
>I AEM Forms 6.5 och senare behöver du inte den här anpassade koden för att skapa metadataegenskaper. Använd variabelfunktionerna i AEM

Kontrollera att fliken Bifogade filer i komponenten Skicka e-post är konfigurerad enligt skärmbilden nedan
![Fliken Skicka e-postbilaga](assets/sendemailcomponentconfigure.jpg)Värdet &quot;DOR.pdf&quot; måste matcha det värde som anges i dokumentsökvägen som anges i alternativen för att skicka formulär som kan anpassas.

