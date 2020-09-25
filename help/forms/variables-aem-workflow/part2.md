---
title: Variabler i AEM [del2]
seo-title: Variabler i AEM [del2]
description: Använda variabler av typen xml,json,arraylist,dokument i aem-arbetsflöde
seo-description: Använda variabler av typen xml,json,arraylist,dokument i aem-arbetsflöde
feature: workflow
topics: development
audience: developer
doc-type: tutorial
activity: understand
version: 6.5
translation-type: tm+mt
source-git-commit: 22ccd6627a035b37edb180eb4633bc3b57470c0c
workflow-type: tm+mt
source-wordcount: '318'
ht-degree: 0%

---

# Variabler av typen JSON i AEM

Från och med AEM Forms 6.5 kan vi nu skapa variabler av typen JSON i AEM. Vanligtvis skapar du variabler av typen JSON om du skickar Adaptive Forms baserat på JSON-schema till ett AEM arbetsflöde eller om du vill lagra resultatet av en anropsåtgärd för formulärdatamodell. I följande videofilm får du hjälp med att skapa och använda en variabel av typen JSON i AEM arbetsflöde
>[!NOTE]

**Om du använder AEM Forms 6.5.0**

När du skapar en variabel av typen JSON för att hämta inskickade data i arbetsflödesmodellen ska du inte associera JSON-schemat med variabeln. Detta beror på att inskickade data inte är kompatibla med JSON-schemabildet när du skickar ett anpassat JSON-schema. JSON-schemaklagodata omsluts av elementet afData.afBoundData.data.

**Om du använder AEM Forms 6.5.1 och senare**

Du kan mappa schemat med variabeln av typen JSON i arbetsflödesmodellen. Du kan sedan använda schemaläsaren för att mappa schemaelementen med dina sträng-/talvariabler i arbetsflödesmodellen

>[!VIDEO](https://video.tv.adobe.com/v/26444?quality=12&learn=on)

**Möjligheten att detaljgranska schemaelement och mappa schemaelementet till arbetsflödesvariabeln är endast tillgänglig med och från AEM Forms 6.5.1.**

>[!VIDEO](https://video.tv.adobe.com/v/28097?quality=12&learn=on)

Följ de här stegen för att få resurserna att fungera i ditt system:

* [Hämta och importera resurser till AEM med hjälp av pakethanteraren](assets/jsonandstringvariable.zip)
* [Utforska arbetsflödesmodellen](http://localhost:4502/editor.html/conf/global/settings/workflow/models/jsonvariable.html) för att förstå de variabler som används i arbetsflödet
* [Konfigurera e-posttjänsten](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/notification.html#ConfiguringtheMailService)
* [Öppna det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/afbasedonjson/jcr:content?wcmmode=disabled)
* Fyll i uppgifterna och skicka in formuläret
