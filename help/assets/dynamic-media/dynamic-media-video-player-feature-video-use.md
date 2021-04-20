---
title: Använda videospelaren i AEM Dynamic Media
description: AEM Dynamic Media videospelare använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter, och webbläsare blev mer aggressiva när det gäller Flash-baserad innehållsströmning. I och med lanseringen av HLS (Apples leveransprotokoll för HTTP-direktuppspelning) kan innehållet nu direktuppspelas utan att förlita sig på flash.
sub-product: dynamiska medier
feature: Video Profiles
version: 6.3, 6.4, 6.5
topic: Content Management
role: Business Practitioner
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '221'
ht-degree: 0%

---


# Använda videospelaren i AEM Dynamic Media{#using-the-video-player-in-aem-dynamic-media}

AEM Dynamic Media videospelare använde Flash runtime för att stödja adaptiv videoströmning på skrivbordsklienter, och webbläsare blev mer aggressiva när det gäller Flash-baserad innehållsströmning. I och med lanseringen av HLS (Apples leveransprotokoll för HTTP-direktuppspelning) kan innehållet nu direktuppspelas utan att förlita sig på flash.

>[!VIDEO](https://video.tv.adobe.com/v/16791/?quality=9&learn=on)

## Snabb sökning i icke-Flash-videospelaren {#quick-look-into-non-flash-video-player}

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