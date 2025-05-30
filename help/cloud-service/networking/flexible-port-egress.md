---
title: Flexibel portutgång
description: Lär dig hur du konfigurerar och använder flexibel portutgångar för att stödja externa anslutningar från AEM as a Cloud Service till externa tjänster.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9350
thumbnail: KT-9350.jpeg
exl-id: 5c1ff98f-d1f6-42ac-a5d5-676a54ef683c
last-substantial-update: 2024-04-26T00:00:00Z
duration: 870
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1275'
ht-degree: 0%

---

# Flexibel portutgång

Lär dig hur du konfigurerar och använder flexibel portutgångar för att stödja externa anslutningar från AEM as a Cloud Service till externa tjänster.

## Vad är flexibel hamnutgång?

Flexibel portutgång gör det möjligt att koppla anpassade, specifika regler för portvidarebefordran till AEM as a Cloud Service, vilket gör det möjligt att ansluta från AEM till externa tjänster.

Ett Cloud Manager-program kan bara ha en __enskild__ nätverksinfrastrukturtyp. Kontrollera att flexibel portutgång är den [lämpligaste typen av nätverksinfrastruktur](./advanced-networking.md) för din AEM as a Cloud Service innan du kör följande kommandon.

>[!MORELIKETHIS]
>
> Läs AEM as a Cloud Service [dokumentation om avancerad nätverkskonfiguration](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking) om du vill ha mer information om flexibel portutgång.


## Förutsättningar

Följande krävs när du ställer in eller konfigurerar flexibel portutgångar med Cloud Manager API:er:

+ Adobe Developer Console-projekt med Cloud Manager API aktiverat och [Cloud Manager Business Owner-behörigheter](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/permissions/)
+ Åtkomst till [Cloud Manager API:ts autentiseringsuppgifter](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/create-api-integration/)
   + Organisations-ID (även IMS Org-ID)
   + Klient-ID (även API-nyckel)
   + Åtkomsttoken (även Bearer Token)
+ Cloud Manager program-ID
+ Cloud Manager miljö-ID:n

Mer information finns i [Konfigurera och hämta API-autentiseringsuppgifter för Cloud Manager](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/developing/extensibility/app-builder/server-to-server-auth) så att du kan använda dem för att göra ett Cloud Manager API-anrop.

I den här självstudien används `curl` för att skapa Cloud Manager API-konfigurationer. De `curl`-kommandon som tillhandahålls förutsätter en Linux/macOS-syntax. Om du använder kommandotolken i Windows ersätter du radbrytningstecknet `\` med `^`.


## Möjliggör flexibel portutgång per program

Börja med att aktivera den flexibla porten i AEM as a Cloud Service.

>[!BEGINTABS]

>[!TAB Cloud Manager]

Flexibel portutgång kan aktiveras med Cloud Manager. I följande steg beskrivs hur du aktiverar flexibel portutgång på AEM as a Cloud Service med Cloud Manager.

1. Logga in på [Adobe Experience Manager Cloud Manager](https://experience.adobe.com/cloud-manager/) som Cloud Manager Business Owner.
1. Navigera till önskat program.
1. Navigera till __Tjänster > Nätverksinfrastrukturer__ på den vänstra menyn.
1. Välj knappen __Lägg till nätverksinfrastruktur__.

   ![Lägg till nätverksinfrastruktur](./assets/cloud-manager__add-network-infrastructure.png)

1. I dialogrutan __Lägg till nätverksinfrastruktur__ väljer du alternativet __Flexibel portutgång__ och väljer __Region__ för att skapa den dedikerade IP-adressen för utgångar.

   ![Lägg till flexibel portutgång](./assets/flexible-port-egress/select-type.png)

1. Välj __Spara__ om du vill bekräfta att den flexibla porten har lagts till.

   ![Bekräfta skapande av flexibel portutgång](./assets/flexible-port-egress/confirmation.png)

1. Vänta tills nätverksinfrastrukturen har skapats och markerats som __Ready__. Den här processen kan ta upp till 1 timme.

   ![Status för skapande av flexibel portutgång](./assets/flexible-port-egress/ready.png)

När du har skapat en flexibel portutgång kan du nu konfigurera regler för portvidarebefordran med Cloud Manager API:er enligt beskrivningen nedan.

>[!TAB Cloud Manager API:er]

Flexibel portutgång kan aktiveras med Cloud Manager API:er. I följande steg beskrivs hur du aktiverar flexibel portutgång på AEM as a Cloud Service med Cloud Manager API.

1. Kontrollera först att regionen Advanced Networking har konfigurerats i med Cloud Manager API-åtgärden [listRegions](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/). `region name` krävs för efterföljande Cloud Manager API-anrop. Normalt används regionen där produktionsmiljön finns.

   Hitta AEM as a Cloud Service-miljöns region i [Cloud Manager](https://my.cloudmanager.adobe.com) under [miljöns information](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments). Regionnamnet som visas i Cloud Manager kan [mappas till regionkoden](https://developer.adobe.com/experience-cloud/cloud-manager/guides/api-usage/creating-programs-and-environments/#creating-aem-cloud-service-environments) som används i Cloud Manager API.

   __listRegions HTTP request__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/regions \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' 
   ```

