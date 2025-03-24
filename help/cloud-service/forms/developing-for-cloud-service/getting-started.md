---
title: Installera kraven
description: Installera nödvändig programvara för att konfigurera utvecklingsmiljön
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
jira: KT-8842
exl-id: 274018b9-91fe-45ad-80f2-e7826fddb37e
duration: 44
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '222'
ht-degree: 0%

---

# Installera nödvändig programvara

I den här självstudiekursen får du hjälp med att skapa ett AEM Forms-projekt, synkronisera AEM Forms-projektet med den lokala AEM-instansen med IntelliJ och repo. Du får även lära dig hur du lägger till ditt projekt i den lokala Git-databasen och överför den lokala Git-databasen till molnhanterardatabasen.





Den här självstudiekursen visar mappstrukturen framåt.

* [Installera JDK 1](https://www.oracle.com/java/technologies/downloads/#java11-windows). Jag har laddat ned jdk-11.0.6_windows-x64_bin.zip
* [Maven](https://maven.apache.org/guides/getting-started/windows-prerequisites.html).Om du till exempel har installerat Maven i mappen c:\maven måste du skapa en miljövariabel som heter M2_HOME med värdet C:\maven\apache-maven-3.6.0. Lägg sedan till M2_HOME\bin i sökvägen och spara inställningarna.

## Skapa Maven-projekt med AEM Project Archetype

* Skapa en mapp med namnet **cloudManager** (du kan ge den vilket namn som helst) i din c-enhet
* Öppna kommandotolkfönstret och gå till **c:\cloudmanager**
* Kopiera och klistra in innehållet i [textfilen](assets/creating-maven-project.txt) i kommandotolken. Du kan behöva ändra DarchetypeVersion=30 beroende på den [senaste versionen](https://github.com/adobe/aem-project-archetype/releases). Den senaste versionen var 30 när den här artikeln skrevs.
* Kör kommandot genom att trycka på tangenten enter.Om allt är rätt ska du se meddelandet om att det lyckades.

## Nästa steg

[Installerar IntelliJ](./intellij-set-up.md)