---
title: Installera och konfigurera Git
description: Initiera din lokala Git-databas
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
jira: KT-8848
exl-id: 31487027-d528-48ea-b626-a740b94dceb8
duration: 59
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '207'
ht-degree: 0%

---

# Installera Git


[Installera Git](https://git-scm.com/downloads). Du kan välja standardinställningar och slutföra installationsprocessen.
Gå till kommandotolken Navigera till typen c:\cloudmanager\aem-Banking-app i Git —version. Du bör se den version av GIT som är installerad på datorn

## Initiera lokal Git-databas

Kontrollera att du finns i mappen c:\cloudmanager\aem-Banking-app

```
git init
```

Ovanstående kommando initierar projektet som en Git-lokal databas

```
git add .
```

Detta lägger till alla projektfiler i Git-databasen som är klara att implementeras i Git-databasen

```
git commit -m "initial commit"
```

Detta implementerar filerna i Git-databasen



## Registrera molnhanterararkivet hos vår lokala Git-databas

Få åtkomst till ditt molnhanterarsvar
![få åtkomst till svarsinformationen](assets/cloud-manager-repo.png)
Hämta autentiseringsuppgifter för molnhanterarens svar
![get-credentials](assets/cloud-manager-repo1.png)

Spara användarnamnet i konfigurationsfilen

```java
git config --global credential.username "gbedekar-adobe-com"
```

spara lösenordet i konfigurationsfilen

```java
git config --global user.password "XXXX"
```

(Lösenordet är ditt lösenord för molnhanterarens Git-databas)

Registrera molnhanterarens Git-databas hos din lokala Git-databas. Kommandot nedan associerar **bankingapp** med fjärrhanterarens Git-databas. Du kunde ha använt vilket namn som helst i stället för **bankingapp**


```shell
git remote add bankingapp https://git.cloudmanager.adobe.com/<cloud-manager-repo-path>
```

(Kontrollera att du använder din databas-URL)

Kontrollera om fjärrdatabasen är registrerad

```java
git remote -v
```

## Nästa steg

[Synkronisera AEM med AEM i IntelliJ](./intellij-and-aem-sync.md)