2. Aktivera flexibel portutgång för ett Cloud Manager-program med Cloud Manager API-åtgärden [createNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/). Använd rätt `region`-kod som hämtats från Cloud Manager API `listRegions` -åtgärden.

   __createNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X POST https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructures \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d '{ "kind": "flexiblePortEgress", "region": "va7" }'
   ```

   Vänta i 15 minuter tills Cloud Manager-programmet tillhandahåller nätverksinfrastrukturen.

3. Kontrollera att miljön har slutfört __flexibel portutgångskonfiguration__ med Cloud Manager API [getNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/#operation/getNetworkInfrastructure) -åtgärden, med hjälp av `id` som returnerades från HTTP-begäran `createNetworkInfrastructure` i föregående steg.

   __getNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructure/{networkInfrastructureId} \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

   Kontrollera att HTTP-svaret innehåller __status__ av __ready__. Om du inte är klar ännu kontrollerar du statusen var några minut.

När du har skapat en flexibel portutgång kan du nu konfigurera regler för portvidarebefordran med Cloud Manager API:er enligt beskrivningen nedan.

>[!ENDTABS]

## Konfigurera flexibla portaregresproxy per miljö

1. Aktivera och konfigurera konfigurationen för __flexibel portutgångar__ i varje AEM as a Cloud Service-miljö med Cloud Manager API-åtgärden [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) .

   __enableEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X PUT https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d @./flexible-port-egress.json
   ```

   Definiera JSON-parametrarna i en `flexible-port-egress.json` och tillhandahåll för att rulla via `... -d @./flexible-port-egress.json`.

   [Hämta exemplet flexible-port-egress.json](./assets/flexible-port-egress.json). Filen är bara ett exempel. Konfigurera filen efter behov baserat på de valfria/obligatoriska fälten som beskrivs i [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/).

   ```json
   {
       "portForwards": [
           {
               "name": "mysql.example.com",
               "portDest": 3306,
               "portOrig": 30001
           },
           {
               "name": "smtp.sendgrid.com",
               "portDest": 465,
               "portOrig": 30002
           }
       ]
   }
   ```

   För varje `portForwards`-mappning definierar det avancerade nätverket följande vidarebefordringsregel:

   | Proxyvärd | Proxyport |  | Extern värd | Extern port |
   |---------------------------------|----------|----------------|------------------|----------|
   | `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |

   Om din AEM-distribution __endast__ kräver HTTP/HTTPS-anslutningar (port 80/443) till den externa tjänsten lämnar du `portForwards`-arrayen tom, eftersom dessa regler bara krävs för icke-HTTP/HTTPS-begäranden.

1. Verifiera egresreglerna för varje miljö med Cloud Manager API-åtgärden [getEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/).

   __getEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Content-Type: application/json'
   ```

1. Flexibla portutgångskonfigurationer kan uppdateras med Cloud Manager API-åtgärden [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) . Kom ihåg att `enableEnvironmentAdvancedNetworkingConfiguration` är en `PUT`-åtgärd, så alla regler måste anges med varje anrop av den här åtgärden.

1. Nu kan du använda den flexibla konfigurationen av portutgångar i din anpassade AEM-kod och konfiguration.


## Ansluta till externa tjänster via flexibel hamnutgång

När den flexibla portaregresproxyn är aktiverad kan AEM-kod och konfiguration använda dem för att ringa till externa tjänster. Det finns två varianter av externa anrop som AEM hanterar på olika sätt:

1. HTTP/HTTPS-anrop till externa tjänster på icke-standardportar
   + Innehåller HTTP/HTTPS-anrop till tjänster som körs på andra portar än standardportarna 80 eller 443.
1. icke-HTTP/HTTPS-anrop till externa tjänster
   + Inkluderar alla icke-HTTP-anrop, till exempel anslutningar med e-postservrar, SQL-databaser eller tjänster som körs på andra icke-HTTP/HTTPS-protokoll.

HTTP/HTTPS-begäranden från AEM på standardportar (80/443) tillåts som standard och kräver ingen extra konfiguration eller överväganden.


### HTTP/HTTPS på portar som inte är standard

