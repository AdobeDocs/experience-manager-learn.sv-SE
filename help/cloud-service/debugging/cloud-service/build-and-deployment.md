---
title: Bygg och driftsätta
description: Adobe Cloud Manager underlättar kodbygget och distributionen AEM som en Cloud Service. Fel kan uppstå under steg i byggprocessen, vilket kräver åtgärder för att åtgärda dem. Den här guiden går igenom hur man förstår vanliga fel i distributionen och hur man bäst hanterar dem.
feature: Utvecklarverktyg
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 5434
thumbnail: kt-5424.jpg
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: 7200601c1b59bef5b1546a100589c757f25bf365
workflow-type: tm+mt
source-wordcount: '2529'
ht-degree: 0%

---


# Felsöka AEM som Cloud Service och distributioner

Adobe Cloud Manager underlättar kodbygget och distributionen AEM som en Cloud Service. Fel kan uppstå under steg i byggprocessen, vilket kräver åtgärder för att åtgärda dem. Den här guiden går igenom hur man förstår vanliga fel i distributionen och hur man bäst hanterar dem.

![Molnet hanterar byggpipeline](./assets/build-and-deployment/build-pipeline.png)

## Validering

Valideringssteget säkerställer helt enkelt att de grundläggande konfigurationerna för Cloud Manager är giltiga. Vanliga valideringsfel:

### Miljön är i ett ogiltigt tillstånd

+ __Felmeddelande:__ Miljön är i ett ogiltigt tillstånd.
   ![Miljön är i ett ogiltigt tillstånd](./assets/build-and-deployment/validation__invalid-state.png)
+ __Orsak:__ Rörledningens målmiljö är i ett övergångstillstånd då den inte kan ta emot nya byggen.
+ __Upplösning:__ Vänta tills tillståndet har lösts till ett öppet (eller uppdaterat tillgängligt) tillstånd. Om miljön tas bort kan du återskapa miljön eller välja en annan miljö att bygga på.

### Miljön som är associerad med pipelinen kan inte hittas

+ __Felmeddelande:__ Miljön har markerats som borttagen.
   ![Miljön har markerats som borttagen](./assets/build-and-deployment/validation__environment-marked-as-deleted.png)
+ __Orsak:__ Miljön som pipelinen är konfigurerad för har tagits bort.
Även om en ny miljö med samma namn återskapas kommer Cloud Manager inte automatiskt att koppla pipelinen till den miljö med samma namn.
+ __Upplösning:__ Redigera pipelinekonfigurationen och välj sedan den miljö som ska distribueras på nytt.

### Git-grenen som är associerad med pipelinen kan inte hittas

+ __Felmeddelande:__ Ogiltig pipeline: XXXXXX. Orsak=Förgrening=xxxx hittades inte i databasen.
   ![Ogiltig pipeline: XXXXXX. Orsak=Förgrening=xxxx hittades inte i databasen](./assets/build-and-deployment/validation__branch-not-found.png)
+ __Orsak:__ Git-grenen som pipelinen är konfigurerad att använda har tagits bort.
+ __Upplösning:__ Återskapa den saknade Git-grenen med exakt samma namn eller konfigurera om pipelinen så att den byggs från en annan befintlig gren.

## Build &amp; Unit Testing

![Bygg- och enhetstestning](./assets/build-and-deployment/build-and-unit-testing.png)

Fasen Build and Unit Testing utför en Maven-bygge (`mvn clean package`) av projektet som är utcheckad från pipelinens konfigurerade Git-gren.

Fel som upptäcks i den här fasen bör kunna reproduceras lokalt, med följande undantag:

