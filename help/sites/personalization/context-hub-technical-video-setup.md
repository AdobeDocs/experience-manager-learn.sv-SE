---
title: Konfigurera ContextHub för Personalization med AEM Sites
description: ContextHub är ett ramverk för att lagra, ändra och presentera kontextdata. Med ContextHub Javascript API kan du komma åt arkiv för att skapa, uppdatera och ta bort data efter behov. Därför representerar ContextHub ett datalager på dina sidor. På den här sidan beskrivs hur du lägger till sammanhangsnav på dina AEM webbplatssidor.
feature: Context Hub
version: 6.4, 6.5
topic: Personalization
role: Developer
level: Intermediate
doc-type: Technical Video
exl-id: 89308dd3-a7e5-4fec-bffb-5f0974125c0a
duration: 357
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '381'
ht-degree: 1%

---

# Konfigurera ContextHub för Personalization {#set-up-contexthub}

ContextHub är ett ramverk för att lagra, ändra och presentera kontextdata. Med ContextHub Javascript API kan du komma åt arkiv för att skapa, uppdatera och ta bort data efter behov. Därför representerar ContextHub ett datalager på dina sidor. På den här sidan beskrivs hur du lägger till sammanhangsnav på dina AEM webbplatssidor.

>[!VIDEO](https://video.tv.adobe.com/v/23765?quality=12&learn=on)

>[!NOTE]
>
>Vi använder WKND-referenswebbplatsen för den här videon och den ingår inte i AEM. Du kan hämta den [senaste versionen här](https://github.com/adobe/aem-guides-wknd/releases).

Lägg till ContextHub på sidorna för att aktivera ContextHub-funktionerna och för att länka till ContextHub JavaScript-biblioteken. ContextHub JavaScript API ger åtkomst till kontextdata som hanteras av ContextHub.

## Lägga till ContextHub i en sidkomponent {#adding-contexthub-to-a-page-component}

Om du vill aktivera ContextHub-funktionerna och länka till ContextHub JavaScript-biblioteken inkluderar du `contexthub`-komponenten i `<head>`-avsnittet på webbsidan. HTML-koden för sidkomponenten liknar följande exempel:

```java
<!--/* Include Context Hub */-->
<sly data-sly-resource="${'contexthub' @ resourceType='granite/contexthub/components/contexthub'}"/>
```

## Platskonfiguration och ContextHub-segment {#site-configuration-and-contexthub-segments}

ContextHub innehåller en segmenteringsmotor som hanterar segment och fastställer vilka segment som matchas för den aktuella kontexten. Flera segment är definierade. Du kan använda Javascript-API:t för att [identifiera lösta segment](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/ch-adding.html#DeterminingResolvedContextHubSegments). Aktivera ContextHub-segmenten för din webbplats under [[!UICONTROL Configuration Browser]](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/configurations.html).

## Skapa segment {#create-segments}

Skapa AEM segment som fungerar som regler för teasers. Det innebär att de definierar när innehåll inom ett suddgummi visas på en webbsida. Innehållet kan sedan anpassas efter besökarens behov och intressen, beroende på vilket segment som de matchar.

## Tilldela molnkonfiguration, segmentsökväg och ContextHub-sökväg till din plats {#assigning-cloud-configuration-segment-path-and-contexthub-path-to-your-site}

Tilldela konfigurationssökvägen, segmenteringssökvägen och ContextHub-sökvägen till platsens rotnod så att du kan skapa en personlig upplevelse för din publik. Med ContextHub kan du ändra kontextdata och testa de lösta segmenten.

![CRXDE Lite](assets/crx-de-properties.png)

Du kan läsa mer om ContextHub och segmentering nedan:

* [ContextHub](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/contexthub.html)
* [Lägger till kontextnav på sidan och använder butiker](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/ch-adding.html)
* [Förstå segmentering](https://helpx.adobe.com/experience-manager/6-5/sites/classic-ui-authoring/using/classic-personalization-campaigns-segmentation.html)
* [Konfigurerar segmentering med ContextHub](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/segmentation.html)
