---
title: Komma igång med SPA Editor och SPA - översikt
description: Välkommen till den självstudiekurs i flera delar för utvecklare som vill utöka en befintlig SPA med redigerbart AEM med AEM SPA Editor.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
kt: 7630
thumbnail: 333272.jpeg
exl-id: c5f933eb-c409-41dc-bb6a-6b2220dfbb47
source-git-commit: fe056006ab59a3955e5f16a23e96e9e208408cf5
workflow-type: tm+mt
source-wordcount: '693'
ht-degree: 1%

---

# Översikt

Välkommen till flerdelssjälvstudiekursen för utvecklare som vill utöka en befintlig React-baserad (eller Next.js) SPA med redigerbart AEM med AEM SPA Editor.

Den här självstudiekursen bygger vidare på [WKND GraphQL-app](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html), en React-app som använder innehåll AEM innehållsfragment över AEM GraphQL-API:er, men som inte innehåller någon sammanhangsbaserad redigering av SPA.

>[!VIDEO](https://video.tv.adobe.com/v/333272/?quality=12&learn=on)

## Om självstudiekursen

Självstudiekursen är tänkt att illustrera hur en SPA, eller en SPA som körs utanför AEM, kan uppdateras för att använda och leverera innehåll som skapats i AEM.

De flesta aktiviteterna i självstudiekursen fokuserar på JavaScript-utveckling, men viktiga aspekter beskrivs som AEM. Dessa aspekter kan vara att definiera var innehållet skapas och lagras i AEM och mappa SPA till AEM sidor.

Självstudiekursen är utformad för att fungera med **AEM as a Cloud Service** och består av två projekt:

1. The __AEM__ innehåller konfiguration och innehåll som måste distribueras till AEM.
1. __WKND-app__ är SPA som ska integreras med AEM SPA

## Senaste kod

+ Den här självstudiekursens kod finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql) på `feature/spa-editor` förgrening.

## Förutsättningar

Den här självstudiekursen kräver följande:

+ [SDK för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=en)
+ [Node.js v16+](https://nodejs.org/en/)
+ [npm v8+](https://www.npmjs.com/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ [aem-guides-wknd.all-2.1.0.zip eller högre](https://github.com/adobe/aem-guides-wknd/releases)
+ [källkoden aem-guides-wknd-graphql (gren: feature/spa-editor)](https://github.com/adobe/aem-guides-wknd-graphql/tree/feature/spa-editor)

I den här självstudiekursen förutsätts:

+ [Microsoft® Visual Studio Code](https://visualstudio.microsoft.com/) som IDE
+ En arbetskatalog för `~/Code/wknd-app`
+ Köra AEM SDK som en författartjänst på `http://localhost:4502`
+ Köra AEM SDK med lokala `admin` konto med lösenord `admin`
+ Köra SPA på `http://localhost:3000`

>[!NOTE]
>
> **Behöver du hjälp med att konfigurera din lokala utvecklingsmiljö?** Kolla in [följa guiden för att konfigurera en lokal utvecklingsmiljö med AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).


## Snabbinställningar

Med Snabbinstallation kommer du igång med WKND App SPA och AEM SPA Editor på 15 minuter. Den här snabbredigerade installationen tar dig direkt till självstudiekursens slutläge så att du kan utforska redigeringen av SPA i AEM SPA.

+ [Läs om snabbinställningar](./quick-setup.md)

## 1. Konfigurera AEM för SPA Editor

AEM konfigurationer krävs för att integrera SPA med AEM SPA Editor. Dessa konfigurationer hanteras och distribueras via ett AEM projekt. Läs om vilka konfigurationer som är nödvändiga och hur du definierar dem i det här kapitlet.

+ [Lär dig hur du konfigurerar AEM för SPA Editor](./aem-configure.md)

## 2. Bootstrap the SPA

För att AEM redigeraren ska kunna integrera en SPA i sitt redigeringssammanhang måste några tillägg göras i SPA.

+ [Läs om hur du startar SPA för AEM SPA](./spa-bootstrap.md)

## 3. Redigerbara fasta komponenter

Börja med att utforska hur du lägger till en redigerbar&quot;fast komponent&quot; i SPA. Detta visar hur en utvecklare kan placera en viss redigerbar komponent i SPA. Även om författaren kan ändra komponentens innehåll kan de inte ta bort komponenten eller ändra dess placering, placering eller storlek.

+ [Lär dig mer om redigerbara fasta komponenter](./spa-fixed-component.md)

## 4. Redigerbara behållarkomponenter

Utforska sedan att lägga till en redigerbar&quot;behållarkomponent&quot; i SPA. Detta visar hur en utvecklare kan placera en behållarkomponent i SPA. Med behållarkomponenter kan författare placera tillåtna komponenter i den och justera komponenternas layout.

+ [Lär dig mer om redigerbara behållarkomponenter](./spa-container-component.md)

## 5. Dynamiska vägar och redigerbara komponenter

Slutligen bör de begrepp som beskrivs i tidigare kapitel användas för dynamiska rutter. vägar som visar olika innehåll baserat på flödets parameter. Detta visar hur AEM redigerare kan användas för att skapa innehåll på vägar som är programmässigt drivna och härledda.

+ [Lär dig mer om dynamiska vägar och redigerbara komponenter](./spa-dynamic-routes.md)

## Ytterligare resurser

+ [Redigera en extern SPA i AEM dokument](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/hybrid/editing-external-spa.html)
+ [AEM WCM-komponenter - React Core-implementering](https://www.npmjs.com/package/@adobe/aem-core-components-react-base)
+ [AEM WCM-komponenter - Spa editor - React Core-implementering](https://www.npmjs.com/package/@adobe/aem-core-components-react-spa)
