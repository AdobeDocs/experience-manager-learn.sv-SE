---
title: Skicka till din tacksida
seo-title: Skicka till din tacksida
description: Visa en tacksida när du skickar ett anpassat formulär
seo-description: Visa en tacksida när du skickar ett anpassat formulär
uuid: ec695b87-083a-47f6-92ac-c9a6dc2b85fb
feature: adaptiva formulär
topics: developing
audience: implementer
doc-type: article
activity: setup
version: 6.3,6.4,6.5
discoiquuid: 58c6bf42-efe5-41a3-8023-d84f3675f689
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '276'
ht-degree: 0%

---


# Skickar till din tacksida {#submitting-to-thank-you-page}

Alternativet Skicka till REST-slutpunkt skickar data som är ifyllda i formuläret till en konfigurerad bekräftelsesida som en del av HTTP GET-begäran. Du kan lägga till namnet på fälten som ska begäras. Begäran har följande format:

\{fieldName\} = \{parameterName\}. SubmitName är till exempel namnet på ett adaptivt formulärfält och avsändaren är namnet på parametern. På tacksidan kan du komma åt parametern Submit med hjälp av request.getParameter(&quot;Submitter&quot;) för att få tag i värdet i fältet för avsändarens namn.

sändareNamn=avsändare

På skärmbilden nedan skickar vi det adaptiva formuläret för att tacka dig på sidan /content/thankyou. Till denna tacksida skickar vi tre attribut som innehåller formulärfältets värden.

![tack](assets/thankyoupage.gif)

Du kan också skicka till den externa slutpunkten via POST. För att uppnå detta behöver du bara markera kryssrutan&quot;aktivera efterbeställning&quot; och ange URL:en för den externa slutpunkten. När du skickar in formuläret får du en tacksida och POSTENS slutpunkt anropas samtidigt.

![hämtning](assets/capture.gif)


Följ instruktionerna nedan för att testa den här funktionen på servern:

* Importera [resursfilen som är associerad med den här artikeln till AEM med hjälp av pakethanteraren](assets/submittingtorestendpoint.zip)
* Peka webbläsaren på [Formuläret för att ställa in tid](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled)
* Fyll i det obligatoriska fältet och skicka formuläret
* Du bör få en tacksida med dina uppgifter ifyllda på sidan

