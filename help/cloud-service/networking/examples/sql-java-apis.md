---
title: SQL-anslutningar med Java™ API:er
description: Lär dig hur du ansluter till SQL-databaser från AEM as a Cloud Service med Java™ SQL API:er och utgångsportar.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Developer
level: Intermediate
jira: KT-9356
thumbnail: KT-9356.jpeg
exl-id: ec9d37cb-70b6-4414-a92b-3b84b3f458ab
duration: 124
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '291'
ht-degree: 0%

---

# SQL-anslutningar med Java™ API:er

Anslutningar till SQL-databaser (och andra icke-HTTP/HTTPS-tjänster) måste vara proxierade från AEM.

Undantaget till den här regeln är när [den dedikerade IP-adressen](../dedicated-egress-ip-address.md) används och tjänsten är på Adobe eller Azure.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Kontrollera att den [lämpliga](../advanced-networking.md#advanced-networking) avancerade nätverkskonfigurationen har konfigurerats innan du följer den här självstudien.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✔ | ✔ |

## OSGi-konfiguration

Eftersom hemligheter inte får lagras i kod bör SQL-anslutningens användarnamn och lösenord anges med [hemliga OSGi-konfigurationsvariabler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#secret-configuration-values), som anges med AIO CLI eller Cloud Manager API:er.

+ `ui.config/src/jcr_root/apps/wknd-examples/osgiconfig/com.adobe.aem.wknd.examples.core.connections.impl.MySqlExternalServiceImpl.cfg.json`

```json
{
  "username": "$[env:MYSQL_USERNAME;default=mysql-user]",
  "password": "$[secret:MYSQL_PASSWORD]"
}
```

Följande `aio CLI`-kommando kan användas för att ange OSGi-hemligheter per miljö:

```shell
$ aio cloudmanager:set-environment-variables --programId=<PROGRAM_ID> <ENVIRONMENT_ID> --secret MYSQL_USERNAME "mysql-user" --secret MYSQL_PASSWORD "password123"
```

## Exempel på kod

Detta Java™-kodexempel är en OSGi-tjänst som skapar en anslutning till en extern SQL-server via följande Cloud Manager `portForwards`-regel i åtgärden [ enableEnvironmentAdvancedNetworkingConfiguration ](https://www.adobe.io/experience-cloud/cloud-manager/reference/api/#operation/enableEnvironmentAdvancedNetworkingConfiguration) .

```json
...
"portForwards": [{
    "name": "mysql.example.com",
    "portDest": 3306,
    "portOrig": 30001
}]
...
```

+ `core/src/com/adobe/aem/wknd/examples/connections/impl/MySqlExternalServiceImpl.java`

```java
package com.adobe.aem.wknd.examples.core.connections.impl;

import com.adobe.aem.wknd.examples.core.connections.ExternalService;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.metatype.annotations.AttributeDefinition;
import org.osgi.service.metatype.annotations.AttributeType;
import org.osgi.service.metatype.annotations.Designate;
import org.osgi.service.metatype.annotations.ObjectClassDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;

@Component
@Designate(ocd = MySqlExternalServiceImpl.Config.class)
public class MySqlExternalServiceImpl implements ExternalService {
    private static final Logger log = LoggerFactory.getLogger(MySqlExternalServiceImpl.class);

    // Get the proxy host using the AEM_PROXY_HOST Java environment variable provided by AEM as a Cloud Service
    private static final String PROXY_HOST = System.getenv().getOrDefault("AEM_PROXY_HOST", "proxy.tunnel");

    // Use the port mapped to the external MySQL service in the Cloud Manager API call
    private static final int PORT_FORWARDS_PORT_ORIG = 30001;

    private Config config;

    @Override
    public boolean isAccessible() {
        log.debug("MySQL connection URL: [ {} ]", getConnectionUrl(config));

        // Establish a connection with the external MySQL service
        // This MySQL connection URL is created in getConnection(..) which will use the AEM_PROXY_HOST is it exists, and the proxied port.
        try (Connection connection = DriverManager.getConnection(getConnectionUrl(config), config.username(), config.password())) {
            // Validate the connection
            connection.isValid(1000);

            // Close the connection, since this is just a simple connectivity check
            connection.close();

            // Return true if AEM could reach the external SQL service
            return true;
        } catch (SQLException e) {
            log.error("Unable to establish an connection with MySQL service using connection URL  [ {} ]", getConnectionUrl(config), e);
        }

        return false;
    }

    /**
     * Create a connection string to the MySQL using the AEM-provided AEM_PROXY_HOST and portForwards.portOrg port
     * defined in the Cloud Manager API mapping.
     *
     * @param config OSGi configuration object
     * @return the MySQL connection URI
     */
    private String getConnectionUrl(Config config) {
        return String.format("jdbc:mysql://%s:%d/wknd-examples", PROXY_HOST, PORT_FORWARDS_PORT_ORIG);
    }

    @Activate
    protected void activate(Config config) throws ClassNotFoundException, SQLException {
        this.config = config;

        // Load the required MySQL Driver class required for Java to make the connection
        // The OSGi bundle that contains this driver is deployed via the project's all project
        DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    }

    @ObjectClassDefinition
    @interface Config {
        @AttributeDefinition(type = AttributeType.STRING)
        String username();

        @AttributeDefinition(type = AttributeType.STRING)
        String password();
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
