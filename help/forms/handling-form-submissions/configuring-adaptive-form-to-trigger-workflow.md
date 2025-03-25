---
title: Konfigurera anpassat formulär som utlöser en översikt över AEM Workflow
description: Konfigurera nyttolastalternativ när AEM-arbetsflöde aktiveras när formulär skickas
feature: Workflow
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-5407
thumbnail: 40258.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 9f1dbd02-774a-4b84-90fa-02d4e468cbac
last-substantial-update: 2020-07-07T00:00:00Z
duration: 573
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '148'
ht-degree: 0%

---

# Konfigurera anpassat formulär som utlöser AEM Workflow

## Förutsättningar

Exempelformuläret som används i det här arbetsflödet är baserat på en anpassad, anpassad formulärmall som måste importeras till din AEM-server. Det angivna exempelformuläret måste importeras när mallen har importerats.

### Hämta adaptiva formulärmallar

* Hämta [Adaptiv formulärmall](assets/af-form-template.zip)
* [Importera mallen med pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Överför och installera mallen för adaptiva formulär

### Hämta exemplet med adaptiv form

* Hämta [anpassat formulär](assets/peak-application-form.zip)
* Bläddra till [formulär och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa -> Filöverföring
* Det adaptiva exempelformuläret placeras i en mapp med namnet [Application Forms](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments/applicationforms)

I följande video förklaras hur du konfigurerar ett adaptivt formulär för att aktivera ett AEM-arbetsflöde
>[!VIDEO](https://video.tv.adobe.com/v/40258?quality=12&learn=on)

I följande video visas arbetsflödets nyttolast och annan information i crx-databasen

>[!VIDEO](https://video.tv.adobe.com/v/40259?quality=12&learn=on)
