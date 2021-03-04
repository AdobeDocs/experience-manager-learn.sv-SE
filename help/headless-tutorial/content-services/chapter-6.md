---
title: Kapitel 6 - Visa innehåll på AEM Publish som JSON - Innehållstjänster
description: Kapitel 6 i självstudiekursen AEM Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att tillåta användning från mobilappen.
feature: Innehållsfragment, API:er
topic: Headless, Content Management
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '454'
ht-degree: 1%

---


# Kapitel 6 - Visa innehållet på AEM Publish for Delivery

Kapitel 6 i den AEM självstudiekursen Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att göra det möjligt för mobilappen att konsumera.

## Publicera innehåll för AEM Content Services

Den konfiguration och det innehåll som skapas för att köra händelser via AEM Content Services måste publiceras i AEM Publish så att mobilappen kan komma åt det.

Eftersom AEM Content Services byggs från Configuration (Content Fragment Models, Editable Templates), Assets (Content Fragments, Images) och Pages får alla dessa delar automatiskt AEM funktioner för innehållshantering, som:

* Arbetsflöde för granskning och bearbetning
* och aktivering/inaktivering för att skjuta upp och dra innehåll från AEM Publish AEM Content Services-slutpunkter

1. Kontrollera att **[!DNL WKND Mobile]-programpaketen**, som listas i [Kapitel 1](./chapter-1.md#wknd-mobile-application-packages), är installerade på **AEM Publish** med [!UICONTROL Package Manager].
   * [http://localhost:4503/crx/packmgr](http://localhost:4503/crx/packmgr)

1. Publicera den redigerbara mallen **[!DNL WKND Mobile Events API]**
   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Tools] > [!UICONTROL General] > [!UICONTROL Templates] >[!DNL WKND Mobile]**
   1. Välj mallen **[!DNL Event API]**
   1. Tryck på **[!UICONTROL Publish]** i det övre åtgärdsfältet
   1. Publicera **mallen** och **alla referenser** (innehållsprinciper, innehållsprincipmappningar och mallar)

1. Publicera **[!DNL WKND Mobile Events]-innehållsfragmenten**.

Observera att detta är nödvändigt eftersom API:t för händelser använder komponenten Lista med innehållsfragment, som inte specifikt refererar till innehållsfragment.
1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English] >[!DNL Events]**
1. Markera alla **[!DNL Event]**-innehållsfragment
1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
1. Om du inte vill använda standardåtgärden **Publicera** trycker du på **[!UICONTROL Next]** i det övre åtgärdsfältet
1. Välj **alla** innehållsfragment
1. Tryck på **[!UICONTROL Publish]** i det övre åtgärdsfältet
* *Innehållsfragmentmodellen och referenser till händelsebilder publiceras automatiskt tillsammans med innehållsfragmenten.*[!DNL Events]

1. Publicera **[!DNL Events API]-sidan**.
   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Sites] > [!DNL WKND Mobile] > [!DNL English] >[!DNL API]**
   1. Välj sidan **[!DNL Events]**
   1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
   1. Om du inte vill använda standardåtgärden **Publicera** trycker du på **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Välj sidan **[!DNL Events]**
   1. Tryck på **[!DNL Publish]** i det övre åtgärdsfältet

>[!VIDEO](https://video.tv.adobe.com/v/28343/?quality=12&learn=on)

## Verifiera AEM-publicering

1. I en ny webbläsare kontrollerar du att du är utloggad från AEM Publish och begär följande URL:er (ersätt `http://localhost:4503` för den värd:port AEM Publish körs på).

   * [http://localhost:4503/content/wknd-mobile/en/api/events.model.json](http://localhost:4503/content/wknd-mobile/en/api/events.model.tidy.json)
   Dessa förfrågningar bör returnera samma JSON-svar som när motsvarande AEM Author-slutpunkter granskades. Om de inte gör det kontrollerar du att alla publikationer har slutförts (kontrollera replikeringsköerna). [!DNL WKND Mobile] `ui.apps`-paketet är installerat på AEM Publish och granskar `error.log` för AEM Publish.

## Nästa steg

Det finns inga extra paket att installera. Kontrollera att innehållet och konfigurationen som beskrivs i det här avsnittet publiceras till AEM Publish, annars fungerar inte efterföljande kapitel.

* [Kapitel 7 - Använda AEM innehållstjänster från en mobilapp](./chapter-7.md)
