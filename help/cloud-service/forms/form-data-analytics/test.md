---
title: Rapportera inskickade formulärdatafält med Adobe Analytics
description: Integrera AEM Forms CS med Adobe Analytics för att rapportera formulärdatafält
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Adaptive Forms
topic: Integrations, Development
jira: KT-12557
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: 43665a1e-4101-4b54-a6e0-d189e825073e
duration: 38
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '203'
ht-degree: 0%

---

# Testa lösningen

Förhandsgranska och skicka formuläret med flera kombinationer av formulärvärden. Det kan ta upp till 30 minuter att se dina data i Adobe Analytics-rapporter. Datauppsättningar som ska fungera som props visas i rapporter tidigare än datauppsättningar som eVars.

## Report Suite

De formulärdata som samlas in i Adobe Analytics presenteras i donut-format

**Sändningar per tillstånd**

![applicantsbystate](assets/donut.png)

Fältvalideringsfel

![field-validation-error](assets/donut-field-validation.png)

## Felsökning

Kontrollera att det adaptiva formuläret använder samma konfigurationsbehållare som innehåller Adobe Launch Configuration.

Så här bekräftar du att formuläret skickar data till Adobe Analytics:

* Öppna utvecklingsverktygen i webbläsaren.
* Ange följande text på konsolpanelen.

```javascript
_satellite.setDebug(true)
```

Interagera med formuläret och håll konsolfönstret öppet. Du borde se något liknande

![console-debug](assets/debug.png)

## Använd Adobe Experience Platform Debugger

Lägg till [AEP-felsökningstillägget](https://experienceleague.adobe.com/docs/experience-platform/debugger/home.html?lang=sv-SE) i webbläsaren (du måste logga in) för att få mer felsökningsinformation

![platform-debugger](assets/platform-debugger.png)

## Grattis

Du har nu integrerat AEM Forms as a Cloud Service med Adobe Analytics för att rapportera formulärdatafält.