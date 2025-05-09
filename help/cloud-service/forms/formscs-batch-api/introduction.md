---
title: Dokumentgenerering med batch-API i AEM Forms CS
description: Konfigurera och utlösa batchåtgärder för att generera dokument.
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Output Service
topic: Development
exl-id: 165e2884-4399-4970-81ff-1f2f8b041a10
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
duration: 26
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '140'
ht-degree: 0%

---

# Introduktion

En gruppbegäran är där tiotals, hundratals eller tusentals liknande dokument genereras samtidigt. Exempel: Ett finansföretag kan generera kreditkortsräkningar som ska skickas till alla sina kunder.
API:er för gruppbearbetning (asynkrona API:er) är lämpliga för schemalagd hög genomströmning vid användning av flera dokumentgenereringar. Dessa API:er genererar dokument gruppvis. Till exempel telefonräkningar, kontoutdrag och förmånsräkningar som genereras varje månad.

Om du vill använda API:t för gruppåtgärd i AEM Forms CS krävs följande konfigurationer

1. Konfigurera Azure-lagringskonto
1. Skapa molnkonfiguration som baseras på Azure-lagring
1. Skapa konfiguration för batchdatalager
1. Kör batch-API:t

Vi rekommenderar att du lär dig mer om [API-dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/batch-api.yaml?lang=sv-SE) innan du fortsätter att använda den här självstudiekursen.
