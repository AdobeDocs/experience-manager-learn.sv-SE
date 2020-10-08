---
title: Personalisering av en hel webbsida - upplevelse
description: Lär dig hur du skapar en aktivitet som dirigerar om de webbsidor som finns på AEM till en ny sida med Adobe Target.
feature: targeting
topics: integrations, authoring, personalization, activity, offers
audience: all
doc-type: feature video
activity: use
version: cloud-service
kt: 6353
thumbnail: 6353-personalization-web-page.jpg
translation-type: tm+mt
source-git-commit: 7a830d5a04ce53014b86f9f05238dd64f79edffc
workflow-type: tm+mt
source-wordcount: '457'
ht-degree: 0%

---


# Personalisering av en hel webbsida - upplevelse {#personalization-fpe}

Lär dig hur du skapar en aktivitet som dirigerar om de webbsidor som finns på AEM till en ny sida med Adobe Target.

Innan du skapar en aktivitet i Target måste du konfigurera:

1. [Integrera Experience Platform Launch och AEM](https://docs.adobe.com/content/help/en/experience-manager-learn/sites/integrations/experience-platform-launch/overview.html)

## Scenarioöversikt

WKND:s webbplats har gjort om sin hemsida och vill dirigera om sina nuvarande besökare till den nya hemsidan. Samtidigt måste du också förstå hur den omdesignade startsidan kan förbättra användarengagemanget och intäkterna. Som marknadsförare har du tilldelats uppgiften att skapa en aktivitet som dirigerar om besökarna till den nya hemsidan. Låt oss utforska WKND:s hemsida och lära oss hur man skapar en aktivitet med Adobe Target.

## Steg för att skapa ett A/B-test med Visual Experience Composer (VEC)

1. Logga in på Adobe Target och navigera till aktivitetsfliken
1. Klicka på knappen **Skapa aktivitet** och välj sedan **A/B-testaktivitet**

   ![A/B-aktivitet](assets/ab-target-activity.png)

1. Välj alternativet **Visual Experience Composer** , ange aktivitets-URL:en och klicka sedan på **Nästa**

   ![Aktivitets-URL](assets/ab-test-url.png)

1. I Visual Experience Composer visas två flikar till vänster när du har skapat en ny aktivitet: *Upplev A* och *Experience B*. Välj en upplevelse i listan. Du kan lägga till nya upplevelser i listan genom att använda knappen **Lägg till upplevelse** .

   ![Experience Options](assets/experience-options.png)

1. Visa tillgängliga alternativ för Experience A och välj sedan alternativet **Omdirigera till URL** och ange en URL för den nya WKND-webbplatsens hemsida.

   ![Omdirigerings-URL](assets/redirect-url.png)

1. Byt namn på *upplevelse A* till *ny WKND-hemsida* och *upplevelse B* till *WKND-startsida*

   ![Annonser](assets/new-experiences.png)

1. Klicka på **Nästa** för att gå över till Riktning och behålla en manuell trafikallokering på 50-50 mellan de två upplevelserna.

   ![Målinriktning](assets/targeting.png)

1. För Mål och inställningar väljer du Rapporteringskällan som Adobe Target och väljer Mått som konvertering med en sidvisningsåtgärd.

   ![Mål](assets/goals.png)

1. Ange ett namn för aktiviteten och Spara.
1. Aktivera den sparade aktiviteten för att göra ändringarna tillgängliga.

   ![Mål](assets/activate.png)

1. Öppna din webbplatssida (Aktivitets-URL från steg 3) på en ny flik och du bör kunna visa någon av upplevelserna (WKND-hemsida eller Ny WKND-hemsida) från vår A/B-testaktivitet. `us/en.html` omdirigeras till `us/home.html`.

   ![Mål](assets/redirect-test.png)

## Sammanfattning

Som marknadsförare kunde du skapa en aktivitet för att dirigera om de webbsidor som finns på AEM till en ny sida med Adobe Target.

## Stödlänkar

* [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj)
* [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)

