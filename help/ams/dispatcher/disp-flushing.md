---
title: AEM Dispatcher Flushing
description: Förstå hur AEM gör gamla cachefiler från Dispatcher ogiltiga.
version: Experience Manager 6.5
topic: Administration
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 461873a1-1edf-43a3-b4a3-14134f855d86
duration: 520
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '2225'
ht-degree: 0%

---

# Dispatcher Vanity URL:er

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Använda och förstå variabler](./variables.md)

Det här dokumentet innehåller riktlinjer för hur tömning sker och en förklaring av vilken mekanism som exekverar tömning och ogiltigförklaring av cache.


## Så här fungerar det

### Operationsordning

Det typiska arbetsflödet beskrivs bäst när innehållsförfattare ska aktivera en sida och när utgivaren tar emot det nya innehållet utlöses en tömningsbegäran till Dispatcher enligt följande diagram:
![författare aktiverar innehåll, vilket utlöser en begäran om tömning till Dispatcher](assets/disp-flushing/dispatcher-flushing-order-of-events.png "dispatcher-flushing-order-of-events")
Den här kedjan av händelser markerar att vi bara rensar objekt när de är nya eller har ändrats.  Detta garanterar att innehållet har tagits emot av utgivaren innan cachen rensas för att undvika konkurrensförhållanden där rensningen kan ske innan ändringarna kan hämtas från utgivaren.

## Replikeringsagenter

Vid författaren finns det en replikeringsagent som är konfigurerad att peka på utgivaren att när något aktiveras utlöses det att skicka filen och alla dess beroenden till utgivaren.

När utgivaren tar emot filen har den en replikeringsagent som är konfigurerad att peka på Dispatcher som utlöser händelsen on-receive.  Sedan serialiseras en rensningsbegäran och skickas till Dispatcher.

### REPLIKATIONSAGENT FÖR FÖRFATTARE

Här följer några exempel på skärmbilder av en konfigurerad standardslikeringsagent
![skärmbild av standardsvar för replikeringsagent från AEM webbsida /etc/replication.html](assets/disp-flushing/author-rep-agent-example.png "author-rep-agent-example")

Vanligtvis har 1 eller 2 replikeringsagenter konfigurerats på författaren för varje utgivare som de replikerar innehåll till.

Det första är den standardsvar för replikering som överför innehållsaktiveringar till.

Det andra är det omvända agenset.  Detta är valfritt och är konfigurerat för att kontrollera om det finns nytt innehåll att hämta till författaren som en omvänd replikeringsaktivitet

### PUBLISHER REPLICATION AGENT

Här är ett exempel på skärmbilder av en konfigurerad standardimporteringsagent
![skärmbild av standardsenselagenten för tömning från AEM webbsida /etc/replication.html](assets/disp-flushing/publish-flush-rep-agent-example.png "publish-flush-rep-agent-example")

### DISPATCHER FLUSH REPLICATION MOTTAR VIRTUELL VÄRD

Dispatcher-modulen letar efter särskilda rubriker som ska veta när en POST-begäran är något att skicka vidare till AEM-renderingar eller om den är serialiserad som en tömningsbegäran och måste hanteras av Dispatcher-hanteraren.

Här är en skärmbild av konfigurationssidan som visar följande värden:
![bild på fliken Inställningar för huvudkonfigurationsskärmen med serialiseringstypen som visas som Dispatcher Flush](assets/disp-flushing/disp-flush-agent1.png "disp-flush-agent1")

Standardinställningssidan visar `Serialization Type` som `Dispatcher Flush` och anger felnivån

![Skärmbild av transportfliken för replikeringsagenten.  Detta visar den URI som begäran om tömning ska skickas till.  /dispatcher/invalidate.cache](assets/disp-flushing/disp-flush-agent2.png "disp-flush-agent2")

På fliken `Transport` kan du se att `URI` är inställd på att peka på IP-adressen för den Dispatcher som ska ta emot rensningsbegäranden.  Sökvägen `/dispatcher/invalidate.cache` är inte så som modulen avgör om det är en tömning, det är bara en tydlig slutpunkt som du kan se i åtkomstloggen för att veta att det var en tömningsbegäran.  På fliken `Extended` går vi igenom de saker som finns för att kvalificera att det här är en rensningsförfrågan till Dispatcher-modulen.

![Skärmbild av fliken Utökat i replikeringsagenten.  Observera de huvuden som skickas med POST-begäran som skickats för att instruera Dispatcher att tömma](assets/disp-flushing/disp-flush-agent3.png "disp-flush-agent3")

