---
title: Dedikerad IP-adress för utgångar
description: Lär dig hur du konfigurerar och använder en dedikerad IP-adress för utgående anslutningar från AEM som kan komma från en dedikerad IP-adress.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9351
thumbnail: KT-9351.jpeg
exl-id: 311cd70f-60d5-4c1d-9dc0-4dcd51cad9c7
duration: 926
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1142'
ht-degree: 0%

---

# Dedikerad IP-adress för utgångar

Lär dig hur du konfigurerar och använder en dedikerad IP-adress för utgående anslutningar från AEM som kan komma från en dedikerad IP-adress.

## Vad är en dedikerad IP-adress för egress?

Med en dedikerad IP-adress för utgående IP-adress kan begäranden från AEM as a Cloud Service använda en dedikerad IP-adress, vilket gör att externa tjänster kan filtrera inkommande begäranden från den här IP-adressen. Gilla [flexibla utgångsportar](./flexible-port-egress.md), dedikerad IP-adress för utgångar som gör att du kan börja använda portar som inte är standard.

Ett Cloud Manager-program kan bara ha en __enkel__ typ av nätverksinfrastruktur. Se till att den dedikerade IP-adressen för utgångar är den [lämplig typ av nätverksinfrastruktur](./advanced-networking.md)  för AEM as a Cloud Service innan följande kommandon utförs.

>[!MORELIKETHIS]
>
> Läs AEM as a Cloud Service [dokumentation om avancerad nätverkskonfiguration](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#dedicated-egress-IP-address) om du vill ha mer information om IP-adressen för den dedikerade egresen.

## Förutsättningar

Följande krävs när du konfigurerar en dedikerad IP-adress för utgångar:

+ Cloud Manager API med [Behörigheter för affärsägare för Cloud Manager](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/permissions/)
+ Åtkomst till [Autentiseringsuppgifter för Cloud Manager API](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/authentication/)
   + Organisations-ID (även IMS Org-ID)
   + Klient-ID (även API-nyckel)
   + Åtkomsttoken (även Bearer Token)
+ Program-ID för Cloud Manager
+ Miljö-ID för Cloud Manager

Mer information finns i följande genomgång om hur du konfigurerar, konfigurerar och hämtar API-autentiseringsuppgifter för Cloud Manager och hur du använder dem för att göra ett API-anrop för Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/342235?quality=12&learn=on)

Den här självstudiekursen använder `curl` för att göra API-konfigurationer för Cloud Manager. Angiven `curl` -kommandon förutsätter en Linux/macOS-syntax. Om du använder kommandotolken i Windows ersätter du `\` radbrytningstecken med `^`.

## Aktivera dedikerad IP-adress för egress i programmet

Börja med att aktivera och konfigurera den dedikerade IP-adressen för utgångar på AEM as a Cloud Service.

1. Börja med att fastställa i vilken region det avancerade nätverket behövs genom att använda API:t för Cloud Manager [listRegions](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. The `region name` krävs för att göra efterföljande API-anrop för Cloud Manager. Normalt används regionen där produktionsmiljön finns.

   Hitta den AEM as a Cloud Service miljöns region i [Cloud Manager](https://my.cloudmanager.adobe.com) under [miljöinformation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html?lang=en#viewing-environment). Regionnamnet som visas i Cloud Manager kan [mappas till regionkoden](https://developer.adobe.com/experience-cloud/cloud-manager/guides/api-usage/creating-programs-and-environments/#creating-aem-cloud-service-environments) används i Cloud Manager API.

   __listRegions HTTP request__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/regions \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' 
   ```

