---
title: SQL-anslutningar med JDBC DataSourcePool
description: Lär dig hur du ansluter till SQL-databaser från AEM as a Cloud Service med AEM JDBC DataSourcePool och utgångsportar.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Developer
level: Intermediate
jira: KT-9355
thumbnail: KT-9355.jpeg
exl-id: c1a26dcb-b2ae-4015-b865-2ce32f4fa869
duration: 117
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '325'
ht-degree: 0%

---

# SQL-anslutningar med JDBC DataSourcePool

Anslutningar till SQL-databaser (och andra icke-HTTP/HTTPS-tjänster) måste proxiceras ut från AEM, inklusive de som gjorts med AEM DataSourcePool OSGi-tjänst för att hantera anslutningarna.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Kontrollera att den [lämpliga](../advanced-networking.md#advanced-networking) avancerade nätverkskonfigurationen har konfigurerats innan du följer den här självstudien.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✔ | ✔ |

## OSGi-konfiguration

OSGi-konfigurationens anslutningssträng använder:

+ `AEM_PROXY_HOST`-värde via konfigurationsmiljövariabeln [&#x200B; OSGi &#x200B;](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html?lang=en#environment-specific-configuration-values) `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` som anslutningsvärd
+ `30001` som är `portOrig`-värdet för framåtmappning för Cloud Manager-port `30001` → `mysql.example.com:3306`

Eftersom hemligheter inte får lagras i kod bör SQL-anslutningens användarnamn och lösenord anges via OSGi-konfigurationsvariabler som anges med AIO CLI eller Cloud Manager API:er.

+ `ui.config/src/jcr_root/apps/wknd-examples/osgiconfig/config/com.day.commons.datasource.jdbcpool.JdbcPoolService~wknd-examples-mysql.cfg.json`

```json
{
  "datasource.name": "wknd-examples-mysql",
  "jdbc.driver.class": "com.mysql.jdbc.Driver",
  "jdbc.connection.uri": "jdbc:mysql://$[env:AEM_PROXY_HOST;default=proxy.tunnel]:30001/wknd-examples",
  "jdbc.username": "$[env:MYSQL_USERNAME;default=mysql-user]",
  "jdbc.password": "$[secret:MYSQL_PASSWORD]"
}
```

Följande `aio CLI`-kommando kan användas för att ange OSGi-hemligheter per miljö:

```shell
$ aio cloudmanager:set-environment-variables --programId=<PROGRAM_ID> <ENVIRONMENT_ID> --secret MYSQL_USERNAME "mysql-user" --secret MYSQL_PASSWORD "password123"
```

## Exempel på kod

Detta Java™-kodexempel är en OSGi-tjänst som skapar en anslutning till en extern MySQL-databas via AEM DataSourcePool OSGi-tjänst.
Fabrikskonfigurationen för DataSourcePool OSGi anger i sin tur en port (`30001`) som mappas via regeln `portForwards` i åtgärden [&#x200B; enableEnvironmentAdvancedNetworkingConfiguration &#x200B;](https://www.adobe.io/experience-cloud/cloud-manager/reference/api/#operation/enableEnvironmentAdvancedNetworkingConfiguration) till den externa värden och porten `mysql.example.com:3306`.

```json
...
"portForwards": [{
    "name": "mysql.example.com",
    "portDest": 3306,
    "portOrig": 30001
}]
...
```

+ `core/src/com/adobe/aem/wknd/examples/connections/impl/JdbcExternalServiceImpl.java`

```java
package com.adobe.aem.wknd.examples.core.connections.impl;

import com.adobe.aem.wknd.examples.core.connections.ExternalService;
import com.day.commons.datasource.poolservice.DataSourceNotFoundException;
import com.day.commons.datasource.poolservice.DataSourcePool;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

@Component
public class JdbcExternalServiceImpl implements ExternalService {
    private static final Logger log = LoggerFactory.getLogger(JdbcExternalServiceImpl.class);

    @Reference
    private DataSourcePool dataSourcePool;

    // The datasource.name value of the OSGi configuration containing the connection this OSGi component will use.
    private static final String DATA_SOURCE_NAME = "wknd-examples-mysql";

    @Override
    public boolean isAccessible() {

        try {
            // Get the JDBC data source based on the named OSGi configuration
            DataSource dataSource = (DataSource) dataSourcePool.getDataSource(DATA_SOURCE_NAME);

            // Establish a connection with the external JDBC service
            // Per the OSGi configuration, this will use the injected $[env:AEM_PROXY_HOST] value as the host
            // and the port (30001) mapped via Cloud Manager API call
            try (Connection connection = dataSource.getConnection()) {

                // Validate the connection
                connection.isValid(1000);

                // Close the connection, since this is just a simple connectivity check
                connection.close();

                // Return true if AEM could reach the external JDBC service
                return true;
            } catch (SQLException e) {
                log.error("Unable to validate SQL connection for [ {} ]", DATA_SOURCE_NAME, e);
            }
        } catch (DataSourceNotFoundException e) {
            log.error("Unable to establish an connection with the JDBC data source [ {} ]", DATA_SOURCE_NAME, e);
        }

        return false;
    }
}
```

## MySQL-drivrutinsberoenden

AEM as a Cloud Service kräver ofta att du tillhandahåller Java™-databasdrivrutiner som stöder anslutningarna. Det bästa sättet att tillhandahålla drivrutinerna är oftast att bädda in OSGi-paketartefakter som innehåller dessa drivrutiner i AEM-projektet via paketet `all`.

### Reaktorprom.xml

Inkludera databasdrivrutinernas beroenden i reaktorn `pom.xml` och referera sedan till dem i `all` -delprojekten.

+ `pom.xml`

```xml
...
<dependencies>
    ...
    <!-- MySQL Driver dependencies -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>[8.0.27,)</version>
        <scope>provided</scope>
    </dependency>
    ...
</dependencies>
...
```

## Alla pom.xml

Bädda in beroendeartefakter för databasdrivrutiner i paketet `all` till de distribueras och är tillgängliga på AEM as a Cloud Service. De här artefakterna __måste__ vara OSGi-paket som exporterar Java™-klassen för databasdrivrutinen.

+ `all/pom.xml`

```xml
...
<embededs>
    ...
    <!-- Include the MySQL Driver OSGi bundles for deployment to the project -->
    <embedded>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <target>/apps/wknd-examples-vendor-packages/application/install</target>
    </embedded>
    ...
</embededs>

...

<dependencies>
    ...
    <!-- Add MySQL OSGi bundle artifacts so the <embeddeds> can add them to the project -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <scope>provided</scope>
    </dependency>
    ...
</dependencies>
...
```
