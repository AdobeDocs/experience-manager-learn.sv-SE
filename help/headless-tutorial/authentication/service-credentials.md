---
title: Tjänstautentiseringsuppgifter
description: AEM Service Credentials används för att underlätta för externa program, system och tjänster att programmässigt interagera med AEM Author eller Publish services via HTTP.
version: cloud-service
doc-type: tutorial
topics: Development, Security
feature: API:er
activity: develop
audience: developer
kt: 6785
thumbnail: 330519.jpg
topic: '"Headless, integrations"'
role: Developer
level: '"Intermediera, erfarna"'
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '1830'
ht-degree: 0%

---


# Tjänstautentiseringsuppgifter

Integrationer med AEM som Cloud Service måste kunna autentiseras säkert till AEM. AEM Developer Console ger åtkomst till tjänstens autentiseringsuppgifter, som används för att underlätta för externa program, system och tjänster att programmässigt interagera med AEM Author eller Publish services via HTTP.

>[!VIDEO](https://video.tv.adobe.com/v/330519/?quality=12&learn=on)

Tjänstautentiseringsuppgifter kan se ut som [token för lokal utvecklingsåtkomst](./local-development-access-token.md), men skiljer sig på några viktiga sätt:

+ Tjänstautentiseringsuppgifterna är _inte_ åtkomsttokens, utan de är autentiseringsuppgifter som används för att _hämta_-åtkomsttoken.
+ Autentiseringsuppgifterna för tjänsten är mer permanenta (upphör att gälla var 365:e dag) och ändras inte om de inte återkallas, medan token för lokal utvecklingsåtkomst upphör att gälla dagligen.
+ Tjänstautentiseringsuppgifter för en AEM som en Cloud Service-miljömappning till en enskild AEM-användare, medan Local Development Access-token autentiseras som den AEM användare som genererade åtkomsttoken.

Både tjänstautentiseringsuppgifter och åtkomsttoken som de genererar, liksom token för lokal utvecklingsåtkomst, bör hållas hemliga eftersom alla tre kan användas för att få åtkomst till sina respektive AEM som en Cloud Service-miljö

## Generera autentiseringsuppgifter för tjänsten

Generering av servicereferenser delas upp i två steg:

1. En engångsinitiering av tjänstens autentiseringsuppgifter av en Adobe IMS-organisationsadministratör
1. Hämtning och användning av JSON för tjänstautentiseringsuppgifter

### Initiering av tjänstautentiseringsuppgifter

Till skillnad från Local Development Access-token krävs en _engångsininitiering_ av IMS-administratören för Adobe-organisationen innan de kan hämtas.

![Initiera autentiseringsuppgifter för tjänsten](assets/service-credentials/initialize-service-credentials.png)

__Detta är en engångsinitiering per AEM som en Cloud Service-miljö__

1. Se till att du är inloggad som Adobe IMS-organisationens administratör
1. Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com)
1. Öppna programmet som innehåller AEM som en Cloud Service-miljö för att integrera inställningarna för tjänsten
1. Tryck på ellipsen bredvid miljön i __Miljön__-avsnittet och välj __Utvecklarkonsol__
1. Tryck på fliken __Integreringar__
1. Tryck på knappen __Hämta tjänstinloggningsuppgifter__
1. Tjänstautentiseringsuppgifterna initieras och visas som JSON

![AEM Developer Console - Integreringar - Hämta tjänstautentiseringsuppgifter](./assets/service-credentials/developer-console.png)

När AEM som Cloud Service-miljöns tjänstautentiseringsuppgifter har initierats kan andra AEM i din Adobe IMS-organisation hämta dem.

### Hämta tjänstens autentiseringsuppgifter

![Hämta tjänstens autentiseringsuppgifter](assets/service-credentials/download-service-credentials.png)

När du hämtar tjänstens autentiseringsuppgifter följer du samma steg som initieringen. Om initieringen ännu inte har utförts visas ett fel för användaren när användaren trycker på knappen __Hämta inloggningsuppgifter__.

1. Kontrollera att du är medlem i __Cloud Manager - Developer__ IMS-produktprofilen (som ger åtkomst till AEM Developer Console)
   + För sandlådevisning som Cloud Service-miljöer krävs endast medlemskap i antingen __AEM Administrators__ eller __AEM Användare__ produktprofil
1. Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com)
1. Öppna programmet som innehåller AEM som en Cloud Service-miljö att integrera med
1. Tryck på ellipsen bredvid miljön i __Miljön__-avsnittet och välj __Utvecklarkonsol__
1. Tryck på fliken __Integreringar__
1. Tryck på knappen __Hämta tjänstinloggningsuppgifter__
1. Tryck på nedladdningsknappen i det övre vänstra hörnet om du vill hämta JSON-filen som innehåller värdet för tjänstens autentiseringsuppgifter och spara filen på en säker plats.
   + _Om inloggningsuppgifterna är i konflikt kontaktar du Adobe Support omedelbart för att få dem återkallade_

## Installera tjänstens autentiseringsuppgifter

Tjänstautentiseringsuppgifterna innehåller den information som behövs för att generera en JWT, som byts ut mot en åtkomsttoken som används för att autentisera med AEM som Cloud Service. Tjänstinloggningsuppgifterna måste lagras på en säker plats som är tillgänglig för externa program, system eller tjänster som använder dem för att få åtkomst till AEM. Hur och var serviceautentiseringsuppgifterna hanteras är unika per kund.

För enkelhetens skull skickar den här självstudiekursen in inloggningsuppgifterna via kommandoraden, men arbeta med IT-säkerhetsteamet för att förstå hur dessa uppgifter ska lagras och användas i enlighet med organisationens säkerhetsriktlinjer.

