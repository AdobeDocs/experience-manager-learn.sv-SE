---
title: Fyll i tabell med anpassat formulär
description: Fyll i tabellen Adaptivt formulär med resultat från anrop till tjänsten Formulärdatamodell
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: User
level: Intermediate
exl-id: 6e4b901a-6534-4c34-b315-2f2620b74247
last-substantial-update: 2019-06-09T00:00:00Z
duration: 45
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '223'
ht-degree: 0%

---

# Fyll i adaptiv formulärtabell med resultatet av anrop till tjänsten Form Data Model

[Live-formuläret finns här](https://forms.enablementadobe.com/content/dam/formsanddocuments/amortization/jcr:content?wcmmode=disabled)
I den här artikeln tar vi en titt på att fylla i tabeller med anpassade formulär genom att hämta data från anrop av formulärdatamodelltjänst. Vi ska skapa en amorteringsplan i en tabell som visar varje vanlig betalning på en inteckning över tiden. Avskrivningsresultaten returneras av vår formulärdatamodell. Tjänsten för formulärdatamodellen anropas vid click-händelsen för knappen calculate, vilket visas på skärmbilden. Indata- och utdataparametrarna för serviceanropet mappas på rätt sätt enligt skärmbilden. Utdata mappas till kolumnerna i rad1
![clickevent](assets/amortization.PNG)

Rad1 är konfigurerad att växa beroende på vilka data som returneras av serviceanropet. Lägg märke till de inställningar för upprepning som anges här. Värdet -1 anger ett obegränsat antal rader i tabellen
![Rad1](assets/rowconfiguration.PNG)

## Distribuera detta på servern

[Installera Tomcat enligt följande](/help/forms/ic-print-channel-tutorial/set-up-tomcat.md)
[Distribuera filen SampleRest.war som finns i zip-filen i din Tomcat](assets/sample-rest.zip)
[Installera resurserna](assets/amortizationschedule.zip) med AEM pakethanterare
[Öppna formuläret för amorteringsschema](http://localhost:4502/content/dam/formsanddocuments/amortization/jcr:content?wcmmode=disabled)
Ange lämpligt värde och klicka på Beräkna
Amorteringsschema ska fyllas i i formuläret
