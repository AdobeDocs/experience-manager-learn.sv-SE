---
title: Testa Forms assembler-lösningen
description: Kör ExecuteAssemblerService.java för att testa lösningen
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Adaptive Forms
topic: Development
exl-id: 5139aa84-58d5-40e3-936a-0505bd407ee8
duration: 55
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '256'
ht-degree: 0%

---

# Importera Eclipse-projekt

* Hämta och zippa upp zip-filen [zip](./assets/pdf-manipulation.zip)
* Starta Eclipse och importera projektet till Eclipse
* Projektet innehåller följande mappar i resursmappen:
   * ddxFiles - Den här mappen innehåller ddx-filen som beskriver utdata som du vill generera
   * pdffiles - Den här mappen innehåller de pdf-filer som du vill sätta ihop och pdf-filer för att testa PDFA-verktygen
   * credentials - Den här mappen innehåller pdfa-options.json-filen

![resources-file](./assets/resources.png)

## Testa att sammanställa PDF-filer

* Kopiera och klistra in dina inloggningsuppgifter i tjänstens_token.json-resursfil i projektet.
* Öppna filen AssemblePDFFiles.java och ange i vilken mapp du vill spara de genererade PDF-filerna
* Öppna executeAssemblerService.java. Ange värdet för variabeln _AEM_FORMS_CS_ så att den pekar på din instans.
* Avkommentera lämpliga rader för att testa att sätta ihop två eller flera PDF-filer
* Kör ExecuteAssemblerService.java som java-program

### Testa PDFA-verktyg

* Kopiera och klistra in dina inloggningsuppgifter i tjänstens_token.json-resursfil i projektet.
* Öppna filen PDFAUtilities.java och ange i vilken mapp du vill spara de genererade PDF-filerna.
* Öppna executeAssemblerService.java. Ange värdet för variabeln _AEM_FORMS_CS_ så att den pekar på din instans.
* Avkommentera lämpliga rader för att testa PDFA-åtgärder.
* Kör ExecuteAssemblerService.java som java-program.



>[!NOTE]
> Första gången du kör java-programmet får du ett HTTP 403-fel. För att komma förbi detta måste du ge [lämplig behörighet till den tekniska kontoanvändaren i AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials.html?lang=sv-SE#configure-access-in-aem).

**AEM Forms-användare** är den roll jag har använt för kursen.