När du skapar HTTP/HTTPS-anslutningar till portar som inte är standard (not-80/443) från AEM, måste anslutningarna göras via en särskild värd och portar, som tillhandahålls via platshållare.

AEM tillhandahåller två uppsättningar särskilda Java™-systemvariabler som mappar till AEM HTTP/HTTPS-proxy.

| Variabelnamn | Använd | Java™-kod | OSGi-konfiguration |
| - |  - | - | - |
| `AEM_PROXY_HOST` | Proxyvärd för både HTTP/HTTPS-anslutningar | `System.getenv().getOrDefault("AEM_PROXY_HOST", "proxy.tunnel")` | `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` |
| `AEM_HTTP_PROXY_PORT` | Proxyport för HTTPS-anslutningar (ange reserv till `3128`) | `System.getenv().getOrDefault("AEM_HTTP_PROXY_PORT", 3128)` | `$[env:AEM_HTTP_PROXY_PORT;default=3128]` |
| `AEM_HTTPS_PROXY_PORT` | Proxyport för HTTPS-anslutningar (ange reserv till `3128`) | `System.getenv().getOrDefault("AEM_HTTPS_PROXY_PORT", 3128)` | `$[env:AEM_HTTPS_PROXY_PORT;default=3128]` |

När du gör HTTP/HTTPS-anrop till externa tjänster på icke-standardportar, behöver ingen motsvarande `portForwards` definieras med Cloud Manager API `enableEnvironmentAdvancedNetworkingConfiguration` -åtgärden eftersom reglerna för portvidarebefordran är definierade i koden.

>[!TIP]
>
> I AEM as a Cloud Service dokumentation för flexibel portutgång finns [en fullständig uppsättning routningsregler](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking).

#### Exempel på koder

<table>
<tr>
<td>
    <a  href="./examples/http-on-non-standard-ports-flexible-port-egress.md"><img alt="HTTP/HTTPS på portar som inte är standard" src="./assets/code-examples__http.png"/></a>
    <div><strong><a href="./examples/http-on-non-standard-ports-flexible-port-egress.md">HTTP/HTTPS på portar som inte är standard</a></strong></div>
    <p>
        Exempel på Java™-kod som skapar HTTP/HTTPS-anslutning från AEM as a Cloud Service till en extern tjänst på icke-standard HTTP/HTTPS-portar.
    </p>
</td>   
<td></td>   
<td></td>   
</tr>
</table>

### Icke-HTTP/HTTPS-anslutningar till externa tjänster

När anslutningar som inte är HTTP/HTTPS skapas (t.ex. SQL, SMTP och så vidare) från AEM måste anslutningen upprättas via ett särskilt värdnamn som tillhandahålls av AEM.

| Variabelnamn | Använd | Java™-kod | OSGi-konfiguration |
| - |  - | - | - |
| `AEM_PROXY_HOST` | Proxyvärd för icke-HTTP/HTTPS-anslutningar | `System.getenv().getOrDefault("AEM_PROXY_HOST", "proxy.tunnel")` | `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` |


Anslutningar till externa tjänster anropas sedan via `AEM_PROXY_HOST` och den mappade porten (`portForwards.portOrig`), som AEM sedan dirigerar till det mappade externa värdnamnet (`portForwards.name`) och porten (`portForwards.portDest`).

| Proxyvärd | Proxyport |  | Extern värd | Extern port |
|---------------------------------|----------|----------------|------------------|----------|
| `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |

#### Exempel på koder

<table><tr>
   <td>
      <a  href="./examples/sql-datasourcepool.md"><img alt="SQL-anslutning med JDBC DataSourcePool" src="./assets/code-examples__sql-osgi.png"/></a>
      <div><strong><a href="./examples/sql-datasourcepool.md">SQL-anslutning med JDBC DataSourcePool</a></strong></div>
      <p>
            Exempel på Java™-kod som ansluter till externa SQL-databaser genom att konfigurera AEM JDBC-datakällpool.
      </p>
    </td>   
   <td>
      <a  href="./examples/sql-java-apis.md"><img alt="SQL-anslutning med Java API:er" src="./assets/code-examples__sql-java-api.png"/></a>
      <div><strong><a href="./examples/sql-java-apis.md">SQL-anslutning med Java™ API:er</a></strong></div>
      <p>
            Exempel på Java™-kod som ansluter till externa SQL-databaser med Java™ SQL API:er.
      </p>
    </td>   
   <td>
      <a  href="./examples/email-service.md"><img alt="VPN (Virtual Private Network)" src="./assets/code-examples__email.png"/></a>
      <div><strong><a href="./examples/email-service.md">E-posttjänst</a></strong></div>
      <p>
        Exempel på OSGi-konfiguration som använder AEM för att ansluta till externa e-posttjänster.
      </p>
    </td>   
</tr></table>
