---
title: Komma igång med SPA-redigeraren och fjärr-SPA - översikt
description: Välkommen till självstudiekursen med flera delar för utvecklare som vill utöka en befintlig fjärr-SPA med redigerbart AEM-innehåll med AEM SPA Editor.
topic: Headless, SPA, Development
feature: SPA Editor, Core Components, APIs, Developing
role: Developer, Architect
level: Beginner
jira: KT-7630
thumbnail: 333272.jpeg
last-substantial-update: 2022-11-11T00:00:00Z
doc-type: Tutorial
exl-id: c5f933eb-c409-41dc-bb6a-6b2220dfbb47
duration: 294
hide: true
source-git-commit: 5b008419d0463e4eaa1d19c9fe86de94cba5cb9a
workflow-type: tm+mt
source-wordcount: '571'
ht-degree: 1%

---

# Ökning

{{edge-delivery-services}}

Välkommen till den självstudiekurs i flera delar för utvecklare som vill utöka en befintlig React-baserad (eller Next.js) fjärr-SPA med redigerbart AEM-innehåll med AEM SPA Editor.

Den här självstudiekursen bygger på [WKND GraphQL App](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html?lang=sv-SE), en React-app som använder AEM Content Fragment-innehåll i stället för AEM GraphQL API:er, men har ingen kontextredigering av SPA-innehåll.

>[!VIDEO](https://video.tv.adobe.com/v/3444851?quality=12&learn=on&captions=swe)

## Om självstudiekursen

Självstudiekursen illustrerar hur en Remote SPA, eller en SPA som körs utanför AEM, kan uppdateras för att använda och leverera innehåll som skapats i AEM.

De flesta aktiviteterna i självstudiekursen fokuserar på JavaScript utveckling, men de viktigaste aspekterna beskrivs som gäller AEM. Dessa aspekter kan vara att definiera var innehållet skapas och lagras i AEM och mappa SPA-vägar till AEM Pages.

Självstudiekursen är utformad för att fungera med **AEM as a Cloud Service** och består av två projekt:

1. __AEM-projektet__ innehåller konfiguration och innehåll som måste distribueras till AEM.
1. __WKND App__ -projektet är den SPA som ska integreras med AEM SPA Editor

## Senaste kod

+ Startpunkten för den här självstudiekursens kod finns i [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/remote-spa-tutorial) i mappen `remote-spa-tutorial`.

## Förutsättningar

Den här självstudiekursen kräver följande:

+ [SDK för AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html?lang=sv-SE)
+ [Node.js v18](https://nodejs.org/en/)
+ [Java™ 11](https://downloads.experiencecloud.adobe.com/content/software-distribution/en/general.html)
+ [Maven 3.6+](https://maven.apache.org/)
+ [Git](https://git-scm.com/downloads)
+ [aem-guides-wknd.all-2.1.0.zip eller större](https://github.com/adobe/aem-guides-wknd/releases)
+ [källkoden aem-guides-wknd-graphql](https://github.com/adobe/aem-guides-wknd-graphql/tree/main)

I den här självstudien förutsätts:

+ [Microsoft® Visual Studio Code](https://visualstudio.microsoft.com/) som IDE
+ En arbetskatalog för `~/Code/aem-guides-wknd-graphql/remote-spa-tutorial`
+ Köra AEM SDK som en författartjänst på `http://localhost:4502`
+ Kör AEM SDK med det lokala `admin`-kontot med lösenordet `admin`
+ Kör SPA på `http://localhost:3000`

>[!NOTE]
>
> **Behöver du hjälp med att konfigurera din lokala utvecklingsmiljö?** Titta i [följande guide för att konfigurera en lokal utvecklingsmiljö med AEM as a Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=sv-SE).

## &#x200B;1. Konfigurera AEM för SPA Editor

AEM-konfigurationer krävs för att integrera SPA med AEM SPA Editor. Dessa konfigurationer hanteras och distribueras via ett AEM-projekt. Läs om vilka konfigurationer som är nödvändiga och hur du definierar dem i det här kapitlet.

+ [Lär dig konfigurera AEM för SPA Editor](./aem-configure.md)

## &#x200B;2. Bootstrap och SPA

För att AEM SPA Editor ska kunna integrera en SPA i sitt redigeringssammanhang måste ytterligare några läggas till i SPA-filen.

+ [Läs om hur du startar SPA för AEM SPA Editor](./spa-bootstrap.md)

## &#x200B;3. Redigerbara fasta komponenter

Börja med att utforska hur du lägger till en redigerbar&quot;fast komponent&quot; i SPA-filen. Detta visar hur en utvecklare kan placera en viss redigerbar komponent i SPA-filen. Även om författaren kan ändra komponentens innehåll kan de inte ta bort komponenten eller ändra dess placering, placering eller storlek.

+ [Lär dig mer om redigerbara fasta komponenter](./spa-fixed-component.md)

## &#x200B;4. Redigerbara behållarkomponenter

Utforska sedan att lägga till en redigerbar&quot;behållarkomponent&quot; i SPA-filen. Detta visar hur en utvecklare kan placera en behållarkomponent i SPA. Med behållarkomponenter kan författare placera tillåtna komponenter i den och justera komponenternas layout.

+ [Läs om redigerbara behållarkomponenter](./spa-container-component.md)

## &#x200B;5. Dynamiska vägar och redigerbara komponenter

Slutligen bör du använda de koncept som beskrivs i tidigare kapitel för dynamiska vägar, dvs. vägar som visar olika innehåll baserat på flödets parameter. Detta visar hur AEM SPA Editor kan användas för att skapa innehåll på vägar som styrs och härleds programmatiskt.

+ [Lär dig mer om dynamiska vägar och redigerbara komponenter](./spa-dynamic-routes.md)

## Ytterligare resurser

+ [AEM SPA React Editable Components](https://www.npmjs.com/package/@adobe/aem-react-editable-components)
