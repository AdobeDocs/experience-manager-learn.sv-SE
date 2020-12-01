---
title: Använda översättning med AEM innehållsfragment
description: I AEM 6.3 introduceras möjligheten att översätta innehållsfragment. Medieresurser och resurssamlingar som är kopplade till ett innehållsfragment kan också extraheras och översättas.
sub-product: webbplatser, resurser, innehållstjänster
feature: content-fragments, multi-site-manager
topics: localization, content-architecture
audience: all
doc-type: feature video
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 67ca08bf386a217807da3755d46abed225050d02
workflow-type: tm+mt
source-wordcount: '252'
ht-degree: 0%

---


# Använda översättning med AEM innehållsfragment{#using-translation-with-aem-content-fragments}

I AEM 6.3 introduceras möjligheten att översätta innehållsfragment. Medieresurser och resurssamlingar som är kopplade till ett innehållsfragment kan också extraheras och översättas.

>[!VIDEO](https://video.tv.adobe.com/v/18131/?quality=9&learn=on)

## Användningsexempel för innehållsfragmentöversättning {#content-fragment-translation-use-cases}

Innehållsfragment är en identifierad innehållstyp som AEM extraherar och skickas till en extern översättningstjänst. Flera användningsområden stöds inte:

1. Ett innehållsfragment kan väljas direkt i Assets-konsolen för språkkopiering och översättning
2. Innehållsfragment som refereras på en Sites-sida kopieras till rätt språkmapp och extraheras för översättning när Sites-sidan väljs för språkkopia
3. Material för textbundna media som är inbäddade i ett innehållsfragment kan extraheras och översättas.
4. Resurssamlingar som är kopplade till ett innehållsfragment kan extraheras och översättas

## Konfigurationsalternativ för översättning {#translation-config-options}

Konfigurationen av översättning som är färdig att användas har stöd för flera alternativ för översättning av innehållsfragment. Som standard översätts inte interna medieresurser och associerade resurssamlingar. Om du vill uppdatera översättningskonfigurationen går du till [http://localhost:4502/etc/cloudservices/translation/default_translation.html](http://localhost:4502/etc/cloudservices/translation/default_translation.html).

Det finns fyra alternativ för översättning av Content Fragment-resurser:

1. **Översätt inte (standard)**
2. **Endast textbundna medieresurser**
3. **Endast associerade resurssamlingar**
4. **Infogade medieresurser och associerade samlingar**

![Konfiguration för översättning](assets/classic-ui-dialog.png)