`HTTP Method` för rensningsbegäranden är bara en `GET`-begäran med några särskilda begäranderubriker:
- CQ-Action
   - Detta använder en AEM-variabel som baseras på begäran och värdet är vanligtvis *activate eller delete*
- CQ-Handle
   - Detta använder en AEM-variabel som baseras på begäran och värdet är vanligtvis den fullständiga sökvägen till objektet som tömts, till exempel `/content/dam/logo.jpg`
- CQ-Path
   - Detta använder en AEM-variabel som baseras på begäran och värdet är vanligtvis den fullständiga sökvägen till objektet som rensas, till exempel `/content/dam`
- Värd
   - Det är här `Host` Header placeras i en buffert som mål för en specifik `VirtualHost` som har konfigurerats på API-avsändarens webbserver (`/etc/httpd/conf.d/enabled_vhosts/aem_flush.vhost`).  Det är ett hårdkodat värde som matchar en post i `ServerName` eller `ServerAlias` för filen `aem_flush.vhost`

![Skärm på en standardslikeringsagent som visar att replikeringsagenten med respons och utlösare när nya objekt har tagits emot från en replikeringshändelse från författarpubliceringsinnehållet](assets/disp-flushing/disp-flush-agent4.png "disp-flush-agent4")

På fliken `Triggers` noterar vi aktiverade utlösare som vi använder och vad de är

- `Ignore default`
   - Detta är aktiverat så att replikeringsagenten inte aktiveras vid sidaktivering.  Detta är något som utlöser en tömning när en författarinstans ändrar till en sida.  Eftersom det här är en utgivare vill vi inte utlösa den typen av händelse.
- `On Receive`
   - När en ny fil tas emot vill vi utlösa en tömning.  Så när författaren skickar en uppdaterad fil till oss kommer vi att skicka en begäran om att filen ska rensas till Dispatcher.
- `No Versioning`
   - Vi kontrollerar detta för att undvika att utgivaren genererar nya versioner eftersom en ny fil har tagits emot.  Vi ersätter bara den fil vi har och förlitar oss på att författaren håller reda på versionerna istället för utgivaren.

Om vi nu tittar på hur en typisk rensningsbegäran ser ut i form av ett `curl`-kommando

```
$ curl \ 
-H "CQ-Action: Activate" \ 
-H "CQ-Handle: /content/dam/logo.jpg" \ 
-H "CQ-Path: /content/dam/" \ 
-H "Content-Length: 0" \  
-H "Content-Type: application/octect-stream" \ 
-H "Host: flush" \ 
http://10.43.0.32:80/dispatcher/invalidate.cache
```

Det här rensningsexemplet tömmer sökvägen `/content/dam` genom att uppdatera filen `.stat` i den katalogen.

## Filen `.stat`

Tömningsmekanismen är enkel och vi vill förklara vikten av de `.stat`-filer som genereras i dokumentroten där cachefilerna skapas.

I filerna `.vhost` och `_farm.any` konfigurerar vi ett dokumentrotdirektiv för att ange var cachen finns och var filerna ska lagras/hanteras från när en begäran från en slutanvändare kommer in.

Om du kör följande kommando på din Dispatcher-server börjar du hitta `.stat` filer

```
$ find /mnt/var/www/html/ -type f -name ".stat"
```

Här följer ett diagram över hur den här filstrukturen ser ut när du har objekt i cachen och har fått en tömningsbegäran skickad och bearbetad av modulen Dispatcher

![statusfiler blandade med innehåll och datum som visas med statusnivåer ](assets/disp-flushing/dispatcher-statfiles.png "dispatcher-statfiles")

### STARTFILNIVÅ

Observera att det fanns en `.stat`-fil i varje katalog.  Det här är en indikator på att en tömning har skett.  I exemplet ovan ställdes inställningen `statfilelevel` in på `3` i motsvarande servergruppskonfigurationsfil.

Inställningen `statfilelevel` anger hur många mappar som är djupa i modulen som kommer att gå igenom och uppdatera en `.stat`-fil.  .stat-filen är tom, det är bara ett filnamn med en datastamp och kan till och med skapas manuellt, men du kan köra pekkommandot på kommandoraden på Dispatcher-servern.

Om inställningen för statusfilnivå är för hög kommer varje justeringsbegäran att gå igenom katalogträdets beröringstillståndsfiler.  Detta kan få stora prestanda i stora cacheträd och kan påverka Dispatcher allmänna prestanda.

