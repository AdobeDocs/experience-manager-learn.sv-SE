---
title: Komma igång med AEM Sites - Project Archetype
description: Komma igång med AEM Sites - Project Archetype. WKND-självstudiekursen är en självstudiekurs i flera delar som utformats för utvecklare som är nybörjare på Adobe Experience Manager. Självstudiekursen går igenom implementeringen av en AEM-sajt för ett fiktivt livsstilsmärke, WKND. Självstudiekursen behandlar grundläggande ämnen som projektinställningar, prototyper, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling.
version: Experience Manager 6.5, Experience Manager as a Cloud Service
feature: Core Components, Page Editor, Editable Templates, AEM Project Archetype
topic: Content Management, Development
role: Developer
level: Beginner
mini-toc-levels: 1
index: y
doc-type: Tutorial
exl-id: 90d14734-f644-4a45-9361-1e47a5b52fff
recommendations: disable
duration: 74
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '414'
ht-degree: 0%

---

# Komma igång med AEM Sites - Project Archetype {#project-archetype}

{{edge-delivery-services-and-page-editor}}

Välkommen till en självstudiekurs i flera delar som utformats för utvecklare som inte använt Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en AEM-sajt för ett påhittat livsstilsmärke, WKND.

Den här självstudien börjar med att använda [AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html) för att generera ett nytt projekt.

Självstudiekursen är utformad för att fungera med **AEM as a Cloud Service** och är bakåtkompatibel med **AEM 6.5.14+**. Webbplatsen implementeras med:

* [Maven AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html)
* [Kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
* [HTML](https://experienceleague.adobe.com/docs/experience-manager-htl/content/getting-started.html)
* [Sling Models](https://sling.apache.org/documentation/bundles/models.html)
* [Redigerbara mallar](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html)
* [Formatsystem](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/page-authoring/style-system-feature-video-use.html)

*Beräkna 1-2 timmar för att komma igenom varje del av självstudiekursen.*

## Lokal utvecklingsmiljö {#local-dev-environment}

En lokal utvecklingsmiljö krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM as a Cloud Service SDK som körs i en macOS-miljö med [Visual Studio Code](https://code.visualstudio.com/) som IDE. Kommandon och kod ska vara oberoende av det lokala operativsystemet, om inget annat anges.

### Nödvändig programvara

Följande bör installeras lokalt:

* [Lokal instans av AEM **Författare**](https://experience.adobe.com/#/downloads) (Cloud Service SDK eller 6.5.14+)
* [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
* [Apache Maven](https://maven.apache.org/) (3.3.9 eller senare)
* [Node.js](https://nodejs.org/en/) (LTS - långsiktig support)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)
* [Visual Studio-kod](https://code.visualstudio.com/) eller motsvarande IDE
   * [VSCode AEM Sync](https://marketplace.visualstudio.com/items?itemName=yamato-ltd.vscode-aem-sync) - Verktyg som används genom självstudiekursen

>[!NOTE]
>
> **Ny på AEM as a Cloud Service?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).
>
> **Har du inte använt AEM 6.5 tidigare?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## GitHub {#github}

Koden från den här självstudiekursen finns i GitHub i AEM Guide-rapporten:

**[GitHub: WKND Sites Project](https://github.com/adobe/aem-guides-wknd)**

Dessutom har varje del av självstudiekursen en egen gren i GitHub. Användaren kan börja självstudiekursen när som helst genom att helt enkelt checka ut den gren som motsvarar föregående del.

## Nästa steg {#next-steps}

Vad väntar du på? Starta självstudiekursen genom att gå till kapitlet [Projektinställningar](project-setup.md) och lära dig hur du skapar ett nytt Adobe Experience Manager-projekt med AEM Project Archetype.
