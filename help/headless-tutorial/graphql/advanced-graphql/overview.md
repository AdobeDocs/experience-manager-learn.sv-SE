---
title: Advanced Concepts of AEM Headless - GraphQL
description: En komplett självstudiekurs som illustrerar avancerade koncept för API:er i Adobe Experience Manager (AEM) GraphQL.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
exl-id: daae6145-5267-4958-9abe-f6b7f469f803
duration: 441
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1052'
ht-degree: 0%

---

# Avancerade begrepp för AEM Headless

{{aem-headless-trials-promo}}

Den här kompletta självstudiekursen fortsätter med den [grundläggande självstudiekursen](../multi-step/overview.md) som täckte grunderna i Adobe Experience Manager (AEM) Headless och GraphQL. Den avancerade självstudiekursen visar ingående aspekter av att arbeta med modeller för innehållsfragment, innehållsfragment och de AEM GraphQL beständiga frågorna, inklusive användning av GraphQL beständiga frågor i ett klientprogram.

## Förutsättningar

Slutför [snabbinstallationen för AEM as a Cloud Service](../quick-setup/cloud-service.md) för att konfigurera din AEM as a Cloud Service-miljö.

Vi rekommenderar att du slutför de tidigare [grundläggande självstudiekurserna](../multi-step/overview.md) och [videoserierna](../video-series/modeling-basics.md) innan du fortsätter med den här avancerade självstudiekursen. Även om du kan slutföra självstudiekursen i en lokal AEM omfattar den här självstudiekursen bara arbetsflödet för AEM as a Cloud Service.

>[!CAUTION]
>
>Om du inte har tillgång till AEM as a Cloud Service-miljön kan du slutföra [AEM Headless-snabbinstallationen med den lokala SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/quick-setup/local-sdk.html). Det är dock viktigt att notera att vissa användargränssnittssidor, som navigering för innehållsfragment, är olika.



## Mål

Den här självstudiekursen handlar om följande ämnen:

* Skapa modeller för innehållsfragment med valideringsregler och mer avancerade datatyper som platshållare för flikar, kapslade fragmentreferenser, JSON-objekt och datatyperna Datum och tid.
* Skapa innehållsfragment när du arbetar med kapslat innehåll och fragmentreferenser och konfigurera mappprinciper för styrning av innehållsfragmentutveckling.
* Utforska AEM GraphQL API-funktioner med GraphQL queries med variabler och direktiv.
* Behåll GraphQL-frågor med parametrar i AEM och lär dig hur du använder cachekontrollparametrar med beständiga frågor.
* Integrera begäran om beständiga frågor i exempelappen WKND GraphQL React med AEM Headless JavaScript SDK.

## Avancerade koncept AEM Headless-översikt

I följande video visas en översikt på hög nivå över de koncept som beskrivs i den här självstudiekursen. Självstudiekursen innehåller definition av modeller för innehållsfragment med mer avancerade datatyper, kapsling av innehållsfragment och beständiga GraphQL-frågor i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/340035?quality=12&learn=on)

>[!CAUTION]
>
>I den här videon (kl. 2:25) omnämns hur du installerar frågeredigeraren GraphiQL via Package Manager för att utforska GraphQL-frågor. I senare versioner av AEM som Cloud Service finns dock en inbyggd **GraphiQL Explorer**, vilket innebär att paketinstallation inte krävs. Mer information finns i [Använda GraphiQL IDE](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/headless/graphql-api/graphiql-ide.html).


## Projektinställningar

WKND-webbplatsprojektet har alla nödvändiga konfigurationer, så du kan starta självstudiekursen direkt när du har slutfört [snabbinstallationen](../quick-setup/cloud-service.md). I det här avsnittet beskrivs bara några viktiga steg som du kan använda när du skapar ett eget AEM Headless-projekt.


### Granska befintlig konfiguration

Det första steget till att starta ett nytt projekt i AEM är att skapa dess konfiguration, som en arbetsyta och att skapa GraphQL API-slutpunkter. Om du vill granska eller skapa en konfiguration går du till **Verktyg** > **Allmänt** > **Konfigurationsläsaren**.

![Navigera till Configuration Browser](assets/overview/create-configuration.png)

Observera att webbplatskonfigurationen `WKND Shared` redan har skapats för självstudiekursen. Om du vill skapa en konfiguration för ditt eget projekt väljer du **Skapa** i det övre högra hörnet och fyller i formuläret i Create Configuration modal som visas.

![Granska WKND-delad konfiguration](assets/overview/review-wknd-shared-configuration.png)

### Granska GraphQL API-slutpunkter

Sedan måste du konfigurera API-slutpunkter att skicka GraphQL-frågor till. Om du vill granska befintliga slutpunkter eller skapa en går du till **Verktyg** > **Allmänt** > **GraphQL**.

