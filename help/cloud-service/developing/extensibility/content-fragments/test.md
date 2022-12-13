---
title: Testa ett AEM Content Fragment-konsoltillägg
description: Lär dig hur du testar ett AEM Content Fragment-konsoltillägg innan du distribuerar till produktion.
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay, noCatalog
kt: 11603
last-substantial-update: 2022-12-01T00:00:00Z
source-git-commit: a7b32982b547eb292384d2ebde80ba745091702a
workflow-type: tm+mt
source-wordcount: '514'
ht-degree: 0%

---


# Testa ett tillägg

AEM Content Fragment Console-tillägg kan testas mot alla AEM as a Cloud Service miljöer i den Adobe organisation som tillägget tillhör.

Testning av ett tillägg görs via en URL som skapats för ändamålet och som instruerar konsolen AEM innehållsfragment att läsa in tillägget.

## URL för AEM Content Fragment Console

![URL för AEM Content Fragment Console](./assets/test/content-fragment-console-url.png){align="center"}

Om du vill skapa en URL som monterar icke-produktionstillägget i en AEM Content Fragment Console måste URL:en för den önskade AEM Content Fragment Console samlas in. Navigera till den AEM as a Cloud Service miljön för att testa tillägget på och kopiera URL:en för dess AEM Content Fragment Console.

1. Logga in på önskad AEM as a Cloud Service-miljö.

   + Använd en AEM utvecklingsmiljö för [testa utvecklingsbyggen](#testing-development-builds)
   + Använd AEM Stage eller QA Development Environment för [byggen för testfasen](#testing-stage-builds)

1. Välj __Innehållsfragment__ ikon.
1. Vänta tills AEM Content Fragment Console läses in i webbläsaren.
1. Kopiera URL:en för AEM Content Fragment Console från webbläsarens adressfält. Den ska likna:

   ```
   https://experience.adobe.com/?repo=author-p1234-e5678.adobeaemcloud.com#/@wknd/aem/cf/admin
   ```

Den här URL:en används nedan när du skapar URL:er för utveckling och scentestning.

## Testa lokala utvecklingsbyggen

1. Öppna en kommandorad i tilläggsprojektets rot.
1. Kör AEM Content Fragment Console-tillägget som en lokal app i App Builder

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

1. Lägg till följande två frågeparametrar i [URL för AEM Content Fragment Console](#aem-content-fragment-console-url)
   + `&devMode=true`
   + `&ext=<LOCAL APPLICATION URL>`, vanligtvis `&ext=https://localhost:9080`.

   Test-URL:en ska se ut så här:

   ```
   https://experience.adobe.com/?repo=author-p1234-e5678.adobeaemcloud.com#/@wknd/aem/cf/admin&devMode=true&ext=https://localhost:9080
   ```

1. Kopiera och klistra in test-URL:en i webbläsaren.

   + Du kan behöva göra det först, och sedan måste du med jämna mellanrum [acceptera HTTPS-certifikatet](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/extension-development/#accepting-the-certificate-first-time-users) för det lokala programmets värd (`https://localhost:9080`).

1. AEM Content Fragment Console läses in med den lokala versionen av tillägget insatt i den för testning och ändringar som kan läsas in under tiden som den lokala appen App Builder körs.

När du använder den här metoden påverkar tillägget under utveckling bara din upplevelse, och alla andra användare av konsolen AEM innehållsfragment får åtkomst till det utan det injicerade tillägget.

## Testa scenbyggen

1. Öppna en kommandorad i tilläggsprojektets rot.
1. Kontrollera att scenarbetsytan är aktiv (eller någon annan arbetsyta som används för testning).

   ```shell
   $ aio app use -w Stage
   ```
   Sammanfoga alla ändringar i `.env` och `.aio`.
1. Distribuera det uppdaterade tillägget i appen App Builder. Om du inte är inloggad kör du `aio login` först.

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

1. Lägg till följande två frågeparametrar i [URL för AEM Content Fragment Console](#aem-content-fragment-console-url)
   + `&devMode=true`
   + `&ext=<DEPLOYED APPLICATION URL>`

   Test-URL:en ska se ut så här:

   ```
   https://experience.adobe.com/?repo=author-p1234-e5678.adobeaemcloud.com#/@wknd/aem/cf/admin&devMode=true&ext=https://98765-123aquarat.adobeio-static.net/index.html
   ```

1. Kopiera och klistra in test-URL:en i webbläsaren.
1. AEM Content Fragment Console injicerar den version av tillägget som distribueras till scenarbetsytan i. Denna scen-URL kan delas med QA- eller företagsanvändare för testning.

Kom ihåg att när du använder den här metoden injiceras tillägget Mellanlagring bara på AEM Content Fragment Console när du får tillgång till den här programmeringsscenens URL.

1. Distribuerade tillägg kan uppdateras genom att köra `aio app deploy` och dessa ändringar återspeglas automatiskt när test-URL:en används.
1. Om du vill ta bort ett tillägg för testning kör du `aio app undeploy`.



