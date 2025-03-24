---
title: Installing IntelliJ Community Edition
description: Installera och importera AEM-projektet till IntelliJ
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
jira: KT-8843
exl-id: 34840d28-ad47-4a69-b15d-cd9593626527
duration: 43
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '219'
ht-degree: 0%

---

# Installerar IntelliJ

Installera [IntelliJ Community Edition](https://www.jetbrains.com/idea/download/#section=windows). Du kan acceptera standardinställningarna medan de föreslås under installationen.

## Importera AEM Project

* Starta IntelliJ
* Importera det AEM-projekt du skapade i det tidigare steget. När projektet har importerats ska skärmen se ut som den här ![aem-Banking-appen](assets/aem-banking-app.png). Du arbetar vanligtvis med underprojekt core, ui.apps, ui.config och ui.content.
* Om du inte ser maven och terminalfönstret går du till view->Tools Window och väljer Maven and Terminal

## Lägg till teckensnittsmodulen

Om du vill använda anpassade teckensnitt i din PDF-fil måste du överföra de anpassade teckensnitten till AEM Forms CS-instansen. Följ följande steg

* Skapa en mapp med namnet **fonts** i C:\CloudManager\aem-banking-application
* Extrahera innehållet i [font.zip](assets/fonts.zip) till mappen med nyligen skapade teckensnitt
* I teckensnittsmodulen finns några anpassade teckensnitt.Du kan lägga till organisationens anpassade teckensnitt i mappen C:\CloudManager\aem-banking-application\fonts\src\main\resources i teckensnittsmodulen
* Öppna C:\CloudManager\aem-banking-application\pom.xml
* Lägg till följande rad ```<module>fonts</module>``` i modulavsnittet i pom.xml
* Spara din pom.xml
* Uppdatera aem-Banking-applikationsprojektet i IntelliJ

Projektstruktur med teckensnittsmodul
![fonts-module](assets/fonts-module.png)

Teckensnittsmodulen som ingår i projektstrukturen
![fonts-pom](assets/fonts-module-pom.png)

## Nästa steg

[Konfigurera Git](./setup-git.md)
