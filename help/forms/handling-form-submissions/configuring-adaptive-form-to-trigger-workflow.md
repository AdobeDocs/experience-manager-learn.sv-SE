---
title: Konfigurera anpassat formulär som utlöser AEM
description: Konfigurera nyttolastalternativ när AEM aktiveras när formulär skickas
sub-product: formulär
feature: arbetsflöde
topics: integrations
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
kt: 5407
thumbnail: 40258.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '167'
ht-degree: 0%

---


# Konfigurera anpassat formulär som utlöser AEM

## Förutsättningar

Exempelformuläret som används i det här arbetsflödet är baserat på en anpassad adaptiv formulärmall som måste importeras till din AEM. Det angivna exempelformuläret måste importeras när mallen har importerats.

### Hämta adaptiva formulärmallar

* Hämta [anpassad formulärmall](assets/af-form-template.zip)
* [Importera mallen med hjälp av pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Överför och installera mallen för adaptiva formulär

### Hämta exemplet Adaptiv form

* Hämta [anpassningsbart formulär](assets/peak-application-form.zip)
* Bläddra till [formulär och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa -> Filöverföring
* Det adaptiva exempelformuläret placeras i en mapp med namnet [Application Forms](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments/applicationforms)

I följande video förklaras hur du konfigurerar ett adaptivt formulär för att aktivera ett AEM arbetsflöde
>[!VIDEO](https://video.tv.adobe.com/v/40258/?quality=9&learn=on)

I följande video visas arbetsflödets nyttolast och annan information i crx-databasen

>[!VIDEO](https://video.tv.adobe.com/v/40259/?quality=9&learn=on)


