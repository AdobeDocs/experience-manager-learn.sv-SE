---
title: Skapa Forms för signering
description: Skapa formulär som måste inkluderas i signeringspaketet.
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6893
thumbnail: 6893.jpg
topic: Utveckling
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '329'
ht-degree: 0%

---


# Skapa formulär för signering

Nästa steg är att skapa de adaptiva formulär som du vill ska ingå i paketet. Tänk på följande när du skapar formulär för signering:

* Kontrollera att formulären är baserade på mallen **SignMultipleForms**. Detta garanterar att formulären är förifyllda med data som hämtats från databasen.

* Formulären måste konfigureras för att använda Adobe Sign och signerarfältet1 måste associeras med kundens e-postfält
* Formulären måste också kopplas till clientLib med namnet **getnextform**
* Formulären måste använda komponenten Signature Step.
* Formuläret måste också använda den anpassade **Signera flera formulär**-komponenten. Med den här komponenten kan du navigera till nästa formulär för att signera i paketet.
* Överföringen av formuläret måste konfigureras för att AEM arbetsflödet **Uppdatera signaturstatus**
* Kontrollera att sökvägen till datafilen är **Data.xml**. Detta är mycket viktigt eftersom exempelkoden söker efter en fil som heter Data.xml i nyttolasten när formuläret skickas.

När du har skapat formuläret inkluderar du det adaptiva formulärfragmentet **CommonField** i formuläret. Fragmentet markeras som dolt. Detta fragment innehåller följande fält.

* **signerad**  - Det fält som innehåller signaturens status
* **GUID**  - Unik identifierare för att identifiera formuläret i paketet
* **customerEmail**  - Det här fältet innehåller kundens e-postadress



>[!NOTE]
>Om du vill överföra data från ett formulär till ett annat i paketet, måste du se till att formulärfälten har samma namn i alla formulär.

## Alla färdiga formulär

När alla formulär i paketet är ifyllda och signerade måste vi visa rätt meddelande. Det här meddelandet visas med hjälp av Alldone-formuläret. Formuläret Alldone ingår i exempelformulären.

## Assets

Exempelformulären, inklusive de som används i den här självstudiekursen, kan [hämtas här](assets/forms-for-signing.zip)
