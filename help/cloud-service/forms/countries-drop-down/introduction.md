---
title: Skapa nedrullningsbar listkomponent för länder
description: Skapa en nedrullningsbar listrutekomponent för länder baserat på en aem-formulärkärnkomponent.
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16517
source-git-commit: f9a1fb40aabb6fdc1157e1f2576f9c0d9cf1b099
workflow-type: tm+mt
source-wordcount: '245'
ht-degree: 0%

---

# Skapa en nedrullningsbar komponent för länder baserat på en nedrullningsbar komponent

Att skapa en ny kärnkomponent i Adobe Experience Manager (AEM) är en spännande process som innefattar flera steg, som att definiera komponentstrukturen, anpassa dialogen och implementera en Sling-modell för dynamisk funktionalitet.

I slutet av den här självstudiekursen får du lära dig att:

* Skapa och använd en Sling-modell för att hämta data dynamiskt.
* Anpassa cq-dialogrutan genom att lägga till nya fält och dölja andra.
* Definiera en robust komponentstruktur som är anpassad för återanvändning.

Komponenten, med namnet&quot;Länder&quot;, kommer att göra det möjligt för användare att välja en kontinent och dynamiskt fylla i en listruta med länder som motsvarar den valda kontinenten. Detta kommer att bygga på den färdiga listrutekomponenten, som förbättrats för det här specifika användningsexemplet.

Låt oss dyka in och skapa den här dynamiska och kraftfulla komponenten!

## Förutsättningar

Att bygga en ny kärnkomponent i Adobe Experience Manager (AEM) kräver att man uppfyller flera krav för att utvecklingsprocessen ska bli smidig. Det här behöver du innan du börjar:

* AEM Development Environment: En funktionell molnklar installation som körs lokalt
* Tillgång till AEM utvecklingsverktyg som Visual Studio Code eller IntelliJ
* Installation och AEM av MAven med den senaste arkitekturen
* Baskunskaper AEM begrepp
* Grundläggande verktyg och inställningar som Git-databas, rätt version av JDK


## Nästa steg

[Skapa komponentstruktur](./component.md)
