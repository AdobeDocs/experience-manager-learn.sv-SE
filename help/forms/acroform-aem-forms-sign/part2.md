---
title: Acrobat med AEM Forms
description: Del 2 i Integrering av Acrobat med AEM Forms. Skapa ett schema från en Acrobat.
feature: adaptive-forms
doc-type: Tutorial
version: 6.5
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
duration: 43
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '176'
ht-degree: 0%

---


# Skapa schema från acroform

Nästa steg är att skapa ett schema från den Acrobat som skapades i det tidigare steget. Ett exempelprogram tillhandahålls för att skapa schemat som en del av den här självstudien. Följ dessa anvisningar för att skapa schemat:

1. Logga in på [CRXDE Lite](http://localhost:4502/crx/de)
2. Öppna i filen `/apps/AemFormsSamples/components/createxsd/POST.jsp`
3. Ändra `saveLocation` till en lämplig mapp på hårddisken. Kontrollera att mappen som du sparar i redan har skapats.
4. Peka webbläsaren till [Skapa XSD](http://localhost:4502/content/DocumentServices/CreateXsd.html) sida som finns på AEM.
5. Dra och släpp Acrobat.
6. Kontrollera mappen som anges i steg 3. Schemafilen sparas på den här platsen.

## Ladda upp Acroform

För att den här demon ska fungera på ditt system måste du skapa en mapp med namnet `acroforms` i AEM Assets. Överför Acrobat till denna `acroforms` mapp.

>[!NOTE]
>
>Exempelkoden söker efter acroform i den här mappen. Det behövs för att sammanfoga de data som har skickats från det adaptiva formuläret.
