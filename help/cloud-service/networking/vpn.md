---
title: VPN (Virtual Private Network)
description: Lär dig hur du ansluter AEM as a Cloud Service till ditt VPN för att skapa säkra kommunikationskanaler mellan AEM och interna tjänster.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9352
thumbnail: KT-9352.jpeg
exl-id: 74cca740-bf5e-4cbd-9660-b0579301a3b4
duration: 948
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1192'
ht-degree: 0%

---

# VPN (Virtual Private Network)

Lär dig hur du ansluter AEM as a Cloud Service till ditt VPN för att skapa säkra kommunikationskanaler mellan AEM och interna tjänster.

## Vad är Virtual Private Network?

VPN (Virtual Private Network) gör det möjligt för en AEM as a Cloud Service kund att ansluta **AEM** inom ett Cloud Manager-program till en befintlig [stöds](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#vpn) VPN. Detta möjliggör säkra och kontrollerade anslutningar mellan AEM as a Cloud Service och tjänster i kundens nätverk.

Ett Cloud Manager-program kan bara ha en __enkel__ typ av nätverksinfrastruktur. Se till att det virtuella privata nätverket är det mest [lämplig typ av nätverksinfrastruktur](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#general-vpn-considerations) för AEM as a Cloud Service innan följande kommandon utförs.

>[!NOTE]
>
>Observera att det inte går att ansluta byggmiljön från Cloud Manager till ett VPN. Om du måste få åtkomst till binära artefakter från en privat databas måste du skapa en säker och lösenordsskyddad databas med en URL som är tillgänglig på det offentliga Internet [enligt beskrivning här](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/create-application-project/setting-up-project.html#password-protected-maven-repositories).

>[!MORELIKETHIS]
>
> Läs AEM as a Cloud Service [dokumentation om avancerad nätverkskonfiguration](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#vpn) om du vill ha mer information om Virtual Private Network.

## Förutsättningar

Följande krävs när du konfigurerar ett virtuellt privat nätverk:

+ Adobe-konto med [Behörigheter för affärsägare för Cloud Manager](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/permissions/)
+ Åtkomst till [Autentiseringsuppgifter för Cloud Manager API](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/authentication/)
   + Organisations-ID (även IMS Org-ID)
   + Klient-ID (även API-nyckel)
   + Åtkomsttoken (även Bearer Token)
+ Program-ID för Cloud Manager
+ Miljö-ID för Cloud Manager
+ A **Flödesbaserad** Virtuellt privat nätverk med tillgång till alla nödvändiga anslutningsparametrar.

Mer information finns i följande genomgång om hur du konfigurerar, konfigurerar och hämtar API-autentiseringsuppgifter för Cloud Manager och hur du använder dem för att göra ett API-anrop för Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/342235?quality=12&learn=on)

Den här självstudiekursen använder `curl` för att göra API-konfigurationer för Cloud Manager. Angiven `curl` -kommandon förutsätter en Linux/macOS-syntax. Om du använder kommandotolken i Windows ersätter du `\` radbrytningstecken med `^`.

## Aktivera virtuellt privat nätverk per program

Börja med att aktivera det virtuella privata nätverket på AEM as a Cloud Service.

1. Först identifierar du i vilken region det avancerade nätverket behövs med hjälp av API:t för Cloud Manager [listRegions](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. The `region name` krävs för att göra efterföljande API-anrop för Cloud Manager. Normalt används regionen där produktionsmiljön finns.

   Hitta den AEM as a Cloud Service miljöns region i [Cloud Manager](https://my.cloudmanager.adobe.com) under [miljöinformation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html?lang=en#viewing-environment). Regionnamnet som visas i Cloud Manager kan [mappas till regionkoden](https://developer.adobe.com/experience-cloud/cloud-manager/guides/api-usage/creating-programs-and-environments/#creating-aem-cloud-service-environments) används i Cloud Manager API.

   __listRegions HTTP request__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/regions \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

1. Aktivera Virtual Private Network för ett Cloud Manager-program med API:er för Cloud Manager [createNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. Använd lämplig `region` kod som hämtats från Cloud Manager API `listRegions` operation.

   __createNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X POST https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructures \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
       -d @./vpn-create.json
   ```

   Definiera JSON-parametrarna i en `vpn-create.json` och tillhandahålls för att surfa via `... -d @./vpn-create.json`.

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

   Vänta 45-60 minuter tills Cloud Manager-programmet har etablerat nätverksinfrastrukturen.

1. Kontrollera att miljön är klar __Virtuellt privat nätverk__ konfiguration med Cloud Manager API [getNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/#operation/getNetworkInfrastructure) åtgärd, använda `id` returnerades från createNetworkInfrastructure HTTP-begäran i föregående steg.

   __getNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructure/{networkInfrastructureId} \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: <YOUR_BEARER_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

   Verifiera att HTTP-svaret innehåller en __status__ av __klar__. Om du inte är klar ännu kan du kontrollera status var minut.

## Konfigurera virtuella privata nätverksproxies per miljö

1. Aktivera och konfigurera __Virtuellt privat nätverk__ konfiguration för varje AEM as a Cloud Service miljö med API:t för Cloud Manager [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation.

   __enableEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X PUT https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d @./vpn-configure.json
   ```

   Definiera JSON-parametrarna i en `vpn-configure.json` och tillhandahålls för att surfa via `... -d @./vpn-configure.json`.

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

   `nonProxyHosts` deklarerar en uppsättning värdar för vilka port 80 eller 443 ska dirigeras via de delade standardadressintervallen i stället för den dedikerade IP-adressen. `nonProxyHosts` kan vara användbart eftersom trafikutjämning via delade IP-adresser kan optimeras ytterligare automatiskt av Adobe.

   För varje `portForwards` mappning, definierar det avancerade nätverket följande vidarebefordringsregel:

   | Proxyvärd | Proxyport |  | Extern värd | Extern port |
   |---------------------------------|----------|----------------|------------------|----------|
   | `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |

   Om din AEM __endast__ kräver HTTP/HTTPS-anslutningar till extern tjänst, lämna `portForwards` matrisen är tom eftersom dessa regler endast krävs för icke-HTTP/HTTPS-begäranden.


1. Verifiera att VPN-routningsreglerna används i molnhanterarens API:er för varje miljö [getEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation.

   __getEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

1. Proxykonfigurationer för virtuella privata nätverk kan uppdateras med API:n för Cloud Manager [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. Kom ihåg `enableEnvironmentAdvancedNetworkingConfiguration` är en `PUT` -åtgärd, så alla regler måste anges för varje anrop av den här åtgärden.

1. Nu kan du använda den virtuella privata nätverkets utgångskonfiguration i din anpassade AEM kod och konfiguration.

## Ansluta till externa tjänster via det virtuella privata nätverket

När det virtuella privata nätverket är aktiverat kan AEM kod och konfiguration använda dem för att ringa till externa tjänster via VPN. Det finns två varianter av externa anrop som AEM behandlar på olika sätt:

1. HTTP/HTTPS-anrop till externa tjänster
   + Innehåller HTTP/HTTPS-anrop till tjänster som körs på andra portar än standardportarna 80 eller 443.
1. icke-HTTP/HTTPS-anrop till externa tjänster
   + Inkluderar alla icke-HTTP-anrop, till exempel anslutningar med e-postservrar, SQL-databaser eller tjänster som körs på andra icke-HTTP/HTTPS-protokoll.

HTTP/HTTPS-begäranden från AEM på standardportar (80/443) tillåts som standard, men VPN-anslutningen används inte om den inte är korrekt konfigurerad enligt beskrivningen nedan.

### HTTP/HTTPS

När du skapar HTTP-/HTTPS-anslutningar från AEM proxiceras HTTP-/HTTPS-anslutningar automatiskt ut ur AEM när VPN används. Ingen ytterligare kod eller konfiguration krävs för att stödja HTTP/HTTPS-anslutningar.

>[!TIP]
>
> Se AEM as a Cloud Service Virtual Private Network-dokumentation för [alla routningsregler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#vpn-traffic-routing).

#### Exempel på koder

<table>
<tr>
<td>
    <a  href="./examples/http-dedicated-egress-ip-vpn.md"><img alt="HTTP/HTTPS" src="./assets/code-examples__http.png"/></a>
    <div><strong><a href="./examples/http-dedicated-egress-ip-vpn.md">HTTP/HTTPS</a></strong></div>
    <p>
        Exempel på Java™-kod som gör HTTP/HTTPS-anslutning från AEM as a Cloud Service till en extern tjänst med HTTP/HTTPS-protokoll.
    </p>
</td>
<td></td>
<td></td>
</tr>
</table>

### Kodexempel för icke-HTTP/HTTPS-anslutningar

När anslutningar som inte är HTTP/HTTPS skapas (t.ex. SQL, SMTP och så vidare) från AEM måste anslutningen upprättas via ett särskilt värdnamn som AEM anger.

| Variabelnamn | Använd | Java™-kod | OSGi-konfiguration |
| - |  - | - | - |
| `AEM_PROXY_HOST` | Proxyvärd för icke-HTTP/HTTPS-anslutningar | `System.getenv("AEM_PROXY_HOST")` | `$[env:AEM_PROXY_HOST]` |


Anslutningar till externa tjänster anropas sedan via `AEM_PROXY_HOST` och den mappade porten (`portForwards.portOrig`), som AEM sedan dirigeras till det mappade externa värdnamnet (`portForwards.name`) och port (`portForwards.portDest`).

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

Konfigurationen för det virtuella privata nätverket begränsar åtkomsten till AEM as a Cloud Service miljöer till ett VPN.

#### Konfigurationsexempel

<table><tr>
   <td>
      <a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/ip-allow-lists/apply-allow-list.html"><img alt="Använda IP tillåtelselista" src="./assets/code_examples__vpn-allow-list.png"/></a>
      <div><strong><a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/ip-allow-lists/apply-allow-list.html">Använda ett IP-tillåtelselista</a></strong></div>
      <p>
            Konfigurera en IP-tillåtelselista så att endast VPN-trafik kan komma åt AEM.
      </p>
    </td>
   <td>
      <a  href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#restrict-vpn-to-ingress-connections"><img alt="Sökvägsbaserade begränsningar för VPN-åtkomst till AEM" src="./assets/code_examples__vpn-path-allow-list.png"/></a>
      <div><strong><a href="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#restrict-vpn-to-ingress-connections">Sökvägsbaserade begränsningar för VPN-åtkomst till AEM</a></strong></div>
      <p>
            Kräv VPN-åtkomst för specifika sökvägar vid AEM.
      </p>
    </td>
   <td></td>
</tr></table>
