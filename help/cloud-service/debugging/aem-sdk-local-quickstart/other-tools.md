---
title: Andra verktyg för felsökning AEM SDK
description: En mängd andra verktyg kan hjälpa dig att felsöka AEM SDK:s lokala snabbstart.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
jira: KT-5251
topic: Development
role: Developer
level: Beginner, Intermediate
exl-id: 11fb83e9-dbaf-46e5-8102-ae8cc716c6ba
duration: 141
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '514'
ht-degree: 0%

---

# Andra verktyg för felsökning AEM SDK

En mängd andra verktyg kan hjälpa dig att felsöka programmet på AEM SDK:s lokala snabbstart.

## CRXDE Lite

![CRXDE Lite](./assets/other-tools/crxde-lite.png)

CRXDE Lite är ett webbaserat gränssnitt för interaktion med JCR-AEM. CRXDE Lite ger fullständig synlighet i JCR-rapporterna, inklusive noder, egenskaper, egenskapsvärden och behörigheter.

CRXDE Lite ligger på:

+ Verktyg > Allmänt > CRXDE Lite
+ eller direkt på [http://localhost:4502/crx/de/index.jsp](http://localhost:4502/crx/de/index.jsp)

### Felsöka innehåll

CRXDE Lite ger direktåtkomst till JCR. Det innehåll som visas via CRXDE Lite begränsas av de behörigheter som tilldelats användaren, vilket innebär att du kanske inte kan se eller ändra allt i JCR beroende på din åtkomst.

+ JCR-strukturen navigeras och ändras med den vänstra navigeringsrutan
+ Om du väljer en nod i det vänstra navigeringsfönstret visas nodegenskaperna i det nedre fönstret.
   + Egenskaper kan läggas till, tas bort eller ändras från rutan
+ Dubbelklicka på en filnod i den vänstra navigeringen för att öppna filens innehåll i den övre högra rutan
+ Tryck på knappen Spara alla längst upp till vänster om du vill behålla ändringarna eller på nedåtpilen bredvid Spara alla om du vill återställa ändringar som inte har sparats.

![CRXDE Lite - Felsöka innehåll](./assets/other-tools/crxde-lite__debugging-content.png)

Ändringar som görs direkt i AEM SDK via CRXDE Lite kan vara svåra att spåra och styra. Se till att ändringar som görs via CRXDE Lite återgår till AEM innehållspaket (`ui.content`) och engagerade i Git. Helst utgår alla innehållsändringar i programmet från kodbasen och flödar in i AEM SDK via distributioner, i stället för att göra ändringar direkt i AEM SDK via CRXDE Lite.

### Åtkomstkontroller för felsökning

Med CRXDE Lite kan du testa och utvärdera åtkomstkontroll på en specifik nod för en viss användare eller grupp (även huvudnamn).

Om du vill få åtkomst till kontrollkonsolen Testa åtkomst i CRXDE Lite går du till:

+ CRXDE Lite > Verktyg > Testa åtkomstkontroll ...

![CRXDE Lite - Testa åtkomstkontroll](./assets/other-tools/crxde-lite__test-access-control.png)

1. Välj en JCR-sökväg som ska utvärderas i fältet Sökväg
1. Använd fältet Principal och markera den användare eller grupp som sökvägen ska utvärderas mot
1. Tryck på knappen Testa

Resultaten visas nedan:

+ __Bana__ upprepar sökvägen som utvärderades
+ __kapitalbelopp__ upprepar användaren eller gruppen som sökvägen utvärderades för
+ __Huvudkonton__ visar alla huvudobjekt som det valda huvudobjektet är en del av.
   + Detta är praktiskt om du vill veta mer om de tillfälliga gruppmedlemskap som kan ge behörigheter via arv
+ __Behörigheter vid sökväg__ visar alla JCR-behörigheter som det valda huvudkontot har på den utvärderade sökvägen

## Förklara fråga

![Förklara fråga](./assets/other-tools/explain-query.png)

Förklara frågebaserade verktyg i AEM SDK:s lokala snabbstart, som ger viktiga insikter i hur AEM tolkar och kör frågor, och ett värdefullt verktyg för att säkerställa att frågor körs på ett bra sätt av AEM.

Förklara frågan finns på:

+ Verktyg > Diagnostik > Frågeprestanda > Fliken Förklara fråga
+ [http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) > Fliken Förklara fråga

## QueryBuilder-felsökning

![QueryBuilder-felsökning](./assets/other-tools/query-debugger.png)

QueryBuilder-felsökaren är ett webbaserat verktyg som hjälper dig att felsöka och förstå sökfrågor med hjälp av AEM [QueryBuilder](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html) syntax.

Felsökaren för QueryBuilder finns på:

+ [http://localhost:4502/libs/cq/search/content/querydebug.html](http://localhost:4502/libs/cq/search/content/querydebug.html)
