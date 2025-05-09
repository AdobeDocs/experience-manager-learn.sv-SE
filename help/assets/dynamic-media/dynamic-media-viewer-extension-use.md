---
title: Använda Dynamic Media Viewer med Adobe Analytics och taggar
description: Med tillägget Dynamic Media Viewers för taggar, tillsammans med releasen av Dynamic Media Viewers 5.13, kan kunder som använder Dynamic Media, Adobe Analytics och taggar använda händelser och data som är specifika för Dynamic Media Viewers i sin taggkonfiguration.
sub-product: Dynamic Media
feature: Asset Insights
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
doc-type: Feature Video
exl-id: 9d807f4c-999c-45e6-a9db-6c1776bddda1
duration: 576
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '325'
ht-degree: 0%

---

# Använda Dynamic Media Viewer med Adobe Analytics och taggar{#using-dynamic-media-viewers-adobe-analytics-tags}

För kunder med Dynamic Media och Adobe Analytics kan du nu spåra användningen av Dynamic Media Viewer på din webbplats med hjälp av Dynamic Media Viewer Extension.

>[!VIDEO](https://video.tv.adobe.com/v/29308?quality=12&learn=on)

>[!NOTE]
>
> Kör Adobe Experience Manager i Dynamic Media Scene7-läge för den här funktionen. Du måste också [integrera taggar med din AEM-instans](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html?lang=sv-SE).

I och med lanseringen av tillägget Dynamic Media Viewer har Adobe Experience Manager nu avancerade analysstöd för material som levereras med Dynamic Media Viewer (5.13), vilket ger mer detaljkontroll över händelsespårningen när en Dynamic Media Viewer används på en Sites-sida.

Om du redan har AEM Assets och Sites kan du integrera taggegenskaperna med AEM författarinstans. När startintegreringen är kopplad till webbplatsen kan du lägga till dynamiska mediekomponenter på sidan med händelsespårning för visningsprogram aktiverat.

För kunder som bara har AEM Assets eller Dynamic Media Classic kan användare hämta inbäddningskod för ett visningsprogram och lägga till den på sidan. Skriptbibliotek för taggar kan sedan läggas till manuellt på sidan för spårning av visningshändelser.

I följande tabell visas Dynamic Media Viewer-händelser och deras argument som stöds:

<table>
   <tbody>
      <tr>
         <td>Namn på visningsprogramhändelse</td>
         <td>Argumentreferens</td>
      </tr>
      <tr>
         <td> VANLIG </td>
         <td> %event.detail.dm.objID% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.compClass% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.instName% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.timeStamp% </td>
      </tr>
      <tr>
         <td> BANNER <br></td>
         <td> %event.detail.dm.BANER.asset% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.BANER.frame% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.BANER.label% </td>
      </tr>
      <tr>
         <td> HREF </td>
         <td> %event.detail.dm.HREF.rollover% </td>
      </tr>
      <tr>
         <td> OBJEKT </td>
         <td> %event.detail.dm.ITEM.rollover% </td>
      </tr>
      <tr>
         <td> LADDA </td>
         <td> %event.detail.dm.LOAD.applicationname% </td>
      </tr>
      <tr>
         <td><strong> </strong></td>
         <td> %event.detail.dm.LOAD.asset% </td>
      </tr>
      <tr>
         <td><strong> </strong></td>
         <td> %event.detail.dm.LOAD.company% </td>
      </tr>
      <tr>
         <td><strong> </strong></td>
         <td> %event.detail.dm.LOAD.sdkversion% </td>
      </tr>
      <tr>
         <td><strong> </strong></td>
         <td> %event.detail.dm.LOAD.viewertype% </td>
      </tr>
      <tr>
         <td><strong> </strong></td>
         <td> %event.detail.dm.LOAD.viewerversion% </td>
      </tr>
      <tr>
         <td> METADATA </td>
         <td> %event.detail.dm.METADATA.length% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.METADATA.type% </td>
      </tr>
      <tr>
         <td> MILESTON </td>
         <td> %event.detail.dm.MILESTONE.milestone% </td>
      </tr>
      <tr>
         <td> SIDA </td>
         <td> %event.detail.dm.PAGE.frame% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.PAGE.label% </td>
      </tr>
      <tr>
         <td> PAUS </td>
         <td> %event.detail.dm.PAUSE.timestamp% </td>
      </tr>
      <tr>
         <td> SPELA </td>
         <td> %event.detail.dm.PLAY.timestamp% </td>
      </tr>
      <tr>
         <td> SPIN </td>
         <td> %event.detail.dm.SPIN.framenumber% </td>
      </tr>
      <tr>
         <td> STOP </td>
         <td> %event.detail.dm.STOP.timestamp% </td>
      </tr>
      <tr>
         <td> SWAP </td>
         <td> %event.detail.dm.SWAP.asset% </td>
      </tr>
      <tr>
         <td> FÄRGRUTA </td>
         <td> %event.detail.dm.SWATCH.frame% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.SWATCH.label% </td>
      </tr>
      <tr>
         <td> TARG </td>
         <td> %event.detail.dm.TARG.frame% </td>
      </tr>
      <tr>
         <td> </td>
         <td> %event.detail.dm.TARG.label% </td>
      </tr>
      <tr>
         <td> ZOOMA </td>
         <td> %event.detail.dm.ZOOM.scale% </td>
      </tr>
   </tbody>
</table>

## Ytterligare resurser{#additional-resources}

* [Integrera AEM med taggar i Adobe Experience Platform](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html?lang=sv-SE)
* [Kör Adobe Experience Manager i läget Dynamic Media Scene7](https://experienceleague.adobe.com/docs/experience-manager-65/assets/dynamic/config-dms7.html?lang=sv-SE)
* [Integrera dynamiska medievisningsprogram med Adobe Analytics med hjälp av taggar](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/dynamic-media/dynamic-media-viewer-extension-use.html?lang=sv-SE)
