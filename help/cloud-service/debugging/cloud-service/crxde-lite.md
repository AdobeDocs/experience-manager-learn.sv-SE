---
title: CRXDE Lite
description: CRXDE Lite är ett klassiskt men ändå kraftfullt verktyg för felsökning AEM as a Cloud Service utvecklingsmiljöer. CRXDE Lite har en uppsättning funktioner som hjälper till att felsöka från att inspektera alla resurser och egenskaper, manipulera de ändringsbara delarna av JCR och undersöka behörigheter.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
kt: KT-5481
thumbnail: kt-5481.jpg
topic: Development
role: Developer
level: Beginner
exl-id: f3f2c89f-6ec1-49d3-91c7-10a42b897780
duration: 140
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '613'
ht-degree: 0%

---

# Felsökning AEM as a Cloud Service med CRXDE Lite

CRXDE Lite is __ENDAST__ finns för AEM as a Cloud Service utvecklingsmiljöer (liksom för den lokala AEM SDK).

## Åtkomst till CRXDE Lite på AEM författare

CRXDE Lite is __endast__ som är tillgängliga AEM as a Cloud Service utvecklingsmiljöer, och __not__ som finns i scen- eller produktionsmiljöer.

Så här öppnar du CRXDE Lite på AEM författare:

1. Logga in på AEM as a Cloud Service AEM Author.
1. Navigera till Verktyg > Allmänt > CRXDE Lite

Detta öppnar CRXDE Lite med hjälp av de inloggningsuppgifter och behörigheter som används för att logga in AEM författare.

## Felsöka innehåll

CRXDE Lite ger direktåtkomst till JCR. Det innehåll som visas via CRXDE Lite begränsas av de behörigheter som tilldelats användaren, vilket innebär att du kanske inte kan se eller ändra allt i JCR beroende på din åtkomst.

Observera att `/apps`, `/libs` och `/oak:index` är oföränderliga, vilket innebär att de inte kan ändras under körning av någon användare. Dessa platser i JCR kan endast ändras via koddistributioner.

+ JCR-strukturen navigeras och ändras med den vänstra navigeringsrutan
+ Om du väljer en nod i det vänstra navigeringsfönstret visas nodegenskaperna i det nedre fönstret.
   + Egenskaper kan läggas till, tas bort eller ändras från rutan
+ Dubbelklicka på en filnod i den vänstra navigeringen för att öppna filens innehåll i den övre högra rutan
+ Tryck på knappen Spara alla längst upp till vänster om du vill behålla ändringarna eller på nedåtpilen bredvid Spara alla om du vill återställa ändringar som inte har sparats.

![CRXDE Lite - Felsöka innehåll](./assets/crxde-lite/debugging-content.png)

Det måste göras med försiktighet att göra ändringar i innehåll som kan ändras under körning i AEM as a Cloud Service utvecklingsmiljöer via CRXDE Lite.
Ändringar som görs direkt till AEM via CRXDE Lite kan vara svåra att spåra och styra. Se till att ändringar som görs via CRXDE Lite återgår till AEM innehållspaket (`ui.content`) och engagerade i Git för att säkerställa att problemet löses. Helst utgår alla innehållsändringar i programmet från kodbasen och flödar in i AEM via distributioner i stället för att göra ändringar direkt i AEM via CRXDE Lite.

### Åtkomstkontroller för felsökning

Med CRXDE Lite kan du testa och utvärdera åtkomstkontroll på en specifik nod för en viss användare eller grupp (även huvudnamn).

Om du vill få åtkomst till kontrollkonsolen Testa åtkomst i CRXDE Lite går du till:

+ CRXDE Lite > Verktyg > Testa åtkomstkontroll ...

![CRXDE Lite - Testa åtkomstkontroll](./assets/crxde-lite/permissions__test-access-control.png)

1. Välj en JCR-sökväg som ska utvärderas i fältet Sökväg
1. Använd fältet Principal och markera den användare eller grupp som sökvägen ska utvärderas mot
1. Tryck på knappen Testa

Resultaten visas nedan:

+ __Bana__ upprepar sökvägen som utvärderades
+ __kapitalbelopp__ upprepar användaren eller gruppen som sökvägen utvärderades för
+ __Huvudkonton__ visar alla huvudobjekt som det valda huvudobjektet är en del av.
   + Detta är praktiskt om du vill veta mer om de tillfälliga gruppmedlemskap som kan ge behörigheter via arv
+ __Behörigheter vid sökväg__ visar alla JCR-behörigheter som det valda huvudkontot har på den utvärderade sökvägen

### Felsökningsaktiviteter som inte stöds

Följande är felsökningsaktiviteter som kan __not__ utföras i CRXDE Lite.

### Felsöka OSGi-konfigurationer

Distribuerade OSGi-konfigurationer kan inte granskas via CRXDE Lite. OSGi-konfigurationer underhålls i AEM `ui.apps` kodpaket på `/apps/example/config.xxx`Men när OSGi-konfigurationsresurserna distribueras till AEM as a Cloud Service miljöer bevaras de inte i JCR-konfigurationen och syns därför inte via CRXDE Lite.

Använd i stället [Developer Console > Configuration](./developer-console.md#configurations) för att granska driftsatta OSGi-konfigurationer.
