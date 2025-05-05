---
title: Använda Panorama och Vertical Image Viewer med AEM Assets Dynamic Media
description: Förbättringarna i Dynamic Media Viewer i AEM 6.4 innefattar även Panoramic Image Viewer, Panoramic Virtual Reality Image Viewer och Vertical Image Viewer. Panoramavisningsprogrammet är ett enkelt sätt att leverera en engagerande, engagerande upplevelse av rummet, egendomen, platsen eller landskapet utan att behöva ta fram något skräddarsytt.
feature: Video Profiles, Video Profiles, 360 VR Video
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
doc-type: Feature Video
exl-id: 6b2f7533-8ce0-4134-b1ae-b3c5d15a05e6
duration: 535
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '518'
ht-degree: 0%

---

# Använda Panorama och Vertical Image Viewer med AEM Assets Dynamic Media{#using-panorama-and-vertical-image-viewer-with-aem-assets-dynamic-media}

Förbättringarna i Dynamic Media Viewer i AEM 6.4 innefattar även Panoramic Image Viewer, Panoramic Virtual Reality Image Viewer och Vertical Image Viewer. Panoramavisningsprogrammet är ett enkelt sätt att leverera en engagerande, engagerande upplevelse av rummet, egendomen, platsen eller landskapet utan att behöva ta fram något skräddarsytt.

>[!VIDEO](https://video.tv.adobe.com/v/24156?quality=12&learn=on)

>[!NOTE]
>
>I videon antas att din AEM-instans körs i läget Dynamic Media S7. [Instruktioner för hur du konfigurerar AEM med Dynamic Media finns här.](https://helpx.adobe.com/se/experience-manager/6-3/assets/using/config-dynamic-fp-14410.html)

## VR-visningsprogram för panoramor och panoramor

En bild betraktas som panoramabild baserat på dess proportioner eller nyckelord. Som standard betraktas en bild med proportionerna 2 som en panoramabild. Förinställningar för panoramabildsvisningsprogram blir tillgängliga för förhandsvisningar av bilder om de uppfyller villkoren ovan. Proportionerna för panoramabilder kan ändras i företagets DMS7-konfiguration genom att du anger den dubbla egenskapen s7PanoramicAR på /conf/global/settings/cloudconfigs/dmscene7/jcr:content. Nyckelorden lagras i egenskapen dc:keyword i objektets metadatanod. Om nyckelorden innehåller någon av följande kombinationer:

* ekvirektangulära,
* sfärisk + panoramabild,
* sfärisk + panorama,

den betraktas som en panoramabild oavsett dess proportioner.

## Lodrät bildvisare

Med vågräta färgrutor, beroende på konsumentens skärmstorlek, kan det hända att färgrutorna inte visas förrän användaren rullar nedåt på sidan. Genom att använda lodrätt bildvisningsprogram och placera lodräta färgrutor ser det till att färgrutorna är synliga oavsett skärmstorleken. Den maximerar också huvudbildens storlek. Med vågräta färgrutor var det nödvändigt att reservera utrymme på sidan för att säkerställa att de med stor sannolikhet är synliga och skulle minska storleken på huvudbilden. Med en lodrät layout behöver du inte bekymra dig om att tilldela detta utrymme och kan därför maximera huvudbildstorleken.

<table> 
 <tbody>
  <tr>
   <td> </td>
   <td>Panorama och VR Viewer</td>
   <td>Lodrät bildvisare</td>
  </tr>
  <tr>
   <td>Körningsläge för dynamiska media</td>
   <td>Endast Dynamic Media Scene7-läge</td>
   <td>DMS7 och Dynamic Media</td>
  </tr>
  <tr>
   <td>Användningsfall</td>
   <td><p>Panoramavisningsprogram och Virtual Reality-visningsprogram ger användarna en mer engagerande upplevelse. Användaren kan checka ut ett hotellrum innan han eller hon bokar, eller checka ut en uthyrningsfastighet utan att behöva boka in ett möte. En användare kan kolla in en plats och många fler möjligheter. Det främsta målet här är att ge konsumenterna en bättre upplevelse när de besöker er webbplats och så småningom öka konverteringsgraden.</p> <p> </p> </td> 
   <td><p>Vertical Image Viewer hjälper till att maximera produktbildernas visningsupplevelse och ge konsumenterna bästa möjliga representation av produkten, vilket driver konverteringen och minimerar avkastningen.</p> <p> </p> </td>
  </tr>
  <tr>
   <td>Tillgänglig </td>
   <td>OTB</td>
   <td>OTB</td>
  </tr>
 </tbody>
</table>

[Konfigurera dynamiska media i Scene7-läge](https://helpx.adobe.com/se/experience-manager/6-5/assets/using/config-dms7.html)

[Konfigurera dynamiska media i hybridläge](https://helpx.adobe.com/se/experience-manager/6-5/assets/using/config-dynamic.html)

>[!NOTE]
>
>Panoramaviseringsprogram fungerar med panoramabilder och ska inte användas med normala bilder.