Om den här filnivån anges för låg kan det medföra att en rensningsbegäran rensas mer än vad som var tänkt.  Detta skulle i sin tur få cachen att krascha oftare med färre begäranden som skickas från cachen och kan orsaka prestandaproblem.

>[!BEGINSHADEBOX &quot;Obs!&quot;]

Ange `statfilelevel` på en rimlig nivå. Titta på mappstrukturen och se till att den är konfigurerad så att du kan utföra korta genomgångar utan att behöva gå igenom för många kataloger. Testa det och se till att det passar dina behov under ett prestandatest av systemet.

Ett bra exempel är en webbplats som har stöd för språk. Det typiska innehållsträdet skulle ha följande kataloger

`/content/brand1/en/us/`

I det här exemplet använder du en inställning för statusfilnivå på 4. Detta garanterar att när du tömmer innehåll som finns under mappen **`us`**, kommer det inte att medföra att även språkmapparna rensas.

>[!ENDSHADEBOX]

### STÄLL FILTIDSSTÄMPELHANTERING

När en begäran om innehåll kommer in i samma rutin händer

1. Tidsstämpeln för filen `.stat` jämförs med tidsstämpeln för den begärda filen
2. Om filen `.stat` är nyare än den begärda filen tar den bort det cachelagrade innehållet och hämtar ett nytt från AEM och sparar det i cacheminnet.  Ändrar sedan innehållet
3. Om filen `.stat` är äldre än den begärda filen vet den att filen är ny och kan hantera innehållet.

### CACHEMANG - EXEMPEL 1

I exemplet ovan finns en begäran för innehållet `/content/index.html`

Tiden för filen `index.html` är 2019-11-01 vid 6:21PM

Tidpunkten för närmaste `.stat`-fil är 2019-11-01 @ 12:22 PM

Om du förstår vad vi har läst ovan kan du se att indexfilen är nyare än `.stat`-filen och att filen kan hanteras från cachen till slutanvändaren som begärde den

### CACHE-HANTERING - EXEMPEL 2

I exemplet ovan finns en begäran för innehållet `/content/dam/logo.jpg`

Tiden för filen `logo.jpg` är 2019-10-31 vid 1:13 PM

Tidpunkten för närmaste `.stat`-fil är 2019-11-01 @ 12:22 PM

Som du kan se i det här exemplet är filen äldre än filen `.stat` och kommer att tas bort och en ny hämtas från AEM för att ersätta den i cachen innan den skickas till slutanvändaren som begärde den.

## Inställningar för servergruppsfil

