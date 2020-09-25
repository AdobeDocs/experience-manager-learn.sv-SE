---
title: Fjärrfelsökning av AEM SDK
description: Med AEM SDK:s lokala snabbstart kan du fjärrfelsöka Java från din utvecklingsmiljö, vilket gör att du kan stega igenom direktkörning av kod i AEM för att förstå det exakta körningsflödet.
feature: null
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5251
translation-type: tm+mt
source-git-commit: a3d3612713decefb5c7e1cf5b2d4d21afff0a2f5
workflow-type: tm+mt
source-wordcount: '275'
ht-degree: 0%

---


# Fjärrfelsökning av AEM SDK

>[!VIDEO](https://video.tv.adobe.com/v/34338/?quality=12&learn=on)

Med AEM SDK:s lokala snabbstart kan du fjärrfelsöka Java från din utvecklingsmiljö, vilket gör att du kan stega igenom direktkörning av kod i AEM för att förstå det exakta körningsflödet.

Om du vill ansluta en fjärrfelsökare till AEM måste AEM SDK:s lokala snabbstart startas med specifika parametrar (`-agentlib:...`) som gör att IDE kan ansluta till den.

```
$ java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar aem-author-p4502.jar   
```

+ `address` anger vilken port AEM avlyssnar fjärrfelsökningsanslutningar och kan ändras till vilken port som helst som är tillgänglig på den lokala utvecklingsdatorn.
+ Den sista parametern (t.ex. `aem-author-p4502.jar`) är AEM SKD Quickstart Jar. Detta kan vara antingen AEM Author Service (`aem-author-p4502.jar`) eller AEM Publish Service (`aem-publish-p4503.jar`).

## Instruktioner för IDE-konfiguration

De flesta Java IDE:er har stöd för fjärrfelsökning av Java-program, men de exakta konfigurationsstegen för varje IDE varierar. Se instruktionerna för hur du konfigurerar fjärrfelsökning för din IDE. Vanligtvis kräver IDE-konfigurationer:

+ Värden AEM SDK:s lokala snabbstart lyssnar på, vilket är `localhost`.
+ Porten AEM SDK:s lokala snabbstart lyssnar efter fjärrfelsökningsanslutning, som är den port som anges av `address` parametern när AEM SDK:s lokala snabbstart startas.
+ Ibland måste det anges vilka Maven-projekt som tillhandahåller källkoden till fjärrfelsökningen. det här är ditt OSGi-paket med maven-projekt.

### Konfigurera instruktioner

+ [VS Code Java Remote Debugger - konfiguration](https://code.visualstudio.com/docs/java/java-debugging)
+ [Konfigurera IntelliJ IDEA Remote Debugger](https://www.jetbrains.com/help/idea/run-debug-configuration-remote-debug.html)
+ [Konfigurera Eclipse Remote Debugger](https://javapapers.com/core-java/java-remote-debug-with-eclipse/)
