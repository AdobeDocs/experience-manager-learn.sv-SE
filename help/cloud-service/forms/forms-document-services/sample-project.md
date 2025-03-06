---
title: Exempelprojekt
description: Exempelprojekt som kan importeras och köras i din miljö
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
source-wordcount: '94'
ht-degree: 0%

---


# Testa det i din lokala miljö

* Importera projektet

   * Hämta och extrahera [exempelprojektet](./assets/formsdocumentservices.zip)
   * Öppna önskad **Java Development Environment**(IntelliJ IDEA, Eclipse eller VS Code) och importera projektet som Maven-projekt
* Konfigurera autentiseringsuppgifter

   * Hitta filen `resources/credentials/server_credentials.json`
   * Öppna den och **uppdatera autentiseringsuppgifterna** som är specifika för din miljö.
   * Kontrollera att den innehåller giltiga värden för:
     `clientId`, `clientSecret`,`adobeIMSV3TokenEndpointURL` och
     `scopes`

* Kör klassen Main

   * Navigera till `src/main/java/Main.java` och kör huvudmetoden

* Verifiera körning
   * Verifiera utdata i terminalfönstret

