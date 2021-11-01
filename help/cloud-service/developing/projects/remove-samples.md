---
title: Ta bort exempel från ett AEM Maven-projekt
description: Lär dig hur du rensar och tar bort exempelkod från ett AEM projekt som genererats av AEM Project Archetype.
version: Cloud Service
topic: Development
feature: AEM Project Archetype
role: Developer
level: Beginner
kt: 9092
thumbnail: 337263.jpeg
source-git-commit: e8b3bcaeee40b4bfd4f967f929ad664e8d168cb0
workflow-type: tm+mt
source-wordcount: '88'
ht-degree: 2%

---


# Ta bort prover från ett AEM Maven-projekt

Lär dig hur du rensar och tar bort genererad exempelkod från ett AEM projekt som genererats av AEM Project Archettype.

>[!VIDEO](https://video.tv.adobe.com/v/337263/?quality=12&learn=on)


## Resurser

+ [AEM Maven Project Archetype](https://github.com/adobe/aem-project-archetype)

## Kommandon

Följande kommandon kan köras för att ta bort de genererade exempelfilerna från AEM Maven Project:

```
rm -rf core/src/main/java/com/adobe/aem/wknd/examples/core/filters \
rm -rf core/src/main/java/com/adobe/aem/wknd/examples/core/listeners \
rm -rf core/src/main/java/com/adobe/aem/wknd/examples/core/models \
rm -rf core/src/main/java/com/adobe/aem/wknd/examples/core/schedulers \
rm -rf core/src/main/java/com/adobe/aem/wknd/examples/core/servlets \
rm -rf core/src/test/java/com/adobe/aem/wknd/examples/core/* \
rm -rf ui.apps/src/main/content/jcr_root/apps/wknd-examples/components/helloworld \
rm -rf ui.frontend/src/main/webpack/components/_helloworld.js \
rm -rf ui.frontend/src/main/webpack/components/_helloworld.css
```

## Redigeringar

Ta bort `<div class="helloworld" ...></div>` från:

```
ui.frontend/src/main/webpack/static/index.html
```

Ta bort `<helloworld>` komponentinstansdefinition från:

```
ui.content/src/main/content/jcr_root/content/wknd-examples/us/en/.content.xml
```
