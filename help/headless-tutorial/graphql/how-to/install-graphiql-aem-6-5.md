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
duration: 41
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '208'
ht-degree: 0%

---

# Installera GraphiQL IDE på AEM 6.5

I AEM 6.5 måste GraphiQL IDE-verktyget installeras manuellt.

1. Navigera till **[portalen för programvarudistribution](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html)** > **AEM as a Cloud Service**.
1. Sök efter &quot;GraphiQL&quot; (se till att inkludera **i** i **GraphiQL**).
1. Hämta det senaste **GraphiQL-innehållspaketet v.x.x.x**.

   ![Hämta GraphiQL-paket](assets/graphiql/software-distribution.png)

   Zip-filen är ett AEM som kan installeras direkt.

1. Gå till **Verktyg** > **Distribution** > **Paket** från AEM Start-menyn.
1. Klicka på **Överför paket** och välj det paket som hämtades i det föregående steget. Klicka på **Installera** för att installera paketet.

   ![Installera GraphiQL-paketet](assets/graphiql/install-graphiql-package.png)

1. Navigera till **CRXDE Lite** > **Databaspanel** > markera `/content/graphiql`-nod (till exempel <http://localhost:4502/crx/de/index.jsp#/content/graphiql>).
1. Ändra värdet för egenskapen `endpoint` till `/content/_cq_graphql/wknd-shared/endpoint.json` på fliken **Egenskaper**.
   ![Värdeändring för slutpunktsegenskapen](assets/graphiql/endpoint-prop-value-change.png)

1. Navigera till **webbkonsolkonfigurationen** Användargränssnitt > Sök efter **CSRF-filter**-konfigurationen (till exempel <http://localhost:4502/system/console/configMgr/com.adobe.granite.csrf.impl.CSRFFilter)>)
1. I uppdateringen av fältet för egenskapsnamn i `Excluded Paths` är WKND-slutpunktssökvägen för GraphQL `/content/cq:graphql/wknd-shared/endpoint`.

![Uteslut egenskapsvärdeändring för sökvägar](assets/graphiql/exclude-paths-value-change.png)

1. Använd GraphiQL-redigeraren med `//HOST:PORT/content/graphiql.html` och verifiera att du kan skapa en ny fråga eller köra en befintlig fråga. (t.ex. <http://localhost:4502/content/graphiql.html>)

![GraphiQL-redigerare](assets/graphiql/graphiql-editor.png)

>[!TIP]
>
>Om du vill ha stöd för ditt projektspecifika GraphQL-schema och frågekörning måste du göra motsvarande ändringar för värdena `endpoint` och `Excluded Paths` i ovanstående steg.
