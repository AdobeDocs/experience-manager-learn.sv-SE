---
title: Granska ui.front-modulen för ett projekt i full hög
description: Granska utvecklingsfasen, driftsättningen och leveranscykeln för ett webbaserat AEM Sites-projekt i full hög.
version: Cloud Service
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
duration: 396
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '560'
ht-degree: 0%

---

# Granska modulen ui.front för AEM i fullstacksprojektet {#aem-full-stack-ui-frontent}

I det här kapitlet går vi igenom utveckling, driftsättning och leverans av front end-artefakter i ett AEM i full stack genom att fokusera på ui.front-modulen i __WKND Sites-projekt__.


## Mål {#objective}

* Förstå hur frontendartefakter byggs och driftsätts i ett AEM projekt i full hög
* Granska AEM projekt i fullhög `ui.frontend` modulens [webbpaket](https://webpack.js.org/) configs
* Genereringsprocess för AEM klientbibliotek (kallas även klientbibliotek)

## Driftsättningsflöde i gränssnittet för projekt med AEM i fullhög och snabb utveckling av webbplatser

>[!IMPORTANT]
>
>I den här videon förklaras och demonstreras frontend-flödet för båda **Skapa i hög och snabb takt** projekt för att få en överblick över den subtila skillnaden i frontend-resurser för att bygga, driftsätta och leverera.

>[!VIDEO](https://video.tv.adobe.com/v/3409344?quality=12&learn=on)

## Förutsättningar {#prerequisites}


* Klona [AEM WKND Sites-projekt](https://github.com/adobe/aem-guides-wknd)
* Bygg och driftsatte det klonade AEM WKND Sites-projektet till AEM as a Cloud Service.

Se projektet AEM WKND Site [README.md](https://github.com/adobe/aem-guides-wknd/blob/main/README.md) för mer information.

## AEM slutartefaktflöde för projekt i full hög {#flow-of-frontend-artifacts}

Nedan visas en högnivårepresentation av __utveckling, driftsättning och leverans__ flödet av slutartefakter i ett AEM i full hög.

![Utveckling, driftsättning och leverans av frontend-artefakter](assets/Dev-Deploy-Delivery-AEM-Project.png)


Under utvecklingsfasen utförs ändringar i gränssnittet som formatering och omprofilering genom att CSS-, JS-filer uppdateras från `ui.frontend/src/main/webpack` mapp. Under byggtiden kan [webbpaket](https://webpack.js.org/) plug-inen module-bundler och maven förvandlar dessa filer till optimerade AEM clientlibs under `ui.apps` -modul.

Ändringar i gränssnittet distribueras till AEM as a Cloud Service miljö när programmet körs [__Fullhög__ pipeline i Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html).

Framsidan levereras till webbläsarna via URI-sökvägar som börjar med `/etc.clientlibs/`, och cachas vanligtvis AEM Dispatcher och CDN.


>[!NOTE]
>
> På samma sätt visas __AEM för att skapa webbplatser snabbt__, [ändringar i gränssnittet](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/customize-theme.html) distribueras till AEM as a Cloud Service miljö genom att köra __Front-End__ pipeline, se [Konfigurera din pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/site-creation/quick-site/pipeline-setup.html)

### Granska webbpaketskonfigurationer i WKND Sites-projektet {#development-frontend-webpack-clientlib}

* Det finns tre __webbpaket__ config-filer som används för att paketera WKND-webbplatsernas frontresurser.

   1. `webpack.common` - Detta innehåller __vanlig__ konfiguration för att instruera WKND-resurspaket och optimering. The __output__ anger var de konsoliderade filerna ska genereras (kallas även JavaScript-paket, men ska inte blandas ihop med AEM OSGi-paket) som skapas. Standardnamnet är `clientlib-site/js/[name].bundle.js`.

  ```javascript
      ...
      output: {
              filename: 'clientlib-site/js/[name].bundle.js',
              path: path.resolve(__dirname, 'dist')
          }
      ...    
  ```

   1. `webpack.dev.js` innehåller __utveckling__ konfiguration för webbpack-dev-server och pekar på HTML-mallen som ska användas. Den innehåller även en proxykonfiguration för en AEM som körs på `localhost:4502`.

  ```javascript
      ...
      devServer: {
          proxy: [{
              context: ['/content', '/etc.clientlibs', '/libs'],
              target: 'http://localhost:4502',
          }],
      ...    
  ```

   1. `webpack.prod.js` innehåller __produktion__ och använder plugin-programmen för att omvandla utvecklingsfilerna till optimerade paket.

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


* De paketerade resurserna flyttas till `ui.apps` modul använda [aem-clientlib-generator](https://www.npmjs.com/package/aem-clientlib-generator) plugin-program, använda konfigurationen som hanteras i `clientlib.config.js` -fil.

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

* The __front-maven-plugin__ från `ui.frontend/pom.xml` orkestrerar paketering av webbpaket och generering av klientlib när AEM byggs.

`$ mvn clean install -PautoInstallSinglePackage`

### Distribution till AEM as a Cloud Service {#deployment-frontend-aemaacs}

The [__Fullhög__ pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines.html?#full-stack-pipeline) distribuerar dessa ändringar till en AEM as a Cloud Service miljö.


### Leverans från AEM as a Cloud Service {#delivery-frontend-aemaacs}

De resurser som distribueras via hela stacken levereras från AEM webbplats till webbläsare som `/etc.clientlibs` filer. Du kan verifiera detta genom att gå till [offentlig WKND-webbplats](https://wknd.site/content/wknd/us/en.html) och visa webbsidans källa.

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

I nästa kapitel [Uppdatera projekt för att använda frontpipeline](update-project.md)uppdaterar du AEM WKND Sites Project för att aktivera det för det främre pipelinekontraktet.
