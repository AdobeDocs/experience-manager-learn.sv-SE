---
title: SMS-autentisering med två faktorer
description: Lägg till ett extra säkerhetslager som hjälper till att bekräfta en användares identitet när han/hon vill utföra vissa aktiviteter
feature: Adaptive Forms
version: 6.4,6.5
jira: KT-6317
topic: Development
role: Developer
level: Experienced
exl-id: c2c55406-6da6-42be-bcc0-f34426b3291a
last-substantial-update: 2021-07-07T00:00:00Z
duration: 144
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '557'
ht-degree: 0%

---

# Verifiera användare med sina mobiltelefonnummer

SMS Two Factor Authentication (Dual Factor Authentication) är en säkerhetsverifieringsprocedur som aktiveras genom att en användare loggar in på en webbplats, ett program eller ett program. I inloggningsprocessen skickas användaren automatiskt ett SMS till sitt mobilnummer med en unik numerisk kod.

Det finns ett antal organisationer som tillhandahåller den här tjänsten och så länge de har väldokumenterade REST API:er kan du enkelt integrera AEM Forms med AEM Forms dataintegrationsfunktioner. I den här självstudiekursen har jag använt [Nexmo](https://developer.nexmo.com/verify/overview) för att demonstrera användningen av SMS 2FA.

Följande steg utfördes för att implementera SMS 2FA med AEM Forms med tjänsten Nexmo Verify.

## Skapa utvecklarkonto

Skapa ett utvecklarkonto med [Nexmo](https://dashboard.nexmo.com/sign-in). Anteckna API-nyckeln och API-hemlig nyckel. Dessa nycklar behövs för att anropa REST API:er för Nexmo-tjänsten.

## Skapa Swagger/OpenAPI-fil

OpenAPI-specifikationen (tidigare Swagger-specifikationen) är ett API-beskrivningsformat för REST API:er. Med en OpenAPI-fil kan du beskriva hela ditt API, inklusive:

* Tillgängliga slutpunkter (/användare) och åtgärder för varje slutpunkt (GET /användare, POST /användare)
* Åtgärdsparametrar Indata och utdata för varje åtgärd Autentiseringsmetoder
* Kontaktinformation, licens, användningsvillkor och annan information.
* API-specifikationer kan skrivas i YAML eller JSON. Formatet är lätt att lära sig och kan läsas av både människor och datorer.

Om du vill skapa din första swagger/OpenAPI-fil följer du [OpenAPI-dokumentation](https://swagger.io/docs/specification/2-0/basic-structure/)

>[!NOTE]
> AEM Forms stöder OpenAPI Specification version 2.0 (fka Swagger).

Använd [swagger editor](https://editor.swagger.io/) om du vill skapa en swagger-fil som beskriver de åtgärder som skickar och verifierar den engångskod som skickas med SMS. Swagger-filen kan skapas i JSON- eller YAML-format. Den färdiga swagger-filen kan hämtas från [här](assets/two-factore-authentication-swagger.zip)

## Skapa datakälla

För att integrera AEM/AEM Forms med program från tredje part måste vi [skapa datakälla](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html) i molntjänstkonfigurationen.

## Skapa formulärdatamodell

AEM Forms dataintegrering ger ett intuitivt användargränssnitt för att skapa och arbeta med [formulärdatamodeller](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html). En formulärdatamodell bygger på datakällor för datautbyte.
Den ifyllda formulärdatamodellen kan [hämtad härifrån](assets/sms-2fa-fdm.zip)

![fdm](assets/2FA-fdm.PNG)

## Skapa anpassat formulär

Integrera formulärdatamodellens mobilanrop med ditt anpassningsbara formulär för att verifiera det mobiltelefonnummer som POSTEN angett i formuläret. Du kan skapa ett eget anpassat formulär och använda POSTEN som anropas av formulärdatamodellen för att skicka och verifiera koden för engångslösenord enligt dina önskemål.

Om du vill använda exempelresurserna med dina API-nycklar följer du följande steg:

* [Hämta formulärdatamodellen](assets/sms-2fa-fdm.zip) och importera till AEM med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* Ladda ned exempelformuläret för anpassning [hämtad härifrån](assets/sms-2fa-verification-af.zip). Det här exempelformuläret använder tjänsteanropen för den formulärdatamodell som tillhandahålls som en del av den här artikeln.
* Importera formuläret till AEM från [Forms och dokumentgränssnitt](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Öppna formuläret i redigeringsläge. Öppna regelredigeraren för följande fält

![sms-send](assets/check-sms.PNG)

* Redigera regeln som är associerad med fältet. Ange lämpliga API-nycklar
* Spara formuläret
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/sms-2fa-verification/jcr:content?wcmmode=disabled) och testa funktionerna
