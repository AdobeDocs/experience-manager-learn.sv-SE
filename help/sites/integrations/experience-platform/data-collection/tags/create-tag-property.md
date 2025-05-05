---
title: Skapa en taggegenskap
description: Lär dig hur du skapar en taggegenskap med lägsta möjliga konfiguration som kan integreras med AEM. Användare introduceras i tagggränssnittet och får lära sig mer om tillägg, regler och publiceringsarbetsflöden.
solution: Experience Manager, Data Collection, Experience Platform
jira: KT-5980
thumbnail: 38553.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: d5de62ef-a2aa-4283-b500-e1f7cb5dec3b
duration: 606
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '593'
ht-degree: 0%

---

# Skapa en taggegenskap {#create-tag-property}

Lär dig hur du skapar en taggegenskap med lägsta möjliga konfiguration som kan integreras med Adobe Experience Manager. Användare introduceras i tagggränssnittet och får lära sig mer om tillägg, regler och publiceringsarbetsflöden.

>[!VIDEO](https://video.tv.adobe.com/v/38553?quality=12&learn=on)

## Skapa taggegenskap

Om du vill skapa en taggegenskap följer du de här stegen.

1. Gå till [Adobe Experience Cloud Home](https://experience.adobe.com/)-sidan i webbläsaren och logga in med Adobe ID.

1. Klicka på programmet **Datainsamling** i avsnittet _Snabbåtkomst_ på Adobe Experience Cloud hemsida.

1. Klicka på menyobjektet **Taggar** i den vänstra navigeringen och klicka sedan på **Ny egenskap** i det övre högra hörnet.

1. Namnge taggegenskapen med det obligatoriska fältet **Namn**. I fältet Domäner anger du ditt domännamn eller om du använder AEM as a Cloud Service-miljön anger du `adobeaemcloud.com` och klickar på **Spara**.

   ![Taggegenskaper](assets/tag-properties.png)

## Skapa en ny regel

Öppna den nyligen skapade taggegenskapen genom att klicka på dess namn i vyn **Taggegenskaper** . Under rubriken _Min senaste aktivitet_ kan du även se att Core-tillägget har lagts till i det. Core-taggtillägget är standardtillägg och innehåller händelsetyper som sidinläsning, webbläsare, formulär och andra händelsetyper. Mer information finns i [Översikt över kärntillägg](https://experienceleague.adobe.com/docs/experience-platform/tags/extensions/client/core/overview.html?lang=sv-SE).

Med regler kan du ange vad som ska hända när besökaren interagerar med AEM. För att förenkla saker och ting loggar vi två meddelanden till webbläsarkonsolen för att visa hur integrering av datainsamling och taggar kan mata in JavaScript-kod i AEM utan att uppdatera AEM projektkod.

Om du vill skapa en regel följer du de här stegen.

1. Klicka på **Regler** i avsnittet _REDIGERING_ i den vänstra navigeringen och klicka sedan på **Skapa ny regel**

1. Namnge regeln med det obligatoriska fältet **Namn**.

1. Klicka på **Lägg till** i avsnittet _HÄNDELSER_ och sedan i formuläret _Händelsekonfiguration_ i listrutan **Händelsetyp**, markera alternativet _Bibliotek inläst (sidan överst)_ och klicka på **Behåll ändringar**.

1. Klicka på **Lägg till** i avsnittet _ÅTGÄRDER_, markera sedan alternativet _Egen kod_ i formuläret _Åtgärdskonfiguration_ i listrutan **Åtgärdstyp** och klicka på **Öppna redigerare**.

1. Ange följande JavaScript-kodfragment i _Redigera kod_, klicka sedan på **Spara** och slutligen på **Behåll ändringar**.

   ```javascript
   console.log('Tags Property loaded, all set for...');
   console.log('capabilities such as capturing data, conversion tracking and delivering unique and personalized experiences');
   ```

1. Klicka på **Spara** för att slutföra regelskapandeprocessen.

   ![Ny regel](assets/new-rule.png)

## Lägg till bibliotek och publicera det

Taggegenskapen _Regler_ aktiveras med ett bibliotek, tänk på biblioteket som ett paket som innehåller JavaScript-kod. Aktivera den nya regeln genom att följa stegen.

1. Klicka på **Publiceringsflöde** i avsnittet _PUBLISHING_ i den vänstra navigeringen och klicka sedan på **Lägg till bibliotek**

1. Namnge biblioteket med fältet **Namn** och välj alternativet _Utveckling(development)_ i listrutan **Miljö**.

1. Om du vill välja alla ändrade resurser sedan taggegenskapen skapades klickar du på **+ Lägg till alla ändrade resurser**. Den här åtgärden lägger till den nya regeln och kärntilläggsresursen i biblioteket. Klicka slutligen på **Spara och skapa till utveckling**.

1. När biblioteket har byggts för simbanan **Utveckling** väljer du _ellipsen_ **Skicka för godkännande**

1. I det **skickade** simbanor som använder _ellipser_ väljer du **Godkänn för publicering**, på samma sätt som **Skapa och Publish till produktion** i det **Godkänd** simbanan.

![Publicerat bibliotek](assets/published-library.png)


Ovanför steg slutförs den enkla taggegenskap som har en regel för att logga ett meddelande till webbläsarkonsolen när sidan läses in. Regeln och huvudtillägget publiceras också genom att ett bibliotek skapas.

## Nästa steg

[Anslut AEM med taggegenskap med IMS](connect-aem-tag-property-using-ims.md)


## Ytterligare resurser {#additional-resources}

* [Skapa en taggegenskap](https://experienceleague.adobe.com/docs/platform-learn/implement-in-websites/configure-tags/create-a-property.html?lang=sv-SE)
