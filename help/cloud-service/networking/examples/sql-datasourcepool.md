---
title: SQL-anslutningar med JDBC DataSourcePool
description: Lär dig hur du ansluter till SQL-databaser från AEM as a Cloud Service med hjälp AEM JDBC DataSourcePool och utgångsportar.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
kt: 9355
thumbnail: KT-9355.jpeg
exl-id: c1a26dcb-b2ae-4015-b865-2ce32f4fa869
source-git-commit: 6ed26e5c9bf8f5e6473961f667f9638e39d1ab0e
workflow-type: tm+mt
source-wordcount: '325'
ht-degree: 0%

---

# SQL-anslutningar med JDBC DataSourcePool

Anslutningar till SQL-databaser (och andra icke-HTTP/HTTPS-tjänster) måste vara AEM, inklusive de som görs med AEM DataSourcePool OSGi-tjänsten för att hantera anslutningarna.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✔ | ✔ |

## OSGi-konfiguration

OSGi-konfigurationens anslutningssträng använder:

+ `AEM_PROXY_HOST` värdet via [OSGi-konfigurationsmiljövariabel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html?lang=en#environment-specific-configuration-values) `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` som anslutningens värd
+ `30001` som är `portOrig` värde för Cloud Manager-portvidarebefordringsmappning `30001` → `mysql.example.com:3306`

Eftersom hemligheter inte får lagras i kod bör SQL-anslutningens användarnamn och lösenord anges via OSGi-konfigurationsvariabler som anges med API:er för AIO CLI eller Cloud Manager.

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

Följande `aio CLI` kommandot kan användas för att ange OSGi-hemligheter per miljö:

```shell
$ aio cloudmanager:set-environment-variables --programId=<PROGRAM_ID> <ENVIRONMENT_ID> --secret MYSQL_USERNAME "mysql-user" --secret MYSQL_PASSWORD "password123"
```

## Exempel på kod

Detta Java™-kodexempel är en OSGi-tjänst som skapar en anslutning till en extern MySQL-databas via AEM DataSourcePool OSGi-tjänst.
Fabrikskonfigurationen för DataSourcePool OSGi anger i sin tur en port (`30001`) som mappas genom `portForwards` regel i [enableEnvironmentAdvancedNetworkingConfiguration](https://www.adobe.io/experience-cloud/cloud-manager/reference/api/#operation/enableEnvironmentAdvancedNetworkingConfiguration) till den externa värddatorn och porten, `mysql.example.com:3306`.

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

AEM as a Cloud Service kräver ofta att du tillhandahåller Java™-databasdrivrutiner som stöder anslutningarna. Att tillhandahålla drivrutinerna är oftast bäst om du bäddar in OSGi-paketartefakter som innehåller dessa drivrutiner i AEM-projektet via `all` paket.

### Reaktorprom.xml

Inkludera databasdrivrutinernas beroenden i reaktorn `pom.xml` och sedan referera till dem i `all` delprojekt.

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

Bädda in beroendeartefakter för databasdrivrutiner i `all` till de distribueras och är tillgängliga på AEM as a Cloud Service. Dessa artefakter __måste__ vara OSGi-paket som exporterar Java™-klassen för databasdrivrutinen.

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
