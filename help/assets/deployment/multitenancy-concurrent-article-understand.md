---
title: Understanding Multitenancy and Concurrent Development
description: Läs om fördelarna, utmaningarna och teknikerna med att hantera en multi-tenant-implementering med Adobe Experience Manager Assets.
feature: Connected Assets
version: 6.5
topic: Development
role: Developer
level: Intermediate
doc-type: Article
exl-id: c9ee29d4-a8a5-4e61-bc99-498674887da5
duration: 463
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '2022'
ht-degree: 0%

---

# Understanding Multitenancy and Concurrent Development {#understanding-multitenancy-and-concurrent-development}

## Introduktion {#introduction}

När flera team distribuerar sin kod till samma AEM miljöer finns det rutiner som de bör följa för att säkerställa att teamen kan arbeta så självständigt som möjligt, utan att behöva ta hjälp av andra team. De kan aldrig elimineras helt, men de här teknikerna minimerar beroendet mellan olika team. För att en samverkande utvecklingsmodell ska bli framgångsrik är det mycket viktigt med bra kommunikation mellan utvecklingsteamen.

När flera utvecklingsteam arbetar i samma AEM är det dessutom troligt att det finns en viss grad av multi-tenancy på gång. Mycket har skrivits om de praktiska övervägandena att försöka stödja flera hyresgäster i en AEM miljö, särskilt när det gäller de utmaningar som man ställs inför när det gäller styrning, drift och utveckling. I den här rapporten behandlas några tekniska problem med att implementera AEM i en multi-tenant-miljö, men många av dessa rekommendationer gäller alla organisationer med flera utvecklingsteam.

Det är viktigt att komma ihåg att AEM kan stödja flera webbplatser och till och med flera varumärken som används i en och samma miljö, men inte erbjuder äkta multi-tenancy. Vissa systemkonfigurationer och systemresurser delas alltid över alla platser som är distribuerade i en miljö. Det här dokumentet ger vägledning för att minimera effekterna av dessa delade resurser och ger förslag för att effektivisera kommunikation och samarbete inom dessa områden.

## Fördelar och utmaningar {#benefits-and-challenges}

Det finns många utmaningar med att implementera en multi-tenant-miljö.

Bland dessa finns:

* Ytterligare teknisk komplexitet
* Ökad utvecklingskostnader
* Beroenden mellan organisationer för delade resurser
* Ökad komplexitet

Trots de problem som kan uppstå har körning av ett multi-tenant-program vissa fördelar, som:

* Minskade hårdvarukostnader
* kortare time-to-market för framtida sajter
* Lägre implementeringskostnader för framtida hyresgäster
* Standardiserad arkitektur och utvecklingspraxis i hela företaget
* En gemensam kodbas

Om verksamheten kräver äkta multi-tenancy, utan kunskaper om andra innehavare och utan delad kod, innehåll eller gemensamma författare, är separata författarinstanser det enda möjliga alternativet. Den övergripande ökningen av utvecklingsinsatsen bör jämföras med besparingarna i infrastruktur- och licenskostnader för att avgöra om detta tillvägagångssätt är det bästa sättet.

## Utvecklingstekniker {#development-techniques}

### Hantera beroenden {#managing-dependencies}

När du hanterar Maven-projektberoenden är det viktigt att alla team använder samma version av ett givet OSGi-paket på servern. För att illustrera vad som kan gå fel när Maven-projekt hanteras fel presenterar vi ett exempel:

Projekt A är beroende av version 1.0 av biblioteket och för version 1.0 är det inbäddat i distributionen till servern. Projekt B är beroende av version 1.1 av biblioteket, foo, för version 1.1 är inbäddad i distributionen.

Låt oss också anta att ett API har ändrats i det här biblioteket mellan version 1.0 och 1.1. I nuläget kommer ett av dessa två projekt inte längre att fungera som de ska.

För att bemöta detta rekommenderar vi att alla Maven-projekt görs underordnade ett huvudreaktorprojekt. Detta reaktorprojekt har två syften: det gör det möjligt att bygga och driftsätta alla projekt tillsammans om så önskas, och det innehåller beroendedeklarationer för alla underordnade projekt. Det överordnade projektet definierar beroenden och deras versioner medan de underordnade projekten endast deklarerar beroenden som de kräver, vilket ärver versionen från det överordnade projektet.

I det här scenariot, om teamet som arbetar med projekt B behöver funktioner i version 1.1 av foo, kommer det i utvecklingsmiljön snabbt att bli uppenbart att den här ändringen kommer att bryta projekt A. Här kan teamen diskutera ändringen och antingen göra Project A kompatibelt med den nya versionen eller leta efter en alternativ lösning för Project B.

Observera att detta inte eliminerar behovet av att dessa team delar detta beroende - det bara sätter fokus på frågor snabbt och tidigt så att teamen kan diskutera eventuella risker och komma överens om en lösning.

