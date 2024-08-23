---
title: Skapa klickbar bildkomponent
description: Skapa klickbar bildkomponent i AEM Forms Cloud Service
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-15968
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
source-git-commit: 426020f59c7103829b7b7b74acb0ddb7159b39fa
workflow-type: tm+mt
source-wordcount: '132'
ht-degree: 0%

---

# Introduktion

Med klickbara bilder i Forms kan du skapa en mer engagerande, intuitiv och visuellt tilltalande användarupplevelse. I den här artikeln använde vi SVG för klickbara bilder eftersom det har flera fördelar, särskilt när det gäller flexibilitet, prestanda och användarupplevelse.
SVG kan skapas med Adobe Illustrator eller något av de kostnadsfria onlineverktygen. Jag har använt [USA Map från](https://simplemaps.com/resources/svg-us)simplemaps för att demonstrera användningsfallet.

## Använd skiftläge för klickbar USA-karta

Med klickbara kartor över USA kan man utforska tillståndsspecifika formulärinskickade formulär. När en användare klickar på ett tillstånd visas inskickade data från det läget, med alternativet att öppna ett visst inskickat dokument.
