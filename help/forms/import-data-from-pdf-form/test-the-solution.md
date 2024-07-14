---
title: Importera data från en PDF-fil till ett anpassat formulär
description: Självstudiekurs för att fylla i ett anpassat formulär genom att importera en PDF-fil
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
exl-id: f21753b2-f065-4556-add4-b1983fb57031
duration: 21
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '117'
ht-degree: 0%

---

# Distribuera exempelresurserna

Du kan distribuera exempelresurserna för att få lösningen att fungera på din lokala AEM Forms-instans

* [Importera klientbiblioteket och den anpassade komponenten för att överföra PDF-formuläret via Package Manager](./assets/client-libs-custom-component.zip)
* Hämta och distribuera paketet med OSGi-webbkonsolen[Custom Document Services Bundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
* Hämta och distribuera paketet med OSGi-webbkonsolen [Developing with Service User Bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* Hämta och distribuera paketet med OSGi-webbkonsolen[importera data från PDF-filen](./assets/onlineToOffline.core-1.0.0-SNAPSHOT.jar)
* Lägg till posten _**DevelopingWithServiceUser.core:getresouresolver=data**_ i _**Användarmappningstjänsten för Apache Sling-tjänsten**_ OSGi-konfigurationskonsolen
