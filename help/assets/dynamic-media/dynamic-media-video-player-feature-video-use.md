---
title: Använda videospelaren i AEM Dynamic Media
description: AEM Dynamic Media-videospelare som använde Flash-miljön för att stödja adaptiv videoströmning på skrivbordsklienter och webbläsare blev mer aggressiva när det gäller Flash-baserad innehållsströmning. I och med lanseringen av HLS (Apple HTTP Live Streaming video delivery protocol) kan man nu strömma material utan att behöva använda flash.
feature: Video Profiles
version: Experience Manager 6.4, Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
doc-type: Feature Video
exl-id: 7e4cb782-836d-4ec0-97d0-645b91ea43e0
duration: 568
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '265'
ht-degree: 0%

---


# Använda videospelaren i AEM Dynamic Media{#using-the-video-player-in-aem-dynamic-media}

AEM Dynamic Media-videospelare som använde Flash-miljön för att stödja adaptiv videoströmning på skrivbordsklienter och webbläsare blev mer aggressiva när det gäller Flash-baserad innehållsströmning. I och med lanseringen av HLS (Apple HTTP Live Streaming video delivery protocol) kan man nu strömma material utan att behöva använda flash.

>[!VIDEO](https://video.tv.adobe.com/v/16791?quality=12&learn=on)

## Snabb sökning i icke-Flash Video Player {#quick-look-into-non-flash-video-player}

>[!VIDEO](https://video.tv.adobe.com/v/17429?quality=12&learn=on)

Stöd för webbläsare i HLS är följande för webbläsare som inte stöds: vi övergår till progressiv videoutgång

>[!NOTE]
>
> Dynamic Media Hybrid stöder INTE direktuppspelad video i Internet Explorer 11 från och med 15 mars 2022. Uppgradera till 6.5.12 eller senare för att återgå till progressiv uppspelning på IE 11.

<table> 
 <thead> 
  <tr> 
   <th> <p>Enhet</p> </th>
   <th> <p>Webbläsare</p> </th>
   <th > <p>Videouppspelningsläge</p> </th>
  </tr>
 </thead>
 <tbody>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Internet Explorer 9 och 10</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr>
   <td> <p>Skrivbord</p> </td>
   <td> <p>Internet Explorer 11+</p> </td>
   <td> <p>Dynamiska media - Scen 7-läge: HLS direktuppspelad video</p> 
        <p>Dynamiska media - hybridläge: Progressiv nedladdning</p>
   </td>
  </tr>
  <tr>
   <td> <p>Skrivbord</p> </td>
   <td> <p>Firefox 23-44</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Firefox 45 eller senare</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Chrome</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Safari (Mac)</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Chrome (Android 6 eller tidigare)</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Chrome (Android 7 eller senare)</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Android (standardwebbläsare)</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Safari (iOS)</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Chrome (iOS)</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Blackberry</p> </td>
   <td> <p>HLS direktuppspelad video</p> </td>
  </tr>
 </tbody>
</table>
