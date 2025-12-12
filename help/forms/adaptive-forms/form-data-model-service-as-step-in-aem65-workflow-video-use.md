---
title: Använda datamodelltjänst för formulär som ett steg i AEM 6.5-arbetsflödet
description: I AEM Forms 6.5 introducerades möjligheten att skapa variabler i AEM Workflow. Den här nya funktionen med tjänsten"Anropa datamodell" i AEM Workflow har blivit mycket enkel. I följande video får du hjälp med att använda Anropa datamodelltjänst för formulär i AEM Workflow.
feature: Workflow
type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 1f13d82e-c1d0-4c8c-8468-b4a4c5897c71
last-substantial-update: 2021-02-09T00:00:00Z
duration: 239
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '257'
ht-degree: 0%

---

# Använda datamodelltjänst för formulär som ett steg i AEM 6.5-arbetsflödet {#using-form-data-model-service-as-step-in-workflow}

Från och med AEM Forms 6.4 kan vi nu använda Form Data Model Service som en del av AEM Workflow. I följande videofilm visas de steg som krävs för att konfigurera steget Formulärdatamodell i AEM Workflow

>[!NOTE]
>
>Funktionen som demonstreras i den här videon kräver AEM Forms 6.5.1


>[!VIDEO](https://video.tv.adobe.com/v/28145?quality=12&learn=on)

Följ instruktionerna nedan om du vill testa den här funktionen på servern

* Konfigurera för katt med filen SampleRest.war enligt beskrivningen [här](https://helpx.adobe.com/experience-manager/kt/forms/using/preparing-datasource-for-form-data-model-tutorial-use.html).Krigsfilen som distribueras i Tomcat har koden som returnerar den sökandes kreditpoäng. Kreditpoängen är ett slumpmässigt tal mellan 200 och 800

* [Importera mediefiler till AEM med hjälp av pakethanteraren](assets/aem65-loanapplication.zip)
* Paketet innehåller följande:

   * Arbetsflödesmodell som använder FDM-steg.
   * Formulärdatamodell som används i FDM-steget.
   * Anpassad form som utlöser arbetsflödet när det skickas.
* Öppna [MortgageApplicationForm](http://localhost:4502/content/dam/formsanddocuments/loanapplication/jcr:content?wcmmode=disabled). Fyll i uppgifterna och skicka in. När formuläret skickas aktiveras arbetsflödet [för låneprogram](http://http://localhost:4502/editor.html/conf/global/settings/workflow/models/LoanApplication2.html).

![arbetsflöde](assets/invokefdm651.PNG).

Arbetsflödet använder eller delar komponenten för att dirigera programmet till administratören om kreditpoängen är över 500. Om kreditpoängen är mindre än 500 dirigeras programmet till klotter.
