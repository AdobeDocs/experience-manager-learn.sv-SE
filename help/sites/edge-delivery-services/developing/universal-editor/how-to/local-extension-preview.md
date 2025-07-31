---
title: Förhandsgranska ett universellt redigeringstillägg
description: Lär dig hur du förhandsgranskar ett tillägg för en universell redigerare som körs lokalt under utvecklingen.
version: Experience Manager as a Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner, Intermediate, Experienced
doc-type: Tutorial
jira: KT-18658
source-git-commit: f0ad5d66549970337118220156d7a6b0fd30fd57
workflow-type: tm+mt
source-wordcount: '306'
ht-degree: 0%

---


# Förhandsgranska ett lokalt universellt redigeringstillägg

>[!TIP]
> Lär dig hur du [skapar ett universellt redigeringstillägg](https://developer.adobe.com/uix/docs/services/aem-universal-editor/).

Om du vill förhandsgranska ett universellt redigeringstillägg under utvecklingen måste du:

1. Kör tillägget lokalt.
2. Acceptera det självsignerade certifikatet.
3. Öppna en sida i Universal Editor.
4. Uppdatera platsens URL för att läsa in det lokala tillägget.

## Kör tillägget lokalt

Detta förutsätter att du redan har skapat ett [Universal Editor-tillägg](https://developer.adobe.com/uix/docs/services/aem-universal-editor/) och vill förhandsgranska det när du testar och utvecklar lokalt.

Starta tillägget Universal Editor med:

```bash
$ aio app run
```

Du ser utdata som:

```
To view your local application:
  -> https://localhost:9080
To view your deployed application in the Experience Cloud shell:
  -> https://experience.adobe.com/?devMode=true#/custom-apps/?localDevUrl=https://localhost:9080
```

Detta kör tillägget på `https://localhost:9080` som standard.


## Acceptera det självsignerade certifikatet

Universal Editor kräver HTTPS för att läsa in tillägg. Eftersom lokal utveckling använder ett självsignerat certifikat måste webbläsaren uttryckligen lita på det.

Öppna en ny flik i webbläsaren och navigera till den lokala URL-utdatafilen för tillägget med kommandot `aio app run`:

```
https://localhost:9080
```

Webbläsaren visar en certifikatvarning. Acceptera certifikatet för att fortsätta.

![Acceptera det självsignerade certifikatet](./assets/local-extension-preview/accept-certificate.png)

När du har accepterat visas platshållarsidan för det lokala tillägget:

![Tillägg är tillgängligt](./assets/local-extension-preview/extension-accessible.png)


## Öppna en sida i Universal Editor

Öppna Universal Editor via [Universal Editor-konsolen](https://experience.adobe.com/#/@myOrg/aem/editor/canvas/) eller genom att redigera en sida i AEM Sites som använder Universal Editor:

![Öppna en sida i Universal Editor](./assets/local-extension-preview/open-page-in-ue.png)


## Läs in tillägget

Leta reda på fältet **Plats** längst upp i mitten av gränssnittet i Universellt redigeringsprogram. Expandera den och uppdatera **URL:en i platsfältet**, **inte webbläsarens adressfält**.

Lägg till följande frågeparametrar:

* `devMode=true` - Aktiverar utvecklingsläge för Universal Editor.
* `ext=https://localhost:9080` - Läser in ditt lokalt körda tillägg.

Exempel:

```
https://author-pXXX-eXXX.adobeaemcloud.com/content/aem-ue-wknd/index.html?devMode=true&ext=https://localhost:9080
```

![Uppdatera URL:en för Universal Editor-platsen](./assets/local-extension-preview/update-location-url.png)


## Förhandsgranska tillägget

Utför en **hård inläsning** av webbläsaren för att kontrollera att den uppdaterade URL:en används.

Det lokala tillägget läses nu in i den universella redigeraren - endast i webbläsarsessionen.

Alla kodändringar du gör lokalt återspeglas omedelbart.

![Lokalt tillägg har lästs in](./assets/local-extension-preview/extension-loaded.png)

