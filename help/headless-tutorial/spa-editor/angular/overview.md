---
title: Komma igång med AEM SPA Editor och Angular
description: Skapa ditt första Angular Single Page Application (SPA) som kan redigeras i Adobe Experience Manager, AEM med WKND SPA.
version: Experience Manager as a Cloud Service
jira: KT-5913
thumbnail: 5913-spa-angular.jpg
feature: SPA Editor
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: f2cf4063-0b08-4b4f-91e6-70e5a148f931
duration: 123
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '583'
ht-degree: 0%

---

# Skapa din första Angular SPA i AEM {#introduction}

{{edge-delivery-services}}

Välkommen till en självstudiekurs i flera delar som utformats för utvecklare som inte har använt funktionen **SPA Editor** i Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en Angular-applikation för ett fiktivt livsstilsmärke, WKND. Angular-appen har utvecklats och utformats för att användas med AEM SPA Editor, som mappar Angular-komponenter till AEM-komponenter. Den kompletta SPA-lösningen, som används i AEM, kan redigeras dynamiskt med AEM traditionella textbundna redigeringsverktyg.

![Slutlig SPA har implementerats](assets/wknd-spa-implementation.png)

*WKND SPA-implementering*

## Om

Målet med den här självstudiekursen är att lära en utvecklare hur man implementerar ett Angular-program så att det fungerar med SPA-redigeringsfunktionen i AEM. I ett verkligt scenario bryts utvecklingsaktiviteterna ned per person, ofta med en **Front End-utvecklare** och en **Back End-utvecklare**. Vi anser att det är bra att alla utvecklare som arbetar med ett AEM SPA Editor-projekt slutför kursen.

Självstudiekursen är utformad för att fungera med **AEM as a Cloud Service** och är bakåtkompatibel med **AEM 6.5.4+** och **AEM 6.4.8+**. SPA implementeras med:

* [Maven AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html)
* [AEM SPA Editor](https://experienceleague.adobe.com/docs/experience-manager-65/developing/headless/spas/spa-walkthrough.html#content-editing-experience-with-spa)
* [Kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
* [Angular](https://angular.io/)

*Beräkna 1-2 timmar för att komma igenom varje del av självstudiekursen.*

## Senaste kod

All självstudiekod finns på [GitHub](https://github.com/adobe/aem-guides-wknd-spa).

Den [senaste kodbasen](https://github.com/adobe/aem-guides-wknd-spa/releases) är tillgänglig som hämtningsbara AEM-paket.

## Förutsättningar

Innan du startar den här självstudiekursen behöver du följande:

* Grundläggande kunskaper i HTML, CSS och JavaScript
* Grundläggande kunskap om [Angular](https://angular.io/)
* [AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html#download-the-aem-as-a-cloud-service-sdk), [AEM 6.5.4+](https://helpx.adobe.com/experience-manager/aem-releases-updates.html#65) eller [AEM 6.4.8+](https://helpx.adobe.com/experience-manager/aem-releases-updates.html#64)
* [Java](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
* [Apache Maven](https://maven.apache.org/) (3.3.9 eller senare)
* [Node.js](https://nodejs.org/en/) och [npm](https://www.npmjs.com/)

*Även om det inte krävs är det bra att ha en grundläggande förståelse för [utveckling av traditionella AEM Sites-komponenter](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html).*

## Lokal utvecklingsmiljö {#local-dev-environment}

En lokal utvecklingsmiljö krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM as a Cloud Service SDK som körs i en Mac OS-miljö med [Visual Studio Code](https://code.visualstudio.com/) som IDE. Kommandon och kod ska vara oberoende av det lokala operativsystemet, om inget annat anges.

>[!NOTE]
>
> **Ny på AEM as a Cloud Service?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).
>
> **Har du inte använt AEM 6.5 tidigare?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## Nästa steg {#next-steps}

Vad väntar du på?! Starta självstudiekursen genom att gå till kapitlet [SPA Editor Project](create-project.md) och lära dig hur du genererar ett SPA Editor-aktiverat projekt med AEM Project Archetype.

## Bakåtkompatibilitet {#compatibility}

Projektkoden för den här självstudiekursen har skapats för AEM as a Cloud Service. För att göra projektkoden bakåtkompatibel för **6.5.4+** och **6.4.8+** har flera ändringar gjorts.

[UberJar](https://experienceleague.adobe.com/docs/experience-manager-65/developing/devtools/ht-projects-maven.html#what-is-the-uberjar) **v6.4.4** har inkluderats som ett beroende:

```xml
<!-- Adobe AEM 6.x Dependencies -->
<dependency>
    <groupId>com.adobe.aem</groupId>
    <artifactId>uber-jar</artifactId>
    <version>6.4.4</version>
    <classifier>apis</classifier>
    <scope>provided</scope>
</dependency>
```

En ytterligare Maven-profil med namnet `classic` har lagts till för att ändra byggprocessen till AEM 6.x-miljöer:

```xml
  <!-- AEM 6.x Profile to include Core Components-->
    <profile>
        <id>classic</id>
        <activation>
            <activeByDefault>false</activeByDefault>
        </activation>
        <build>
        ...
    </profile>
```

Profilen `classic` är inaktiverad som standard. Om du följer självstudiekursen med AEM 6.x ska du lägga till profilen `classic` när du får instruktioner om att utföra en Maven-version:

```shell
$ mvn clean install -PautoInstallSinglePackage -Pclassic
```

När du genererar ett nytt projekt för en AEM-implementering ska du alltid använda den senaste versionen av [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) och uppdatera `aemVersion` så att den är avsedd för din version av AEM.
