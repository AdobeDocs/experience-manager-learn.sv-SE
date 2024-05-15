---
title: Distribuera resurserna lokalt
description: Distribuera självstudieresurserna till den lokala AEM instansen
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2023-01-04T00:00:00Z
exl-id: d23b51ba-1efb-4505-b5b3-44a02177e467
duration: 27
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '140'
ht-degree: 0%

---

# Driftsätt i ditt system

Följ stegen nedan för att få det här användningsexemplet att fungera på din lokala AEM.

* [Distribuera paketet DevelopingWithServiceUser](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/developingwithserviceuser.zip) som finns i zip-filen.

* Lägg till följande post i användarmappningstjänsten för Apache Sling **DevelopingWithServiceUser.core:getformsresourceReser=fd-service** med [configMgr](http://localhost:4502/system/console/configMgr).

* [Distribuera nyhetsbrevet](assets/Newsletters.core-1.0.0-SNAPSHOT.jar). Paketet innehåller koden som listar mappinnehållet och sätter ihop de valda nyhetsbreven.

* [Importera paketet med hjälp av Pakethanteraren](assets/newsletter.zip). Paketet innehåller klientbibliotek och exempel på PDF-filer för att testa lösningen.

* [Importera det adaptiva exempelformuläret](assets/sample-adaptive-form.zip). I det här formuläret visas de nyhetsbrev som kan väljas.

* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/downloadarchivednewsletters/jcr:content?wcmmode=disabled).
Välj några nyhetsbrev att ladda ned.De valda nyhetsbreven kombineras till en PDF och returneras till dig.
