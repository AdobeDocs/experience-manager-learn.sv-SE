---
title: Komma igång med AEM Sites - Project Archetype
description: Komma igång med AEM Sites - Project Archetype. WKND-självstudiekursen är en självstudiekurs i flera delar som utformats för utvecklare som är nybörjare på Adobe Experience Manager. Självstudiekursen går igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND. Självstudiekursen behandlar grundläggande ämnen som projektinställningar, prototyper, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling.
sub-product: platser
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
index: y
feature: Huvudkomponenter, sidredigeraren, redigerbara mallar, AEM projekttyp
topic: Innehållshantering, utveckling
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: fb6c56dfc85fbcb36a68210f068fd496849c352e
workflow-type: tm+mt
source-wordcount: '502'
ht-degree: 3%

---


# Komma igång med AEM Sites - Project Archetype {#project-archetype}

Välkommen till en självstudiekurs i flera delar som är utformad för utvecklare som är nybörjare i Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND.

Den här självstudien börjar med att använda [AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html) för att generera ett nytt projekt.

Självstudiekursen är utformad för att fungera med **AEM som en Cloud Service** och är bakåtkompatibel med **AEM 6.5.5.0+** och **AEM 6.4.8.1+**. Webbplatsen implementeras med:

* [Maven AEM Project Archetype](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/overview.html)
* [Kärnkomponenter](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html)
* [HTL](https://docs.adobe.com/content/help/en/experience-manager-htl/using/getting-started/getting-started.html)
* Sling Models
* [Redigerbara mallar](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html)
* [Formatsystem](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/style-system-feature-video-use.html)

*Beräkna 1-2 timmar för att komma igenom varje del av självstudiekursen.*

## Lokal utvecklingsmiljö {#local-dev-environment}

En lokal utvecklingsmiljö krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM som en Cloud Service-SDK som körs i en Mac OS-miljö med [Visual Studio Code](https://code.visualstudio.com/) som IDE. Kommandon och kod ska vara oberoende av det lokala operativsystemet, om inget annat anges.

### Nödvändig programvara

Följande bör installeras lokalt:

* Lokal AEM **Författare** instans (Cloud Service SDK, 6.5.5+ eller 6.4.8.1+)
* [Java 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
* [Apache Maven](https://maven.apache.org/)  (3.3.9 eller senare)
* [Node.js](https://nodejs.org/en/) (LTS - långsiktigt stöd)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)
* [Visual Studio ](https://code.visualstudio.com/) Codeor equivalent IDE
   * [VSCode AEM Sync](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync)  - Verktyg som används genomgående i självstudiekursen

>[!NOTE]
>
> **Är du inte AEM som Cloud Service?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM som Cloud Service-SDK](https://docs.adobe.com/content/help/en/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).
>
> **Har du inte använt AEM 6.5 tidigare?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö](https://docs.adobe.com/content/help/en/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## Github {#github}

All kod för projektet finns i Github i AEM:

**[GitHub: WKND Sites Project](https://github.com/adobe/aem-guides-wknd)**

Dessutom har varje del av självstudiekursen en egen gren i GitHub. Användaren kan börja självstudiekursen när som helst genom att helt enkelt checka ut den gren som motsvarar föregående del.

## Nästa steg {#next-steps}

Vad väntar du på?! Starta självstudiekursen genom att gå till kapitlet [Projektinställningar](project-setup.md) och lär dig hur du skapar ett nytt Adobe Experience Manager-projekt med hjälp av den AEM projektarkitypen.
