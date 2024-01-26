---
title: Installera och konfigurera Tomcat-video
description: Detta är en del av en flerstegskurs som lär dig skapa ditt första interaktiva kommunikationsdokument.
feature: Interactive Communication
doc-type: Tutorial
version: 6.4,6.5
thumbnail: 37815.jpg
discoiquuid: 5f68be3d-aa35-4a3f-aaea-b8ee213c87ae
topic: Development
role: Developer
level: Beginner
exl-id: faa9ca2d-6cfa-4abf-be5e-3e549202853a
duration: 249
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '239'
ht-degree: 0%

---

# Installera och konfigurera Tomcat {#install-and-configure-tomcat}

I den här delen installerar vi TOMCAT och distribuerar filen sampleRest.war i TOMCAT. REST-slutpunkten som exponeras av den här WAR-filen utgör grunden för vår datakälla och formulärdatamodell.

>[!VIDEO](https://video.tv.adobe.com/v/37815?quality=12&learn=on)

Så här ställer du in tomcat:

1. Hämta och installera JDK1.8.
2. Ställ in JAVA_HOME till att peka på JDK1.8.
3. Ladda ned [tomat](https://tomcat.apache.org/). Krigsfilen har testats med Tomcat version 8.5.x och 9.0.x.
4. Ladda ned tomcat-versionen av din inställning. Du kan ladda ned zip-filen för 64-bitarsfönster under kärnavsnittet.
5. Zippa upp innehållet till din c:\tomcat.
6. Du bör se något liknande i din cd-enhet **c:\tomcat\apache-tomcat-8.5.27** beroende på vilken version du har
7. Skapa en miljövariabel med namnet&quot;CATALINA_HOME&quot; och ange värdet till Exempel på installationsmappen för tomcat c:\tomcat\apache-tomcat-8.5.27
8. Kopiera filen SampleRest.war till webbappen för din Tomcat-installation
9. Starta nytt kommandotolkfönster.
10. Navigera till &lt;tomcat install=&quot;&quot; folder=&quot;&quot;>\bin och kör startup.bat
11. När tomcat har startat testar du slutpunkten som exponeras av WAR-filen av [klicka här](http://localhost:8080/SampleRest/webapi/getStatement/9586)
12. Du bör hämta exempeldata som resultat av det här anropet.

Grattis!!! Du har konfigurerat för att katt och distribuerat filen SampleRest.war.

I följande video förklaras distributionen av exempelprogrammet i Tomcat
>[!VIDEO](https://video.tv.adobe.com/v/37815?quality=12&learn=on)

## Nästa steg

[Skapa RESTful-datakälla](./create-data-source.md)