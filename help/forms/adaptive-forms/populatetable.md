---
title: 'Fyll i tabell med anpassat formulär '
seo-title: Fyll i tabell med anpassat formulär
description: Fyll i tabellen Adaptivt formulär med resultat från anrop till tjänsten Formulärdatamodell
seo-description: Fyll i tabellen Adaptivt formulär med resultat från anrop till tjänsten Formulärdatamodell
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
translation-type: tm+mt
source-git-commit: 449202af47b6bbcd9f860d5c5391d1f7096d489e
workflow-type: tm+mt
source-wordcount: '254'
ht-degree: 0%

---


# Fyll i adaptiv formulärtabell med resultatet av anrop till tjänsten för formulärdatamodell

[Live-formuläret ligger ](https://forms.enablementadobe.com/content/dam/formsanddocuments/amortization/jcr:content?wcmmode=disabled)
härI den här artikeln tar vi en titt på att fylla i tabeller med anpassade formulär genom att hämta data från anrop av formulärdatamodelltjänst. Vi ska skapa en amorteringsplan i en tabell som visar varje vanlig betalning på en inteckning över tiden. Avskrivningsresultaten returneras av vår formulärdatamodell. Tjänsten för formulärdatamodellen anropas vid click-händelsen för knappen calculate, vilket visas på skärmbilden. Indata- och utdataparametrarna för serviceanropet mappas på rätt sätt enligt skärmbilden. Utdata mappas till kolumnerna i rad1
![klickhändelse](assets/amortization.PNG)

Rad1 är konfigurerad att växa beroende på vilka data som returneras av serviceanropet. Lägg märke till de inställningar för upprepning som anges här. Värdet -1 anger ett obegränsat antal rader i tabellen
![Rad1](assets/rowconfiguration.PNG)

## Distribuera detta på servern

[Installera Tomcat enligt ](/help/forms/ic-print-channel-tutorial/set-up-tomcat.md)
[anvisningarna härDistribuera ](https://forms.enablementadobe.com/content/DemoServerBundles/SampleRest.war)
[filen SampleRest.warInstallera materialet  ](assets/amortizationschedule.zip) med AEM pakethanterare 
[Öppna ](http://localhost:4502/content/dam/formsanddocuments/amortization/jcr:content?wcmmode=disabled)
formuläret för amorteringsschemaAnge lämpligt värde och klicka på Beräkna amorteringsschema för att fylla i formuläret

