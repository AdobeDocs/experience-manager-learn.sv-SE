---
title: Installera kraven
description: Installera nödvändig programvara för att konfigurera utvecklingsmiljön
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: cloud-service
topic: Development
kt: 8842
source-git-commit: d38da94bd4164163a16899b565c90b159194580a
workflow-type: tm+mt
source-wordcount: '231'
ht-degree: 0%

---


# Installera nödvändig programvara

I den här självstudiekursen får du hjälp med att skapa ett AEM Forms-projekt, synkronisera AEM Forms-projektet med den lokala AEM med IntelliJ och Repoo. Du får även lära dig hur du lägger till ditt projekt i den lokala Git-databasen och överför den lokala Git-databasen till molnhanterardatabasen.




Den här självstudiekursen visar mappstrukturen framåt.

* [Installera JDK 11](https://www.oracle.com/java/technologies/downloads/#java11-windows). Jag har laddat ned jdk-11.0.6_windows-x64_bin.zip
* [Maven](https://maven.apache.org/guides/getting-started/windows-prerequisites.html)Om du till exempel har installerat Maven i c:\maven folder måste du skapa en miljövariabel som heter M2_HOME med värdet C:\maven\apache-maven-3.6.0. Lägg sedan till M2_HOME\bin i sökvägen och spara inställningarna.

## Skapa Maven-projekt med AEM Project Archetype

* Skapa en mapp med namnet **molnhanterare**(du kan ge den vilket namn som helst) på din c-enhet
* Öppna kommandotolkfönstret och navigera till **c:\cloudmanager**
* Kopiera och klistra in innehållet i [textfil](assets/creating-maven-project.txt) i kommandotolken. Du kan behöva ändra DarchetypeVersion=30 beroende på vilken [senaste versionen](https://github.com/adobe/aem-project-archetype/releases). Den senaste versionen var 30 när den här artikeln skrevs.
* Kör kommandot genom att trycka på tangenten enter.Om allt är rätt ska du se meddelandet om att det lyckades.





