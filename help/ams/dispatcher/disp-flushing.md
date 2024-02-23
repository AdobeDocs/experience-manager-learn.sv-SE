---
title: AEM Dispatcher-tömning
description: Förstå hur AEM gör gamla cachefiler ogiltiga från Dispatcher.
version: 6.5
topic: Administration
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 461873a1-1edf-43a3-b4a3-14134f855d86
duration: 653
source-git-commit: 19beb662b63476f4745291338d944502971638a3
workflow-type: tm+mt
source-wordcount: '2225'
ht-degree: 0%

---

# Dispatcher Vanity-URL:er

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Använda och förstå variabler](./variables.md)

Det här dokumentet innehåller riktlinjer för hur tömning sker och en förklaring av vilken mekanism som exekverar tömning och ogiltigförklaring av cache.


## Så här fungerar det

### Operationsordning

Det typiska arbetsflödet beskrivs bäst när innehållsförfattare ska aktivera en sida och när utgivaren tar emot det nya innehållet utlöses en tömningsbegäran till Dispatcher enligt följande diagram:
![författare aktiverar innehåll, vilket utlöser att utgivaren skickar en begäran om tömning till Dispatcher](assets/disp-flushing/dispatcher-flushing-order-of-events.png "dispatcher-flushing-order-of-events")
Den här kedjan av händelser markerar att vi bara rensar objekt när de är nya eller har ändrats.  Detta garanterar att innehållet har tagits emot av utgivaren innan cachen rensas för att undvika konkurrensförhållanden där rensningen kan ske innan ändringarna kan hämtas från utgivaren.

## Replikeringsagenter

Vid författaren finns det en replikeringsagent som är konfigurerad att peka på utgivaren att när något aktiveras utlöses det att skicka filen och alla dess beroenden till utgivaren.

När utgivaren tar emot filen har den en replikeringsagent som är konfigurerad att peka på Dispatcher som utlöser händelsen on-receive.  Sedan serialiseras en tömningsbegäran och skickas till Dispatcher.

### REPLIKATIONSAGENT FÖR FÖRFATTARE

Här följer några exempel på skärmbilder av en konfigurerad standardslikeringsagent
![skärmbild av standardroppreplikeringsagenten från AEM webbsida /etc/replication.html](assets/disp-flushing/author-rep-agent-example.png "author-rep-agent-example")

Vanligtvis har 1 eller 2 replikeringsagenter konfigurerats på författaren för varje utgivare som de replikerar innehåll till.

Det första är den standardsvar för replikering som överför innehållsaktiveringar till.

Det andra är det omvända agenset.  Detta är valfritt och är konfigurerat för att kontrollera om det finns nytt innehåll att hämta till författaren som en omvänd replikeringsaktivitet

### PUBLISHER REPLICATION AGENT

Här är ett exempel på skärmbilder av en konfigurerad standardimporteringsagent
![skärmbild av standardsvarningsagenten för tömning från AEM webbsida /etc/replication.html](assets/disp-flushing/publish-flush-rep-agent-example.png "publish-flush-rep-agent-example")

### SKICKA FLUSH-REPLIKATION SOM TAR EMOT VIRTUAL HOST

Dispatcher-modulen letar efter särskilda rubriker som ska veta när en POST-förfrågan är något att skicka vidare till AEM eller om den är serialiserad som en tömningsbegäran och måste hanteras av Dispatcher-hanteraren.

Här är en skärmbild av konfigurationssidan som visar följande värden:
![bild på fliken med inställningar för huvudkonfigurationsskärmen med serialiseringstypen som visas som Dispatcher Flush](assets/disp-flushing/disp-flush-agent1.png "disp-flush-agent1")

Standardinställningssidan visar `Serialization Type` as `Dispatcher Flush` och anger felnivån

![Skärmbild av transportfliken för replikeringsagenten.  Detta visar den URI som begäran om tömning ska skickas till.  /dispatcher/invalidate.cache](assets/disp-flushing/disp-flush-agent2.png "disp-flush-agent2")

På `Transport` -fliken som du kan se `URI` anges till att peka på IP-adressen för Dispatcher som ska ta emot rensningsbegäranden.  Banan `/dispatcher/invalidate.cache` är inte hur modulen avgör om det är en tömning, det är bara en tydlig slutpunkt som du kan se i åtkomstloggen för att veta att det var en tömningsbegäran.  På `Extended` går vi igenom de saker som finns för att kvalificera att det här är en rensningsförfrågan till modulen Dispatcher.

![Skärmbild på fliken Utökat för replikeringsagenten.  Observera de huvuden som skickas med begäran om POST som skickats för att tala om för Dispatcher att tömma](assets/disp-flushing/disp-flush-agent3.png "disp-flush-agent3")

The `HTTP Method` för tömningsbegäranden är bara en `GET` begäran med särskilda begärandehuvuden:
- CQ-Action
   - Detta använder en AEM variabel som baseras på begäran och värdet är vanligtvis *aktivera eller ta bort*
