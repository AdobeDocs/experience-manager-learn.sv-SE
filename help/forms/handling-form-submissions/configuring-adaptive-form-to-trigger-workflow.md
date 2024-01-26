---
title: Konfigurera anpassat formulär för att aktivera AEM arbetsflöde - översikt
description: Konfigurera nyttolastalternativ när AEM aktiveras när formulär skickas
feature: Workflow
doc-type: article
version: 6.4,6.5
jira: KT-5407
thumbnail: 40258.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 9f1dbd02-774a-4b84-90fa-02d4e468cbac
last-substantial-update: 2020-07-07T00:00:00Z
duration: 583
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '148'
ht-degree: 0%

---

# Konfigurera anpassat formulär som utlöser AEM

## Förutsättningar

Exempelformuläret som används i det här arbetsflödet är baserat på en anpassad adaptiv formulärmall som måste importeras till din AEM. Det angivna exempelformuläret måste importeras när mallen har importerats.

### Hämta adaptiva formulärmallar

* Ladda ned [Adaptiv formulärmall](assets/af-form-template.zip)
* [Importera mallen med pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Överför och installera mallen för adaptiva formulär

### Hämta exemplet med adaptiv form

* Ladda ned [Adaptiv form](assets/peak-application-form.zip)
* Bläddra till [Formulär och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa -> Filöverföring
* Det adaptiva exempelformuläret placeras i en mapp som heter [Forms](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments/applicationforms)

I följande video förklaras hur du konfigurerar ett adaptivt formulär för att aktivera ett AEM arbetsflöde
>[!VIDEO](https://video.tv.adobe.com/v/40258?quality=12&learn=on)

I följande video visas arbetsflödets nyttolast och annan information i crx-databasen

>[!VIDEO](https://video.tv.adobe.com/v/40259?quality=12&learn=on)
