---
title: Installera och konfigurera Tomcat
seo-title: Install and Configure Tomcat
description: Detta är en del av en flerstegskurs för att skapa ditt första interaktiva kommunikationsdokument. I det här avsnittet kommer vi att installera TOMCAT och distribuera filen sampleRest.war i TOMCAT.
uuid: c6d4c74c-ea16-4c63-92c9-182d087fd88c
feature: Interactive Communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
discoiquuid: 4f400c22-6c96-4018-851c-70d988ce7c6c
topic: Development
role: Developer
level: Beginner
exl-id: f0f19838-1ade-4eda-b736-a9703a3916c2
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '236'
ht-degree: 0%

---

# Installera och konfigurera Tomcat {#install-and-configure-tomcat}

I den här delen installerar vi TOMCAT och distribuerar filen sampleRest.war i TOMCAT. REST-slutpunkten som exponeras av den här WAR-filen utgör grunden för vår datakälla och formulärdatamodell.

Så här ställer du in tomcat:

1. Hämta och installera JDK1.8.
2. Ställ in JAVA_HOME till att peka på JDK1.8.
3. Hämta [tomat](https://tomcat.apache.org/). Krigsfilen har testats med Tomcat version 8.5.x och 9.0.x.
4. Ladda ned tomcat-versionen av din inställning. Du kan ladda ned zip-filen för 64-bitarsfönster under kärnavsnittet.
5. Packa upp innehållet till c:\tomcat.
6. Du bör se något liknande i din cd-enhet **c:\tomcat\apache-tomcat-8.5.27** beroende på vilken version du har
7. Skapa en miljövariabel med namnet&quot;CATALINA_HOME&quot; och ange värdet till Exempel på installationsmappen för tomcat c:\tomcat\apache- tomcat-8.5.27
8. Kopiera filen SampleRest.war till webbappen för din Tomcat-installation
9. Starta nytt kommandotolkfönster.
10. Navigera till &lt;tomcat install=&quot;&quot; folder=&quot;&quot;>\bin och kör startup.bat
11. När tomcat har startat testar du slutpunkten som exponeras av WAR-filen av [klicka här](http://localhost:8080/SampleRest/webapi/getStatement/9586)
12. Du bör hämta exempeldata som resultat av det här anropet.

Grattis!!!! Du har konfigurerat för att katt och distribuerat filen SampleRest.war.
