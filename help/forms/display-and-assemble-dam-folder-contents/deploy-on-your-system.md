---
title: Distribuera resurserna lokalt
description: Distribuera självstudieresurserna till din lokala AEM-instans
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2023-01-04T00:00:00Z
exl-id: d23b51ba-1efb-4505-b5b3-44a02177e467
duration: 27
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '140'
ht-degree: 0%

---

# Driftsätt i ditt system

Följ stegen nedan för att få det här användningsexemplet att fungera på din lokala AEM-instans.

* [Distribuera DevelopingWithServiceUser-paketet](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/developingwithserviceuser.zip?lang=sv-SE) som finns i zip-filen.

* Lägg till följande post i användarmappningstjänsten för Apache Sling Service **DevelopingWithServiceUser.core:getformsresourceServer=fd-service** med [configMgr](http://localhost:4502/system/console/configMgr).

* [Distribuera nyhetsbrevet](assets/Newsletters.core-1.0.0-SNAPSHOT.jar). Paketet innehåller koden som listar mappinnehållet och sätter ihop de valda nyhetsbreven.

* [Importera paketet med pakethanteraren](assets/newsletter.zip). Paketet innehåller klientbibliotek och exempel på PDF-filer för att testa lösningen.

* [Importera det adaptiva exempelformuläret](assets/sample-adaptive-form.zip). I det här formuläret visas de nyhetsbrev som kan väljas.

* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/downloadarchivednewsletters/jcr:content?wcmmode=disabled).
Välj några nyhetsbrev att ladda ned.De valda nyhetsbreven kombineras till en PDF och returneras till dig.
