---
title: Testa lösningen
description: Kör ExecuteAssemblerService.java för att testa lösningen
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
source-git-commit: b7ff98dccc1381abe057a80b96268742d0a0629b
workflow-type: tm+mt
source-wordcount: '174'
ht-degree: 0%

---

# Importera Eclipse-projekt

* Ladda ned och zippa upp [zip-fil](./assets/pdf-manipulation.zip)
* Starta Eclipse och importera projektet till Eclipse
* Projektet innehåller följande mappar i resursmappen:
   * ddxFiles - Den här mappen innehåller ddx-filen som beskriver utdata som du vill generera
   * pdffiles - Den här mappen innehåller de pdf-filer som du vill montera

![resources-file](./assets/resources.png)

## Testa lösningen

* Kopiera och klistra in dina inloggningsuppgifter i tjänstens_token.json-resursfil i projektet.
* Öppna filen AssemblePDFFiles.java och ange i vilken mapp du vill spara de genererade PDF-filerna
* Öppna ExecuteAssemblerService.java. Ange värdet för variabeln assembleURL så att det pekar på din instans.
* Kör ExecuteAssemblerService.java som java-program

>[!NOTE]
> Första gången du kör java-programmet får du ett HTTP 403-fel. För att komma förbi detta måste du [lämplig behörighet för den tekniska kontoanvändaren i AEM](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/service-credentials.html?lang=en#configure-access-in-aem).

**AEM Forms-användare** Det är den roll jag har använt för den här kursen.
