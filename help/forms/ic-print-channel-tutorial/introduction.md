---
title: Skapa din första interaktiva kommunikation för tryckkanalen
seo-title: Creating your first interactive communication for the print channel
description: Interactive Communications är nytt för AEM Forms 6.4. I det här dokumentet får du stegvisa instruktioner för att skapa en interaktiv kommunikation för tryckkanalen.
seo-description: Interactive Communications is new to AEM Forms 6.4. This document will walk you through the steps needed to create an interactive communication for the print channel.
feature: Interactive Communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
exl-id: 1949aeff-ae56-4abd-8e63-23c2fb4859f2
source-git-commit: 9529b1f6d1a863fc570822c8ecd6c4be01b36729
workflow-type: tm+mt
source-wordcount: '167'
ht-degree: 0%

---

# Skapa din första interaktiva kommunikation för tryckkanalen

Interactive Communications är nytt för AEM Forms 6.4. I det här dokumentet får du stegvisa instruktioner för att skapa en interaktiv kommunikation för tryckkanalen.

## Förutsättningar {#prerequistes}

[Hämta och importera mediefilen som är relaterad till den här självstudiekursen till AEM med pakethanteraren.](assets/gettingstartedassets.zip)Den här zip-filen innehåller bilder, dokumentfragment, bevakad mappkonfiguration och layoutfil(xdp) som en del av resurspaketet

[Ladda ned och zippa upp den här filen.](assets/warfileandswaggerfile.zip) Den här filen innehåller filen SampleRest.war som måste distribueras till Tomcat och swagger som ska användas för att konfigurera datakällan.

När du är klar med den här självstudiekursen har du lärt dig följande:

* Skapa datakälla
* Skapa formulärdatamodell
* Skapa dokumentfragment
* Konfigurera tabeller och diagram
* Använd Bevakade mappar för att generera dokument i gruppläge
