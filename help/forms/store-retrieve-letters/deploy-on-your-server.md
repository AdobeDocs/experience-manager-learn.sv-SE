---
title: Distribuera exempelresurserna på servern
description: Testa funktionen Spara som utkast för interaktiv kommunikation
feature: Interactive Communication
doc-type: article
version: Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
jira: KT-10208
exl-id: 9053ee29-436a-439a-b592-c3fef9852ea4
duration: 28
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '143'
ht-degree: 0%

---

# Distribuera exempelresurserna på servern

Följ instruktionerna nedan för att få den här funktionen att fungera på din AEM Server

* [Skapa databasschemat](assets/icdrafts.sql)
* [Importera klientbiblioteket](assets/icdrafts.zip)
* [Importera det adaptiva formuläret](assets/SavedDraftsAdaptiveForm.zip)
* Skapa en datakälla med namnet _SaveAndContinue_

![Skapa data-Source](assets/data-source.png)

| Egenskapsnamn | Egenskapsvärde |
|---|---|
| Namn på datakälla | `SaveAndContinue` |
| JDBC-drivrutinsklass | `com.mysql.cj.jdbc.Driver` |
| URL för JDBC-anslutning | `jdbc:mysql://localhost:3306/aemformstutorial?autoReconnect=true&useSSL=false&characterEncoding=utf8&useUnicode=true` |

* [Distribuera kasseringsprogrampaketet](assets/icdrafts.icdrafts.core-1.0-SNAPSHOT.jar)
* Se till att du _aktiverar Spara med CCRDocumentInstanceService_ i OSGI-konfigurationen enligt nedan
  ![Aktivera utkast](assets/enable-drafts.png)
* Öppna interaktiv kommunikation. Klicka på Spara som utkast för att spara
* [Visa sparade utkast](http://localhost:4502/content/dam/formsanddocuments/saveddrafts/jcr:content?wcmmode=disabled)

>[!NOTE]
>XML-filerna lagras i rotmappen för AEM-serverinstallationen. Du kan anpassa lösningen efter dina behov med hjälp av projektet >Förmörka.

Det överlappande projektet med exempelimplementering kan [hämtas härifrån](assets/icdrafts-eclipse-project.zip)
