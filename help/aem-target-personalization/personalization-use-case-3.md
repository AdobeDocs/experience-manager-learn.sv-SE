---
title: Personalisering med Adobe Target Visual Experience Composer
seo-title: Personalisering med Adobe Target Visual Experience Composer (VEC)
description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Target Visual Experience Composer (VEC).
seo-description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Target Visual Experience Composer (VEC).
translation-type: tm+mt
source-git-commit: 0443c8ff42e773021ff8b6e969f5c1c31eea3ae4
workflow-type: tm+mt
source-wordcount: '610'
ht-degree: 0%

---


# Personalisering med Visual Experience Composer

I det här kapitlet ska vi utforska hur du skapar upplevelser med **Visual Experience Composer** genom att dra och släppa, byta och ändra layouten och innehållet på en webbsida inifrån Target.

## Scenarioöversikt

På WKND:s hemsida visas lokala aktiviteter eller det bästa att göra runt en stad i form av kortlayouter. Som marknadsförare har du tilldelats uppgiften att ändra hemsidan genom att ordna om kortlayouterna för att se hur det påverkar användarengagemanget och driver konverteringen.

### Berörda användare

För den här övningen måste följande användare vara involverade och för att kunna utföra vissa uppgifter måste du ha administratörsbehörighet.

* **Content Producer/Content Editor** (Adobe Experience Manager)
* **Marknadsförare** (Adobe Target/optimeringsteamet)

### Startsida för WKND-webbplats

![AEM målscenario 1](assets/personalization-use-case-3/aem-target-use-case-3.png)

### Förutsättningar

* **AEM**
   * [AEM publiceringsinstans](./implementation.md#getting-aem) som körs på 4503
   * [AEM integrerat med Adobe Target med Adobe Experience Platform Launch](./using-launch-adobe-io.md#aem-target-using-launch-by-adobe)
* **Experience Cloud**
   * Tillgång till dina organisationer Adobe Experience Cloud - <https://>`<yourcompany>`.experienceCloud.adobe.com
   * Experience Cloud som tillhandahålls med [Adobe Target](https://experiencecloud.adobe.com)

## Marknadsföringsaktiviteter

1. Marketern skapar en A/B-målaktivitet inom Adobe Target.
   1. Gå till fliken **Verksamheter** i Adobe Target-fönstret.
   2. Klicka på **Skapa aktivitet** och välj aktivitetstypen som **A/B-test**

      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-ab-activity.png)
   3. Markera **webbkanalen** och välj **Visual Experience Composer**.
   4. Ange **aktivitets-URL** och klicka på **Nästa** för att öppna Visual Experience Composer.
      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-activity-ab-name.png)
   5. Aktivera **Tillåt inläsning av osäkra skript** i webbläsaren och läs in sidan igen för att **Visual Experience Composer** ska kunna läsas in.
      ![Experience Targeting Activity](assets/personalization-use-case-1/load-unsafe-scripts.png)
   6. Observera att WKND-webbplatsens hemsida är öppen i Visual Experience Composer-redigeraren.
      ![VEC](assets/personalization-use-case-2/vec.png)
   7. **Experience A** innehåller WKND:s standardhemsida och vi redigerar innehållslayouten för **Experience B**.
      ![Upplevelse B](assets/personalization-use-case-3/use-case3-experience-b.png)
   8. Klicka på en av kortlayoutbehållarna (*Bästa roasters*) och välj alternativet **Ordna** om.
      ![Behållarval](assets/personalization-use-case-3/container-selection.png)
   9. Klicka på behållaren som du vill ändra ordning på och dra och släpp den till önskad plats. Vi ordnar om behållaren *Bästa roasters* från första raden i kolumn 1 till tredje raden. Nu kommer behållaren *Best Roasters* att finnas bredvid *Photography Exhibition* container.
      ![Behållarväxling](assets/personalization-use-case-3/container-swap.png)

      **Efter växling**
      ![Behållaren har bytts ut](assets/personalization-use-case-3/after-swap-1-3.png)
   10. Du kan även ordna om positionerna för de andra kortbehållarna.
      ![Behållaren har bytts ut](assets/personalization-use-case-3/after-swap-all.png)
   11. Låt oss också lägga till en rubriktext under karusellkomponenten och ovanför kortlayouten.
   12. Klicka på karusellbehållaren och välj alternativet **Lägg till efter > HTML** för att lägga till HTML.
      ![Lägg till text](assets/personalization-use-case-3/add-text.png)

      ```html
      <h1 style="text-align:center">Check Out the Hot Spots in Town</h1>
      ```

      ![Lägg till text](assets/personalization-use-case-3/after-changes.png)
   13. Klicka på **Nästa** för att fortsätta med din aktivitet.
   14. Välj **Traffic Allocation Method** som manual och tilldela 100 % trafik till **Experience B**.
      ![Experience B Traffic](assets/personalization-use-case-2/traffic.png)
   15. Klicka på **Nästa**.
   16. Ange **målvärden** för aktiviteten och spara och stäng A/B-testet.
      ![Mätning av A/B-testmål](assets/personalization-use-case-2/goal-metric.png)
   17. Ange ett namn (**WKND Home Page Refresh**) för aktiviteten och spara ändringarna.
   18. På skärmen Aktivitetsinformation ser du till att du **aktiverar** din aktivitet.
      ![Aktivera aktivitet](assets/personalization-use-case-3/save-activity.png)
   19. Navigera till WKND-hemsida (http://localhost:4503/content/wknd/en.html) och se ändringarna vi lade till i aktiviteten Uppdatera A/B-test för WKND-hemsidan.
      ![WKND hemsida har uppdaterats](assets/personalization-use-case-3/activity-result.png)
   20. Öppna webbläsarkonsolen och kontrollera nätverksfliken för att se efter målsvaret för aktiviteten Uppdatera A/B-test på WKND-startsidan.
      ![Nätverksaktivitet](assets/personalization-use-case-3/activity-result.png)

## Sammanfattning

I det här kapitlet kunde en marknadsförare skapa en upplevelse med Visual Experience Composer genom att dra och släppa, byta och ändra layouten och innehållet på en webbsida utan att ändra någon kod för att köra ett test.
