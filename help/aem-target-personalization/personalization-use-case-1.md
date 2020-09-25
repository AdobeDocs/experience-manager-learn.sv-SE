---
title: Personalisering med AEM Experience Fragments och Adobe Target
seo-title: Personalisering med Adobe Experience Manager (AEM) Experience Fragments och Adobe Target
description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Experience Manager Experience Fragments och Adobe Target.
seo-description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Experience Manager Experience Fragments och Adobe Target.
translation-type: tm+mt
source-git-commit: 1209064fd81238d4611369b8e5b517365fc302e3
workflow-type: tm+mt
source-wordcount: '1729'
ht-degree: 0%

---


# Personalisering med AEM Experience Fragments och Adobe Target

Med möjligheten att exportera AEM Experience Fragments till Adobe Target som HTML-erbjudanden kan ni kombinera lättanvända och kraftfulla AEM med kraftfulla funktioner för Automated Intelligence (AI) och Machine Learning (ML) i Target för att testa och personalisera upplevelser i stor skala.

AEM samlar allt innehåll och alla resurser på en central plats för att understödja er personaliseringsstrategi. AEM gör det enkelt att skapa innehåll för datorer, surfplattor och mobila enheter på en och samma plats utan att behöva skriva kod. Du behöver inte skapa sidor för alla enheter. AEM justerar automatiskt varje upplevelse med ditt innehåll.

Med Target kan ni leverera personaliserade upplevelser i stor skala baserat på en kombination av regelbaserade och AI-drivna maskininlärningsstrategier som innehåller beteendevariabler, sammanhangsbaserade variabler och offlinevariabler.  Med Target kan ni enkelt konfigurera och köra A/B- och Multivariate-aktiviteter (MVT) för att fastställa de bästa erbjudandena, innehållet och upplevelserna.

Upplevelsefragment är ett stort steg framåt när det gäller att länka innehållsskapare till marknadsförare som driver affärsresultaten med Target.

## Scenarioöversikt

WKND:s webbplats planerar att lansera en **SkateFest Challenge** i hela Amerika via sin webbplats och vill att webbplatsanvändarna ska registrera sig för provspelningen i respektive delstat. Som marknadsförare har du tilldelats uppgiften att köra en kampanj på WKND-webbplatsens hemsida, med bannermeddelanden som är relevanta för användarens plats och en länk till sidan med händelseinformation. Låt oss utforska WKND:s hemsida och lära oss hur man skapar och levererar en personaliserad upplevelse som bygger på användarens aktuella plats.

### Berörda användare

För den här övningen måste följande användare vara involverade och för att kunna utföra vissa uppgifter måste du ha administratörsbehörighet.

* **Content Producer/Content Editor** (Adobe Experience Manager)
* **Marknadsförare** (Adobe Target/optimeringsteamet)

### Förutsättningar

