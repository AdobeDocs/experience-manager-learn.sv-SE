---
title: Loggar
description: Loggar fungerar som en frontlinje för felsökning AEM program på AEM as a Cloud Service, men är beroende av korrekt inloggning i det distribuerade AEM.
feature: Developer Tools
version: Cloud Service
doc-type: Tutorial
jira: KT-5432
thumbnail: kt-5432.jpg
topic: Development
role: Developer
level: Beginner
exl-id: d0bd64bd-9e6c-4a28-a8d9-52bb37b27a09
duration: 275
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '948'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med loggar

Loggar fungerar som en frontlinje för felsökning AEM program på AEM as a Cloud Service, men är beroende av korrekt inloggning i det distribuerade AEM.

All loggaktivitet för en viss AEM (Författare, Publicera/Publicera Dispatcher) samlas i en enda loggfil, även om olika poster i den tjänsten genererar loggsatserna.

Pod-ID:n anges i varje loggsats och tillåter filtrering eller sortering av loggsatser. Pod-ID:n har formatet:

+ `cm-p<PROGRAM ID>-e<ENVIRONMENT ID>-aem-<author|publish>-<POD NAME>`
+ Exempel: `cm-p12345-e56789-aem-author-abcdefabde-98765`

## Egna loggfiler

AEM som en Cloud Service stöder inte anpassade loggfiler, men det stöder anpassad loggning.

