---
title: AEM autentiseringsuppgifter för tjänsten Developer Console
description: AEM Service Credentials används för att underlätta för externa program, system och tjänster att programmässigt interagera med AEM Author eller Publish services via HTTP.
version: Cloud Service
doc-type: tutorial
topics: Development, Security
feature: APIs
activity: develop
audience: developer
kt: 6785
thumbnail: 330519.jpg
topic: Headless, Integrations
role: Developer
level: Intermediate, Experienced
exl-id: e2922278-4d0b-4f28-a999-90551ed65fb4
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '1901'
ht-degree: 0%

---

# Autentiseringsuppgifter för tjänsten

Integrationer med AEM as a Cloud Service måste kunna autentiseras säkert till AEM. AEM Developer Console ger åtkomst till tjänstens autentiseringsuppgifter, som används för att underlätta för externa program, system och tjänster att programmässigt interagera med AEM Author eller Publish services via HTTP.

>[!VIDEO](https://video.tv.adobe.com/v/330519/?quality=12&learn=on)

Tjänstautentiseringsuppgifterna kan se ut som liknande [Åtkomsttoken för lokal utveckling](./local-development-access-token.md) men skiljer sig på några viktiga sätt:

+ Tjänstautentiseringsuppgifterna är _not_ få åtkomst till tokens, i stället för att vara inloggningsuppgifter som används för _hämta_ åtkomsttoken.
+ Autentiseringsuppgifterna för tjänsten är mer permanenta (upphör att gälla var 365:e dag) och ändras inte om de inte återkallas, medan token för lokal utvecklingsåtkomst upphör att gälla dagligen.
+ Tjänstautentiseringsuppgifter för en AEM as a Cloud Service miljö mappas till en enskild AEM användare, medan Local Development Access-token autentiseras som den AEM användaren som genererade åtkomsttoken.
+ En AEM as a Cloud Service miljö har en Service Credentials som mappar till ett tekniskt konto AEM användare. Tjänstautentiseringsuppgifter kan inte användas för att autentisera till samma AEM as a Cloud Service miljö som andra tekniska AEM.

Både tjänstens autentiseringsuppgifter och de åtkomsttoken som de genererar, liksom token för lokal utvecklingsåtkomst, bör hållas hemliga eftersom alla tre kan användas för att få åtkomst till sina respektive AEM as a Cloud Service miljöer

## Generera autentiseringsuppgifter för tjänsten

Generering av servicereferenser delas upp i två steg:

1. En engångstjänstinloggningsinitiering av en Adobe IMS-organisationsadministratör
1. Hämtning och användning av JSON för tjänstautentiseringsuppgifter

### Initiering av tjänstautentiseringsuppgifter

Tjänstautentiseringsuppgifter, till skillnad från token för lokal utvecklingsåtkomst, kräver en _engångsinitiering_ av din IMS-administratör för Adobe Org innan de kan hämtas.

![Initiera autentiseringsuppgifter för tjänsten](assets/service-credentials/initialize-service-credentials.png)

__Detta är en engångsinitiering per AEM as a Cloud Service miljö__

1. Se till att du är inloggad som:
   + Din Adobe IMS-organisations administratör
   + Medlem i __Cloud Manager - utvecklare__ IMS-produktprofil
   + Medlem i __AEM__ eller __AEM administratörer__ IMS-produktprofil på __AEM Author__
1. Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com)
1. Öppna programmet som innehåller den AEM as a Cloud Service miljön för att integrera inställningarna för tjänstens autentiseringsuppgifter för
1. Tryck på ellipsen bredvid omgivningen i __Miljö__ och markera __Developer Console__
1. Tryck på __Integreringar__ tab
1. Tryck __Hämta tjänstautentiseringsuppgifter__ knapp
1. Tjänstautentiseringsuppgifterna initieras och visas som JSON

![AEM Developer Console - Integreringar - Hämta tjänstautentiseringsuppgifter](./assets/service-credentials/developer-console.png)

När AEM som Cloud Service-miljöns tjänstautentiseringsuppgifter har initierats kan andra AEM i din Adobe IMS-organisation hämta dem.

### Hämta tjänstens autentiseringsuppgifter

![Hämta tjänstens autentiseringsuppgifter](assets/service-credentials/download-service-credentials.png)

När du hämtar tjänstens autentiseringsuppgifter följer du samma steg som initieringen. Om initieringen ännu inte har utförts visas ett fel när användaren trycker på __Hämta tjänstautentiseringsuppgifter__ -knappen.

1. Se till att du är inloggad som:
   + Medlem i __Cloud Manager - utvecklare__ IMS-produktprofil (som ger åtkomst till AEM Developer Console)
      + För as a Cloud Service sandlådemiljöer krävs inte detta  __Cloud Manager - utvecklare__ medlemskap
   + Medlem i __AEM__ eller __AEM administratörer__ IMS-produktprofil på __AEM Author__
