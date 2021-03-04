---
title: Personalisering med Adobe Target
seo-title: Personalisering med Adobe Target
description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Target.
seo-description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Target.
feature: Experience Fragments
topic: Personanpassning
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '611'
ht-degree: 1%

---


# Personalisering av helwebbsidesupplevelser med Adobe Target

I det föregående kapitlet lärde vi oss att skapa en geoplatsbaserad aktivitet i Adobe Target med innehåll som skapats som Experience Fragments och exporterats från AEM som HTML-erbjudanden.

I det här kapitlet ska vi undersöka hur du skapar aktivitet för att dirigera om de webbsidor som finns på AEM till en ny sida med Adobe Target.

## Scenarioöversikt

WKND:s webbplats har gjort om sin hemsida och vill dirigera om sina nuvarande besökare till den nya hemsidan. Samtidigt måste du också förstå hur den omdesignade startsidan kan förbättra användarengagemanget och intäkterna. Som marknadsförare har du tilldelats uppgiften att skapa en aktivitet som dirigerar om besökarna till den nya hemsidan. Låt oss utforska WKND:s hemsida och lära oss hur man skapar en aktivitet med Adobe Target.

### Berörda användare

För den här övningen måste följande användare vara involverade och för att kunna utföra vissa uppgifter måste du ha administratörsbehörighet.

* **Content Producer/Content Editor**  (Adobe Experience Manager)
* **Marketer**  (Adobe Target/optimeringsteamet)

### Startsida för WKND-webbplats

![AEM målscenario 1](assets/personalization-use-case-2/aem-target-use-case-2.png)

### Förutsättningar

* **AEM**
   * [AEM skapar och publicerar ](./implementation.md#getting-aem) instancerunning på localhost 4502 respektive 4503.
   * [AEM integrerat med Adobe Target med Adobe Experience Platform Launch](./using-launch-adobe-io.md#aem-target-using-launch-by-adobe)
* **Experience Cloud**
   * Åtkomst till dina organisationer Adobe Experience Cloud - <https://>`<yourcompany>`.experienceCloud.adobe.com
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Target](https://experiencecloud.adobe.com)

## Innehållsredigeringsaktiviteter

1. Marknadsföraren initierar omdesignningsdiskussionen för WKND-hemsidan med AEM Content Editor och redogör för kraven.
   * ***Krav*** : Designa om startsidan för WKND-webbplatsen med kortbaserad design.
2. AEM Content Editor skapar sedan en ny WKND Site-hemsida med en kortbaserad design och publicerar den nya hemsidan.

## Marknadsföringsaktiviteter

1. Marknadsföraren skapar en A/B-målaktivitet med omdirigeringserbjudandet som en upplevelse och 100 % webbplatstrafik som tilldelats den nya startsidan med framgångsmål och mätvärden tillagda.
   1. I Adobe Target-fönstret går du till fliken **Aktiviteter**.
   2. Klicka på knappen **Skapa aktivitet** och välj aktivitetstypen som **A/B-test**

      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-ab-activity.png)
   3. Markera kanalen **Webb** och välj **Visual Experience Composer**.
   4. Ange **aktivitets-URL** och klicka på **Nästa** för att öppna Visual Experience Composer.
      ![Adobe Target - Skapa aktivitet](assets/personalization-use-case-2/create-activity-ab-name.png)
   5. Aktivera **Tillåt inläsning av osäkra skript** i webbläsaren och läs in sidan igen för att **Visual Experience Composer** ska kunna läsas in.
      ![Experience Targeting Activity](assets/personalization-use-case-1/load-unsafe-scripts.png)
   6. Observera att WKND-webbplatsens hemsida är öppen i Visual Experience Composer-redigeraren.
      ![VEC](assets/personalization-use-case-2/vec.png)
   7. Håll muspekaren över **Upplev B** och välj visa andra alternativ.
      ![Upplevelse B](assets/personalization-use-case-2/redirect-url.png)
   8. Välj alternativet **Omdirigera till URL** och ange URL:en till den nya WKND-startsidan. (http://localhost:4503/content/wknd/en1.html)
      ![Upplevelse B](assets/personalization-use-case-2/redirect-url-2.png)
   9. **Spara** ändringarna och fortsätt med nästa steg i Skapa aktivitet.
   10. Välj **Trafikallokeringsmetod** som manuell och tilldela 100 % trafik till **upplevelse B**.
      ![Experience B Traffic](assets/personalization-use-case-2/traffic.png)
   11. Klicka på **Nästa**.
   12. Ange **Målmått** för din aktivitet och Spara och stäng A/B-testet.
      ![Mätning av A/B-testmål](assets/personalization-use-case-2/goal-metric.png)
   13. Ange ett namn (**WKND Home Page Redesign**) för aktiviteten och spara ändringarna.
   14. På skärmen Aktivitetsinformation ser du till att **aktivera** din aktivitet.
      ![Aktivera aktivitet](assets/personalization-use-case-2/ab-activate.png)
   15. Navigera till WKND-startsidan (http://localhost:4503/content/wknd/en.html) så dirigeras du till den omdesignade startsidan för WKND-webbplatsen (http://localhost:4503/content/wknd/en1.html).
      ![WKND Home Page Redesignad](assets/personalization-use-case-2/WKND-home-page-redesign.png)

## Sammanfattning

I det här kapitlet kunde en marknadsförare skapa en aktivitet som dirigerade om de webbsidor som finns på AEM till en ny sida med Adobe Target.