För att Java-loggar ska vara tillgängliga i AEM as a Cloud Service (via [Cloud Manager](#cloud-manager) eller [ADOBE I/O CLI](#aio)) måste egna loggsatser skrivas i `error.log`. Loggar som skrivits till anpassade namngivna loggar, som `example.log`, kommer inte att vara tillgängligt från AEM as a Cloud Service.

Loggar kan skrivas till `error.log` med en Sling LogManager OSGi-konfigurationsegenskap i programmets `org.apache.sling.commons.log.LogManager.factory.config~example.cfg.json` filer.

```
{
   ...
   "org.apache.sling.commons.log.file": "logs/error.log"
   ...
}
```

## AEM Författar- och publiceringstjänstloggar

Både AEM Author- och Publish-tjänster tillhandahåller AEM körtidsserverloggar:

+ `aemerror` är Java-felloggen (finns på `/crx-quickstart/logs/error.log` på AEM SDK (lokal snabbstart). Följande är [rekommenderade loggnivåer](#log-levels) för anpassade loggare per miljötyp:
   + Utveckling: `DEBUG`
   + Scen: `WARN`
   + Produktion: `ERROR`
+ `aemaccess` visar en lista över HTTP-begäranden till AEM med information
+ `aemrequest` visar HTTP-begäranden som gjorts till AEM och deras motsvarande HTTP-svar

## AEM Publish Dispatcher-loggar

Endast AEM Publish Dispatcher tillhandahåller Apache-webbservern och Dispatcher-loggar, eftersom dessa aspekter bara finns i AEM publiceringsskikt, och inte på AEM.

+ `httpdaccess` visar en lista över HTTP-begäranden som gjorts till AEM Apache-webbservern/Dispatcher.
+ `httperror`  visar loggmeddelanden från webbservern Apache och hjälp med felsökning av Apache-moduler som `mod_rewrite`.
   + Utveckling: `DEBUG`
   + Scen: `WARN`
   + Produktion: `ERROR`
+ `aemdispatcher` I visas loggmeddelanden från Dispatcher-modulerna, inklusive filtrering och hämtning från cachemeddelanden.
   + Utveckling: `DEBUG`
   + Scen: `WARN`
   + Produktion: `ERROR`

## Cloud Manager{#cloud-manager}

I Adobe Cloud Manager kan du ladda ned loggar per dag via en miljös hämtningsloggåtgärd.

![Cloud Manager - Hämta loggar](./assets/logs/download-logs.png)

Loggarna kan laddas ned och inspekteras via alla logganalysverktyg.

## Adobe I/O CLI med plugin-programmet Cloud Manager{#aio}

Adobe Cloud Manager har stöd för åtkomst AEM as a Cloud Service loggar via [ADOBE I/O CLI](https://github.com/adobe/aio-cli) med [Cloud Manager-plugin för Adobe I/O CLI](https://github.com/adobe/aio-cli-plugin-cloudmanager).

Första, [konfigurera Adobe I/O med molnhanterarens plugin](../../local-development-environment/development-tools.md#aio-cli).

Kontrollera att relevant program-ID och miljö-ID har identifierats och använd [list-available-log-options](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerlist-available-log-options-environmentid) för att lista de loggalternativ som används för [svans](#aio-cli-tail-logs) eller [ladda ned](#aio-cli-download-logs) loggar.

```
$ aio cloudmanager:list-programs
Program Id Name      Enabled 
14304      Program 1 true    
11454      Program 2 true 
11502      Program 3 true    

$ aio config:set cloudmanager_programid <PROGRAM ID>

$ aio cloudmanager:list-environments        
Environment Id Name            Type  Description 
22295          program-3-dev   dev               
22310          program-3-prod  prod              
22294          program-3-stage stage   

$ aio cloudmanager:list-available-log-options <ENVIRONMENT ID>
Environment Id Service    Name          
22295          author     aemaccess     
22295          author     aemerror      
22295          author     aemrequest    
22295          publish    aemaccess     
22295          publish    aemerror      
22295          publish    aemrequest    
22295          dispatcher httpdaccess   
22295          dispatcher httpderror    
22295          dispatcher aemdispatcher 
```

### Spridningsloggar{#aio-cli-tail-logs}

Adobe I/O CLI gör det möjligt att stänga loggar i realtid från AEM as a Cloud Service med hjälp av [slutloggar](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagertail-log-environmentid-service-name) -kommando. Passning är användbart när du vill se loggaktivitet i realtid när åtgärder utförs i den AEM as a Cloud Service miljön.

```
$ aio config:set cloudmanager_programid <PROGRAM ID>
$ aio cloudmanager:tail-logs <ENVIRONMENT ID> <SERVICE> <NAME>
```

Andra kommandoradsverktyg, som `grep` kan användas tillsammans med `tail-logs` för att hjälpa till att isolera loggsatser av intresse, till exempel:

```
$ aio cloudmanager:tail-logs 12345 author | grep com.example.MySlingModel
```

... visar bara loggsatser som genererats från `com.example.MySlingModel` eller innehåller den strängen i dem.

### Laddar ned loggar{#aio-cli-download-logs}

Adobe I/O CLI gör det möjligt att hämta loggar från AEM as a Cloud Service med hjälp av [download-logs](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerdownload-logs-environmentid-service-name-days)). Detta ger samma slutresultat som när du hämtar loggarna från webbgränssnittet i Cloud Manager, men skillnaden är att `download-logs` kommandot konsoliderar loggar över flera dagar baserat på hur många dagar som loggarna begärs.

```
$ aio config:set cloudmanager_programid <PROGRAM ID>
$ aio cloudmanager:download-logs <ENVIRONMENT> <SERVICE> <NAME> <DAYS>
```

## Förstå loggar

Inloggningar AEM as a Cloud Service innehåller flera pods som skriver loggsatser i dem. Eftersom flera AEM-instanser skriver till samma loggfil är det viktigt att du förstår hur du analyserar och minskar bruset vid felsökning. Förklara följande: `aemerror` loggfragment används:

```
01.01.2020 12:00:00.000 [cm-p12345-e56789-aem-author-abcdefg-1111] *DEBUG* [qtp2078364989-269] com.example.components.impl.ExampleModelImpl Preparing to collect resources
01.01.2020 12:00:01.002 [cm-p12345-e56789-aem-author-abcdefg-2222] *WARN*  [qtp40782847611-87] com.example.services.impl.ExampleServiceImpl Unable to resolve resource [ /content/example ] to a resource. Aborting.
01.01.2020 12:00:02.003 [cm-p12345-e56789-aem-author-abcdefg-1111] *ERROR* [qtp2078364989-269] com.example.components.impl.ExampleModelImpl Unable to collect any resources
```

Med Pod ID, datapunkten efter datum och tid, kan loggarna sorteras efter Pod, eller AEM instans i tjänsten, vilket gör det enklare att spåra och förstå kodkörningen.

__Pod cm-p12345-e56789-aem-author-abcdefg-111__

```
01.01.2020 12:00:00.000 [cm-p12345-e56789-aem-author-abcdefg-1111] *DEBUG* [qtp2078364989-269] com.example.components.impl.ExampleModelImpl Preparing to collect resources
01.01.2020 12:00:02.003 [cm-p12345-e56789-aem-author-abcdefg-1111] *ERROR* [qtp2078364989-269] com.example.components.impl.ExampleModelImpl Unable to collect any resources
```

__Pod cm-p12345-e56789-aem-author-abcdefg-222__

```
01.01.2020 12:00:01.002 [cm-p12345-e56789-aem-author-abcdefg-2222] *WARN*  [qtp2078364989-269] com.example.services.impl.ExampleServiceImpl Unable to resolve resource [ /content/example ] to a resource. Aborting.
```

## Rekommenderade loggnivåer{#log-levels}

Adobe allmänna riktlinjer för loggnivåer per AEM as a Cloud Service miljö är:

+ Lokal utveckling (AEM SDK): `DEBUG`
+ Utveckling: `DEBUG`
+ Scen: `WARN`
+ Produktion: `ERROR`

Att ställa in den lämpligaste loggnivån för varje miljötyp är med AEM as a Cloud Service, loggnivåerna behålls i koden

+ Java-loggkonfigurationer underhålls i OSGi-konfigurationer
+ Loggnivåer för Apache-webbserver och Dispatcher i dispatcher-projektet

...och därför måste ni ha en driftsättning för att kunna ändra den.

### Miljöspecifika variabler för att ställa in Java-loggnivåer

Ett alternativ till att ställa in statiska, välkända Java-loggnivåer för varje miljö är att använda AEM som Cloud Servicens [systemspecifika variabler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#environment-specific-configuration-values) för att parametrisera loggnivåer, vilket gör att värdena kan ändras dynamiskt via [Adobe I/O CLI med plugin-programmet Cloud Manager](#aio-cli).

Detta kräver att OSGi-konfigurationerna för loggning uppdateras för att använda miljöspecifika variabelplatshållare. [Standardvärden](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#default-values) för loggnivåer ska anges enligt [Adobe rekommendationer](#log-levels). Till exempel:

`/apps/example/config/org.apache.sling.commons.log.LogManager.factory.config~example.cfg.json`

```
{
    ...
    "org.apache.sling.commons.log.names": ["com.example"],
    "org.apache.sling.commons.log.level": "$[env:LOG_LEVEL;default=DEBUG]"
    ...
}
```

Detta tillvägagångssätt har nackdelar som måste beaktas:

+ [Ett begränsat antal miljövariabler tillåts](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#number-of-variables)och om du skapar en variabel för att hantera loggnivån används en variabel.
+ Miljövariabler kan hanteras programmatiskt via [Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables.html), [ADOBE I/O CLI](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerset-environment-variables-environmentid)och [HTTP-API:er för Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#cloud-manager-api-format-for-setting-properties).
+ Ändringar av miljövariabler måste återställas manuellt av ett verktyg som stöds. Om du glömmer att återställa en hög trafikmiljö, till exempel produktion, till en mindre detaljerad loggnivå kan loggarna flöda och påverka AEM prestanda.

_Miljöspecifika variabler fungerar inte för webbservern Apache eller Dispatcher-loggkonfigurationer eftersom dessa inte har konfigurerats via OSGi-konfigurationen._
