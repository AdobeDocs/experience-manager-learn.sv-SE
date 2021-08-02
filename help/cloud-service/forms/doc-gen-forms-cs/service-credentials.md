---
title: AEM
description: Hämta autentiseringsuppgifter för tjänsten från AEM Developer Console.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: cloud-service
feature: Adaptiv Forms
topic: Utveckling
kt: 8192
thumbnail: 330519.jpg
source-git-commit: f2a94910fbc29b705f82a66d8248cbcf54366874
workflow-type: tm+mt
source-wordcount: '112'
ht-degree: 0%

---


# Tjänstautentiseringsuppgifter

Integrationer med AEM som Cloud Service måste kunna autentiseras säkert till AEM. AEM Developer Console genererar autentiseringsuppgifter som används av externa program, system och tjänster för att programmässigt interagera med AEM Author eller Publish services via HTTP.

>[!VIDEO](https://video.tv.adobe.com/v/330519/?quality=12&learn=on)

Den hämtade tjänstens autentiseringsuppgifter lagras som en resursfil med namnet service_token.json i den angivna förmörkelsen. Värdena i service_token-filen används för att generera JWT och för att byta ut JWT mot en Access-token. Verktygsklassen GetServiceCredentials används för att hämta egenskapsvärden från resursfilen service_token.json.
