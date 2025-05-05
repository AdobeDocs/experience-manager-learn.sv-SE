---
title: Översättningsstöd för AEM Content Fragments
description: Lär dig hur innehållsfragment kan lokaliseras och översättas med Adobe Experience Manager. Medieresurser som är kopplade till ett innehållsfragment kan också extraheras och översättas.
feature: Content Fragments, Multi Site Manager
topic: Localization
role: User
level: Intermediate
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
jira: KT-201
thumbnail: 18131.jpg
doc-type: Feature Video
exl-id: cc4ffbd0-207a-42e4-bfcb-d6c83fb97237
duration: 223
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '231'
ht-degree: 0%

---

# Översättningsstöd för AEM Content Fragments {#translation-support-content-fragments}

Lär dig hur innehållsfragment kan lokaliseras och översättas med Adobe Experience Manager. Medieresurser som är kopplade till ett innehållsfragment kan också extraheras och översättas.

>[!VIDEO](https://video.tv.adobe.com/v/18131?quality=12&learn=on)

## Användningsexempel för översättning av innehållsfragment {#content-fragment-translation-use-cases}

Innehållsfragment är en känd innehållstyp som AEM extraherar och skickar till en extern översättningstjänst. Flera användningsområden stöds inte:

1. Ett innehållsfragment kan [väljas direkt i Assets-konsolen för språkkopiering och översättning](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/translate-assets.html?lang=sv-SE).
2. Content Fragments referenced on a Sites page are copied to the appropriate language folder and extract for translation when the Sites page is selected for language copy.
3. Material för textbundna media som är inbäddade i ett innehållsfragment kan extraheras och översättas.
4. Resurssamlingar som är kopplade till ett innehållsfragment kan extraheras och översättas.

## Redigerare för översättningsregler {#translation-rules-editor}

Experience Manager översättningsbeteende kan uppdateras med **redigeraren för översättningsregler**. Om du vill uppdatera översättningen går du till **Verktyg** > **Allmänt** > **Översättningskonfiguration** på [http://localhost:4502/libs/cq/translation/translationrules/contexts.html](http://localhost:4502/libs/cq/translation/translationrules/contexts.html).

Slut på konfiguration refererar till innehållsfragment vid `fragmentPath` med resurstypen `core/wcm/components/contentfragment/v1/contentfragment`. Alla komponenter som ärver från `v1/contentfragment` känns igen av standardkonfigurationen.

![Redigerare för översättningsregler](assets/translation-configuration.png)
