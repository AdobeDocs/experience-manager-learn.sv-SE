---
title: Distribuera exemplet på den lokala servern
description: Multidelad självstudiekurs som visar hur du går igenom stegen för att fråga efter formuläröverföringar som lagras i Azure Portal
feature: Adaptive Forms
doc-type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Experienced
jira: kt-14884
last-substantial-update: 2024-03-03T00:00:00Z
exl-id: 44841a3c-85e0-447f-85e2-169a451d9c68
duration: 20
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '117'
ht-degree: 0%

---

# Distribuera exemplet på den lokala servern

Följ stegen nedan om du vill att den här användningen ska fungera på den lokala servern. Vi antar att AEM körs på den lokala värden, 4502-port.

* [Installera paketet](assets/azuredemo.all-1.0.0-SNAPSHOT.zip) med pakethanteraren.

* Ange autentiseringsuppgifterna för Azure-portalen med OSGi configMgr
  ![azure-portal](assets/azure-portal-config.png)
Kontrollera att lagrings-URI avslutas med ett snedstreck och att SAS-token börjar med ett ?
* Navigera till [AzureDemo](http://localhost:4502/libs/fd/fdm/gui/components/admin/fdmcloudservice/fdm.html/conf/azuredemo)

* Redigera autentiseringsinställningarna för följande tre datakällor så att de matchar din miljö
  ![datakällor](assets/fdm-data-sources.png)

* Förhandsgranska och skicka [formuläret Kontakta oss](http://localhost:4502/content/dam/formsanddocuments/azureportal/contactus/jcr:content?wcmmode=disabled)

* [Fråga när formulär skickas](http://localhost:4502/content/dam/formsanddocuments/azureportal/queryformsubmissions/jcr:content?wcmmode=disabled)
