---
title: Personalisering av en hel webbsida - upplevelse
description: Lär dig hur du skapar en Target-aktivitet för att dirigera om dina AEM webbsidor till nya sidor med Adobe Target.
topics: integrations, authoring, personalization, activity, offers
audience: all
doc-type: feature video
activity: use
version: Cloud Service
kt: 6353
thumbnail: 6353-personalization-web-page.jpg
topic: Integrations
role: Developer
level: Intermediate
exl-id: 2d201b48-c0fb-4bb4-a7d8-da9f4702e9ff
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '461'
ht-degree: 0%

---

# Personalisering av en hel webbsida - upplevelse {#personalization-fpe}

Lär dig hur du skapar en aktivitet som dirigerar om de webbsidor som finns på AEM till en ny sida med Adobe Target.

## Förutsättningar

För att personalisera hela sidor på en AEM webbplats måste följande inställningar göras:

1. [Lägg till Adobe Target på din AEM webbplats](./add-target-launch-extension.md)
1. [Starta ett Adobe Target-samtal från Launch](./load-and-fire-target.md)

## Scenarioöversikt

WKND:s webbplats har gjort om sin hemsida och vill dirigera om sina nuvarande besökare till den nya hemsidan. Samtidigt måste du också förstå hur den omdesignade startsidan kan förbättra användarengagemanget och intäkterna. Som marknadsförare har du tilldelats uppgiften att skapa en aktivitet som dirigerar om besökarna till den nya hemsidan. Låt oss utforska WKND:s hemsida och lära oss hur man skapar en aktivitet med Adobe Target.

## Steg för att skapa ett A/B-test med Visual Experience Composer (VEC)

1. Logga in på Adobe Target och navigera till aktivitetsfliken
1. Klicka **Skapa aktivitet** och sedan välja **A/B-test** aktivitet

   ![A/B-aktivitet](assets/ab-target-activity.png)

1. Välj **Visual Experience Composer** anger du aktivitets-URL:en och klickar sedan på **Nästa**

   ![Aktivitets-URL](assets/ab-test-url.png)

1. I Visual Experience Composer visas två flikar till vänster när du har skapat en ny aktivitet: *Upplevelse A* och *Upplevelse B*. Välj en upplevelse i listan. Du kan lägga till nya upplevelser i listan genom att använda **Lägg till upplevelse** -knappen.

   ![Experience Options](assets/experience-options.png)

1. Visa tillgängliga alternativ för Experience A och välj sedan **Omdirigera till URL** och ange en URL för den nya WKND-webbplatsens hemsida.

   ![Omdirigerings-URL](assets/redirect-url.png)

1. Byt namn *Upplevelse A* till *Ny WKND-startsida* och *Upplevelse B* till *WKND - startsida*

   ![Annonser](assets/new-experiences.png)

1. Klicka **Nästa** för att gå över till målinriktning och behålla en manuell trafiktilldelning på 50-50 mellan de två upplevelserna.

   ![Målinriktning](assets/targeting.png)

1. För Mål och inställningar väljer du Rapporteringskällan som Adobe Target och väljer Mått som konvertering med en sidvisningsåtgärd.

   ![Mål](assets/goals.png)

1. Ange ett namn för aktiviteten och Spara.
1. Aktivera den sparade aktiviteten för att göra ändringarna tillgängliga.

   ![Mål](assets/activate.png)

1. Öppna din webbplatssida (Aktivitets-URL från steg 3) på en ny flik och du bör kunna visa någon av upplevelserna (WKND-hemsida eller Ny WKND-hemsida) från vår A/B-testaktivitet. `us/en.html` omdirigerar till `us/home.html`.

   ![Mål](assets/redirect-test.png)

## Sammanfattning

Som marknadsförare kunde du skapa en aktivitet för att dirigera om de webbsidor som finns på AEM till en ny sida med Adobe Target.

## Stödlänkar

* [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj)
* [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)
