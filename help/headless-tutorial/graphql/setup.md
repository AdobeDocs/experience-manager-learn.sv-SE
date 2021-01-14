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
translation-type: tm+mt
source-git-commit: eb2b556c5947b15a31a74a86dadd525fb06bcf14
workflow-type: tm+mt
source-wordcount: '1599'
ht-degree: 0%

---


# Snabbinställningar {#setup}

>[!CAUTION]
>
> AEM GraphQL API för leverans av innehållsfragment är tillgänglig på begäran.
> Kontakta Adobe Support för att aktivera API:t för din AEM som ett Cloud Service-program.

I det här kapitlet finns en snabb konfiguration av en lokal miljö för att se ett externt program konsumera innehåll från AEM med hjälp AEM GraphQL API:er. Senare kapitel i självstudiekursen kommer att bygga vidare på den här inställningen.

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

* [JDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2Fjcr cr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
* [Node.js v10+](https://nodejs.org/en/)
* [npm 6+](https://www.npmjs.com/)
* [Git](https://git-scm.com/)

## Mål {#objectives}

1. Hämta och installera AEM SDK.
1. Hämta och installera exempelinnehåll från WKND Reference-webbplatsen.
1. Hämta och installera en exempelapp för att använda innehåll med GraphQL API:er.

## Installera AEM SDK{#aem-sdk}

I den här självstudien används [AEM som en Cloud Service-SDK](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-as-a-cloud-service-sdk.html?lang=en#aem-as-a-cloud-service-sdk) för att utforska AEM GraphQL API:er. I det här avsnittet finns en snabbguide till hur du installerar AEM SDK och kör det i redigeringsläge. En mer detaljerad guide för hur du konfigurerar en lokal utvecklingsmiljö [finns här](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html?lang=en#local-development-environment-set-up).

>[!NOTE]
>
> Det går också att följa självstudiekursen med en AEM som Cloud Service. Ytterligare information om hur du använder en molnmiljö finns i självstudiekursen.

1. Gå till **[portalen för programvarudistribution](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)** > **AEM som en Cloud Service** och hämta den senaste versionen av **AEM SDK**.

   ![Programdistributionsportal](assets/setup/software-distribution-portal-download.png)

1. Zippa upp nedladdningen och kopiera Quickstart jar (`aem-sdk-quickstart-XXX.jar`) till en dedikerad mapp, d.v.s. `~/aem-sdk/author`.
1. Ge filen ett nytt namn till `aem-author-p4502.jar`.
1. Öppna ett nytt terminalfönster och navigera till mappen som innehåller filen jar. Kör följande kommando för att installera och starta AEM:

   ```shell
   $ cd ~/aem-sdk/author
   $ java -jar aem-author-p4502.jar
   ```

1. Ange ett administratörslösenord som `admin`. Alla administratörslösenord är godtagbara, men de rekommenderas att använda standardvärdet för lokal utveckling för att minska behovet av att konfigurera om.
1. Efter några minuter kommer AEM att slutföra installationen och ett nytt webbläsarfönster öppnas på [http://localhost:4502](http://localhost:4502).
1. Logga in med användarnamnet `admin` och lösenordet `admin`.

>[!CAUTION]
>
> För att kunna fortsätta med installationen måste GraphQL-funktionen nu aktiveras manuellt i QuickStart SDK. Kontakta Adobe för ytterligare instruktioner. Det här manuella steget behövs bara tills funktionen släpps 2021.

## Installera exempelinnehåll{#wknd-site}

Exempelinnehåll från WKND Reference-webbplatsen installeras för att snabba upp självstudiekursen. WKND är ett fiktivt vardagsmärke som ofta används tillsammans med AEM utbildning.

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

   **Innehållsfragment** är ett av sätten att hantera innehåll i AEM. Innehållsfragment är återanvändbart, presentationsbaserat innehåll som består av strukturerade dataelement som text, formaterad text, datum eller referenser till andra innehållsfragment. Innehållsfragment utforskas senare i självstudiekursen.

1. Klicka på **Avbryt** för att stänga fragmentet. Du kan navigera i några andra mappar och utforska det andra innehållet i Adventure.

>[!NOTE]
>
> Om du använder en kodmiljö läser du dokumentationen om hur du [distribuerar en kodbas som WKND Reference-platsen till en Cloud Service-miljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/overview.html?lang=en#deploying).

## Installera GraphQL-slutpunkter{#graphql-endpoint}

GraphQL-slutpunkter måste konfigureras. Detta ger flexibilitet i projektet när det gäller att fastställa exakt vilken slutpunkt GraphQL-API:t exponeras för. Ett [CORS](#cors-config) krävs också för att ge åtkomst till ett externt program. För att underlätta självstudiekursen har ett paket skapats i förväg.

1. Hämta [aem-guides-wknd-graphql.all-1.0.0-SNAPSHOT.zip](./assets/setup/aem-guides-wknd-graphql.all-1.0.0-SNAPSHOT.zip)-paketet.
1. I menyn **AEM Start** går du till **Verktyg** > **Distribution** > **Paket**.
1. Klicka på **Överför paket** och välj det paket som hämtades i föregående steg. Klicka på **Installera** för att installera paketet.

Ovanstående paket innehåller också [GraphiQL-verktyget](https://github.com/graphql/graphiql) som ska användas i senare kapitel. Mer information om CORS-konfigurationen finns nedan [](#cors-config).

## Installera exempelappen{#sample-app}

Ett av målen med den här självstudiekursen är att visa hur du använder AEM innehåll från ett externt program med GraphQL API:er. I den här självstudien används ett exempel på React App (React App) som delvis har slutförts för att snabba upp självstudiekursen. Samma lektioner och koncept gäller appar som skapats med iOS, Android eller någon annan plattform. Reaktionsappen är avsiktligt enkel för att undvika onödig komplexitet. Det är inte avsett att vara en referensimplementering.

1. Öppna ett nytt terminalfönster och klona självstudiekursens startgren med Git:

   ```shell
   $ git clone --branch tutorial/react git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Öppna filen `.env.development` på `aem-guides-wknd-graphql/react-app/.env.development` i den utvecklingsmiljö du väljer. Avkommentera `REACT_APP_AUTHORIZATION`-raden så att filen ser ut så här:

   ```plain
   REACT_APP_HOST_URI=http://localhost:4502
   REACT_APP_GRAPHQL_ENDPOINT=/content/graphql/endpoint.gql
   REACT_APP_AUTHORIZATION=admin:admin
   ```

   Kontrollera att `React_APP_HOST_URI` matchar den lokala AEM instansen. I det här kapitlet ansluter vi React App direkt till AEM **Author**-miljön och måste därför autentisera. Detta är vanligt under utvecklingen, eftersom det gör det möjligt för oss att snabbt göra ändringar i AEM och omedelbart se hur de återspeglas i appen.

   >[!NOTE]
   >
   > I ett produktionsscenario ansluter appen till en AEM **Publish**-miljö. Detta beskrivs mer ingående senare i självstudiekursen.

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

1. Använd webbläsarens utvecklarverktyg för att kontrollera **nätverks**-begäranden. Visa **XHR**-begäranden och observera flera begäranden om POST till `/content/graphql/endpoint.gql`, den GraphQL-slutpunkt som konfigurerats för AEM.

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

## Grattis! {#congratulations}

Grattis, du har nu ett externt program som AEM innehåll med GraphQL. Du kan granska koden i React-appen och fortsätta experimentera med att ändra befintliga innehållsfragment.

## Nästa steg {#next-steps}

I nästa kapitel, [Defining Content Fragment Models](content-fragment-models.md), får du lära dig att modellera innehåll och skapa ett schema med **Content Fragment Models**. Du kommer att granska befintliga modeller och skapa en ny modell. Du får också lära dig mer om de olika datatyper som kan användas för att definiera ett schema som en del av modellen.

## (Bonus) CORS-konfiguration {#cors-config}

AEM, som är säkert som standard, blockerar förfrågningar om korsursprung och förhindrar att obehöriga program ansluter till och tar sig förbi innehållet.

För att den här självstudiekursens React-app ska kunna interagera med AEM GraphQL API-slutpunkter har en resursdelningskonfiguration för korsursprung definierats i GraphQL-slutpunktspaketet.

![Konfiguration för resursdelning mellan ursprung](./assets/setup/cross-origin-resource-sharing-configuration.png)

Så här konfigurerar du manuellt:

1. Gå till AEM SDK:s webbkonsol på **Verktyg** > **Åtgärder** > **Webbkonsol**
1. Klicka på raden **Resursdelningsprincip för korsursprung för Adobe Granite** för att skapa en ny konfiguration
1. Uppdatera följande fält och låt de andra behålla sina standardvärden:
   * Tillåtna ursprungsobjekt: `localhost:3000`
   * Tillåtna ursprung (Regex): `.* `
   * Tillåtna sökvägar: `/content/graphql/endpoint.gql`
   * Tillåtna metoder: `GET`, `HEAD`, `POST`
      * Endast `POST` krävs för GraphQL, men de andra metoderna kan vara användbara när du interagerar med AEM utan huvud.
   * Autentiseringsuppgifter stöds: `Yes`
      * Detta krävs eftersom React-appen kommunicerar med de skyddade GraphQL-slutpunkterna på AEM Author-tjänsten.
1. Klicka på **Spara**

Den här konfigurationen tillåter `POST` HTTP-begäranden som kommer från `localhost:3000` till AEM Author-tjänsten på sökvägen `/content/graphql/endpoint.gql`.

Den här konfigurationen och GraphQL-slutpunkterna genereras från ett AEM projekt. [Se informationen här](https://github.com/adobe/aem-guides-wknd-graphql/tree/master/aem-project).
