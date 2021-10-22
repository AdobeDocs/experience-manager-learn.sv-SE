---
title: Skicka AEM till molnhanterardatabasen
description: Överför lokal Git-databas till molnhanterardatabasen
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
kt: 8851
source-git-commit: 9063c3dfd9ab9ac537850694ce6545a3fdc840e9
workflow-type: tm+mt
source-wordcount: '139'
ht-degree: 0%

---


# Skicka AEM till molnhanterarens Git-rapport

I föregående steg synkroniserade vi vårt AEM med det adaptiva Forms och de teman som skapades i AEM.
Vi måste nu lägga till dessa ändringar i vår lokala Git-databas och sedan överföra den lokala Git-databasen till molnhanterarens Git-databas.
Öppna kommandotolken och gå till c:\cloudmanager\aem-banking-app Execute the following commands

```
git add .**
```

Detta lägger till de nya filerna i scengrenen i den lokala Git-databasen

```
git commit -m "My First AF"
```

Detta implementerar filerna på den överordnad grenen i vår lokala Git-databas

```
git push -f bankingapp master:"MyFirstAF"
```

I ovanstående kommando överför vi vår överordnad gren från vår lokala Git-databas till MyFirstAF-grenen i molnhanterardatabasen som identifieras av bankingapp-användarnamnet.



