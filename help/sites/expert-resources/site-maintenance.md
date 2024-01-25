---
title: Handbok för webbplatsunderhåll
description: Oavsett om du är administratör, författare eller utvecklare gäller webbplatsunderhållet alla delar av din AEM Sites-instans. Använd den här guiden för att säkerställa att strategin är klar för framgång.
role: Admin
level: Beginner, Intermediate
topic: Administration
feature: Learn From Your Peers
jira: KT-14255
exl-id: 37ee3234-f91c-4f0a-b0b7-b9167e7847a9
duration: 225
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '998'
ht-degree: 0%

---

# Tips och tricks för webbplatsunderhåll

Det finns tre alternativ när det gäller att installera och underhålla en AEM

* AEMaaCS (molntjänst) - systemet är alltid aktiverat, uppdaterat och skalas dynamiskt efter behov
* Adobe Managed Services där Adobe kundtjänstingenjörer utför allt underhåll varje dag, vecka/månad och ser till att alla servicepaket installeras och att systemet alltid är säkert och smidigt
* köra programmet lokalt, där du måste ta hand om hela systemet, inklusive säkerhetskopiering, uppgraderingar och säkerhet.

Om du väljer att implementera ditt eget system lokalt finns det några saker att tänka på för att säkerställa att du har ett säkert, prestandasystem. Förutom&quot;vården och matningen&quot; kommer denna rapport även att peka ut flera saker AEM utvecklarna bör tänka på för att hjälpa till att hålla systemet i drift.

## Administratörer

Säkerhetskopieringar - se till att du har fullständig och/eller partiell säkerhetskopiering enligt ett ofta återkommande schema:

* daglig
* veckovis
* månadsvis

Många kunder gör snapshot-säkerhetskopieringar, som bara tar några minuter om det underliggande operativsystemet har stöd för sådana säkerhetskopieringar. Se till att säkerhetskopiorna lagras korrekt (inte i AEM). Se till att säkerhetskopiorna fungerar och kan användas för att återskapa ett fungerande system med jämna mellanrum - det finns inget värre än att systemet kraschar och säkerhetskopiorna är skadade av någon anledning!

Det finns flera saker du måste övervaka för att säkerställa problemfri drift:

### Rutinunderhåll

#### [indexunderhåll](https://experienceleague.adobe.com/docs/experience-manager-65/deploying/practices/best-practices-for-queries-and-indexing.html?lang=en)

Med index kan frågor köras så snabbt de kan, vilket frigör resurser för andra åtgärder. Se till att indexen är i toppform! AEM avbryter frågor som rör sig i stället för att använda ett index för att förhindra att en felaktig fråga påverkar AEM övergripande prestanda.

#### [Tjärkompakation/Revision-rensning](https://experienceleague.adobe.com/docs/experience-manager-65/deploying/deploying/revision-cleanup.html?lang=en)

Varje uppdatering av databasen skapar en ny innehållsrevision. Det innebär att databasstorleken ökar för varje uppdatering. För att undvika okontrollerad databastillväxt måste gamla versioner rensas bort för att frigöra diskutrymme.

#### [Rensa Lucene-binärfiler](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/operations-dashboard.html#automated-maintenance-tasks)

Rensa lucene-binärfiler och minska storlekskraven för det datalager som körs.

#### [Skräpning för datalager](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/data-store-garbage-collection.html)

När en resurs i AEM tas bort kan referensen till den underliggande datalagreposten tas bort från nodhierarkin, men själva datalagreposten finns kvar. Den här dataarkivposten utan referenser blir&quot;skräp&quot; som inte behöver behållas. Om det finns ett antal resurser som inte refereras är det bra att ta bort dem, bevara utrymme, optimera säkerhetskopieringen och prestanda för filsystemsunderhåll.

#### [Rensa arbetsflöde](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/workflows-administering.html)

Om du minimerar antalet arbetsflödesinstanser ökas arbetsflödesmotorns prestanda, så att du regelbundet kan rensa avslutade eller pågående arbetsflödesinstanser från databasen.

