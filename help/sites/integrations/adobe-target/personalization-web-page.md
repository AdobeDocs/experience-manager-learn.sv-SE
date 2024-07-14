---
title: Personalization of full web page Experience
description: Lär dig hur du skapar en Target-aktivitet för att dirigera om dina AEM webbsidor till nya sidor med Adobe Target.
jira: KT-6353
thumbnail: 6353-personalization-web-page.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 2d201b48-c0fb-4bb4-a7d8-da9f4702e9ff
duration: 89
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '454'
ht-degree: 0%

---

# Personalization of full web page Experience {#personalization-fpe}

Lär dig hur du skapar en aktivitet som dirigerar om de webbsidor som finns på AEM till en ny sida med Adobe Target.

## Förutsättningar

Om du vill anpassa kompletta sidor på en AEM webbplats måste du slutföra följande konfiguration:

1. [Lägg till Adobe Target på din AEM webbplats](./add-target-launch-extension.md)
1. [Utlös ett Adobe Target-samtal från taggar](./load-and-fire-target.md)

## Scenarioöversikt

WKND:s webbplats har gjort om sin hemsida och vill dirigera om sina nuvarande besökare till den nya hemsidan. Samtidigt måste du också förstå hur den omdesignade startsidan kan förbättra användarengagemanget och intäkterna. Som marknadsförare har du tilldelats uppgiften att skapa en aktivitet som dirigerar om besökarna till den nya hemsidan. Låt oss utforska WKND:s hemsida och lära oss hur man skapar en aktivitet med Adobe Target.

## Steg för att skapa ett A/B-test med Visual Experience Composer (VEC)

1. Logga in på Adobe Target och navigera till aktivitetsfliken
1. Klicka på knappen **Skapa aktivitet** och välj sedan aktiviteten **A/B-test**

   ![A/B-aktivitet](assets/ab-target-activity.png)

1. Välj alternativet **Visual Experience Composer**, ange aktivitets-URL:en och klicka sedan på **Nästa**

   ![Aktivitets-URL](assets/ab-test-url.png)

1. I Visual Experience Composer visas två flikar till vänster när du har skapat en aktivitet: *Experience A* och *Experience B*. Välj en upplevelse i listan. Du kan lägga till nya upplevelser i listan med knappen **Lägg till upplevelse** .

   ![Upplevelsealternativ](assets/experience-options.png)

1. Visa tillgängliga alternativ för Experience A och välj sedan alternativet **Omdirigera till URL** och ange en URL för den nya WKND-webbplatsens hemsida.

   ![Omdirigerings-URL](assets/redirect-url.png)

1. Byt namn på *Upplev A* till *Ny WKND-startsida* och *Upplev B* till *WKND-startsida*

   ![Anteckningar](assets/new-experiences.png)

1. Klicka på **Nästa** för att gå till Riktning och behålla en manuell trafikallokering på 50-50 mellan de två upplevelserna.

   ![Målgruppsanpassning](assets/targeting.png)

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

* [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob)
