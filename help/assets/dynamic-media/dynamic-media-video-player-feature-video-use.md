---
title: Använda videospelaren i AEM Dynamic Media
seo-title: Använda videospelaren i AEM Dynamic Media
description: AEM Dynamic Media-videospelaren som använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter och webbläsare blev mer aggressiva när det gäller flashbaserad innehållsströmning. I och med lanseringen av HLS (Apples leveransprotokoll för HTTP-direktuppspelning) kan innehållet nu direktuppspelas utan att förlita sig på flash.
seo-description: AEM Dynamic Media-videospelaren som använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter och webbläsare blev mer aggressiva när det gäller flashbaserad innehållsströmning. I och med lanseringen av HLS (Apples leveransprotokoll för HTTP-direktuppspelning) kan innehållet nu direktuppspelas utan att förlita sig på flash.
uuid: aac6f471-4bed-4773-890f-0dd2ceee381d
discoiquuid: b01cc46b-ef64-4db9-b3b4-52d3f27bddf5
sub-product: dynamiska medier
feature: media-player, video-profiles
topics: videos, renditions, authoring, best-practices
doc-type: feature video
audience: all
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 9cf01dbf9461df4cc96d5bd0a96c0d4d900af089
workflow-type: tm+mt
source-wordcount: '271'
ht-degree: 0%

---


# Använda videospelaren i AEM Dynamic Media{#using-the-video-player-in-aem-dynamic-media}

AEM Dynamic Media-videospelaren som använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter och webbläsare blev mer aggressiva när det gäller flashbaserad innehållsströmning. I och med lanseringen av HLS (Apples leveransprotokoll för HTTP-direktuppspelning) kan innehållet nu direktuppspelas utan att förlita sig på flash.

>[!VIDEO](https://video.tv.adobe.com/v/16791/?quality=9&learn=on)

## Snabb sökning i videospelare utan Flash {#quick-look-into-non-flash-video-player}

>[!VIDEO](https://video.tv.adobe.com/v/17429/?quality=9&learn=on)

Stöd för HLS-webbläsare är följande, för webbläsare som inte stöds används progressiv videoleverans

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