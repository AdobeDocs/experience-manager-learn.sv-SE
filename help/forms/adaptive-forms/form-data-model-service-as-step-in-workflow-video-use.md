---
title: Använda datamodelltjänst för formulär som ett steg i arbetsflödet
description: Från och med AEM Forms 6.4 kan vi nu använda Form Data Model som en del av AEM Workflow. I följande videofilm visas stegen som behövs för att konfigurera steget för formulärdatamodell i AEM Workflow.
feature: Workflow
type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 0c77a853-fa71-46ac-8626-99bc69d6222d
last-substantial-update: 2020-06-09T00:00:00Z
duration: 205
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '261'
ht-degree: 0%

---

# Använda datamodelltjänst för formulär som ett steg i arbetsflödet {#using-form-data-model-service-as-step-in-workflow}

Från och med AEM Forms 6.4 kan vi nu använda Form Data Model som en del av AEM Workflow. I följande videofilm visas de steg som krävs för att konfigurera steget Formulärdatamodell i AEM Workflow


>[!VIDEO](https://video.tv.adobe.com/v/21719?quality=12&learn=on)

Följ instruktionerna nedan om du vill testa den här funktionen på servern
* [Hämta och distribuera setvalue-paketet](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar). Det här är det anpassade OSGI-paketet som anger metadataegenskaper.
>I AEM Forms 6.5 och senare är den här funktionen tillgänglig direkt, vilket [beskrivs här](form-data-model-service-as-step-in-aem65-workflow-video-use.md)

* Konfigurera tomcat med filen SampleRest.war enligt beskrivningen [här](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-print-channel-tutorial/introduction.html?lang=sv-SE). Krigsfilen som distribueras i Tomcat har koden som returnerar sökandens kreditpoäng. Kreditpoängen är ett slumpmässigt tal mellan 200 och 800

* [Importera resurserna till AEM med pakethanteraren](assets/invoke-fdm-as-service-step.zip). Paketet innehåller följande:

   * Arbetsflödesmodell som använder FDM-steg.
   * Formulärdatamodell som används i FDM-steget.
   * Anpassad form som utlöser arbetsflödet när det skickas.
* Öppna [MortgageApplicationForm](http://localhost:4502/content/dam/formsanddocuments/loanapplication/jcr:content?wcmmode=disabled). Fyll i uppgifterna och skicka in. När formuläret skickas aktiveras arbetsflödet [för låneprogram](http://http://localhost:4502/editor.html/conf/global/settings/workflow/models/LoanApplication2.html).

![&#x200B; arbetsflöde &#x200B;](assets/fdm-as-service-step-workflow.PNG).
Arbetsflödet använder eller delar komponenten för att dirigera programmet till administratören om kreditpoängen är över 500. Om kreditpoängen är mindre än 500 dirigeras programmet till kaveri
