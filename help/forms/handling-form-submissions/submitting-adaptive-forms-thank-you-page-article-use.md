---
title: Skicka till din tacksida
description: Visa en tacksida när du skickar ett anpassat formulär
feature: Adaptive Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
discoiquuid: 58c6bf42-efe5-41a3-8023-d84f3675f689
topic: Development
role: Developer
level: Beginner
exl-id: 85e1b450-39c0-4bb8-be5d-d7f50b102f3d
last-substantial-update: 2020-07-07T00:00:00Z
duration: 51
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '251'
ht-degree: 0%

---

# Skicka till din tacksida {#submitting-to-thank-you-page}

Alternativet Skicka till REST-slutpunkt skickar data som är ifyllda i formuläret till en konfigurerad bekräftelsesida som en del av HTTP GET-begäran. Du kan lägga till namnet på fälten som ska begäras. Begäran har följande format:

\{fieldName\} = \{parameterName\}. SubmitName är till exempel namnet på ett adaptivt formulärfält och avsändaren är namnet på parametern. På tacksidan kan du komma åt parametern Submit med hjälp av request.getParameter(&quot;Submitter&quot;) för att få tag i värdet i fältet för avsändarens namn.

`submitterName=submitter`

På skärmbilden nedan skickar vi det adaptiva formuläret för att tacka dig på sidan /content/thankyou. Till denna tacksida skickar vi tre begärandeattribut som innehåller formulärfältets värden.

![Tack!](assets/thankyoupage.gif)

Du kan också skicka till den externa slutpunkten via POST. För att uppnå detta behöver du bara markera kryssrutan&quot;aktivera efterbeställning&quot; och ange URL:en för den externa slutpunkten. När du skickar formuläret får du en tacksida och POST-slutpunkten anropas samtidigt.

![Hämtningskonfiguration](assets/capture.gif)

Följ instruktionerna nedan om du vill testa den här funktionen på servern:

* Importera den [resursfil som är associerad med den här artikeln till AEM med hjälp av pakethanteraren](assets/submittingtorestendpoint.zip)
* Peka webbläsaren på formuläret [Tid kvar](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled)
* Fyll i det obligatoriska fältet och skicka formuläret
* Du bör få en tacksida där informationen finns på sidan
