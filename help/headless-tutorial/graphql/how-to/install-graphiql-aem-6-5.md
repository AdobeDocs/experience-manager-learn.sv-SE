---
title: Installera GraphiQL IDE på AEM 6.5
description: Lär dig installera och konfigurera GraphiQL IDE på AEM 6.5
version: 6.5
topic: Headless
feature: GraphQL API
role: Developer
level: Intermediate
jira: KT-11614
thumbnail: KT-10253.jpeg
exl-id: 04fcc24c-7433-4443-a109-f01840ef1a89
duration: 55
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '208'
ht-degree: 0%

---

# Installera GraphiQL IDE på AEM 6.5

I AEM 6.5 måste GraphiQL IDE-verktyget installeras manuellt.

1. Navigera till **[Programdistributionsportal](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)** > **AEM as a Cloud Service**.
1. Sök efter &quot;GraphiQL&quot; (se till att inkludera **i** in **GraphiQL**).
1. Ladda ned den senaste **Innehållspaket för GraphiQL v.x.x.x**.

   ![Hämta GraphiQL-paket](assets/graphiql/software-distribution.png)

   Zip-filen är ett AEM som kan installeras direkt.

1. Gå till AEM Start-menyn **verktyg** > **Distribution** > **Paket**.
1. Klicka **Överför paket** och välj det paket som laddats ned i föregående steg. Klicka **Installera** för att installera paketet.

   ![Installera GraphiQL-paket](assets/graphiql/install-graphiql-package.png)

1. Navigera till **CRXDE Lite** > **Databaspanel** > markera `/content/graphiql` nod (till exempel <http://localhost:4502/crx/de/index.jsp#/content/graphiql>).
1. I **Egenskaper** tabbändringsvärde för `endpoint` egenskap till `/content/_cq_graphql/wknd-shared/endpoint.json`.
   ![Ändra egenskapsvärde för slutpunkt](assets/graphiql/endpoint-prop-value-change.png)

1. Navigera till **Konfiguration av webbkonsol** Gränssnitt > Sök efter **CSRF-filter** konfiguration (till exempel<http://localhost:4502/system/console/configMgr/com.adobe.granite.csrf.impl.CSRFFilter)>
1. I `Excluded Paths` egenskapsnamnfältsuppdatering, WKND-slutpunktssökvägen för GraphQL till `/content/cq:graphql/wknd-shared/endpoint`.

![Uteslut ändringar i egenskapsvärde för sökvägar](assets/graphiql/exclude-paths-value-change.png)

1. Få åtkomst till GraphiQL-redigeraren med `//HOST:PORT/content/graphiql.html`och verifiera att du kan skapa en ny fråga eller köra en befintlig fråga. (t.ex. <http://localhost:4502/content/graphiql.html>)

![GraphiQL Editor](assets/graphiql/graphiql-editor.png)

>[!TIP]
>
>För att stödja ditt projektspecifika GraphQL-schema och -frågekörning måste du göra motsvarande ändringar för `endpoint` och `Excluded Paths` värden i ovanstående steg.
