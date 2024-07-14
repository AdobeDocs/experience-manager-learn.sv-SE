---
title: Kapitel 6 - Visa innehåll på AEM Publish som JSON - Innehållstjänster
description: Kapitel 6 i självstudiekursen AEM Headless handlar om att säkerställa att alla nödvändiga paket, konfigurationer och innehåll finns på AEM Publish för att tillåta konsumtion från mobilappen.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: b33d1509-531d-40c3-9b26-1d18c8d86a97
duration: 196
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '434'
ht-degree: 0%

---

# Kapitel 6 - Visa innehållet på AEM Publish för leverans

Kapitel 6 i självstudiekursen AEM Headless handlar om att säkerställa att alla paket, konfigurationer och innehåll som behövs finns på AEM Publish så att mobilappen kan användas.

## Publicera innehåll för AEM Content Services

Den konfiguration och det innehåll som skapas för att köra händelser via AEM Content Services måste publiceras till AEM Publish så att mobilappen kan komma åt det.

Eftersom AEM Content Services byggs från Configuration (Content Fragment Models, Editable Templates), Assets (Content Fragments, Images) och Pages får alla dessa delar automatiskt AEM funktioner för innehållshantering, som:

* Arbetsflöde för granskning och bearbetning
* och aktivering/inaktivering för att skjuta upp och dra innehåll från de AEM slutpunkterna för Publish AEM Content Services

1. Kontrollera att **[!DNL WKND Mobile]-programpaketen**, som listas i [Kapitel 1](./chapter-1.md#wknd-mobile-application-packages), är installerade på **AEM Publish** med [!UICONTROL Package Manager].
   * [http://localhost:4503/crx/packmgr](http://localhost:4503/crx/packmgr)

1. Publish den redigerbara mallen **[!DNL WKND Mobile Events API]**
   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Tools] > [!UICONTROL General] > [!UICONTROL Templates] >[!DNL WKND Mobile]**
   1. Välj mallen **[!DNL Event API]**
   1. Tryck på **[!UICONTROL Publish]** i det övre åtgärdsfältet
   1. Publish **mallen** och **alla referenser** (innehållsprinciper, innehållsprincipmappningar och mallar)

1. Publish **[!DNL WKND Mobile Events]-innehållsfragmenten**.

   Observera att detta är nödvändigt eftersom API:t för händelser använder komponenten Lista med innehållsfragment, som inte specifikt refererar till innehållsfragment.

   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] > [!UICONTROL Files] > [!DNL WKND Mobile] > [!DNL English] >[!DNL Events]**
   1. Markera alla **[!DNL Event]**-innehållsfragment
   1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
   1. Lämna standardåtgärden **Publish** som den är, tryck **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Markera **alla** innehållsfragment
   1. Tryck på **[!UICONTROL Publish]** i det övre åtgärdsfältet
      * *Innehållsfragmentmodellen i [!DNL Events] och referenser till händelsebilder publiceras automatiskt tillsammans med innehållsfragmenten.*

1. Publish **[!DNL Events API]-sidan**.
   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Sites] > [!DNL WKND Mobile] > [!DNL English] >[!DNL API]**
   1. Välj sidan **[!DNL Events]**
   1. Tryck på **[!UICONTROL Manage Publication]** i det övre åtgärdsfältet
   1. Lämna standardåtgärden **Publish** som den är, tryck **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Välj sidan **[!DNL Events]**
   1. Tryck på **[!DNL Publish]** i det övre åtgärdsfältet

>[!VIDEO](https://video.tv.adobe.com/v/28343?quality=12&learn=on)

## Verifiera AEM Publish

1. I en ny webbläsare kontrollerar du att du är utloggad från AEM Publish och begär följande URL:er (ersätt `http://localhost:4503` för den värd:port AEM Publish körs på).

   * [http://localhost:4503/content/wknd-mobile/en/api/events.model.json](http://localhost:4503/content/wknd-mobile/en/api/events.model.tidy.json)

   Dessa förfrågningar bör returnera samma JSON-svar som när motsvarande AEM författarslutpunkter granskades. Om de inte gör det kontrollerar du att alla publikationer har slutförts (kontrollera replikeringsköerna). [!DNL WKND Mobile] `ui.apps`-paketet installeras AEM Publish och läser `error.log` för AEM Publish.

## Nästa steg

Det finns inga extra paket att installera. Kontrollera att innehållet och konfigurationen som beskrivs i det här avsnittet publiceras till AEM Publish, annars fungerar inte efterföljande kapitel.

* [Kapitel 7 - Använda AEM innehållstjänster från en mobilapp](./chapter-7.md)
