---
title: Skapa det första formuläret för att utlösa processen
description: Skapa ett första formulär som utlöser e-postmeddelandet för att starta signeringsprocessen.
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: User
level: Intermediate
jira: KT-6892
thumbnail: 6892.jpg
exl-id: d7c55dc8-d886-4629-bb50-d927308d12e3
duration: 35
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '177'
ht-degree: 1%

---

# Skapa ursprungligt formulär

Det ursprungliga formuläret (ReFinance Form) används för att signera flera formulär genom att arbetsflödet **Signera flera Forms** AEM aktiveras. Du kan ange valfria värden men se till att följande fält läggs till i formuläret.

| Fälttyp | Namn | Syfte | Dold | Standardvärde |
| ------------------------|---------------------------------------|--------------------|--------|----------------- |
| TextField | signerad | Ange signeringsstatus | Y | N |
| TextField | guid | Unik identifiering av formulär | Y | 3889 |
| TextField | customerName | Så här hämtar du kundnamn | N |
| TextField | customerEmail | E-post till kund som skickar meddelande | N |
| CheckBox | formsToSign | Objekten identifierar formulären i paketet | N |

Det inledande formuläret måste konfigureras för att utlösa ett AEM som kallas **signmultipleforms**
Kontrollera att sökvägen till datafilen är inställd på **Data.xml** . Detta är mycket viktigt eftersom exempelkoden söker efter en fil som heter Data.xml i nyttolasten när formuläret skickas.

## Assets

Det ursprungliga formuläret (ReFinance Form) kan [laddas ned här](assets/refinance-form.zip)

## Nästa steg

[Skapa formulär som ska användas för signering](./create-forms-for-signing.md)
