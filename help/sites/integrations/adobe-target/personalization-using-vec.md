---
title: Personalisering med Visual Experience Composer
description: Lär dig hur du skapar en Adobe Target-aktivitet med Visual Experience Composer.
topics: integrations, authoring, personalization, activity, offers
audience: all
doc-type: feature video
activity: use
version: cloud-service
kt: 6352
thumbnail: 6352-personalization-using-vec.jpg
topic: Integreringar
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '521'
ht-degree: 0%

---


# Personalisering med Visual Experience Composer {#personalization-vec}

Lär dig hur du skapar en A/B Test Target-aktivitet med Visual Experience Composer (VEC).

## Förutsättningar

För att kunna använda VEC på en AEM webbplats måste följande inställningar göras:

1. [Lägg till Adobe Target på din AEM webbplats](./add-target-launch-extension.md)
1. [Starta ett Adobe Target-samtal från Launch](./load-and-fire-target.md)

## Scenarioöversikt

På WKND-webbplatsens hemsida visas lokala aktiviteter eller det bästa att göra runt en stad i form av informationskort. Som marknadsförare har du tilldelats uppgiften att ändra hemsidan genom att göra textändringar i äventyrsavsnittet och förstå hur konverteringen förbättras.

## Steg för att skapa ett A/B-test med Visual Experience Composer (VEC)

1. Logga in på [Adobe Experience Cloud](https://experience.adobe.com/), tryck på __Mål__, navigera till fliken __Aktiviteter__

   + Om du inte ser __Mål__ på kontrollpanelen Experience Cloud kontrollerar du att rätt Adobe-organisation är markerad i organisationsväljaren i det övre högra hörnet och att du har fått åtkomst till Target i [Adobe Admin Console](https://adminconsole.adobe.com/).

1. Klicka på knappen **Skapa aktivitet** och välj sedan **A/B Test** aktivitet

   ![A/B-aktivitet](assets/ab-target-activity.png)

1. Välj alternativet **Visual Experience Composer**, ange aktivitets-URL:en och klicka sedan på **Nästa**

   ![Aktivitets-URL](assets/ab-test-url.png)

1. I Visual Experience Composer visas två flikar till vänster när du har skapat en ny aktivitet: *Upplev A* och *Upplev B*. Välj en upplevelse i listan. Du kan lägga till nya upplevelser i listan genom att använda knappen **Lägg till upplevelse**.

   ![Upplevelse A](assets/experience.png)

1. Markera en bild eller text på sidan som du vill börja ändra, eller använd kodredigeraren för att välja och använda HTML-element.

   ![Element](assets/select-element.png)

1. Ändra texten från *Camping i Western Australia* till *Adventures of Australia*. En lista över ändringar som har lagts till i en upplevelse visas under Ändringar. Du kan klicka på och redigera det ändrade objektet för att visa dess CSS-väljare och det nya innehållet som lagts till i det.

   ![Annonser](assets/adventures.png)

1. Byt namn på *Upplev A* till *Adventure*
1. Uppdatera texten på *Experience B* från *Camping i Western Australia* till *Explore the Australian Wilderness*.

   ![Utforska](assets/explore.png)

1. Klicka på **Nästa** för att gå över till Riktning och låt oss behålla en manuell trafikallokering på 50-50 mellan de två upplevelserna.

   ![Målinriktning](assets/targeting.png)

1. För Mål och inställningar väljer du Rapporteringskällan som Adobe Target och väljer Mått som konvertering med en sidvisningsåtgärd.

   ![Mål](assets/goals.png)

1. Ange ett namn för aktiviteten och Spara.
1. Aktivera den sparade aktiviteten för att göra ändringarna tillgängliga.

   ![Mål](assets/activate.png)

1. Öppna din webbplatssida (Aktivitets-URL från steg 3) på en ny flik och du bör kunna visa någon av upplevelserna (Adventure eller Explore) från vår A/B-testaktivitet.

   ![Mål](assets/publish.png)

## Sammanfattning

I det här kapitlet kunde en marknadsförare skapa en upplevelse med Visual Experience Composer genom att dra och släppa, byta och ändra layouten och innehållet på en webbsida utan att ändra någon kod för att köra ett test.

## Stödlänkar

+ [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj)
+ [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)
