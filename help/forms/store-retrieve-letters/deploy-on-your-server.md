---
title: Distribuera exempelresurserna på servern
description: Testa funktionen Spara som utkast för interaktiv kommunikation
feature: Interactive Communication
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.5
topic: Development
role: Developer
level: Intermediate
jira: KT-10208
exl-id: 9053ee29-436a-439a-b592-c3fef9852ea4
source-git-commit: 30d6120ec99f7a95414dbc31c0cb002152bd6763
workflow-type: tm+mt
source-wordcount: '165'
ht-degree: 0%

---

# Distribuera exempelresurserna på servern

Följ instruktionerna nedan för att få den här funktionen att fungera på din AEM

* [Skapa databasschemat](assets/icdrafts.sql)
* [Importera klientbiblioteket](assets/icdrafts.zip)
* [Importera det adaptiva formuläret](assets/SavedDraftsAdaptiveForm.zip)
* Skapa datakälla anropad _SparaOchFortsätt_

![Skapa datakälla](assets/data-source.png)

| Egenskapsnamn | Egenskapsvärde |
|---|---|
| Namn på datakälla | SparaOchFortsätt |
| JDBC-drivrutinsklass | com.mysql.cj.jdbc.Driver |
| URL för JDBC-anslutning | jdbc:mysql://localhost:3306/aemformstutorial?autoReconnect=true&amp;useSSL=false&amp;characterEncoding=utf8&amp;useUnicode=true |

* [Distribuera kasseringsprogrampaketet](assets/icdrafts.icdrafts.core-1.0-SNAPSHOT.jar)
* Se till att du _Aktivera Spara med CCRDocumentInstanceService_ i OSGI-konfigurationen enligt nedan
  ![Aktivera utkast](assets/enable-drafts.png)
* Öppna interaktiv kommunikation. Klicka på Spara som utkast för att spara
* [Visa sparade utkast](http://localhost:4502/content/dam/formsanddocuments/saveddrafts/jcr:content?wcmmode=disabled)

>[!NOTE]
>XML-filerna lagras i rotmappen i AEM serverinstallation. Du kan anpassa lösningen efter dina behov med hjälp av projektet >Förmörka.

Det explicita projektet med exempelimplementering kan [hämtad härifrån](assets/icdrafts-eclipse-project.zip)
