---
title: Skapa ditt första OSGi-paket med AEM formulär
description: Bygg ditt första OSGi-paket med maven och eclipse
feature: Adaptive Forms
topics: development
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '820'
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
* Ladda ned [binärt zip-arkiv](http://maven.apache.org/download.cgi)
* Extrahera innehållet i zip-arkivet till `c:\maven`
* Skapa en miljövariabel med namnet `M2_HOME` med värdet `C:\maven\apache-maven-3.6.0`. I mitt fall **mvn** version är 3.6.0. När den här artikeln skrivs är den senaste versionen av maven 3.6.3
* Lägg till `%M2_HOME%\bin` till din bana
* Spara ändringarna
* Öppna en ny kommandotolk och skriv in `mvn -version`. Du borde se **mvn** version som visas på skärmbilden nedan

![datakälla](assets/mvn-version.JPG)

## Settings.xml

A Maven `settings.xml` -filen definierar värden som konfigurerar Maven-körningen på olika sätt. Det används oftast för att definiera en lokal plats för databasen, alternativa servrar för fjärrdatabaser och autentiseringsinformation för privata databaser.

Navigera till `C:\Users\<username>\.m2 folder`
Extrahera innehållet i [settings.zip](assets/settings.zip) och montera den i `.m2` mapp.

## Installera Eclipse

Installera den senaste versionen av [förmörka](https://www.eclipse.org/downloads/)

## Skapa ditt första projekt

Arketype är en Maven-projektmallverktygslåda. En arkityp definieras som ett ursprungligt mönster eller en modell från vilken alla andra saker av samma typ görs. Namnet passar ihop med att vi försöker skapa ett system som ger ett konsekvent sätt att generera Maven-projekt. Arketype hjälper författare att skapa Maven-projektmallar för användare och ger användarna möjlighet att generera parametriserade versioner av dessa projektmallar.
Så här skapar du ditt första maven-projekt:

* Skapa en ny mapp med namnet `aemformsbundles` i C-enheten
* Öppna en kommandotolk och navigera till `c:\aemformsbundles`
* Kör följande kommando i kommandotolken
* `mvn archetype:generate  -DarchetypeGroupId=com.adobe.granite.archetypes  -DarchetypeArtifactId=aem-project-archetype -DarchetypeVersion=19`

Maven-projektet genereras interaktivt och du uppmanas att ange värden för ett antal egenskaper, till exempel

| Egenskapsnamn | Signifikans | Värde |
|------------------------|---------------------------------------|---------------------|
| groupId | groupId identifierar projektet unikt i alla projekt | com.learningaemforms.adobe |
| appsFolderName | Namnet på den mapp som innehåller projektstrukturen | inlärningsaemforms |
| artifactId | artifactId är namnet på behållaren utan version. Om du skapade den kan du välja vilket namn du vill med gemener och inga märkliga symboler. | inlärningsaemforms |
| version | Om du distribuerar den kan du välja valfri typisk version med siffror och punkter (1.0, 1.1, 1.0.1, ...). | 1.0 |

Acceptera standardvärdena för de andra egenskaperna genom att trycka på Retur.
Om allt blir bra kan du se ett meddelande om att bygget fungerar i kommandofönstret

## Skapa förmörkande projekt från ditt maven-projekt

Ändra arbetskatalogen till `learningaemforms`.
Kör `mvn eclipse:eclipse` från kommandoraden Ovanstående kommando läser din PDF-fil och skapar Eclipse-projekt med korrekta metadata så att Eclipse förstår projekttyper, relationer, klassökväg osv.

## Importera projektet till förmörkning

Starta **Eclipse**

Gå till **Arkiv -> Importera** och markera **Befintliga Maven-projekt** som visas här

![datakälla](assets/import-mvn-project.JPG)

Klicka på Nästa

Välj `c:\aemformsbundles\learningaemform`s genom att klicka på **Bläddra** knapp

![datakälla](assets/select-mvn-project.JPG)

>[!NOTE]
>Du kan välja att importera lämpliga moduler beroende på dina behov. Välj och importera endast kärnmodulen om du bara ska skapa Java-kod i ditt projekt.

Klicka **Slutför** för att starta importprocessen

Projektet importeras till Eclipse och ett antal `learningaemforms.xxxx` mappar

Expandera `src/main/java` under `learningaemforms.core` mapp. Det här är den mapp där du skriver större delen av koden.

![datakälla](assets/learning-core.JPG)

## Bygg ditt projekt

När du har skrivit OSGi-tjänsten, eller servleten, måste du skapa ditt projekt för att generera OSGi-paketet som kan distribueras med Felix webbkonsol. Se [AEMFD Client SDK](https://repo.adobe.com/nexus/content/repositories/public/com/adobe/aemfd/aemfd-client-sdk/) för att inkludera rätt klient-SDK i Maven-projektet. Du måste inkludera AEM FD-klient-SDK i beroendeavsnittet i `pom.xml` för kärnprojektet enligt nedan.

```xml
<dependency>
    <groupId>com.adobe.aemfd</groupId>
    <artifactId>aemfd-client-sdk</artifactId>
    <version>6.0.122</version>
</dependency>
```

Så här skapar du ditt projekt:

* Öppna **kommandotolkfönstret**
* Navigera till `c:\aemformsbundles\learningaemforms\core`
* Kör kommandot `mvn clean install`
Om allt blir bra ska du se paketet på följande plats `C:\AEMFormsBundles\learningaemforms\core\target`. Paketet är nu klart att distribueras till AEM med Felix webbkonsol.