### Förhindra kodduplicering {#preventing-code-duplication-nbsp-br}

När du arbetar med flera projekt är det viktigt att se till att koden inte dupliceras. Kodduplicering ökar sannolikheten för felhändelser, kostnaden för systemändringar och den övergripande stelheten i kodbasen. För att undvika dubbelarbete kan du lägga in den vanliga logiken i återanvändbara bibliotek som kan användas i flera projekt.

För att tillgodose detta behov rekommenderar vi utveckling och underhåll av ett kärnprojekt som alla team kan lita på och bidra till. När du gör det är det viktigt att se till att detta kärnprojekt inte i sin tur är beroende av något av de enskilda teamens projekt, vilket möjliggör oberoende driftsättning samtidigt som det främjar återanvändning av kod.

Några exempel på kod som är vanliga i en huvudmodul är:

* Systemomfattande konfigurationer som:
   * OSGi-konfigurationer
   * Servletfilter
   * Resurslösningsmappningar
   * Rörledningar för Sling Transformer
   * Felhanterare (eller använd ACS AEM Commons Error Page Handler1)
   * Auktoriseringsservrar för behörighetskänslig cachelagring
* Verktygsklasser
* Affärslogik
* Integrationslogik från tredje part
* Användargränssnittsövertäckningar för redigering
* Andra anpassningar som krävs för redigering, till exempel anpassade widgetar
* Starta arbetsflöden
* Vanliga designelement som används på olika webbplatser

*Modulär projektarkitektur*

Detta eliminerar inte behovet av att flera team är beroende av och kan uppdatera samma koduppsättning. Genom att skapa ett kärnprojekt har vi minskat storleken på den kodbas som delas mellan olika team, men inte eliminerat behovet av delade resurser.

För att säkerställa att de ändringar som görs i detta kärnpaket inte stör systemets funktion rekommenderar vi att en högre utvecklare eller grupp av utvecklare upprätthåller tillsyn. Ett alternativ är att ha ett enda team som hanterar alla ändringar i det här paketet. Ett annat är att låta team skicka in pull-begäranden som granskas och sammanfogas av dessa resurser. Det är viktigt att en styrningsmodell utformas och godkänns av teamen och att utvecklarna följer den.

## Hantera distributionsomfång  {#managing-deployment-scope}

När olika team distribuerar sin kod till samma databas är det viktigt att de inte skriver över varandras ändringar. AEM har en funktion som styr detta när innehållspaket distribueras, filtret. xml-fil. Det är viktigt att det inte finns någon överlappning mellan filtren.  xml-filer, annars kan distributionen av ett team radera ett annat teams tidigare distribution. Se följande exempel på välutformade respektive problematiska filterfiler för att illustrera detta:

/apps/my-company vs. /apps/my-company/my-site

/etc/clientlibs/my-company vs/etc/clientlibs/my-company/my-site

/etc/designs/my-company vs. /etc/designs/my-company/my-site

Om varje team uttryckligen konfigurerar sin filterfil till den eller de webbplatser de arbetar med, kan varje team distribuera sina komponenter, klientbibliotek och webbplatsdesigner separat utan att radera varandras ändringar.

Eftersom det är en global systemsökväg som inte är specifik för en webbplats, bör följande servertjänst ingå i huvudprojektet, eftersom ändringar som görs här kan påverka alla grupper:

/apps/sling/servlet/errorhandler

### Övertäckningar {#overlays}

Övertäckningar används ofta för att utöka eller ersätta AEM, men om du använder en övertäckning påverkas hela AEM (dvs. alla funktionsändringar görs tillgängliga för alla innehavare). Detta skulle vara ytterligare komplicerat om hyresgästerna hade olika krav för övertäckningen. I idealfallet bör företagsgrupperna samarbeta för att komma överens om funktionaliteten och utseendet hos AEM administrativa konsoler.

Om konsensus inte kan nås mellan de olika affärsenheterna är en möjlig lösning att helt enkelt inte använda övertäckningar. Skapa i stället en egen kopia av funktionen och visa den via olika sökvägar för varje klientorganisation. På så sätt kan varje klientorganisation ha en helt annan användarupplevelse, men det här tillvägagångssättet ökar också kostnaden för implementering och efterföljande uppgraderingar.

### Arbetsflödeskörare {#workflow-launchers}

AEM använder arbetsflödeskörning för att automatiskt starta arbetsflödeskörning när angivna ändringar görs i databasen. AEM innehåller flera startfunktioner, t.ex. för att skapa återgivningar och extrahera metadata för nya och uppdaterade resurser. Även om det är möjligt att lämna dessa startprogram som de är i en flerinnehavarmiljö, och om de har olika krav för startprogram och/eller arbetsflödesmodeller, är det troligt att enskilda startprogram behöver skapas och underhållas för varje innehavare. Dessa startprogram måste konfigureras så att de kan köras på klientorganisationens uppdateringar samtidigt som innehåll från andra hyresgäster lämnas orört. Det är enkelt att uppnå detta genom att använda startprogram på angivna databassökvägar som är klientspecifika.

