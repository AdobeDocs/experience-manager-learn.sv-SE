---
title: Skicka formulär utan rubrik till en anpassad skicka-tjänst
description: Anpassa ditt svar baserat på skickade data
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-13520
exl-id: 78fe677c-d5ab-40f6-a381-800f24e227ae
duration: 29
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '135'
ht-degree: 0%

---

# Anpassa svar baserat på skickade data

När formuläret har skickats in är det viktigt att användaren får feedback om utfallet av inlämningen. Svaret kan innehålla ett transaktions-ID eller bara ett personligt svar. En anpassad sändningstjänst skrivs i AEM Forms och den headless-blankett skickas till denna anpassade sändningstjänst för att styrka att den här användningen är korrekt.

## Krav

Vi rekommenderar att du är bekant med följande för att kunna implementera den här funktionen

* Upplevelse med Git
* Upplev AEM Cloud Manager
* Maven (denna artikel testades med 3.8.6)
* Lokal instans av AEM Forms Cloud-förberedd författare
* Tillgång till AEM Forms som Cloud Service
* IntelliJ eller någon annan utvecklingsmiljö


## Nästa steg

[Skriv den anpassade skicka-tjänsten](./custom-submit-service.md)
