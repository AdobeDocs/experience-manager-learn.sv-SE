---
title: Använda API för usagerights
description: Exempelkod för att använda användningsrättigheter på den angivna PDF
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Document Services
topic: Development
jira: KT-17479
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
source-git-commit: a72f533b36940ce735d5c01d1625c6f477ef4850
workflow-type: tm+mt
source-wordcount: '280'
ht-degree: 0%

---

# Anropa API

## Använd användningsbehörighet

När du har en åtkomsttoken är nästa steg att göra en API-begäran om att tillämpa användarrättigheter på den angivna PDF:n. Detta inbegriper åtkomsttoken i begärandehuvudet för att autentisera anropet och säkerställa säker och auktoriserad behandling av dokumentet.

Följande funktion tillämpar användarrättigheterna

```java
public void applyUsageRights(String accessToken,String endPoint) {

            String host = "https://" + BUCKET + ".adobeaemcloud.com";
            String url = host + endPoint;
            String usageRights = "{\"comments\":true,\"embeddedFiles\":true,\"formFillIn\":true,\"formDataExport\":true}";

            logger.info("Request URL: {}", url);
            logger.info("Access Token: {}", accessToken);

            ClassLoader classLoader = DocumentGeneration.class.getClassLoader();
            URL pdfFile = classLoader.getResource("pdffiles/withoutusagerights.pdf");

            if (pdfFile == null) {
                logger.error("PDF file not found!");
                return;
            }

            File fileToApplyRights = new File(pdfFile.getPath());
            CloseableHttpClient httpClient = null;
            CloseableHttpResponse response = null;
            InputStream generatedPDF = null;
            FileOutputStream outputStream = null;
            
            try {
                httpClient = HttpClients.createDefault();
                byte[] fileContent = FileUtils.readFileToByteArray(fileToApplyRights);
                MultipartEntityBuilder builder = MultipartEntityBuilder.create();
                builder.addBinaryBody("document", fileContent, ContentType.create("application/pdf"),fileToApplyRights.getName());
                builder.addTextBody("usageRights", usageRights, ContentType.APPLICATION_JSON);
                
                HttpPost httpPost = new HttpPost(url);
                httpPost.addHeader("Authorization", "Bearer " + accessToken);
                httpPost.addHeader("X-Adobe-Accept-Experimental", "1");
                httpPost.setEntity(builder.build());
                
                response = httpClient.execute(httpPost);
                generatedPDF = response.getEntity().getContent();
                byte[] bytes = IOUtils.toByteArray(generatedPDF);

                outputStream = new FileOutputStream(SAVE_LOCATION + File.separator + "ReaderExtended.pdf");
                outputStream.write(bytes);
                logger.info("ReaderExtended File is  saved at "+SAVE_LOCATION);
            } catch (IOException e) {
                logger.error("Error applying usage rights", e);
            } finally {
                try {
                    if (generatedPDF != null) generatedPDF.close();
                    if (response != null) response.close();
                    if (httpClient != null) httpClient.close();
                    if (outputStream != null) outputStream.close();
                } catch (IOException e) {
                    logger.error("Error closing resources", e);
                }
            }
        }
```

## Funktionsuppdelning:



* **Konfigurera API-slutpunkt och nyttolast**
   * Skapar API-URL:en med angiven `endPoint` och fördefinierad `BUCKET`.
   * Definierar en JSON-sträng (`usageRights`) som anger vilka rättigheter som ska tillämpas, till exempel:
      * Kommentar
      * Inbäddade filer
      * Blankettifyllnad
      * Export av formulärdata

* **Läs in PDF-filen**
   * Hämtar filen `withoutusagerights.pdf` från katalogen `pdffiles`.
   * Loggar ett fel och avslutar om filen inte hittas.

* **Förbered HTTP-begäran**
   * Läser PDF-filen till en bytearray.
   * Använder `MultipartEntityBuilder` för att skapa en begäran om flera delar som innehåller:
      * PDF-filen som en binärfil.
      * JSON `usageRights` som textbrödtext.
   * Ställer in en HTTP `POST`-begäran med rubriker:
      * `Authorization: Bearer <accessToken>` för autentisering.
      * `X-Adobe-Accept-Experimental: 1` (krävs eventuellt för API-kompatibilitet).

* **Skicka förfrågan och handtag-svar**
   * Kör HTTP-begäran med `httpClient.execute(httpPost)`.
   * Läser svaret (förväntas vara den uppdaterade PDF med användningsbehörighet).
   * Skriver mottaget PDF-innehåll till **&quot;ReaderExtended.pdf&quot;** kl. `SAVE_LOCATION`.

* **Felhantering och rensning**
   * Fångar och loggar eventuella `IOException`-fel.
   * Ser till att alla resurser (strömmar, HTTP-klient, svar) stängs korrekt i blocket `finally`.

Här följer koden main.java som anropar funktionen applyUsageRights

```java
package com.aemformscs.communicationapi;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Main {
    private static final Logger logger = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        try {
            String accessToken = new AccessTokenService().getAccessToken();
            DocumentGeneration docGen = new DocumentGeneration();

            docGen.applyUsageRights(accessToken, "/adobe/document/assure/usagerights");

            // Uncomment as needed
            // docGen.extractPDFProperties(accessToken, "/adobe/document/extract/pdfproperties");
            // docGen.mergeDataWithXdpTemplate(accessToken, "/adobe/document/generate/pdfform");

        } catch (Exception e) {
            logger.error("Error occurred: {}", e.getMessage(), e);
        }
    }
}
```

Metoden `main` initieras genom att anropa `getAccessToken()` från `AccessTokenService`, som förväntas returnera en giltig token.

* Sedan anropas `applyUsageRights()` från klassen `DocumentGeneration` och följande skickas:
   * Hämtade `accessToken`
   * API-slutpunkten för användning av användningsrättigheter.


## Nästa steg

[Distribuera exempelprojektet](sample-project.md)
