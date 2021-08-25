---
title: Fjärrfelsökning av AEM SDK
description: Med AEM SDK:s lokala snabbstart kan du fjärrfelsöka Java från din utvecklingsmiljö, vilket gör att du kan stega igenom direktkörning av kod i AEM för att förstå det exakta körningsflödet.
kt: 5251
topic: Development
feature: Developer Tools
role: Developer
level: Beginner, Intermediate
thumbnail: 34338.jpeg
source-git-commit: ea7d49985e69ecf9713e17e51587125b3fb400ee
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
+ Den sista parametern (t.ex. `aem-author-p4502.jar`) är AEM SKD Quickstart Jar. Det kan vara antingen AEM Author-tjänsten (`aem-author-p4502.jar`) eller AEM Publish-tjänsten (`aem-publish-p4503.jar`).

## Instruktioner för IDE-konfiguration

De flesta Java IDE:er har stöd för fjärrfelsökning av Java-program, men de exakta konfigurationsstegen för varje IDE varierar. Se instruktionerna för hur du konfigurerar fjärrfelsökning för din IDE. Vanligtvis kräver IDE-konfigurationer:

+ Värden AEM SDK:s lokala snabbstart lyssnar på, vilket är `localhost`.
+ Porten AEM SDK:s lokala snabbstart lyssnar efter fjärrfelsökningsanslutning, som är den port som anges av parametern `address` när AEM SDK:s lokala snabbstart startas.
+ Ibland måste det anges vilka Maven-projekt som tillhandahåller källkoden till fjärrfelsökningen. det här är ditt OSGi-paket med maven-projekt.

### Konfigurera instruktioner

+ [VS Code Java Remote Debugger - konfiguration](https://code.visualstudio.com/docs/java/java-debugging)
+ [Konfigurera IntelliJ IDEA Remote Debugger](https://www.jetbrains.com/help/idea/tutorial-remote-debug.html)
+ [Konfigurera Eclipse Remote Debugger](https://javapapers.com/core-java/java-remote-debug-with-eclipse/)
