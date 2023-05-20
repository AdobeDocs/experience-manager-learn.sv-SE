---
title: Rapportera inskickade formulärdatafält med Adobe Analytics
description: Integrera AEM Forms CS med Adobe Analytics för att rapportera formulärdatafält
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
kt: 12557
exl-id: 43665a1e-4101-4b54-a6e0-d189e825073e
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '180'
ht-degree: 0%

---

# Testa lösningen

Förhandsgranska och skicka formuläret med flera kombinationer av formulärvärden. Det kan ta upp till 30 minuter att se dina data i Adobe Analytics-rapporter. Datauppsättningar som ska fungera som props visas i rapporter tidigare än datauppsättningar som eVars.

## Report Suite

De formulärdata som samlas in i Adobe Analytics presenteras i donut-format

**Inlagor per stat**

![applicantsbystate](assets/donut.png)

Fältvalideringsfel

![field-validation-error](assets/donut-field-validation.png)

## Felsökning

Kontrollera att det adaptiva formuläret använder samma konfigurationsbehållare som innehåller startkonfigurationen för Adobe.

Så här bekräftar du att formuläret skickar data till Adobe Analytics:

* Öppna utvecklingsverktygen i webbläsaren.
* Ange följande text på konsolpanelen.

```javascript
_satellite.setDebug(true)
```

Interagera med formuläret och håll konsolfönstret öppet. Du borde se något liknande

![console-debug](assets/debug.png)

## Använd Adobe Experience Platform Debugger

Lägg till [AEP-felsökningstillägg](https://experienceleague.adobe.com/docs/experience-platform/debugger/home.html) till din webbläsare (du måste logga in) för att få mer felsökningsinformation

![platform-debugger](assets/platform-debugger.png)
