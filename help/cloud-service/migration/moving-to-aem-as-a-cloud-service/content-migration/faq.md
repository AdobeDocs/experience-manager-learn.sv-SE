---
title: Vanliga frågor om migrering av as a Cloud Service innehåll
description: Få svar på vanliga frågor om innehållsmigrering till AEM as a Cloud Service.
version: Cloud Service
doc-type: article
topic: Migration
feature: Migration
role: Architect, Developer
level: Beginner
jira: KT-11200
thumbnail: kt-11200.jpg
exl-id: bdec6cb0-34a0-4a28-b580-4d8f6a249d01
duration: 569
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '2146'
ht-degree: 0%

---

# Vanliga frågor om migrering av as a Cloud Service innehåll

Få svar på vanliga frågor om innehållsmigrering till AEM as a Cloud Service.

## Terminologi

+ **AEMaaCS**: [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/overview/introduction.html)
+ **BPA**: [Best Practices Analyzer](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/best-practices-analyzer/overview-best-practices-analyzer.html)
+ **CTT**: [Verktyget Innehållsöverföring](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/overview-content-transfer-tool.html)
+ **CAM**: [Cloud Acceleration Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-acceleration-manager/using-cam/getting-started-cam.html)
+ **IMS**: [Identity Management System](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/security/ims-support.html)
+ **DM**: [Dynamic Media](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/dynamicmedia/dm-journey/dm-journey-part1.html)

Använd mallen nedan om du vill ha mer information när du skapar supportbiljetter för CTT-relaterade Adobe.

![Mall för supportanmälan för innehållsmigrering på Adobe](../../assets/faq/adobe-support-ticket-template.png) { align=&quot;center&quot; }

## Allmänna frågor om innehållsmigrering

### F: Vilka olika metoder använder man för att migrera innehåll till AEM som Cloud Service?

Det finns tre olika metoder

+ Använda verktyget Innehållsöverföring (AEM 6.3+ → AEMaaCS)
+ Via Package Manager (AEM → AEMaaCS)
+ Utanför paketet med bulkimporttjänst för resurser (S3/Azure → AEMaaCS)

### F: Finns det någon gräns för hur mycket innehåll som kan överföras med CTT?

Nej. CTT som ett verktyg kan extrahera från AEM och importera till AEMaaCS. Det finns dock specifika begränsningar för AEMaaCS-plattformen som bör beaktas före migreringen.

Mer information finns i [krav för molnmigrering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/prerequisites-content-transfer-tool.html).

### F: Jag har den senaste BPA-rapporten från mitt källsystem, vad ska jag göra med den?

Exportera rapporten som CSV och överför den sedan till Cloud Acceleration Manager, [som är kopplad till din IMS-organisation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-acceleration-manager/using-cam/getting-started-cam.html). Gå sedan igenom granskningsprocessen som [i beredskapsfasen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-acceleration-manager/using-cam/cam-readiness-phase.html).

Granska den bedömning av kod och innehållskomplexitet som verktyget erbjuder och notera associerade åtgärdsobjekt som leder till eftersläpning i kodomfaktoriseringen eller utvärdering av molnmigrering.

### F: Rekommenderas att extrahera information om källförfattare och inmatning till AEMaaCS-författare och publicera?

Vi rekommenderar alltid att du utför 1:1-extrahering och -förtäring mellan författare- och publiceringsnivåer. Det går dock att extrahera källproduktionsförfattare och importera det till Dev, Stage och Production CS.

### F: Finns det något sätt att uppskatta tiden det tar att migrera innehåll från AEM till AEMaaCS med hjälp av CTT?

Eftersom migreringsprocessen är beroende av internetbandbredd, heap som allokerats för CTT-processen, ledigt minne och disk-I/O som är beroende av varje källsystem, rekommenderas att proof of migrations körs tidigt och att datapunkter extrapoleras för att få en uppskattning.

### F: Hur påverkas min AEM prestanda om jag startar extraheringsprocessen för CTT?

CTT-verktyget körs i en egen Java™-process som tar upp till 4 GB heap, som kan konfigureras med OSGi-konfiguration. Antalet kan komma att ändras, men du kan hoppa till Java™-processen och ta reda på det.

