---
title: Extrahera nod från skickad data-xml
description: Anpassat processsteg för att lägga till skrivdokument i nyttolastmappen i filsystemet
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-9860
exl-id: 5282034f-275a-479d-aacb-fc5387da793d
last-substantial-update: 2020-07-07T00:00:00Z
duration: 39
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '179'
ht-degree: 0%

---

# Extrahera nod från skickad data-xml

Det här anpassade steget är att skapa ett nytt XML-dokument genom att extrahera nod från ett annat XML-dokument. Du måste använda detta när du vill sammanfoga skickade data med xdp-mallen för att generera PDF-filen. När du till exempel skickar ett anpassat formulär finns de data som du behöver sammanfoga med xdp-mallen inuti dataelementet. I det här fallet måste du skapa ett till XML-dokument genom att extrahera rätt dataelement.

I följande skärmbild visas de argument som du behöver skicka till det anpassade steget
![processteg](assets/create-xml-process-step.png)
Följande parametrar
* Data.xml - XML-filen som du vill extrahera noden från
* datatomerge.xml - Den nya xml-filen som skapas med den extraherade noden
* /afData/afUnboundData/data - Den nod som ska extraheras


På följande skärmbild visas datamerge.xml som skapas under nyttolastmappen
![create-xml](assets/create-xml.png)

[Det anpassade paketet kan laddas ned härifrån](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)
