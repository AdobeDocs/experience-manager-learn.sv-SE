---
title: Skapa det adaptiva huvudformuläret
description: Skapa adaptiva formulär för att hämta information om sökande och adaptiva formulär för att hämta det sparade adaptiva formuläret
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6552
thumbnail: 6552.jpg
topic: Development
role: User
level: Beginner
exl-id: 73de0ac4-ada6-4b8e-90a8-33b976032135
duration: 41
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '208'
ht-degree: 0%

---

# Skapa det adaptiva huvudformuläret

Formuläret **StoreAFWithAttachments** är den huvudsakliga adaptiva formen. Detta adaptiva formulär är utgångspunkten för användningsfallet. I det här formuläret hämtas användarinformation, inklusive mobilnummer. Det här formuläret kan även lägga till några bilagor. När användaren klickar på knappen Spara och avsluta körs serversideskoden för att lagra formulärdata i databasen och ett unikt program-ID genereras och visas för användaren för att skydda dem. Detta program-ID används för att hämta det mobilnummer som är kopplat till programmet.

![huvudprogramformulär](assets/6552.JPG)

Det här formuläret är associerat med **bootboxjs540,storeAFWithAttachments** klientbibliotek som skapats tidigare under kursen och ett AEM-arbetsflöde som aktiveras när formulär skickas.


* Exempelformulären är baserade på [en anpassad adaptiv formulärmall](assets/custom-template-with-page-component.zip) som måste importeras till AEM för att exempelformulären ska återges korrekt.

* Det färdiga [StoreAfWithAttachments-formuläret](assets/store-af-with-attachments-form.zip) kan hämtas och importeras till din AEM-instans.

* [AEM-arbetsflödet som är associerat med det här formuläret](assets/workflow-model-store-af-with-attachments.zip) måste importeras till din AEM-instans för att formuläret ska fungera.


## Nästa steg

[Skapa formuläret som hämtar det sparade formuläret](./retrieve-saved-form.md)