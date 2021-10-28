---
title: Använda videospelaren i AEM Dynamic Media
description: AEM Dynamic Media videospelare använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter, och webbläsare blev mer aggressiva när det gäller Flash-baserad innehållsströmning. I och med lanseringen av HLS (Apple HTTP Live Streaming video delivery protocol) kan innehåll nu strömmas utan att förlita sig på flash.
sub-product: dynamic-media
feature: Video Profiles
version: 6.3, 6.4, 6.5
topic: Content Management
role: User
level: Beginner
exl-id: 7e4cb782-836d-4ec0-97d0-645b91ea43e0
source-git-commit: bd1fe0c1aa8883bcb9f92ec26c6fb2c9cac77c0a
workflow-type: tm+mt
source-wordcount: '223'
ht-degree: 0%

---


# Använda videospelaren i AEM Dynamic Media{#using-the-video-player-in-aem-dynamic-media}

AEM Dynamic Media videospelare använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter, och webbläsare blev mer aggressiva när det gäller Flash-baserad innehållsströmning. I och med lanseringen av HLS (Apple HTTP Live Streaming video delivery protocol) kan innehåll nu strömmas utan att förlita sig på flash.

>[!VIDEO](https://video.tv.adobe.com/v/16791/?quality=9&learn=on)

## Snabb sökning i videospelare utan Flash {#quick-look-into-non-flash-video-player}

>[!VIDEO](https://video.tv.adobe.com/v/17429/?quality=9&learn=on)

Stöd för HLS-webbläsare är följande, för webbläsare som inte stöds används progressiv videoleverans

>[!NOTE]
>
> Dynamic Media Hybrid stöder INTE Internet Explorer 11 efter maj 2022.

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
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr>
   <td> <p>Skrivbord</p> </td>
   <td> <p>Firefox 23-44</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Firefox 45 eller senare</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Krom</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr> 
   <td> <p>Skrivbord</p> </td>
   <td> <p>Safari (Mac)</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Chrome (Android 6 eller tidigare)</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Chrome (Android 7 eller senare)</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Android (standardwebbläsare)</p> </td>
   <td> <p>Progressiv nedladdning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Safari (iOS)</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Chrome (iOS)</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
  <tr> 
   <td> <p>Mobil</p> </td>
   <td> <p>Blackberry</p> </td>
   <td> <p>HLS-videoströmning</p> </td>
  </tr>
 </tbody>
</table>
