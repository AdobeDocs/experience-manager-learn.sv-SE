---
title: Uppdaterar molntjänstprojekt med den senaste arkitypen
description: Uppdaterar AEM Forms molntjänstprojekt med den senaste arkitypen
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: AEM Project Archetype
jira: KT-9534
exl-id: c2cd9c52-6f00-4cfe-a972-665093990e5d
duration: 85
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '322'
ht-degree: 0%

---

# Migrera från gammal aem-arketyp

Om du vill uppdatera ditt befintliga AEM Forms-projekt med den senaste makrotypen måste du kopiera din kod/konfigurationer osv. manuellt, från det gamla projektet till det nya projektet.

Följande steg har utförts för att migrera projektet som skapats med arkivtyp 30 till arkivtyp 33-projekt

## Skapa maven-projekt med den senaste arkitypen

* Öppna kommandotolken och navigera till c:\cloudmanager
* Skapa maven-projekt med den senaste arkitypen.
* Kopiera och klistra in innehållet i [textfil](assets/creating-maven-project.txt) i kommandotolken. Du kan behöva ändra DarchetypeVersion=33 beroende på [senaste versionen](https://github.com/adobe/aem-project-archetype/releases). Arketypen 33 innehåller nya AEM Forms-teman.
Eftersom vi skapar det nya maven-projektet i molnhanterarmappen som redan har ett aem-Banking-applikationsprojekt, bör du ändra **DartifactId** från aem-Banking till något annat. Jag har använt aem-Banking-application1 för den här artikeln.

>[!NOTE]
>
>Om du distribuerar det nya projektet som det är i molntjänstinstansen kommer HandleFormSubmission och SubmitToAEMServlet inte att finnas. Det beror på att varje gång du distribuerar ett projekt med Cloud Manager finns det något under `/apps` mappen tas bort och skrivs över.

## Kopiera din java-kod

När projektet har skapats kan du börja kopiera kod/konfigurationer o.s.v. från det gamla projektet till det nya projektet

* Kopiera HandleFormSubmission-serverleten från ```C:\CloudManager\aem-banking-application\core\src\main\java\com\aem\bankingapplication\core\servlets```
till
  ```C:\CloudManager\aem-banking-application1\core\src\main\java\com\aem\bankingapplication\core\servlets```

* Kopiera CustomSubmit från
  ```C:\CloudManager\aem-banking-application\ui.apps\src\main\content\jcr_root\apps\bankingapplication\SubmitToAEMServlet``` från aem-Banking-application till aem-Banking-application1 project

* importera det nya projektet till IntelliJ

* Uppdatera filter.xml i ui.apps-modulen i aem-Banking-application1-projektet så att den innehåller följande rad
  ```<filter root="/apps/bankingapplication/SubmitToAEMServlet"/>```

När du har kopierat all kod till ditt nya projekt kan du överföra projektet till molnhanteraren.

>[!NOTE]
>
>Om du vill synkronisera innehållet (Adaptive Forms, Form Data Model osv.) till ditt nya projekt måste du skapa rätt mappstruktur i IntelliJ-projektet och sedan synkronisera IntelliJ-projektet med din AEM med kommandot Get i repo-verktyget.
