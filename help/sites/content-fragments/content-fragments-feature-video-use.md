---
title: Skapa innehållsfragment i AEM
description: Innehållsfragment är en innehållsabstraktion i AEM som gör det möjligt att skapa och hantera textbaserat innehåll oberoende av vilka kanaler det stöder.
feature: Content Fragments
version: Experience Manager as a Cloud Service
topic: Content Management
role: User
level: Beginner
doc-type: Feature Video
exl-id: d33c033a-9577-4d4e-99be-f3c7e2a4ce73
duration: 665
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '358'
ht-degree: 0%

---

# Skapa innehållsfragment {#authoring-content-fragments}

Innehållsfragment är en innehållsabstraktion i AEM som gör det möjligt att skapa och hantera textbaserat innehåll oberoende av vilka kanaler det stöder.

AEM Content Fragments är textbaserat redaktionellt innehåll som kan innehålla vissa strukturerade dataelement som är kopplade till, men som betraktas som rent innehåll utan design- eller layoutinformation. Innehållsfragment skapas vanligtvis som kanalbaserat innehåll, som är avsett att användas och återanvändas i alla kanaler, vilket i sin tur omsluter innehållet i en kontextspecifik upplevelse.

Den här videoserien handlar om redigeringscykeln för innehållsfragment i AEM. Information om att [leverera innehållsfragment finns här](content-fragments-delivery-feature-video-use.md).

1. Aktivera och definiera modeller för innehållsfragment
2. Skapa innehållsfragment
3. Hämta innehållsfragment
4. Redigeringsfunktioner

>[!CONTEXTUALHELP]
>id="aemcloud_sites_admin_content_fragments"
>title="Hantera fragment"
>abstract="Lär dig hur innehållsfragment gör att du kan utforma, skapa, strukturera och använda sidoberoende innehåll."

## Definiera modeller för innehållsfragment {#defining-content-fragment-models}

>[!VIDEO](https://video.tv.adobe.com/v/22452?quality=12&learn=on)

AEM Content Fragments Models, datascheman för Content Fragments, måste aktiveras via AEM [[!UICONTROL Configuration Browser]](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/configurations.html?lang=sv-SE), som gör att Content Fragment Models kan definieras per konfiguration.

## Skapa innehållsfragment {#creating-content-fragments}

>[!VIDEO](https://video.tv.adobe.com/v/22451?quality=12&learn=on)

AEM-konfigurationer tillämpas på AEM Assets mapphierarkier så att deras Content Fragment Models kan skapas som Content Fragments. Content Fragments har stöd för en omfattande formulärbaserad redigeringsfunktion som gör att innehållet kan modelleras som en samling element.

Innehållsfragment kan ha flera varianter, där varje variant adresserar olika användningsfall (inte nödvändigtvis kanal) för innehållet.

*Exempel på sportbiografi för import:*\
**[sandra-spritent-bio.txt](assets/sandra-sprient-bio.txt)**

## Hämta innehållsfragment {#downloading-content-fragments}

>[!VIDEO](https://video.tv.adobe.com/v/22450?quality=12&learn=on)

AEM Content Fragments kan laddas ned från AEM Author som en ZIP-fil som innehåller Varianter, Elements och Metadata.

*Exempel på ZIP-fil för hämtning av innehållsfragment:*\
**[daniel_schreder.zip](assets/daniel_schreder.zip)**

## Redigeringsfunktioner för innehållsfragment {#editorial-capabilities}

>[!VIDEO](https://video.tv.adobe.com/v/25891?quality=12&learn=on)

>[!NOTE]
>
> Anteckningar och versionsjämförelser för innehållsfragment introducerades i [AEM 6.4 Service Pack 2](https://helpx.adobe.com/se/experience-manager/aem-releases-updates.html) och [AEM 6.3 Service Pack 3](https://helpx.adobe.com/se/experience-manager/6-3/release-notes/sp3-release-notes.html).

## Nästa steg

Lär dig mer om att [leverera innehållsfragment](content-fragments-delivery-feature-video-use.md).

## Ytterligare resurser {#additional-resources}

* [Leverera innehållsfragment](content-fragments-delivery-feature-video-use.md)
* [AEM WCM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html?lang=sv-SE)
* [AEM WCM Core Content Fragment Component](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/components/content-fragment-component.html?lang=sv-SE)

Så här hämtar och installerar du paketet nedan på en AEM 6.4+-instans för det slutliga läget från videoserien:

**[aem_demo_fluid-experience-content-fragments-100.zip](assets/aem_demo_fluid-experiencescontent-fragments-100.zip)**
