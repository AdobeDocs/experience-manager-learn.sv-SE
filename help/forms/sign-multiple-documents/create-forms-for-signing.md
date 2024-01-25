---
title: Skapa Forms för signering
description: Skapa formulär som måste inkluderas i signeringspaketet.
feature: Adaptive Forms
version: 6.4,6.5
jira: KT-6893
thumbnail: 6893.jpg
topic: Development
role: User
level: Beginner
exl-id: 565d81a4-2918-44ea-a3e9-ed79f246f08a
duration: 78
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '333'
ht-degree: 0%

---

# Skapa formulär för signering

Nästa steg är att skapa de adaptiva formulär som du vill ska ingå i paketet. Tänk på följande när du skapar formulär för signering:

* Kontrollera att formulären är baserade på **SignMultipleForms** mall. Detta garanterar att formulären är förifyllda med data som hämtats från databasen.

* Formulären måste konfigureras för att använda Acrobat Sign och signerarfältet1 måste associeras med kundens e-postfält
* Formulären måste också kopplas till clientLib som anropas **getnextform**
* Formulären måste använda komponenten Signature Step.
* Formuläret måste även använda den anpassade **Signera flera formulär** -komponenten. Med den här komponenten kan du navigera till nästa formulär för att signera i paketet.
* Överföringen av formuläret måste konfigureras för att starta AEM arbetsflöde **Uppdatera signaturstatus**
* Kontrollera att sökvägen till datafilen är inställd på **Data.xml**. Detta är mycket viktigt eftersom exempelkoden söker efter en fil som heter Data.xml i nyttolasten när formuläret skickas.

När du har skrivit formuläret ska du inkludera **vanliga** adaptivt formulärfragment i formuläret. Fragmentet är markerat som dolt. Detta fragment innehåller följande fält.

* **signerad** - Det fält som innehåller signaturens status
* **guid** - Unik identifierare som identifierar formuläret i paketet
* **customerEmail** - Det här fältet innehåller kundens e-postadress



>[!NOTE]
>Om du vill överföra data från ett formulär till ett annat i paketet, måste du se till att formulärfälten har samma namn i alla formulär.

## Alla färdiga formulär

När alla formulär i paketet är ifyllda och signerade måste vi visa rätt meddelande. Det här meddelandet visas med hjälp av Alldone-formuläret. Formuläret Alldone ingår i exempelformulären.

## Assets

Exempelformulären som innehåller de som används i den här självstudiekursen kan [hämtad härifrån](assets/forms-for-signing.zip)

## Nästa steg

[Testa lösningen på ditt lokala system](./testing-and-trouble-shooting.md)