![Konfigurera slutpunkter](assets/overview/endpoints.png)

Observera att `WKND Shared Endpoint` redan har skapats. Om du vill skapa en slutpunkt för projektet väljer du **Skapa** i det övre högra hörnet och följer arbetsflödet.

![Granska WKND-delad slutpunkt](assets/overview/review-wknd-shared-endpoint.png)

>[!NOTE]
>
> När du har sparat slutpunkten visas ett modalt besök på säkerhetskonsolen där du kan justera skyddsinställningarna om du vill konfigurera åtkomst till slutpunkten. Själva säkerhetsbehörigheterna ligger dock utanför den här självstudiekursen. Mer information finns i [AEM-dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security.html).

### Granska WKND-innehållets struktur och språkets rotmapp

En väldefinierad innehållsstruktur är avgörande för att AEM headless-implementering ska lyckas. Det är användbart för skalbarhet, användbarhet och behörighetshantering av ditt innehåll.

En språkrotmapp är en mapp med en ISO-språkkod som namn, till exempel EN eller FR. Det AEM översättningshanteringssystemet använder dessa mappar för att definiera det primära språket för ditt innehåll och dina språk för översättning av innehåll.

Gå till **Navigering** > **Assets** > **Filer**.

![Navigera till filer](assets/overview/files.png)

Gå till mappen **WKND Shared**. Lägg märke till mappen med titeln &quot;English&quot; och namnet &quot;EN&quot;. Den här mappen är språkrotmappen för WKND-platsprojektet.

![Engelsk mapp](assets/overview/english.png)

Skapa en språkrotmapp i konfigurationen för ditt eget projekt. Mer information finns i avsnittet [Skapa mappar](/help/headless-tutorial/graphql/advanced-graphql/author-content-fragments.md#create-folders).

### Tilldela en konfiguration till den kapslade mappen

Slutligen måste du tilldela projektets konfiguration till rotmappen för språket. Med det här uppdraget kan du skapa innehållsfragment baserat på de modeller för innehållsfragment som definieras i projektets konfiguration.

Om du vill tilldela språkets rotmapp till konfigurationen markerar du mappen och väljer **Egenskaper** i det övre navigeringsfältet.

![Välj egenskaper](assets/overview/properties.png)

Gå sedan till fliken **Cloud Service** och välj mappikonen i fältet **Cloud-konfiguration** .

![Molnkonfiguration](assets/overview/cloud-conf.png)

I den modal som visas väljer du den tidigare skapade konfigurationen för att tilldela språkrotmappen till den.

### God praxis

Nedan följer de bästa sätten att skapa egna projekt i AEM:

* Mapphierarkin bör utformas med lokalisering och översättning i åtanke. Språkmappar ska med andra ord kapslas i konfigurationsmappar, vilket gör det enkelt att översätta innehåll i dessa konfigurationsmappar.
* Mapphierarkin bör hållas platt och okomplicerad. Undvik att flytta eller byta namn på mappar och fragment senare, särskilt efter publicering för direktanvändning, eftersom sökvägar ändras som kan påverka fragmentreferenser och GraphQL-frågor.

## Starter- och lösningspaket

Två AEM **paket** är tillgängliga och kan installeras via [Package Manager](/help/headless-tutorial/graphql/advanced-graphql/author-content-fragments.md#sample-content)

* [Advanced-GraphQL-Tutorial-Starter-Package-1.1.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/Advanced-GraphQL-Tutorial-Starter-Package-1.1.zip) används senare i självstudien och innehåller exempelbilder och mappar.
* [Advanced-GraphQL-Tutorial-Solution-Package-1.2.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/Advanced-GraphQL-Tutorial-Solution-Package-1.2.zip) innehåller den färdiga lösningen för kapitel 1-4 inklusive nya modeller för innehållsfragment, innehållsfragment och beständiga GraphQL-frågor. Användbar för dem som vill hoppa direkt in i kapitlet [Integrering av klientprogram](/help/headless-tutorial/graphql/advanced-graphql/client-application-integration.md).


Projektet [React App - Advanced Tutorial - WKND Adventures](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/advanced-tutorial/README.md) är tillgängligt för att granska och utforska exempelprogrammet. Det här exempelprogrammet hämtar innehållet från AEM genom att anropa de beständiga GraphQL-frågorna och återger det i en engagerande upplevelse.

## Komma igång

Så här kommer du igång med den här avancerade självstudiekursen:

1. Konfigurera en utvecklingsmiljö med [AEM as a Cloud Service](../quick-setup/cloud-service.md).
1. Starta självstudiekursens kapitel i [Skapa modeller för innehållsfragment](/help/headless-tutorial/graphql/advanced-graphql/create-content-fragment-models.md).
