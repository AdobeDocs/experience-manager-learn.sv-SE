---
title: Skapa det första formuläret för att utlösa processen
description: Skapa ett första formulär som utlöser e-postmeddelandet för att starta signeringsprocessen.
feature: Adaptiv Forms
version: 6.4,6.5
topic: Utveckling
role: User
level: Intermediate
kt: 6892
thumbnail: 6892.jpg
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '171'
ht-degree: 4%

---


# Skapa ursprungligt formulär

Det initiala formuläret (Omfinansieringsformulär) används för att signera flera formulär genom att utlösa AEM **Signera flera Forms**. Du kan ange valfria värden men se till att följande fält läggs till i formuläret.

| Fälttyp | Namn | Syfte | Dold | Standardvärde |
| ------------------------|---------------------------------------|--------------------|--------|----------------- |
| TextField | signerad | Ange signeringsstatus | J | N |
| TextField | guid | Identifiera formulär unikt | J | 3889 |
| TextField | customerName | Hämta kundnamn | N |
| TextField | customerEmail | E-post till kund som skickar meddelande | N |
| CheckBox | formsToSign | Objekten identifierar formulären i paketet | N |

Det inledande formuläret måste konfigureras för att utlösa ett AEM som heter **signmultipleforms**
Kontrollera att sökvägen till datafilen är **Data.xml**. Detta är mycket viktigt eftersom exempelkoden söker efter en fil som heter Data.xml i nyttolasten när formuläret skickas.

## Assets

Det ursprungliga formuläret (ReFinance Form) kan laddas ned här[](assets/refinance-form.zip)





