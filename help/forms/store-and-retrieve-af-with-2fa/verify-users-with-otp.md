---
title: Verifiera användare med engångslösenord
description: Verifiera det mobilnummer som är kopplat till programnumret med hjälp av engångslösenord.
feature: Adaptiv Forms
type: Tutorial
version: 6.4,6.5
kt: 6594
thumbnail: 6594.jpg
topic: Utveckling
role: Developer
level: Experienced
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '424'
ht-degree: 0%

---



# Verifiera användare med engångslösenord

SMS Two Factor Authentication (Dual Factor Authentication) är en säkerhetsverifieringsprocedur som aktiveras genom att en användare loggar in på en webbplats, ett program eller ett program. I inloggningsprocessen skickas användaren automatiskt ett SMS till sitt mobilnummer med en unik numerisk kod.

Det finns ett antal organisationer som tillhandahåller den här tjänsten och så länge de har väldokumenterade REST API:er kan du enkelt integrera AEM Forms med AEM Forms dataintegrationsfunktioner. I den här självstudiekursen har jag använt [Nexmo](https://developer.nexmo.com/verify/overview) för att demonstrera SMS 2FA-användningsexemplet.

Följande steg utfördes för att implementera SMS 2FA med AEM Forms med tjänsten Nexmo Verify.

## Skapa utvecklarkonto

Skapa ett utvecklarkonto med [Nexmo](https://dashboard.nexmo.com/sign-in). Anteckna API-nyckeln och API-hemlig nyckel. Dessa nycklar behövs för att anropa REST API:er för Nexmo-tjänsten.

## Skapa Swagger/OpenAPI-fil

OpenAPI-specifikationen (tidigare Swagger-specifikationen) är ett API-beskrivningsformat för REST API:er. Med en OpenAPI-fil kan du beskriva hela ditt API, inklusive:

* Tillgängliga slutpunkter (/användare) och åtgärder för varje slutpunkt (GET /användare, POST /användare)
* Operationsparametrar Indata och utdata för varje åtgärd
Autentiseringsmetoder
* Kontaktinformation, licens, användningsvillkor och annan information.
* API-specifikationer kan skrivas i YAML eller JSON. Formatet är lätt att lära sig och kan läsas av både människor och datorer.

Följ [OpenAPI-dokumentationen](https://swagger.io/docs/specification/2-0/basic-structure/) för att skapa din första swagger/OpenAPI-fil

>[!NOTE]
> AEM Forms stöder OpenAPI Specification version 2.0 (fka Swagger).

Använd [swagger-redigeraren](https://editor.swagger.io/) för att skapa en swagger-fil som beskriver de åtgärder som skickar och verifierar engångslösenord som skickas med SMS. Swagger-filen kan skapas i JSON- eller YAML-format. Den färdiga swagger-filen kan hämtas från [här](assets/two-factore-authentication-swagger.zip)

## Skapa datakälla

För att integrera AEM/AEM Forms med program från tredje part måste vi [REST-baserad datakälla med swagger-filen](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html) i konfigurationen för molntjänster. Den färdiga datakällan tillhandahålls som en del av kursmaterialet.

## Skapa formulärdatamodell

AEM Forms dataintegrering ger ett intuitivt användargränssnitt för att skapa och arbeta med [formulärdatamodeller](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html). En formulärdatamodell bygger på datakällor för datautbyte.
Den ifyllda formulärdatamodellen kan [hämtas här](assets/sms-2fa-fdm.zip)

![fdm](assets/2FA-fdm.PNG)
