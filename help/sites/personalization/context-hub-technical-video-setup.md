---
title: Konfigurera ContextHub för personalisering med AEM Sites
description: ContextHub är ett ramverk för att lagra, ändra och presentera kontextdata. Med ContextHub Javascript API kan du komma åt arkiv för att skapa, uppdatera och ta bort data efter behov. Därför representerar ContextHub ett datalager på dina sidor. På den här sidan beskrivs hur du lägger till sammanhangsnav på dina AEM webbplatssidor.
feature: Context Hub
topics: personalization
audience: developer, architect
doc-type: technical video
activity: setup
version: 6.4, 6.5
topic: Personalization
role: Developer
level: Intermediate
exl-id: 89308dd3-a7e5-4fec-bffb-5f0974125c0a
source-git-commit: b3e9251bdb18a008be95c1fa9e5c79252a74fc98
workflow-type: tm+mt
source-wordcount: '422'
ht-degree: 1%

---

# Konfigurera ContextHub för personalisering {#set-up-contexthub}

ContextHub är ett ramverk för att lagra, ändra och presentera kontextdata. Med ContextHub Javascript API kan du komma åt arkiv för att skapa, uppdatera och ta bort data efter behov. Därför representerar ContextHub ett datalager på dina sidor. På den här sidan beskrivs hur du lägger till sammanhangsnav på dina AEM webbplatssidor.

>[!VIDEO](https://video.tv.adobe.com/v/23765?quality=12&learn=on)

>[!NOTE]
>
>Vi använder WKND-referenswebbplatsen för den här videon och den ingår inte i AEM. Du kan ladda ned [senaste versionen här](https://github.com/adobe/aem-guides-wknd/releases).

Lägg till ContextHub på sidorna för att aktivera ContextHub-funktionerna och för att länka till ContextHub JavaScript-biblioteken. ContextHub JavaScript-API:t ger åtkomst till kontextdata som ContextHub hanterar.

## Lägga till ContextHub i en sidkomponent {#adding-contexthub-to-a-page-component}

Om du vill aktivera ContextHub-funktionerna och länka till ContextHub JavaScript-biblioteken inkluderar du `contexthub` i `<head>` på webbsidan. HTML-koden för sidkomponenten liknar följande exempel:

```java
<!--/* Include Context Hub */-->
<sly data-sly-resource="${'contexthub' @ resourceType='granite/contexthub/components/contexthub'}"/>
```

## Platskonfiguration och ContextHub-segment {#site-configuration-and-contexthub-segments}

ContextHub innehåller en segmenteringsmotor som hanterar segment och fastställer vilka segment som matchas för den aktuella kontexten. Flera segment är definierade. Du kan använda Javascript-API:t för att [identifiera matchade segment](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/ch-adding.html#DeterminingResolvedContextHubSegments). Aktivera ContextHub-segmenten för din webbplats under [[!UICONTROL Configuration Browser]](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/configurations.html).

## Skapa segment {#create-segments}

Skapa AEM segment som fungerar som regler för teasers. Det innebär att de definierar när innehåll inom ett suddgummi visas på en webbsida. Innehållet kan sedan anpassas specifikt efter besökarens behov och intressen, beroende på vilket segment de matchar.

## Tilldela molnkonfiguration, segmentsökväg och ContextHub-sökväg till din plats {#assigning-cloud-configuration-segment-path-and-contexthub-path-to-your-site}

Tilldela molnkonfigurationssökvägen, segmenteringssökvägen och ContextHub-sökvägen till platsens rotnod så att du kan skapa en personlig upplevelse för din publik. Med ContextHub kan du ändra kontextdata och testa de lösta segmenten.

![CRXDE Lite](assets/crx-de-properties.png)

Du kan läsa mer om ContextHub och segmentering nedan:

* [ContextHub](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/contexthub.html)
* [Lägga till kontextnav på sidan och få åtkomst till butiker](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/ch-adding.html)
* [Förstå segmentering](https://helpx.adobe.com/experience-manager/6-5/sites/classic-ui-authoring/using/classic-personalization-campaigns-segmentation.html)
* [Konfigurera segmentering med ContextHub](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/segmentation.html)