Om AZCopy är installerat och/eller Pre copy-alternativ/valideringsfunktion är aktiverad förbrukar AZCopy-processen processorcykler.

Förutom jvm använder verktyget även disk-I/O för att lagra data på ett tillfälligt övergångsutrymme som rensas efter extraheringscykeln. Förutom RAM, CPU och disk-I/O använder CTT-verktyget även källsystemets nätverksbandbredd för att överföra data till Azure-blobbutiken.

Mängden resurser som extraheringsprocessen för CTT tar beror på antalet noder, antalet blober och deras sammanlagda storlek. Det är svårt att skapa en formel och därför rekommenderas att köra ett litet migreringsbevis för att fastställa kraven för källserverns storlek.

Om klonmiljöer används för migrering kommer detta inte att påverka resursutnyttjandet för produktionsservern, utan har egna nackdelar när det gäller att synkronisera innehåll mellan Live-produktion och kloning

### F: I mitt källförfattarsystem har vi konfigurerat enkel inloggning så att användarna kan autentiseras i Author-instansen. Måste jag använda funktionen för användarmappning i CTT i det här fallet?

Det korta svaret är &quot;**Ja**&quot;.

CTT-extrahering och -förtäring **utan** användarmappning migrerar bara innehållet, de associerade principerna (användare, grupper) från AEM till AEMaaCS. Men dessa användare (identiteter) som finns i Adobe IMS och har (etablerats med) tillgång till AEMaaCS-instansen för att kunna autentisera. Jobbet för [användarmappningsverktyg](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/legacy-user-mapping-tool/overview-user-mapping-tool-legacy.html) mappa den lokala AEM till IMS-användare så att autentisering och auktoriseringar fungerar tillsammans.

I det här fallet är SAML-identitetsleverantören konfigurerad mot Adobe IMS för att använda antingen Federated/Enterprise ID, i stället för direkt till AEM med autentiseringshanteraren.

### F: I mitt källförfattarsystem har vi konfigurerat grundläggande autentisering för användarna så att de kan autentiseras i Author-instansen med lokala AEM. Måste jag använda funktionen för användarmappning i CTT i det här fallet?

Det korta svaret är &quot;**Ja**&quot;.

CTT-extraheringen och -intaget utan användarmappning migrerar innehållet, de associerade principerna (användare, grupper) från AEM till AEMaaCS. Men dessa användare (identiteter) som finns i Adobe IMS och har (etablerats med) tillgång till AEMaaCS-instansen för att kunna autentisera. Jobbet för [användarmappningsverktyg](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/legacy-user-mapping-tool/overview-user-mapping-tool-legacy.html) mappa den lokala AEM till IMS-användare så att autentisering och auktoriseringar fungerar tillsammans.

I det här fallet använder man Adobe ID och Adobe ID används av IMS-administratören för att ge åtkomst till AEMaaCS.

### F: Vad betyder termerna&quot;svep&quot; och&quot;skriv över&quot; i samband med CTT?

