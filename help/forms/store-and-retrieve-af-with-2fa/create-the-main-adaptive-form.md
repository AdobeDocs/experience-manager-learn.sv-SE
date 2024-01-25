---
title: Skapa det adaptiva huvudformuläret
description: Skapa adaptiva formulär för att hämta information om sökande och adaptiva formulär för att hämta det sparade adaptiva formuläret
feature: Adaptive Forms
type: Tutorial
version: 6.4,6.5
jira: KT-6552
thumbnail: 6552.jpg
topic: Development
role: User
level: Beginner
exl-id: 73de0ac4-ada6-4b8e-90a8-33b976032135
duration: 46
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '208'
ht-degree: 0%

---

# Skapa det adaptiva huvudformuläret

Formuläret **StoreAFWithAttachments** är den huvudsakliga adaptiva formen. Detta adaptiva formulär är utgångspunkten för användningsfallet. I det här formuläret hämtas användarinformation, inklusive mobilnummer. Det här formuläret kan även lägga till några bilagor. När användaren klickar på knappen Spara och avsluta körs serversideskoden för att lagra formulärdata i databasen och ett unikt program-ID genereras och visas för användaren för att skydda dem. Detta program-ID används för att hämta det mobilnummer som är kopplat till programmet.

![huvudansökningsformulär](assets/6552.JPG)

Det här formuläret är kopplat till **bootboxjs540,storeAFWithAttachments** klientbibliotek som skapats tidigare under kursen och ett AEM som aktiveras när formulär skickas.


* Exempelformulären är baserade på [anpassad mall för anpassningsbara formulär](assets/custom-template-with-page-component.zip) som måste importeras till AEM för att exempelformulären ska återges korrekt.

* Slutförd [StoreAfWithAttachments-formulär](assets/store-af-with-attachments-form.zip) kan hämtas och importeras till din AEM.

* The [AEM arbetsflöde som är associerat med det här formuläret](assets/workflow-model-store-af-with-attachments.zip) måste importeras till din AEM för att formuläret ska fungera.


## Nästa steg

[Skapa formuläret som hämtar det sparade formuläret](./retrieve-saved-form.md)