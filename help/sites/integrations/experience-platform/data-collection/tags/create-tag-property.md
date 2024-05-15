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

1. I webbläsaren går du till [Adobe Experience Cloud Home](https://experience.adobe.com/) och logga in med Adobe ID.

1. Klicka på **Datainsamling** från _Snabb åtkomst_ på Adobe Experience Cloud hemsida.

1. Klicka på **Taggar** menyalternativ från den vänstra navigeringen och klicka sedan på **Ny egenskap** från det övre högra hörnet.

1. Namnge taggegenskapen med **Namn** obligatoriskt fält. För fältet Domäner anger du domännamnet eller om AEM as a Cloud Service miljön anger `adobeaemcloud.com` och klicka **Spara**.

   ![Taggegenskaper](assets/tag-properties.png)

## Skapa en ny regel

Öppna den nyligen skapade taggegenskapen genom att klicka på dess namn i dialogrutan **Taggegenskaper** vy. Även under _Min senaste aktivitet_ som du ser att Core-tillägget har lagts till. Core-taggtillägget är standardtillägget och innehåller händelsetyper som sidinläsning, webbläsare, formulär och andra händelsetyper, se [Översikt över Core Extension](https://experienceleague.adobe.com/docs/experience-platform/tags/extensions/client/core/overview.html) för mer information.

Med regler kan du ange vad som ska hända när besökaren interagerar med AEM. För att förenkla saker och ting loggar vi två meddelanden till webbläsarkonsolen för att visa hur datainsamling Tagg-integrering kan mata in JavaScript-kod i AEM utan att uppdatera AEM projektkod.

Om du vill skapa en regel följer du de här stegen.

1. Klicka **Regler** från _REDIGERA_ till vänster och klicka sedan på **Skapa ny regel**

1. Namnge regeln med **Namn** obligatoriskt fält.

1. Klicka **Lägg till** från _HÄNDELSER_ -avsnittet, sedan i _Händelsekonfiguration_ formulär, i **Händelsetyp** listruteväljare _Bibliotek inläst (sidan ovanpå)_ och klicka **Behåll ändringar**.

1. Klicka **Lägg till** från _ÅTGÄRDER_ -avsnittet, sedan i _Åtgärdskonfiguration_ formulär, i **Åtgärdstyp** listruteväljare _Egen kod_ och klicka **Öppna redigeraren**.

1. I _Redigera kod_ modal, ange följande JavaScript-kodfragment och klicka sedan på **Spara** och slutligen klicka **Behåll ändringar**.

   ```javascript
   console.log('Tags Property loaded, all set for...');
   console.log('capabilities such as capturing data, conversion tracking and delivering unique and personalized experiences');
   ```

1. Klicka **Spara** för att slutföra regelskapandet.

   ![Ny regel](assets/new-rule.png)

## Lägg till bibliotek och publicera det

Egenskapen Tagg _Regler_ aktiveras med ett bibliotek, tänk på biblioteket som ett paket som innehåller JavaScript-kod. Aktivera den nya regeln genom att följa stegen.

1. Klicka **Publiceringsflöde** från _PUBLICERING_ till vänster och klicka sedan på **Lägg till bibliotek**

1. Namnge biblioteket med **Namn** fält och markera _Utveckling_ alternativ för **Miljö** nedrullningsbar meny.

1. Om du vill välja alla ändrade resurser sedan taggegenskapen skapades klickar du på **+ Lägg till alla ändrade resurser**. Den här åtgärden lägger till den nya regeln och kärntilläggsresursen i biblioteket. Klicka till sist **Spara och bygg till utveckling**.

1. När biblioteket har byggts för **Utveckling** simbana, använda _ellipser_ välj **Skicka för godkännande**

1. Sedan i **Skickat** simbana med _ellipser_ välj **Godkänn för publicering**, på samma sätt **Bygg och publicera i produktion** i **Godkänd** simbana.

![Publicerat bibliotek](assets/published-library.png)


Ovanför steg slutförs den enkla taggegenskap som har en regel för att logga ett meddelande till webbläsarkonsolen när sidan läses in. Regeln och huvudtillägget publiceras också genom att ett bibliotek skapas.

## Nästa steg

[Anslut AEM med taggegenskap med IMS](connect-aem-tag-property-using-ims.md)


## Ytterligare resurser {#additional-resources}

* [Skapa en taggegenskap](https://experienceleague.adobe.com/docs/platform-learn/implement-in-websites/configure-tags/create-a-property.html)