I samband med [extraheringsfas](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/getting-started-content-transfer-tool.html?lang=en#extraction-setup-phase), är alternativen att antingen skriva över data i mellanlagringsbehållaren från tidigare extraheringscykler eller lägga till differentialen (tillagd/uppdaterad/borttagen) i den. Mellanlagringsbehållaren är ingenting, men den blob-lagringsbehållare som är associerad med migreringsuppsättningen. Varje migreringsuppsättning får en egen mellanlagringsbehållare.

I samband med [matningsfas](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/ingesting-content.html), är alternativen + för att ersätta hela innehållsdatabasen i AEMaaCS eller för att synkronisera differentiellt (tillagt/uppdaterat/borttaget) innehåll från mellanlagringsmigreringsbehållaren.

### F: Det finns flera webbplatser, associerade resurser, användare och grupper i källsystemet. Går det att migrera dem i faser till AEMaaCS?

Ja, det är möjligt men kräver noggrann planering av:

+ När du skapar migreringsuppsättningar under förutsättning att platserna används, placeras resurserna i sina respektive hierarkier
   + Verifiera om det går att migrera alla resurser som en del av en migreringsuppsättning och sedan ta med platser som använder dem i faser
+ I det aktuella läget gör redigeringsprocessen att författarinstansen inte är tillgänglig för innehållsredigering, även om publiceringsnivån fortfarande kan hantera innehållet
   + Detta innebär att tills det är klart för användaren att han/hon har skrivit innehållet, fryses innehållsredigeringen

Granska den övre extraherings- och intagsprocessen enligt dokumentationen innan du planerar migreringarna.

### F: Kommer mina webbplatser att vara tillgängliga för slutanvändare även om de lägger in något i AEMaaCS-författare eller publiceringsinstanser?

Ja. Slutanvändartrafiken avbryts inte av innehållsmigreringsaktiviteten. Författaren fryser dock innehållet tills det är klart.

### F: BPA-rapporten innehåller objekt som är relaterade till saknade ursprungliga återgivningar. Ska jag städa upp dem vid källan innan jag extraherar dem?

Ja. Den saknade ursprungliga återgivningen innebär att resursens binärfil inte överförs korrekt från början. Om du ser det som felaktiga data bör du granska, säkerhetskopiera med Package Manager (efter behov) och ta bort dem från AEM innan du kör extraheringen. Felaktiga data kommer att få negativa resultat i tillgångsbearbetningsstegen.

### F: BPA-rapporten innehåller artiklar som är relaterade till saknad `jcr:content` nod för mappar. Vad ska jag göra med dem?

När `jcr:content` saknas på mappnivå, åtgärder för att sprida inställningar som bearbetningsprofiler osv. från föräldrar bryts på den här nivån. Granska orsaken till saknad `jcr:content`. Även om dessa mappar kan migreras bör du tänka på att sådana mappar försämrar användarupplevelsen och orsakar onödiga felsökningscykler senare.

### F: Jag har skapat en migreringsuppsättning. går det att kontrollera dess storlek?

Ja, det finns en [Kontrollera storlek](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/getting-started-content-transfer-tool.html#migration-set-size) som ingår i CTT.

### F: Jag utför migreringen (extrahering, förtäring). Går det att validera att allt mitt extraherade innehåll hämtas till målet?

Ja, det finns en [validering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/validating-content-transfers.html) som ingår i CTT.

### F: Kunden måste flytta innehåll mellan AEMaaCS-miljöer som AEMaaCS Dev till AEMaaCS Stage eller till AEMaaCS Prod. Kan jag använda verktyget för innehållsöverföring för de här användningsområdena?

Tyvärr, nej. CTT:s användningsexempel är att migrera innehåll från en lokal/AMS-värd AEM 6.3+-källa till AEMaaCS-molnmiljöer. [Läs CTT-dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/overview-content-transfer-tool.html).

### F: Vilka typer av problem förväntas vid extraktion?

Extraheringsfasen är en involverad process som kräver att flera aspekter fungerar som förväntat. Att vara medveten om olika typer av problem som kan uppstå och hur ni kan mildra dem ökar den övergripande framgången med innehållsmigreringen.

Den offentliga dokumentationen förbättras kontinuerligt baserat på inlärningen, men här finns några problemkategorier på hög nivå och möjliga bakomliggande orsaker.

![Extraheringsproblem för as a Cloud Service innehållsmigrering](../../assets/faq/extraction-issues.jpg) { align=&quot;center&quot; }

### F: Vilken typ av problem förväntas vid intag?

Inmatningsfasen sker helt och hållet i molnplattformen och kräver hjälp från de resurser som har tillgång till AEMaaCS-infrastrukturen. Skapa en supportanmälan för mer hjälp.

Här är möjliga problemkategorier (se inte detta som en exklusiv lista)

![AEM problem med as a Cloud Service innehållsmigrering](../../assets/faq/ingestion-issues.jpg) { align=&quot;center&quot; }



### F: Måste min källserver ha en utgående internetanslutning för att CTT ska fungera?

Det korta svaret är &quot;**Ja**&quot;.

CTT-processen kräver anslutning till resurserna nedan:

+ Målet AEM den as a Cloud Service miljön: `author-p<program_id>-e<env_id>.adobeaemcloud.com`
+ Azure-blobblagringstjänsten: `casstorageprod.blob.core.windows.net`
+ I/O-slutpunkten för användarmappning: `usermanagement.adobe.io`

Mer information om [källanslutning](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/migration-journey/cloud-migration/content-transfer-tool/getting-started-content-transfer-tool.html#source-environment-connectivity).

## Tillgångshantering Dynamic Media relaterade frågor

### F: Kommer materialet att bearbetas om automatiskt efter intag i AEMaaCS?

Nej. Begäran om ombearbetning måste initieras för att resurserna ska kunna bearbetas.

### F: Kommer mediefiler att indexeras om automatiskt efter intag i AEMaaCS?

Ja. Resurserna indexeras om baserat på de indexdefinitioner som är tillgängliga i AEMaaCS.

### F: AEM är integrerat med Dynamic Media. Finns det några specifika saker som måste övervägas före innehållsmigrering?

Ja, tänk på följande när AEM har Dynamic Media Integration.

+ AEMaaCS stöder endast Dynamic Media Scene7 Mode. Om källsystemet är i hybrid-läge krävs DM-migrering till Scene7-lägen.
+ Om metoden är att migrera från källkloninstanser är det säkert att inaktivera DM-integrering på klon som skulle användas för CTT. Detta steg är enbart för att undvika skrivningar till DM eller för att undvika belastning på DM-trafiken.
+ Observera att CTT migrerar noder, metadata för en migreringsuppsättning från AEM till AEMaaCS. Den utför inga åtgärder direkt på DM.

### F: Vilka olika migreringsmetoder använder DM-integrering på AEM?

Läs ovanstående fråga och svar innan

(Det här är två möjliga alternativ, men de är inte begränsade till bara dessa två). Det beror på hur kunden vill närma sig UAT, prestandatestning, den tillgängliga miljön och om en klon används för migrering eller inte. Se dessa två som utgångspunkt för diskussion

**Alternativ 1**

Om antalet resurser/noder i källmiljön ligger på en lägre nivå (~100 kB), under förutsättning att dessa kan migreras under en period på 24 + 72 timmar, inklusive extrahering och förtäring, är den bättre metoden att

+ Utför migrering direkt från produktionen
+ Kör en första extrahering och intag i AEMaaCS med `wipe=true`
   + Det här steget migrerar alla noder och binärfiler
+ Fortsätt arbeta på plats/med utvecklaren av AMS-produkten
+ Från och med nu kan du köra alla andra korrekturrundor med `wipe=true`
   + Observera att den här åtgärden migrerar hela nodarkivet, men endast ändrade blobbar i motsats till hela blobbar. Den tidigare uppsättningen blober finns i Azure-blobbbutiken för AEMaaCS-målinstansen.
   + Använd det här migreringsbeviset för att mäta migreringens varaktighet, användarmappning, testning och validering av alla andra funktioner
+ Utför slutligen en svepning=verklig migrering före veckan då det publiceras
   + Ansluta Dynamic Media till AEMaaCS
   + Koppla från DM-konfiguration AEM lokal källa

Med det här alternativet kan du köra migrering från en till en, vilket betyder On-prem Dev → AEMaaCS Dev osv. och flytta DM-konfigurationerna från respektive miljö

(Om migreringen planeras att utföras från klonen)

**Alternativ 2**

+ Skapa klon av produktionsförfattare, ta bort DM-konfiguration från klon
+ Migrera lokalt klon → AEMaaCS Dev / Stage
   + Ansluta DM-företaget i produktionen till AEMaaCS Dev/Stage för validering
   + När DM-anslutningen är aktiv bör du undvika att få tillgång till AEMaaCS
   + Detta gör att de kan validera CTT-, DM-specifika valideringar
+ När testningen är klar på AEMaaCS
   + Kör en svepmigrering från en lokal scen till AEMaaCS-scenen

Kör en svepmigrering från en lokal Dev till AEMaaCS Dev.

Ovanstående metod kan bara användas för att mäta migreringstiden, men den måste rensas senare.

## Ytterligare resurser

+ [Tips och tricks för migrering till Experience Manager i molnet (Summit 2022)](https://business.adobe.com/summit/2022/sessions/tips-and-tricks-for-migrating-to-experience-manage-tw109.html)

+ [Video om CTT Expert Series](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/migration/moving-to-aem-as-a-cloud-service/content-migration/content-transfer-tool.html)

+ [Videofilmer om andra AEMaaCS-ämnen från expertserier](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/expert-resources/aem-experts-series.html)