Dokumentation finns här för alla konfigurationsalternativ: [https://docs.adobe.com/content/help/sv-SE/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#configuring-dispatcher_configuring-the-dispatcher-cache-cache](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE)

Vi vill framhäva några av dem som rör cachetömning

### Töm grupper

Det finns två nyckelkataloger för `document root` som cachelagrar filer från författare- och utgivartrafik.  För att hålla katalogerna uppdaterade med nytt innehåll måste vi tömma cachen.  Dessa rensningsbegäranden vill inte trassla med era vanliga kundtrafikgruppskonfigurationer som kan avvisa begäran eller göra något oönskat.  I stället tillhandahåller vi två rensningsgrupper för den här uppgiften:

- `/etc/httpd.conf.d/available_farms/001_ams_author_flush_farm.any`
- `/etc/httpd.conf.d/available_farms/001_ams_publish_flush_farm.any`

De här servergruppsfilerna gör ingenting annat än att tömma dokumentets rotkataloger.

```
/publishflushfarm {  
    /virtualhosts {
        "flush"
    }
    /cache {
        /docroot "${PUBLISH_DOCROOT}"
        /statfileslevel "${DEFAULT_STAT_LEVEL}"
        /rules {
            $include "/etc/httpd/conf.dispatcher.d/cache/ams_publish_cache.any"
        }
        /invalidate {
            /0000 {
                /glob "*"
                /type "allow"
            }
        }
        /allowedClients {
            /0000 {
                /glob "*.*.*.*"
                /type "deny"
            }
            $include "/etc/httpd/conf.dispatcher.d/cache/ams_publish_invalidate_allowed.any"
        }
    }
}
```

### Dokumentrot

Den här konfigurationsposten finns i följande avsnitt i servergruppsfilen:

```
/myfarm { 
    /cache { 
        /docroot
```

Du anger den katalog där du vill att Dispatcher ska fylla i och hantera som en cachekatalog.

>[!NOTE]
>
>Den här katalogen bör matcha dokumentets rotinställning för Apache för den domän som webbservern är konfigurerad att använda.
>
>Att ha kapslade dokumentrotmappar per servergrupp som innehåller en undermapp till dokumentroten i Apache är en hemsk idé av många anledningar.

### Statusfilnivå

Den här konfigurationsposten finns i följande avsnitt i servergruppsfilen:

```
/myfarm { 
    /cache { 
        /statfileslevel
```

Den här inställningen mäter hur djupa `.stat` filer behöver genereras när en tömningsbegäran kommer in.

`/statfileslevel` som anges med följande nummer med dokumentroten `/var/www/html/` skulle få följande resultat när `/content/dam/brand1/en/us/logo.jpg` tömdes

- 0 - Följande statusfiler skulle skapas
   - `/var/www/html/.stat`
- 1 - Följande statusfiler skulle skapas
   - `/var/www/html/.stat`
   - `/var/www/html/content/.stat`
- 2 - Följande statusfiler skulle skapas
   - `/var/www/html/.stat`
   - `/var/www/html/content/.stat`
   - `/var/www/html/content/dam/.stat`
- 3 - Följande statusfiler skulle skapas
   - `/var/www/html/.stat`
   - `/var/www/html/content/.stat`
   - `/var/www/html/content/dam/.stat`
   - `/var/www/html/content/dam/brand1/.stat`
- 4 - Följande statusfiler skulle skapas
   - `/var/www/html/.stat`
   - `/var/www/html/content/.stat`
   - `/var/www/html/content/dam/.stat`
   - `/var/www/html/content/dam/brand1/.stat`
   - `/var/www/html/content/dam/brand1/en/.stat`
- 5 - Följande statusfiler skulle skapas
   - `/var/www/html/.stat`
   - `/var/www/html/content/.stat`
   - `/var/www/html/content/dam/.stat`
   - `/var/www/html/content/dam/brand1/.stat`
   - `/var/www/html/content/damn/brand1/en/.stat`
   - `/var/www/html/content/damn/brand1/en/us/.stat`

>[!NOTE]
>
>Tänk på att när tidsstämpelhandskakningen inträffar söker den efter den närmaste `.stat`-filen.
>
>Om du har en `.stat`-filnivå 0 och en lägesfil endast på `/var/www/html/.stat` betyder det att innehåll som finns under `/var/www/html/content/dam/brand1/en/us/` söker efter den närmsta `.stat`-filen och går upp till 5 mappar för att hitta den enda `.stat`-filen på nivå 0 och jämför datum med den. Att en tömning vid den nivån gör i princip alla cachelagrade objekt ogiltiga.

### Invalidering tillåten

Den här konfigurationsposten finns i följande avsnitt i servergruppsfilen:

```
/myfarm { 
    /cache { 
        /allowedClients {
```

I den här konfigurationen placerar du en lista över IP-adresser som kan skicka rensningsbegäranden.  Om en begäran om tömning kommer in i Dispatcher måste den komma från en betrodd IP.  Om du har felkonfigurerat detta eller skickar en tömningsbegäran från en IP-adress som inte är betrodd visas följande fel i loggfilen:

```
[Mon Nov 11 22:43:05 2019] [W] [pid 3079 (tid 139859875088128)] Flushing rejected from 10.43.0.57
```

### Invalideringsregler

Den här konfigurationsposten finns i följande avsnitt i servergruppsfilen:

```
/myfarm { 
    /cache { 
        /invalidate {
```

Dessa regler anger vanligtvis vilka filer som tillåts ogiltigförklaras med en tömningsbegäran.

För att undvika att viktiga filer ogiltigförklaras med sidaktivering kan du lägga in regler som anger vilka filer som ska ogiltigförklaras och vilka som ska ogiltigförklaras manuellt.  Här följer ett exempel på en konfigurationsuppsättning som bara tillåter att HTML-filer blir ogiltiga:

```
/invalidate { 
   /0000 { /glob "*" /type "deny" } 
   /0001 { /glob "*.html" /type "allow" } 
}
```

## Testning/felsökning

När du aktiverar en sida och får grönt ljus om att sidaktiveringen lyckades, bör du förvänta dig att innehållet som du har aktiverat också kommer att tömmas ur cachen.

Uppdatera sidan och se gamla saker! vad? fanns det grönt ljus?!

Låt oss följa några steg i processen för att tömma och ta reda på vad som kan vara fel.  Kör följande rensningsbegäran med curl från utgivargränssnittet:

```
$ curl -H "CQ-Action: Activate" \ 
-H "CQ-Handle: /content/<PATH TO ITEM TO FLUSH>" \ 
-H "CQ-Path: /content/<PATH TO ITEM TO FLUSH>" \ 
-H "Content-Length: 0" -H "Content-Type: application/octet-stream" \ 
-H "Host: flush" \ 
http://<DISPATCHER IP ADDRESS>/dispatcher/invalidate.cache
```

Exempel på tömningsbegäran för test

```
$ curl -H "CQ-Action: Activate" \ 
-H "CQ-Handle: /content/customer/en-us" \ 
-H "CQ-Path: /content/customer/en-us" \ 
-H "Content-Length: 0" -H "Content-Type: application/octet-stream" \ 
-H "Host: flush" \ 
http://169.254.196.222/dispatcher/invalidate.cache
```

När du har avaktiverat begärandekommandot till Dispatcher vill du se vad som har gjorts i loggarna och vad som har gjorts med `.stat files`.  Tail the log file and you should see the following entries to confirm flush request hit the Dispatcher module

```
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Activation detected: action=Activate [/content/dam/logo.jpg] 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Touched /mnt/var/www/html/.stat 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Touched /mnt/var/www/html/content/.stat 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Touched /mnt/var/www/html/content/dam/.stat 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] "GET /dispatcher/invalidate.cache" 200 purge [publishfarm/-] 0ms
```

Nu när modulen har hämtats och godkänts måste vi se hur den påverkade `.stat`-filerna.  Kör följande kommando och se hur tidsstämplarna uppdateras när du skickar en ny tömning:

```
$ watch -n 3 "find /mnt/var/www/html/ -type f -name ".stat" | xargs ls -la $1"
```

Som du kan se från kommandot returnerar tidsstämplarna för de aktuella `.stat` filerna

```
-rw-r--r--. 1 apache apache 0 Nov 13 16:54 /mnt/var/www/html/content/dam/.stat 
-rw-r--r--. 1 apache apache 0 Nov 13 16:54 /mnt/var/www/html/content/.stat 
-rw-r--r--. 1 apache apache 0 Nov 13 16:54 /mnt/var/www/html/.stat
```

Om vi kör rensningen igen ser du hur tidsstämplarna uppdateras

```
-rw-r--r--. 1 apache apache 0 Nov 13 17:17 /mnt/var/www/html/content/dam/.stat 
-rw-r--r--. 1 apache apache 0 Nov 13 17:17 /mnt/var/www/html/content/.stat 
-rw-r--r--. 1 apache apache 0 Nov 13 17:17 /mnt/var/www/html/.stat
```

Låt oss jämföra våra tidsstämplar med våra `.stat`-filtidsstämplar

```
$ stat /mnt/var/www/html/content/customer/en-us/.stat 
  File: `.stat' 
  Size: 0           Blocks: 0          IO Block: 4096   regular empty file 
Device: ca90h/51856d    Inode: 17154125    Links: 1 
Access: (0644/-rw-r--r--)  Uid: (   48/  apache)   Gid: (   48/  apache) 
Access: 2019-11-13 16:22:31.000000000 -0400 
Modify: 2019-11-13 16:22:31.000000000 -0400 
Change: 2019-11-13 16:22:31.000000000 -0400 
 
$ stat /mnt/var/www/html/content/customer/en-us/logo.jpg 
File: `logo.jpg' 
  Size: 15856           Blocks: 32          IO Block: 4096   regular file 
Device: ca90h/51856d    Inode: 9175290    Links: 1 
Access: (0644/-rw-r--r--)  Uid: (   48/  apache)   Gid: (   48/  apache) 
Access: 2019-11-11 22:41:59.642450601 +0000 
Modify: 2019-11-11 22:41:59.642450601 +0000 
Change: 2019-11-11 22:41:59.642450601 +0000
```

Om du tittar på någon av tidsstämplarna kommer du att märka att innehållet har en nyare tid än filen `.stat` som instruerar modulen att hantera filen från cachen eftersom den är nyare än filen `.stat`.

Skriv tydligt att något uppdaterade tidsstämpeln för den här filen som inte kvalificerar den som&quot;tömd&quot; eller ersatt.

[Nästa -> Vanity-URL:er](./disp-vanity-url.md)
