---
title: Använda AEM för att gå över till AEM as a Cloud Service
description: Lär dig hur AEM modereringsverktyg används för att uppgradera ett befintligt AEM och innehåll som ska vara AEM as a Cloud Service kompatibelt.
version: Cloud Service
topic: Migration, Upgrade
role: Developer
level: Experienced
kt: 8629
thumbnail: 336965.jpeg
exl-id: 310f492c-0095-4015-81a4-27d76f288138
source-git-commit: 3657e7798774f9cc673ff6ccd8af1a555b1d4013
workflow-type: tm+mt
source-wordcount: '325'
ht-degree: 1%

---


# AEM Modernization Tools

Läs om hur AEM modernisaliseringsverktyg används för att uppgradera befintligt AEM Sites-innehåll så att det är AEM as a Cloud Service kompatibelt och följer vedertagna standarder.

>[!VIDEO](https://video.tv.adobe.com/v/336965/?quality=12&learn=on)

## Använda AEM

![AEM verktygets livscykel](./assets/aem-modernization-tools.png)

AEM verktyg för modernisering konverterar automatiskt befintliga AEM sidor som består av gamla statiska mallar, grundkomponenter och parsys, och använder moderna metoder som redigerbara mallar, AEM viktiga WCM-komponenter och layoutbehållare.

### Viktiga aktiviteter

+ Klona AEM 6.x-produktion och kör AEM moderniseringsverktyg mot
+ Hämta och installera [de senaste AEM moderniseringsverktygen](https://github.com/adobe/aem-modernize-tools/releases/latest) på AEM 6.x-produktionsklonen via Package Manager

+ [Sidstrukturkonverterare](https://opensource.adobe.com/aem-modernize-tools/pages/tools/page-structure.html) uppdaterar befintligt sidinnehåll från statisk mall till en mappad redigerbar mall med layoutbehållare
   + Definiera konverteringsregler med OSGi-konfiguration
   + Kör sidstrukturkonverteraren mot befintliga sidor

+ [Komponentkonverterare](https://opensource.adobe.com/aem-modernize-tools/pages/tools/component.html) uppdaterar befintligt sidinnehåll från statisk mall till en mappad redigerbar mall med layoutbehållare
   + Definiera konverteringsregler via JCR-noddefinitioner/XML
   + Kör komponentkonverteringsverktyget mot befintliga sidor

+ [Principimporteraren](https://opensource.adobe.com/aem-modernize-tools/pages/tools/policy-importer.html) skapar profiler från designkonfigurationen
   + Definiera konverteringsregler med JCR-noddefinitioner/XML
   + Kör principimporteraren mot befintliga designdefinitioner
   + Använd importerade profiler på AEM och behållare

+ [Dialogrutekonverterare](https://opensource.adobe.com/aem-modernize-tools/pages/tools/dialog.html) I konverteras Classic(ExtJS) och CoralUI 2-baserade komponentdialogrutor till TouchUI 3-baserade dialogrutor.
   + Kör verktyget Dialogrutekonverterare mot befintliga dialogrutor baserade på användargränssnittet i ExtJS eller Coral2
   + Synkronisera konverterade dialogrutor tillbaka till Git-databasen

### Andra resurser

+ [Ladda ned verktyg för AEM](https://github.com/adobe/aem-modernize-tools/releases/latest)
+ [Dokumentation för AEM Moderniseringsverktyg](https://opensource.adobe.com/aem-modernize-tools/)
+ [AEM Gems - Introduktion till AEM Modernization Suite](https://helpx.adobe.com/experience-manager/kt/eseminars/gems/Introducing-the-AEM-Modernization-Suite.html)
