---
title: AEM Forms med Marketo (del 2)
description: Självstudiekurs för att integrera AEM Forms med Marketo med AEM Forms Form Data Model.
feature: Adaptive Forms, Form Data Model
version: Experience Manager 6.4, Experience Manager 6.5
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: f8ba3d5c-0b9f-4eb7-8609-3e540341d5c2
duration: 137
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '211'
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
