---
title: Autentiseringsuppgifter för AEM Forms-tjänsten
description: Hämta autentiseringsuppgifter för tjänsten från AEM Developer Console.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
kt: 8192
thumbnail: 330519.jpg
exl-id: 74cb8c30-4c41-426c-a1b5-fc595a3167c8
source-git-commit: b3e9251bdb18a008be95c1fa9e5c79252a74fc98
workflow-type: tm+mt
source-wordcount: '112'
ht-degree: 0%

---

# Autentiseringsuppgifter för AEM Forms-tjänsten

Integrationer med AEM as a Cloud Service måste kunna autentiseras säkert till AEM. AEM Developer Console genererar autentiseringsuppgifter som används av externa program, system och tjänster för att programmässigt interagera med AEM Author eller Publiceringstjänster via HTTP.

>[!VIDEO](https://video.tv.adobe.com/v/330519?quality=12&learn=on)

Den hämtade tjänstens autentiseringsuppgifter lagras som en resursfil med namnet service_token.json i den angivna förmörkelsen. Värdena i service_token-filen används för att generera JWT och för att byta ut JWT mot en Access-token. Verktygsklassen GetServiceCredentials används för att hämta egenskapsvärden från resursfilen service_token.json.
