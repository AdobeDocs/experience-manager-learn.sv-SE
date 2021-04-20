---
title: AEM arbetsflöde vid HTML5-formuläröverföring
seo-title: AEM arbetsflödet vid inskickning av HTML5-formulär
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
seo-description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
feature: Mobile Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '476'
ht-degree: 0%

---


# Få det här användningsexemplet att fungera på datorn

>[!NOTE]
>
>För att exempelresurserna ska fungera på datorn måste du ha AEM Author- och Publish-instansen på port 4502 respektive 4503. Det förutsätts också att AEM Author är tillgänglig via `admin`/`admin`. Om portnumren eller administratörslösenordet har ändrats fungerar inte dessa exempelresurser. Du måste skapa egna resurser med den angivna exempelkoden.

Följ de här stegen för att få det här användningsexemplet att fungera på din lokala dator:

* Installera AEM Author-instansen på port 4502 och AEM Publish-instansen på port 4503
* [Följ instruktionerna som anges i Utveckla för en servicecentral i AEM Forms](https://docs.adobe.com/content/help/en/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html). Se till att skapa tjänstanvändaren och distribuera paketet på din AEM Author- och Publish-instans.
* [Öppna SGB-konfigurationen  ](http://localhost:4503/system/console/configMgr).
* Sök efter **Refererarfilter för Apache Sling**. Kontrollera att kryssrutan Tillåt tomt är markerad.
* [Distribuera det anpassade AEMFormDocumentService Bundle](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar). Paketet måste distribueras till din AEM Publish-instans. Paketet innehåller koden som behövs för att generera interaktiv PDF från mobilformulär.
* [Hämta och zippa upp resurser som hör till den här artikeln.](assets/offline-pdf-submission-assets.zip) Du får följande
   * **offline-submission-profile.zip**  - Det här AEM innehåller den anpassade profilen som gör att du kan hämta den interaktiva PDF-filen till det lokala filsystemet. Distribuera det här paketet på din AEM Publish-instans.
   * **xdp-form-and-workflow.zip**  - Det här AEM innehåller XDP, exempelarbetsflöde, starcher konfigurerad för nodinnehåll/pdfsending. Distribuera det här paketet på både AEM Author- och Publish-instansen.
   * **HandlePDFSubmission.HandlePDFSubmission.core-1.0-SNAPSHOT.jar**  - Detta är det AEM paketet som utför merparten av arbetet. Paketet innehåller serverpaketet som är monterat på `/bin/startworkflow`. Den här servern sparar skickade formulärdata under `/content/pdfsubmissions`-noden i AEM. Distribuera det här paketet på både AEM Author- och Publish-instansen.
* [Förhandsgranska mobilformuläret](http://localhost:4503/content/dam/formsanddocuments/testsubmision.xdp/jcr:content)
* Fyll i flera fält och klicka sedan på knappen i verktygsfältet för att hämta den interaktiva PDF-filen.
* Fyll i den hämtade PDF-filen med Acrobat och tryck på Skicka.
* Du bör få ett meddelande om att du lyckats
* Logga in på AEM Author-instansen som administratör
* [Markera AEM](http://localhost:4502/aem/inbox)
* Du bör ha en arbetsuppgift för att granska den skickade PDF-filen

>[!NOTE]
>
>I stället för att skicka PDF-filen till en server som körs på en publiceringsinstans, har vissa kunder distribuerat servleten i en serverbehållare som Tomcat. Det beror helt på vilken topologi kunden är bekväm med. I den här självstudiekursen ska vi använda serverfunktionen som används på publiceringsinstansen för att hantera PDF-inskickade data.

