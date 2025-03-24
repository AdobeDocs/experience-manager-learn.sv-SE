---
title: Navigera i kapslade paneler
description: Navigera i kapslade paneler
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-9335
exl-id: c60d019e-da26-4f67-8579-ef707e2348bb
last-substantial-update: 2019-07-07T00:00:00Z
duration: 264
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '247'
ht-degree: 0%

---

# Navigeringsflikar med flera paneler

När formuläret har lämnat navigeringsflikar och en av flikarna har flera paneler, kanske du vill dölja titeln för de underordnade panelerna och fortfarande kunna navigera mellan flikarna och de underordnade panelerna på dessa flikar

## Skapa anpassat formulär

Skapa ett anpassat formulär med följande struktur. Rotpanelen har underordnade paneler som visas som flikar till vänster. Vissa av dessa **flikar** har ytterligare underordnade paneler. Fliken Familj har till exempel två underordnade paneler som heter Mus och Barn.

Ett verktygsfält läggs också till under FormContainer med knapparna Föregående och Nästa

![verktygsfält-spacing](assets/multiple-panels.png)



Standardbeteendet för det här formuläret är att visa alla paneler till vänster och sedan navigera från en flik till en annan när du klickar på nästa knapp.

Om du vill ändra standardbeteendet måste du göra följande

>[!VIDEO](https://video.tv.adobe.com/v/338369?quality=12&learn=on)


Lägg till följande kod i click-händelsen för knappen **Nästa** med kodredigeraren

```javascript
window.guideBridge.setFocus(null, 'nextItemDeep', true);
```

Lägg till följande kod i click-händelsen för knappen **Prev** med kodredigeraren

```javascript
window.guideBridge.setFocus(null, 'prevItemDeep', true);
```

Koden ovan hjälper dig att navigera mellan flikarna och de underordnade panelerna på varje flik.

## Dölja den underordnade panelens rubrik

Använd formatredigeraren för att dölja titeln på flikarnas underordnade paneler.

>[!VIDEO](https://video.tv.adobe.com/v/338370?quality=12&learn=on)

>[!NOTE]
>
>Funktionen som beskrivs i den här artikeln fungerar inte på den sista fliken. Om fliken Adress till exempel har underordnade paneler fungerar inte den här funktionen.
