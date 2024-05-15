---
title: Inklusive tredjepartsburkar
description: Lär dig använda en tredjepartsfil i ditt AEM
version: 6.4,6.5
feature: Adaptive Forms
topic: Development
role: Developer
level: Beginner
jira: KT-11245
last-substantial-update: 2022-10-15T00:00:00Z
thumbnail: third-party.jpg
exl-id: e8841c63-3159-4f13-89a1-d8592af514e3
duration: 53
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '269'
ht-degree: 0%

---

# Inkludera tredjepartspaket i ditt AEM

I den här artikeln går vi igenom de steg som ingår i att ta med OSGi-paket från tredje part i ditt AEM-projekt.I den här artikeln ska vi ta med [jsch-0.1.55.jar](https://repo1.maven.org/maven2/com/jcraft/jsch/0.1.55/jsch-0.1.55.jar) i vårt AEM.  Om OSGi är tillgängligt i maven-databasen inkluderas paketets beroende i projektets POM.xml-fil.

>[!NOTE]
> Det antas att tredjepartsbehållaren är ett OSGi-paket

```java
<!-- https://mvnrepository.com/artifact/com.jcraft/jsch -->
<dependency>
    <groupId>com.jcraft</groupId>
    <artifactId>jsch</artifactId>
    <version>0.1.55</version>
</dependency>
```

Om ditt OSGi-paket finns i filsystemet skapar du en mapp med namnet **localjar** under projektets baskatalog (C:\aemformsbundles\AEMFormsProcessStep\localjar) ser beroendet ut ungefär så här

```java
<dependency>
    <groupId>jsch</groupId>
    <artifactId>jsch</artifactId>
    <version>1.0</version>
    <scope>system</scope>
    <systemPath>${project.basedir}/localjar/jsch-0.1.55-bundle.jar</systemPath>
</dependency>
```

## Skapa mappstrukturen

Vi lägger till det här paketet i vårt AEM projekt **AEMFormsProcessStep** som bor i **c:\aemformsbundles** mapp

* Öppna **filter.xml** från mappen C:\aemformsbundles\AEMFormsProcessStep\all\src\main\content\META-INF\vault i ditt projekt Anteckna rotattributet för filterelementet.

* Skapa följande mappstruktur C:\aemformsbundles\AEMFormsProcessStep\all\src\main\content\jcr_root\apps\AEMFormsProcessStep-vendor-packages\application\install
* The **apps/AEMFormsProcessStep-vendor-packages** är rotattributvärdet i filter.xml
* Uppdatera beroendeavsnittet i projektets POM.xml
* Öppna kommandotolken. Navigera till projektmappen (c:\aemformsbundles\AEMFormsProcessStep) i mitt fall. Kör följande kommando

```java
mvn clean install -PautoInstallSinglePackage
```

Om allt blir bra installeras paketet tillsammans med tredjepartspaketet i din AEM. Du kan söka efter paketet med [felix-webbkonsol](http://localhost:4502/system/console/bundles). Tredjepartspaketet är tillgängligt i mappen /apps i `crx` databas som visas nedan
![tredje part](assets/custom-bundle1.png)
