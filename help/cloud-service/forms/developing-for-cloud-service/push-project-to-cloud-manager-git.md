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
source-git-commit: d42fd02b06429be1b847958f23f273cf842d3e1b
workflow-type: tm+mt
source-wordcount: '141'
ht-degree: 0%

---


# Skicka AEM till molnhanteraren Git rep

I föregående steg synkroniserade vi vårt AEM med det adaptiva Forms och de teman som skapades i AEM.
Vi måste nu lägga till dessa ändringar i vår lokala Git-databas och sedan överföra den lokala Git-databasen till molnhanterarens Git-databas

öppna kommandotolken och navigera till c:\cloudmanager\aem-banking-app Execute the following commands

```
git add .**
```

Detta lägger till de nya filerna i scengrenen i den lokala Git-databasen

```
git commit -m "My First AF"
```

Detta implementerar filerna på den överordnad grenen i vår lokala Git-databas

```
git push -f bankingapp master:"My First AF"
```

I ovanstående kommando överför vi vår överordnad gren från vår lokala Git-databas till grenen My First AF i molnhanterardatabasen som identifieras av bankingapp-användarnamnet