1. Aktivera dedikerad IP-adress för en molnhanterare med hjälp av API:t för molnhanteraren [createNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. Använd lämplig `region` kod som hämtats från Cloud Manager API `listRegions` operation.

   __createNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X POST https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructures \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d '{ "kind": "dedicatedEgressIp", "region": "va7" }'
   ```

   Vänta i 15 minuter tills Cloud Manager-programmet etablerar nätverksinfrastrukturen.

1. Kontrollera att programmet har slutförts __dedikerad IP-adress för egress__ konfiguration med Cloud Manager API [getNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/#operation/getNetworkInfrastructure) åtgärd, använda `id` returnerades från createNetworkInfrastructure HTTP-begäran i föregående steg.

   __getNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructure/{networkInfrastructureId} \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

   Verifiera att HTTP-svaret innehåller en __status__ av __klar__. Om du inte är klar ännu kontrollerar du statusen var några minut.

## Konfigurera IP-adressproxy för dedikerad egress per miljö

1. Konfigurera __dedikerad IP-adress för egress__ konfiguration för varje AEM as a Cloud Service miljö med API:t för Cloud Manager [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation.

   __enableEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X PUT https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d @./dedicated-egress-ip-address.json
   ```

   Definiera JSON-parametrarna i en `dedicated-egress-ip-address.json` och tillhandahålls för att surfa via `... -d @./dedicated-egress-ip-address.json`.

   [Hämta exemplet dedikerad-egress-ip-address.json](./assets/dedicated-egress-ip-address.json). Filen är bara ett exempel. Konfigurera filen efter behov baserat på de valfria/obligatoriska fälten som beskrivs i [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/).

   ```json
   {
       "nonProxyHosts": [
           "example.net",
           "*.example.org",
       ],
       "portForwards": [
           {
               "name": "mysql.example.com",
               "portDest": 3306,
               "portOrig": 30001
           },
           {
               "name": "smtp.sendgrid.net",
               "portDest": 465,
               "portOrig": 30002
           }
       ]
   }
   ```

   Den dedikerade IP-adresskonfigurationens HTTP-signatur skiljer sig bara från [flexibel utgångsport](./flexible-port-egress.md#enable-dedicated-egress-ip-address-per-environment) på så sätt att det även stöder det valfria `nonProxyHosts` konfiguration.

   `nonProxyHosts` deklarerar en uppsättning värdar för vilka port 80 eller 443 ska dirigeras via de delade standardadressintervallen i stället för den dedikerade IP-adressen. `nonProxyHosts` kan vara användbart eftersom trafikutjämning via delade IP-adresser kan optimeras ytterligare automatiskt av Adobe.

   För varje `portForwards` mappning, definierar det avancerade nätverket följande vidarebefordringsregel:

   | Proxyvärd | Proxyport |  | Extern värd | Extern port |
   |---------------------------------|----------|----------------|------------------|----------|
   | `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |

1. Verifiera egresreglerna för varje miljö med hjälp av API:t för Cloud Manager [getEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation.

   __getEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: <YOUR_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

1. IP-adresskonfigurationer för dedikerade utgångar kan uppdateras med API:t för Cloud Manager [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. Kom ihåg `enableEnvironmentAdvancedNetworkingConfiguration` är en `PUT` -åtgärd, så alla regler måste anges för varje anrop av den här åtgärden.

1. Hämta __dedikerad IP-adress för egress__ med en DNS-lösare (t.ex. [DNSChecker.org](https://dnschecker.org/)) på värden: `p{programId}.external.adobeaemcloud.com`eller genom att köra `dig` från kommandoraden.

   ```shell
   $ dig +short p{programId}.external.adobeaemcloud.com
   ```

   Värdnamnet får inte vara `pinged`, eftersom det är en egress och _not_ och ingress.

   Anteckna __dedikerad IP-adress för egress__ delas av alla AEM as a Cloud Service miljöer i programmet.

1. Nu kan du använda den dedikerade IP-adressen för utgångar i din anpassade AEM och konfiguration. När du använder en dedikerad IP-adress för utgångar är de externa AEM as a Cloud Service anslutningarna ofta konfigurerade att endast tillåta trafik från den här dedikerade IP-adressen.

## Ansluta till externa tjänster via dedikerad IP-adress

När den dedikerade IP-adressen för utgångar är aktiverad kan AEM kod och konfiguration använda den dedikerade IP-adressen för utgångar för att ringa till externa tjänster. Det finns två varianter av externa anrop som AEM behandlar på olika sätt:

1. HTTP/HTTPS-anrop till externa tjänster
   + Innehåller HTTP/HTTPS-anrop till tjänster som körs på andra portar än standardportarna 80 eller 443.
1. icke-HTTP/HTTPS-anrop till externa tjänster
   + Inkluderar alla icke-HTTP-anrop, till exempel anslutningar med e-postservrar, SQL-databaser eller tjänster som körs på andra icke-HTTP/HTTPS-protokoll.

HTTP/HTTPS-begäranden från AEM på standardportar (80/443) tillåts som standard, men de använder inte den dedikerade IP-adressen för utgångar om de inte är korrekt konfigurerade enligt beskrivningen nedan.

>[!TIP]
>
> Läs AEM as a Cloud Service dokumentation om IP-adresser för utgångar om du vill veta mer [alla routningsregler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#dedcated-egress-ip-traffic-routing=).


### HTTP/HTTPS

När du skapar HTTP/HTTPS-anslutningar från AEM, när du använder en dedikerad IP-adress för utgående IP-adresser, proxiceras HTTP/HTTPS-anslutningar automatiskt ut från AEM med den dedikerade IP-adressen för utgående IP-adressen. Ingen ytterligare kod eller konfiguration krävs för att stödja HTTP/HTTPS-anslutningar.

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

### Icke-HTTP/HTTPS-anslutningar till externa tjänster

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
