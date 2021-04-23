---
title: Snabbinstallation - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Installera AEM SDK, lägg till exempelinnehåll och distribuera ett program som använder innehåll från AEM med GraphQL API:er. Se hur AEM driver flerkanalsupplevelser.
sub-product: platser
topics: headless
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
mini-toc-levels: 1
kt: 6386
thumbnail: KT-6386.jpg
feature: Innehållsfragment, GraphQL API:er
topic: Headless, Content Management
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: 81626b8d853f3f43d9c51130acf02561f91536ac
workflow-type: tm+mt
source-wordcount: '1830'
ht-degree: 0%

---


# Snabbinställningar {#setup}

I det här kapitlet finns en snabb konfiguration av en lokal miljö för att se ett externt program konsumera innehåll från AEM med hjälp AEM GraphQL API:er. Senare kapitel i självstudiekursen kommer att bygga vidare på den här inställningen.

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

* [JDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
* [Node.js v10+](https://nodejs.org/en/)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)

## Mål {#objectives}

1. Hämta och installera AEM SDK.
1. Hämta och installera exempelinnehåll från WKND Reference-webbplatsen.
1. Hämta och installera en exempelapp för att använda innehåll med GraphQL API:er.

## Installera AEM SDK {#aem-sdk}

I den här självstudien används [AEM som en Cloud Service-SDK](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-as-a-cloud-service-sdk.html?lang=en#aem-as-a-cloud-service-sdk) för att utforska AEM GraphQL API:er. I det här avsnittet finns en snabbguide till hur du installerar AEM SDK och kör det i redigeringsläge. En mer detaljerad guide för hur du konfigurerar en lokal utvecklingsmiljö [finns här](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=en#local-development-environment-set-up).

>[!NOTE]
>
> Det går också att följa självstudiekursen med en AEM som Cloud Service. Ytterligare information om hur du använder en molnmiljö finns i självstudiekursen.

1. Gå till **[portalen för programvarudistribution](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)** > **AEM som en Cloud Service** och hämta den senaste versionen av **AEM SDK**.

   ![Programdistributionsportal](assets/setup/software-distribution-portal-download.png)

   >[!CAUTION]
   >
   > GraphQL-funktionen är som standard endast aktiverad för AEM SDK från 2021-02-04 eller senare.

1. Zippa upp nedladdningen och kopiera Quickstart jar (`aem-sdk-quickstart-XXX.jar`) till en dedikerad mapp, d.v.s. `~/aem-sdk/author`.
1. Ge filen ett nytt namn till `aem-author-p4502.jar`.

   `author`-namnet anger att QuickStart-behållaren startar i redigeringsläge. `p4502` anger att QuickStart-servern ska köras på port 4502.

1. Öppna ett nytt terminalfönster och navigera till mappen som innehåller filen jar. Kör följande kommando för att installera och starta AEM:

   ```shell
   $ cd ~/aem-sdk/author
   $ java -jar aem-author-p4502.jar
   ```

1. Ange ett administratörslösenord som `admin`. Alla administratörslösenord är godtagbara, men de rekommenderas att använda standardvärdet för lokal utveckling för att minska behovet av att konfigurera om.
1. Efter några minuter kommer AEM att slutföra installationen och ett nytt webbläsarfönster öppnas på [http://localhost:4502](http://localhost:4502).
1. Logga in med användarnamnet `admin` och lösenordet `admin`.

## Installera exempelinnehåll och GraphQL-slutpunkter {#wknd-site-content-endpoints}

Exempelinnehåll från **WKND-referenswebbplatsen** installeras för att snabba upp självstudiekursen. WKND är ett fiktivt vardagsmärke som ofta används tillsammans med AEM utbildning.

WKND-referenswebbplatsen innehåller konfigurationer som behövs för att visa en [GraphQL-slutpunkt](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/admin/graphql-api-content-fragments.html?lang=en#graphql-aem-endpoint). I en implementering i verkligheten följer du de dokumenterade stegen för att [inkludera GraphQL-slutpunkterna](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/admin/graphql-api-content-fragments.html?lang=en#graphql-aem-endpoint) i ditt kundprojekt. Ett [CORS](#cors-config) har också paketerats som en del av WKND-platsen. En CORS-konfiguration krävs för att ge åtkomst till ett externt program. Mer information om [CORS](#cors-config) finns nedan.

1. Ladda ned det senaste kompilerade AEM-paketet för WKND-webbplatsen: [aem-guides-wknd.all-x.x.x.zip](https://github.com/adobe/aem-guides-wknd/releases/latest).

   >[!NOTE]
   >
   > Se till att hämta standardversionen som är kompatibel med AEM som Cloud Service och **inte** `classic`-versionen.

1. I menyn **AEM Start** går du till **Verktyg** > **Distribution** > **Paket**.

   ![Navigera till paket](assets/setup/navigate-to-packages.png)

1. Klicka på **Överför paket** och välj det WKND-paket som hämtades i föregående steg. Klicka på **Installera** för att installera paketet.

1. På **AEM Start**-menyn navigerar du till **Resurser** > **Filer**.
1. Klicka igenom mapparna för att navigera till **WKND-plats** > **Engelska** > **Adventures**.

   ![Mappvy över annonser](assets/setup/folder-view-adventures.png)

   Det här är en mapp med alla resurser som består av de olika annonser som WKND-varumärket främjar. Detta omfattar traditionella medietyper som bilder och video samt media som är specifika för AEM som **Content Fragments**.

1. Klicka på mappen **Skiing Wyoming** och klicka på **Skiing Wyoming Content Fragment**-kortet nedåt:

   ![Nedpil, hoppa över innehållets fragmentkort](assets/setup/downhill-skiing-cntent-fragment.png)

1. Gränssnittet i Content Fragment Editor öppnas för Hoing Wyoming-äventyret.

   ![Innehållsfragment för nedåtgående Skift](assets/setup/down-hillskiing-fragment.png)

   Observera att olika fält som **Title**, **Description** och **Activity** definierar fragmentet.

   **Innehållsfragment är ett** sätt som innehåll kan hanteras i AEM. Innehållsfragment är återanvändbart, presentationsbaserat innehåll som består av strukturerade dataelement som text, formaterad text, datum eller referenser till andra innehållsfragment. Innehållsfragment utforskas senare i självstudiekursen.

1. Klicka på **Avbryt** för att stänga fragmentet. Du kan navigera i några andra mappar och utforska det andra innehållet i Adventure.

>[!NOTE]
>
> Om du använder en kodmiljö läser du dokumentationen om hur du [distribuerar en kodbas som WKND Reference-platsen till en Cloud Service-miljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/overview.html?lang=en#deploying).

## Installera exempelappen{#sample-app}

Ett av målen med den här självstudiekursen är att visa hur du använder AEM innehåll från ett externt program med GraphQL API:er. I den här självstudien används ett exempel på React App (React App) som delvis har slutförts för att snabba upp självstudiekursen. Samma lektioner och koncept gäller appar som skapats med iOS, Android eller någon annan plattform. Reaktionsappen är avsiktligt enkel för att undvika onödig komplexitet. Det är inte avsett att vara en referensimplementering.

1. Öppna ett nytt terminalfönster och klona självstudiekursens startgren med Git:

   ```shell
   $ git clone --branch tutorial/react git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna filen `.env.development` på `aem-guides-wknd-graphql/react-app/.env.development` i den utvecklingsmiljö du väljer. Kontrollera att raden `REACT_APP_AUTHORIZATION` inte är kommenterad och att filen ser ut så här:

   ```plain
   REACT_APP_HOST_URI=http://localhost:4502
   REACT_APP_GRAPHQL_ENDPOINT=/content/graphql/global/endpoint.json
   # Use Authorization when connecting to an AEM Author environment
   REACT_APP_AUTHORIZATION=admin:admin
   ```

   Kontrollera att `React_APP_HOST_URI` matchar den lokala AEM instansen. I det här kapitlet ansluter vi React App direkt till AEM **Author**-miljön. **I** redigeringsmiljöer krävs som standard autentisering, så vår app ansluts som  `admin` användare. Detta är vanligt under utvecklingen, eftersom det gör det möjligt för oss att snabbt göra ändringar i AEM och omedelbart se hur de återspeglas i appen.

   >[!NOTE]
   >
   > I ett produktionsscenario ansluter appen till en AEM **Publish**-miljö. Detta beskrivs mer ingående i kapitlet [Produktionsdistribution](production-deployment.md).

1. Navigera till mappen `aem-guides-wknd-graphql/react-app`. Installera och starta programmet:

   ```shell
   $ cd aem-guides-wknd-graphql/react-app
   $ npm install
   $ npm start
   ```

1. Ett nytt webbläsarfönster bör automatiskt starta programmet på [http://localhost:3000](http://localhost:3000).

   ![Reagera på startprogram](assets/setup/react-starter-app.png)

   En lista över det aktuella Adventure-innehållet från AEM ska visas.

1. Klicka på en av äventyrsbilderna för att visa äventyrsdetaljer. En begäran görs om att AEM ska returnera detaljerna för ett äventyr.

   ![Vyn Adventure Details](assets/setup/adventure-details-view.png)

1. Använd webbläsarens utvecklarverktyg för att kontrollera **nätverks**-begäranden. Visa **XHR**-begäranden och observera flera begäranden om POST till `/content/graphql/global/endpoint.json`, den GraphQL-slutpunkt som konfigurerats för AEM.

   ![XHR-begäran för GraphQL Endpoint](assets/setup/endpoint-gql.png)

1. Du kan också visa parametrarna och JSON-svaret genom att granska nätverksbegäran. Det kan vara praktiskt att installera ett webbläsartillägg som [GraphQL Network](https://chrome.google.com/webstore/detail/graphql-network/igbmhmnkobkjalekgiehijefpkdemocm) for Chrome för att få en bättre förståelse för frågan och svaret.

   ![GraphQL-nätverkstillägg](assets/setup/GraphQL-extension.png)

   *Använda Chrome-tillägget GraphQL-nätverk*

## Ändra ett innehållsfragment

Nu när React-appen är igång uppdaterar du innehållet i AEM och ser ändringarna i appen.

1. Navigera till AEM [http://localhost:4502](http://localhost:4502).
1. Navigera till **Resurser** > **Filer** > **WKND-plats** > **Engelska** > **Tillägg** > **[Bali Surf Camp](http://localhost:4502/assets.html/content/dam/wknd/en/adventures/bali-surf-camp)**.

   ![Mappen Bali Surf Camp](assets/setup/bali-surf-camp-folder.png)

1. Klicka på innehållsfragmentet **Bali Surf Camp** för att öppna Content Fragment Editor.
1. Ändra **titeln** och **beskrivningen** för äventyret

   ![Ändra innehållsfragment](assets/setup/modify-content-fragment-bali.png)

1. Klicka på **Spara** för att spara ändringarna.
1. Gå tillbaka till React-appen på [http://localhost:3000](http://localhost:3000) och uppdatera för att se ändringarna:

   ![Uppdaterat Bali Surf Camp Adventure](assets/setup/overnight-bali-surf-camp-changes.png)

## Installera GraphiQL-verktyget {#install-graphiql}

[](https://github.com/graphql/graphiql) GraphiQL är ett utvecklingsverktyg som bara behövs i miljöer på låg nivå, t.ex. en utvecklingsmiljö eller lokal instans. Med GraphiQL IDE kan du snabbt testa och finjustera frågor och data som returneras. GraphiQL ger också enkel åtkomst till dokumentationen vilket gör det enkelt att ta reda på vilka metoder som finns tillgängliga.

1. Navigera till **[portalen för programvarudistribution](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)** > **AEM som en Cloud Service**.
1. Sök efter &quot;GraphiQL&quot; (se till att inkludera **i** i **GraphiQL**.
1. Ladda ned det senaste **GraphiQL-innehållspaketet v.x.x.x**

   ![Hämta GraphiQL-paket](assets/explore-graphql-api/software-distribution.png)

   Zip-filen är ett AEM som kan installeras direkt.

1. I menyn **AEM Start** går du till **Verktyg** > **Distribution** > **Paket**.
1. Klicka på **Överför paket** och välj det paket som hämtades i föregående steg. Klicka på **Installera** för att installera paketet.

   ![Installera GraphiQL-paket](assets/explore-graphql-api/install-graphiql-package.png)
1. Navigera till GraphiQL IDE på [http://localhost:4502/content/graphiql.html](http://localhost:4502/content/graphiql.html) och börja utforska GraphQL API:er.

   >[!NOTE]
   >
   > GraphiQL-verktyget och GraphQL API är [utforskade mer i detalj senare i självstudiekursen](./explore-graphql-api.md).

## Grattis! {#congratulations}

Grattis, du har nu ett externt program som AEM innehåll med GraphQL. Du kan granska koden i React-appen och fortsätta experimentera med att ändra befintliga innehållsfragment.

## Nästa steg {#next-steps}

I nästa kapitel, [Defining Content Fragment Models](content-fragment-models.md), får du lära dig att modellera innehåll och skapa ett schema med **Content Fragment Models**. Du kommer att granska befintliga modeller och skapa en ny modell. Du får också lära dig mer om de olika datatyper som kan användas för att definiera ett schema som en del av modellen.

## (Bonus) CORS-konfiguration {#cors-config}

AEM, som är säkert som standard, blockerar förfrågningar om korsursprung och förhindrar att obehöriga program ansluter till och tar sig förbi innehållet.

För att den här självstudiekursens React-app ska kunna interagera med AEM GraphQL API-slutpunkter har en resursdelningskonfiguration för korsursprung definierats i WKND-referensprojektet för webbplatsen.

![Konfiguration för resursdelning mellan ursprung](assets/setup/cross-origin-resource-sharing-configuration.png)

Så här visar du distribuerad konfiguration:

1. Gå till AEM SDK:s webbkonsol på [http://localhost:4502/system/console](http://localhost:4502/system/console).

   >[!NOTE]
   >
   > Webbkonsolen är bara tillgänglig på SDK:n. I en AEM som en Cloud Service-miljö kan den här informationen visas via [utvecklarkonsolen](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/debugging/debugging-aem-as-a-cloud-service/developer-console.html).

1. Klicka på **OSGI** > **Configuration** för att visa alla [OSGi-konfigurationer](http://localhost:4502/system/console/configMgr).
1. Bläddra nedåt på sidan **Resursdelning mellan ursprung för Adobe Granite**.
1. Klicka på konfigurationen för `com.adobe.granite.cors.impl.CORSPolicyImpl~wknd-graphql`.
1. Följande fält har uppdaterats:
   * Tillåtna ursprung (Regex): `http://localhost:.*`
      * Tillåter alla lokala värdanslutningar.
   * Tillåtna sökvägar: `/content/graphql/global/endpoint.json`
      * Det här är den enda GraphQL-slutpunkten som är konfigurerad just nu. Enligt god praxis bör COR-konfigurationer vara så restriktiva som möjligt.
   * Tillåtna metoder: `GET`, `HEAD`, `POST`
      * Endast `POST` krävs för GraphQL, men de andra metoderna kan vara användbara när du interagerar med AEM utan huvud.
   * Rubriker som stöds: **auktorisering** har lagts till för att skicka grundläggande autentisering i författarmiljön.
   * Autentiseringsuppgifter stöds: `Yes`
      * Detta krävs eftersom React-appen kommunicerar med de skyddade GraphQL-slutpunkterna på AEM Author-tjänsten.

Den här konfigurationen och GraphQL-slutpunkterna är en del av AEM WKND-projekt. Du kan visa alla [OSGi-konfigurationer här](https://github.com/adobe/aem-guides-wknd/tree/master/ui.config/src/main/content/jcr_root/apps/wknd/osgiconfig).