+ Ett maven-beroende som inte är tillgängligt för [Maven Central](https://search.maven.org/) används och Maven-databasen som innehåller beroendet är antingen:
   + Det går inte att nå från Cloud Manager, till exempel en privat intern Maven-databas, eller så kräver Maven-databasen autentisering och felaktiga autentiseringsuppgifter har angetts.
   + Inte explicit registrerad i projektets `pom.xml`. Observera att Maven-databaser inte bör inkluderas eftersom byggtiden ökar.
+ Enhetstester misslyckas på grund av timingproblem. Detta kan inträffa när enhetstester är tidskänsliga. En stark indikator förlitar sig på `.sleep(..)` i testkoden.
+ Användning av Maven-plugin-program som inte stöds.

## Kodskanning

![Kodskanning](./assets/build-and-deployment/code-scanning.png)

Kodskanning utför statisk kodanalys med en blandning av Java och AEM bästa praxis.

Kodskanning resulterar i ett byggfel om det finns en allvarlig säkerhetslucka i koden. Mindre överträdelser kan åsidosättas, men vi rekommenderar att de åtgärdas. Observera att kodskanningen är ofullständig och kan resultera i [falskt positiv](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/using-cloud-manager/test-results/overview-test-results.html#dealing-with-false-positives).

Lös problem med kodskanning genom att hämta den CSV-formaterade rapporten från Cloud Manager via knappen **Hämta information** och granska alla poster.

Mer information finns i AEM specifika regler i Cloud Manager-dokumentationen [anpassade AEM-specifika regler för kodskanning](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/using/how-to-use/custom-code-quality-rules.html).

## Skapa bilder

![Skapa bilder](./assets/build-and-deployment/build-images.png)

Bygge image-konfigurationer används för att kombinera de inbyggda kodartefakterna som skapas i steget Build &amp; Unit Testing med AEM Release, så att de utgör en enda distributionsbar artefakt.

Även om kodbygge- och kompileringsproblem påträffas under bygg- och enhetstestning kan det uppstå konfigurationsproblem eller strukturella problem när du försöker kombinera den anpassade build-artefakten med AEM.

### Duplicera OSGi-konfigurationer

När flera OSGi-konfigurationer löses via runmode för AEM, misslyckas steget Build Image med felet:

```
[ERROR] Unable to convert content-package [/tmp/packages/enduser.all-1.0-SNAPSHOT.zip]: 
Configuration ‘com.example.ExampleComponent’ already defined in Feature Model ‘com.example.groupId:example.all:slingosgifeature:xxxxx:X.X’, 
set the ‘mergeConfigurations’ flag to ‘true’ if you want to merge multiple configurations with same PID
```

#### Orsak 1

+ __Orsak:__ Det AEM hela paketet innehåller flera kodpaket och samma OSGi-konfiguration tillhandahålls av fler än ett av kodpaketen, vilket resulterar i en konflikt, vilket resulterar i att steget Skapa bild inte kan avgöra vilken som ska användas, vilket gör att bygget misslyckas. Observera att detta inte gäller OSGi-fabrikskonfigurationer, så länge de har unika namn.
+ __Upplösning:__ Granska alla kodpaket (inklusive eventuella inkluderade kodpaket från tredje part) som distribueras som en del av AEM program, och leta efter duplicerade OSGi-konfigurationer som via runmode kan matchas mot målmiljön. Felmeddelandets vägledning om&quot;set the mergeConfigurations flag to true&quot; är inte möjlig i AEM som en molntjänst och bör ignoreras.

#### Orsak 2

+ __Orsak:__ Det AEM projektet innehåller felaktigt samma kodpaket två gånger, vilket resulterar i att en OSGi-konfiguration i det paketet dupliceras.
+ __Upplösning:__ Granska alla pom.xml-paket som är inbäddade i hela projektet och kontrollera att de har  `filevault-package-maven-plugin` [](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-project-content-package-structure.html#cloud-manager-target) konfigurationsuppsättningen  `<cloudManagerTarget>none</cloudManagerTarget>`.

### Felformaterat ompekningsskript

Repoinit-skript definierar baslinjeinnehåll, användare, åtkomstkontrollistor osv. I AEM som Cloud Service tillämpas repoinit-skript under Build Image, men på AEM SDK:s lokala snabbstart tillämpas de när OSGi-repoinit-fabrikskonfigurationen aktiveras. På grund av detta kan Repoinit-skript i tysthet misslyckas (med loggning) på AEM SDK:s lokala snabbstart, men orsakar fel i steget Skapa bild och avbryter distributionen.

+ __Orsak:__ Ett repeteringsskript har fel format. Observera att detta kan lämna databasen i ett ofullständigt tillstånd som alla repoinit-skript efter att det misslyckade skriptet kommer att köras mot databasen.
+ __Upplösning:__ Granska AEM SDK:s lokala snabbstart när ompekningsskriptets OSGi-konfiguration distribueras för att avgöra om och vilka fel som finns.

### Otillfredsställd återpeka innehållsberoende

Repoinit-skript definierar baslinjeinnehåll, användare, åtkomstkontrollistor osv. I AEM SDK:s lokala snabbstart används repoinit-skript när repoden OSGi-fabrikskonfigurationen aktiveras, med andra ord efter att databasen är aktiv och kan ha fått innehållsändringar direkt eller via innehållspaket. I AEM som en Cloud Service tillämpas repoinit-skript under Build Image (Skapa bild) mot en databas som kanske inte innehåller innehåll som repoinit-skriptet är beroende av.

+ __Orsak:__ Ett poinit-skript beror på innehåll som inte finns.
+ __Upplösning:__ Kontrollera att innehållet som pekskriptet är beroende av finns. Detta visar ofta på ett otillräckligt definierat repoinitskript som saknar direktiv som definierar de saknade, men nödvändiga, innehållsstrukturerna. Detta kan reproduceras lokalt genom att ta bort AEM, packa upp JAR-filen och lägga till den OSGi-konfiguration för repoinit som innehåller repoinit-skriptet i installationsmappen och starta AEM. Felet kommer att finnas i den lokala snabbstartsloggen AEM SDK.


### Programmets Core Components-version är större än den distribuerade versionen

_Problemet gäller endast icke-produktionsmiljöer som INTE automatiskt uppdaterar till den senaste AEM._

AEM som Cloud Service inkluderar automatiskt den senaste Core Components-versionen i varje AEM release, vilket innebär att efter en AEM när en Cloud Service uppdateras, automatiskt eller manuellt, har den senaste versionen av Core Components distribuerats till den.

Går att utföra om steget Skapa bild misslyckas när:

+ Distribueringsprogrammet uppdaterar Core Components maven-beroendeversionen i `core`-projektet (OSGi bundle)
+ Distribueringsprogrammet distribueras sedan till en sandlåda (icke-produktion) AEM som en Cloud Service som inte har uppdaterats för att använda en AEM som innehåller den nya Core Components-versionen.

För att förhindra detta fel ska du, när en uppdatering av AEM som en Cloud Service finns tillgänglig, inkludera uppdateringen som en del av nästa build/deploy och alltid se till att uppdateringarna inkluderas efter att Core Components-versionen har ökats i programkodbasen.

+ __Symtom:__
Stegen Skapa bild misslyckas med en FEL-rapportering som 
`com.adobe.cq.wcm.core.components...` paket i specifika versionsintervall kunde inte importeras av  `core` projektet.

   ```
   [ERROR] Bundle com.example.core:0.0.3-SNAPSHOT is importing package(s) Package com.adobe.cq.wcm.core.components.models;version=[12.13,13) in start level 20 but no bundle is exporting these for that start level in the required version range.
   [ERROR] Analyser detected errors on feature 'com.adobe.granite:aem-ethos-app-image:slingosgifeature:aem-runtime-application-publish-dev:1.0.0-SNAPSHOT'. See log output for error messages.
   [INFO] ------------------------------------------------------------------------
   [INFO] BUILD FAILURE
   [INFO] ------------------------------------------------------------------------
   ```

+ __Orsak:__  Programmets OSGi-paket (som definieras i  `core` projektet) importerar Java-klasser från kärnberoendet för kärnkomponenter, på en annan versionsnivå än vad som distribueras till AEM som en Cloud Service.
+ __Upplösning:__
   + Använd Git för att återgå till en fungerande implementering som finns före den inkrementella versionen av Core Component. Överför implementeringen till en Cloud Manager Git-gren och utför en uppdatering av miljön från den här grenen. Detta kommer att uppgradera AEM som en Cloud Service till den senaste AEM versionen, som kommer att innehålla den senare Core Components-versionen. När AEM som Cloud Service har uppdaterats till den senaste AEM versionen, som har den senaste Core Components-versionen, distribuerar du den kod som misslyckades.
   + Om du vill återskapa det här problemet lokalt måste du se till att AEM SDK-versionen är samma version av AEM som AEM som en Cloud Service-miljö använder.


### Skapa ett supportärende för Adobe

Om ovanstående felsökningsmetoder inte löser problemet kan du skapa ett supportärende för Adobe via:

+ [Adobe Admin Console](https://adminconsole.adobe.com)  > fliken Support > Create Case

   _Om du är medlem i flera Adobe-organisationer måste du se till att den Adobe-organisation som har misslyckad pipeline är markerad i Adobe Orgs-väljaren innan du skapar ärendet._

## Distribuera till

Steget Distribuera till ansvarar för att ta kodartefakten som genereras i Build Image, startar nya AEM Author- och Publish-tjänster som använder den och tar sedan bort alla gamla AEM Author- och Publish-tjänster när de lyckas. Även paket och index med ändringsbart innehåll installeras och uppdateras i det här steget.

Bekanta dig med [AEM som en Cloud Service loggar](./logs.md) innan du felsöker steget Distribuera till. Loggen `aemerror` innehåller information om start och avstängning av poder som kan vara relevant för distribuering av problem. Observera att loggen som är tillgänglig via knappen Hämta logg i steget Distribuera till i Cloud Manager inte är `aemerror`-loggen och inte innehåller detaljerad information som gäller när programmen startas.

![Distribuera till](./assets/build-and-deployment/deploy-to.png)

De tre främsta anledningarna till varför Distribuera till steg kan misslyckas:

### Molnhanterarens pipeline innehåller en gammal AEM

+ __Orsak:__ En Cloud Manager-pipeline innehåller en äldre version av AEM än vad som distribueras till målmiljön. Detta kan inträffa när en pipeline återanvänds och pekas på en ny miljö som kör en senare version av AEM. Detta kan identifieras genom att kontrollera om miljöns AEM är större än pipelinens AEM version.
   ![Molnhanterarens pipeline innehåller en gammal AEM](./assets/build-and-deployment/deploy-to__pipeline-holds-old-aem-version.png)
+ __Upplösning:__
   + Om målmiljön har en tillgänglig uppdatering väljer du Uppdatera från miljöns åtgärder och kör sedan bygget igen.
   + Om målmiljön inte har en tillgänglig uppdatering innebär det att den kör den senaste versionen av AEM. Lös detta genom att ta bort pipelinen och återskapa den.


### Molnhanteraren gör timeout

Kod som körs under starten av den nyligen distribuerade AEM tar så lång tid att Cloud Manager-timeout inträffar innan distributionen kan slutföras. I dessa fall kan distributionen eventuellt lyckas, även om Cloud Manager-statusen rapporterades som Misslyckad.

+ __Orsak:__ Anpassad kod kan köra åtgärder, som stora frågor eller innehållsgenomgångar, som aktiveras tidigt i OSGi-paketet eller komponentens livscykler, vilket avsevärt försenar starttiden för AEM.
+ __Upplösning:__ Granska implementeringen av kod som körs tidigt i OSGi Bundles livscykel och granska  `aemerror` loggarna för AEM Author och Publish services vid tidpunkten för felet (loggtid i GMT) enligt Cloud Manager, och sök efter loggmeddelanden som indikerar eventuella egna loggprocesser som körs.

### Inkompatibel kod eller konfiguration

De flesta kod- och konfigurationsfel fångas upp tidigare i bygget, men det är möjligt att anpassad kod eller konfiguration inte är kompatibel med AEM som en Cloud Service och inte identifieras förrän den körs i behållaren.

+ __Orsak:__ Anpassad kod kan anropa långsamma åtgärder, som stora frågor eller innehållsgenomgångar, som aktiveras tidigt i OSGi-paketet eller komponentens livscykler, vilket avsevärt försenar starttiden för AEM.
+ __Lösning:__ Granska  `aemerror` loggarna för AEM Author och Publish services vid tidpunkten (loggtid i GMT) för felet enligt Cloud Manager.
   1. Granska loggarna efter eventuella FEL som genererats av Java-klasserna i det anpassade programmet. Lös eventuella problem, tryck på den fasta koden och bygg om pipeline.
   1. Granska loggarna för eventuella FEL som rapporterats av AEM som du utökar/interagerar med i ditt anpassade program och undersöka dessa. dessa fel kan inte direkt tillskrivas Java-klasser. Lös eventuella problem, tryck på den fasta koden och bygg om pipeline.

### Inkludera /var i innehållspaketet

`/var` kan ändras och innehåller ett antal olika typer av transient runtime-innehåll. Inkludera `/var` i innehållspaket (ex. `ui.content`) som distribueras via Cloud Manager kan få distributionen att misslyckas.

Det här problemet är svårt att identifiera eftersom det inte leder till ett fel i den initiala distributionen, bara i efterföljande distributioner. Exempel på märkbara symtom är:

+ Den initiala distributionen lyckas, oavsett hur nytt eller ändrat innehåll som kan ändras, som är en del av distributionen, verkar inte finnas i AEM Publish-tjänsten.
+ Aktivering/inaktivering av innehåll i AEM Author är blockerad
+ Efterföljande distributioner misslyckas i steget Distribuera till, med felet Distribuera till efter cirka 60 minuter.

Så här validerar du problemet:

1. Fastställer att minst ett innehållspaket som ingår i distributionen skriver till `/var`.
1. Kontrollera att den primära (fetstilta) distributionskön är blockerad på:
   + AEM Author > Tools > Deployment > Distribution
      ![Blockerad distributionskö](./assets/build-and-deployment/deploy-to__var--distribution.png)
1. Om efterföljande distribution misslyckas hämtar du loggarna för distribution av Cloud Manager med knappen Hämtningslogg:

   ![Hämta distribution till loggar](./assets/build-and-deployment/deploy-to__var--download-logs.png)

   ... och verifiera att det finns ungefär 60 minuter mellan loggsatserna:

   ```
   2020-01-01T01:01:02+0000 Begin deployment in aem-program-x-env-y-dev [CorrelationId: 1234]
   ```

   ... and ...

   ```
   2020-01-01T02:04:10+0000 Failed deployment in aem-program-x-env-y-dev
   ```

   Observera att loggen inte innehåller dessa indikatorer för de initiala distributioner som rapporterar som lyckade, och endast för efterföljande misslyckade distributioner.

+ __Orsak:__ AEM som används för att distribuera innehållspaket till AEM Publish-tjänsten kan inte skriva till  `/var` på AEM Publish. Detta leder till att distributionen av innehållspaketet till AEM Publish-tjänsten misslyckas.
+ __Lösning:__ Följande sätt att lösa detta problem visas i den ordning du vill:
   1. Om `/var`-resurserna inte är nödvändiga tar du bort resurser under `/var` från innehållspaket som distribueras som en del av programmet.
   2. Om `/var`-resurserna är nödvändiga definierar du nodstrukturerna med [repoinit](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/overview.html#repoinit). Repoinit-skript kan riktas mot AEM Author, AEM Publish eller båda, via OSGi-runmodes.
   3. Om `/var`-resurserna bara krävs av AEM författare och inte kan modelleras med [repoinit](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/overview.html#repoinit), flyttar du dem till ett diskret innehållspaket, som bara installeras på AEM Author genom att [bädda in](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-project-content-package-structure.html#embeddeds) det i `all`-paketet i en AEM Author-körlägesmapp (`<target>/apps/example-packages/content/install.author</target>`).
   4. Ange lämpliga åtkomstkontrollistor till `sling-distribution-importer`-tjänstanvändaren enligt beskrivningen i denna [Adobe KB](https://helpx.adobe.com/in/experience-manager/kb/cm/cloudmanager-deploy-fails-due-to-sling-distribution-aem.html).

### Skapa ett supportärende för Adobe

Om ovanstående felsökningsmetoder inte löser problemet kan du skapa ett supportärende för Adobe via:

+ [Adobe Admin Console](https://adminconsole.adobe.com)  > fliken Support > Create Case

   _Om du är medlem i flera Adobe-organisationer måste du se till att den Adobe-organisation som har misslyckad pipeline är markerad i Adobe Orgs-väljaren innan du skapar ärendet._
