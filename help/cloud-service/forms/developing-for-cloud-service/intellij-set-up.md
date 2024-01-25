---
title: Installing IntelliJ Community Edition
description: Installera och importera AEM till IntelliJ
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
jira: KT-8843
exl-id: 34840d28-ad47-4a69-b15d-cd9593626527
duration: 48
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '219'
ht-degree: 0%

---

# Installerar IntelliJ

Installera [IntelliJ Community Edition](https://www.jetbrains.com/idea/download/#section=windows). Du kan acceptera standardinställningarna medan de föreslås under installationen.

## Importera AEM projekt

* Starta IntelliJ
* Importera det AEM projektet som du skapade i det tidigare steget. När projektet har importerats ska skärmen se ut ungefär så här ![aem-Banking-app](assets/aem-banking-app.png). Du arbetar vanligtvis med underprojekt core, ui.apps, ui.config och ui.content.
* Om du inte ser maven och terminalfönstret går du till view->Tools Window och väljer Maven and Terminal

## Lägg till teckensnittsmodulen

Om du vill använda anpassade teckensnitt i PDF måste du överföra de anpassade teckensnitten till AEM Forms CS-instansen. Följ följande steg

* Skapa en mapp med namnet **teckensnitt** i C:\CloudManager\aem-banking-application
* Extrahera innehållet i [font.zip](assets/fonts.zip) till mappen med nya teckensnitt
* I teckensnittsmodulen finns några anpassade teckensnitt.Du kan lägga till organisationens anpassade teckensnitt i mappen C:\CloudManager\aem-banking-application\fonts\src\main\resources i teckensnittsmodulen
* Öppna C:\CloudManager\aem-banking-application\pom.xml
* Lägg till följande rad  ```<module>fonts</module>``` i modulavsnittet i pom.xml
* Spara din pom.xml
* Uppdatera aem-Banking-applikationsprojektet i IntelliJ

Projektstruktur med teckensnittsmodul
![fonts-module](assets/fonts-module.png)

Teckensnittsmodulen som ingår i projektstrukturen
![fonts-pom](assets/fonts-module-pom.png)

## Nästa steg

[Konfigurera Git](./setup-git.md)
