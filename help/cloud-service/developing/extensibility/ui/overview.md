---
title: AEM UI-utökningsmöjligheter
description: Lär dig mer om AEM UI-utbyggbarhet med App Builder för att skapa tillägg.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: 73f5d90d-e007-41a0-9bb3-b8f36a9b1547
duration: 66
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '240'
ht-degree: 0%

---

# AEM UI-utökningsmöjligheter

Adobe Experience Manager (AEM) har ett kraftfullt användargränssnitt för att skapa digitala upplevelser. Adobe introducerade App Builder för att anpassa och utöka användargränssnittet. Med det här verktyget kan utvecklare förbättra användarupplevelsen utan komplex kodning med JavaScript och React.

I App Builder finns ett implementeringslager för att skapa tillägg som är bundna till väl definierade tilläggspunkter i AEM. App Builder kan integreras smidigt med AEM vilket möjliggör förhandsgranskning och testning i realtid. Det går snabbt och smidigt att driftsätta AEM. Genom att använda App Builder sparar utvecklarna både tid och kraft och kan snabbt skapa prototyper och samarbeta med intressenter.

## Utveckla ett AEM

AEM olika gränssnitten har olika tilläggspunkter, men de grundläggande begreppen är desamma.

I videoklippen och genomgångarna nedan visas hur ett tillägg till Content Fragment Console används för att illustrera olika aktiviteter. Det är dock viktigt att komma ihåg att de koncept som omfattas kan tillämpas på alla AEM UI-tillägg.

1. [Skapa ett Adobe Developer Console-projekt](./adobe-developer-console-project.md)
1. [Initiera ett tillägg](./app-initialization.md)
1. [Registrera ett tillägg](./extension-registration.md)
1. Implementera en tilläggspunkt

   Tilläggspunkter och implementeringar av dem varierar beroende på vilket gränssnitt som utökas.

   + [Utveckla ett gränssnittstillägg för innehållsfragment](./content-fragments/overview.md)

1. [Utveckla en modal](./modal.md)
1. [Utveckla en Adobe I/O Runtime-åtgärd](./runtime-action.md)
1. [Verifiera ett tillägg](./verify.md)
1. [Distribuera ett tillägg](./deploy.md)

## Adobe Developer-dokumentation

Adobe Developer innehåller utvecklarinformation om AEM UI-utbyggbarhet. Granska [Adobe Developer content for more technical details](https://developer.adobe.com/uix/docs/).
