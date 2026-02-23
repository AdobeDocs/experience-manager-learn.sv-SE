---
title: Skapa formulärdatamodell för IC-dokument
description: Lär dig skapa en formulärdatamodell i AEM Forms för dynamisk hämtning av data för interaktivt kommunikationsdokument.
version: Experience Manager as a Cloud Service
feature: Interactive Communication
role: Developer
level: Intermediate
doc-type: Feature Video
duration: 170
last-substantial-update: 2026-02-20T00:00:00Z
jira: KT-20353
source-git-commit: c2dde214df0dabe8d856751a9d16afb1423e7450
workflow-type: tm+mt
source-wordcount: '153'
ht-degree: 0%

---


# Skapa formulärdatamodell för IC-dokument

Skapa en Forms datamodell för att integrera externa datakällor med interaktiv kommunikation i Adobe AEM. Den här processen innebär att konfigurera en RESTful-tjänst, överföra en Swagger-fil och konfigurera tjänstslutpunkter för dynamisk hämtning och bindning av data. Lär dig hur du ansluter till externa tjänster på ett säkert sätt och testar modellen för att säkerställa att data kan hämtas korrekt.

En modell-API-server implementerades som simulerar Orders-tjänsten för utvecklings- och testningsändamål. Den visar en slutpunkt för att hämta order för en viss användare (t.ex. efter användar-ID) och returnera fördefinierade eller dynamiskt genererade orderdata i samma schema som produktions-API:t.

Swagger-filen som används för att skapa formulärdatamodellen kan [hämtas här](assets/UsersAndOrders.json)

>[!VIDEO](https://video.tv.adobe.com/v/3480005/?learn=on&enablevpops)

## Nästa steg

[Skapa mall](./create-template.md)
