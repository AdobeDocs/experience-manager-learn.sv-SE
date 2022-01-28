---
title: Avancerade koncept för AEM Headless - GraphQL
description: En komplett självstudiekurs som illustrerar avancerade koncept för Adobe Experience Manager (AEM) GraphQL API:er.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
source-git-commit: 83e16ea87847182139982ea2378d8ff9f079c968
workflow-type: tm+mt
source-wordcount: '926'
ht-degree: 0%

---

# Avancerade begrepp för AEM Headless

Den kompletta självstudiekursen fortsätter med [grundläggande självstudiekurs](../multi-step/overview.md) som täckte grunderna i Adobe Experience Manager (AEM) Headless och GraphQL. Den avancerade självstudiekursen visar ingående aspekter av att arbeta med Content Fragment Models, Content Fragments och AEM GraphQL API, inklusive användning AEM GraphQL i ett klientprogram.

## Förutsättningar

Slutför [snabbinstallation för AEM as a Cloud Service](../quick-setup/cloud-service.md) för att konfigurera miljön.

Vi rekommenderar att du slutför föregående [grundläggande självstudiekurs](../multi-step/overview.md) och [videoserie](../video-series/modeling-basics.md) självstudiekurser innan du fortsätter med den här avancerade självstudiekursen. Även om du kan slutföra självstudiekursen i en lokal AEM omfattar den här självstudiekursen bara arbetsflödet för AEM as a Cloud Service.

## Mål

Den här självstudiekursen handlar om följande ämnen:

* Skapa modeller för innehållsfragment med valideringsregler och mer avancerade datatyper som platshållare för flikar, kapslade fragmentreferenser, JSON-objekt och datatyperna Datum och tid.
* Skapa innehållsfragment när du arbetar med kapslat innehåll och fragmentreferenser och konfigurera mappprinciper för redigering av innehållsfragment.
* Utforska AEM GraphQL API-funktioner med GraphQL-frågor med variabler och direktiv.
* Behåll GraphQL-frågor med parametrar i AEM och lär dig hur du använder cachekontrollparametrar med beständiga frågor.
* Integrera begäran om beständiga frågor i exempelappen WKND GraphQL React med AEM Headless JavaScript SDK.

## Avancerade koncept AEM Headless-översikt

I följande video visas en översikt på hög nivå över de koncept som beskrivs i den här självstudiekursen. Självstudiekursen innehåller definition av modeller för innehållsfragment med mer avancerade datatyper, kapsling av innehållsfragment och beständiga GraphQL-frågor i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/340035/?quality=12&learn=on)

## Projektinställningar

WKND Site-projektet har alla konfigurationer som behövs, så du kan starta självstudiekursen direkt när du har slutfört [snabbinställningar](../quick-setup/cloud-service.md). I det här avsnittet beskrivs bara några viktiga steg som du kan använda när du skapar ett eget AEM Headless-projekt.

### Skapa en konfiguration

Det första steget för att starta ett nytt projekt i AEM är att skapa dess konfiguration, som en arbetsyta och för att skapa GraphQL API-slutpunkter. Om du vill visa eller skapa en konfiguration går du till **verktyg** > **Allmänt** > **Konfigurationsläsaren**.

![Navigera till Configuration Browser](assets/overview/create-configuration.png)

Observera att WKND-platskonfigurationen redan har skapats för självstudiekursen. Om du vill skapa en konfiguration för ditt eget projekt väljer du **Skapa** i det övre högra hörnet och fyll i formuläret i det modala Create Configuration som visas.

### Skapa GraphQL API-slutpunkter

Sedan måste du konfigurera API-slutpunkter att skicka GraphQL-frågor till. Om du vill granska befintliga slutpunkter eller skapa en går du till **verktyg** > **Resurser** > **GraphQL**.

![Konfigurera slutpunkter](assets/overview/endpoints.png)

Observera att de globala slutpunkterna och WKND-slutpunkterna redan har skapats. Om du vill skapa en slutpunkt för projektet väljer du **Skapa** i det övre högra hörnet och följ arbetsflödet.

