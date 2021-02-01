---
title: Acrobat med AEM Forms
seo-title: Sammanfoga data i anpassat format med Acrobat
description: Del 2 i Integrering av Acrobat med AEM Forms. Skapa ett schema från en Acrobat.
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4
translation-type: tm+mt
source-git-commit: 451ca39511b52e90a44bba25c6739280f49a0aac
workflow-type: tm+mt
source-wordcount: '183'
ht-degree: 0%

---


# Skapa schema från acroform

Nästa steg är att skapa ett schema från den Acrobat som skapades i det tidigare steget. Ett exempelprogram tillhandahålls för att skapa schemat som en del av den här självstudiekursen. Följ dessa anvisningar för att skapa schemat:

1. Logga in på [CRXDE Lite](http://localhost:4502/crx/de)
2. Öppna i filen `/apps/AemFormsSamples/components/createxsd/POST.jsp`
3. Ändra `saveLocation` till en lämplig mapp på hårddisken. Kontrollera att mappen du sparar i redan har skapats.
4. Peka webbläsaren på sidan [Skapa XSD](http://localhost:4502/content/DocumentServices/CreateXsd.html) på AEM.
5. Dra och släpp Acrobat.
6. Kontrollera mappen som anges i steg 3. Schemafilen sparas på den här platsen.

## Ladda upp Acroform

För att den här demonstrationen ska fungera på ditt system måste du skapa en mapp med namnet `acroforms` i AEM Assets. Överför Acrobat till den här `acroforms`-mappen.

>[!NOTE]
>
>Exempelkoden söker efter acroform i den här mappen. Det behövs för att sammanfoga de data som har skickats från det adaptiva formuläret.
