---
title: Komma igång med AEM Headless - Kapitel 6 - Visa innehållet i AEM Publish som JSON
description: Kapitel 6 i självstudiekursen AEM Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att tillåta användning från mobilappen.
translation-type: tm+mt
source-git-commit: 22ccd6627a035b37edb180eb4633bc3b57470c0c
workflow-type: tm+mt
source-wordcount: '449'
ht-degree: 0%

---


# Kapitel 6 - Visa innehållet på AEM Publish for Delivery

Kapitel 6 i den AEM självstudiekursen Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att göra det möjligt för mobilappen att konsumera.

## Publicera innehåll för AEM Content Services

Den konfiguration och det innehåll som skapas för att köra händelser via AEM Content Services måste publiceras i AEM Publish så att mobilappen kan komma åt det.

Eftersom AEM Content Services byggs från Configuration (Content Fragment Models, Editable Templates), Assets (Content Fragments, Images) och Pages får alla dessa delar automatiskt AEM funktioner för innehållshantering, som:

* Arbetsflöde för granskning och bearbetning
* och aktivering/inaktivering för att skjuta upp och dra innehåll från AEM Publish AEM Content Services-slutpunkter

1. Kontrollera att **[!DNL WKND Mobile]programpaketen**, som listas i [kapitel 1](./chapter-1.md#wknd-mobile-application-packages), är installerade på **AEM Publish** med [!UICONTROL Package Manager].
   * [http://localhost:4503/crx/packmgr](http://localhost:4503/crx/packmgr)

1. Publicera den **[!DNL WKND Mobile Events API]redigerbara mallen**
   1. Navigera till **[!UICONTROL AEM]>[!UICONTROL Tools]>[!UICONTROL General]>[!UICONTROL Templates]>[!DNL WKND Mobile]**
   1. Select the **[!DNL Event API]** template
   1. Tryck **[!UICONTROL Publish]** i det övre åtgärdsfältet
   1. Publicera **mallen** och **alla referenser** (innehållsprinciper, innehållsprincipmappningar och mallar)

1. Publicera **[!DNL WKND Mobile Events]innehållsfragmenten**.

Observera att detta är nödvändigt eftersom API:t för händelser använder komponenten Lista med innehållsfragment, som inte specifikt refererar till innehållsfragment.
1. Navigera till **[!UICONTROL AEM]>[!UICONTROL Assets]>[!UICONTROL Files]>[!DNL WKND Mobile]>[!DNL English]>[!DNL Events]** 1. Markera alla **[!DNL Event]** innehållsfragment1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet1. Om du inte anger standardåtgärden **Publicera** som den är trycker du **[!UICONTROL Next]** i det övre åtgärdsfältet1. Markera **alla** innehållsfragment1. Tryck **[!UICONTROL Publish]** i det övre åtgärdsfältet* *[!DNL Events]Innehållsfragmentmodellen och refererar till händelsebilder publiceras automatiskt tillsammans med innehållsfragmenten.*

1. Publicera **[!DNL Events API]sidan**.
   1. Navigera till **[!UICONTROL AEM]>[!UICONTROL Sites]>[!DNL WKND Mobile]>[!DNL English]>[!DNL API]**
   1. Markera **[!DNL Events]** sidan
   1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
   1. Om du inte ändrar standardåtgärden **Publicera** i befintligt skick trycker du **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Markera **[!DNL Events]** sidan
   1. Tryck **[!DNL Publish]** i det övre åtgärdsfältet

>[!VIDEO](https://video.tv.adobe.com/v/28343/?quality=12&learn=on)

## Verifiera AEM-publicering

1. I en ny webbläsare kontrollerar du att du är utloggad från AEM Publish och begär följande URL:er (ersätt `http://localhost:4503` med valfri värd:port AEM Publish körs på).

   * [http://localhost:4503/content/wknd-mobile/en/api/events.model.json](http://localhost:4503/content/wknd-mobile/en/api/events.model.tidy.json)
   Dessa förfrågningar bör returnera samma JSON-svar som när motsvarande AEM Author-slutpunkter granskades. Om de inte gör det kontrollerar du att alla publikationer har slutförts (kontrollera replikeringsköerna), att [!DNL WKND Mobile] paketet är installerat på AEM Publish och att du har läst igenom `ui.apps` `error.log` för AEM Publish.

## Nästa steg

Det finns inga extra paket att installera. Kontrollera att innehållet och konfigurationen som beskrivs i det här avsnittet publiceras till AEM Publish, annars fungerar inte efterföljande kapitel.

* [Kapitel 7 - Använda AEM innehållstjänster från en mobilapp](./chapter-7.md)
