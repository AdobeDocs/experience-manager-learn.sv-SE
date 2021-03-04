---
title: Använda batch-API för att generera interaktiva kommunikationsdokument
description: Exempelresurser för generering av tryckta kanalsdokument med batch-API
feature: Interaktiv kommunikation
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.5
topic: Utveckling
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '421'
ht-degree: 0%

---


# Batch-API

Du kan använda batch-API:t för att skapa flera interaktiva dokument från en mall. Mallen är en interaktiv kommunikation utan data. Batch-API:t kombinerar data med en mall för att skapa en interaktiv kommunikation. API:t är användbart vid massproduktion av interaktiv kommunikation. Till exempel telefonräkningar, kreditkortsutdrag för flera kunder.

[Läs mer om API för gruppgenerering](https://docs.adobe.com/content/help/en/experience-manager-65/forms/interactive-communications/generate-multiple-interactive-communication-using-batch-api.html)

I den här artikeln finns exempelresurser för att generera interaktiva kommunikationsdokument med hjälp av batch-API:t.

## Gruppgenerering med bevakad mapp

* Importera [mallen för interaktiv kommunikation](assets/Beneficiaries-confirmation.zip) till din AEM Forms-server.
* Importera [konfigurationen för bevakad mapp](assets/batch-generation-api.zip). Detta skapar en mapp med namnet `batchAPI` i C-enheten.

**Om du kör AEM Forms på ett operativsystem som inte är ett Windows-operativsystem, följ de tre stegen nedan:**

1. [Öppna bevakad mapp](http://localhost:4502/libs/fd/core/WatchfolderUI/content/UI.html)
2. Välj BatchAPIWatchedFolder och klicka på Redigera.
3. Ändra sökvägen så att den matchar ditt operativsystem.

![path](assets/watched-folder-batch-api-basic.PNG)

* Hämta och extrahera innehållet i [zip-filen](assets/jsonfile.zip). ZIP-filen innehåller mappen `jsonfile` som innehåller filen `beneficiaries.json`. Den här filen innehåller data för att generera 3 dokument.

* Släpp mappen `jsonfile` i indatamappen för den bevakade mappen.
* När mappen har tagits upp för bearbetning kontrollerar du resultatmappen för den bevakade mappen. Tre PDF-filer bör genereras

## Batchgenerering med REST-begäranden

Du kan anropa [batch-API](https://helpx.adobe.com/experience-manager/6-5/forms/javadocs/index.html) via REST-begäranden. Du kan visa REST-slutpunkter för andra program för att anropa API:t för att generera dokument.
De exempelresurser som tillhandahålls visar REST-slutpunkten för generering av interaktiva kommunikationsdokument. Servern accepterar följande parametrar:

* fileName - Sökväg till datafilen i filsystemet.
* templatePath - IC-mallsökväg
* saveLocation - Plats där de genererade dokumenten ska sparas i filsystemet
* channelType - Print, Web eller båda
* recordId - JSON-sökväg till element för att ange namnet på en interaktiv kommunikation

På följande skärmbild visas parametrarna och deras värden
![exempelbegäran](assets/generate-ic-batch-servlet.PNG)

## Distribuera exempelresurser på servern

* Importera [ICT-mall](assets/ICTemplate.zip) med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* Importera [anpassad överföringshanterare](assets/BatchAPICustomSubmit.zip) med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* Importera [adaptiv form](assets/BatchGenerationAPIAF.zip) med [Forms- och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Distribuera och starta [Anpassat OSGI-paket](assets/batchgenerationapi.batchgenerationapi.core-1.0-SNAPSHOT.jar) med [Felix webbkonsol](http://localhost:4502/system/console/bundles)
* [Utlös batchgenerering genom att skicka formuläret](http://localhost:4502/content/dam/formsanddocuments/batchgenerationapi/jcr:content?wcmmode=disabled)
