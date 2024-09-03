---
title: Integrera AEM Forms Cloud Service och Marketo (del 2)
description: Lär dig hur du integrerar AEM Forms och Marketo med AEM Forms Form Data Model.
feature: Form Data Model,Integration
version: Cloud Service
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
last-substantial-update: 2024-07-24T00:00:00Z
jira: KT-15876
exl-id: 75e589fa-f7fc-4d0b-98c8-ce4d603ef2f7
source-git-commit: ba744f95f8d1f0b982cd5430860f0cb0945a4cda
workflow-type: tm+mt
source-wordcount: '218'
ht-degree: 0%

---

# Skapa data-Source

Marketo REST API:er autentiseras med 2-legged OAuth 2.0. Vi kan enkelt skapa en datakälla med swagger-filen som laddats ned i föregående steg

## Skapa konfigurationsbehållare

* Logga in på AEM.
* Klicka på Verktyg-menyn och sedan **Konfigurationsläsaren** enligt nedan

* ![verktygsmenyn](assets/datasource3.png)

* Klicka på **Skapa** och ange ett beskrivande namn enligt nedan. Se till att du väljer alternativet för molnkonfigurationer så som visas nedan

* ![konfigurationsbehållare](assets/datasource4.png)

## Skapa molntjänster

* Navigera till Verktyg-menyn och klicka sedan på molntjänster -> Datakällor

* ![molntjänster](assets/datasource5.png)

* Välj den konfigurationsbehållare som skapades i det tidigare steget och klicka på **Skapa** för att skapa en ny datakälla.Ange ett beskrivande namn och välj RESTful-tjänst i listrutan Tjänsttyp och klicka på **Nästa**
* ![new-data-source](assets/datasource6.png)

* Ladda upp swagger-filen och ange typ, klient-ID, klienthemlighet och åtkomsttoken-URL som är specifik för din Marketo-instans enligt skärmbilden nedan.

* Testa anslutningen och om anslutningen lyckas kontrollerar du att du klickar på den blå **Skapa**-knappen för att slutföra processen med att skapa datakällan.

* ![data-source-config](assets/datasource1.png)


## Nästa steg

[Skapa formulärdatamodell](./part3.md)
