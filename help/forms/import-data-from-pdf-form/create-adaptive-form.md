---
title: Skapa schema
description: Skapa ett schema baserat på de data som behöver importeras till det adaptiva formuläret
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: 14196
source-git-commit: 17ab178f385619b589a9dde6089410bfa4515ffa
workflow-type: tm+mt
source-wordcount: '203'
ht-degree: 0%

---

# Introduktion

Det första steget är att skapa ett schema baserat på de data som ska användas för att fylla i det adaptiva formuläret.

## XFA baseras på ett schema

Använd schemat för att skapa ett anpassat formulär

## XFA är inte baserat på ett schema

* Öppna XDP i AEM Forms Designer.
* Klicka på Arkiv | Formuläregenskaper | Förhandsgranska.
* Klicka på Generera förhandsgranskningsdata.
* Klicka på Generera.
* Ange ett beskrivande filnamn som `form-data.xml`

Du kan använda vilket som helst av de kostnadsfria onlineverktygen för att [generera XSD](https://www.freeformatter.com/xsd-generator.html) från XML-data som genererats i föregående steg.

Skapa ett anpassat formulär baserat på schemat från föregående steg.

>[!NOTE]
>Vi rekommenderar alltid att du undersöker de data som genereras när du skickar in adaptiva formulär. Då får du en bra uppfattning om XML-formatet för de data som behöver sammanfogas med det anpassade formuläret.

Data från adaptiv form
![skickade data](./assets/af-submitted-data.png)

Data som exporterats från PDF
![exporterade data](./assets/exported-data.png)

Du måste extrahera de exporterade data **_topmostSubform_** en nod med lämpliga namnutrymmen bevarade så att data kan sammanfogas med det adaptiva formuläret.

## Nästa steg

[Skapa OSGi-tjänst](./create-osgi-service.md)





