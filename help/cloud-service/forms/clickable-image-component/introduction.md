---
title: Skapa en klickbar bildkomponent
description: Skapa klickbara bildkomponenter i AEM Forms as a Cloud Service.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-15968
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: c451472f-d282-4662-9852-8a3e73c5c853
source-git-commit: b4df652fcda0af5d01077b97aa7fa17cfe2abf4b
workflow-type: tm+mt
source-wordcount: '138'
ht-degree: 0%

---

# Introduktion till klickbara bilder

Med klickbara bilder i Forms kan du skapa en mer engagerande, intuitiv och visuellt tilltalande användarupplevelse. I den här artikeln använde vi SVG för klickbara bilder eftersom det har flera fördelar, särskilt när det gäller flexibilitet, prestanda och användarupplevelse.
SVG kan skapas med Adobe Illustrator eller något av de kostnadsfria onlineverktygen. Jag har använt [USA Map från](https://simplemaps.com/resources/svg-us)simplemaps för att demonstrera användningsfallet.

## Använd skiftläge för klickbar USA-karta

Med klickbara kartor över USA kan man utforska tillståndsspecifika formulärinskickade formulär. När en användare klickar på ett tillstånd visas inskickade data från det läget, med alternativet att öppna ett visst inskickat dokument.