1. Logga in på [Adobe Cloud Manager](https://my.cloudmanager.adobe.com)
1. Öppna programmet som innehåller den AEM as a Cloud Service miljön att integrera med
1. Tryck på ellipsen bredvid omgivningen i __Miljö__ och markera __Developer Console__
1. Tryck på __Integreringar__ tab
1. Tryck __Hämta tjänstautentiseringsuppgifter__ knapp
1. Tryck på nedladdningsknappen i det övre vänstra hörnet om du vill hämta JSON-filen som innehåller värdet för tjänstens autentiseringsuppgifter och spara filen på en säker plats.
   + _Om inloggningsuppgifterna är i konflikt kontaktar du Adobe Support omedelbart för att få dem återkallade_

## Installera tjänstens autentiseringsuppgifter

Tjänstautentiseringsuppgifterna innehåller den information som behövs för att generera en JWT, som byts ut mot en åtkomsttoken som används för att autentisera med AEM as a Cloud Service. Tjänstinloggningsuppgifterna måste lagras på en säker plats som är tillgänglig för externa program, system eller tjänster som använder dem för att få åtkomst till AEM. Hur och var serviceautentiseringsuppgifterna hanteras är unika per kund.

För enkelhetens skull skickar den här självstudiekursen in inloggningsuppgifterna via kommandoraden, men arbeta med IT-säkerhetsteamet för att förstå hur dessa uppgifter ska lagras och användas i enlighet med organisationens säkerhetsriktlinjer.

1. Kopiera [hämtade JSON för tjänstinloggningsuppgifter](#download-service-credentials) till en fil med namnet `service_token.json` i projektets rot
   + Men kom ihåg att aldrig binda några referenser till Git!

## Använd tjänstens autentiseringsuppgifter

Tjänstautentiseringsuppgifterna, som är ett fullständigt JSON-objekt, är inte samma som JWT eller åtkomsttoken. I stället används tjänstens autentiseringsuppgifter (som innehåller en privat nyckel) för att generera en JWT, som byts ut mot Adobe IMS API:er för en åtkomsttoken.

![Tjänstautentiseringsuppgifter - externt program](assets/service-credentials/service-credentials-external-application.png)

1. Hämta tjänstautentiseringsuppgifterna från AEM Developer Console till en säker plats
1. Ett externt program behöver programmera interaktion med AEM as a Cloud Service miljöer
1. Det externa programmet läser i tjänstens autentiseringsuppgifter från en säker plats
1. Det externa programmet använder information från tjänstens autentiseringsuppgifter för att skapa en JWT-token
1. JWT-token skickas till Adobe IMS för utbyte mot en åtkomsttoken
1. Adobe IMS returnerar en åtkomsttoken som kan användas för att komma åt AEM as a Cloud Service
   + Åtkomsttoken kan ha en förfallotid begärd. Det är bäst att hålla åtkomsttoken så kort som möjligt och uppdatera vid behov.
1. Det externa programmet gör HTTP-begäranden till AEM as a Cloud Service och lägger till åtkomsttoken som en Bearer-token i HTTP-begäransens auktoriseringshuvud
1. AEM as a Cloud Service tar emot HTTP-begäran, autentiserar begäran och utför det arbete som begärdes av HTTP-begäran och returnerar ett HTTP-svar till det externa programmet

### Uppdateringar till det externa programmet

För att komma åt AEM as a Cloud Service med hjälp av tjänstens autentiseringsuppgifter måste vårt externa program uppdateras på tre sätt:

1. Läs i tjänstens autentiseringsuppgifter
   + För enkelhetens skull läser vi dessa från den hämtade JSON-filen, men i realtidsscenarier måste inloggningsuppgifterna lagras på ett säkert sätt i enlighet med organisationens säkerhetsriktlinjer
1. Generera en JWT från tjänstens autentiseringsuppgifter
1. Byt ut JWT för en åtkomsttoken
   + När det finns inloggningsuppgifter använder vårt externa program denna åtkomsttoken i stället för den lokala utvecklingsåtkomsttoken vid åtkomst till AEM as a Cloud Service

I den här självstudiekursen, Adobe `@adobe/jwt-auth` npm-modulen används för att både (1) generera JWT från tjänstens autentiseringsuppgifter och (2) byta ut det mot en åtkomsttoken i ett enda funktionsanrop. Om ditt program inte är JavaScript-baserat kan du läsa [exempelkod på andra språk](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/JWT/samples/samples.md) om du vill veta hur du skapar en JWT-fil från tjänstens autentiseringsuppgifter och byter ut den mot en åtkomsttoken med Adobe IMS.

## Läs autentiseringsuppgifterna för tjänsten

Granska `getCommandLineParams()` och se att vi kan läsa JSON-filer för tjänstinloggningsuppgifter med samma kod som används för att läsa i JSON-token för lokal utvecklingsåtkomst.

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

När tjänstens autentiseringsuppgifter läses används de för att generera en JWT som sedan byts ut mot Adobe IMS API:er för en åtkomsttoken, som sedan kan användas för att få åtkomst AEM as a Cloud Service.

Det här exempelprogrammet är Node.js-baserat, så det är bäst att använda [@adobe/jwt-auth](https://www.npmjs.com/package/@adobe/jwt-auth) npm-modulen för att underlätta (1) JWT-generering och (20 utbyte med Adobe IMS. Om ditt program har utvecklats på ett annat språk kan du granska [lämpliga kodexempel](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/JWT/samples/samples.md) om hur du konstruerar HTTP-begäran till Adobe IMS med andra programmeringsspråk.

1. Uppdatera `getAccessToken(..)` om du vill inspektera JSON-filens innehåll och avgöra om den representerar en Local Development Access-token eller tjänstautentiseringsuppgifter. Detta kan enkelt uppnås genom att kontrollera om `.accessToken` som bara finns för JSON för Local Development Access-token.

   Om Service Credentials anges genererar programmet en JWT och byter ut den mot Adobe IMS för en åtkomsttoken. Vi använder [@adobe/jwt-auth](https://www.npmjs.com/package/@adobe/jwt-auth)&#39;s `auth(...)` som båda genererar en JWT och byter ut den mot en åtkomsttoken i ett enda funktionsanrop.  Parametrarna till `auth(..)` är en [JSON-objekt som består av specifik information](https://www.npmjs.com/package/@adobe/jwt-auth#config-object) som finns i JSON för tjänstinloggningsuppgifter, vilket beskrivs nedan i koden.

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

   Beroende på vilken JSON-fil (Local Development Access Token JSON eller Service Credentials JSON) som skickas via den `file` kommandoradsparametern, kommer programmet att erhålla en åtkomsttoken.

   Kom ihåg att medan tjänstens autentiseringsuppgifter upphör att gälla var 365:e dag, upphör JWT och motsvarande åtkomsttoken att gälla ofta och måste uppdateras innan de går ut. Detta kan du göra genom att använda en `refresh_token` [från Adobe IMS](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/OAuth/OAuth.md#access-tokens).

1. När dessa ändringar är på plats och tjänstens inloggningsuppgifter har JSON hämtats från AEM Developer Console (och för enkelhetens skull, sparats som `service_token.json` samma mapp som `index.js`), kör programmet som ersätter kommandoradsparametern `file` med `service_token.json`och uppdatera `propertyValue` till ett nytt värde så att effekterna syns i AEM.

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

   The __403 - Ej tillåtet__ rader, indikerar fel i HTTP API-anrop till AEM as a Cloud Service. Dessa 403 får inte förekomma när metadata för resurserna uppdateras.

   Orsaken till detta är att en åtkomsttoken härledd till tjänsten autentiserar begäran till AEM med ett automatiskt skapat tekniskt konto AEM användaren, som som standard endast har läsåtkomst. För att ge programmet skrivåtkomst till AEM måste det tekniska konto AEM användare som är associerad med åtkomsttoken beviljas behörighet i AEM.

## Konfigurera åtkomst i AEM

Tjänstinloggningshärledd åtkomsttoken använder ett tekniskt konto AEM Användare som har medlemskap i AEM användargruppen.

![Tjänstautentiseringsuppgifter - Tekniskt konto AEM användare](./assets/service-credentials/technical-account-user.png)

När det tekniska kontot AEM användaren finns i AEM (efter den första HTTP-begäran med åtkomsttoken) kan den här AEM användarens behörigheter hanteras på samma sätt som andra AEM.

1. Leta först reda på det tekniska kontots AEM inloggningsnamn genom att öppna JSON för tjänstinloggning som hämtats från AEM Developer Console och leta upp `integration.email` värde, som ska se ut ungefär så här: `12345678-abcd-9000-efgh-0987654321c@techacct.adobe.com`.
1. Logga in på motsvarande AEM författartjänst som AEM administratör
1. Navigera till __verktyg__ > __Säkerhet__ > __Användare__
1. Hitta AEM användare med __Inloggningsnamn__ identifieras i steg 1 och öppnar __Egenskaper__
1. Navigera till __Grupper__ och lägga till __DAM-användare__ grupp (som har skrivåtkomst till tillgångar)
1. Tryck __Spara och stäng__

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

1. Logga in i den AEM as a Cloud Service miljön som har uppdaterats (med samma värdnamn som finns i `aem` kommandoradsparameter)
1. Navigera till __Resurser__ > __Filer__
1. Navigera till resursmappen som anges av `folder` kommandoradsparameter, till exempel __WKND__ > __Engelska__ > __Annonser__ > __Napa-vinsprovning__
1. Öppna __Egenskaper__ för alla resurser i mappen
1. Navigera till __Avancerat__ tab
1. Granska värdet på den uppdaterade egenskapen, till exempel __Copyright__ som mappas till den uppdaterade `metadata/dc:rights` JCR-egenskapen, som nu återspeglar värdet i `propertyValue` parameter, till exempel __WKND begränsad användning__

![WKND - metadatauppdatering med begränsad användning](./assets/service-credentials/asset-metadata.png)

## Grattis!

Nu när vi programmässigt har kommit åt AEM as a Cloud Service med hjälp av en lokal åtkomsttoken för utveckling, liksom en produktionsklar åtkomsttoken för tjänst-till-tjänst!