1. Kopiera [JSON](#download-service-credentials) för tjänstinloggningsuppgifter till en fil med namnet `service_token.json` i projektets rot
   + Men kom ihåg att aldrig binda några referenser till Git!

## Använd tjänstens autentiseringsuppgifter

Tjänstautentiseringsuppgifterna, som är ett fullständigt JSON-objekt, är inte samma som JWT eller åtkomsttoken. I stället används tjänstens autentiseringsuppgifter (som innehåller en privat nyckel) för att generera en JWT, som byts ut mot Adobe IMS API:er för en åtkomsttoken.

![Tjänstautentiseringsuppgifter - externt program](assets/service-credentials/service-credentials-external-application.png)

1. Hämta tjänstautentiseringsuppgifterna från AEM Developer Console till en säker plats
1. Ett externt program behöver programmässigt interagera med AEM som en Cloud Service-miljö
1. Det externa programmet läser i tjänstens autentiseringsuppgifter från en säker plats
1. Det externa programmet använder information från tjänstens autentiseringsuppgifter för att skapa en JWT-token
1. JWT-token skickas till Adobe IMS för utbyte mot en åtkomsttoken
1. Adobe IMS returnerar en åtkomsttoken som kan användas för att komma åt AEM som en Cloud Service
   + Åtkomsttoken kan ha en förfallotid begärd. Det är bäst att hålla åtkomsttoken så kort som möjligt och uppdatera vid behov.
1. Det externa programmet gör HTTP-begäranden som AEM som en Cloud Service och lägger till åtkomsttoken som en Bearer-token i HTTP-begärandes auktoriseringshuvud
1. AEM som en Cloud Service tar emot HTTP-begäran, autentiserar begäran och utför det arbete som begärdes av HTTP-begäran och returnerar ett HTTP-svar till det externa programmet

### Uppdateringar till det externa programmet

För att få åtkomst till AEM som Cloud Service med hjälp av tjänstens autentiseringsuppgifter måste vårt externa program uppdateras på tre sätt:

1. Läs i tjänstens autentiseringsuppgifter
   + För enkelhetens skull läser vi dessa från den hämtade JSON-filen, men i realtidsscenarier måste inloggningsuppgifterna lagras på ett säkert sätt i enlighet med organisationens säkerhetsriktlinjer
1. Generera en JWT från tjänstens autentiseringsuppgifter
1. Byt ut JWT för en åtkomsttoken
   + När tjänstautentiseringsuppgifter finns använder vårt externa program denna åtkomsttoken i stället för den lokala utvecklingsåtkomsttoken när AEM används som Cloud Service

I den här självstudiekursen används Adobe `@adobe/jwt-auth` npm-modulen för att både (1) generera JWT från tjänstens autentiseringsuppgifter och (2) byta ut det mot en åtkomsttoken i ett enda funktionsanrop. Om ditt program inte är JavaScript-baserat ska du granska [exempelkoden på andra språk](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/JWT/samples/samples.md) för att se hur du skapar en JWT utifrån tjänstens autentiseringsuppgifter och byta ut den mot en åtkomsttoken med Adobe IMS.

## Läs autentiseringsuppgifterna för tjänsten

Granska `getCommandLineParams()` och se att vi kan läsa JSON-filer för tjänstinloggning med samma kod som används för att läsa i JSON-token för lokal utvecklingsåtkomst.

```javascript
function getCommandLineParams() {
    ...

    // Read in the credentials from the provided JSON file
    // Since both the Local Development Access Token and Service Credentials files are JSON, this same approach can be re-used
    if (parameters.file) {
        parameters.developerConsoleCredentials = JSON.parse(fs.readFileSync(parameters.file));
    }

    ...
    return parameters;
}
```

## Skapa en JWT och byt ut mot en Access-token

När tjänstinloggningsuppgifterna har lästs används de för att generera en JWT som sedan byts ut mot API:er för Adobe IMS för en åtkomsttoken, som sedan kan användas för att komma åt AEM som en Cloud Service.

Exempelprogrammet är Node.js-baserat, så det är bäst att använda [@adobe/jwt-auth](https://www.npmjs.com/package/@adobe/jwt-auth) npm-modulen för att underlätta (1) JWT-generering och (20 utbyte med Adobe IMS. Om ditt program har utvecklats på ett annat språk bör du läsa [de lämpliga kodexemplen](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/JWT/samples/samples.md) för att konstruera HTTP-begäran för Adobe IMS med andra programmeringsspråk.

1. Uppdatera `getAccessToken(..)` för att inspektera JSON-filens innehåll och kontrollera om den representerar en lokal utvecklingstoken eller tjänstautentiseringsuppgifter. Detta kan du enkelt göra genom att kontrollera om egenskapen `.accessToken` finns, som bara finns för Local Development Access Token JSON.

   Om tjänstautentiseringsuppgifter anges genererar programmet en JWT och byter ut den mot Adobe IMS för en åtkomsttoken. Vi använder [@adobe/jwt-auth](https://www.npmjs.com/package/@adobe/jwt-auth)-funktionen `auth(...)` som båda genererar en JWT och byter ut den mot en åtkomsttoken i ett enda funktionsanrop.  Parametrarna för `auth(..)` är ett [JSON-objekt som består av specifik information](https://www.npmjs.com/package/@adobe/jwt-auth#config-object) som är tillgänglig från JSON för tjänstinloggningsuppgifter, vilket beskrivs nedan i koden.

   ```javascript
    async function getAccessToken(developerConsoleCredentials) {
   
        if (developerConsoleCredentials.accessToken) {
            // This is a Local Development access token
            return developerConsoleCredentials.accessToken;
        } else {
            // This is the Service Credentials JSON object that must be exchanged with Adobe IMS for an access token
            let serviceCredentials = developerConsoleCredentials.integration;
   
            // Use the @adobe/jwt-auth library to pass the service credentials generated a JWT and exchange that with Adobe IMS for an access token.
            // If other programming languages are used, please see these code samples: https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/JWT/samples/samples.md
            let { access_token } = await auth({
                clientId: serviceCredentials.technicalAccount.clientId, // Client Id
                technicalAccountId: serviceCredentials.id,              // Technical Account Id
                orgId: serviceCredentials.org,                          // Adobe IMS Org Id
                clientSecret: serviceCredentials.technicalAccount.clientSecret, // Client Secret
                privateKey: serviceCredentials.privateKey,              // Private Key to sign the JWT
                metaScopes: serviceCredentials.metascopes.split(','),   // Meta Scopes defining level of access the access token should provide
                ims: `https://${serviceCredentials.imsEndpoint}`,       // IMS endpoint used to obtain the access token from
            });
   
            return access_token;
        }
    }
   ```

   Beroende på vilken JSON-fil (Local Development Access Token JSON eller Service Credentials JSON) som skickas via kommandoradsparametern `file`, kommer programmet att erhålla en åtkomsttoken.

   Kom ihåg att även om inloggningsuppgifterna inte upphör att gälla så måste JWT och motsvarande åtkomsttoken uppdateras innan de går ut. Detta kan du göra genom att använda en `refresh_token` [som tillhandahålls av Adobe IMS](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/OAuth/OAuth.md#access-tokens).

1. När dessa ändringar är på plats och JSON för tjänstreferenser har hämtats från AEM Developer Console (och för enkelhetens skull, sparats som `service_token.json` samma mapp som denna `index.js`) kör du programmet som ersätter kommandoradsparametern `file` med `service_token.json` och uppdaterar `propertyValue` till ett nytt värde så att effekterna syns i AEM.

   ```shell
   $ node index.js \
       aem=https://author-p1234-e5678.adobeaemcloud.com \
       folder=/wknd/en/adventures/napa-wine-tasting \
       propertyName=metadata/dc:rights \
       propertyValue="WKND Restricted Use" \
       file=service_token.json
   ```

   Utdata till terminalen ser ut så här:

   ```shell
   200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting.json
   403 - Forbidden @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_277654931.jpg.json
   403 - Forbidden @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_239751461.jpg.json
   403 - Forbidden @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_280313729.jpg.json
   403 - Forbidden @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_286664352.jpg.json
   ```

   Raderna __403 - Otillåten__ anger fel i HTTP API-anropen som ska AEM som Cloud Service. Dessa 403 får inte förekomma när metadata för resurserna uppdateras.

   Orsaken till detta är att en åtkomsttoken härledd till tjänsten autentiserar begäran till AEM med ett automatiskt skapat tekniskt konto AEM användaren, som som standard endast har läsåtkomst. För att ge programmet skrivåtkomst till AEM måste det tekniska konto AEM användare som är associerad med åtkomsttoken beviljas behörighet i AEM.

## Konfigurera åtkomst i AEM

Tjänstinloggningshärledd åtkomsttoken använder ett tekniskt konto AEM Användare som har medlemskap i AEM användargruppen.

![Tjänstautentiseringsuppgifter - Tekniskt konto AEM användare](./assets/service-credentials/technical-account-user.png)

När det tekniska kontot AEM användaren finns i AEM (efter den första HTTP-begäran med åtkomsttoken) kan den här AEM användarens behörigheter hanteras på samma sätt som andra AEM.

1. Leta först reda på det tekniska kontots AEM inloggningsnamn genom att öppna JSON för tjänstinloggning som hämtats från AEM Developer Console och leta reda på `integration.email`-värdet, som ska se ut ungefär så här: `12345678-abcd-9000-efgh-0987654321c@techacct.adobe.com`.
1. Logga in på motsvarande AEM författartjänst som AEM administratör
1. Navigera till __Verktyg__ > __Säkerhet__ > __Användare__
1. Leta reda på den AEM användaren med __inloggningsnamnet__ som identifieras i steg 1 och öppna dess __egenskaper__
1. Navigera till fliken __Grupper__ och lägg till gruppen __DAM-användare__ (som skrivåtkomst till resurser)
1. Tryck på __Spara och stäng__

Med det tekniska kontot i AEM behörighet att skriva till resurser kör du programmet igen:

```shell
$ node index.js \
    aem=https://author-p1234-e5678.adobeaemcloud.com \
    folder=/wknd/en/adventures/napa-wine-tasting \
    propertyName=metadata/dc:rights \
    propertyValue="WKND Restricted Use" \
    file=service_token.json
