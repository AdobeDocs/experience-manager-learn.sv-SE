---
title: Utvecklarkonsol
description: AEM as a Cloud Service tillhandahåller en Developer Console för varje miljö som visar olika detaljer om den AEM-tjänst som körs och som är till hjälp vid felsökning.
feature: Developer Tools
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-5433
thumbnail: kt-5433.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 0499ff9f-d452-459f-b1a2-2853a228efd1
duration: 295
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1562'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med Developer Console

AEM as a Cloud Service tillhandahåller en Developer Console för varje miljö som visar olika detaljer om den AEM-tjänst som körs och som är till hjälp vid felsökning.

Varje AEM as a Cloud Service-miljö har sin egen Developer Console.

## Navigera till Developer Console

Developer Console är tillgängligt per AEM as a Cloud Service-miljö via Cloud Manager.

![Navigera till Developer Console](./assets/developer-console/navigate.png)

1. Navigera till __[Cloud Manager](https://my.cloudmanager.adobe.com/)__
2. Öppna __Program__ som innehåller AEM as a Cloud Service-miljön för att öppna Developer Console.
3. Leta reda på __miljön__ och välj `...`.
4. Välj __Developer Console__ i listrutan.


## Developer Console-åtkomst

För att få åtkomst till och använda Developer Console måste följande behörigheter ges till utvecklarens Adobe ID via [Adobe Admin Console](https://adminconsole.adobe.com).

1. Se till att du i Adobe Org-växlaren kan se Adobe Org för de miljöer du vill inspektera i Developer Console.
1. För att kunna logga in på Developer Console måste utvecklaren vara medlem i någon av följande roller:
   + [Cloud Manager Product&#39;s __Developer - Cloud Service__ Product Profile](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/onboarding/journey/assign-profiles-cloud-manager.html?lang=sv-SE#assign-developer): I det här fallet ser utvecklaren hela listan över miljöer som är tillgängliga under den valda Developer Console-URL:en. Om en utvecklingsmiljö eller RDE har valts i Cloud Manager kan andra utvecklingsmiljöer eller RDE:er i samma program visas.
   + [__AEM-administratörer__ Produktprofil på __AEM-författare__](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/onboarding/journey/assign-profiles-aem.html?lang=sv-SE#aem-product-profiles): I det här fallet begränsas listan med miljöer som beskrivs i den föregående punkten till de relaterade produktprofiler där rollen tilldelas.
1. Utvecklaren måste vara medlem i produktprofilen [__AEM Users__ eller __AEM Administrators__ i AEM Author och/eller Publish](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/onboarding/journey/assign-profiles-aem.html?lang=sv-SE#aem-product-profiles).
   + Om det här medlemskapet inte finns, kommer [status](#status)-dumparna att timeout med ett 401 oauktoriserat fel.

### Felsökning av åtkomst till Developer Console

#### När jag loggar in ser jag inte den miljö jag letar efter

Kontrollera följande:

+ Du har valt rätt Developer Console-URL genom att klicka på de tre punkterna för den valda miljön via Cloud Manager och välja Developer Console.
+ Du har antingen [Cloud Manager Product&#39;s __Developer - Cloud Service__ Product Profile](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/onboarding/journey/assign-profiles-cloud-manager.html?lang=sv-SE#assign-developer) för att se hela listan över miljöer eller så ingår du i [__AEM Administrators__ Product Profile på __AEM Author__](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/onboarding/journey/assign-profiles-aem.html?lang=sv-SE#aem-product-profiles) för den miljö du inte hittar.

#### 401 Otillåtet fel vid dumpningens status

![Developer Console - 401 Obehörig](./assets/developer-console/troubleshooting__401-unauthorized.png)

Om någon status dumpas innebär det att ett otillåtet fel 401 har rapporterats, att din användare inte finns med de nödvändiga behörigheterna i AEM as a Cloud Service eller att inloggningstoken inte är giltig eller har gått ut.

Så här löser du det 401 obehöriga problemet:

1. Se till att din användare är medlem i rätt Adobe IMS-produktprofil (AEM-administratörer eller AEM-användare) för den Developer Console associerade AEM as a Cloud Service-produktinstansen.
   + Kom ihåg att Developer Console har tillgång till två Adobe IMS-produktinstanser - produktinstanserna AEM as a Cloud Service Author och Publish - så att rätt produktprofiler används beroende på vilken tjänstenivå som kräver åtkomst via Developer Console.
1. Logga in på AEM as a Cloud Service (Författare eller Publicera) och kontrollera att användare och grupper har synkroniserats korrekt till AEM.
   + Developer Console kräver att din användarpost skapas i motsvarande AEM-tjänstnivå för att den ska kunna autentiseras till den tjänstnivån.
1. Rensa dina webbläsares cookies och programtillstånd (lokal lagring) och logga in på Developer Console igen, och kontrollera att åtkomsttoken som Developer Console använder är korrekt och inte har gått ut.

## Pod

AEM as a Cloud Service Author and Publish services består av flera instanser för att hantera trafikvariationer och rullande uppdateringar utan driftavbrott. De här instanserna kallas Pods. Markering av rutor i Developer Console definierar omfattningen av de data som ska visas via de andra kontrollerna.

![Developer Console - Pod](./assets/developer-console/pod.png)

+ En pod är en diskret instans som ingår i en AEM-tjänst (författare eller publicera)
+ Pod är övergående, vilket innebär att AEM as a Cloud Service skapar och förstör dem vid behov
+ Det är bara poder som ingår i den associerade AEM as a Cloud Service-miljön som listas i den miljöns Developer Console Pod Switcher.
+ Längst ned i Pod Switcher kan du välja Pods efter tjänstetyp:
   + Alla författare
   + Alla utgivare
   + Alla förekomster

## Status

Status innehåller alternativ för att skriva ut ett specifikt AEM-körningstillstånd i text eller JSON-utdata. Developer Console tillhandahåller liknande information som AEM SDK lokala snabbstartskonsol OSGi, med den markerade skillnaden att Developer Console är skrivskyddat.

![Developer Console - Status](./assets/developer-console/status.png)

### Paket

Paketen innehåller alla OSGi-paket i AEM. Den här funktionen liknar [AEM SDK local quickstart’s OSGi Bundles](http://localhost:4502/system/console/bundles) vid `/system/console/bundles`.

Paket hjälper dig att felsöka genom att:

+ Lista alla OSGi-paket som distribuerats till AEM som en tjänst
+ En lista över varje OSGi-paketstatus, inklusive om de är aktiva eller inte
+ Tillhandahåller information om olösta beroenden som gör att OSGi-paket inte blir aktiva

### Komponenter

Komponenterna listar alla OSGi-komponenter i AEM. Den här funktionen liknar [AEM SDK lokala snabbstartsprogram för OSGi-komponenter](http://localhost:4502/system/console/components) vid `/system/console/components`.

Komponenterna hjälper till vid felsökning genom att:

+ Lista alla OSGi-komponenter som distribuerats till AEM as a Cloud Service
+ Tillhandahålla varje OSGi-komponents tillstånd, inklusive om de är aktiva eller missnöjda
+ Om du anger information i ej tillfredsställande tjänstreferenser kan det leda till att OSGi-komponenter blir aktiva
+ En lista över OSGi-egenskaper och deras värden som är bundna till OSGi-komponenten.
   + Detta visar faktiska värden som injicerats via [OSGi-miljökonfigurationsvariabler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html?lang=sv-SE#environment-specific-configuration-values).

### Konfigurationer

Konfigurationer visar alla OSGi-komponentens konfigurationer (OSGi-egenskaper och -värden). Den här funktionaliteten liknar [AEM SDK lokala snabbstarts OSGi Configuration Manager](http://localhost:4502/system/console/configMgr) på `/system/console/configMgr`.

Konfigurationer hjälper dig att felsöka genom att:

+ Lista OSGi-egenskaper och deras värden med OSGi-komponenten
   + Detta visar INTE faktiska värden som injicerats via [OSGi-miljökonfigurationsvariabler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html?lang=sv-SE#environment-specific-configuration-values). Se [Komponenter](#components) ovan för de inmatade värdena.
+ Hitta och identifiera felkonfigurerade egenskaper

### Oak Index

Oak Indexes innehåller en dump av de noder som definierats under `/oak:index`. Tänk på att detta inte visar sammanfogade index, som inträffar när ett AEM-index ändras.

Oak Indexes hjälper dig att felsöka genom att:

+ En lista över alla Oak Index-definitioner som ger insikter i hur sökfrågor körs i AEM. Tänk på att ändringar i AEM-index inte återspeglas här. Den här vyn är bara användbar för index som endast tillhandahålls av AEM eller endast av den anpassade koden.

### OSGi Services

Komponenterna listar alla OSGi-tjänster. Den här funktionaliteten liknar [AEM SDK lokala snabbstartsprogram i OSGi Services](http://localhost:4502/system/console/services) på `/system/console/services`.

OSGi Services hjälper dig att felsöka genom att:

+ En lista över alla OSGi-tjänster i AEM, tillsammans med det tillhörande OSGi-paketet och alla OSGi-paket som använder det

### Försäljningsjobb

Sling Jobs visar alla kön för Sling Jobs. Den här funktionen liknar [AEM SDK lokala snabbstartsjobb](http://localhost:4502/system/console/slingevent) vid `/system/console/slingevent`.

Sling Jobs hjälper till vid felsökning genom att:

+ Lista över Sling-jobbköer och deras konfigurationer
+ Ge insikter om antalet aktiva, köade och bearbetade Sling-jobb, vilket är praktiskt vid felsökning av arbetsflöden, övergångsarbetsflöden och annat arbete som utförs av Sling-jobb i AEM.

## Java-paket

Med Java-paket kan du kontrollera om ett Java-paket, och version, är tillgängligt för användning i AEM as a Cloud Service. Den här funktionen är densamma som [AEM SDK Local QuickStart&#39;s Dependency Finder](http://localhost:4502/system/console/depfinder) vid `/system/console/depfinder`.

![Developer Console - Java-paket](./assets/developer-console/java-packages.png)

Java-paket används för att förhindra att bildpaket startas på grund av olösta importer eller olösta klasser i skript (HTL, JSP osv.). Om Java Packages rapporterar att inga paket exporterar ett Java-paket (eller om versionen inte matchar den som importeras av ett OSGi-paket):

+ Kontrollera att projektets version av AEM API maven-beroendet matchar miljöns version av AEM Release (och uppdatera om möjligt allt till den senaste versionen).
+ Om extra Maven-beroenden används i Maven-projektet
   + Kontrollera om ett alternativt API från AEM SDK API-beroendet kan användas i stället.
   + Om det extra beroendet krävs kontrollerar du att det är ett OSGi-paket (i stället för en vanlig Jar) och att det är inbäddat i projektets kodpaket (`ui.apps`), på samma sätt som OSGi-kärnpaketet är inbäddat i `ui.apps` -paketet.

## Servlets

Servlets används för att ge insikt i hur AEM löser en URL till en Java-server eller ett Java-skript (HTL, JSP) som slutligen hanterar begäran. Den här funktionaliteten är densamma som [AEM SDK lokala snabbstartsserver Sling Servlet Resolver](http://localhost:4502/system/console/servletresolver) vid `/system/console/servletresolver`.

![Developer Console - Servlets](./assets/developer-console/servlets.png)

Servlets hjälper dig att felsöka:

+ Hur en URL delas upp i adresserbara delar (resurs, väljare, tillägg).
+ Vilken server eller vilket skript en URL löser, vilket hjälper till att identifiera felformaterade URL:er eller felregistrerade servrar/skript.

## Frågor

Frågor ger insikt i vad och hur sökfrågor körs på AEM. Den här funktionaliteten är densamma som [AEM SDK lokala snabbstartsverktyg > Query Performance](http://localhost:4502/libs/granite/operations/content/diagnosistools/queryPerformance.html) -konsol.

Frågor fungerar bara när en viss ruta har valts, eftersom den öppnar den pods Query Performance-webbkonsol, som kräver att utvecklaren har åtkomst till inloggningen i AEM-tjänsten.

![Developer Console - Frågor - Förklara fråga](./assets/developer-console/queries__explain-query.png)

Frågor hjälper dig att felsöka genom att:

+ Förklara hur frågor tolkas, analyseras och körs av Oak. Detta är mycket viktigt när du ska spåra varför en fråga är långsam och förstå hur den kan snabbas upp.
+ Visar de vanligaste frågorna som körs i AEM och kan förklara dem.
+ Visar de långsammaste frågorna som körs i AEM, med möjlighet att förklara dem.
