---
title: Konfigurera manifest.yml för ett Asset Compute-projekt
description: Projektets manifest.yml för beräkning av tillgångar beskriver alla arbetare i det här programmet som ska distribueras.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6281
thumbnail: KT-6281.jpg
translation-type: tm+mt
source-git-commit: 50519b9526182b528047069f211498099e3a4c88
workflow-type: tm+mt
source-wordcount: '531'
ht-degree: 0%

---


# Konfigurera manifest.yml

I `manifest.yml`rotkatalogen för projektet Asset Compute beskrivs alla arbetare i det här projektet som ska distribueras.

![manifest.yml](./assets/manifest/manifest.png)

## Standarddefinition för arbetare

Arbetare definieras som Adobe I/O Runtime åtgärdsposter under `actions`, och består av en uppsättning konfigurationer.

Arbetare som använder andra Adobe I/O-integreringar måste ange `annotations -> require-adobe-auth` egenskapen till `true` eftersom detta [visar arbetarens Adobe I/O-autentiseringsuppgifter](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#access-adobe-apis) via `params.auth` objektet. Detta är vanligtvis nödvändigt när arbetaren anropar API:er för Adobe I/O som Adobe Photoshop, Lightroom eller Sensei och kan växlas per arbetare.

1. Öppna och granska den automatiskt genererade arbetaren `manifest.yml`. Projekt som innehåller flera Asset Compute-arbetare måste definiera en post för varje arbetare under `actions` arrayen.

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: # the array of workers, since we have a single worker there is only one entry beneath actions
      worker: # the auto-generated worker definition
        function: actions/worker/index.js # the entry point to the worker 
        web: 'yes'  # as our worker is invoked over HTTP from AEM Author service
        runtime: 'nodejs:12' # the target nodejs runtime (only 10 and 12 are supported)
        limits:
          concurrency: 10
        annotations:
          require-adobe-auth: true # set to true, to pass through Adobe I/O access token/client id via params.auth in the worker, typically required when the worker calls out to Adobe I/O APIs such as the Adobe Photoshop, Lightroom or Sensei APIs.
```

## Definiera gränser

Varje arbetare kan konfigurera [gränserna](https://www.adobe.io/apis/experienceplatform/runtime/docs.html#!adobedocs/adobeio-runtime/master/guides/system_settings.md) för sin körningskontext i Adobe I/O Runtime. Dessa värden bör justeras för att ge optimal storlek för arbetaren, baserat på volymen, hastigheten och typen av resurser som den beräknar samt vilken typ av arbete den utför.

Granska [vägledningen](https://docs.adobe.com/content/help/en/asset-compute/using/extend/develop-custom-application.html#sizing-workers) för storleksändring av Adobe innan du anger gränser. Resursberäkningspersonal kan få slut på minne när resurser bearbetas, vilket leder till att körningen av Adobe I/O Runtime avbryts, så att arbetaren har rätt storlek för att hantera alla resurser.

1. Lägg till ett `inputs` avsnitt i den nya `wknd-asset-compute` åtgärdsposten. Detta gör det möjligt att justera resursplaneringsarbetarens totala prestanda och resursallokering.

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: 
      worker:
        function: actions/worker/index.js 
        web: 'yes' 
        runtime: 'nodejs:12'
        limits: # Allows for the tuning of the worker's performance
          timeout: 60000 # timeout in milliseconds (1 minute)
          memorySize: 512 # memory allocated in MB; if the worker offloads heavy computational work to other Web services this number can be reduced
          concurrency: 10 # adjust based on expected concurrent processing and timeout 
        annotations:
          require-adobe-auth: true
           
```

## Den färdiga manifest.yml

Den slutliga `manifest.yml` stilen ser ut så här:

```yml
packages:
  __APP_PACKAGE__:
    license: Apache-2.0
    actions: 
      worker:
        function: actions/worker/index.js 
        web: 'yes' 
        runtime: 'nodejs:12'
        limits:
          timeout: 60000 # in ms
          memorySize: 512 # in MB
          concurrency: 10 
        annotations:
          require-adobe-auth: true
```

## Verifierar manifest.yml

När den genererade resursberäkningen `manifest.yml` har uppdaterats kör du det lokala utvecklingsverktyget och ser till att de uppdaterade `manifest.yml` inställningarna börjar gälla.

Så här startar du verktyget Resursberäkning för projektet Resursberäkning:

1. Öppna en kommandorad i projektroten Resursberäkning (i VS-koden kan den öppnas direkt i IDE via Terminal > New Terminal) och kör kommandot:

   ```
   $ aio app run
   ```

1. Det lokala verktyget Resursberäkning öppnas i standardwebbläsaren på __http://localhost:9000__.

   ![aio-appkörning](assets/environment-variables/aio-app-run.png)

1. Se kommandoradsutdata och webbläsaren för felmeddelanden när utvecklingsverktyget initieras.
1. Om du vill stoppa verktyget Resursberäkning trycker du `Ctrl-C` i fönstret som utfördes `aio app run` för att avsluta processen.

## Felsökning

### Felaktigt YAML-indrag

+ __Fel:__ YAMLException: felaktigt indrag för en mappningspost på rad X, kolumn Y:(via standard ut från `aio app run` kommando)
+ __Orsak:__ Yaml-filer är känsliga med vitt mellanrum, vilket kan innebära att indraget är felaktigt.
+ __Upplösning:__ Granska `manifest.yml` och se till att allt indrag är korrekt.

### gränsen för memorySize är för låg

+ __Fel:__  Local Dev Server OpenWhiskError: PUT https://adobeioruntime.net/api/v1/namespaces/xxx-xxx-xxx/actions/xxx-0.0.1/__secured_workeroverwrite=true returnerade HTTP 400 (Ogiltig begäran) —> &quot;Innehållet i begäran hade felaktigt format:krav misslyckades: minne 64 MB under det tillåtna tröskelvärdet 134217728 B&quot;
+ __Orsak:__ En `memorySize` gräns i manifestet angavs under den lägsta tillåtna tröskeln som rapporterades av felmeddelandet i byte.
+ __Upplösning:__  Granska `memorySize` gränserna i `manifest.yml` och se till att alla är större än det lägsta tillåtna tröskelvärdet.