---
title: Introduktion till tema i Resursdelningskommentarer
description: Material för både funktionell och teknisk förståelse av Assets Share Commons
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
feature: Asset Distribution
role: Developer
level: Intermediate
last-substantial-update: 2022-06-22T00:00:00Z
doc-type: Tutorial
exl-id: b7d0b6b1-145a-4987-a9dc-7263efa4d9fb
duration: 734
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '106'
ht-degree: 0%

---

# Introduktion till tema i Resursdelningskommentarer {#asset-share-commons-theme}

En kort introduktion till temat i Resursdelningskommentarer. Videon går igenom processen att skapa ett nytt tema med ett anpassat färgschema.

>[!VIDEO](https://video.tv.adobe.com/v/20572?quality=12&learn=on)

I den här videon skapas ett nytt tema baserat på det mörka temat Resursdelningar. Färgschemat kommer att matcha en egen logotyp för att ge webbplatsen ett konsekvent utseende och känsla.

## Temavariabler

```java
/*******************************
         Theme Variables
*******************************/
 
/* Below is a condensed list of variables for easy updating of the theme */
 
/* Color Palette */
@primaryColor      : #560a63;
@secondaryColor    : #fc3096;
 
/* Text */
@fontName          : 'LatoWeb';
@fontSmoothing     : antialiased;
@headerFont        : @fontName, 'Helvetica Neue', Arial, Helvetica, sans-serif;
@pageFont          : @fontName, 'Helvetica Neue', Arial, Helvetica, sans-serif;
@textColor         : #D0D0D0;
 
 
/* Backgrounds */
@pageBackground      : #3C3C3C;
@sideBarBackground   : #363636;
 
/* Links */
@linkColor           : #FFFFFF;
@linkHoverColor      : @secondaryColor;
 
/* Buttons */
@buttonPrimaryColor      : #560a63; /* must be a value to prevent variable recursion*/
@buttonPrimaryColorHover : saturate(darken(@buttonPrimaryColor, 5), 10, relative);
 
/* Filters (Checkboxes,radio buttons, toggle, slider, dropdown, accordion colors)*/
@filterPrimaryColor      : @secondaryColor;
@filterPrimaryColorFocus : saturate(darken(@filterPrimaryColor, 5), 10, relative);
 
/* Label */
@labelPrimaryColor       : @primaryColor;
@labelPrimaryColorHover  : saturate(darken(@labelPrimaryColor, 5), 10, relative);
 
/* Menu */
@menuPrimaryColor        : @primaryColor;
 
/* Message */
@msgPositiveBackgroundColor : @secondaryColor;
@msgNegativeBackgroundColor : @red;
@msgInfoBackgroundColor: @midBlack;
@msgWarningBackgroundColor: @yellow;
```

Hämta [temat för anpassat klientbibliotek](assets/asc-theme-demo.zip)

## Ytterligare resurser{#additional-resources}

* [Kommentarer för resursdelning, versionshämtningar](https://github.com/Adobe-Marketing-Cloud/asset-share-commons/releases)
* [ACS AEM Commons 3.11.0+ nedladdningar](https://github.com/Adobe-Consulting-Services/acs-aem-commons/releases)
