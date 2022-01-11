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
exl-id: e61cea37-b931-49c6-9e5d-899628535480
source-git-commit: 8d83d01fca3bfc9e6f674f7d73298b42f98a5d46
workflow-type: tm+mt
source-wordcount: '139'
ht-degree: 0%

---

# Skicka AEM till molnhanterarens Git-rapport

I det föregående steget synkroniserade vi vårt AEM med det adaptiva Forms och de teman som skapades i AEM.
Vi måste nu lägga till dessa ändringar i vår lokala Git-databas och sedan överföra den lokala Git-databasen till molnhanterarens Git-databas.
Öppna kommandotolken och gå till c:\cloudmanager\aem-banking-app Execute the following commands

```
git add .
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