>[!NOTE]
>
> När du har sparat slutpunkten visas ett modalt besök på säkerhetskonsolen där du kan justera skyddsinställningarna om du vill konfigurera åtkomst till slutpunkten. Själva säkerhetsbehörigheterna ligger dock utanför den här självstudiekursen. Mer information finns i [AEM](https://experienceleague.adobe.com/docs/experience-manager-64/administering/security/security.html).

### Skapa en språkrotmapp för ditt projekt

En språkrotmapp är en mapp med en ISO-språkkod som namn, till exempel EN eller FR. Det AEM översättningshanteringssystemet använder dessa mappar för att definiera det primära språket för ditt innehåll och dina språk för översättning av innehåll.

Gå till **Navigering** > **Resurser** > **Filer**.

![Navigera till filer](assets/overview/files.png)

Navigera till **WKND-plats** mapp. Lägg märke till mappen med titeln &quot;English&quot; och namnet &quot;EN&quot;. Den här mappen är språkrotmappen för WKND-platsprojektet.

![Engelsk mapp](assets/overview/english.png)

Skapa en språkrotmapp i konfigurationen för ditt eget projekt. Se avsnittet om [skapa mappar](/help/headless-tutorial/graphql/advanced-graphql/author-content-fragments.md#create-folders) för mer information.

### Tilldela en konfiguration till den kapslade mappen

Slutligen måste du tilldela projektets konfiguration till rotmappen för språket. Med det här uppdraget kan du skapa innehållsfragment baserat på de modeller för innehållsfragment som definieras i projektets konfiguration.

Om du vill tilldela språkets rotmapp till konfigurationen markerar du mappen och väljer **Egenskaper** i det övre navigeringsfältet.

![Välj egenskaper](assets/overview/properties.png)

Navigera sedan till **Cloud Services** och väljer mappikonen i **Molnkonfiguration** fält.

![Molnkonfiguration](assets/overview/cloud-conf.png)

I den modal som visas väljer du den tidigare skapade konfigurationen för att tilldela språkrotmappen till den.

### God praxis

Nedan följer de bästa sätten att skapa egna projekt i AEM:

* Mapphierarkin bör utformas med lokalisering och översättning i åtanke. Språkmappar ska med andra ord kapslas i konfigurationsmappar, vilket gör det enkelt att översätta innehåll i dessa konfigurationsmappar.
* Mapphierarkin bör hållas platt och okomplicerad. Undvik att flytta eller byta namn på mappar och fragment senare, särskilt efter publicering för direktanvändning, eftersom sökvägar ändras som kan påverka fragmentreferenser och GraphQL-frågor.

## Starter- och lösningspaket

Två AEM **paket** är tillgängliga och kan installeras via [Pakethanteraren](/help/headless-tutorial/graphql/advanced-graphql/author-content-fragments.md#sample-content)

* [Advanced-GraphQL-Tutorial-Starter-Package-1.0.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/Advanced-GraphQL-Tutorial-Starter-Package-1.0.zip) används senare i självstudiekursen och innehåller exempelbilder och mappar.
* [Advanced-GraphQL-Tutorial-Solution-Package-1.1.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/Advanced-GraphQL-Tutorial-Solution-Package-1.1.zip) innehåller den färdiga lösningen för kapitel 1-4 inklusive nya modeller för innehållsfragment, innehållsfragment och beständiga GraphQL-frågor. Användbar för dem som vill hoppa direkt in i [Integrering av klientprogram](/help/headless-tutorial/graphql/advanced-graphql/client-application-integration.md) kapitel.

Det finns två React JS-projekt som du kan använda för att experimentera med frågor [från ett headless-klientprogram](/help/headless-tutorial/graphql/advanced-graphql/client-application-integration.md).

* [aem-guides-wknd-headless-start-tutorial.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/aem-guides-wknd-headless-start-tutorial.zip) - startklientprogram som slutförs i [Kapitel 5 - Integrering av klientprogram](/help/headless-tutorial/graphql/advanced-graphql/client-application-integration.md).
* [aem-guides-wknd-headless-solution-tutorial.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/aem-guides-wknd-headless-solution-tutorial.zip) - slutfört klientprogram som använder **beständig** frågor.


## Komma igång

Så här kommer du igång med den här avancerade självstudiekursen:

1. Konfigurera en utvecklingsmiljö med [AEM as a Cloud Service](../quick-setup/cloud-service.md).
1. Starta självstudiekursens kapitel på [skapa modeller för innehållsfragment](/help/headless-tutorial/graphql/advanced-graphql/create-content-fragment-models.md).
