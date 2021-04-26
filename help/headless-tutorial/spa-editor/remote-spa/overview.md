---
title: Komma igång med SPA Editor och SPA - översikt
description: Välkommen till den självstudiekurs i flera delar för utvecklare som vill utöka en befintlig SPA med redigerbart AEM med AEM SPA Editor.
topic: Headless, SPA, Development
feature: SPA, kärnkomponenter, API:er, utveckling
role: Developer, Architect
level: Beginner
kt: 7630
thumbnail: kt-7630.jpg
translation-type: tm+mt
source-git-commit: 0eb086242ecaafa53c59c2018f178e15f98dd76f
workflow-type: tm+mt
source-wordcount: '675'
ht-degree: 1%

---


# Översikt

Välkommen till flerdelssjälvstudiekursen för utvecklare som vill utöka en befintlig React-baserad (eller Next.js) SPA med redigerbart AEM med AEM SPA Editor.

Den här självstudiekursen bygger vidare på [WKND GraphQL App](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html), en React-app som förbrukar AEM Content Fragment-innehåll över AEM GraphQL-API:er, men har ingen sammanhangsbaserad redigering av SPA.

## Om självstudiekursen

Självstudiekursen är tänkt att illustrera hur en SPA, eller en SPA som körs utanför AEM, kan uppdateras för att använda och leverera innehåll som skapats i AEM.

De flesta aktiviteterna i självstudiekursen fokuserar på JavaScript-utveckling, men viktiga aspekter beskrivs som AEM. Dessa aspekter kan vara att definiera var innehållet skapas och lagras i AEM och mappa SPA till AEM sidor.

Självstudiekursen är utformad för att fungera med **AEM som en Cloud Service** och består av två projekt:

1. __AEM Project__ innehåller konfiguration och innehåll som måste distribueras till AEM.
1. __WKND__ Appproject är SPA som ska integreras med AEM SPA Editor

## Senaste kod

+ Den här självstudiekursens kod finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphq) i `feature/spa-editor`-grenen.

## Förutsättningar

Den här självstudiekursen kräver följande:

+ [SDK för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=en)
+ [Node.js v14+](https://nodejs.org/en/)
+ [npm v7+](https://www.npmjs.com/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ [aem-guides-wknd.all.0.3.0.zip eller högre](https://github.com/adobe/aem-guides-wknd/releases)
+ [källkoden aem-guides-wknd-graphql](https://github.com/adobe/aem-guides-wknd-graphql)

I den här självstudiekursen förutsätts:

+ [Microsoft® Visual Studio ](https://visualstudio.microsoft.com/) Codeas the IDE
+ En arbetskatalog för `~/Code/wknd-app`
+ Köra AEM SDK som en författartjänst på `http://localhost:4502`
+ Kör AEM SDK med det lokala `admin`-kontot med lösenordet `admin`
+ Kör SPA på `http://localhost:3000`

>[!NOTE]
>
> **Behöver du hjälp med att konfigurera din lokala utvecklingsmiljö?** Ta en titt på  [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM som Cloud Service-SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html).


## Snabbinställningar

Med Snabbinstallation kommer du igång med WKND App SPA och AEM SPA Editor på 15 minuter. Detta snabbredigerade installationsprogram tar dig direkt till självstudiekursens slutläge, så att du kan utforska utvecklingen av SPA i AEM SPA.

+ [Snabbkonfiguration](./quick-setup.md)

## Konfigurera AEM för SPA Editor

AEM konfigurationer krävs för att integrera SPA med AEM SPA Editor. Dessa konfigurationer hanteras och distribueras via ett AEM projekt. Läs om vilka konfigurationer som är nödvändiga och hur du definierar dem i det här kapitlet.

+ [Konfigurera AEM](./aem-configure.md)

## Bootstrap the SPA

För att AEM redigeraren ska kunna integrera en SPA i sitt redigeringssammanhang måste några tillägg göras i SPA.

+ [Bootstrap SPA för AEM SPA](./spa-bootstrap.md)

## Redigerbara fasta komponenter

Börja med att utforska hur du lägger till en redigerbar&quot;fast komponent&quot; i SPA. Detta visar hur en utvecklare kan placera en viss redigerbar komponent i SPA. Även om författaren kan ändra komponentens innehåll kan de inte ta bort komponenten eller ändra dess placering, placering eller storlek.

+ [Redigerbara fasta komponenter](./spa-fixed-component.md)

## Redigerbara behållarkomponenter

Utforska sedan att lägga till en redigerbar&quot;behållarkomponent&quot; i SPA. Detta visar hur en utvecklare kan placera en behållarkomponent i SPA. Med behållarkomponenter kan författare placera tillåtna komponenter i den och justera komponenternas layout.

## Dynamiska vägar och redigerbara komponenter

Slutligen bör de begrepp som beskrivs i tidigare kapitel användas för dynamiska rutter. vägar som visar olika innehåll baserat på flödets parameter. Detta visar hur AEM redigerare kan användas för att skapa innehåll på vägar som är programmässigt drivna och härledda.

+ [Dynamiska vägar och redigerbara komponenter](./spa-dynamic-routes.md)

## Ytterligare resurser

+ [Redigera en extern SPA i AEM dokument](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/hybrid/editing-external-spa.html)
+ [AEM WCM-komponenter - React Core-implementering](https://www.npmjs.com/package/@adobe/aem-core-components-react-base)
+ [AEM WCM-komponenter - Spa editor - React Core-implementering](https://www.npmjs.com/package/@adobe/aem-core-components-react-spa)
