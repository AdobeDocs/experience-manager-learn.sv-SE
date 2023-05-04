---
title: Skapa ditt första OSGi-paket med AEM Forms
description: Bygg ditt första OSGi-paket med Maven och Eclipse
version: 6.4,6.5
feature: Adaptive Forms
topic: Development
role: Developer
level: Beginner
exl-id: 307cc3b2-87e5-4429-8f21-5266cf03b78f
last-substantial-update: 2021-04-23T00:00:00Z
source-git-commit: bd41cd9d64253413e793479b5ba900c8e01c0eab
workflow-type: tm+mt
source-wordcount: '0'
ht-degree: 0%

---

# Skapa ditt första OSGi-paket

Ett OSGi-paket är en Java™-arkivfil som innehåller Java-kod, resurser och ett manifest som beskriver paketet och dess beroenden. Paketet är en distributionsenhet för ett program. Den här artikeln är avsedd för utvecklare som vill skapa en OSGi-tjänst eller en servett med AEM Forms 6.4 eller 6.5. Så här skapar du ditt första OSGi-paket:


## Installera JDK

Installera den version av JDK som stöds. Jag har använt JDK1.8. Kontrollera att du har lagt till **JAVA_HOME** i dina miljövariabler och pekar på rotmappen för JDK-installationen.
Lägg till %JAVA_HOME%/bin i sökvägen

![datakälla](assets/java-home.JPG)

>[!NOTE]
> Använd inte JDK 15. Det stöds inte av AEM.

### Testa JDK-versionen

Öppna ett nytt kommandotolkfönster och skriv: `java -version`. Du bör gå tillbaka till den version av JDK som identifieras av `JAVA_HOME` variabel

![datakälla](assets/java-version.JPG)

## Installera Maven

Maven är ett automatiserat byggverktyg som främst används för Java-projekt. Följ de här stegen för att installera maven på din lokala dator.

* Skapa en mapp med namnet `maven` i C-enheten
* Ladda ned [binärt zip-arkiv](https://maven.apache.org/download.cgi)
* Extrahera innehållet i zip-arkivet till `c:\maven`
* Skapa en miljövariabel med namnet `M2_HOME` med värdet `C:\maven\apache-maven-3.6.0`. I mitt fall **mvn** version är 3.6.0. När den här artikeln skrivs är den senaste versionen av maven 3.6.3
* Lägg till `%M2_HOME%\bin` till din bana
* Spara ändringarna
* Öppna en ny kommandotolk och skriv in `mvn -version`. Du borde se **mvn** version som visas på skärmbilden nedan

![datakälla](assets/mvn-version.JPG)


## Installera Eclipse

Installera den senaste versionen av [förmörka](https://www.eclipse.org/downloads/)

## Skapa ditt första projekt

Arketype är en Maven-projektmallverktygslåda. En arkityp definieras som ett ursprungligt mönster eller en modell från vilken alla andra saker av samma typ görs. Namnet passar ihop med att vi försöker skapa ett system som ger ett konsekvent sätt att generera Maven-projekt. Arketype hjälper författare att skapa Maven-projektmallar för användare och ger användarna möjlighet att generera parametriserade versioner av dessa projektmallar.
Så här skapar du ditt första maven-projekt:

* Skapa en ny mapp med namnet `aemformsbundles` i C-enheten
* Öppna en kommandotolk och navigera till `c:\aemformsbundles`
* Kör följande kommando i kommandotolken

```java
mvn -B org.apache.maven.plugins:maven-archetype-plugin:3.2.1:generate -D archetypeGroupId=com.adobe.aem -D archetypeArtifactId=aem-project-archetype -D archetypeVersion=36 -D appTitle="My Site" -D appId="mysite" -D groupId="com.mysite" -D aemVersion=6.5.13
```

När du är klar bör du se ett meddelande om att bygget lyckades i kommandofönstret

## Skapa förmörkande projekt från ditt maven-projekt

* Ändra arbetskatalogen till `mysite`
* Kör `mvn eclipse:eclipse` från kommandoraden. Kommandot läser din pom-fil och skapar Eclipse-projekt med korrekta metadata så att Eclipse förstår projekttyper, relationer, klassökväg osv.

## Importera projektet till förmörkning

Starta **Eclipse**

Gå till **Arkiv -> Importera** och markera **Befintliga Maven-projekt** som visas här

![datakälla](assets/import-mvn-project.JPG)

Klicka på Nästa

Välj c:\aemformsbundles\mysite by clicking the **Bläddra** knapp

![datakälla](assets/mysite-eclipse-project.png)

>[!NOTE]
>Du kan välja att importera lämpliga moduler beroende på dina behov. Välj och importera endast kärnmodulen om du bara ska skapa Java-kod i ditt projekt.

Klicka **Slutför** för att starta importprocessen

Projektet importeras till Eclipse och ett antal `mysite.xxxx` mappar

Expandera `src/main/java` under `mysite.core` mapp. Det här är den mapp där du skriver större delen av koden.

![datakälla](assets/mysite-core-project.png)

## Inkludera AEMFD-klient-SDK

Du måste inkludera AEMFD-klientens SDK i ditt projekt för att kunna utnyttja olika tjänster som medföljer AEM Forms. Se [AEMFD Client SDK](https://mvnrepository.com/artifact/com.adobe.aemfd/aemfd-client-sdk) för att inkludera rätt klient-SDK i Maven-projektet. Du måste inkludera AEM FD-klient-SDK i beroendeavsnittet i `pom.xml` för kärnprojektet enligt nedan.

```xml
<dependency>
    <groupId>com.adobe.aemfd</groupId>
    <artifactId>aemfd-client-sdk</artifactId>
    <version>6.0.122</version>
</dependency>
```

Så här skapar du ditt projekt:

* Öppna **kommandotolkfönstret**
* Navigera till `c:\aemformsbundles\mysite\core`
* Kör kommandot `mvn clean install -PautoInstallBundle`
Kommandot ovan skapar och installerar paketet på den AEM servern som körs på `http://localhost:4502`. Paketet finns också i filsystemet på
   `C:\AEMFormsBundles\mysite\core\target` och kan distribueras med [Felix webbkonsol](http://localhost:4502/system/console/bundles)

## Nästa steg

[Skapa OSGi-tjänst](./create-osgi-service.md)

