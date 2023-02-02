---
title: Distribuera resurserna lokalt
description: Distribuera självstudieresurserna till den lokala AEM instansen
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2023-01-04T00:00:00Z
source-git-commit: ddef90067d3ae4a3c6a705b5e109e474bab34f6d
workflow-type: tm+mt
source-wordcount: '158'
ht-degree: 1%

---

# Driftsätt i ditt system

Följ stegen nedan för att få det här användningsexemplet att fungera på din lokala AEM.

* [Distribuera paketet DevelopingWithServiceUser](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/developingwithserviceuser.zip) som finns i zip-filen.

* Lägg till följande post i användarmappningstjänsten för Apache Sling **DevelopingWithServiceUser.core:getformsresourceReser=fd-service** med [configMgr](http://localhost:4502/system/console/configMgr).

* [Distribuera nyhetsbrevet](assets/Newsletters.core-1.0.0-SNAPSHOT.jar). Paketet innehåller koden som listar mappinnehållet och sätter ihop de valda nyhetsbreven.

* [Importera paketet med hjälp av pakethanteraren](assets/newsletter.zip). Paketet innehåller klientbibliotek och exempel på PDF-filer för att testa lösningen.

* [Importera exempelformuläret](assets/sample-adaptive-form.zip). I det här formuläret visas de nyhetsbrev som kan väljas.

* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/downloadarchivednewsletters/jcr:content?wcmmode=disabled).
Välj några nyhetsbrev att ladda ned.De valda nyhetsbreven kombineras till en PDF och returneras till dig.




