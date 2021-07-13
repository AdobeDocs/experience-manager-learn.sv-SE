---
title: Använda källfilsöversättning med AEM Assets
description: Med Adobe Experience Manager (AEM) Assets kan du identifiera resurser som delar gemensamma attribut och markera dem som relaterade med den nya funktionen Relaterade resurser. Det gör det även möjligt för användare att definiera en källa/härledd relation mellan resurser, vilket gör det enkelt för användarna att identifiera ursprunget för en resurs. När du kör ett översättningsarbetsflöde på en härledd resurs hämtas alla resurser som källfilen refererar till och inkluderas för översättning, vilket minskar arbetet med att underhålla flera platser.
version: 6.3, 6.4, 6.5
topic: Innehållshantering
role: User
level: Intermediate
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '287'
ht-degree: 0%

---


# Använda källfilsöversättning med AEM Assets {#using-source-file-translation-with-aem-assets}

Med Adobe Experience Manager (AEM) Assets kan du identifiera resurser som delar gemensamma attribut och markera dem som relaterade med den nya funktionen Relaterade resurser. Det gör det även möjligt för användare att definiera en källa/härledd relation mellan resurser, vilket gör det enkelt för användarna att identifiera ursprunget för en resurs. När du kör ett översättningsarbetsflöde på en härledd resurs hämtas alla resurser som källfilen refererar till och inkluderas för översättning, vilket minskar arbetet med att underhålla flera platser.

## Filhantering för flera resurser {#multisite-asset-source-file-management}

>[!VIDEO](https://video.tv.adobe.com/v/18331/?quality=9&learn=on)

Relaterade resurser hjälper användarna att hantera bättre och mer länkade resurser med delade egenskaper, egenskaper och smidiga arbetsflöden:

* Ny funktion för relaterade tillgångar för att manuellt relatera tillgångar med liknande egenskaper eller som tillhör samma kampanj eller projekt
* Användaren kan visa relaterade filer för en resurs under Visa egenskaper. En användare kan navigera till de relaterade filerna från fönstret för visningsegenskaper.
* Om egenskaperna för två relaterade resurser har ändrats kan användarna ta bort kopplingen för dessa resurser med alternativet Ej relaterat.
* När du försöker ta bort en relaterad resurs får du ett varningsmeddelande om den har andra relaterade resurser.
* När du kör ett översättningsarbetsflöde på en härledd relaterad resurs läggs de relaterade källfilerna till i översättningsarbetsflödet, vilket gör det enkelt för hantering av flera platser.