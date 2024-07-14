---
title: Leverera innehållsfragment i AEM
description: Content Fragments, independent of layout, can be used directly in AEM Sites with Core Components or can be delivery in a headless channel channel.
feature: Content Fragments
version: 6.4, 6.5
topic: Content Management
role: User
level: Beginner
doc-type: Feature Video
exl-id: 525cd30c-05bf-4f17-b61b-90609ce757ea
duration: 878
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '520'
ht-degree: 0%

---

# Leverera innehållsfragment {#delivering-content-fragments}

Adobe Experience Manager (AEM) Content Fragments är textbaserat redaktionellt innehåll som kan innehålla vissa strukturerade dataelement som är kopplade till, men som betraktas som rent innehåll utan design- eller layoutinformation. Innehållsfragment skapas vanligtvis som kanalbaserat innehåll, som är avsett att användas och återanvändas i alla kanaler, vilket i sin tur omsluter innehållet i en kontextspecifik upplevelse.

Content Fragments, independent of layout, can be used directly in AEM Sites with Core Components or can be delivery in a headless channel channel.

Den här videoserien innehåller leveransalternativ för Content Fragments. Information om definition och [redigering av innehållsfragment finns här](content-fragments-feature-video-use.md).

1. Använda innehållsfragment på webbsidor
2. Visa innehållsfragment som JSON med AEM Content Services
3. Använda Assets HTTP API

## Använda innehållsfragment på webbsidor {#using-content-fragments-in-web-pages}

>[!VIDEO](https://video.tv.adobe.com/v/22449?quality=12&learn=on)

Innehållsfragment kan användas på AEM Sites-sidor, eller på ett liknande sätt, med Experience Fragments, med AEM [Content Fragment-komponenten](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html) för WCM Core-komponenterna.

Innehållsfragmentskomponenter kan formateras med AEM Style System för att visa innehållet efter behov.

## Visa innehållsfragment som JSON {#exposing-content-fragments-as-json}

>[!VIDEO](https://video.tv.adobe.com/v/22448?quality=12&learn=on)

AEM Content Services underlättar skapandet av AEM sidbaserade HTTP-slutpunkter som återger innehåll till ett normaliserat JSON-format.

I videon ovan används komponenten [Content Fragment](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html) för att visa enskilda innehållsfragment. [Listkomponenten för innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-list.html) är en ny komponent som gör att en författare kan definiera en fråga som dynamiskt fyller sidan med en lista med innehållsfragment. Komponenten Lista med innehållsfragment är att föredra när flera innehållsfragment behöver visas.

*Exempel på JSON-nyttolast för Content Services-slutpunkt:*\
**[athletes.json](assets/athletes.json)**

## Använda Assets HTTP API

>[!VIDEO](https://video.tv.adobe.com/v/26390?quality=12&learn=on)

Den första introduktionen i AEM 6.5 har utökat stöd för innehållsfragment med Assets HTTP API. Detta är ett enkelt sätt för utvecklare att utföra Create-, Read-, Update- och Delete-åtgärder (CRUD) mot innehållsfragment.

*Exempel på POSTMAN-begäranden:*
**[CRUD-CFM-API-We.Retail.postman_collection.json](assets/CRUD-CFM-API-We.Retail.postman_collection.json)**

## Vilken leveransmetod som ska användas

### Webbkanal

Det är enkelt att leverera ett innehållsfragment via en webbkanal genom att använda komponenten Content Fragment med AEM Sites.

### Headless

Det finns två alternativ för att visa Content Fragment som JSON som stöd för en kanal från tredje part i ett headless-fall:

1. Använd AEM Content Services- och Proxy API-sidor (Video #2) när det primära användningsexemplet är att leverera innehållsfragment som ska konsumeras (skrivskyddade) av en kanal från tredje part. Content Services-ramverket ger större flexibilitet och fler alternativ vad gäller vilka data som exponeras. Utvecklare kan också utöka Content Services-ramverket för att utöka och/eller berika data.

2. Använd Assets HTTP API (video nr 3) när tredjepartskanalen behöver ändra och/eller uppdatera innehållsfragment. Ett typiskt användningsfall är att importera innehåll från tredje part i en AEM författarmiljö.

## Ytterligare resurser {#additional-resources}

* [Skapa innehållsfragment](content-fragments-feature-video-use.md)
* [AEM WCM-kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
* [AEM WCM Core Content Fragment Component](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html)

Så här hämtar och installerar du paketet nedan på en AEM 6.4+-instans för det slutliga läget från videoserien:\
**[aem_demo_fluid-experience-content-fragments-100.zip](assets/aem_demo_fluid-experiencescontent-fragments-100.zip)**
