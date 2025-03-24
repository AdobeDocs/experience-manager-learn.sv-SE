---
title: VPN (Virtual Private Network)
description: Lär dig hur du ansluter AEM as a Cloud Service till ditt VPN för att skapa säkra kommunikationskanaler mellan AEM och interna tjänster.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9352
thumbnail: KT-9352.jpeg
exl-id: 74cca740-bf5e-4cbd-9660-b0579301a3b4
last-substantial-update: 2024-04-27T00:00:00Z
duration: 919
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1467'
ht-degree: 0%

---

# VPN (Virtual Private Network)

Lär dig hur du ansluter AEM as a Cloud Service till ditt VPN för att skapa säkra kommunikationskanaler mellan AEM och interna tjänster.

## Vad är Virtual Private Network?

Med VPN (Virtual Private Network) kan en AEM as a Cloud Service-kund ansluta **AEM-miljöerna** i ett Cloud Manager-program till en befintlig, [stödd](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking) VPN. VPN ger säkra och kontrollerade anslutningar mellan AEM as a Cloud Service och tjänster i kundens nätverk.

Ett Cloud Manager-program kan bara ha en __enskild__ nätverksinfrastrukturtyp. Kontrollera att Virtuellt privat nätverk är den [lämpligaste typen av nätverksinfrastruktur](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking) för din AEM as a Cloud Service innan du kör följande kommandon.

>[!NOTE]
>
>Observera att det inte går att ansluta byggmiljön från Cloud Manager till ett VPN. Om du måste få åtkomst till binära artefakter från en privat databas måste du skapa en säker och lösenordsskyddad databas med en URL som är tillgänglig på den offentliga Internet [ enligt beskrivningen här](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/create-application-project/setting-up-project).

>[!MORELIKETHIS]
>
> Läs AEM as a Cloud Service [dokumentation om avancerad nätverkskonfiguration](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking) om du vill ha mer information om virtuellt privat nätverk.

## Förutsättningar

Följande krävs när du konfigurerar ett virtuellt privat nätverk med Cloud Manager API:er:

+ Adobe-konto med [Cloud Manager Business Owner-behörigheter](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/permissions/)
+ Åtkomst till [Cloud Manager API:ts autentiseringsuppgifter](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/create-api-integration/)
   + Organisations-ID (även IMS Org-ID)
   + Klient-ID (även API-nyckel)
   + Åtkomsttoken (även Bearer Token)
+ Cloud Manager program-ID
+ Cloud Manager miljö-ID:n
+ Ett **Routbaserat** virtuellt privat nätverk med åtkomst till alla nödvändiga anslutningsparametrar.

