---
title: AEM arbetsflöde för att skicka HTML5-formulär - få användningsfallet att fungera
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
feature: Mobile Forms
doc-type: article
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 79935ef0-bc73-4625-97dd-767d47a8b8bb
duration: 111
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '435'
ht-degree: 0%

---

# Få det här användningsexemplet att fungera på datorn

>[!NOTE]
>
>För att exempelresurserna ska fungera på datorn måste du ha AEM Author och Publish-instansen på port 4502 respektive 4503. Det förutsätts också att AEM författare kan nås via `admin`/`admin`. Om portnumren eller administratörslösenordet har ändrats fungerar inte dessa exempelresurser. Du måste skapa egna resurser med den angivna exempelkoden.

Följ de här stegen för att få det här användningsexemplet att fungera på din lokala dator:

* Installera AEM Author-instans på port 4502 och AEM Publish-instans på port 4503
* [Följ instruktionerna som anges i Utveckla med tjänstanvändare i AEM Forms](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/service-user-tutorial-develop.html). Se till att skapa tjänstanvändaren och distribuera paketet till AEM Author och Publish.
* [Öppna SGB-konfigurationen](http://localhost:4503/system/console/configMgr).
* Sök efter  **Apache Sling Referer-filter**. Kontrollera att kryssrutan Tillåt tomt är markerad.
* [Distribuera det anpassade paketet AEMFormDocumentService](/help/forms/assets/common-osgi-bundles/AEMFormsDocumentServices.core-1.0-SNAPSHOT.jar).Det här paketet måste distribueras till din AEM Publish-instans. Det här paketet innehåller koden för att generera interaktiv PDF från mobilformulär.
* [Hämta och zippa upp resurser som hör till den här artikeln.](assets/offline-pdf-submission-assets.zip) Du får följande
   * **offline-submission-profile.zip** - Det här AEM innehåller den anpassade profilen som gör att du kan hämta den interaktiva PDF-filen till det lokala filsystemet. Distribuera det här paketet på din AEM Publish-instans.
   * **xdp-form-and-workflow.zip** - Det här AEM innehåller XDP, exempelarbetsflöde, starcher konfigurerad för nodinnehåll/pdfSubmissions. Distribuera det här paketet på både AEM Author och Publish.
   * **HandlePDFSubmission.HandlePDFSubmission.core-1.0-SNAPSHOT.jar** - Detta är det AEM paketet som gör merparten av arbetet. Det här paketet innehåller serverpaketet som är monterat på `/bin/startworkflow`. Den här servern sparar skickade formulärdata under `/content/pdfsubmissions` nod i AEM. Distribuera det här paketet på både AEM Author och Publish.
* [Förhandsgranska mobilformuläret](http://localhost:4503/content/dam/formsanddocuments/testsubmision.xdp/jcr:content)
* Fyll i flera fält och klicka sedan på knappen i verktygsfältet för att hämta den interaktiva PDF.
* Fyll i PDF med Acrobat och tryck på Skicka.
* Du bör få ett meddelande om att du lyckats
* Logga in på AEM Author instance som admin
* [Markera AEM inkorg](http://localhost:4502/aem/inbox)
* Du bör ha en arbetsuppgift för att granska den inskickade PDF

>[!NOTE]
>
>I stället för att skicka PDF till serverpaketet som körs på en publiceringsinstans har vissa kunder distribuerat serverpaketet i en serverbehållare som Tomcat. Det beror helt på vilken topologi kunden är bekväm med. I den här självstudiekursen ska vi använda serverfunktionen som används på publiceringsinstansen för att hantera PDF-inskickade data.
