---
title: Uppdatera AEM-projekt i full stack för att använda pipeline i frontend-läget
description: Lär dig hur du uppdaterar AEM-projekt i full stack så att det kan användas i den främre pipeline, så att endast slutartefakter byggs och distribueras.
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
exl-id: c4a961fb-e440-4f78-b40d-e8049078b3c0
duration: 307
source-git-commit: b395b3b84e63fe6c24e597d1628f4aed5ba47469
workflow-type: tm+mt
source-wordcount: '595'
ht-degree: 0%

---

# Uppdatera AEM-projekt i full stack för att använda pipeline i frontend-läget {#update-project-enable-frontend-pipeline}

I det här kapitlet gör vi konfigurationsändringar i __WKND Sites-projektet__ för att använda front end-pipeline för att distribuera JavaScript och CSS, i stället för att kräva en fullständig pipeline-körning i stacken. Detta försvårar utvecklingsfasen och driftsättningslivscykeln för front-end- och back-end-artefakter, vilket ger en snabbare, iterativ utvecklingsprocess som helhet.

## Mål {#objectives}

* Uppdatera ett projekt i full hög för att använda frontendpipeline

## Översikt över konfigurationsändringar i AEM-projekt i fullhög

>[!VIDEO](https://video.tv.adobe.com/v/3409419?quality=12&learn=on)

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att du har granskat modulen [&#39;ui.front&#39; ](./review-uifrontend-module.md).


## Förändringar i AEM-projekt i full hög

Det finns tre projektrelaterade konfigurationsändringar och en formatändring som ska distribueras för en testkörning, vilket innebär totalt fyra specifika ändringar i WKND-projektet för att aktivera det för det främre pipelinekontraktet.

1. Ta bort modulen `ui.frontend` från byggcykeln för hela stacken

   * I kommenterar WKND Sites-projektets rot `pom.xml` posten för undermodulen `<module>ui.frontend</module>`.

   ```xml
       ...
       <modules>
       <module>all</module>
       <module>core</module>
       <!--
       <module>ui.frontend</module>
       -->                
       <module>ui.apps</module>
       ...
   ```

   * Och kommentarrelaterade beroenden från `ui.apps/pom.xml`

   ```xml
       ...
       <!-- ====================================================================== -->
       <!-- D E P E N D E N C I E S                                                -->
       <!-- ====================================================================== -->
           ...
       <!--
           <dependency>
               <groupId>com.adobe.aem.guides</groupId>
               <artifactId>aem-guides-wknd.ui.frontend</artifactId>
               <version>${project.version}</version>
               <type>zip</type>
           </dependency>
       -->    
       ...
   ```

1. Förbered modulen `ui.frontend` för frontend-pipelinekontraktet genom att lägga till två nya webbpaketkonfigurationsfiler.

   * Kopiera den befintliga `webpack.common.js` som `webpack.theme.common.js` och ändra `output`-egenskapen och `MiniCssExtractPlugin`, `CopyWebpackPlugin` plug-in-konfigurationsparametrarna så här:

   ```javascript
   ...
   output: {
           filename: 'theme/js/[name].js', 
           path: path.resolve(__dirname, 'dist')
       }
   ...
   
   ...
       new MiniCssExtractPlugin({
               filename: 'theme/[name].css'
           }),
       new CopyWebpackPlugin({
           patterns: [
               { from: path.resolve(__dirname, SOURCE_ROOT + '/resources'), to: './theme' }
           ]
       })
   ...
   ```

   * Kopiera den befintliga `webpack.prod.js` som `webpack.theme.prod.js` och ändra `common`-variabelns plats till ovanstående fil som

   ```javascript
   ...
       const common = require('./webpack.theme.common.js');
   ...
   ```

   >[!NOTE]
   >
   >De två konfigurationsändringarna ovan för &#39;webpack&#39; är att ha olika namn på utdatafiler och mappar, så det är enkelt att skilja mellan klientlib (fullständig hög) och tema som genereras (frontendspipeline).
   >
   >Som du gissade kan ändringarna ovan hoppas över för att använda befintliga webbpaketskonfigurationer, men nedanstående ändringar krävs.
   >
   >Det är upp till dig hur du vill namnge eller ordna dem.


   * Kontrollera att egenskapsvärdet `name` är samma som platsnamnet från noden `/conf` i filen `package.json`. Under egenskapen `scripts` finns ett `build`-skript som instruerar om hur front end-filerna från den här modulen ska skapas.

   ```javascript
       {
       "name": "wknd",
       "version": "1.0.0",
       ...
   
       "scripts": {
           "build": "webpack --config ./webpack.theme.prod.js"
       }
   
       ...
       }
   ```

1. Förbered modulen `ui.content` för frontendpipeline genom att lägga till två Sling-konfigurationer.

   * Skapa en fil på `com.adobe.cq.wcm.core.components.config.HtmlPageItemsConfig` - detta inkluderar alla frontendfiler som genereras av modulen `ui.frontend` under mappen `dist` med hjälp av webbpaketsbyggprocessen.

   ```xml
   ...
       <css
       jcr:primaryType="nt:unstructured"
       element="link"
       location="header">
       <attributes
           jcr:primaryType="nt:unstructured">
           <as
               jcr:primaryType="nt:unstructured"
               name="as"
               value="style"/>
           <href
               jcr:primaryType="nt:unstructured"
               name="href"
               value="/theme/site.css"/>
   ...
   ```

   >[!TIP]
   >
   >    Se hela [HtmlPageItemsConfig](https://github.com/adobe/aem-guides-wknd/blob/feature/frontend-pipeline/ui.content/src/main/content/jcr_root/conf/wknd/_sling_configs/com.adobe.cq.wcm.core.components.config.HtmlPageItemsConfig/.content.xml) i __AEM WKND Sites-projektet__.


   * Därefter är `com.adobe.aem.wcm.site.manager.config.SiteConfig` med värdet `themePackageName` detsamma som egenskapsvärdet `package.json` och `name` och `siteTemplatePath` pekar på ett `/libs/wcm/core/site-templates/aem-site-template-stub-2.0.0` stub-sökvägsvärde.

   ```xml
   ...
       <?xml version="1.0" encoding="UTF-8"?>
       <jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"
               jcr:primaryType="nt:unstructured"
               siteTemplatePath="/libs/wcm/core/site-templates/aem-site-template-stub-2.0.0"
               themePackageName="wknd">
       </jcr:root>
   ...
   ```

   >[!TIP]
   >
   >    Se hela [SiteConfig](https://github.com/adobe/aem-guides-wknd/blob/feature/frontend-pipeline/ui.content/src/main/content/jcr_root/conf/wknd/_sling_configs/com.adobe.aem.wcm.site.manager.config.SiteConfig/.content.xml) i __AEM WKND Sites-projektet__.

1. Ett eller flera teman ändras för att distribueras via frontendpipeline för en testkörning. `text-color` ändras till Adobe red (eller så kan du välja ett eget) genom att `ui.frontend/src/main/webpack/base/sass/_variables.scss` uppdateras.

   ```css
       $black:     #a40606;
       ...
   ```

Slutligen kan du överföra dessa ändringar till Adobe Git-databasen.


>[!AVAILABILITY]
>
> De här ändringarna är tillgängliga på GitHub i [__frontendpipeline__](https://github.com/adobe/aem-guides-wknd/tree/feature/frontend-pipeline)-grenen i __AEM WKND Sites-projektet__.


## Varning - _Aktivera frontslutspipeline_-knapp

Alternativet [Plats](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/getting-started/basic-handling.html) för [spårningsväljaren](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/getting-started/basic-handling.html) visar knappen **Aktivera frontpipeline** när du väljer platsroten eller webbplatssidan. Om du klickar på knappen **Aktivera frontpipeline** åsidosätts de **Sling-konfigurationer** som anges ovan. Kontrollera att **du inte klickar på den här knappen** efter att du distribuerat de ovanstående ändringarna via Cloud Manager pipeline-körning.

![Aktivera knapp för frontslutspipeline](assets/enable-front-end-Pipeline-button.png)

Om du klickar på den av misstag måste du köra pipelines igen för att se till att slutavtalet för pipeline och ändringarna återställs.

## Grattis! {#congratulations}

Du har uppdaterat WKND Sites-projektet för att aktivera det för det främre pipelinekontraktet.

## Nästa steg {#next-steps}

I nästa kapitel, [Distribuera med frontdelspipeline](create-frontend-pipeline.md), skapar och kör du en frontendpipeline och kontrollerar hur vi __flyttade bort__ från den /etc.clientlibs-baserade frontdelsleveransen.
