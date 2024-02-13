---
title: Autentisering till AEM as a Cloud Service från ett externt program
description: Upptäck hur ett externt program kan autentisera och interagera med AEM as a Cloud Service via HTTP med hjälp av Local Development Access-token och inloggningsuppgifter.
version: Cloud Service
feature: APIs
jira: KT-6785
thumbnail: 330460.jpg
topic: Headless, Integrations
role: Developer
level: Intermediate, Experienced
doc-type: Tutorial
exl-id: 63c23f22-533d-486c-846b-fae22a4d68db
duration: 288
source-git-commit: 0400242f6a99bc5209a8b483469d5fd88eac077e
workflow-type: tm+mt
source-wordcount: '621'
ht-degree: 0%

---

# Tokenbaserad autentisering till AEM as a Cloud Service

AEM visar en mängd olika HTTP-slutpunkter som kan interagera med utan krångel, från GraphQL AEM Content Services till Assets HTTP API. Dessa headless-användare kan ofta behöva autentisera sig för AEM för att få tillgång till skyddat innehåll eller skyddade åtgärder. För att underlätta detta stöder AEM tokenbaserad autentisering av HTTP-begäranden från externa program, tjänster eller system.

I den här självstudiekursen kan du utforska hur ett externt program kan autentisera och interagera med för att AEM as a Cloud Service via HTTP med hjälp av åtkomsttoken.

>[!VIDEO](https://video.tv.adobe.com/v/330460?quality=12&learn=on)

## Krav

Se till att följande finns på plats innan du följer med i den här självstudiekursen:

1. Tillgång till AEM as a Cloud Service miljö (helst utvecklingsmiljö eller sandlådeprogram)
1. Medlemskap i AEM as a Cloud Service miljöns Author Services AEM Administrator Product Profile
1. Medlemskap i, eller åtkomst till, din Adobe IMS-organisationsadministratör (de måste initiera [Autentiseringsuppgifter för tjänsten](./service-credentials.md))
1. De senaste [WKND-plats](https://github.com/adobe/aem-guides-wknd) distribueras till din Cloud Service

## Översikt över externt program

I den här självstudiekursen används en [simple Node.js application](./assets/aem-guides_token-authentication-external-application.zip) köra från kommandoraden för att uppdatera metadata för resurser på AEM as a Cloud Service med [Resurser för HTTP API](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/admin/mac-api-assets.html).

Körningsflödet för programmet Node.js är följande:

![Externt program](./assets/overview/external-application.png)

1. Programmet Node.js anropas från kommandoraden
1. Parametrar för kommandorad definierar:
   + Den AEM as a Cloud Service författartjänstvärden som ska anslutas till (`aem`)
   + Den AEM resursmappen vars resurser uppdateras (`folder`)
   + Egenskapen och värdet för metadata som ska uppdateras (`propertyName` och `propertyValue`)
   + Den lokala sökvägen till filen med de autentiseringsuppgifter som krävs för att få åtkomst till AEM as a Cloud Service (`file`)
1. Åtkomsttoken som används för att autentisera AEM härleds från JSON-filen som tillhandahålls via kommandoradsparametern `file`

   a. Om tjänstautentiseringsuppgifter som används för icke-lokal utveckling anges i JSON-filen (`file`) hämtas åtkomsttoken från Adobe IMS API:er
1. Programmet använder åtkomsttoken för att få åtkomst till AEM och lista alla resurser i mappen som anges i kommandoradsparametern `folder`
1. För varje resurs i mappen uppdaterar programmet sina metadata baserat på egenskapsnamnet och värdet som anges i kommandoradsparametrarna `propertyName` och `propertyValue`

Även om det här exempelprogrammet är Node.js, kan dessa interaktioner utvecklas med olika programmeringsspråk och köras från andra externa system.

## Åtkomsttoken för lokal utveckling

Token för lokal utvecklingsåtkomst genereras för en viss AEM as a Cloud Service miljö och ger åtkomst till författar- och publiceringstjänster.  Dessa åtkomsttoken är temporära och ska bara användas under utvecklingen av externa program eller system som interagerar med AEM via HTTP. Istället för att utvecklaren behöver skaffa och hantera äkta Service Credentials kan han eller hon snabbt och enkelt generera en temporär åtkomsttoken så att han eller hon kan utveckla sin integrering.

+ [Så här använder du Local Development Access Token](./local-development-access-token.md)

## Autentiseringsuppgifter för tjänsten

Autentiseringsuppgifterna för tjänsten är de autentiseringsuppgifter som används i alla icke-utvecklingsscenarier - tydligast i produktionen - och som underlättar för ett externt program eller system att autentisera till, och interagera med, AEM as a Cloud Service via HTTP. Själva tjänstens autentiseringsuppgifter skickas inte till AEM för autentisering, utan det externa programmet använder dessa för att generera en JWT, som byts ut mot Adobe IMS API:er _for_ en åtkomsttoken, som sedan kan användas för att autentisera HTTP-begäranden till AEM as a Cloud Service.

+ [Så här använder du tjänstens autentiseringsuppgifter](./service-credentials.md)

## Ytterligare resurser

+ [Hämta exempelprogrammet](./assets/aem-guides_token-authentication-external-application.zip)
+ Andra kodexempel på skapande och utbyte av JWT
   + [Node.js, Java, Python, C#.NET och PHP-kodexempel](https://developer.adobe.com/developer-console/docs/guides/authentication/JWT/samples/)
   + [JavaScript/Axios-baserad kod](https://github.com/adobe/aemcs-api-client-lib)
