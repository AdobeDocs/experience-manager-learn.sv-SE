---
title: Använda formatsystem i AEM Forms
description: Skapa formatvarianter för knappkomponent
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16276
exl-id: f97a9aed-99d3-4cce-bc3b-c80638e4f1cb
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '231'
ht-degree: 0%

---

# Introduktion

Med Style System i Adobe Experience Manager (AEM) kan användare skapa flera visuella varianter av en komponent och sedan välja vilket format som ska användas när ett formulär skapas. Detta gör komponenterna mer flexibla och återanvändbara, utan att man behöver skapa anpassade komponenter för varje format.

Den här artikeln hjälper dig att skapa varianter av knappkomponenten och testa variationerna i den lokala molnförberedda miljön innan du skickar ändringarna till molninstansen med hjälp av molnhanteraren.

På skärmbilden visas de två olika stilsvariationerna för knappkomponenten som är tillgängliga för formulärförfattaren.


![button-variations](assets/button-variations.png)

## Förutsättningar

* AEM Forms molnklar instans med kärnkomponenter.
* Klona ett tema: Du måste känna till hur du klonar ett tema. I den här självstudiekursen har vi klonat [eAel-temat](https://github.com/adobe/aem-forms-theme-easel). Du kan klona alla tillgängliga teman efter dina behov.

* Installera den senaste versionen av Apache Maven. Apache Maven är ett automatiserat byggverktyg som ofta används för Java™-projekt. Genom att installera den senaste versionen får du de beroenden du behöver för att anpassa temat.
* Installera en vanlig textredigerare. Exempel: Microsoft® Visual Studio Code. Med en vanlig textredigerare som Microsoft® Visual Studio Code får du en användarvänlig miljö där du kan redigera och ändra temafiler.



## Nästa steg

[Skapa formatprincip](./style-policy.md)
