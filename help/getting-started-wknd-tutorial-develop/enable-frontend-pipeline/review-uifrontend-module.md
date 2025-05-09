---
title: Granska ui.front-modulen för ett projekt i full hög
description: Granska utvecklingsfasen, driftsättningen och leveranscykeln för ett webbaserat AEM Sites-projekt i full hög.
version: Experience Manager as a Cloud Service
feature: AEM Project Archetype, Cloud Manager, CI-CD Pipeline
topic: Content Management, Development, Development, Architecture
role: Developer, Architect, Admin
level: Intermediate
jira: KT-10689
mini-toc-levels: 1
index: y
recommendations: noDisplay, noCatalog
doc-type: Tutorial
exl-id: 65e8d41e-002a-4d80-a050-5366e9ebbdea
duration: 364
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '560'
ht-degree: 0%

---

# Granska AEM-projektets ui.front-modul i full hög {#aem-full-stack-ui-frontent}

I det här kapitlet går vi igenom utveckling, distribution och leverans av frontendartefakter i ett AEM-projekt i full hög genom att fokusera på modulen &quot;ui.front&quot; i __WKND Sites-projektet__.


## Mål {#objective}

* Förstå hur frontendartefakter byggs och driftsätts i ett högklassigt AEM-projekt
* Granska [webpack](https://webpack.js.org/)-konfigurationer för AEM-fullstacksprojektet i modulen `ui.frontend`
* Genereringsprocess för AEM klientbibliotek (kallas även klientlibs)

## Driftsättningsflöde i gränssnittet för AEM-projekt i full hög och snabbinstallation av webbplatser

>[!IMPORTANT]
>
>I den här videon förklaras och demonstreras frontendflödet för både **projekt med fullständig hög och snabb webbplatsgenerering** för att visa den subtila skillnaden i frontendresurserna när det gäller att skapa, distribuera och leverera.

>[!VIDEO](https://video.tv.adobe.com/v/3409344?quality=12&learn=on)

## Förutsättningar {#prerequisites}


* Klona [AEM WKND Sites-projektet](https://github.com/adobe/aem-guides-wknd)
* Bygg och driftsätt det klonade AEM WKND Sites-projektet i AEM as a Cloud Service.

Mer information finns i AEM WKND Site-projektet [README.md](https://github.com/adobe/aem-guides-wknd/blob/main/README.md).

## AEM front-end-artefaktflöde för projekt i full hög {#flow-of-frontend-artifacts}

Nedan visas en högnivårepresentation av __utvecklingen, distributionen och leveransflödet__ för frontendartefakterna i ett AEM-projekt i full hög.

![Utveckling, driftsättning och leverans av frontendartefakter](assets/Dev-Deploy-Delivery-AEM-Project.png)


Under utvecklingsfasen utförs ändringar i gränssnittet, som formatering och omprofilering, genom att CSS-, JS-filer från mappen `ui.frontend/src/main/webpack` uppdateras. Under byggtiden förvandlar sedan pluginmodulen [webpack](https://webpack.js.org/) och maven dessa filer till optimerade AEM-klienter under modulen `ui.apps`.

Front-end-ändringar distribueras till AEM as a Cloud Service-miljön när du kör pipelinen [__Full-stack__ i Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html?lang=sv-SE).

Framsidesresurserna levereras till webbläsarna via URI-sökvägar som börjar med `/etc.clientlibs/`, och cachas vanligtvis i AEM Dispatcher och CDN.


>[!NOTE]
>
> På samma sätt distribueras [ändringarna i gränssnittet](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/customize-theme.html?lang=sv-SE) i __AEM snabbplatsresa__ till AEM as a Cloud Service-miljön genom att pipeline __Front-End__ körs. Se [Konfigurera pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/pipeline-setup.html?lang=sv-SE).

### Granska webbpaketskonfigurationer i WKND Sites-projektet {#development-frontend-webpack-clientlib}

* Det finns tre __webbpack__-konfigurationsfiler som används för att paketera WKND-webbplatsernas frontendresurser.

   1. `webpack.common` - Detta innehåller konfigurationen __common__ för att instruera WKND-resurspaket och optimering. Egenskapen __output__ anger var de konsoliderade filerna ska genereras (kallas även JavaScript-paket, men ska inte blandas ihop med AEM OSGi-paket) som skapas. Standardnamnet är `clientlib-site/js/[name].bundle.js`.

  ```javascript
      ...
      output: {
              filename: 'clientlib-site/js/[name].bundle.js',
              path: path.resolve(__dirname, 'dist')
          }
      ...    
  ```

   1. `webpack.dev.js` innehåller konfigurationen __development__ för webbpack-dev-server och pekar på den HTML-mall som ska användas. Den innehåller även en proxykonfiguration för en AEM-instans som körs på `localhost:4502`.

  ```javascript
      ...
      devServer: {
          proxy: [{
              context: ['/content', '/etc.clientlibs', '/libs'],
              target: 'http://localhost:4502',
          }],
      ...    
  ```

   1. `webpack.prod.js` innehåller konfigurationen __production__ och använder plugin-programmen för att omvandla utvecklingsfilerna till optimerade paket.

  ```javascript
      ...
      module.exports = merge(common, {
          mode: 'production',
          optimization: {
              minimize: true,
              minimizer: [
                  new TerserPlugin(),
                  new CssMinimizerPlugin({ ...})
          }
      ...    
  ```


* De paketerade resurserna flyttas till modulen `ui.apps` med plugin-programmet [ aem-clientlib-generator](https://www.npmjs.com/package/aem-clientlib-generator), med hjälp av konfigurationen som hanteras i filen `clientlib.config.js`.

```javascript
    ...
    const BUILD_DIR = path.join(__dirname, 'dist');
    const CLIENTLIB_DIR = path.join(
    __dirname,
    '..',
    'ui.apps',
    'src',
    'main',
    'content',
    'jcr_root',
    'apps',
    'wknd',
    'clientlibs'
    );
    ...
```

* __front-maven-plugin__ från `ui.frontend/pom.xml` orkestrerar webbpaketering och klientlib-generering när AEM-projekt byggs.

`$ mvn clean install -PautoInstallSinglePackage`

### Distribution till AEM as a Cloud Service {#deployment-frontend-aemaacs}

[__Fullhög__ pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html?lang=sv-SE&#full-stack-pipeline) distribuerar dessa ändringar till en AEM as a Cloud Service-miljö.


### Leverans från AEM as a Cloud Service {#delivery-frontend-aemaacs}

De front end-resurser som distribueras via pipeline i helhög levereras från AEM Site till webbläsare som `/etc.clientlibs`-filer. Du kan verifiera detta genom att gå till den [offentliga WKND-webbplatsen](https://wknd.site/content/wknd/us/en.html) och visa webbsidans källa.

```html
    ....
    <link rel="stylesheet" href="/etc.clientlibs/wknd/clientlibs/clientlib-site.lc-181cd4102f7f49aa30eea548a7715c31-lc.min.css" type="text/css">

    ...

    <script async src="/etc.clientlibs/wknd/clientlibs/clientlib-site.lc-d4e7c03fe5c6a405a23b3ca1cc3dcd3d-lc.min.js"></script>
    ....
```

## Grattis! {#congratulations}

Grattis, du har granskat ui.front-modulen för ett projekt i en hel hög

## Nästa steg {#next-steps}

I nästa kapitel, [Uppdatera projekt till att använda frontdelspipeline](update-project.md), uppdaterar du AEM WKND Sites Project så att det aktiveras för frontdelsslutsslutsslutsslutsslutsslutsslutsslutsslutsslutskontraktet.
