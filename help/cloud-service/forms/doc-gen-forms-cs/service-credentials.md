---
title: Autentiseringsuppgifter för AEM Forms
description: Hämta tjänstens autentiseringsuppgifter från AEM Developer Console.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-8192
thumbnail: 330519.jpg
exl-id: 74cb8c30-4c41-426c-a1b5-fc595a3167c8
duration: 453
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '109'
ht-degree: 0%

---

# Autentiseringsuppgifter för AEM Forms

Integrationer med AEM as a Cloud Service måste kunna autentiseras säkert för AEM. AEM Developer Console genererar inloggningsuppgifter som används av externa program, system och tjänster för att interagera programmatiskt med AEM Author eller Publish-tjänster via HTTP.

>[!VIDEO](https://video.tv.adobe.com/v/330519?quality=12&learn=on)

Den hämtade tjänstens autentiseringsuppgifter lagras som en resursfil med namnet service_token.json i den angivna förmörkelsen. Värdena i service_token-filen används för att generera JWT och för att byta ut JWT mot en Access-token. Verktygsklassen GetServiceCredentials används för att hämta egenskapsvärden från resursfilen service_token.json.
