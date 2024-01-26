---
title: Personalisering med Adobe Target Visual Experience Composer
description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Target Visual Experience Composer (VEC).
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 1550e6a7-04b5-4a40-9d7b-88074283402f
duration: 165
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '584'
ht-degree: 0%

---

# Personalisering med Visual Experience Composer

I det här kapitlet ska vi utforska hur vi skapar upplevelser med **Visual Experience Composer** genom att dra och släppa, byta och ändra en webbsidas layout och innehåll inifrån Target.

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
   * Tillgång till er organisation Adobe Experience Cloud - `https://<yourcompany>.experiencecloud.adobe.com`
   * Experience Cloud har etablerats med [Adobe Target](https://experiencecloud.adobe.com)

## Marknadsföringsaktiviteter

1. Marketern skapar en A/B-målaktivitet inom Adobe Target.
   1. I Adobe Target-fönstret går du till **Verksamhet** -fliken.
   2. Klicka **Skapa aktivitet** och välj aktivitetstyp som **A/B-test**
      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-ab-activity.png)
   3. Välj **Webb** kanal och välj **Visual Experience Composer**.
   4. Ange **Aktivitets-URL** och klicka **Nästa** för att öppna Visual Experience Composer.
      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-activity-ab-name.png)
   5. För **Visual Experience Composer** att läsa in, aktivera **Tillåt inläsning av osäkra skript** i webbläsaren och läsa in sidan igen.
      ![Experience Targeting Activity](assets/personalization-use-case-1/load-unsafe-scripts.png)
   6. Observera att WKND-webbplatsens hemsida är öppen i Visual Experience Composer-redigeraren.
      ![VEC](assets/personalization-use-case-2/vec.png)
   7. **Upplevelse A** innehåller standardhemsidan för WKND, och vi redigerar innehållslayouten för **Upplevelse B**.
      ![Upplevelse B](assets/personalization-use-case-3/use-case3-experience-b.png)
   8. Klicka på en av kortlayoutbehållarna (*Bästa roasters*) och markera **Ordna om** alternativ.
      ![Behållarval](assets/personalization-use-case-3/container-selection.png)
   9. Klicka på behållaren som du vill ändra ordning på och dra och släpp den till önskad plats. Vi ordnar om *Bästa roasters* behållare från första raden, första kolumnen till första raden, tredje kolumnen. Nu *Bästa roasters* behållaren är intill *Fotografiutställningar* behållare.
      ![Behållarväxling](assets/personalization-use-case-3/container-swap.png)
      **Efter växling**
      ![Behållare utbytt](assets/personalization-use-case-3/after-swap-1-3.png)
   10. Du kan även ordna om positionerna för de andra kortbehållarna.
      ![Behållare utbytt](assets/personalization-use-case-3/after-swap-all.png)
   11. Låt oss också lägga till en rubriktext under karusellkomponenten och ovanför kortlayouten.
   12. Klicka på karusellbehållaren och välj **Indrag efter > HTML** för att lägga till HTML.
      ![Lägg till text](assets/personalization-use-case-3/add-text.png)

      ```html
      <h1 style="text-align:center">Check Out the Hot Spots in Town</h1>
      ```

      ![Lägg till text](assets/personalization-use-case-3/after-changes.png)
   13. Klicka **Nästa** för att fortsätta med din aktivitet.
   14. Välj **Trafikallokeringsmetod** som manuell och tillåt 100 % trafik till **Upplevelse B**.
      ![Experience B Traffic](assets/personalization-use-case-2/traffic.png)
   15. Klicka på **Nästa**.
   16. Ange **Målmått** för din aktivitet och spara och stäng A/B-testet.
      ![Mätning av A/B-testmål](assets/personalization-use-case-2/goal-metric.png)
   17. Ange ett namn (**WKND - hemsidesuppdatering**) för din aktivitet och spara ändringarna.
   18. På skärmen Aktivitetsinformation ser du till att **Aktivera** din aktivitet.
      ![Aktivera aktivitet](assets/personalization-use-case-3/save-activity.png)
   19. Navigera till WKND-hemsida (http://localhost:4503/content/wknd/en.html) och se ändringarna vi lade till i aktiviteten Uppdatera A/B-test för WKND-hemsidan.
      ![WKND hemsida har uppdaterats](assets/personalization-use-case-3/activity-result.png)
   20. Öppna webbläsarkonsolen och kontrollera nätverksfliken för att se efter målsvaret för aktiviteten Uppdatera A/B-test på WKND-startsidan.
      ![Nätverksaktivitet](assets/personalization-use-case-3/activity-result.png)

## Sammanfattning

I det här kapitlet kunde en marknadsförare skapa en upplevelse med Visual Experience Composer genom att dra och släppa, byta och ändra layouten och innehållet på en webbsida utan att ändra någon kod för att köra ett test.
