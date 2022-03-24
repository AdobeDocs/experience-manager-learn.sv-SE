---
title: AEM
description: Hämta autentiseringsuppgifter för tjänsten från AEM Developer Console.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
kt: 9980
source-git-commit: b7ff98dccc1381abe057a80b96268742d0a0629b
workflow-type: tm+mt
source-wordcount: '109'
ht-degree: 0%

---

# Tjänstautentiseringsuppgifter

Integrationer med AEM as a Cloud Service måste kunna autentiseras säkert till AEM. AEM Developer Console genererar autentiseringsuppgifter som används av externa program, system och tjänster för att programmässigt interagera med AEM Author eller Publish services via HTTP.

>[!VIDEO](https://video.tv.adobe.com/v/330519/?quality=12&learn=on)

Den hämtade tjänstens autentiseringsuppgifter lagras som en resursfil med namnet service_token.json i den angivna förmörkelsen. Värdena i service_token-filen används för att generera JWT och för att byta ut JWT mot en Access-token. Verktygsklassen GetServiceCredentials används för att hämta egenskapsvärden från resursfilen service_token.json.
