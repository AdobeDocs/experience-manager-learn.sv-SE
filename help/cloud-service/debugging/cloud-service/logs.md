---
title: Loggar
description: Loggar fungerar som en frontlinje för felsökning av AEM-program i AEM as a Cloud Service, men är beroende av korrekt inloggning i det distribuerade AEM-programmet.
feature: Developer Tools
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-5432
thumbnail: kt-5432.jpg
topic: Development
role: Developer
level: Beginner
exl-id: d0bd64bd-9e6c-4a28-a8d9-52bb37b27a09
duration: 229
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '948'
ht-degree: 0%

---

# Felsöka AEM as a Cloud Service med hjälp av loggar

Loggar fungerar som en frontlinje för felsökning av AEM-program i AEM as a Cloud Service, men är beroende av korrekt inloggning i det distribuerade AEM-programmet.

All loggaktivitet för en viss miljös AEM-tjänst (Författare, Publicera/Publicera Dispatcher) samlas i en enda loggfil, även om olika poster i den tjänsten genererar loggsatserna.

Pod-ID:n anges i varje loggsats och tillåter filtrering eller sortering av loggsatser. Pod-ID:n har formatet:

+ `cm-p<PROGRAM ID>-e<ENVIRONMENT ID>-aem-<author|publish>-<POD NAME>`
+ Exempel: `cm-p12345-e56789-aem-author-abcdefabde-98765`

## Egna loggfiler

AEM som molntjänster stöder inte anpassade loggfiler, men det stöder anpassad loggning.

