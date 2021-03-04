---
title: Skapa din första interaktiva kommunikation för tryckkanalen
seo-title: Skapa din första interaktiva kommunikation för tryckkanalen
description: Interactive Communications är nytt för AEM Forms 6.4. I det här dokumentet får du stegvisa instruktioner för att skapa en interaktiv kommunikation för tryckkanalen.
seo-description: Interactive Communications är nytt för AEM Forms 6.4. I det här dokumentet får du stegvisa instruktioner för att skapa en interaktiv kommunikation för tryckkanalen.
feature: Interaktiv kommunikation
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
topic: Utveckling
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '229'
ht-degree: 1%

---


# Skapa din första interaktiva kommunikation för tryckkanalen

Interactive Communications är nytt för AEM Forms 6.4. I det här dokumentet får du stegvisa instruktioner för att skapa en interaktiv kommunikation för tryckkanalen.

På sidan [AEM Forms samples](https://forms.enablementadobe.com/content/samples/samples.html?query=0) finns en länk till en live-demo av den här funktionen.

## Förutsättningar {#prerequistes}

[Hämta och importera mediefilen som är relaterad till den här självstudiekursen till AEM med pakethanteraren.](assets/gettingstartedassets.zip)Den här zip-filen innehåller bilder, dokumentfragment, bevakad mappkonfiguration och layoutfil(xdp) som en del av resurspaketet

[Ladda ned och zippa upp den här filen.](assets/warfileandswaggerfile.zip) Den här filen innehåller filen SampleRest.war som måste distribueras till Tomcat och swagger som ska användas för att konfigurera datakällan.

När du är klar med den här självstudiekursen har du lärt dig följande:

* Skapa datakälla
* Skapa formulärdatamodell
* Skapa dokumentfragment
* Konfigurera tabeller och diagram
* Använd Bevakade mappar för att generera dokument i gruppläge

