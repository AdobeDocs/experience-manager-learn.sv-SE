---
title: Personalisering med Visual Experience Composer
description: Lär dig skapa en Adobe Target-aktivitet med Visual Experience Composer.
version: Cloud Service
jira: KT-6352
thumbnail: 6352-personalization-using-vec.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: becf2bed-0541-45e8-9ce2-f9fb023234e0
duration: 141
source-git-commit: 970093bb54046fee49e2ac209f1588e70582ab67
workflow-type: tm+mt
source-wordcount: '508'
ht-degree: 0%

---

# Personalisering med Visual Experience Composer {#personalization-vec}

Lär dig hur du skapar en A/B Test Target-aktivitet med Visual Experience Composer (VEC).

## Förutsättningar

För att kunna använda VEC på en AEM webbplats måste följande konfiguration vara slutförd:

1. [Lägg till Adobe Target på din AEM webbplats](./add-target-launch-extension.md)
1. [Utlös ett Adobe Target-samtal från taggar](./load-and-fire-target.md)

## Scenarioöversikt

På WKND-webbplatsens hemsida visas lokala aktiviteter eller de bästa sakerna att göra runt en stad i form av informationskort. Som marknadsförare har du tilldelats uppgiften att ändra hemsidan genom att göra textändringar i äventyrsavsnittet och förstå hur konverteringen förbättras.

## Steg för att skapa ett A/B-test med Visual Experience Composer (VEC)

1. Logga in på [Adobe Experience Cloud](https://experience.adobe.com/), tryck på __Mål__, navigera till __Verksamhet__ tab

   + Om du inte ser __Mål__ Kontrollera att rätt Adobe-organisation har valts i organisationsväljaren i det övre högra hörnet på kontrollpanelen Experience Cloud och att användaren har beviljats åtkomst till Target i [Adobe Admin Console](https://adminconsole.adobe.com/).

1. Klicka **Skapa aktivitet** och sedan välja **A/B-test** aktivitet

   ![A/B-aktivitet](assets/ab-target-activity.png)

1. Välj **Visual Experience Composer** anger du aktivitets-URL:en och klickar sedan på **Nästa**

   ![Aktivitets-URL](assets/ab-test-url.png)

1. I Visual Experience Composer visas två flikar till vänster när du har skapat en aktivitet: *Upplevelse A* och *Upplevelse B*. Välj en upplevelse i listan. Du kan lägga till nya upplevelser i listan med hjälp av **Lägg till upplevelse** -knappen.

   ![Upplevelse A](assets/experience.png)

1. Markera en bild eller text på sidan som du vill börja ändra, eller använd kodredigeraren för att välja och använda elementet HTML.

   ![Element](assets/select-element.png)

1. Ändra texten från *Camping i Western Australia* till *Australiens äventyr*. En lista över ändringar som har lagts till i en upplevelse visas under Ändringar. Du kan klicka på och redigera det ändrade objektet för att visa dess CSS-väljare och det nya innehållet som lagts till i det.

   ![Annonser](assets/adventures.png)

1. Byt namn *Upplevelse A* till *Adventure*
1. Uppdatera texten på samma sätt *Upplevelse B* från *Camping i Western Australia* till *Utforska Australiens vildhet*.

   ![Utforska](assets/explore.png)

1. Klicka **Nästa** för att gå över till Targeting och vi behåller en manuell trafiktilldelning på 50-50 mellan de två upplevelserna.

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

+ [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob)
