---
title: Testa Forms assembler-lösningen
description: Kör ExecuteAssemblerService.java för att testa lösningen
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
exl-id: 5139aa84-58d5-40e3-936a-0505bd407ee8
duration: 80
source-git-commit: af928e60410022f12207082467d3bd9b818af59d
workflow-type: tm+mt
source-wordcount: '256'
ht-degree: 0%

---

# Importera Eclipse-projekt

* Ladda ned och zippa upp [zip-fil](./assets/pdf-manipulation.zip)
* Starta Eclipse och importera projektet till Eclipse
* Projektet innehåller följande mappar i resursmappen:
   * ddxFiles - Den här mappen innehåller ddx-filen som beskriver utdata som du vill generera
   * pdffiles - Den här mappen innehåller de pdf-filer som du vill sätta ihop och pdf-filer för att testa PDFA-verktygen
   * credentials - Den här mappen innehåller pdfa-options.json-filen

![resources-file](./assets/resources.png)

## Testa att samla ihop PDF-filer

* Kopiera och klistra in dina inloggningsuppgifter i tjänstens_token.json-resursfil i projektet.
* Öppna filen AssemblePDFFiles.java och ange i vilken mapp du vill spara de genererade PDF-filerna
* Öppna executeAssemblerService.java. Ange variabelns värde _AEM_FORMS_CS_ för att peka på din instans.
* Avkommentera lämpliga rader för att testa sammansättning av två eller flera PDF-filer
* Kör ExecuteAssemblerService.java som java-program

### Testa PDFA-verktyg

* Kopiera och klistra in dina inloggningsuppgifter i tjänstens_token.json-resursfil i projektet.
* Öppna filen PDFAUtilities.java och ange i vilken mapp du vill spara de genererade PDF-filerna.
* Öppna executeAssemblerService.java. Ange variabelns värde _AEM_FORMS_CS_ för att peka på din instans.
* Avkommentera lämpliga rader för att testa PDFA-åtgärder.
* Kör ExecuteAssemblerService.java som java-program.



>[!NOTE]
> Första gången du kör java-programmet får du ett HTTP 403-fel. För att komma förbi detta måste du [lämplig behörighet för den tekniska kontoanvändaren i AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials.html?lang=en#configure-access-in-aem).

**AEM Forms-användare** Det är den roll jag har använt för den här kursen.
