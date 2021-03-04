---
title: Använda AEM Forms med Adobe Sign
description: Med Adobe Sign och AEM Forms kan man automatisera komplexa transaktioner och inkludera juridiskt bindande e-signaturer som en del av en smidig digital upplevelse.
feature: adaptiva formulär
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '159'
ht-degree: 0%

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

