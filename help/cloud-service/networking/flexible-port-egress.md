---
title: Flexibel portutgång
description: Lär dig hur du konfigurerar och använder flexibel portutgångar för att stödja externa anslutningar från AEM as a Cloud Service till externa tjänster.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9350
thumbnail: KT-9350.jpeg
exl-id: 5c1ff98f-d1f6-42ac-a5d5-676a54ef683c
duration: 906
source-git-commit: 970093bb54046fee49e2ac209f1588e70582ab67
workflow-type: tm+mt
source-wordcount: '1060'
ht-degree: 0%

---

# Flexibel portutgång

Lär dig hur du konfigurerar och använder flexibel portutgångar för att stödja externa anslutningar från AEM as a Cloud Service till externa tjänster.

## Vad är flexibel hamnutgång?

Flexibla portutgångar gör det möjligt att koppla anpassade, specifika regler för portvidarebefordran till AEM as a Cloud Service, vilket gör det möjligt att ansluta från AEM till externa tjänster.

Ett Cloud Manager-program kan bara ha en __enkel__ typ av nätverksinfrastruktur. Se till att den dedikerade IP-adressen för utgångar är den [lämplig typ av nätverksinfrastruktur](./advanced-networking.md)  för AEM as a Cloud Service innan följande kommandon utförs.

