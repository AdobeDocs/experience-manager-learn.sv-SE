---
title: Acrobat med AEM Forms
description: En självstudiekurs som visar hur du skapar ett adaptivt formulär med Acrobat och sammanfogar data för att få ett PDF. PDF med sammanfogade data kan sedan skickas för signering med Adobe Sign.
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4
source-git-commit: 307ed6cd25d5be1e54145406b206a78ec878d548
workflow-type: tm+mt
source-wordcount: '254'
ht-degree: 0%

---


# Skapa adaptiv Forms från Acrobat

Organisationer har en mängd olika typer av formulär. Vissa av dessa formulär skapas i Microsoft Word och konverteras till PDF. Dessa formulär kan som standard inte fyllas i med Adobe Reader eller Acrobat. För att göra dessa formulär ifyllbara med Acrobat eller Reader måste vi konvertera formulären till Acrobat. Acrobat är formulär som skapats med Acrobat. I den här artikeln går vi igenom hur du skapar ett adaptivt formulär från Acrobat och sammanfogar data i Acrobat för att få PDF. PDF med sammanfogade data kan också skickas för signering med Adobe Sign.

>[!NOTE]
>
>Om du använder AEM Forms 6.5 ska du använda funktionen Automated forms conversion.

## Förutsättningar

* AEM Forms 6.3 eller 6.4 har installerats och konfigurerats
* Tillgång till Adobe Acrobat
* Bekanta dig med AEM/AEM Forms.

### Följande krävs för att den här funktionen ska fungera i ditt system

* Hämta och distribuera paketen med [Felix Web Console](http://localhost:4502/system/console/bundles)
* [DocumentServicesBundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar)
* [UtvecklaMedTjänstanvändare](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* [AcroFormsToAEMFormsBundle](https://forms.enablementadobe.com/content/DemoServerBundles/AcroFormToAEMForm.core-1.0-SNAPSHOT.jar)
* [Hämta och importera det här paketet till AEM](assets/acro-form-aem-form.zip). Det här paketet innehåller exempelarbetsflödet och HTML-sidan för att skapa XSD från acroform
* Öppna [configMgr](http://localhost:4502/system/console/configMgr)
   * Sök efter användarmappningstjänsten för Apache Sling-tjänsten och klicka för att öppna egenskaperna
   * Klicka på `+` ikon (plus) för att lägga till följande Service Mapping
      * `DevelopingWithServiceUser.core:getresourceresolver=data`
      * `DevelopingWithServiceUser.core:getformsresourceresolver=fd-service`
   * Klicka på Spara