Mer information finns i [Konfigurera och hämta API-autentiseringsuppgifter för Cloud Manager](https://experienceleague.adobe.com/en/docs/experience-manager-learn/cloud-service/developing/extensibility/app-builder/server-to-server-auth) så att du kan använda dem för att göra ett Cloud Manager API-anrop.

I den här självstudien används `curl` för att skapa Cloud Manager API-konfigurationer. De `curl`-kommandon som tillhandahålls förutsätter en Linux/macOS-syntax. Om du använder kommandotolken i Windows ersätter du radbrytningstecknet `\` med `^`.

## Aktivera virtuellt privat nätverk per program

Börja med att aktivera det virtuella privata nätverket på AEM as a Cloud Service.


>[!BEGINTABS]

>[!TAB Cloud Manager]

Flexibel portutgång kan aktiveras med Cloud Manager. I följande steg beskrivs hur du aktiverar flexibel portutgång på AEM as a Cloud Service med Cloud Manager.

1. Logga in på [Adobe Experience Manager Cloud Manager](https://experience.adobe.com/cloud-manager/) som Cloud Manager Business Owner.
1. Navigera till önskat program.
1. Navigera till __Tjänster > Nätverksinfrastrukturer__ på den vänstra menyn.
1. Välj knappen __Lägg till nätverksinfrastruktur__.

   ![Lägg till nätverksinfrastruktur](./assets/cloud-manager__add-network-infrastructure.png)

1. Välj alternativet __Virtuellt privat nätverk__ i dialogrutan __Lägg till nätverksinfrastruktur__. Fyll i fälten och välj __Fortsätt__. Samarbeta med organisationens nätverksadministratör för att få rätt värden.

   ![Lägg till VPN](./assets/vpn/select-type.png)

1. Skapa minst en VPN-anslutning. Ge anslutningen ett beskrivande namn och välj knappen __Lägg till anslutning__.

   ![Lägg till VPN-anslutning](./assets/vpn/add-connection.png)

1. Konfigurera VPN-anslutningen. Samarbeta med organisationens nätverksadministratör för att få rätt värden. Välj __Spara__ för att bekräfta att anslutningen har lagts till.

   ![Konfigurera VPN-anslutning](./assets/vpn/configure-connection.png)

1. Om det krävs flera VPN-anslutningar måste du ange fler anslutningar efter behov. När alla VPN-anslutningar har lagts till väljer du __Fortsätt__.

   ![Konfigurera VPN-anslutning](./assets/vpn/connections.png)

1. Välj __Spara__ för att bekräfta att VPN och alla konfigurerade anslutningar lagts till.

   ![Bekräfta skapande av VPN](./assets/vpn/confirmation.png)

1. Vänta tills nätverksinfrastrukturen har skapats och markerats som __Ready__. Den här processen kan ta upp till 1 timme.

   ![VPN-skapandestatus](./assets/vpn/creating.png)

När VPN har skapats kan du nu konfigurera det med Cloud Manager API:er enligt beskrivningen nedan.

>[!TAB Cloud Manager API:er]

Virtuellt privat nätverk kan aktiveras med Cloud Manager API:er. I följande steg beskrivs hur du aktiverar VPN på AEM as a Cloud Service med Cloud Manager API.

1. Ta först reda på i vilken region det avancerade nätverket behövs genom att använda Cloud Manager API-åtgärden [listRegions](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/). `region name` krävs för efterföljande Cloud Manager API-anrop. Normalt används regionen där produktionsmiljön finns.

   Hitta AEM as a Cloud Service-miljöns region i [Cloud Manager](https://my.cloudmanager.adobe.com) under [miljöns information](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments). Regionnamnet som visas i Cloud Manager kan [mappas till regionkoden](https://developer.adobe.com/experience-cloud/cloud-manager/guides/api-usage/creating-programs-and-environments/#creating-aem-cloud-service-environments) som används i Cloud Manager API.

   __listRegions HTTP request__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/regions \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

1. Aktivera åtgärden [createNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) för ett Cloud Manager-program med Cloud Manager API:er. Använd rätt `region`-kod som hämtats från Cloud Manager API `listRegions` -åtgärden.

   __createNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X POST https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructures \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
       -d @./vpn-create.json
   ```

   Definiera JSON-parametrarna i en `vpn-create.json` och tillhandahåll för att rulla via `... -d @./vpn-create.json`.

   [Hämta exemplet vpn-create.json](./assets/vpn-create.json).  Filen är bara ett exempel. Konfigurera filen efter behov baserat på de valfria/obligatoriska fälten som beskrivs i [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/).

   ```json
   {
       "kind": "vpn",
       "region": "va7",
       "addressSpace": [
           "10.104.182.64/26"
       ],
       "dns": {
           "resolvers": [
               "10.151.201.22",
               "10.151.202.22",
               "10.154.155.22"
           ],
           "domains": [
               "wknd.site",
               "wknd.com"
           ]
       },
       "connections": [{
           "name": "connection-1",
           "gateway": {
               "address": "195.231.212.78",
               "addressSpace": [
                   "10.151.0.0/16",
                   "10.152.0.0/16",
                   "10.153.0.0/16",
                   "10.154.0.0/16",
                   "10.142.0.0/16",
                   "10.143.0.0/16",
                   "10.124.128.0/17"
               ]
           },
           "sharedKey": "<secret_shared_key>",
           "ipsecPolicy": {
               "dhGroup": "ECP256",
               "ikeEncryption": "AES256",
               "ikeIntegrity": "SHA256",
               "ipsecEncryption": "AES256",
               "ipsecIntegrity": "SHA256",
               "pfsGroup": "ECP256",
               "saDatasize": 102400000,
               "saLifetime": 3600
           }
       }]
   }
   ```

   Vänta i 45-60 minuter på att Cloud Manager-programmet ska tillhandahålla nätverksinfrastrukturen.

1. Kontrollera att miljön har slutfört konfigurationen __Virtuellt privat nätverk__ med Cloud Manager API [getNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/#operation/getNetworkInfrastructure) med hjälp av `id` som returnerades från HTTP-begäran `createNetworkInfrastructure` i föregående steg.

   __getNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructure/{networkInfrastructureId} \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: <YOUR_BEARER_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

   Kontrollera att HTTP-svaret innehåller __status__ av __ready__. Om du inte är klar ännu kontrollerar du statusen var några minut.


När VPN har skapats kan du nu konfigurera det med Cloud Manager API:er enligt beskrivningen nedan.

>[!ENDTABS]

## Konfigurera virtuella privata nätverksproxies per miljö

1. Aktivera och konfigurera konfigurationen __Virtuellt privat nätverk__ i varje AEM as a Cloud Service-miljö med Cloud Manager API-åtgärden [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) .

   __enableEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X PUT https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d @./vpn-configure.json
   ```

   Definiera JSON-parametrarna i en `vpn-configure.json` och tillhandahåll för att rulla via `... -d @./vpn-configure.json`.

[Hämta exemplet vpn-configure.json](./assets/vpn-configure.json)

   ```json
   {
       "nonProxyHosts": [
           "example.net",
           "*.example.org"
       ],
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

   `nonProxyHosts` deklarerar en uppsättning värdar för vilka port 80 eller 443 ska dirigeras via de delade standardadressintervallen i stället för den dedikerade IP-adressen. `nonProxyHosts` kan vara användbart eftersom trafik som läses in via delade IP-adresser optimeras automatiskt av Adobe.

   För varje `portForwards`-mappning definierar det avancerade nätverket följande vidarebefordringsregel:

   | Proxyvärd | Proxyport |  | Extern värd | Extern port |
   |---------------------------------|----------|----------------|------------------|----------|
   | `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |

   Om AEM-distributionen __endast__ kräver HTTP/HTTPS-anslutningar till den externa tjänsten lämnar du `portForwards`-arrayen tom, eftersom dessa regler bara krävs för icke-HTTP/HTTPS-begäranden.


2. Verifiera VPN-routningsreglerna för varje miljö med Cloud Manager API:ns [getEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) -åtgärd.

   __getEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

3. Proxykonfigurationer för virtuella privata nätverk kan uppdateras med Cloud Manager API:ts [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) -åtgärd. Kom ihåg att `enableEnvironmentAdvancedNetworkingConfiguration` är en `PUT`-åtgärd, så alla regler måste anges med varje anrop av den här åtgärden.

4. Nu kan du använda den virtuella privata nätverkets utgångskonfiguration i din anpassade AEM-kod och konfiguration.

## Ansluta till externa tjänster via det virtuella privata nätverket

När det virtuella privata nätverket är aktiverat kan AEM-kod och konfiguration använda dem för att ringa till externa tjänster via VPN. Det finns två varianter av externa anrop som AEM hanterar på olika sätt:

1. HTTP/HTTPS-anrop till externa tjänster
   + Innehåller HTTP/HTTPS-anrop till tjänster som körs på andra portar än standardportarna 80 eller 443.
1. icke-HTTP/HTTPS-anrop till externa tjänster
   + Inkluderar alla icke-HTTP-anrop, till exempel anslutningar med e-postservrar, SQL-databaser eller tjänster som körs på andra icke-HTTP/HTTPS-protokoll.

HTTP/HTTPS-begäranden från AEM på standardportar (80/443) tillåts som standard, men VPN-anslutningen används inte om den inte är korrekt konfigurerad enligt beskrivningen nedan.

### HTTP/HTTPS

När du skapar HTTP/HTTPS-anslutningar från AEM proxideras HTTP/HTTPS-anslutningar automatiskt från AEM när VPN används. Ingen ytterligare kod eller konfiguration krävs för att stödja HTTP/HTTPS-anslutningar.

>[!TIP]
>
> I AEM as a Cloud Service dokumentation för virtuellt privat nätverk finns [en fullständig uppsättning routningsregler](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking).

#### Exempel på koder

<table>
<tr>
<td>
    <a  href="./examples/http-dedicated-egress-ip-vpn.md"><img alt="HTTP/HTTPS" src="./assets/code-examples__http.png"/></a>
    <div><strong><a href="./examples/http-dedicated-egress-ip-vpn.md">HTTP/HTTPS</a></strong></div>
    <p>
        Exempel på Java™-kod som skapar HTTP/HTTPS-anslutning från AEM as a Cloud Service till en extern tjänst med protokollet HTTP/HTTPS.
    </p>
</td>
<td></td>
<td></td>
</tr>
</table>

### Kodexempel för icke-HTTP/HTTPS-anslutningar

När anslutningar som inte är HTTP/HTTPS skapas (t.ex. SQL, SMTP och så vidare) från AEM måste anslutningen upprättas via ett särskilt värdnamn som tillhandahålls av AEM.

| Variabelnamn | Använd | Java™-kod | OSGi-konfiguration |
| - |  - | - | - |
| `AEM_PROXY_HOST` | Proxyvärd för icke-HTTP/HTTPS-anslutningar | `System.getenv("AEM_PROXY_HOST")` | `$[env:AEM_PROXY_HOST]` |


Anslutningar till externa tjänster anropas sedan via `AEM_PROXY_HOST` och den mappade porten (`portForwards.portOrig`), som AEM sedan dirigerar till det mappade externa värdnamnet (`portForwards.name`) och porten (`portForwards.portDest`).

| Proxyvärd | Proxyport |  | Extern värd | Extern port |
|---------------------------------|----------|----------------|------------------|----------|
| `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |


#### Exempel på koder

<table><tr>
   <td>
      <a  href="./examples/sql-datasourcepool.md"><img alt="SQL-anslutning med JDBC DataSourcePool" src="./assets//code-examples__sql-osgi.png"/></a>
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

### Begränsa åtkomst till AEM as a Cloud Service via VPN

Konfigurationen Virtuellt privat nätverk begränsar åtkomsten till AEM as a Cloud Service-miljöer till ett VPN.

#### Konfigurationsexempel

<table><tr>
   <td>
      <a href="https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/ip-allow-lists/apply-allow-list"><img alt="Använda IP tillåtelselista" src="./assets/code_examples__vpn-allow-list.png"/></a>
      <div><strong><a href="https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/ip-allow-lists/apply-allow-list">Använder en IP-tillåtelselista</a></strong></div>
      <p>
            Konfigurera en IP-tillåtelselista så att endast VPN-trafik kan komma åt AEM.
      </p>
    </td>
   <td>
      <a  href="https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking"><img alt="Sökvägsbaserade begränsningar för VPN-åtkomst till AEM Publish" src="./assets/code_examples__vpn-path-allow-list.png"/></a>
      <div><strong><a href="https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking">Sökvägsbaserade begränsningar för VPN-åtkomst till AEM Publish</a></strong></div>
      <p>
            Kräv VPN-åtkomst för specifika sökvägar i AEM Publish.
      </p>
    </td>
   <td></td>
</tr></table>
