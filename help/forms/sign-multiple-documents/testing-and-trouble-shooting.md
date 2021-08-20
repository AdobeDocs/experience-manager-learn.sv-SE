---
title: Felsöka signering av flera dokument
description: Testa och felsöka lösningen
feature: Adaptiv Forms
version: 6.4,6.5
kt: 6960
thumbnail: 6960.jpg
topic: Utveckling
role: Developer
level: Intermediate
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '392'
ht-degree: 1%

---


# Testa och felsök


## Förhandsgranska omfinansieringsformuläret

Användningsexemplet utlöses när kundtjänstagenten fyller i och skickar [omfinansieringsformulär](http://localhost:4502/content/dam/formsanddocuments/formsandsigndemo/refinanceform/jcr:content?wcmmode=disabled).

Arbetsflödet Signera flera Forms aktiveras när formuläret skickas och kunden får ett e-postmeddelande med en länk för att börja fylla i och signera formuläret.

## Fylla i formulär i paketet

Kunden får fylla i och signera det första formuläret i paketet. När formuläret har signerats kan kunden navigera till nästa formulär i paketet. När alla formulär har fyllts i och signerats visas formuläret &quot;**AllDone**&quot;.

## Felsök

### E-postmeddelanden genereras inte

E-postmeddelandet skickas av komponenten Skicka e-post i arbetsflödet Signera flera formulär. Om något av stegen i det här arbetsflödet misslyckas skickas e-postmeddelandet. Se till att det anpassade processteget i arbetsflödet skapar rader i MySQL-databasen. Om raderna skapas kontrollerar du konfigurationsinställningarna för Dag CQ Mail Service

### Länken i e-postmeddelandet fungerar inte

Länkarna i e-postmeddelandena genereras dynamiskt. Om AEM inte körs på localhost:4502 anger du rätt servernamn och port i argumenten i Store Forms To Sign-steget i Sign Multiple Forms-arbetsflödet

### Det går inte att signera formuläret

Detta kan inträffa om formuläret inte fylldes i korrekt genom att data hämtades från datakällan. Kontrollera serverns stdout-loggar. fetchformdata.jsp skriver ut några användbara meddelanden i stdout.

### Det går inte att navigera till nästa formulär i paketet

När ett formulär har signerats i paketet aktiveras arbetsflödet Uppdatera signaturstatus. Det första steget i arbetsflödet uppdaterar signaturstatusen för formuläret i databasen. Kontrollera om formulärets status har uppdaterats från 0 till 1.

### Visas inte formuläret AllDone

När det inte finns fler formulär att signera i paketet visas formuläret AllDone för användaren. Om du inte ser formuläret AllDone kontrollerar du URL:en som används på rad 33 i filen GetNextFormToSign.js som är en del av **getnextform**-klientens lib.











