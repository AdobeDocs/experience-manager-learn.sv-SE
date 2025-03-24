---
title: Utbyggbarhet för AEM UI
description: Lär dig mer om AEM UI-utbyggbarhet med App Builder för att skapa tillägg.
feature: Developer Tools
version: Experience Manager as a Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: 73f5d90d-e007-41a0-9bb3-b8f36a9b1547
duration: 50
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '275'
ht-degree: 0%

---

# Utbyggbarhet för AEM UI {#aem-ui-extensibility}

Adobe Experience Manager (AEM) har ett kraftfullt användargränssnitt för att skapa digitala upplevelser. Adobe har introducerat App Builder för att anpassa och utöka användargränssnittet. Med det här verktyget kan utvecklare förbättra användarupplevelsen utan komplex kodning med JavaScript och React.

App Builder tillhandahåller ett implementeringslager för att skapa tillägg som är bundna till bra definierade tilläggspunkter i AEM. App Builder kan integreras smidigt med AEM och möjliggör förhandsgranskning och testning i realtid. Det går snabbt och smidigt att införa ändringar i AEM. Genom att använda App Builder sparar utvecklarna både tid och kraft, vilket möjliggör snabb framtagning av prototyper och samarbete med intressenter.

>[!CONTEXTUALHELP]
>id="aemcloud_learn_extensibility_app_builder"
>title="Komma igång med Adobe Developer App Builder och AEM Headless"
>abstract="Läs om hur AEM App Builder gör det möjligt för utvecklare att snabbt anpassa och utöka AEM gränssnitt med JavaScript och React, med stöd för smidig integrering och snabb driftsättning."

## Utveckla ett AEM UI-tillägg

AEM olika gränssnitt har olika tilläggspunkter, men de grundläggande begreppen är desamma.

I videoklippen och genomgångarna nedan visas hur ett tillägg till Content Fragment Console används för att illustrera olika aktiviteter. Det är dock viktigt att komma ihåg att de koncept som behandlas kan tillämpas på alla AEM UI-tillägg.

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

Adobe Developer innehåller utvecklarinformation om AEM UI-utbyggbarhet. Mer teknisk information finns i [Adobe Developer-innehållet](https://developer.adobe.com/uix/docs/).