```

Utdata till terminalen ser ut så här:

```
200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting.json
200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_277654931.jpg.json
200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_286664352.jpg.json
200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_239751461.jpg.json
200 - OK @ https://author-p1234-e5678.adobeaemcloud.com/api/assets/wknd/en/adventures/napa-wine-tasting/AdobeStock_280313729.jpg.json
```

## Verifiera ändringarna

1. Logga in i AEM som en uppdaterad Cloud Service (med samma värdnamn som finns i kommandoradsparametern `aem`)
1. Navigera till __Resurser__ > __Filer__
1. Navigera till den resursmapp som anges av kommandoradsparametern `folder`, till exempel __WKND__ > __Engelska__ > __Adventures__ > __Napa Wine Tasting__
1. Öppna __Egenskaperna__ för en resurs i mappen
1. Gå till fliken __Avancerat__
1. Granska värdet för den uppdaterade egenskapen, till exempel __Copyright__ som är mappad till den uppdaterade JCR-egenskapen `metadata/dc:rights`, som nu återspeglar värdet som anges i parametern `propertyValue`, till exempel __WKND begränsad användning__

![WKND - metadatauppdatering med begränsad användning](./assets/service-credentials/asset-metadata.png)

## Grattis!

Nu när vi programmatiskt har kommit åt AEM som Cloud Service med hjälp av en lokal åtkomsttoken för utveckling, liksom en produktionsklar åtkomsttoken för tjänst-till-tjänst!