* **AEM**
   * [AEM författare och publicerar instansen](./implementation.md#getting-aem) som körs på localhost 4502 respektive 4503.
* **Experience Cloud**
   * Tillgång till dina organisationer Adobe Experience Cloud - <https://>`<yourcompany>`.experienceCloud.adobe.com
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Target](https://experiencecloud.adobe.com)

### Startsida för WKND-webbplats

![AEM målscenario 1](assets/personalization-use-case-1/aem-target-use-case-1-4.png)

1. Marketer initierar WKND SkateFest-kampanjdiskussionen med AEM Content Editor och redogör för kraven.
   * ***Krav***: Marknadsför kampanjen WKND SkateFest på WKND:s hemsida med personaliserat innehåll för besökare från alla delstater i USA. Lägg till ett nytt innehållsblock under Home Page Carousel som innehåller en bakgrundsbild, text och en knapp.
      * **Bakgrundsbild**: Bilden bör vara relevant för det tillstånd från vilket användaren besöker WKND-webbplatssidan.
      * **Text**: &quot;Registrera dig för Audition&quot;
      * **Knapp**: &quot;Händelseinformation&quot; som pekar på WKND SkateFest-sidan
      * **WKND SkateFest Page**: en ny sida med eventinformation, inklusive ljudplats, datum och tid.
2. AEM Content Editor skapar en Experience Fragment för innehållsblocket och exporterar det till Adobe Target som ett erbjudande. Om du vill leverera personaliserat innehåll för alla lägen i USA kan innehållsförfattaren skapa en överordnad Experience Fragment-variant och sedan skapa 50 andra varianter, en för varje läge. Innehåll för varje lägesvariation med relevanta bilder och text kan sedan redigeras manuellt. När du redigerar ett Experience Fragment kan redigerare snabbt få tillgång till alla resurser som finns i AEM Assets med hjälp av alternativet Resurssökning. När en Experience Fragment exporteras till Adobe Target skickas alla dess varianter också till Adobe Target som erbjudanden.

3. Efter att ha exporterat Experience Fragment från AEM till Adobe Target som erbjudanden kan marknadsförarna skapa aktiviteter i Target med dessa erbjudanden. Baserat på SkateFest-kampanjen på WKND-webbplatsen måste marknadsföraren skapa och leverera en personaliserad upplevelse till WKND-webbplatsbesökare från varje stat. För att skapa en Experience Targeting-aktivitet måste marknadsföraren identifiera målgrupperna. För vår WKND SkateFest-kampanj måste vi skapa 50 separata målgrupper utifrån deras plats på WKND:s webbplats.
   * [Målgrupperna](https://docs.adobe.com/content/help/en/target/using/introduction/target-key-concepts.html#section_3F32DA46BDF947878DD79DBB97040D01) definierar målet för din aktivitet och används var som helst där målinriktning finns tillgänglig. Målgrupper är en definierad uppsättning besökskriterier. Erbjudandena kan riktas till specifika målgrupper (eller segment). Det är bara besökare som tillhör den målgruppen som ser upplevelsen som är riktad till dem.  Du kan till exempel leverera ett erbjudande till en publik som består av besökare som använder en viss webbläsare eller från en viss geografisk plats.
   * Ett [erbjudande](https://docs.adobe.com/content/help/en/target/using/introduction/target-key-concepts.html#section_973D4CC4CEB44711BBB9A21BF74B89E9) är det innehåll som visas på dina webbsidor under kampanjer eller aktiviteter. När du testar dina webbsidor mäter du framgången för varje upplevelse med olika erbjudanden på dina platser. Ett erbjudande kan innehålla olika typer av innehåll, bland annat:
      * Bild
      * Text
      * **HTML**
         * *HTML-erbjudanden kommer att användas för det här scenariots aktivitet*
      * Länk
      * Knapp

## Innehållsredigeringsaktiviteter

>[!VIDEO](https://video.tv.adobe.com/v/28596?quality=12&learn=on)

>[!NOTE]
>
>Publicera Experience Fragment innan du exporterar det till Adobe Target.

## Marknadsföringsaktiviteter

### Skapa en målgrupp med geolokalisering {#marketer-audience}

1. Gå till din organisation [Adobe Experience Cloud](https://experiencecloud.adobe.com/) (<https://>`<yourcompany>`.experienceCloud.adobe.com)
2. Logga in med din Adobe ID och kontrollera att du är i rätt organisation.
3. Klicka på **Target** i lösningsväljaren och **starta** Adobe Target.

   ![Experience Cloud - Adobe Target](assets/personalization-use-case-1/exp-cloud-adobe-target.png)

4. Gå till fliken **Erbjudanden** och sök efter&quot;WKND&quot;-erbjudanden. Du bör kunna se listan med Experience Fragments-variationer, som exporteras AEM som HTML-erbjudanden. Varje erbjudande motsvarar ett läge. Exempel: *WKND SkateFest California* är erbjudandet som skickas till en WKND Site-besökare från Kalifornien.

   ![Experience Cloud - Adobe Target](assets/personalization-use-case-1/html-offers.png)

5. Klicka på **Publiker** i huvudnavigeringen.

   En marknadsförare måste skapa 50 separata målgrupper för WKND:s webbplatsbesökare som kommer från varje delstat i USA.

6. Om du vill skapa en målgrupp klickar du på knappen **Skapa publik** och anger ett namn för målgruppen.

   **Målgruppsnamnformat: WKND-\&lt;*tillstånd*\>**

   ![Experience Cloud - Adobe Target](assets/personalization-use-case-1/audience-target-1.png)

7. Klicka på **Lägg till regel > Geo**.
8. Klicka på **Markera** och välj sedan ett av följande alternativ:
   * Land
   * **Läge** *(Välj läge för WKND-webbplats SkateFest-kampanj)*
   * Ort
   * Postnummer
   * Latitud
   * Longitud
   * DMA
   * Mobiloperatör

   **Geo** - Använd målgrupper för att rikta in er på användare baserat på deras geografiska plats, inklusive land, stat/provins, stad, postnummer, DMA eller mobiloperatör. Med geopositioneringsparametrar kan ni inrikta er på aktiviteter och upplevelser baserat på besökarnas geografiska läge. Dessa data skickas med varje Target-begäran och baseras på besökarens IP-adress. Välj de här parametrarna precis som andra målvärden.

   >[!NOTE]
   >En besökares IP-adress skickas med en mbox-begäran, en gång per besök (session), för att matcha parametrar för geomål för den besökaren.

9. Välj operatorn som **matchar**, ange ett lämpligt värde (till exempel: California) och **Save** your changes. Ange i så fall delstatens namn.

   ![Adobe Target - Georegel](assets/personalization-use-case-1/audience-geo-rule.png)

   >[!NOTE]
   >Du kan ha flera regler tilldelade till en målgrupp.

10. Upprepa steg 6-9 för att skapa målgrupper för de andra lägena.

   ![Adobe Target - WKND-målgrupper](assets/personalization-use-case-1/adobe-target-audiences-50.png)

Nu har vi skapat målgrupper för alla WKND Site-besökare i olika delstater i USA och även motsvarande HTML-erbjudande för respektive delstat. Låt oss nu skapa en Experience Targeting-aktivitet för att rikta in oss på målgruppen med ett motsvarande erbjudande för WKND Site Home Page.

### Skapa en aktivitet med geolokalisering

1. Gå till fliken **Verksamheter** i Adobe Target-fönstret.
2. Klicka på **Skapa aktivitet** och välj aktivitetstypen **Experience Targeting** .
3. Markera **webbkanalen** och välj **Visual Experience Composer**.
4. Ange **aktivitets-URL** och klicka på **Nästa** för att öppna Visual Experience Composer.

   Publicerings-URL för WKND-webbplatsens hemsida: http://localhost:4503/content/wknd/en.html
   ![Experience Targeting Activity](assets/personalization-use-case-1/target-activity.png)
5. Aktivera **Tillåt inläsning av osäkra skript** i webbläsaren och läs in sidan igen för att **Visual Experience Composer** ska kunna läsas in.
   ![Experience Targeting Activity](assets/personalization-use-case-1/load-unsafe-scripts.png)
6. Observera att WKND-webbplatsens hemsida är öppen i Visual Experience Composer-redigeraren.
   ![VEC](assets/personalization-use-case-1/vec.png)
7. Om du vill lägga till en målgrupp i VEC klickar du på **Lägg till upplevelseanpassning** under Publiker, väljer målgruppen WKND-California och klickar på **Nästa**.
   ![VEC](assets/personalization-use-case-1/vec-select-audience.png)
8. Klicka på WKND-webbsidan i VEC, markera HTML-elementet för att lägga till erbjudandet för WKND-California-målgrupp, välj **Ersätt med** och välj sedan **HTML-erbjudandet**.
   ![Experience Targeting Activity](assets/personalization-use-case-1/vec-selecting-div.png)
9. Välj erbjudandet **WKND SkateFest California** HTML för **WKND-California** -målgruppen i erbjudandet välj UI och klicka på **Klar**.
10. Nu bör du kunna se **WKND SkateFest California** HTML Offer som lagts till på WKND Site för WKND-California-målgruppen.
11. Upprepa steg 7-10 för att lägga till Experience Targeting för de andra lägena och välj motsvarande HTML-erbjudande.
12. Klicka på **Nästa** för att fortsätta så ser du en mappning för Publiker till upplevelser.
13. Klicka på **Nästa** för att gå till Mål och inställningar.
14. Välj rapportkälla och identifiera ett primärt mål för aktiviteten. I vårt scenario väljer vi Rapporteringskälla som **Adobe Target** och mäter aktivitet som **Conversion**, åtgärd som visad på en sida och URL som pekar på sidan WKND SkateFest Details.
   ![Mål och målinriktning - Mål](assets/personalization-use-case-1/goal-metric-target.png)

   >[!NOTE]
   >Du kan också välja Adobe Analytics som rapportkälla.

15. Håll muspekaren över det aktuella aktivitetsnamnet så kan du byta namn på det till **WKND SkateFest - USA** och sedan **Spara och stäng** ändringarna.
16. På skärmen Aktivitetsinformation ser du till att du **aktiverar** din aktivitet.
   ![Aktivera aktivitet](assets/personalization-use-case-1/activate-activity.png)
17. Din WKND SkateFest-kampanj är nu tillgänglig för alla WKND-webbplatsbesökare.
18. Navigera till startsidan för [WKND-webbplatsen](http://localhost:4503/content/wknd/en.html)och se WKND SkateFest-erbjudandet baserat på din geografiska plats (*läge: Kalifornien*).
   ![Aktivitets-QA](assets/personalization-use-case-1/wknd-california.png)

### Målaktivitet, QA

1. Under fliken **Aktivitetsinformation > Översikt** klickar du på knappen **Aktivitets-QA** så får du en direkt QA-länk till alla dina upplevelser.
   ![Aktivitets-QA](assets/personalization-use-case-1/activity-qa.png)
2. Navigera till startsidan för [WKND-webbplatsen](http://localhost:4503/content/wknd/en.html)så kan du se WKND SkateFest-erbjudandet baserat på din geografiska plats (läge).
3. Titta på videon nedan för att förstå hur ett erbjudande levereras till din sida, hur du anpassar svarstoken och för att utföra en kvalitetskontroll.

>[!VIDEO](https://video.tv.adobe.com/v/28658?quality=12&learn=on)

## Sammanfattning

I det här kapitlet kunde en innehållsredigerare skapa allt innehåll som kunde stödja WKND SkateFest-kampanjen i Adobe Experience Manager och exportera det till Adobe Target som HTML-erbjudanden för att skapa Experience Targeting, baserat på användarnas geografiska plats.
