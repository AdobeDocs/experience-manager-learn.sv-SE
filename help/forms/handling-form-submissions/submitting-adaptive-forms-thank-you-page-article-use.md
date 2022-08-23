---
title: Skicka till din tacksida
seo-title: Submitting To Thank You Page
description: Visa en tacksida när du skickar ett anpassat formulär
seo-description: Display a thank you page on submitting Adaptive Form
uuid: ec695b87-083a-47f6-92ac-c9a6dc2b85fb
feature: Adaptive Forms
topics: developing
audience: implementer
doc-type: article
activity: setup
version: 6.4,6.5
discoiquuid: 58c6bf42-efe5-41a3-8023-d84f3675f689
topic: Development
role: Developer
level: Beginner
exl-id: 85e1b450-39c0-4bb8-be5d-d7f50b102f3d
source-git-commit: 307ed6cd25d5be1e54145406b206a78ec878d548
workflow-type: tm+mt
source-wordcount: '261'
ht-degree: 0%

---

# Skicka till din tacksida {#submitting-to-thank-you-page}

Alternativet Skicka till REST-slutpunkt skickar data som är ifyllda i formuläret till en konfigurerad bekräftelsesida som en del av HTTP GET-begäran. Du kan lägga till namnet på fälten som ska begäras. Begäran har följande format:

\{fieldName\} = \{parameterName\}. SubmitName är till exempel namnet på ett adaptivt formulärfält och avsändaren är namnet på parametern. På tacksidan kan du komma åt parametern Submit med hjälp av request.getParameter(&quot;Submitter&quot;) för att få tag i värdet i fältet för avsändarens namn.

sändareNamn=avsändare

På skärmbilden nedan skickar vi det adaptiva formuläret för att tacka dig på sidan /content/thankyou. Till denna tacksida skickar vi tre attribut som innehåller formulärfältets värden.

![tack](assets/thankyoupage.gif)

Du kan också skicka till den externa slutpunkten via POST. För att uppnå detta behöver du bara markera kryssrutan&quot;aktivera efterbeställning&quot; och ange URL:en för den externa slutpunkten. När du skickar in formuläret får du en tacksida och POSTENS slutpunkt anropas samtidigt.

![hämtning](assets/capture.gif)


Följ instruktionerna nedan för att testa den här funktionen på servern:

* Importera [resursfil som är associerad med den här artikeln till AEM med hjälp av pakethanteraren](assets/submittingtorestendpoint.zip)
* Peka webbläsaren mot [Frågeformulär - tid](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled)
* Fyll i det obligatoriska fältet och skicka formuläret
* Du bör få en tacksida med dina uppgifter ifyllda på sidan