- CQ-Handle
   - Detta använder en AEM variabel som baseras på begäran och värdet är vanligtvis den fullständiga sökvägen till objektet som tömts, till exempel `/content/dam/logo.jpg`
- CQ-Path
   - Detta använder en AEM variabel som baseras på begäran och värdet är vanligtvis den fullständiga sökvägen till det objekt som ska tömmas, till exempel `/content/dam`
- Värd
   - Det är här `Host` Huvudet är förfalskat för att ange en specifik `VirtualHost` som har konfigurerats på dispatcher Apache-webbservern (`/etc/httpd/conf.d/enabled_vhosts/aem_flush.vhost`).  Det är ett hårdkodat värde som matchar en post i `aem_flush.vhost` fil `ServerName` eller `ServerAlias`

![Skärmen på en standardoperationsagent som visar att replikeringsagenten med respons och utlösare när nya objekt har tagits emot från en replikeringshändelse från författarens publiceringsinnehåll](assets/disp-flushing/disp-flush-agent4.png "disp-flush-agent4")

På `Triggers` som vi tar upp de växlade utlösare vi använder och vad de är

- `Ignore default`
   - Detta är aktiverat så att replikeringsagenten inte aktiveras vid sidaktivering.  Detta är något som utlöser en tömning när en författarinstans ändrar till en sida.  Eftersom det här är en utgivare vill vi inte utlösa den typen av händelse.
- `On Receive`
   - När en ny fil tas emot vill vi utlösa en tömning.  Så när författaren skickar en uppdaterad fil till oss utlöser vi och skickar en begäran om tömning till Dispatcher.
- `No Versioning`
   - Vi kontrollerar detta för att undvika att utgivaren genererar nya versioner eftersom en ny fil har tagits emot.  Vi ersätter bara den fil vi har och förlitar oss på att författaren håller reda på versionerna istället för utgivaren.

Om vi nu tittar på hur en typisk flush-begäran ser ut i form av en `curl` kommando

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

Det här justeringsexemplet tömmer `/content/dam` sökväg genom att uppdatera `.stat` i den katalogen.

## The `.stat` fil

Blodvallningsmekanismen är enkel till sin natur och vi vill förklara vikten av `.stat` filer som genereras i dokumentroten där cachefilerna skapas.

Innanför `.vhost` och `_farm.any` filer som vi konfigurerar ett dokumentrotdirektiv för att ange var cachen finns och var filer ska lagras/hanteras från när en begäran från en slutanvändare kommer in.

Om du kör följande kommando på Dispatcher-servern kommer du att hitta `.stat` filer

```
$ find /mnt/var/www/html/ -type f -name ".stat"
```

Här följer ett diagram över hur den här filstrukturen ser ut när du har objekt i cachen och har fått en tömningsbegäran skickad och bearbetad av modulen Dispatcher

![statusfiler blandade med innehåll och datum som visas på statusnivåer](assets/disp-flushing/dispatcher-statfiles.png "dispatcher-statfiles")

### STARTFILNIVÅ

Observera att det fanns en `.stat` fil finns.  Det här är en indikator på att en tömning har skett.  I exemplet ovanför `statfilelevel` inställningen är inställd på `3` i motsvarande servergruppskonfigurationsfil.

The `statfilelevel` anger hur många mappar som är djupa i modulen som ska gå igenom och uppdatera en `.stat` -fil.  .stat-filen är tom, det är bara ett filnamn med en datamastamp och kan till och med skapas manuellt, men du kan köra pekkommandot på kommandoraden på Dispatcher-servern.

Om inställningen för statusfilnivå är för hög kommer varje justeringsbegäran att gå igenom katalogträdets beröringstillståndsfiler.  Detta kan få stora prestanda i stora cacheträd och kan påverka den övergripande prestandan för Dispatcher.

Om den här filnivån anges för låg kan det medföra att en rensningsbegäran rensas mer än vad som var tänkt.  Detta skulle i sin tur få cachen att krascha oftare med färre begäranden som skickas från cachen och kan orsaka prestandaproblem.

>[!BEGINSHADEBOX &quot;Anteckning&quot;]

Ange `statfilelevel` på en rimlig nivå. Titta på mappstrukturen och se till att den är konfigurerad så att du kan utföra korta genomgångar utan att behöva gå igenom för många kataloger. Testa det och se till att det passar dina behov under ett prestandatest av systemet.

Ett bra exempel är en webbplats som har stöd för språk. Det typiska innehållsträdet skulle ha följande kataloger

`/content/brand1/en/us/`

I det här exemplet använder du en inställning för statusfilnivå på 4. Detta garanterar när du tömmer innehåll som finns under **`us`** som inte gör att även språkmapparna blir tömda.

>[!ENDSHADEBOX]

### STÄLL FILTIDSSTÄMPELHANTERING

När en begäran om innehåll kommer in i samma rutin händer

