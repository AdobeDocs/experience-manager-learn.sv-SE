---
title: Skapa det adaptiva huvudformuläret
description: Skapa adaptiva formulär för att hämta information om sökande och adaptiva formulär för att hämta det sparade adaptiva formuläret
feature: Adaptiv Forms
type: Tutorial
activity: implement
version: 6.4,6.5
kt: 6552
thumbnail: 6552.jpg
topic: Utveckling
role: User
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '206'
ht-degree: 0%

---


# Skapa det adaptiva huvudformuläret

Formuläret **StoreAFWithAttachments** är den huvudsakliga adaptiva formen. Detta adaptiva formulär är utgångspunkten för användningsfallet. I det här formuläret hämtas användarinformation, inklusive mobilnummer. Det här formuläret kan även lägga till några bilagor. När användaren klickar på knappen Spara och avsluta körs serversideskoden för att lagra formulärdata i databasen, och ett unikt program-ID genereras och presenteras för användaren för säker lagring. Detta program-ID används för att hämta det mobilnummer som är kopplat till programmet.

![huvudansökningsformulär](assets/6552.JPG)

Det här formuläret är associerat med **bootboxjs540,storeAFWithAttachments** klientbibliotek som skapats tidigare under kursen och ett AEM arbetsflöde som aktiveras när formulär skickas.


* Exempelformulären är baserade på [en anpassad adaptiv formulärmall](assets/custom-template-with-page-component.zip) som måste importeras till AEM för att exempelformulären ska återges korrekt.

* Det färdiga [StoreAfWithAttachments-formuläret](assets/store-af-with-attachments-form.zip) kan hämtas och importeras till din AEM.

* Det [AEM arbetsflöde som är associerat med det här formuläret](assets/workflow-model-store-af-with-attachments.zip) måste importeras till din AEM för att formuläret ska fungera.



