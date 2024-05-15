---
title: Översättningsstöd för AEM innehållsfragment
description: Lär dig hur innehållsfragment kan lokaliseras och översättas med Adobe Experience Manager. Medieresurser som är kopplade till ett innehållsfragment kan också extraheras och översättas.
feature: Content Fragments, Multi Site Manager
topic: Localization
role: User
level: Intermediate
version: 6.4, 6.5, Cloud Service
jira: KT-201
thumbnail: 18131.jpg
doc-type: Feature Video
exl-id: cc4ffbd0-207a-42e4-bfcb-d6c83fb97237
duration: 223
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '231'
ht-degree: 0%

---

# Översättningsstöd för AEM innehållsfragment {#translation-support-content-fragments}

Lär dig hur innehållsfragment kan lokaliseras och översättas med Adobe Experience Manager. Medieresurser som är kopplade till ett innehållsfragment kan också extraheras och översättas.

>[!VIDEO](https://video.tv.adobe.com/v/18131?quality=12&learn=on)

## Användningsexempel för översättning av innehållsfragment {#content-fragment-translation-use-cases}

Innehållsfragment är en godkänd innehållstyp som AEM extraheras och skickas till en extern översättningstjänst. Flera användningsområden stöds inte:

1. Ett innehållsfragment kan vara [väljs direkt i Assets-konsolen för språkkopiering och översättning](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/translate-assets.html).
2. Content Fragments referenced on a Sites page are copied to the appropriate language folder and extract for translation when the Sites page is selected for language copy.
3. Material för textbundna media som är inbäddade i ett innehållsfragment kan extraheras och översättas.
4. Resurssamlingar som är kopplade till ett innehållsfragment kan extraheras och översättas.

## Redigerare för översättningsregler {#translation-rules-editor}

Experience Manager kan uppdatera översättningsbeteendet med **Redigerare för översättningsregler**. Om du vill uppdatera översättningen går du till **verktyg** > **Allmänt** > **Översättningskonfiguration** på [http://localhost:4502/libs/cq/translation/translationrules/contexts.html](http://localhost:4502/libs/cq/translation/translationrules/contexts.html).

Utanför förpackningen refererar konfigurationer till innehållsfragment vid `fragmentPath` med en resurstyp av `core/wcm/components/contentfragment/v1/contentfragment`. Alla komponenter som ärver från `v1/contentfragment` identifieras av standardkonfigurationen.

![Redigerare för översättningsregler](assets/translation-configuration.png)
