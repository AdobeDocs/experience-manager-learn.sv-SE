---
title: OCR-dataextrahering
description: Extrahera data från dokument från myndigheter för att fylla i formulär.
feature: integreringar
topics: adaptive forms
audience: developer
doc-type: article
activity: use
version: 6.4,6.5
kt: 6679
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '648'
ht-degree: 0%

---



# OCR-dataextrahering

Extrahera automatiskt data från en mängd olika dokument från myndigheter för att fylla i era adaptiva formulär.

Det finns ett antal organisationer som tillhandahåller den här tjänsten och så länge de har väldokumenterade REST API:er kan ni enkelt integrera med AEM Forms med hjälp av dataintegreringsfunktionen. I den här självstudiekursen har jag använt [ID Analyzer](https://www.idanalyzer.com/) för att demonstrera OCR-dataextraheringen för överförda dokument.

Följande steg utfördes för att implementera OCR-dataextraheringen med AEM Forms med hjälp av tjänsten ID Analyzer.

## Skapa utvecklarkonto

Skapa ett utvecklarkonto med [ID Analyzer](https://portal.idanalyzer.com/signin.html). Anteckna API-nyckeln. Den här nyckeln behövs för att anropa REST API:er för ID Analyzer-tjänsten.

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

Använd [swagger-redigeraren](https://editor.swagger.io/) för att skapa en swagger-fil som beskriver de åtgärder som skickar och verifierar engångslösenord som skickas med SMS. Swagger-filen kan skapas i JSON- eller YAML-format. Den färdiga swagger-filen kan hämtas från [här](assets/drivers-license-swagger.zip)

## Skapa datakälla

Om du vill integrera AEM/AEM Forms med program från tredje part måste du [skapa en datakälla](https://docs.adobe.com/content/help/en/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html) i konfigurationen för molntjänster. Använd [swagger-filen](assets/drivers-license-swagger.zip) för att skapa datakällan.

## Skapa formulärdatamodell

AEM Forms dataintegrering ger ett intuitivt användargränssnitt för att skapa och arbeta med [formulärdatamodeller](https://docs.adobe.com/content/help/en/experience-manager-65/forms/form-data-model/create-form-data-models.html). Basera formulärdatamodellen på datakällan som skapades i det tidigare steget.

![fdm](assets/test-dl-fdm.PNG)

## Skapa klientbibliotek

Vi måste hämta base64-kodad sträng för det överförda dokumentet. Den här base64-kodade strängen skickas sedan som en av parametrarna för REST-anropet.
Klientbiblioteket kan hämtas [härifrån.](assets/drivers-license-client-lib.zip)

## Skapa anpassat formulär

Integrera formulärdatamodellens anrop av POSTEN med ditt anpassningsbara formulär för att extrahera data från det överförda dokumentet av  i formuläret. Du kan skapa ett eget adaptivt formulär och använda formulärdatamodellens anrop till POSTEN för att skicka den base64-kodade strängen för det överförda dokumentet.

## Distribuera på servern

Om du vill använda exempelresurserna med API-nyckeln följer du följande steg:

* [Hämta datakällan ](assets/drivers-license-source.zip) och importera den till AEM med  [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* [Hämta formulärdatamodellen ](assets/drivers-license-fdm.zip) och importera till AEM med  [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* [Hämta klientbiblioteket](assets/drivers-license-client-lib.zip)
* Hämta exempelformuläret för adaptiv form [som kan hämtas här](assets/adaptive-form-dl.zip). Det här exempelformuläret använder tjänsteanropen för den formulärdatamodell som tillhandahålls som en del av den här artikeln.
* Importera formuläret till AEM från [Forms- och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Öppna formuläret i [redigeringsläge.](http://localhost:4502/editor.html/content/forms/af/driverslicenseandpassport.html)
* Ange API-nyckeln som standardvärde i apikey-fältet och spara ändringarna
* Öppna regelredigeraren för fältet Base 64-sträng. Observera att tjänsten anropas när värdet för det här fältet ändras.
* Spara formuläret
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/driverslicenseandpassport/jcr:content?wcmmode=disabled), ladda upp bilden framför din körkort


