---
title: Använda AEM Forms med Adobe Sign
description: Med Adobe Sign och AEM Forms kan man automatisera komplexa transaktioner och inkludera juridiskt bindande e-signaturer som en del av en smidig digital upplevelse.
feature: Adaptive Forms,Adobe Sign
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '165'
ht-degree: 1%

---

# Använda AEM Forms med Adobe Sign

Adobe Sign möjliggör e-signaturarbetsflöden för anpassningsbara formulär. E-signaturer förbättrar arbetsflödena för att bearbeta dokument inom juridik, försäljning, löneadministration, personaladministration och många andra områden.
Integrationen mellan AEM Forms och Adobe Sign gör att du kan göra följande

* Använd adaptiv Forms för att samla in data och presentera autogenererade dokument för inspelning (DoR) för signaturer
* Skapa adaptiv Forms baserat på din PDF-mall. Sammanfoga data med PDF-mallen och presentera samma data för signaturer
* Skicka dokument för signering med arbetsflödeskomponenten Signera dokument

## Förutsättningar

Du behöver följande för att kunna integrera Adobe Sign med AEM Forms:

* En SSL-aktiverad AEM Forms-server
* Ett aktivt Adobe Sign-utvecklarkonto.
* Ett Adobe Sign API-program
* Autentiseringsuppgifter (klient-ID och klienthemlighet) för Adobe Sign API-program.

