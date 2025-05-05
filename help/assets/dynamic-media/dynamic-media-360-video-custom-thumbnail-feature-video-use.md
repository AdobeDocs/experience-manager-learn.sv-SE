---
title: Använda Dynamic Media 360-videor och en anpassad videominiatyr med AEM Assets
description: Förbättringarna i Dynamic Media Viewer i AEM 6.5 innefattar stöd för 360-videoåtergivning, 360 medievyer (video360Social och video360VR) samt möjlighet att välja anpassade videominiatyrer.
feature: Video Profiles
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
doc-type: Feature Video
exl-id: 4ee0b68f-3897-4104-8615-9de8dbb8f327
duration: 656
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '394'
ht-degree: 0%

---

# Använda Dynamic Media 360-videor och en anpassad videominiatyr med AEM Assets

Förbättringarna i Dynamic Media Viewer i AEM 6.5 innefattar stöd för 360-videoåtergivning, 360 medievyer (video360Social och video360VR) samt möjlighet att välja anpassade videominiatyrer.

>[!VIDEO](https://video.tv.adobe.com/v/26391?quality=12&learn=on)

>[!NOTE]
>
>I videon antas att din AEM-instans körs i läget Dynamic Media S7.  [Instruktioner om hur du konfigurerar AEM med Dynamic Media finns här](https://helpx.adobe.com/se/experience-manager/6-3/assets/using/config-dynamic-fp-14410.html). När du överför en video bearbetar Dynamic Media som standard tagningen som en 360-video, om den har proportionerna 2:1. dvs. förhållandet mellan bredd och höjd är 2:1.

>[!NOTE]
>
>Dynamic Media 360 Media-komponenter har endast stöd för 360-videor.

## Dynamic Media 360-videor

360-gradersvideor, även kallade sfäriska videor, är videoinspelningar där en vy i alla riktningar spelas in samtidigt och spelas in med en omdirigerad kamera eller en samling kameror. Vid uppspelning på en platt skärm har användaren kontroll över visningsriktningen och uppspelning på mobila enheter utnyttjar vanligtvis den inbyggda gyroskopkontrollen.  Med den kan du utöka bortom gränserna för enstaka foton. Marknadsförarna kan ge användarna en engagerande upplevelse med hjälp av 360 videor.  Kom så sätter vi igång. Proportionerna för panoramabilder kan ändras i företagets DMS7-konfiguration genom att du anger den dubbla egenskapen s7PanoramicAR på /conf/global/settings/cloudconfigs/dmscene7/jcr:content.

## Dynamic Media 360-videor

Dynamic Media-video har nu stöd för möjligheten att välja en anpassad miniatyrbild för videon. Användaren kan antingen välja en befintlig resurs från AEM Assets eller välja en videobildruta som miniatyrbild.

## Dynamiska 360-medievyer

<table> 
 <tbody>
   <tr>
      <td> </td>
      <td>**Video360Social Viewer**</td>
      <td>**Video360VR Viewer**</td>
   </tr>
   <tr>
      <td>Körningsläge för dynamiska media</td>
      <td>Endast Dynamic Media Scene7-läge</td>
      <td>Dynamic Media Scene7 Mode only<br>
         <br>
      </td>
   </tr>
   <tr>
      <td>Användningsfall</td>
      <td>
         <p>För webbplatser och enheter som inte stöder gyroskop</p>
         <p> </p>
      </td>
      <td>
         <p>Ger en Virtual Reality-upplevelse för en enhet som stöder gyroskop </p>
      </td>
   </tr>
   <tr>
      <td>Ljud - stereoläge</td>
      <td>Nej</td>
      <td>Ja</td>
   </tr>
   <tr>
      <td>Videouppspelning</td>
      <td>Ja</td>
      <td>Ja</td>
   </tr>
   <tr>
      <td>Visningsnavigering</td>
      <td>
         <ul>
            <li>Musdra (på stationära datorer)</li>
            <li>Svep (touchenheter)</li>
         </ul>
      </td>
      <td>
         <ul>
            <li>Alternativ för mus och dra är inaktiverade</li>
            <li>Använder inbyggt gyroskop</li>
         </ul>
      </td>
   </tr>
   <tr>
      <td>HTML5 Player</td>
      <td>Ja</td>
      <td>Ja</td>
   </tr>
   <tr>
      <td>Alternativ för delning via sociala medier</td>
      <td>Ja</td>
      <td>Nej</td>
   </tr>
</tbody>
</table>

## Ytterligare resurser{#additional-resources}

[Konfigurera dynamiska media i Scene7-läge](https://helpx.adobe.com/se/experience-manager/6-5/assets/using/config-dms7.html)
