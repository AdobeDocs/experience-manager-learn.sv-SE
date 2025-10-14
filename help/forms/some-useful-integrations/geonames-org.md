---
title: Listrutor för överlappande
description: Fyll i listrutor baserat på ett tidigare val i listrutan.
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-9724
topic: Development
role: Developer
level: Intermediate
exl-id: f1f2cacc-9ec4-46d6-a6af-dac3f663de78
last-substantial-update: 2021-02-07T00:00:00Z
duration: 185
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '610'
ht-degree: 0%

---

# Listrutor för överlappande

En överlappande nedrullningsbar lista är en serie beroende DropDownList-kontroller där en DropDownList-kontroll är beroende av den överordnade eller föregående DropDownList-kontroller. Objekten i DropDownList-kontrollen fylls i baserat på ett objekt som väljs av användaren från en annan DropDownList-kontroll.

## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/3437311?quality=12&learn=on&captions=swe)

I den här självstudiekursen har jag använt [Geonames REST API](https://www.geonames.org/export/web-services.html) för att demonstrera den här funktionen.
Det finns ett antal organisationer som erbjuder den här typen av tjänster och så länge de har väldokumenterade REST API:er kan du enkelt integrera med AEM Forms med hjälp av dataintegreringsfunktionen

Följande steg har utförts för att implementera listrutor i listrutan för överlappande i AEM Forms

## Skapa utvecklarkonto

Skapa ett utvecklarkonto med [geografiska namn](https://www.geonames.org/login). Anteckna användarnamnet. Användarnamnet behövs för att anropa REST API:er för mappen geonames.org.

## Skapa Swagger/OpenAPI-fil

OpenAPI-specifikationen (tidigare Swagger-specifikationen) är ett API-beskrivningsformat för REST API:er. Med en OpenAPI-fil kan du beskriva hela ditt API, inklusive:

* Tillgängliga slutpunkter (/users) och åtgärder för varje slutpunkt (GET /users, POST /users)
* Operationsparametrar Indata och utdata för varje åtgärd
Autentiseringsmetoder
* Kontaktinformation, licens, användningsvillkor och annan information.
* API-specifikationer kan skrivas i YAML eller JSON. Formatet är lätt att lära sig och kan läsas av både människor och datorer.

Följ [OpenAPI-dokumentationen](https://swagger.io/docs/specification/2-0/basic-structure/) för att skapa din första swagger/OpenAPI-fil

>[!NOTE]
> AEM Forms stöder OpenAPI Specification version 2.0 (FKA Swagger).

Använd [swagger-redigeraren](https://editor.swagger.io/) för att skapa en swagger-fil som beskriver åtgärderna som hämtar alla länder och underordnade element för landet eller staten. Swagger-filen kan skapas i JSON- eller YAML-format.

## Skapa datakällor

Om du vill integrera AEM/AEM Forms med program från tredje part måste vi [skapa datakälla](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html?lang=sv-SE) i konfigurationen för molntjänster. Använd [swagger-filerna](assets/geonames-swagger-files.zip) för att skapa datakällor.
Du måste skapa två datakällor (en för att hämta alla länder och andra för att få underordnade element)


## Skapa formulärdatamodell

AEM Forms dataintegrering ger ett intuitivt användargränssnitt för att skapa och arbeta med [formulärdatamodeller](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html?lang=sv-SE). Basera formulärdatamodellen på datakällorna som skapades i det tidigare steget. Formulärdatamodell med 2 datakällor

![fdm](assets/geonames-fdm.png)


## Skapa anpassat formulär

Integrera GET-anropen i formulärdatamodellen med ditt anpassningsbara formulär för att fylla i listrutorna.
Skapa ett anpassningsbart formulär med 2 nedrullningsbara listor. En för att lista länderna och en för att lista staterna/provinserna beroende på vilket land som valts.

### Listruta för att fylla i länder

Länklistan fylls i när formuläret initieras för första gången. I följande skärmbild visas regelredigeraren som är konfigurerad att fylla i alternativen i den nedrullningsbara listan med länder. Du måste ange ditt användarnamn med geonames-kontot för att detta ska fungera.
![get-countries](assets/get-countries-rule-editor.png)

#### Fyll i listrutan Region

Vi måste fylla i den nedrullningsbara listan Stat/provins baserat på det valda landet. Följande skärmbild visar konfigurationen för regelredigeraren
![state-Region-options](assets/state-province-options.png)

### Utövning

Lägg till två nedrullningsbara listor med namnet fylken och städer i formuläret för att lista fylken och staden baserat på valt land och vald stat/provins.
![övning](assets/cascading-drop-down-exercise.png)


### Exempel på Assets

Du kan ladda ned följande resurser för att få ett försprång i överlappande listruteexempel
De färdiga swagger-filerna kan hämtas från [här](assets/geonames-swagger-files.zip)
Swagger-filerna beskriver följande REST API
* [Hämta alla länder](https://secure.geonames.org/countryInfoJSON?username=yourusername)
* [Hämta underordnade objekt för Geoname-objekt](https://secure.geonames.org/children?formatted=true&geonameId=6252001&username=yourusername)

Den färdiga [formulärdatamodellen kan hämtas här](assets/geonames-api-form-data-model.zip)
