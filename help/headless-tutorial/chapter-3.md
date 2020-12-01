---
title: Kapitel 3 - Innehållsfragment för redigeringshändelse
seo-title: Komma igång med AEM Content Services - Kapitel 3 - Innehållsfragment för redigeringshändelser
description: Kapitel 3 i den AEM självstudiekursen Headless handlar om att skapa och redigera händelseinnehållsfragment från innehållsfragmentmodellen som skapas i kapitel 2.
seo-description: Kapitel 3 i den AEM självstudiekursen Headless handlar om att skapa och redigera händelseinnehållsfragment från innehållsfragmentmodellen som skapas i kapitel 2.
translation-type: tm+mt
source-git-commit: d7258f8acf6df680795ce61cc8383e60b5b7d722
workflow-type: tm+mt
source-wordcount: '500'
ht-degree: 0%

---


# Kapitel 3 - Innehållsfragment för redigeringshändelse

Kapitel 3 i den AEM självstudiekursen Headless handlar om att skapa och redigera händelseinnehållsfragment från innehållsfragmentmodellen som skapats i [Kapitel 2](./chapter-2.md).

## Skapa ett händelseinnehållsfragment

När en [!DNL Event] Content Fragment Model har skapats och AEM Configuration for WKND har tillämpats på resursmappen `/content/dam/wknd-mobile` (via egenskapen `cq:conf`) kan ett [!DNL Event] Content Fragment skapas.

Innehållsfragment, som är en typ av resurs, bör ordnas och hanteras i AEM Assets på samma sätt som andra resurser.

* Använd språkmappar i resursmappens struktur om översättning krävs
* Ordna innehållsfragment logiskt så att de är enkla att hitta och hantera

I det här steget skapar du en ny [!DNL Event] för `Punkrock Fest` i resursmappen `/content/dam/wknd-mobile/en/events`.

1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] >[!DNL English]** och skapa resursmappar **[!DNL Events]**.
1. I **[!UICONTROL Assets]> [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English] >[!DNL Events]** skapar du ett nytt innehållsfragment av typen **[!DNL Event]** med titeln **[!DNL Punkrock Fest]**.
1. Skapa det nya [!DNL Event]-innehållsfragmentet.

   * [!DNL Event Title] : **[!DNL Punkrock Fest]**
   * [!DNL Event Description] :  **&lt;enter a=&quot;&quot; few=&quot;&quot; lines=&quot;&quot; of=&quot;&quot; description=&quot;&quot;>**
   * [!DNL Event Date] :  **&lt;select a=&quot;&quot; date=&quot;&quot; in=&quot;&quot; the=&quot;&quot; future=&quot;&quot;>**
   * [!DNL Event Type] :  **Musik**
   * [!DNL Ticket Price] :  **10**
   * [!DNL Event Image] :  **/content/dam/wknd-mobile/images/tom-rogerson-574325-unsplash.jpg**
   * [!DNL Venue Name] :  **ReptilHouse**
   * [!DNL Venue City] :  **New York**

   Tryck på **[!UICONTROL Save]** i det övre åtgärdsfältet för att spara ändringarna.

1. Använd [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp) och installera paketet nedan på AEM Author. Det här paketet innehåller ett antal händelseinnehållsfragment.

   [Hämta fil: GitHub > Assets > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

>[!VIDEO](https://video.tv.adobe.com/v/28338/?quality=12&learn=on)

## Granska innehållsfragmentets JCR-struktur

*Det här avsnittet är endast informationsbaserat och är avsett att socialisera den underliggande JCR-strukturen för innehållsfragment som skapats från modeller för innehållsfragment.*

1. Öppna **[CRXDE Lite](http://localhost:4502/crx/de/index.jsp)** på AEM Author.
1. I CRXDE Lite går du till [/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content), som är den nod som representerar [!DNL Punkrock Fest] [!DNL Event]-innehållsfragment i JCR.
1. Expandera noden [data](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content/data/master).
Granska i rutan **Egenskaper** att den har en egenskap `cq:model` som pekar på definitionen för innehållsfragmentmodellen i [!DNL Event].
   * **`cq:model`**=**`/conf/settings/wknd-mobile/dam/cfm/models/event`**
1. Under noden `data` markerar du noden [överordnad](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content/data/master) och granskar egenskaperna. Den här noden innehåller det innehåll som samlats in under utvecklingen av en [!DNL Event] Content Fragment Model. JCR-egenskapsnamnen motsvarar egenskapsnamnen för innehållsfragmentmodellen, och värdena motsvarar de värden som skapats för [!DNL Punkrock Fest] [!DNL Event] innehållsfragmentet.

>[!VIDEO](https://video.tv.adobe.com/v/28356/?quality=12&learn=on)

## Nästa steg

Du bör installera [com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)-innehållspaketet på AEM Author via [AEM [!UICONTROL Package Manager]](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 4 - Definiera mallar AEM innehållstjänster](./chapter-4.md)
