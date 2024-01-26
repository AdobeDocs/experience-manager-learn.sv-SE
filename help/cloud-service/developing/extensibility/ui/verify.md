---
title: Verifiera ett AEM UI-tillägg
description: Lär dig hur du förhandsgranskar, testar och verifierar ett AEM UI-tillägg innan du distribuerar till produktion.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
jira: KT-11603, KT-13382
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: c5c1df23-1c04-4c04-b0cd-e126c31d5acc
duration: 637
source-git-commit: 2a22a1bbe8474b8b7ca95f2b364fd7540b26b894
workflow-type: tm+mt
source-wordcount: '739'
ht-degree: 0%

---

# Verifiera ett tillägg

AEM UI-tillägg kan verifieras mot alla AEM as a Cloud Service miljöer i den Adobe-organisation som tillägget tillhör.

Testning av ett tillägg görs via en URL som skapats för ändamålet och som instruerar AEM att läsa in tillägget, endast för den begäran som skickas.

>[!VIDEO](https://video.tv.adobe.com/v/3412877?quality=12&learn=on)

>[!IMPORTANT]
>
> I videon ovan visas hur ett tillägg till Content Fragment Console används för att illustrera förhandsgranskning och verifiering av apptillägg i App Builder. Det är dock viktigt att komma ihåg att de koncept som omfattas kan tillämpas på alla AEM UI-tillägg.

## AEM URL

![URL för AEM Content Fragment Console](./assets/verify/content-fragment-console-url.png){align="center"}

Om du vill skapa en URL som monterar det icke-producerade tillägget i AEM måste URL:en för det AEM användargränssnittet som tillägget matas in i hämtas. Navigera till den AEM as a Cloud Service miljön för att verifiera tillägget och öppna gränssnittet som tillägget ska förhandsgranskas i.

Om du till exempel vill förhandsgranska ett tillägg för konsolen Innehållsfragment:

1. Logga in på önskad AEM as a Cloud Service-miljö.
2. Välj __Innehållsfragment__ -ikon.
3. Vänta tills AEM Content Fragment Console läses in i webbläsaren.
4. Kopiera URL:en för AEM Content Fragment Console från webbläsarens adressfält. Den ska likna:

   ```
   https://experience.adobe.com/?repo=author-p1234-e5678.adobeaemcloud.com#/@wknd/aem/cf/admin
   ```

Den här URL:en används nedan när du skapar URL:er för utveckling och scenverifiering. Om du verifierar tillägget mot andra AEM UI:er hämtar du dessa URL:er och utför samma steg nedan.

## Verifiera lokala utvecklingsbyggen

1. Öppna en kommandorad i tilläggsprojektets rot.
1. Kör AEM UI-tillägg som en lokal App Builder-app

   ```shell
   $ aio app run
   ...
   No change to package.json was detected. No package manager install will be executed.
   
   To view your local application:
     -> https://localhost:9080
   To view your deployed application in the Experience Cloud shell:
     -> https://experience.adobe.com/?devMode=true#/custom-apps/?localDevUrl=https://localhost:9080
   ```

Observera den lokala URL:en för programmet som visas ovan som `-> https://localhost:9080`

1. Först (och när du ser ett anslutningsfel) öppnas `https://localhost:9080` (eller vilken URL-adress som helst för ditt lokala program) i webbläsaren och acceptera manuellt [HTTPS-certifikatet](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/extension-development/#accepting-the-certificate-first-time-users).
1. Lägg till följande två frågeparametrar i [URL för AEM](#aem-ui-url)
   + `&devMode=true`
   + `&ext=<LOCAL APPLICATION URL>`, vanligtvis `&ext=https://localhost:9080`.

   Lägg till de två ovanstående frågeparametrarna (`devMode` och `ext`) som __först__ frågeparametrar i URL:en. AEM utökningsbart användargränssnitt använder hash-vägar (`#/@wknd/aem/...`), så att parametrarna efterkorrigeras felaktigt efter `#` fungerar inte.

   URL:en för förhandsgranskning ska se ut så här:

   ```
   https://experience.adobe.com/?devMode=true&ext=https://localhost:9080&repo=author-p1234-e5678.adobeaemcloud.com#/@wknd/aem/cf/admin
   ```

2. Kopiera och klistra in URL:en för förhandsgranskning i webbläsaren.

   + Du kan behöva göra det först, och sedan regelbundet, [acceptera HTTPS-certifikatet](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/extension-development/#accepting-the-certificate-first-time-users) för det lokala programmets värd (`https://localhost:9080`).

3. Det AEM användargränssnittet läses in med den lokala versionen av tillägget inmatad i det för verifiering.

>[!IMPORTANT]
>
>Kom ihåg att när du använder den här metoden så påverkar tillägget under utveckling bara din upplevelse, och alla andra användare av AEM gränssnitt upplever användargränssnittet utan det injicerade tillägget.

## Verifiera scenbyggen

1. Öppna en kommandorad i tilläggsprojektets rot.
1. Kontrollera att scenarbetsytan är aktiv (eller den arbetsyta som används för verifiering).

   ```shell
   $ aio app use -w Stage
   ```

   Sammanfoga alla ändringar i `.env` och `.aio`.

1. Distribuera den uppdaterade appen App Builder. Om du inte är inloggad kör du `aio login` först.

   ```shell
   $ aio app deploy
   ...
   Your deployed actions:
   web actions:
     -> https://98765-123aquarat.adobeio-static.net/api/v1/web/aem-cf-console-admin-1/generic 
   To view your deployed application:
     -> https://98765-123aquarat.adobeio-static.net/index.html
   To view your deployed application in the Experience Cloud shell:
     -> https://experience.adobe.com/?devMode=true#/custom-apps/?localDevUrl=https://98765-123aquarat.adobeio-static.net/index.html
   New Extension Point(s) in Workspace 'Production': 'aem/cf-console-admin/1'
   Successful deployment 🏄
   ```

1. Lägg till följande två frågeparametrar i [URL för AEM](#aem-ui-url)
   + `&devMode=true`
   + `&ext=<DEPLOYED APPLICATION URL>`

   Lägg till de två ovanstående frågeparametrarna (`devMode` och `ext`) som __först__ frågeparametrar i URL:en, eftersom utökningsbara gränssnitt AEM använder en hash-väg (`#/@wknd/aem/...`), så att parametrarna efterkorrigeras felaktigt efter `#` fungerar inte.

   URL:en för förhandsgranskning ska se ut så här:

   ```
   https://experience.adobe.com/?devMode=true&ext=https://98765-123aquarat.adobeio-static.net/index.html&repo=author-p1234-e5678.adobeaemcloud.com#/@wknd/aem/cf/admin
   ```

1. Kopiera och klistra in URL:en för förhandsgranskning i webbläsaren.
1. AEM Content Fragment Console injicerar den version av tillägget som distribueras till scenarbetsytan i. Denna scen-URL kan delas med QA- eller företagsanvändare för verifiering.

Kom ihåg att när du använder den här metoden injiceras tillägget Mellanlagring bara på AEM Content Fragment Console när du får tillgång till den här programmeringsscenens URL.

1. Distribuerade tillägg kan uppdateras genom att köra `aio app deploy` igen, och dessa ändringar återspeglas automatiskt när du använder URL:en för förhandsgranskning.
1. Om du vill ta bort ett tillägg för verifiering kör du `aio app undeploy`.

## Förhandsgranska bokmärkesdiagram

För att förenkla skapandet av förhandsgransknings- och förhandsgransknings-URL:er som beskrivs ovan kan ett JavaScript-bokmärke som läser in tillägget skapas.

Bokmärket nedan förhandsvisar [lokala utvecklingsverktyg](#verify-local-development-builds) för tillägget på `https://localhost:9080`. Förhandsgranska [scenbyggen](#verify-stage-builds), skapa ett bokmärkesdiagram med `previewApp` variabeln inställd på URL:en för den distribuerade appen App Builder.

1. Skapa ett bokmärke i webbläsaren.
2. Redigera bokmärket.
3. Ge ett bokmärke ett beskrivande namn, till exempel `AEM UI Extension Preview (localhost:9080)`.
4. Ställ in bokmärkets URL till följande kod:

   ```javascript
   javascript: (() => {
       /* Change this to the URL of the local App Builder app if not using https://localhost:9080 */
       const previewApp = 'https://localhost:9080';
   
       const repo = new URL(window.location.href).searchParams.get('repo');
   
       if (window.location.href.match(/https:\/\/experience\.adobe\.com\/.*\/aem\/cf\/(editor|admin)\/.*/i)) {
           window.location = `https://experience.adobe.com/?devMode=true&ext=${previewApp}&repo=${repo}${window.location.hash}`;
       } 
   })();
   ```

5. Navigera till ett utökningsbart AEM för att läsa in förhandsvisningstillägget och klicka sedan på bokmärkesdiagrammet.

>[!TIP]
>
> Om App Builder-tillägget inte läses in när du använder `&ext=https://localhost:9080`, öppna värden och porten direkt på en webbläsarflik och acceptera det självsignerade certifikatet. Prova sedan bokmärket igen.
