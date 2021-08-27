---
title: 'Fyll i tabell med anpassat formulär '
description: Fyll i tabellen Adaptivt formulär med resultat från anrop till tjänsten Formulärdatamodell
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: User
level: Intermediate
source-git-commit: 0049c9fd864bd4dd4f8c33b1e40e94aad3ffc5b9
workflow-type: tm+mt
source-wordcount: '245'
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
[anvisningarna härDistribuera filen SampleRest.war som finns i den här zip-](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/assets/common-osgi-bundles/sample-rest.zip)
[filenInstallera resurserna  ](assets/amortizationschedule.zip) med AEM pakethanteraren 
[Öppna ](http://localhost:4502/content/dam/formsanddocuments/amortization/jcr:content?wcmmode=disabled)
formuläret för amorteringsschemaAnge lämpligt värde och klicka på Beräkna amorteringsschema för att fylla i formuläret

