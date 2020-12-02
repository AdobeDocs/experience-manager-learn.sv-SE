---
title: Använda Dynamic Media Viewer med Adobe Analytics och Adobe Launch
seo-title: Använda Dynamic Media Viewer med Adobe Analytics och Adobe Launch
description: Med tillägget Dynamic Media Viewers för Adobe Launch, tillsammans med releasen av Dynamic Media Viewers 5.13, kan kunder som använder Dynamic Media, Adobe Analytics och Adobe Launch använda händelser och data som är specifika för Dynamic Media Viewers i Adobe Launch-konfigurationen.
seo-description: 'Med tillägget Dynamic Media Viewers för Adobe Launch, tillsammans med releasen av Dynamic Media Viewers 5.13, kan kunder som använder Dynamic Media, Adobe Analytics och Adobe Launch använda händelser och data som är specifika för Dynamic Media Viewers i Adobe Launch-konfigurationen. '
sub-product: dynamiska medier, analys
feature: asset-insights, media-player
topics: images, videos, renditions, authoring, integrations, publishing
doc-type: feature video
audience: all
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 9cf01dbf9461df4cc96d5bd0a96c0d4d900af089
workflow-type: tm+mt
source-wordcount: '411'
ht-degree: 2%

---


# Använda Dynamic Media Viewer med Adobe Analytics och Adobe Launch{#using-dynamic-media-viewers-adobe-analytics-launch}

För kunder med Dynamic Media och Adobe Analytics kan du nu spåra användningen av Dynamic Media Viewer på din webbplats med hjälp av Dynamic Media Viewer Extension.

>[!VIDEO](https://video.tv.adobe.com/v/29308/?quality=12&learn=on)

>[!NOTE]
>
> Kör Adobe Experience Manager i Dynamic Media Scene7-läge för den här funktionen. Du måste också [integrera Adobe Experience Platform Launch med din AEM](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/integrations/adobe-launch-integration-tutorial-understand.html).

I och med lanseringen av tillägget Dynamic Media Viewer har Adobe Experience Manager nu avancerade analysstöd för material som levereras med Dynamic Media Viewer (5.13), vilket ger mer detaljkontroll över händelsespårningen när en Dynamic Media Viewer används på en Sites-sida.

Om du redan har AEM Assets och Sites kan du integrera Launch-egenskapen med AEM författarinstans. När startintegreringen är kopplad till webbplatsen kan du lägga till dynamiska mediekomponenter på sidan med händelsespårning för visningsprogram aktiverat.

För kunder som bara har AEM Assets eller Dynamic Media Classic kan användaren hämta inbäddningskod för ett visningsprogram och lägga till den på sidan. Det går sedan att lägga till skriptbibliotek för att starta dem manuellt på sidan för att spåra visningsprogrammets händelser.

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

* [Integrera Adobe Experience Manager med Adobe Launch](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/integrations/adobe-launch-integration-tutorial-understand.html)
* [Köra Adobe Experience Manager i Scene7-läget Dynamic Media](https://helpx.adobe.com/experience-manager/6-5/assets/using/config-dms7.html)
* [Integrera Dynamic Media Viewers med Adobe Analytics och Adobe Launch](https://helpx.adobe.com/experience-manager/6-5/assets/using/launch.html)
