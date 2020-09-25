---
title: Tagga och lagra AEM Forms DoR i DAM
seo-title: Tagga och lagra AEM Forms DoR i DAM
description: I den här artikeln går vi igenom hur du lagrar och taggar DoR-filer som genererats av AEM Forms i AEM DAM. Dokumentets taggning görs utifrån skickade formulärdata.
seo-description: I den här artikeln går vi igenom hur du lagrar och taggar DoR-filer som genererats av AEM Forms i AEM DAM. Dokumentets taggning görs utifrån skickade formulärdata.
uuid: b9ba13ed-52d5-4389-a7d5-bf85e58fea49
feature: adaptive-forms,workflow
topics: developing
audience: implementer
doc-type: article
activity: develop
version: 6.4,6.5
discoiquuid: 53961454-633b-4cd8-aef7-e64ab4e528e4
translation-type: tm+mt
source-git-commit: a0e5a99408237c367ea075762ffeb3b9e9a5d8eb
workflow-type: tm+mt
source-wordcount: '655'
ht-degree: 0%

---


# Tagga och lagra AEM Forms DoR i DAM {#tagging-and-storing-aem-forms-dor-in-dam}

I den här artikeln går vi igenom hur du lagrar och taggar DoR-filer som genererats av AEM Forms i AEM DAM. Dokumentets taggning görs utifrån skickade formulärdata.

En vanlig fråga från kunderna är att lagra och tagga det DoR-dokument som genererats av AEM Forms i AEM DAM. Dokumentets taggning måste baseras på inskickade data från Adaptive Forms. Om anställningsstatusen i inskickade data till exempel är &quot;Inaktuell&quot;, vill vi tagga dokumentet med taggen &quot;Inaktuell&quot; och lagra dokumentet i DAM.

Användningsexemplet är följande:

* En användare fyller i ett adaptivt formulär. I adaptiv form fångas användarens civilstånd (ex Single) och anställningsstatus (Ex pensionerad).
* När formulär skickas aktiveras ett AEM arbetsflöde. I det här arbetsflödet taggas dokumentet med civilstånd (Single) och anställningsstatus (pensionerad) och dokumentet sparas i DAM.
* När dokumentet har lagrats i DAM bör administratören kunna söka efter dokumentet med dessa taggar. Om du till exempel söker på En eller Återkallad hämtas rätt DoR-svar.

Ett anpassat processsteg skrevs för att uppfylla detta användningsfall. I det här steget hämtar vi värdena för lämpliga dataelement från skickade data. Sedan konstruerar vi taggplattan med det här värdet. Om värdet för elementet för civilstånd till exempel är &quot;Enskilt&quot; blir taggtiteln **Peak:EmploymentStatus/Single. **Med hjälp av TagManager API hittar vi taggen och använder den på DoR-taggen.

I följande kodutdrag visas hur du söker efter taggen och lägger till den i dokumentet.

```java
Tag tagFound = tagManager.resolveByTitle(tagTitle+xmlElement.getTextContent());
//tagTitle is "Peak:EmploymentStatus/" and the xmlElement.getTextContent() will return the value Single. So the tag title becomes Peak:EmploymentStatus/Single. Once the tag is found we put the tag in array and apply the tags to the resource as shown below
tagArray[i] = tagFound;
tagManager.setTags(metadata, tagArray, true);
```

Följ stegen nedan om du vill att det här exemplet ska fungera i ditt system:
* [Distribuera Developing with service user bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

* [Hämta och distribuera setvalue-paketet](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar). Detta är det anpassade OSGI-paketet som ställer in taggarna från skickade formulärdata.

* [Ladda ned exempelformuläret för anpassad redigering](assets/tag-and-store-in-dam-assets.zip)

* [Gå till Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)

* Klicka på Skapa | Filöverföring och överföring av exempel adaptiveform.zip

* [Importera artikelresurser](assets/tag-and-store-in-dam-assets.zip) med AEM pakethanterare
* Öppna [exempelformuläret i förhandsgranskningsläge](http://localhost:4502/content/dam/formsanddocuments/summit/peakform/jcr:content?wcmmode=disabled). Fyll i avsnittet Personer och skicka formuläret.
* [Navigera till mappen Peak i DAM](http://localhost:4502/assets.html/content/dam/Peak). Du bör se DoR i mappen Peak. Kontrollera dokumentets egenskaper. Den bör taggas på lämpligt sätt.
Grattis! Exemplet har installerats på datorn

* Låt oss utforska [arbetsflödet](http://localhost:4502/editor.html/conf/global/settings/workflow/models/TagAndStoreDoRinDAM.html) som aktiveras när formulär skickas in.
* Det första steget i arbetsflödet skapar ett unikt filnamn genom att sammanfoga de sökandes namn och land där de bor.
* I det andra steget i arbetsflödet skickas tagghierarkin och de formulärfältselement som måste taggas. Processsteget extraherar värdet från skickade data och skapar den taggtitel som ska tagga dokumentet.
* Om du vill lagra DoR i en annan mapp i DAM anger du mapplatsen med konfigurationsegenskaperna som anges i skärmbilden nedan.

De andra två parametrarna är specifika för DoR och Datafilssökvägen enligt vad som anges i alternativen för att skicka adaptiva formulär. Kontrollera att de värden du anger här matchar de värden du angav i alternativen för att skicka adaptiva formulär.

![Tagg Dor](assets/tag_dor_service_configuration.gif)

