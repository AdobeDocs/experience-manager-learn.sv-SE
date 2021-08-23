---
title: Komma igång med AEM SPA Editor och Angular
description: Skapa ett program med en Angular (SPA) som kan redigeras i Adobe Experience Manager AEM med WKND-SPA. Lär dig hur du skapar en SPA med Angularnas JS-ramverk med AEM SPA Editor. Denna självstudiekurs i flera delar går igenom implementeringen av en Angular för ett fiktivt livsstilsmärke, WKND. Självstudiekursen täcker hela SPA och integreringen med AEM.
sub-product: platser
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5913
thumbnail: 5913-spa-angular.jpg
feature: SPA
topic: SPA
role: Developer
level: Beginner
source-git-commit: 7200601c1b59bef5b1546a100589c757f25bf365
workflow-type: tm+mt
source-wordcount: '702'
ht-degree: 0%

---


# Skapa din första Angular SPA i AEM {#introduction}

Välkommen till en självstudiekurs i flera delar som utformats för utvecklare som är nybörjare i **SPA Editor**-funktionen i Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en Angular för ett fiktivt livsstilsmärke, WKND. Appen Angular kommer att utvecklas och utformas för att användas med AEM SPA Editor, som mappar Angular-komponenter till AEM. Den färdiga SPA, som används för AEM, kan redigeras dynamiskt med AEM traditionella textbundna redigeringsverktyg.

![Slutlig SPA implementerad](assets/wknd-spa-implementation.png)

*WKND-SPA*

## Om

Målet med den här självstudiekursen är att lära en utvecklare hur man implementerar en Angular som fungerar med SPA redigeringsfunktion i AEM. I ett verkligt scenario är utvecklingsaktiviteterna uppdelade efter persona, ofta med en **Front End-utvecklare** och en **Back End-utvecklare**. Vi tror att det är bra att alla utvecklare som kommer att delta i ett AEM SPA Editor-projekt slutför kursen.

Självstudiekursen är utformad för att fungera med **AEM som en Cloud Service** och är bakåtkompatibel med **AEM 6.5.4+** och **AEM 6.4.8+**. SPA implementeras med:

* [Maven AEM Project Archetype](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/developing/archetype/overview.html)
* [AEM SPA Editor](https://experienceleague.adobe.com/docs/experience-manager-65/developing/headless/spas/spa-walkthrough.html#content-editing-experience-with-spa)
* [Kärnkomponenter](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
* [Angular](https://angular.io/)

*Beräkna 1-2 timmar för att komma igenom varje del av självstudiekursen.*

## Senaste kod

All självstudiekod finns på [GitHub](https://github.com/adobe/aem-guides-wknd-spa).

Den [senaste kodbasen](https://github.com/adobe/aem-guides-wknd-spa/releases) är tillgänglig som hämtningsbara AEM.

## Förutsättningar

Innan du startar den här självstudiekursen behöver du följande:

* Grundläggande kunskaper i HTML, CSS och JavaScript
* Grundläggande kunskap om [Angular](https://angular.io/)
* [AEM som Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html#download-the-aem-as-a-cloud-service-sdk),  [AEM 6.5.4+](https://helpx.adobe.com/experience-manager/aem-releases-updates.html#65) eller  [AEM 6.4.8+](https://helpx.adobe.com/experience-manager/aem-releases-updates.html#64)
* [Java](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
* [Apache Maven](https://maven.apache.org/)  (3.3.9 eller senare)
* [Node.](https://nodejs.org/en/) jsand  [npm](https://www.npmjs.com/)

*Även om det inte är nödvändigt är det bra att ha en grundläggande förståelse för hur man  [utvecklar traditionella AEM Sites-komponenter](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html).*

## Lokal utvecklingsmiljö {#local-dev-environment}

En lokal utvecklingsmiljö krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM som en Cloud Service-SDK som körs i en Mac OS-miljö med [Visual Studio Code](https://code.visualstudio.com/) som IDE. Kommandon och kod ska vara oberoende av det lokala operativsystemet, om inget annat anges.

>[!NOTE]
>
> **Är du inte AEM som Cloud Service?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM som Cloud Service-SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).
>
> **Har du inte använt AEM 6.5 tidigare?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## Nästa steg {#next-steps}

Vad väntar du på?! Starta självstudiekursen genom att navigera till kapitlet [SPA Editor Project](create-project.md) och lär dig hur du skapar ett projekt som är aktiverat för SPA redigeraren med hjälp av den AEM projekttypen.

## Bakåtkompatibilitet {#compatibility}

Projektkoden för den här självstudiekursen har skapats för AEM som en Cloud Service. För att göra projektkoden bakåtkompatibel för **6.5.4+** och **6.4.8+** har flera ändringar gjorts.

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

Profilen `classic` är inaktiverad som standard. Om du följer självstudiekursen med AEM 6.x ska du lägga till profilen `classic` när du får instruktioner om att utföra en Maven-konstruktion:

```shell
$ mvn clean install -PautoInstallSinglePackage -Pclassic
```

När du genererar ett nytt projekt för en AEM implementering ska du alltid använda den senaste versionen av [AEM Project Archetype](https://github.com/adobe/aem-project-archetype) och uppdatera `aemVersion` för att ange målversionen av AEM.
