---
title: Använda AEM Forms med Acrobat Sign
description: Med Acrobat Sign och AEM Forms kan man automatisera komplexa transaktioner och inkludera juridiskt bindande e-signaturer som en del av en smidig digital upplevelse.
feature: Adaptive Forms,Acrobat Sign
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
exl-id: 0be61f04-c3ed-4ecb-bab7-73fd308c14e0
last-substantial-update: 2020-03-20T00:00:00Z
source-git-commit: 81b96f59450448a3d5b17a61aa025acd60d0cce1
workflow-type: tm+mt
source-wordcount: '158'
ht-degree: 0%

---

# Använda AEM Forms med Acrobat Sign

Acrobat Sign möjliggör e-signaturarbetsflöden för anpassningsbara formulär. E-signaturer förbättrar arbetsflödena för att bearbeta dokument inom juridik, försäljning, löneadministration, personaladministration och många andra områden.
Integrationen mellan AEM Forms och Acrobat Sign gör att du kan göra följande

* Använd adaptiv Forms för att samla in data och presentera autogenererade dokument för inspelning (DoR) för signaturer
* Skapa adaptiv Forms baserat på din PDF-mall. Sammanfoga data med PDF-mallen och presentera samma data för signaturer
* Skicka dokument för signering med arbetsflödeskomponenten Signera dokument

## Förutsättningar

Du behöver följande för att kunna integrera Acrobat Sign med AEM Forms:

* En SSL-aktiverad AEM Forms-server
* Ett aktivt Acrobat Sign-utvecklarkonto.
* Ett Acrobat Sign API-program
* Autentiseringsuppgifter (klient-ID och klienthemlighet) för Acrobat Sign API-program.
