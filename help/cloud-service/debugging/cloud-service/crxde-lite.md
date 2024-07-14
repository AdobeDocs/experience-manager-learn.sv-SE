---
title: CRXDE Lite
description: CRXDE Lite är ett klassiskt men ändå kraftfullt verktyg för felsökning i AEM as a Cloud Service Developer-miljöer. CRXDE Lite har en uppsättning funktioner som hjälper till att felsöka från att inspektera alla resurser och egenskaper, manipulera de ändringsbara delarna av JCR och undersöka behörigheter.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
kt: KT-5481
thumbnail: kt-5481.jpg
topic: Development
role: Developer
level: Beginner
exl-id: f3f2c89f-6ec1-49d3-91c7-10a42b897780
duration: 125
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '613'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med CRXDE Lite

CRXDE Lite är __ENDAST__ tillgängligt i AEM as a Cloud Service Development-miljöer (samt lokal AEM SDK).

## Åtkomst till CRXDE Lite på AEM författare

CRXDE Lite är __endast__ tillgängligt i AEM as a Cloud Service Development-miljöer och är __inte__ tillgängligt i Stage- eller Production-miljöer.

Så här öppnar du CRXDE Lite på AEM författare:

1. Logga in på tjänsten AEM as a Cloud Service AEM Author.
1. Navigera till Verktyg > Allmänt > CRXDE Lite

Detta öppnar CRXDE Lite med hjälp av de inloggningsuppgifter och behörigheter som används för att logga in AEM författare.

## Felsöka innehåll

CRXDE Lite ger direktåtkomst till JCR. Det innehåll som visas via CRXDE Lite begränsas av de behörigheter som tilldelats användaren, vilket innebär att du kanske inte kan se eller ändra allt i JCR beroende på din åtkomst.

Observera att `/apps`, `/libs` och `/oak:index` inte kan ändras, vilket innebär att de inte kan ändras under körning av någon användare. Dessa platser i JCR kan endast ändras via koddistributioner.

+ JCR-strukturen navigeras och ändras med den vänstra navigeringsrutan
+ Om du väljer en nod i det vänstra navigeringsfönstret visas nodegenskaperna i det nedre fönstret.
   + Egenskaper kan läggas till, tas bort eller ändras från rutan
+ Dubbelklicka på en filnod i den vänstra navigeringen för att öppna filens innehåll i den övre högra rutan
+ Tryck på knappen Spara alla längst upp till vänster om du vill behålla ändringarna eller på nedåtpilen bredvid Spara alla om du vill återställa ändringar som inte har sparats.

![CRXDE Lite - Felsöka innehåll](./assets/crxde-lite/debugging-content.png)

Det måste göras med försiktighet att göra ändringar i muterbart innehåll under körning i AEM as a Cloud Service utvecklingsmiljöer via CRXDE Lite.
Ändringar som görs direkt till AEM via CRXDE Lite kan vara svåra att spåra och styra. Se till att ändringar som görs via CRXDE Lite återgår till det ändringsbara innehållspaketet (`ui.content`) i AEM-projektet och utförs i Git, för att problemet ska kunna lösas. Helst utgår alla innehållsändringar i programmet från kodbasen och flödar in i AEM via distributioner i stället för att göra ändringar direkt i AEM via CRXDE Lite.

### Åtkomstkontroller för felsökning

Med CRXDE Lite kan du testa och utvärdera åtkomstkontroll på en specifik nod för en viss användare eller grupp (även huvudnamn).

Om du vill få åtkomst till kontrollkonsolen Testa åtkomst i CRXDE Lite går du till:

+ CRXDE Lite > Verktyg > Testa åtkomstkontroll ...

![CRXDE Lite - Testa åtkomstkontroll](./assets/crxde-lite/permissions__test-access-control.png)

1. Välj en JCR-sökväg som ska utvärderas i fältet Sökväg
1. Använd fältet Principal och markera den användare eller grupp som sökvägen ska utvärderas mot
1. Tryck på knappen Testa

Resultaten visas nedan:

+ __Sökvägen__ upprepar sökvägen som utvärderades
+ __Principal__ upprepar användaren eller gruppen som sökvägen utvärderades för
+ __Huvudkonton__ visar alla huvudkonton som det valda huvudkontot är en del av.
   + Detta är praktiskt om du vill veta mer om de tillfälliga gruppmedlemskap som kan ge behörigheter via arv
+ __Behörigheter på sökvägen__ visar alla JCR-behörigheter som det valda huvudkontot har på den utvärderade sökvägen

### Felsökningsaktiviteter som inte stöds

Följande är felsökningsaktiviteter som __inte__ kan utföras i CRXDE Lite.

### Felsöka OSGi-konfigurationer

Distribuerade OSGi-konfigurationer kan inte granskas via CRXDE Lite. OSGi-konfigurationer underhålls i AEM Project `ui.apps`-kodpaketet på `/apps/example/config.xxx`, men vid distributionen till AEM as a Cloud Service-miljöer sparas inte OSGi-konfigurationsresurserna i JCR-konfigurationen, och visas därför inte via CRXDE Lite.

Använd i stället [Developer Console > Konfigurationer](./developer-console.md#configurations) för att granska distribuerade OSGi-konfigurationer.
