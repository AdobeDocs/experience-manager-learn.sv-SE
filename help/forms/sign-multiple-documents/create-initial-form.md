---
title: Skapa det första formuläret för att utlösa processen
description: Skapa ett första formulär som utlöser e-postmeddelandet för att starta signeringsprocessen.
feature: adaptiva formulär
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6892
thumbnail: 6892.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 3%

---


# Skapa ursprungligt formulär

Det initiala formuläret (Omfinansieringsformulär) används för att signera flera formulär genom att utlösa AEM **Signera flera Forms**. Du kan ange valfria värden men se till att följande fält läggs till i formuläret.



| Fälttyp | Namn | Syfte | Dold | Standardvärde |
------------------------|---------------------------------------|--------------------|--------|-----------------
| TextField | signerad | Ange signeringsstatus | J | N |
| TextField | guid | Identifiera formulär unikt | J | 3889 |
| TextField | customerName | Hämta kundnamn | N |
| TextField | customerEmail | E-post till kund som skickar meddelande | N |
| CheckBox | formsToSign | Objekten identifierar formulären i paketet | N |



Det inledande formuläret måste konfigureras för att utlösa ett AEM som heter **signmultipleforms**
Kontrollera att sökvägen till datafilen är **Data.xml**. Detta är mycket viktigt eftersom exempelkoden söker efter en fil som heter Data.xml i nyttolasten när formuläret skickas.

## Assets

Det ursprungliga formuläret (ReFinance Form) kan laddas ned här[](assets/refinance-form.zip)





