---
title: Kapitel 6 - Visa innehåll vid AEM publicering som JSON - Innehållstjänster
description: Kapitel 6 i självstudiekursen AEM Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att tillåta användning från mobilappen.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: b33d1509-531d-40c3-9b26-1d18c8d86a97
duration: 225
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '434'
ht-degree: 0%

---

# Kapitel 6 - Visa innehåll vid AEM publicering för leverans

Kapitel 6 i självstudiekursen AEM Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att göra det möjligt att använda mobilappen.

## Publicera innehåll för AEM Content Services

Den konfiguration och det innehåll som skapas för att köra händelser via AEM Content Services måste publiceras för AEM Publish så att mobilappen kan komma åt det.

Eftersom AEM Content Services byggs från Configuration (Content Fragment Models, Editable Templates), Assets (Content Fragments, Images) och Pages får alla dessa delar automatiskt AEM funktioner för innehållshantering, som:

* Arbetsflöde för granskning och bearbetning
* och aktivering/inaktivering för att skjuta upp och dra innehåll från AEM publiceringens AEM Content Services-slutpunkter

1. Kontrollera **[!DNL WKND Mobile]Programpaket**, listas i [Kapitel 1](./chapter-1.md#wknd-mobile-application-packages), installeras på **AEM Publish** använda [!UICONTROL Package Manager].
   * [http://localhost:4503/crx/packmgr](http://localhost:4503/crx/packmgr)

1. Publicera **[!DNL WKND Mobile Events API]Redigerbar mall**
   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Tools] > [!UICONTROL General] > [!UICONTROL Templates] >[!DNL WKND Mobile]**
   1. Välj **[!DNL Event API]** mall
   1. Tryck **[!UICONTROL Publish]** i det övre åtgärdsfältet
   1. Publicera **mall** och **alla referenser** (innehållsprinciper, innehållsprincipmappningar och mallar)

1. Publicera **[!DNL WKND Mobile Events]innehållsfragment**.

   Observera att detta är nödvändigt eftersom API:t för händelser använder komponenten Lista med innehållsfragment, som inte specifikt refererar till innehållsfragment.

   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English] >[!DNL Events]**
   1. Markera alla **[!DNL Event]** innehållsfragment
   1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
   1. Lämnar standardinställningen **Publicera** åtgärd i befintligt skick, tryck **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Välj **alla** innehållsfragment
   1. Tryck **[!UICONTROL Publish]** i det övre åtgärdsfältet
      * *The [!DNL Events] Content Fragment Model och refererar till händelsebilder publiceras automatiskt tillsammans med innehållsfragmenten.*

1. Publicera **[!DNL Events API]page**.
   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Sites] > [!DNL WKND Mobile] > [!DNL English] >[!DNL API]**
   1. Välj **[!DNL Events]** page
   1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
   1. Lämnar standardinställningen **Publicera** åtgärd i befintligt skick, tryck **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Välj **[!DNL Events]** page
   1. Tryck **[!DNL Publish]** i det övre åtgärdsfältet

>[!VIDEO](https://video.tv.adobe.com/v/28343?quality=12&learn=on)

## Verifiera AEM

1. I en ny webbläsare kontrollerar du att du är utloggad AEM Publicera och begär följande URL:er (ersätt) `http://localhost:4503` för alla värddatorer:port AEM Publish körs på).

   * [http://localhost:4503/content/wknd-mobile/en/api/events.model.json](http://localhost:4503/content/wknd-mobile/en/api/events.model.tidy.json)

   Dessa förfrågningar bör returnera samma JSON-svar som när motsvarande AEM författarslutpunkter granskades. Om de inte gör det kontrollerar du att alla publikationer har slutförts (kontrollera replikeringsköerna), [!DNL WKND Mobile] `ui.apps` paketet installeras AEM publicera och du kan granska `error.log` för AEM.

## Nästa steg

Det finns inga extra paket att installera. Kontrollera att innehållet och konfigurationen som beskrivs i det här avsnittet publiceras AEM Publicera, annars fungerar inte efterföljande kapitel.

* [Kapitel 7 - Använda AEM innehållstjänster från en mobilapp](./chapter-7.md)