#### [Underhåll av granskningslogg](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/operations-audit-log.html

AEM som är kvalificerade för granskningsloggning genererar mycket arkiverade data. Dessa data kan snabbt växa med tiden på grund av replikeringar, överföringar av resurser och andra systemaktiviteter.

#### [Säkerhet](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security-checklist.html?lang=en)

Se till att god praxis för checklistan för säkerhet följs noga för att säkerställa den säkraste instansen av AEM.

#### Diskutrymme

Övervaka diskutrymmet för att säkerställa att du har tillräckligt med utrymme för JCR-databasen, plus ungefär hälften så mycket utrymme igen - tjärkomprimeringen använder extra utrymme när den körs. Diskutrymmet tar slut och är den främsta orsaken till JCR-fel!

## Developer

Försök att inte använda anpassade komponenter - använd [kärnkomponenter](https://www.aemcomponents.dev/). Målet bör vara att endast använda kärnkomponenterna 80-90 % av tiden och anpassade komponenter sparsamt. Detta kräver ofta ett nytt sätt att se på komponenterna på en sida - du måste inse att komponenterna enkelt kan återskapas av en frontutvecklare som använder CSS. Tänk också på att dessa kärnkomponenter kan bäddas in i varandra för att uppnå ganska komplexa resultat. Bli kreativ!

### [Formatsystem](https://experienceleague.adobe.com/docs/experience-manager-65/authoring/siteandpage/style-system.html?lang=en)

Med formatsystem kan de centrala komponenterna, och även de anpassade komponenterna, få en ny look och känsla som författaren bestämmer sig för att skapa helt nya snygga komponenter. De här stilistiska ändringarna gäller vanligtvis endast för en frontenddesigner och en kunnig författare (kallas ofta&quot;superförfattare&quot;)

### [Startar](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/launches/overview.html?lang=en)

Med lanseringar kan du slutföra arbetet för att lansera en ny kampanj, försäljning eller webbplats utan att påverka de distribuerade sidorna. Dessutom kan man schemalägga att publicera dem automatiskt utan närvaro eller övervakning, så att författarna kan göra nästa veckas (eller nästa kvarts) arbete idag och inte skynda sig in i sidutvecklingen dagen innan det ska publiceras - det är verkligen TIME-presenten!)

### [Innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-65/assets/fragments/content-fragments.html)

Innehållsfragment är anpassningsbara informationsdelar som enkelt kan återanvändas på hela webbplatsen. Om du behöver ändra något ändrar du bara det ursprungliga segmentet så visas uppdateringen var den än används - omedelbart!

### [Experience Fragments](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/experience-fragments/experience-fragments-feature-video-use.html?lang=en)

Medan du låter nästan identiskt med innehållsfragment är Experience Fragments små, synliga delar av en sida. Dessa kan också återanvändas i stor omfattning på hela webbplatsen och underhållas på en central plats inom AEM för att underlätta uppgiften att göra potentiellt globala ändringar på webbplatsen på några sekunder, inte dagar eller veckor.

Tänk framåt och se vad som kan återanvändas. En sidfot? Ansvarsfriskrivning? En rubrik? Vissa typer av innehåll? Alla dessa kan delas på en hel webbplats med ett minimum av underhåll. Behöver du uppdatera ett datum i en ansvarsfriskrivning, men det finns på 1 000 sidor på din webbplats? Det är en åtgärd på fem sekunder om du använde en Experience Fragment!

## Allmänt

Håll dig à jour med förändringar AEM genom fortsatt lärande - fastna inte i det förflutna. Använd [Experience League](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/overview.html?lang=en) och [Adobe Digital Learning Services (ADLS)](https://learning.adobe.com/) för att finslipa dina färdigheter.

## Slutsats

AEM kan vara ett stort system, och det krävs många typer av personer för att det ska&quot;sjunga&quot;. Från administratörer till utvecklare (både front-end- och hardcore Java-utvecklare) till författare - det finns något för alla! Och om du inte känner för att hantera den dagliga administrationen finns det alltid AMS och AEM as a Cloud Service.
