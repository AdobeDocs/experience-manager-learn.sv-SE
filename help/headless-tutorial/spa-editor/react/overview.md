---
title: Komma igång med AEM SPA Editor och React
description: Skapa ditt första React Single Page Application (SPA) som kan redigeras i Adobe Experience Manager AEM med WKND SPA. Lär dig hur du skapar en SPA med hjälp av React JS-ramverket med AEM:s SPA Editor. Denna självstudiekurs i flera delar går igenom implementeringen av en React-applikation för ett fiktivt livsstilsmärke, WKND. Självstudiekursen täcker hela skapandet av SPA och integreringen med AEM.
version: Cloud Service
jira: KT-5912
thumbnail: 5912-spa-react.jpg
feature: SPA Editor
topic: SPA
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 38802296-8988-4300-a04a-fcbbe98ac810
last-substantial-update: 2022-08-25T00:00:00Z
duration: 71
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '417'
ht-degree: 16%

---

# Skapa din första SPA i AEM {#overview}

{{edge-delivery-services}}

Välkommen till en självstudiekurs i flera delar som är utformad för utvecklare som inte använt **SPA** i Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en React-applikation för ett fiktivt livsstilsmärke, WKND. Appen React har utvecklats och utformats för att användas med AEM SPA Editor, som mappar React-komponenter till AEM komponenter. Den färdiga SPA, som används för AEM, kan redigeras dynamiskt med AEM traditionella textbundna redigeringsverktyg.

![Slutlig SPA implementerad](assets/wknd-spa-implementation.png)

*WKND-SPA*

## Om

Självstudiekursen är utformad för att fungera med **AEM as a Cloud Service** och är bakåtkompatibel med **AEM 6.5.4+** och **AEM 6.4.8+**.

## Senaste kod

All självstudiekod finns på [GitHub](https://github.com/adobe/aem-guides-wknd-spa).

The [senaste kodbas](https://github.com/adobe/aem-guides-wknd-spa/releases) finns som hämtningsbara AEM.

## Förutsättningar

Innan du startar den här självstudiekursen behöver du följande:

* Grundläggande kunskaper i HTML, CSS och JavaScript
* Grundläggande kunskap om [Reagera](https://reactjs.org/tutorial/tutorial.html)

*Även om det inte är nödvändigt är det bra att ha en grundläggande förståelse för [utveckla traditionella AEM Sites-komponenter](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html).*

## Lokal utvecklingsmiljö {#local-dev-environment}

En lokal utvecklingsmiljö krävs för att slutföra den här självstudiekursen. Skärmbilder och video hämtas med AEM as a Cloud Service SDK som körs i en Mac OS-miljö med [Visual Studio Code](https://code.visualstudio.com/) som IDE. Kommandon och kod ska vara oberoende av det lokala operativsystemet, om inget annat anges.

### Nödvändig programvara

* [AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html), [AEM 6.5.4+](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/aem-releases-updates.html?lang=en#aem-65) eller [AEM 6.4.8+](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/aem-releases-updates.html?lang=en#aem-64)
* [Java](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
* [Apache Maven](https://maven.apache.org/) (3.3.9 eller senare)
* [Node.js](https://nodejs.org/en/) och [npm](https://www.npmjs.com/)

>[!NOTE]
>
> **Är du inte AEM as a Cloud Service?** Kolla in [följa guiden för att konfigurera en lokal utvecklingsmiljö med AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).
>
> **Har du inte använt AEM 6.5 tidigare?** Kolla in [följa guiden för att konfigurera en lokal utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/development/set-up-a-local-aem-development-environment.html).

## Nästa steg {#next-steps}

Vad väntar du på?! Starta självstudiekursen genom att gå till [Skapa projekt](create-project.md) och lär dig hur du skapar ett projekt som SPA redigeraren har aktiverat med hjälp av AEM Project Archetype.