### Vanity-URL:er {#vanity-urls}

AEM tillhandahåller funktionalitet-URL som kan anges per sida. Oron med detta tillvägagångssätt i ett multi-tenant-scenario är att AEM inte garanterar att det är unikt mellan de vanity-URL:er som konfigurerats på det här sättet. Om två olika användare konfigurerar samma vanlighetssökväg för olika sidor kan ett oväntat beteende påträffas. Därför rekommenderar vi att du använder mod_rewrite-regler i Apache-dispatcherinstanserna, som tillåter en central konfigurationspunkt i kombination med regler för utgående resurslösare.

### Komponentgrupper {#component-groups}

När du utvecklar komponenter och mallar för flera redigeringsgrupper är det viktigt att du använder egenskaperna componentGroup och allowedPaths på ett effektivt sätt. Genom att utnyttja dessa effektivt med webbplatsdesigner kan vi se till att författare från Brand A bara ser komponenter och mallar som har skapats för deras webbplats medan skribenter från Brand B bara ser sina.

### Testning {#testing}

En bra arkitektur och öppna kommunikationskanaler kan förhindra att defekter introduceras i oväntade delar av sajten, men dessa metoder är inte förifyllda. Därför är det viktigt att till fullo testa vad som distribueras på plattformen innan något släpps i produktionen. Detta kräver samordning mellan teamen om deras lanseringscykler och förstärker behovet av en serie automatiska tester som täcker så mycket funktionalitet som möjligt. Och eftersom ett system delas av flera team blir prestanda, säkerhet och belastningstestning viktigare än någonsin.

## Verksamhetsöverväganden {#operational-considerations}

### Delade resurser {#shared-resources}

AEM körs i en enda JVM. Alla distribuerade AEM-program delar resurser med varandra utöver de resurser som redan används i den normala AEM. I själva JVM-rymden finns ingen logisk separation av trådar, och de begränsade resurser som är tillgängliga för AEM, som minne, processor och disk-I/O, delas också. Eventuella resurser som förbrukas av hyresgäster kommer ofrånkomligen att påverka andra systeminnehavare.

### Prestanda {#performance}

Om du inte följer AEM bästa praxis är det möjligt att utveckla program som förbrukar resurser utöver vad som anses vara normalt. Exempel på detta är att utlösa många omfattande arbetsflödesåtgärder (till exempel DAM Update Asset), använda MSM push-on-modify-åtgärder över många noder eller använda dyra JCR-frågor för att återge innehåll i realtid. Dessa kommer oundvikligen att påverka prestanda för andra klientapplikationer.

### Loggning {#logging}

AEM tillhandahåller färdiga gränssnitt för robust loggkonfiguration som kan användas till våra fördelar i delade utvecklingsscenarier. Genom att ange separata loggare för varje varumärke, per paketnamn, kan vi uppnå en viss grad av loggseparation. Medan systemomfattande åtgärder som replikering och autentisering fortfarande loggas på en central plats, kan icke-delad anpassad kod loggas separat, vilket underlättar övervakning och felsökning för varje varumärkes tekniska team.

### Säkerhetskopiering och återställning {#backup-and-restore}

På grund av JCR-databasens natur fungerar traditionella säkerhetskopieringar i hela databasen i stället för i en enskild innehållssökväg. Det är därför inte enkelt att separera säkerhetskopieringar per klient. Omvänt kommer återställning från en säkerhetskopia att återställa innehåll och databasnoder för alla klientorganisationer i systemet. Även om det är möjligt att utföra riktade innehållssäkerhetskopieringar, använda verktyg som VLT, eller att välja innehåll som ska återställas genom att bygga ett paket i en separat miljö, kan dessa\
Metoderna omfattar inte så lätt konfigurationsinställningar eller programlogik och kan vara krångliga att hantera.

## Säkerhetsaspekter {#security-considerations}

### ACL:er {#acls}

Det går förstås att använda åtkomstkontrollistor för att styra vilka som har åtkomst att visa, skapa och ta bort innehåll baserat på innehållssökvägar, vilket kräver att användargrupper skapas och hanteras. Svårigheten med att underhålla åtkomstkontrollistor och grupper beror på vikten av att se till att varje klientorganisation inte har någon kunskap om andra och huruvida de distribuerade programmen är beroende av delade resurser. För att säkerställa effektiv åtkomstkontroll, användar- och gruppadministration rekommenderar vi att ni har en centraliserad grupp med nödvändig tillsyn för att säkerställa att dessa åtkomstkontroller och principer överlappar (eller inte överlappar) på ett sätt som främjar effektivitet och säkerhet.
