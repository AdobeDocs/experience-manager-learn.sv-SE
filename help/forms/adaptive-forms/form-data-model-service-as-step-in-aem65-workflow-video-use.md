---
title: Använda datamodelltjänst som steg i AEM 6.5-arbetsflöde
seo-title: Använda datamodelltjänst som steg i AEM 6.5-arbetsflöde
description: I AEM Forms 6.5 introducerades möjligheten att skapa variabler i AEM. Med den här nya funktionen som använder tjänsten Anropa formulärdatamodell i AEM arbetsflöde har det blivit mycket enkelt. I följande video får du hjälp med att använda tjänsten Anropa formulärdatamodell i AEM arbetsflöde.
seo-description: I AEM Forms 6.5 introducerades möjligheten att skapa variabler i AEM. Med den här nya funktionen som använder tjänsten Anropa formulärdatamodell i AEM arbetsflöde har det blivit mycket enkelt. I följande video får du hjälp med att använda tjänsten Anropa formulärdatamodell i AEM arbetsflöde.
feature: arbetsflöde.
topics: workflow.
audience: developer.
doc-type: technical video.
activity: setup.
version: 6.5.
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '335'
ht-degree: 0%

---


# Använda datamodelltjänst som steg i AEM 6.5-arbetsflöde {#using-form-data-model-service-as-step-in-workflow}

Från och med AEM Forms 6.4 har vi nu möjlighet att använda Form Data Model Service som en del av AEM arbetsflöde. I följande videofilm visas de steg som krävs för att konfigurera steget Formulärdatamodell i AEM arbetsflöde

>!![NOTE]Funktionen som demonstreras i den här videon kräver AEM Forms 6.5.1


>[!VIDEO](https://video.tv.adobe.com/v/28145?quality=9&learn=on)

Följ instruktionerna nedan om du vill testa den här funktionen på servern

* Konfigurera tomcat med filen SampleRest.war enligt beskrivningen [här](https://helpx.adobe.com/experience-manager/kt/forms/using/preparing-datasource-for-form-data-model-tutorial-use.html). Krigsfilen som distribueras i Tomcat har koden som returnerar den sökandes kreditpoäng. Kreditpoängen är ett slumpmässigt tal mellan 200 och 800

* [ Importera resurser till AEM med pakethanteraren](assets/aem65-loanapplication.zip)
* Paketet innehåller följande:

   * Arbetsflödesmodell som använder FDM-steg.
   * Formulärdatamodell som används i FDM-steget.
   * Anpassad form som utlöser arbetsflödet när det skickas.
* Öppna [MortgageApplicationForm](http://localhost:4502/content/dam/formsanddocuments/loanapplication/jcr:content?wcmmode=disabled). Fyll i uppgifterna och skicka in. När formuläret skickas utlöses arbetsflödet [för låneprogram](http://http://localhost:4502/editor.html/conf/global/settings/workflow/models/LoanApplication2.html).

![ arbetsflöde  ](assets/invokefdm651.PNG).
Arbetsflödet använder eller delar komponenten för att dirigera programmet till administratören om kreditpoängen är över 500. Om kreditpoängen är mindre än 500 dirigeras programmet till klotter.
