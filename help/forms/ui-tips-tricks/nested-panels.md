---
title: Navigera i kapslade paneler
description: Navigera i kapslade paneler
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: 9335
exl-id: c60d019e-da26-4f67-8579-ef707e2348bb
last-substantial-update: 2019-07-07T00:00:00Z
source-git-commit: 7a2bb61ca1dea1013eef088a629b17718dbbf381
workflow-type: tm+mt
source-wordcount: '247'
ht-degree: 0%

---

# Navigeringsflikar med flera paneler

När formuläret har lämnat navigeringsflikar och en av flikarna har flera paneler, kanske du vill dölja titeln för de underordnade panelerna och fortfarande kunna navigera mellan flikarna och de underordnade panelerna på dessa flikar

## Skapa anpassat formulär

Skapa ett anpassat formulär med följande struktur. Rotpanelen har underordnade paneler som visas som flikar till vänster. Några av dessa &quot;**tabbar**&quot; har ytterligare underordnade paneler. Fliken Familj har till exempel två underordnade paneler som heter Mus och Barn.

Ett verktygsfält läggs också till under FormContainer med knapparna Föregående och Nästa

![verktygsfältsavstånd](assets/multiple-panels.png)



Standardbeteendet för det här formuläret är att visa alla paneler till vänster och sedan navigera från en flik till en annan när du klickar på nästa knapp.

Om du vill ändra det här standardbeteendet måste du göra följande

>[!VIDEO](https://video.tv.adobe.com/v/338369?quality=9&learn=on)


Lägg till följande kod i click-händelsen för **Nästa** med kodredigeraren

```javascript
window.guideBridge.setFocus(null, 'nextItemDeep', true);
```

Lägg till följande kod i click-händelsen för **Föregående** med kodredigeraren

```javascript
window.guideBridge.setFocus(null, 'prevItemDeep', true);
```

Koden ovan hjälper dig att navigera mellan flikarna och de underordnade panelerna på varje flik.

## Dölja den underordnade panelens rubrik

Använd formatredigeraren för att dölja titeln på flikarnas underordnade paneler.

>[!VIDEO](https://video.tv.adobe.com/v/338370?quality=9&learn=on)

>[!NOTE]
>
>Funktionen som beskrivs i den här artikeln fungerar inte på den sista fliken. Om fliken Adress till exempel har underordnade paneler fungerar inte den här funktionen.