1. Tidsstämpel för `.stat` filen jämförs med den begärda filens tidsstämpel
2. Om `.stat` filen är nyare än den begärda filen. Den tar bort det cachelagrade innehållet och hämtar en ny från AEM och cachelagrar det.  Ändrar sedan innehållet
3. Om `.stat` filen är äldre än den begärda filen. Den vet då att filen är ny och kan hantera innehållet.

### CACHEMANG - EXEMPEL 1

I exemplet ovan finns en begäran om innehållet `/content/index.html`

Tiden för `index.html` filen är 2019-11-01 vid 6:21PM

Tiden för närmaste `.stat` filen är 2019-11-01 vid 12:22 PM

Om du förstår vad vi har läst ovan kan du se att indexfilen är nyare än `.stat` filen och filen kommer att hanteras från cachen till slutanvändaren som begärde den

### CACHE-HANTERING - EXEMPEL 2

I exemplet ovan finns en begäran om innehållet `/content/dam/logo.jpg`

Tiden för `logo.jpg` filen är 2019-10-31 vid 1:13 PM

Tiden för närmaste `.stat` filen är 2019-11-01 vid 12:22 PM

Som du kan se i det här exemplet är filen äldre än `.stat` filen tas bort och en ny hämtas från AEM för att ersätta den i cachen innan den skickas till slutanvändaren som begärde den.

## Inställningar för servergruppsfil

Dokumentation finns här för alla konfigurationsalternativ: [https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html#configuring-dispatcher_configuring-the-dispatcher-cache-cache](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en)

Vi vill framhäva några av dem som rör cachetömning

### Töm grupper

Det finns två nycklar `document root` kataloger som cachelagrar filer från författare och utgivare.  För att hålla katalogerna uppdaterade med nytt innehåll måste vi tömma cachen.  Dessa rensningsbegäranden vill inte trassla med era vanliga kundtrafikgruppskonfigurationer som kan avvisa begäran eller göra något oönskat.  I stället tillhandahåller vi två rensningsgrupper för den här uppgiften:

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

Du anger i vilken katalog du vill att Dispatcher ska fylla i och hantera som en cachekatalog.

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

Den här inställningen mäter hur djupt `.stat` filer måste genereras när en tömningsbegäran kommer in.

`/statfileslevel` anges med följande nummer med dokumentroten för `/var/www/html/` skulle få följande resultat vid tömning `/content/dam/brand1/en/us/logo.jpg`

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
>Kom ihåg att när tidsstämpelhandskakningen inträffar så ser den ut som närmast `.stat` -fil.
>
>Med `.stat` filnivå 0 och en startfil endast på `/var/www/html/.stat` betyder det innehåll som lever under `/var/www/html/content/dam/brand1/en/us/` skulle leta efter närmaste `.stat` och bläddra mellan fem mappar för att hitta den enda `.stat` som finns på nivå 0 och jämför datum med det. Att en tömning vid den nivån gör i princip alla cachelagrade objekt ogiltiga.

### Invalidering tillåten

Den här konfigurationsposten finns i följande avsnitt i servergruppsfilen:

```
/myfarm { 
    /cache { 
        /allowedClients {
```

I den här konfigurationen placerar du en lista över IP-adresser som kan skicka rensningsbegäranden.  Om en rensningsbegäran kommer in i Dispatcher måste den komma från en betrodd IP.  Om du har felkonfigurerat detta eller skickar en tömningsbegäran från en IP-adress som inte är betrodd visas följande fel i loggfilen:

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

När du har avaktiverat kommandot till Dispatcher vill du se vad som har gjorts i loggarna och vad som har gjorts med kommandot `.stat files`.  Tail the log file and you should see the following entries to confirm flush request hit the Dispatcher module

```
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Activation detected: action=Activate [/content/dam/logo.jpg] 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Touched /mnt/var/www/html/.stat 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Touched /mnt/var/www/html/content/.stat 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] Touched /mnt/var/www/html/content/dam/.stat 
[Wed Nov 13 16:54:12 2019] [I] [pid 19173:tid 140542721578752] "GET /dispatcher/invalidate.cache" 200 purge [publishfarm/-] 0ms
```

Nu när vi ser modulen som plockats upp och bekräftat begäran om tömning måste vi se hur den påverkade `.stat` filer.  Kör följande kommando och se hur tidsstämplarna uppdateras när du skickar en ny tömning:

```
$ watch -n 3 "find /mnt/var/www/html/ -type f -name ".stat" | xargs ls -la $1"
```

Som du kan se av kommandot kan du skriva ut tidsstämplarna för den aktuella `.stat` filer

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

Låt oss jämföra våra tidsstämplar med våra `.stat` tidsstämplar för filer

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

Om du tittar på någon tidsstämpel kommer du att märka att innehållet har en nyare tid än `.stat` som instruerar modulen att hantera filen från cachen eftersom den är nyare än `.stat` -fil.

Skriv tydligt att något uppdaterade tidsstämpeln för den här filen som inte kvalificerar den som&quot;tömd&quot; eller ersatt.

[Nästa -> Vanity-URL:er](./disp-vanity-url.md)
