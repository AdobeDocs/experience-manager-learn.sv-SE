---
title: Markera och hämta innehåll i DAM-mappen
description: Distribuera självstudieresurserna till den lokala AEM instansen
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2023-01-04T00:00:00Z
source-git-commit: a2bbb26751c9182056b4fe6d36eeeec964001df8
workflow-type: tm+mt
source-wordcount: '152'
ht-degree: 1%

---

# Driftsätt i ditt system

Följ stegen nedan för att få det här användningsexemplet att fungera på din lokala AEM.

* [Konfigurera för att använda fd-service-användare genom att följa stegen som nämns i den här artikeln](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html?lang=en). Kontrollera att du har distribuerat paketet DevelopingWithServiceUser.

* [Distribuera nyhetsbrevet](assets/Newsletters.core-1.0.0-SNAPSHOT.jar). Paketet innehåller koden som listar mappinnehållet och sätter ihop de valda nyhetsbreven.

* [Importera paketet med hjälp av pakethanteraren](assets/newsletter.zip). Paketet innehåller klientbibliotek och exempel på PDF-filer för att testa lösningen.

* [Importera exempelformuläret](assets/sample-adaptive-form.zip). I det här formuläret visas de nyhetsbrev som kan väljas.

* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/downloadarchivednewsletters/jcr:content?wcmmode=disabled).
Välj några nyhetsbrev att ladda ned.De valda nyhetsbreven kombineras till en PDF och returneras till dig.




