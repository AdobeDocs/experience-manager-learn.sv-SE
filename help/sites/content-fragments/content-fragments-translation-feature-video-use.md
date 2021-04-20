---
title: Översättningsstöd för AEM innehållsfragment
description: Lär dig hur innehållsfragment kan lokaliseras och översättas med Adobe Experience Manager. Medieresurser som är kopplade till ett innehållsfragment kan också extraheras och översättas.
feature: Content Fragments, Multi Site Manager
topic: Localization
role: Business Practitioner
level: Intermediate
version: 6.3, 6.4, 6.5, cloud-service
kt: 201
thumbnail: 18131.jpg
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '251'
ht-degree: 0%

---


# Översättningsstöd för AEM innehållsfragment {#translation-support-content-fragments}

Lär dig hur innehållsfragment kan lokaliseras och översättas med Adobe Experience Manager. Medieresurser som är kopplade till ett innehållsfragment kan också extraheras och översättas.

>[!VIDEO](https://video.tv.adobe.com/v/18131/?quality=12&learn=on)

## Användningsexempel för innehållsfragmentöversättning {#content-fragment-translation-use-cases}

Innehållsfragment är en godkänd innehållstyp som AEM extraheras och skickas till en extern översättningstjänst. Flera användningsområden stöds inte:

1. Ett innehållsfragment kan väljas direkt i Assets-konsolen för språkkopiering och översättning
2. Innehållsfragment som refereras på en Sites-sida kopieras till rätt språkmapp och extraheras för översättning när Sites-sidan väljs för språkkopia
3. Material för textbundna media som är inbäddade i ett innehållsfragment kan extraheras och översättas.
4. Resurssamlingar som är kopplade till ett innehållsfragment kan extraheras och översättas

## Redigerare för översättningsregler {#translation-rules-editor}

Översättningsbeteendet för Experience Manager kan uppdateras med **Översättningsregelredigeraren**. Om du vill uppdatera översättningen går du till **Verktyg** > **Allmänt** > **Översättningskonfiguration** på [http://localhost:4502/libs/cq/translation/translationrules/contexts.html](http://localhost:4502/libs/cq/translation/translationrules/contexts.html).

Utanför förpackningen refererar konfigurationer till innehållsfragment vid `fragmentPath` med resurstypen `core/wcm/components/contentfragment/v1/contentfragment`. Alla komponenter som ärver från `v1/contentfragment` identifieras av standardkonfigurationen.

![Redigerare för översättningsregler](assets/translation-configuration.png)
