---
title: Komma igång med AEM Sites - WKND självstudiekurs
description: Komma igång med AEM Sites - WKND självstudiekurs. WKND-självstudiekursen är en självstudiekurs i flera delar som utformats för utvecklare som är nybörjare på Adobe Experience Manager. Självstudiekursen går igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND. Självstudiekursen behandlar grundläggande ämnen som projektinställningar, prototyper, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling.
sub-product: platser
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
KT: 4132
mini-toc-levels: 1
index: y
thumbnail: 30476.jpg
translation-type: tm+mt
source-git-commit: 69c1767098cc9da8ec0ae2bd83d25417d330f393
workflow-type: tm+mt
source-wordcount: '970'
ht-degree: 2%

---


# Getting Started with AEM Sites - WKND Tutorial {#introduction}

Välkommen till en självstudiekurs i flera delar som är utformad för utvecklare som är nybörjare i Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND. Självstudiekursen behandlar grundläggande ämnen som projektinställningar, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling med Adobe Experience Manager Sites.

## Översikt {#wknd-tutorial-overview}

Målet med den här självstudiekursen är att lära en utvecklare hur man implementerar en webbplats med hjälp av de senaste standarderna och teknikerna i Adobe Experience Manager (AEM). Efter att ha avslutat den här självstudiekursen bör utvecklaren förstå plattformens grundläggande grund och med kunskap om vanliga designmönster i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/30476?quality=12&learn=on)

Självstudiekursen är utformad för att fungera med **AEM som Cloud Service** och är bakåtkompatibel med **AEM 6.5+** och **AEM 6.4.2+**. Webbplatsen implementeras med:

* [Maven AEM Project Archetype](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/developing/archetype/overview.html)
* [Kärnkomponenter](https://docs.adobe.com/content/help/en/experience-manager-core-components/using/introduction.html)
* [HTL](https://docs.adobe.com/content/help/en/experience-manager-htl/using/getting-started/getting-started.html)
* Sling Models
* [Redigerbara mallar](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/template-editor-feature-video-use.html)
* [Formatsystem](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/page-authoring/style-system-feature-video-use.html)

*Beräkna 1-2 timmar för att komma igenom varje del av självstudiekursen.*

## Om självstudiekursen {#about-tutorial}

WKND är en påhittad nättidskrift och blogg som fokuserar på nattliv, aktiviteter och evenemang i flera internationella städer.

### Adobe XD UI Kit

För att göra den här självstudiekursen närmare ett verkligt scenario skapade Adobe talangfulla UX-designers dummies för sajten med [Adobe XD](https://www.adobe.com/products/xd.html). Under självstudiekursen implementeras olika delar av designen till en helt redigerbar AEM. Ett särskilt tack till **Lorenzo Buosi** och **Kilian Modiola** som skapade den vackra designen för WKND:s sajt.

Ladda ned XD UI-kit:

* [AEM Core Component UI Kit](assets/overview/AEM-CoreComponents-UI-Kit.xd)
* [WKND UI Kit](https://github.com/adobe/aem-guides-wknd/releases/download/aem-guides-wknd-0.0.2/AEM_UI-kit-WKND.xd)

Namnet WKND passar eftersom vi förväntar oss att en utvecklare ska ta den bättre delen av en ***helg*** för att slutföra självstudiekursen.

### Github {#github}

All kod för projektet finns i Github i AEM:

**[GitHub: WKND Sites Project](https://github.com/adobe/aem-guides-wknd)**

Dessutom har varje del av självstudiekursen en egen gren i GitHub. Användaren kan börja självstudiekursen när som helst genom att helt enkelt checka ut den gren som motsvarar föregående del.

>[!NOTE]
>
> Om du arbetade med den tidigare versionen av den här självstudiekursen kan du fortfarande hitta [lösningspaketen](https://github.com/adobe/aem-guides-wknd/releases/tag/archetype-18.1) och [koden](https://github.com/adobe/aem-guides-wknd/tree/archetype-18.1) på GitHub.

## Lokal utvecklingsmiljö {#local-dev-environment}

En lokal utvecklingsmiljö krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM som en Cloud Service-SDK som körs i Mac OS-miljö. Kommandon och kod ska vara oberoende av det lokala operativsystemet, om inget annat anges.

**Är du inte AEM som Cloud Service?** Ta en titt på [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM som Cloud Service-SDK](https://docs.adobe.com/content/help/en/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).

**Har du inte använt AEM 6.5 tidigare?** Ta en titt på [följande guide för att konfigurera en lokal utvecklingsmiljö](https://docs.adobe.com/content/help/en/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

### Nödvändig programvara

Följande bör installeras lokalt:

* [AEM som Cloud Service SDK](https://docs.adobe.com/content/help/en/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html#download-the-aem-as-a-cloud-service-sdk) eller [AEM 6.5](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/technical-requirements.html) eller [AEM 6.4 + SP2](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html)
* [Java 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html) (endast AEM 6.5+)
* [Apache Maven](https://maven.apache.org/) (3.3.9 eller senare)
* [Node.js v10+](https://nodejs.org/en/)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)

### Integrated Development Environment (IDE)

I den här självstudiekursen används [Eclipse](https://www.eclipse.org/) med [AEM Developer Tool Plugin](https://eclipse.adobe.com/aem/dev-tools/) som IDE, men alla IDE som har stöd för Java- och Maven-projekt kan användas. Den här självstudiekursen är minimalt beroende av vissa IDE-funktioner.

Mer information om hur du använder Eclipse eller andra utvecklingsmiljöer som [Visual Studio Code](https://code.visualstudio.com/) eller [IntelliJ](https://www.jetbrains.com/idea/)finns i [följande guide](https://docs.adobe.com/content/help/en/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## Referenswebbplats {#reference-site}

En färdig version av WKND-webbplatsen finns också som referens: [https://wknd.site/](https://wknd.site/)

Självstudiekursen behandlar de viktigaste utvecklingskunskaperna för en AEM utvecklare, men kommer *inte* att bygga hela webbplatsen från början till slut. Den färdiga referenswebbplatsen är en annan bra resurs att utforska och se mer av AEM funktioner.

Om du vill testa den senaste koden innan du går in i självstudiekursen hämtar och installerar du den **[senaste versionen från GitHub](https://github.com/adobe/aem-guides-wknd/releases/latest)**.

### Powered by Adobe Stock

Många av bilderna på WKND Reference-webbplatsen är från [Adobe Stock](https://stock.adobe.com/) och är material från tredje part enligt definitionen i Demo Asset Additional Terms på [https://www.adobe.com/legal/terms.html](https://www.adobe.com/legal/terms.html). Om du vill använda en Adobe Stock-bild för andra ändamål än att visa den här demowebbplatsen, till exempel för att visa den på en webbplats, eller i marknadsföringsmaterial, kan du köpa en licens på Adobe Stock.

Med Adobe Stock får du tillgång till över 140 miljoner högklassiga royaltyfria bilder som foton, grafik, videor och mallar som hjälper dig att komma igång snabbt med dina kreativa projekt.

## Nästa steg {#next-steps}

Vad väntar du på?! Starta självstudiekursen genom att gå till kapitlet [Projektinställningar](project-setup.md) och lära dig hur du skapar ett nytt Adobe Experience Manager-projekt med hjälp av den AEM projektarkitekturen.
