---
title: Skapa en molntjänstkonfiguration
description: Skapa en datakälla för att ansluta till Salesforce med OAuth-autentiseringsuppgifterna
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Adaptive Forms, Integrations
jira: KT-7148
thumbnail: 331755.jpg
exl-id: e2d56e91-c13e-4787-a97f-255938b5d290
duration: 173
source-git-commit: ce22dd482417a54d222165deaf485ff69c2856b7
workflow-type: tm+mt
source-wordcount: '75'
ht-degree: 0%

---

# Skapa data-Source

Skapa en REST-baserad datakälla med swagger-filen som skapades i det tidigare steget.

>[!VIDEO](https://video.tv.adobe.com/v/331755?quality=12&learn=on)

| Inställning | Värde |
|---------------------|-----------------------------------------------------------------|
| OAuth-URL | https://login.salesforce.com/services/oauth2/authorize |
| Auktoriseringsomfång | api chatter_api full id openid refresh_token visualforce web |
| Uppdatera token-URL | https://newfocus-dev-ed.my.salesforce.com/services/oauth2/token |
| Åtkomsttoken-URL | https://newfocus-dev-ed.my.salesforce.com/services/oauth2/token |


**Domännamnen för uppdaterings- och åtkomsttokens URL måste ändras så att de matchar dina Salesforce-kontoinställningar**