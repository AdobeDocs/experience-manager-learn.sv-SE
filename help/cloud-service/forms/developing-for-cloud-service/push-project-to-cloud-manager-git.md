---
title: Push AEM-projekt till molnhanterardatabasen
description: Överför lokal Git-databas till molnhanterardatabasen
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
jira: KT-8851
exl-id: e61cea37-b931-49c6-9e5d-899628535480
duration: 32
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '147'
ht-degree: 0%

---

# Push AEM project to cloud manager git repo

I föregående steg synkroniserade vi vårt AEM-projekt med den adaptiva Forms och de teman som skapades i AEM-instansen.
Vi måste nu lägga till dessa ändringar i vår lokala Git-databas och sedan överföra den lokala Git-databasen till molnhanterarens Git-databas.
Öppna kommandotolken och navigera till c:\cloudmanager\aem-Banking-app
Utför följande kommandon

```
git add .
```

Detta lägger till de nya filerna i scengrenen i den lokala Git-databasen

```
git commit -m "My First AF"
```

Detta implementerar filerna i huvudgrenen i vår lokala Git-databas

```
git push -f bankingapp master:"MyFirstAF"
```

I ovanstående kommando flyttar vi huvudgrenen från vår lokala Git-databas till MyFirstAF-grenen i molnhanterardatabasen som identifieras av bankingapp-användarnamnet.

## Nästa steg

[Distribuera projektet till utvecklingsmiljön](./deploy-to-dev-environment.md)