>[!MORELIKETHIS]
>
> Läs AEM as a Cloud Service [dokumentation om avancerad nätverkskonfiguration](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#flexible-port-egress) om du vill ha mer information om flexibel hamnutgång.

## Förutsättningar

Följande krävs när du konfigurerar flexibel portutgång:

+ Adobe Developer Console-projekt med Cloud Manager API aktiverat och [Behörigheter för affärsägare för Cloud Manager](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/permissions/)
+ Åtkomst till [Autentiseringsuppgifter för Cloud Manager API](https://developer.adobe.com/experience-cloud/cloud-manager/guides/getting-started/create-api-integration/)
   + Organisations-ID (även IMS Org-ID)
   + Klient-ID (även API-nyckel)
   + Åtkomsttoken (även Bearer Token)
+ Program-ID för Cloud Manager
+ Miljö-ID för Cloud Manager

Mer information finns i följande genomgång om hur du konfigurerar, konfigurerar och hämtar API-autentiseringsuppgifter för Cloud Manager och hur du använder dem för att göra ett API-anrop för Cloud Manager.

>[!VIDEO](https://video.tv.adobe.com/v/342235?quality=12&learn=on)

Den här självstudiekursen använder `curl` för att göra API-konfigurationer för Cloud Manager. Angiven `curl` -kommandon förutsätter en Linux/macOS-syntax. Om du använder kommandotolken i Windows ersätter du `\` radbrytningstecken med `^`.

## Möjliggör flexibel portutgång per program

Börja med att aktivera den flexibla porten på AEM as a Cloud Service.

1. Kontrollera först att regionen Advanced Networking är konfigurerad i med hjälp av Cloud Manager API [listRegions](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. The `region name` krävs för att göra efterföljande API-anrop för Cloud Manager. Normalt används regionen där produktionsmiljön finns.

   Hitta den AEM as a Cloud Service miljöns region i [Cloud Manager](https://my.cloudmanager.adobe.com) under [miljöinformation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/manage-environments.html?lang=en#viewing-environment). Regionnamnet som visas i Cloud Manager kan [mappas till regionkoden](https://developer.adobe.com/experience-cloud/cloud-manager/guides/api-usage/creating-programs-and-environments/#creating-aem-cloud-service-environments) används i Cloud Manager API.

   __listRegions HTTP request__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/regions \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' 
   ```

1. Aktivera flexibel portutgång för ett Cloud Manager-program med hjälp av API:t för Cloud Manager [createNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. Använd lämplig `region` kod som hämtats från Cloud Manager API `listRegions` operation.

   __createNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X POST https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructures \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d '{ "kind": "flexiblePortEgress", "region": "va7" }'
   ```

   Vänta i 15 minuter tills Cloud Manager-programmet etablerar nätverksinfrastrukturen.

1. Kontrollera att miljön är klar __flexibel portutgång__ konfiguration med Cloud Manager API [getNetworkInfrastructure](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/#operation/getNetworkInfrastructure) åtgärd, använda `id` returnerades från createNetworkInfrastructure HTTP-begäran i föregående steg.

   __getNetworkInfrastructure HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/networkInfrastructure/{networkInfrastructureId} \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json'
   ```

   Verifiera att HTTP-svaret innehåller en __status__ av __klar__. Om du inte är klar ännu kan du kontrollera status var minut.

## Konfigurera flexibla portaregresproxy per miljö

1. Aktivera och konfigurera __flexibel portutgång__ konfiguration för varje AEM as a Cloud Service miljö med API:t för Cloud Manager [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation.

   __enableEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X PUT https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'Content-Type: application/json' \
       -d @./flexible-port-egress.json
   ```

   Definiera JSON-parametrarna i en `flexible-port-egress.json` och tillhandahålls för att surfa via `... -d @./flexible-port-egress.json`.

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

   För varje `portForwards` mappning, definierar det avancerade nätverket följande vidarebefordringsregel:

   | Proxyvärd | Proxyport |  | Extern värd | Extern port |
   |---------------------------------|----------|----------------|------------------|----------|
   | `AEM_PROXY_HOST` | `portForwards.portOrig` | → | `portForwards.name` | `portForwards.portDest` |

   Om din AEM __endast__ kräver HTTP/HTTPS-anslutningar (port 80/443) till extern tjänst, lämna `portForwards` matrisen är tom eftersom dessa regler endast krävs för icke-HTTP/HTTPS-begäranden.

1. Verifiera egresreglerna för varje miljö med hjälp av API:t för Cloud Manager [getEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation.

   __getEnvironmentAdvancedNetworkingConfiguration HTTP-begäran__

   ```shell
   $ curl -X GET https://cloudmanager.adobe.io/api/program/{programId}/environment/{environmentId}/advancedNetworking \
       -H 'x-gw-ims-org-id: <ORGANIZATION_ID>' \
       -H 'Authorization: Bearer <ACCESS_TOKEN>' \
       -H 'x-api-key: <CLIENT_ID>' \ 
       -H 'Content-Type: application/json'
   ```

1. Flexibla portutgångskonfigurationer kan uppdateras med API:t för Cloud Manager [enableEnvironmentAdvancedNetworkingConfiguration](https://developer.adobe.com/experience-cloud/cloud-manager/reference/api/) operation. Kom ihåg `enableEnvironmentAdvancedNetworkingConfiguration` är en `PUT` -åtgärd, så alla regler måste anges för varje anrop av den här åtgärden.

1. Nu kan du använda den flexibla konfigurationen av portutgångar i din anpassade AEM kod och konfiguration.


## Ansluta till externa tjänster via flexibel hamnutgång

När den flexibla portaregresproxyn är aktiverad kan AEM kod och konfiguration använda dem för att ringa till externa tjänster. Det finns två varianter av externa anrop som AEM behandlar på olika sätt:

1. HTTP/HTTPS-anrop till externa tjänster på icke-standardportar
   + Innehåller HTTP/HTTPS-anrop till tjänster som körs på andra portar än standardportarna 80 eller 443.
1. icke-HTTP/HTTPS-anrop till externa tjänster
   + Inkluderar alla icke-HTTP-anrop, till exempel anslutningar med e-postservrar, SQL-databaser eller tjänster som körs på andra icke-HTTP/HTTPS-protokoll.

HTTP/HTTPS-begäranden från AEM på standardportar (80/443) tillåts som standard och kräver ingen extra konfiguration eller överväganden.


### HTTP/HTTPS på portar som inte är standard

När du skapar HTTP/HTTPS-anslutningar till portar som inte är standard (not-80/443) från AEM, måste anslutningarna göras via en särskild värd och portar, som tillhandahålls via platshållare.

AEM innehåller två uppsättningar särskilda Java™-systemvariabler som mappar till AEM HTTP/HTTPS-proxy.

| Variabelnamn | Använd | Java™-kod | OSGi-konfiguration |
| - |  - | - | - |
| `AEM_PROXY_HOST` | Proxyvärd för både HTTP/HTTPS-anslutningar | `System.getenv().getOrDefault("AEM_PROXY_HOST", "proxy.tunnel")` | `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` |
| `AEM_HTTP_PROXY_PORT` | Proxyport för HTTPS-anslutningar (ange reserv som reserv till `3128`) | `System.getenv().getOrDefault("AEM_HTTP_PROXY_PORT", 3128)` | `$[env:AEM_HTTP_PROXY_PORT;default=3128]` |
| `AEM_HTTPS_PROXY_PORT` | Proxyport för HTTPS-anslutningar (ange reserv som reserv till `3128`) | `System.getenv().getOrDefault("AEM_HTTPS_PROXY_PORT", 3128)` | `$[env:AEM_HTTPS_PROXY_PORT;default=3128]` |

När HTTP/HTTPS-anrop görs till externa tjänster på portar som inte är standard utförs ingen motsvarande `portForwards` måste definieras med Cloud Manager API `enableEnvironmentAdvancedNetworkingConfiguration` -åtgärd, eftersom portvidarebefordringens &quot;regler&quot; är definierade i koden.

>[!TIP]
>
> I AEM as a Cloud Service dokumentation om flexibel portutgång finns mer information [alla routningsregler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/configuring-advanced-networking.html#flexible-port-egress-traffic-routing).

#### Exempel på koder

<table>
<tr>
<td>
    <a  href="./examples/http-on-non-standard-ports-flexible-port-egress.md"><img alt="HTTP/HTTPS på portar som inte är standard" src="./assets/code-examples__http.png"/></a>
    <div><strong><a href="./examples/http-on-non-standard-ports-flexible-port-egress.md">HTTP/HTTPS på portar som inte är standard</a></strong></div>
    <p>
        Exempel på Java™-kod som gör HTTP/HTTPS-anslutning från AEM as a Cloud Service till en extern tjänst på icke-standard HTTP/HTTPS-portar.
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
| `AEM_PROXY_HOST` | Proxyvärd för icke-HTTP/HTTPS-anslutningar | `System.getenv().getOrDefault("AEM_PROXY_HOST", "proxy.tunnel")` | `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` |


Anslutningar till externa tjänster anropas sedan via `AEM_PROXY_HOST` och den mappade porten (`portForwards.portOrig`), som AEM sedan dirigeras till det mappade externa värdnamnet (`portForwards.name`) och port (`portForwards.portDest`).

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
