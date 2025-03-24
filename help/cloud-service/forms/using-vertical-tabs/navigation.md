---
title: Använda lodräta tabbar i AEM Forms as a Cloud Service
description: Skapa ett adaptivt formulär med hjälp av lodräta flikar
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
thumbnail: 331891.jpg
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16023
exl-id: c5bbd35e-fd15-4293-901e-c81faf6025f9
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '111'
ht-degree: 0%

---

# Navigera mellan flikarna

Du kan navigera mellan flikarna genom att klicka på de enskilda flikarna eller genom att använda föregående och nästa knappar i formuläret.
Om du vill navigera med knappar lägger du till två knappar i formuläret och ger dem namnen Föregående och Nästa. Koppla följande anpassade funktion till click-händelsen för knappen för att navigera mellan flikarna.

Här följer den anpassade funktionen som används för att navigera mellan flikarna.



```javascript
/**
 * Navigate in panel with focusOption
 * @name navigateInPanelWithFocusOption
 * @param {object} panelField
 * @param {string} focusOption - values can be 'nextItem'/'previousItem'
 * @param {scope} globals
 */
function navigateInPanelWithFocusOption(panelField, focusOption, globals)
{
    globals.functions.setFocus(panelField, focusOption);
}
```

Följande är regelredigeraren för knapparna Nästa och Föregående

**Nästa knapp**

![nästa knapp](assets/next-button.png)

**Föregående knapp**

![föregående-knapp](assets/prev-button.png)
