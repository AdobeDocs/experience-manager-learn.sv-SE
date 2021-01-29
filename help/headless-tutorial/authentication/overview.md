---
title: Autentisera till AEM som en Cloud Service från ett externt program
description: Upptäck hur ett externt program kan autentisera och interagera med AEM som en Cloud Service via HTTP med hjälp av Local Development Access-token och inloggningsuppgifter.
version: cloud-service
doc-type: tutorial
topics: Development, Security
feature: APIs
activity: develop
audience: developer
kt: 6785
thumbnail: 330460.jpg
translation-type: tm+mt
source-git-commit: c4f3d437b5ecfe6cb97314076cd3a5e31b184c79
workflow-type: tm+mt
source-wordcount: '585'
ht-degree: 0%

---


# Tokenbaserad autentisering som AEM som Cloud Service

I den här självstudiekursen kan du utforska hur ett externt program kan autentisera och interagera med till AEM som en Cloud Service via HTTP med hjälp av åtkomsttoken.

>[!VIDEO](https://video.tv.adobe.com/v/330460/?quality=12&learn=on)

## Krav

Kontrollera att följande finns på plats innan du följer med i den här självstudiekursen:

1. Tillgång till am AEM som Cloud Service (helst en utvecklingsmiljö eller ett sandlådeprogram)
1. Medlemskap i AEM som Cloud Service-miljöns Author services AEM Administrator Product Profile
1. Medlemskap i eller åtkomst till din Adobe IMS-organisationsadministratör (de måste initiera [tjänstens inloggningsuppgifter](./service-credentials.md))
1. Den senaste [WKND-platsen](https://github.com/adobe/aem-guides-wknd) som distribuerats till din Cloud Service-miljö

## Översikt över externt program

I den här självstudien används ett [enkelt Node.js-program](./assets/aem-guides_token-authentication-external-application.zip) som körs från kommandoraden för att uppdatera metadata för resurser på AEM som en Cloud Service med [Assets HTTP API](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/admin/mac-api-assets.html).

Körningsflödet för programmet Node.js är följande:

![Externt program](./assets/overview/external-application.png)

1. Programmet Node.js anropas från kommandoraden
1. Parametrar för kommandorad definierar:
   + AEM som Cloud Service Author Service Host att ansluta till (`aem`)
   + Den AEM resursmapp vars resurser ska uppdateras (`folder`)
   + Egenskapen och värdet för metadata som ska uppdateras (`propertyName` och `propertyValue`)
   + Den lokala sökvägen till filen med de autentiseringsuppgifter som krävs för att få åtkomst till AEM som Cloud Service (`file`)
1. Åtkomsttoken som används för att autentisera AEM härleds från JSON-filen som tillhandahålls via kommandoradsparametern `file`

   a. Om tjänstautentiseringsuppgifter som används för icke-lokal utveckling anges i JSON-filen (`file`) hämtas åtkomsttoken från Adobe IMS API:er
1. Programmet använder åtkomsttoken för att få åtkomst till AEM och lista alla resurser i mappen som anges i kommandoradsparametern `folder`
1. För varje resurs i mappen uppdaterar programmet sina metadata baserat på egenskapsnamnet och värdet som anges i kommandoradsparametrarna `propertyName` och `propertyValue`

Även om det här exempelprogrammet är Node.js, kan dessa interaktioner utvecklas med olika programmeringsspråk och köras från andra externa system.

## Åtkomsttoken för lokal utveckling

Token för lokal utvecklingsåtkomst genereras för en specifik AEM som en Cloud Service och ger tillgång till författar- och publiceringstjänster.  Dessa åtkomsttoken är temporära och ska bara användas under utvecklingen av externa program eller system som interagerar med AEM via HTTP. Istället för att utvecklaren behöver skaffa och hantera äkta Service Credentials kan han eller hon snabbt och enkelt generera en temporär åtkomsttoken så att han eller hon kan utveckla sin integrering.

+ [Så här använder du Local Development Access Token](./local-development-access-token.md)

## Tjänstautentiseringsuppgifter

Autentiseringsuppgifterna för tjänsten är de autentiseringsuppgifter som används i alla icke-utvecklingsscenarier - tydligast i produktionen - och som underlättar för ett externt program eller system att autentisera till och interagera med AEM som en Cloud Service via HTTP. Själva tjänstautentiseringsuppgifterna skickas inte till AEM för autentisering, utan i det externa programmet används dessa för att generera en JWT, som byts ut mot Adobe IMS API:er _för_ en åtkomsttoken, som sedan kan användas för att autentisera HTTP-begäranden som AEM som en Cloud Service.

+ [Så här använder du tjänstens autentiseringsuppgifter](./service-credentials.md)

## Ytterligare resurser

+ [Hämta exempelprogrammet](./assets/aem-guides_token-authentication-external-application.zip)
+ Andra kodexempel på skapande och utbyte av JWT
   + [Node.js, Java, Python, C#.NET och PHP-kodexempel](https://www.adobe.io/authentication/auth-methods.html#!AdobeDocs/adobeio-auth/master/JWT/samples/samples.md)
   + [JavaScript/Axios-baserad kod](https://github.com/adobe/aemcs-api-client-lib)
