---
title: Testa lösningen
description: Kör Main.java för att testa lösningen
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '208'
ht-degree: 0%

---


# Importera Eclipse-projekt

Ladda ned och zippa upp zip-filen [zip-fil](./assets/aem-forms-doc-gen.zip)

Starta Eclipse och importera projektet till Eclipse
Projektet innehåller följande filer i resursmappen:

* DataFile1 och DataFile2 - Exempel på xml-datafiler som ska sammanfogas med mallen för att generera den slutliga PDF-filen
* address.xdp - XDP-mall
* service_token.json - Du måste ersätta innehållet i den här filen med dina kontospecifika autentiseringsuppgifter
* options.json - De alternativ som anges i den här filen används för att ange egenskaper för PDF-filen som genereras av API:t

![resources-file](./assets/resource-files.JPG)

## Testa lösningen

* Kopiera och klistra in dina inloggningsuppgifter i tjänstens_token.json-resursfil i projektet.
* Öppna filen DocumentGeneration.java och ange i vilken mapp du vill spara de genererade PDF-filerna
* Öppna Main.java. Ange värdet för variabeln postURL så att det pekar på instansen.
* Kör Main.java som java-programmet

>[!NOTE]
> Första gången du kör java-programmet får du ett HTTP 403-fel. För att komma förbi detta måste du ge [rätt behörighet till den tekniska kontoanvändaren i AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials.html?lang=en#configure-access-in-aem).

**AEM Forms** Usersis är den roll jag har använt i den här kursen.

