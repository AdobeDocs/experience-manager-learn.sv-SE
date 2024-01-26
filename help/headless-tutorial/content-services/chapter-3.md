---
title: Kapitel 3 - Innehållsfragment för redigeringshändelser - Innehållstjänster
description: Kapitel 3 i den AEM självstudiekursen Headless handlar om att skapa och redigera händelseinnehållsfragment från innehållsfragmentmodellen som skapas i kapitel 2.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 46ef11a2-81bd-4ff7-b9ef-9f8cba52c6a8
duration: 196
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '415'
ht-degree: 0%

---

# Kapitel 3 - Innehållsfragment för redigeringshändelse

Kapitel 3 i den AEM självstudiekursen Headless handlar om att skapa och redigera händelseinnehållsfragment från innehållsfragmentmodellen som skapas i [Kapitel 2](./chapter-2.md).

## Skapa ett händelseinnehållsfragment

Med [!DNL Event] Content Fragment Model skapades och AEM Configuration for WKND användes på `/content/dam/wknd-mobile` Resursmapp (via `cq:conf` egenskap), en [!DNL Event] Innehållsfragment kan skapas.

Innehållsfragment, som är en typ av resurs, bör ordnas och hanteras i AEM Assets på samma sätt som andra resurser.

* Använd språkmappar i resursmappens struktur om översättning krävs
* Ordna innehållsfragment logiskt så att de är enkla att hitta och hantera

I det här steget skapar du en ny [!DNL Event] for `Punkrock Fest` i `/content/dam/wknd-mobile/en/events` resursmapp.

1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] >[!DNL English]** och skapa resursmappar **[!DNL Events]**.
1. Inom **[!UICONTROL Assets]> [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English] >[!DNL Events]** skapa ett nytt innehållsfragment av typen **[!DNL Event]** med en titel på **[!DNL Punkrock Fest]**.
1. Författare till den nyskapade [!DNL Event] Innehållsfragment.

   * [!DNL Event Title] : **[!DNL Punkrock Fest]**
   * [!DNL Event Description] : **&lt;enter a=&quot;&quot; few=&quot;&quot; lines=&quot;&quot; of=&quot;&quot; description...=&quot;&quot;>**
   * [!DNL Event Date] : **&lt;select a=&quot;&quot; date=&quot;&quot; in=&quot;&quot; the=&quot;&quot; future=&quot;&quot;>**
   * [!DNL Event Type] : **Musik**
   * [!DNL Ticket Price] : **10**
   * [!DNL Event Image] : **/content/dam/wknd-mobile/images/tom-rogerson-574325-unsplash.jpg**
   * [!DNL Venue Name] : **ReptilHouse**
   * [!DNL Venue City] : **New York**

   Tryck **[!UICONTROL Save]** i det övre åtgärdsfältet för att spara ändringar.

1. Använda [AEM](http://localhost:4502/crx/packmgr/index.jsp), installerar du paketet nedan på AEM. Det här paketet innehåller ett antal händelseinnehållsfragment.

   [Hämta fil: GitHub > Resurser > com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)

>[!VIDEO](https://video.tv.adobe.com/v/28338?quality=12&learn=on)

## Granska innehållsfragmentets JCR-struktur

*Det här avsnittet är endast informationsbaserat och är avsett att socialisera den underliggande JCR-strukturen för innehållsfragment som skapats från modeller för innehållsfragment.*

1. Öppna **[CRXDE Lite](http://localhost:4502/crx/de/index.jsp)** på AEM författare.
1. I CRXDE Lite, på den vänstra hierarkimenyn, navigerar du till [/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content) som representerar [!DNL Punkrock Fest] [!DNL Event] Innehållsfragment i JCR.
1. Expandera [data](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content/data/master) nod.
Granska i **Egenskapspanelen** att den har en egenskap `cq:model` som pekar på [!DNL Event] Definition av innehållsfragmentmodell.
   * **`cq:model`**=**`/conf/settings/wknd-mobile/dam/cfm/models/event`**
1. Under `data` noden väljer [master](http://localhost:4502/crx/de/index.jsp#/content/dam/wknd-mobile/en/events/punkrock-fest/jcr:content/data/master) nod och granska egenskaperna. Den här noden innehåller det innehåll som samlats in under utvecklingen av en [!DNL Event] Content Fragment Model. JCR-egenskapsnamnen motsvarar egenskapsnamnet för innehållsfragmentmodellen, och värdena motsvarar de värden som har skapats för &quot;[!DNL Punkrock Fest]&quot; [!DNL Event] Innehållsfragment.

>[!VIDEO](https://video.tv.adobe.com/v/28356?quality=12&learn=on)

## Nästa steg

Vi rekommenderar att du installerar [com.adobe.aem.guides.wknd-mobile.content.chapter-3.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) innehållspaket på AEM författare via [AEM [!UICONTROL Package Manager]](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 4 - Definiera mallar AEM innehållstjänster](./chapter-4.md)
