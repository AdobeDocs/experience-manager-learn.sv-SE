---
title: Personalization med Adobe Target
description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Target.
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 53cafd06-3a0a-4995-947d-179146b89234
duration: 114
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '577'
ht-degree: 0%

---

# Personalization med Adobe Target

I det föregående kapitlet lärde vi oss att skapa en geoplatsbaserad aktivitet i Adobe Target med innehåll som skapats som Experience Fragments och exporterats från AEM som HTML Offers.

I det här kapitlet ska vi undersöka hur du skapar aktivitet för att dirigera om de webbsidor som finns på AEM till en ny sida med Adobe Target.

## Scenarioöversikt

WKND:s webbplats har gjort om sin hemsida och vill dirigera om sina nuvarande besökare till den nya hemsidan. Samtidigt måste du också förstå hur den omdesignade startsidan kan förbättra användarengagemanget och intäkterna. Som marknadsförare har du tilldelats uppgiften att skapa en aktivitet som dirigerar om besökarna till den nya hemsidan. Låt oss utforska WKND:s hemsida och lära oss hur man skapar en aktivitet med Adobe Target.

### Berörda användare

För den här övningen måste följande användare vara involverade och för att kunna utföra vissa uppgifter måste du ha administratörsbehörighet.

* **Content Producer/Content Editor** (Adobe Experience Manager)
* **Marketer** (Adobe Target/optimeringsteamet)

### WKND - startsida för webbplats

![AEM Målscenario 1](assets/personalization-use-case-2/aem-target-use-case-2.png)

### Förutsättningar

* **AEM**
   * [AEM författare och publiceringsinstans](./implementation.md#getting-aem) som körs på localhost 4502 respektive 4503.
   * [AEM integrerat med Adobe Target med taggar](./using-launch-adobe-io.md#aem-target-using-launch-by-adobe)
* **Experience Cloud**
   * Åtkomst till ditt företag Adobe Experience Cloud - `https://<yourcompany>.experiencecloud.adobe.com`
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Target](https://experiencecloud.adobe.com)

## Innehållsredigeringsaktiviteter

1. Marknadsföraren initierar omdesignningsdiskussionen för WKND-hemsidan med AEM Content Editor och redogör för kraven.
   * ***Krav*** : Designa om startsidan för WKND-webbplatsen med kortbaserad design.
2. AEM Content Editor skapar sedan en ny WKND Site-hemsida med en kortbaserad design och publicerar den nya hemsidan.

## Marknadsföringsaktiviteter

1. Marknadsföraren skapar en A/B-målaktivitet med omdirigeringserbjudandet som en upplevelse och 100 % webbplatstrafik som tilldelats den nya startsidan med framgångsmål och mätvärden tillagda.
   1. Gå till fliken **Aktiviteter** i ditt Adobe Target-fönster.
   2. Klicka på knappen **Skapa aktivitet** och välj aktivitetstypen som **A/B-test**

      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-ab-activity.png)
   3. Markera **webbkanalen** och välj **Visual Experience Composer**.
   4. Ange **aktivitets-URL** och klicka på **Nästa** för att öppna Visual Experience Composer.

      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-activity-ab-name.png)
   5. Aktivera **Tillåt inläsning av osäkra skript** i webbläsaren och läs in sidan igen om du vill att **Visual Experience Composer** ska läsas in.

      ![Aktivitet för målinriktning](assets/personalization-use-case-1/load-unsafe-scripts.png)
   6. Observera att WKND-webbplatsens hemsida är öppen i Visual Experience Composer-redigeraren.

      ![VEC](assets/personalization-use-case-2/vec.png)
   7. Hovra över **upplevelse B** och välj Visa andra alternativ.

      ![Upplevelse B](assets/personalization-use-case-2/redirect-url.png)
   8. Välj alternativet **Omdirigera till URL** och ange URL:en till den nya WKND-startsidan. (http://localhost:4503/content/wknd/en1.html)

      ![Upplevelse B](assets/personalization-use-case-2/redirect-url-2.png)
   9. **Spara** dina ändringar och fortsätt med nästa steg i Skapa aktivitet.
   10. Välj **Trafikallokeringsmetod** som manuell och tilldela 100 % trafik till **upplevelse B**.

       ![Upplev B-trafik](assets/personalization-use-case-2/traffic.png)
   11. Klicka på **Nästa**.
   12. Ange **målvärden** för aktiviteten och spara och stäng A/B-testet.

       ![Mätvärde för A/B-testmål](assets/personalization-use-case-2/goal-metric.png)
   13. Ange ett namn (**WKND Home Page Redesign**) för aktiviteten och spara ändringarna.
   14. På skärmen Aktivitetsinformation ser du till att **Aktivera** din aktivitet.

       ![Aktivera aktivitet](assets/personalization-use-case-2/ab-activate.png)
   15. Navigera till WKND-startsidan (http://localhost:4503/content/wknd/en.html) så dirigeras du till den omdesignade startsidan för WKND-webbplatsen (http://localhost:4503/content/wknd/en1.html).

      ![WKND-hemsida har gjorts om](assets/personalization-use-case-2/WKND-home-page-redesign.png)

## Sammanfattning

I det här kapitlet kunde en marknadsförare skapa en aktivitet för att dirigera om de webbsidor som finns på AEM till en ny sida med Adobe Target.
