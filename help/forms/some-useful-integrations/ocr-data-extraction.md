---
title: OCR-dataextrahering
description: Extrahera data från dokument från myndigheter för att fylla i formulär.
feature: Barcoded Forms
version: 6.4,6.5
jira: KT-6679
topic: Development
role: Developer
level: Intermediate
exl-id: 1532a865-4664-40d9-964a-e64463b49587
last-substantial-update: 2019-07-07T00:00:00Z
duration: 179
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '661'
ht-degree: 0%

---

# OCR-dataextrahering

Extrahera automatiskt data från en mängd olika dokument från myndigheter för att fylla i era adaptiva formulär.

Det finns ett antal organisationer som tillhandahåller den här tjänsten och så länge de har väldokumenterade REST API:er kan ni enkelt integrera med AEM Forms med hjälp av dataintegreringsfunktionen. I den här självstudiekursen har jag använt [ID Analyzer](https://www.idanalyzer.com/) för att demonstrera OCR-extraheringen av överförda dokument.

Följande steg utfördes för att implementera OCR-dataextraheringen med AEM Forms med hjälp av tjänsten ID Analyzer.

## Skapa utvecklarkonto

Skapa ett utvecklarkonto med [ID Analyzer](https://portal.idanalyzer.com/signin.html). Anteckna API-nyckeln. Den här nyckeln behövs för att anropa REST API:er för ID Analyzer-tjänsten.

## Skapa Swagger/OpenAPI-fil

OpenAPI-specifikationen (tidigare Swagger-specifikationen) är ett API-beskrivningsformat för REST API:er. Med en OpenAPI-fil kan du beskriva hela ditt API, inklusive:

* Tillgängliga slutpunkter (/användare) och åtgärder för varje slutpunkt (GET /användare, POST /användare)
* Åtgärdsparametrar Indata och utdata för varje åtgärd Autentiseringsmetoder
* Kontaktinformation, licens, användningsvillkor och annan information.
* API-specifikationer kan skrivas i YAML eller JSON. Formatet är lätt att lära sig och kan läsas av både människor och datorer.

Om du vill skapa din första swagger/OpenAPI-fil följer du [OpenAPI-dokumentation](https://swagger.io/docs/specification/2-0/basic-structure/)

>[!NOTE]
> AEM Forms stöder OpenAPI Specification version 2.0 (fka Swagger).

Använd [swagger editor](https://editor.swagger.io/) om du vill skapa en swagger-fil som beskriver de åtgärder som skickar och verifierar den engångskod som skickas med SMS. Swagger-filen kan skapas i JSON- eller YAML-format. Den färdiga swagger-filen kan hämtas från [här](assets/drivers-license-swagger.zip)

## Att tänka på när du definierar swagger-filen

* Definitioner krävs
* $ref måste användas för metoddefinitioner
* Föredrar att ha definierade förbrukningar och skapar avsnitt
* Definiera inte textbundna parametrar för förfrågningar eller svarsparametrar. Försök att modularisera så mycket som möjligt. Följande definition stöds till exempel inte

```json
 "name": "body",
            "in": "body",
            "required": false,
            "schema": {
              "type": "object",
              "properties": {
                "Rollnum": {
                  "type": "string",
                  "description": "Rollnum"
                }
              }
            }
```

Följande stöds med en referens till definitionen requestBody

```json
 "name": "requestBody",
            "in": "body",
            "required": false,
            "schema": {
              "$ref": "#/definitions/requestBody"
            }
```

* [Exempelfil för Swagger som referens](assets/sample-swagger.json)

## Skapa datakälla

För att integrera AEM/AEM Forms med program från tredje part måste vi [skapa datakälla](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html) i molntjänstkonfigurationen. Använd [swagger-fil](assets/drivers-license-swagger.zip) för att skapa en datakälla.

## Skapa formulärdatamodell

AEM Forms dataintegrering ger ett intuitivt användargränssnitt för att skapa och arbeta med [formulärdatamodeller](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html). Basera formulärdatamodellen på datakällan som skapades i det tidigare steget.

![fdm](assets/test-dl-fdm.PNG)

## Skapa klientbibliotek

Vi måste hämta base64-kodad sträng för det överförda dokumentet. Den här base64-kodade strängen skickas sedan som en av parametrarna för REST-anropet.
Klientbiblioteket kan hämtas [härifrån.](assets/drivers-license-client-lib.zip)

## Skapa anpassat formulär

Integrera formulärdatamodellens anrop av POSTEN med ditt anpassningsbara formulär för att extrahera data från det överförda dokumentet av  i formuläret. Du kan skapa ett eget adaptivt formulär och använda formulärdatamodellens anrop till POSTEN för att skicka den base64-kodade strängen för det överförda dokumentet.

## Distribuera på servern

Om du vill använda exempelresurserna med API-nyckeln följer du följande steg:

* [Hämta datakällan](assets/drivers-license-source.zip) och importera till AEM med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* [Hämta formulärdatamodellen](assets/drivers-license-fdm.zip) och importera till AEM med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* [Hämta klientbiblioteket](assets/drivers-license-client-lib.zip)
* Ladda ned exempelformuläret för anpassning [hämtad härifrån](assets/adaptive-form-dl.zip). Det här exempelformuläret använder tjänsteanropen för den formulärdatamodell som tillhandahålls som en del av den här artikeln.
* Importera formuläret till AEM från [Forms och dokumentgränssnitt](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Öppna formuläret i [redigeringsläge.](http://localhost:4502/editor.html/content/forms/af/driverslicenseandpassport.html)
* Ange API-nyckeln som standardvärde i apikey-fältet och spara ändringarna
* Öppna regelredigeraren för fältet Base 64-sträng. Observera att tjänsten anropas när värdet för det här fältet ändras.
* Spara formuläret
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/driverslicenseandpassport/jcr:content?wcmmode=disabled), ladda upp bilden framför din körkort
