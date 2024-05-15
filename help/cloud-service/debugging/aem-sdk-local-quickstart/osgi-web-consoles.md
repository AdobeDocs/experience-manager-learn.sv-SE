---
title: Felsöka AEM SDK med OSGi-webbkonsolen
description: AEM SDK:s lokala snabbstart har en OSGi-webbkonsol som innehåller en mängd information och introspectioner i den lokala AEM som är användbara för att förstå hur programmet känns igen av och fungerar i AEM.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
kt: 5265, 5366, 5267
topic: Development
role: Developer
level: Beginner, Intermediate
exl-id: 0929bc1a-376c-4e16-a540-a276fd5af164
duration: 486
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '369'
ht-degree: 0%

---

# Felsöka AEM SDK med OSGi-webbkonsolen

AEM SDK:s lokala snabbstart har en OSGi-webbkonsol som innehåller en mängd information och introspectioner i den lokala AEM som är användbara för att förstå hur programmet känns igen av och fungerar i AEM.

AEM innehåller många OSGi-konsoler, där var och en ger viktiga insikter i olika aspekter av AEM, men det här är vanligtvis det mest användbara när du felsöker programmet.

## Paket

>[!VIDEO](https://video.tv.adobe.com/v/34335?quality=12&learn=on)

Bundles-konsolen är en katalog över OSGi-paketen och deras information, som distribueras till AEM, tillsammans med ad hoc-möjligheten att starta och stoppa dem.

Konsolen Bundles finns på:

+ Verktyg > Åtgärder > Webbkonsol > OSGi > Paket
+ Eller direkt på: [http://localhost:4502/system/console/bundles](http://localhost:4502/system/console/bundles)

Om du klickar i varje paket får du information som kan hjälpa dig med felsökningen av programmet.

+ Kontrollerar OSGi-paketet
+ Verifierar om ett OSGi-paket är aktivt
+ Fastställa om ett OSGi-paket har otillfredsställande importer som förhindrar det från att starta

## Komponenter

>[!VIDEO](https://video.tv.adobe.com/v/34336?quality=12&learn=on)

Komponentkonsolen är en katalog över alla OSGi-komponenter som distribueras till AEM och ger all information om dem, från deras definierade OSGi-komponentlivscykel till vilka OSGi-tjänster de kan referera till

Komponentkonsolen finns på:

+ Verktyg > Åtgärder > Webbkonsol > OSGi > Komponenter
+ Eller direkt på: [http://localhost:4502/system/console/components](http://localhost:4502/system/console/components)

Viktiga aspekter som kan vara till hjälp vid felsökning:

+ Kontrollerar OSGi-paketet
+ Verifierar om ett OSGi-paket är aktivt
+ Fastställa om ett OSGi-paket har otillfredsställande importer som förhindrar det från att starta
+ Hämta komponentens PID för att skapa OSGi-konfigurationer för dem i Git
+ Identifiera OSGi-egenskapsvärden bundna till den aktiva OSGi-konfigurationen

## Sling Models

>[!VIDEO](https://video.tv.adobe.com/v/34337?quality=12&learn=on)

Sling Models-konsolen finns på:

+ Verktyg > Åtgärder > Webbkonsol > Status > Sling Models
+ Eller direkt på: [http://localhost:4502/system/console/status-slingmodels](http://localhost:4502/system/console/status-slingmodels)

Viktiga aspekter som kan vara till hjälp vid felsökning:

+ Verifierar att modeller har registrerats med rätt resurstyp
+ Det går att anpassa verifieringen av modellerna från rätt objekt (Resource eller SlingHttpRequestServlet)
+ Verifierar att exporterare för försäljningsmodell är korrekt registrerade