För att Java-loggar ska vara tillgängliga i AEM as a Cloud Service (via [Cloud Manager](#cloud-manager) eller [Adobe I/O CLI](#aio)) måste anpassade loggsatser skrivas i `error.log`. Loggar som skrivits till anpassade namngivna loggar, som `example.log`, kommer inte att vara tillgängliga från AEM as a Cloud Service.

Loggar kan skrivas till `error.log` med hjälp av en Sling LogManager OSGi-konfigurationsegenskap i programmets `org.apache.sling.commons.log.LogManager.factory.config~example.cfg.json`-filer.

```
{
   ...
   "org.apache.sling.commons.log.file": "logs/error.log"
   ...
}
```

## Loggar för tjänsten AEM Author och Publish

Både AEM Author och Publish Services tillhandahåller AEM runtime-serverloggar:

+ `aemerror` är Java-felloggen (finns i `/crx-quickstart/logs/error.log` på AEM SDK lokala snabbstart). Följande är [rekommenderade loggnivåer](#log-levels) för anpassade loggare per miljötyp:
   + Utveckling: `DEBUG`
   + Scen: `WARN`
   + Produktion: `ERROR`
+ `aemaccess` listar HTTP-begäranden till AEM-tjänsten med information
+ `aemrequest` visar HTTP-begäranden som gjorts till AEM-tjänsten och deras motsvarande HTTP-svar

## AEM Publish Dispatcher-loggar

Det är bara AEM Publish Dispatcher som tillhandahåller webbservern Apache och Dispatcher-loggar, eftersom dessa aspekter bara finns i AEM publiceringsnivå, och inte på AEM Author-nivå.

+ `httpdaccess` visar HTTP-begäranden som gjorts till AEM-tjänstens Apache-webbserver/Dispatcher.
+ `httperror` visar loggmeddelanden från Apache-webbservern och hjälp med felsökningsmoduler som stöds, till exempel `mod_rewrite`.
   + Utveckling: `DEBUG`
   + Scen: `WARN`
   + Produktion: `ERROR`
+ `aemdispatcher` visar loggmeddelanden från Dispatcher-modulerna, inklusive filtrering och hämtning från cachemeddelanden.
   + Utveckling: `DEBUG`
   + Scen: `WARN`
   + Produktion: `ERROR`

## Cloud Manager{#cloud-manager}

Med Adobe Cloud Manager kan du ladda ned loggar per dag via en miljös Download Logs-åtgärd.

![Cloud Manager - Hämta loggar](./assets/logs/download-logs.png)

Loggarna kan laddas ned och inspekteras via alla logganalysverktyg.

## Adobe I/O CLI med Cloud Manager plugin{#aio}

Adobe Cloud Manager har stöd för åtkomst till AEM as a Cloud Service-loggar via [Adobe I/O CLI](https://github.com/adobe/aio-cli) med [Cloud Manager-pluginen för Adobe I/O CLI](https://github.com/adobe/aio-cli-plugin-cloudmanager).

Först [konfigurerar du Adobe I/O med Cloud Manager plugin](../../local-development-environment/development-tools.md#aio-cli).

Se till att rätt program-ID och miljö-ID har identifierats och använd [list-available-log-options](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerlist-available-log-options-environmentid) för att lista de loggalternativ som används för att [slut](#aio-cli-tail-logs) - eller [hämta](#aio-cli-download-logs) -loggar.

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

Med Adobe I/O CLI kan du avsluta loggar i realtid från AEM as a Cloud Service med kommandot [tail-logs](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagertail-log-environmentid-service-name) . Passning är användbart när du vill se loggaktivitet i realtid när åtgärder utförs i AEM as a Cloud Service-miljön.

```
$ aio config:set cloudmanager_programid <PROGRAM ID>
$ aio cloudmanager:tail-logs <ENVIRONMENT ID> <SERVICE> <NAME>
```

Andra kommandoradsverktyg, som `grep`, kan användas tillsammans med `tail-logs` för att isolera loggsatser av intresse, till exempel:

```
$ aio cloudmanager:tail-logs 12345 author | grep com.example.MySlingModel
```

... visar bara loggsatser som genererats från `com.example.MySlingModel` eller innehåller strängen i dem.

### Laddar ned loggar{#aio-cli-download-logs}

Med Adobe I/O CLI kan du hämta loggar från AEM as a Cloud Service med kommandot [download-logs](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerdownload-logs-environmentid-service-name-days)). Detta ger samma slutresultat som när du hämtar loggarna från Cloud Manager webbgränssnitt. Skillnaden är att kommandot `download-logs` konsoliderar loggar över flera dagar, baserat på hur många dagar som loggarna begärs.

```
$ aio config:set cloudmanager_programid <PROGRAM ID>
$ aio cloudmanager:download-logs <ENVIRONMENT> <SERVICE> <NAME> <DAYS>
```

## Förstå loggar

Inloggningar i AEM as a Cloud Service innehåller flera pods-skrivloggsatser. Eftersom flera AEM-instanser skriver till samma loggfil är det viktigt att du förstår hur du analyserar och minskar bruset vid felsökning. Följande `aemerror` loggutdrag används som förklaring:

```
01.01.2020 12:00:00.000 [cm-p12345-e56789-aem-author-abcdefg-1111] *DEBUG* [qtp2078364989-269] com.example.components.impl.ExampleModelImpl Preparing to collect resources
01.01.2020 12:00:01.002 [cm-p12345-e56789-aem-author-abcdefg-2222] *WARN*  [qtp40782847611-87] com.example.services.impl.ExampleServiceImpl Unable to resolve resource [ /content/example ] to a resource. Aborting.
01.01.2020 12:00:02.003 [cm-p12345-e56789-aem-author-abcdefg-1111] *ERROR* [qtp2078364989-269] com.example.components.impl.ExampleModelImpl Unable to collect any resources
```

Med Pod ID, datapunkten efter datum och tid, kan loggarna sorteras efter Pod, eller AEM-instansen inom tjänsten, vilket gör det enklare att spåra och förstå kodkörningen.

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

Adobe allmänna riktlinjer för loggnivåer per AEM as a Cloud Service-miljö är:

+ Lokal utveckling (AEM SDK): `DEBUG`
+ Utveckling: `DEBUG`
+ Scen: `WARN`
+ Produktion: `ERROR`

Att ställa in den lämpligaste loggnivån för varje miljötyp är AEM as a Cloud Service, loggnivåerna behålls i koden

+ Java-loggkonfigurationer underhålls i OSGi-konfigurationer
+ Loggnivåer för Apache-webbservern och Dispatcher i dispatcherprojektet

...och därför måste ni ha en driftsättning för att kunna ändra den.

### Miljöspecifika variabler för att ställa in Java-loggnivåer

Ett alternativ till att ställa in statiska, välkända Java-loggnivåer för varje miljö är att använda AEM som Cloud Service [miljöspecifika variabler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#environment-specific-configuration-values) för att parametrisera loggnivåer så att värdena kan ändras dynamiskt via [Adobe I/O CLI med Cloud Manager plugin](#aio-cli) .

Detta kräver att OSGi-konfigurationerna för loggning uppdateras för att använda miljöspecifika variabelplatshållare. [Standardvärden](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#default-values) för loggnivåer måste anges enligt [Adobe-rekommendationer](#log-levels). Till exempel:

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

+ [Ett begränsat antal miljövariabler tillåts](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#number-of-variables), och om du skapar en variabel som hanterar loggnivån används en.
+ Miljövariabler kan hanteras programmatiskt via [Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables.html), [Adobe I/O CLI](https://github.com/adobe/aio-cli-plugin-cloudmanager#aio-cloudmanagerset-environment-variables-environmentid) och [Cloud Manager HTTP API:er](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#cloud-manager-api-format-for-setting-properties).
+ Ändringar av miljövariabler måste återställas manuellt av ett verktyg som stöds. Om du glömmer att återställa en hög trafikmiljö, till exempel Production, till en mindre detaljerad loggnivå kan loggarna flöda och AEM prestanda påverkas.

_Miljöspecifika variabler fungerar inte för webbservern Apache eller Dispatcher-loggkonfigurationer eftersom dessa inte har konfigurerats via OSGi-konfigurationen._
