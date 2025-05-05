---
title: Förklaring av Dispatcher konfigurationsfiler
description: Förstå konfigurationsfiler, namnkonventioner med mera.
version: Experience Manager 6.5
topic: Administration
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: ec8e2804-1fd6-4e95-af6d-07d840069c8b
duration: 379
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1694'
ht-degree: 0%

---

# Förklaring av konfigurationsfiler

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Grundläggande fillayout](./basic-file-layout.md)

Det här dokumentet kommer att innehålla en beskrivning och en beskrivning av de konfigurationsfiler som distribueras i en standardbaserad Dispatcher-server som distribueras i Adobe Managed Services. deras användning, namnkonventioner osv.

## Namngivningskonvention

Apache Web Server bryr sig egentligen inte om vad filtillägget är för en fil när den används med en `Include`- eller `IncludeOptional`-sats.  Om du namnger dem på rätt sätt med namn som eliminerar konflikter och förvirring blir <b>ton</b> lättare. Namn som används beskriver filens användningsområde och gör livet enklare. Om allt har namnet `.conf` blir det förvirrande. Vi vill undvika dåligt namngivna filer och tillägg.  Nedan finns en lista över de olika anpassade filtillägg och namnkonventioner som används i en typisk AMS-konfigurerad Dispatcher.

## Filer i conf.d/

| Fil | Filmål | Beskrivning |
| ---- | ---------------- | ----------- |
| FILNAMN `.conf` | `/etc/httpd/conf.d/` | En standardinstallation av Enterprise Linux använder det här filtillägget och ta med mapp som en plats för att åsidosätta inställningar som deklarerats i httpd.conf och göra det möjligt att lägga till ytterligare funktioner på global nivå i Apache. |
| FILNAMN `.vhost` | Mellanlagrad: `/etc/httpd/conf.d/available_vhosts/`<br>Aktiv: `/etc/httpd/conf.d/enabled_vhosts/`<br/><br/><b>Obs!</b> .vhost-filer ska inte kopieras till mappen enabled_vhosts, men använd symboler för en relativ sökväg till filen available_vhosts/\*.vhost</u><br><br> | \*.vhost-filer (Virtual Host) är `<VirtualHosts>`  poster som matchar värdnamn och som tillåter att Apache hanterar varje domäntrafik med olika regler. Från filen `.vhost` inkluderas andra filer som `rewrites`, `whitelisting`, `etc`. |
| FILNAMN `_rewrite.rules` | `/etc/httpd/conf.d/rewrites/` | `*_rewrite.rules` filer lagrar `mod_rewrite` regler som ska inkluderas och användas explicit av en `vhost`-fil |
| FILNAMN `_whitelist.rules` | `/etc/httpd/conf.d/whitelists/` | `*_ipwhitelist.rules` filer inkluderas från `*.vhost`-filerna. Den innehåller IP-regex eller tillåter nekanderegler för att tillåta vitlistning av IP. Om du försöker begränsa visningen av ett virtuellt värdsystem baserat på IP-adresser genererar du en av dessa filer och tar med den från din `*.vhost`-fil |

## Filer i conf.dispatcher.d/

| Fil | Filmål | Beskrivning |
| --- | --- | --- |
| FILNAMN `.any` | `/etc/httpd/conf.dispatcher.d/` | AEM Dispatcher Apache Module hämtar inställningarna från `*.any` filer. Standardfilen för överordnad inkludering är `conf.dispatcher.d/dispatcher.any` |
| FILNAMN `_farm.any` | Mellanlagrad: `/etc/httpd/conf.dispatcher.d/available_farms/`<br>Aktiv: `/etc/httpd/conf.dispatcher.d/enabled_farms/`<br><br><b>Obs!</b> De här servergruppsfilerna ska inte kopieras till mappen `enabled_farms`, men använd `symlinks` för att ange en relativ sökväg till `available_farms/*_farm.any` file <br/>`*_farm.any` -filerna som finns i filen `conf.dispatcher.d/dispatcher.any` . Dessa överordnade gruppfiler finns för att styra modulbeteendet för varje rendering eller webbplatstyp. Filerna skapas i katalogen `available_farms` och aktiveras med en `symlink` i katalogen `enabled_farms`.  <br/>De inkluderas automatiskt efter namn från filen `dispatcher.any`.<br/><b>Baslinje</b>-servergruppsfiler börjar med `000_` för att se till att de läses in först.<br><b>Egna </b>-servergruppsfiler ska läsas in efter att deras nummerschema har startats på `100_` för att säkerställa korrekt inkluderingsbeteende. |
| FILNAMN `_filters.any` | `/etc/httpd/conf.dispatcher.d/filters/` | `*_filters.any` filer inkluderas från `conf.dispatcher.d/enabled_farms/*_farm.any`-filerna. Varje gård har en uppsättning regler som förändrar vilken trafik som ska filtreras bort och inte övergå till renderarna. |
| FILNAMN `_vhosts.any` | `/etc/httpd/conf.dispatcher.d/vhosts/` | `*_vhosts.any` filer inkluderas från `conf.dispatcher.d/enabled_farms/*_farm.any`-filerna. De här filerna är en lista över värdnamn eller uri-sökvägar som matchas av blobbmatchning för att avgöra vilken renderare som ska användas för begäran |
| FILNAMN `_cache.any` | `/etc/httpd/conf.dispatcher.d/cache/` | `*_cache.any` filer inkluderas från `conf.dispatcher.d/enabled_farms/*_farm.any`-filerna. De här filerna anger vilka objekt som cachelagras och vilka som inte |
| FILNAMN `_invalidate_allowed.any` | `/etc/httpd/conf.dispatcher.d/cache/` | `*_invalidate_allowed.any` filer ingår i `conf.dispatcher.d/enabled_farms/*_farm.any`-filerna. De anger vilka IP-adresser som tillåts skicka begäranden om tömning och ogiltigförklaring. |
| FILNAMN `_clientheaders.any` | `/etc/httpd/conf.dispatcher.d/clientheaders/` | `*_clientheaders.any` filer ingår i `conf.dispatcher.d/enabled_farms/*_farm.any`-filerna. De anger vilka klientrubriker som ska skickas till varje återgivning. |
| FILNAMN `_renders.any` | `/etc/httpd/conf.dispatcher.d/renders/` | `*_renders.any` filer ingår i `conf.dispatcher.d/enabled_farms/*_farm.any`-filerna. De anger inställningar för IP, port och timeout för varje återgivning. En korrekt återgivare kan vara en LiveCycle-server eller ett AEM-system där Dispatcher kan hämta/proxyköra förfrågningar från |

## Undantagna problem

När du följer namnkonventionen kan du undvika att göra misstag som kan få katastrofala resultat.  Vi ska ta upp några exempel.

### Exempel på problem

Som ett exempel på en plats för ExampleCo skapades två konfigurationsfiler av utvecklarna av Dispatcher-konfigurationerna.

<b>/etc/httpd/conf.d/exampleco.conf</b>

```
<VirtualHost *:80> 
    ServerName  "exampleco" 
    ServerAlias "www.exampleco.com" 
    .......... SNIP ............... 
    <IfModule mod_rewrite.c> 
        ReWriteEngine   on 
        LogLevel warn rewrite:trace1 
        Include /etc/httpd/conf.d/rewrites/exampleco.conf 
    </IfModule> 
</VirtualHost>
```

<b>/etc/httpd/conf.d/rewrites/exampleco.conf</b>

```
RewriteRule ^/$ /content/exampleco/en.html [PT,L] 
RewriteRule ^/robots.txt$ /content/dam/exampleco/robots.txt [PT,L]
```

#### `POTENTIAL DANGER - The file names are the same`

Om filen `vhost` av misstag placeras i mappen `rewrites` och `rewrites file` placeras i mappen `vhosts`.  Det verkar ha distribuerats korrekt av filnamnet, men Apache genererar ett *FEL* och problemet kommer inte att vara omedelbart synligt.

<b>Så här blir det oftast ett problem</b>

Om `two files` hämtas till platsen `same` kan de antingen `overwrite themselves` eller göra det omöjligt att särskilja, vilket gör distributionsprocessen till en mardröm.

<b>Filtilläggen är desamma och tar automatiskt med någon</b>

Filtilläggen är desamma och använder automatiskt inkluderat tillägg som Apache `auto include` alla `.conf` filer i många av standardmapparna.

<b>Så här blir det oftast ett problem</b>

Om värdfilen med tillägget `.conf` placeras i mappen `/etc/httpd/conf.d/` försöker den att läsa in den i minnet på Apache, vilket vanligtvis är ok, men om den omskrivande regelfilen med tillägget `.conf` placeras i mappen `/etc/httpd/conf.d/` inkluderas den automatiskt och används globalt, vilket ger förvirrande och oönskade resultat.

## Upplösning

Namnge filerna baserat på vad de gör och säkert ut ur namnutrymmet för automatiska inkluderingsregler.

Om det är ett virtuellt värdfilnamn får det namnet med `.vhost` som tillägg.

Om det är en återskrivningsregelfil namnger du den med platsen `_rewrite.rules` som suffix och tillägg. Den här namnkonventionen visar vilken webbplats den är avsedd för och att det är en uppsättning regler för omskrivning.

Om det är en IP-vitlistregelfil ger du den namnet `_whitelist.rules` som suffix och tillägg. Den här namnkonventionen ger en beskrivning av vad den är till för och att det är en uppsättning IP-matchningsregler.

Om du använder dessa namnkonventioner undviker du problem om en fil flyttas till en katalog för automatisk infogning som den inte tillhör.

Om du till exempel placerar en fil med namnet `.rules`, `.any` eller `.vhost` i den automatiska inkluderingsmappen för `/etc/httpd/conf.d/` påverkas inte filen.

Om en distributionsändringsbegäran säger&quot;Distribuera exempel_eco_rewrite.rules till produktionsutskickare&quot;, kan den som distribuerar ändringarna redan veta att de inte lägger till en ny webbplats, så uppdaterar de bara skrivreglerna enligt filnamnet.

### Inkludera order

När du utökar funktioner och konfigurationer i Apache Webserver som är installerad på Enterprise Linux har du några viktiga inkluderingsbeställningar som du vill förstå

### Apache-baslinjen innehåller

![Baslinjen för Apache HTTPD-webbservern innehåller](assets/explanation-config-files/Apache-Webserver-Baseline-Includes.png)

Som du ser i diagrammet ovan ser httpd-binärfilen bara ut mot httpd.conf-filen som konfigurationsfilen.  Filen innehåller följande programsatser:

```
Include conf.modules.d/*.conf 
IncludeOptional conf.d/*.conf
```

### AMS-toppnivån omfattar

När vi tillämpade vår standard lade vi till ytterligare filtyper och inkluderar våra egna.

Här är AMS-originalkataloger och toppnivån innehåller
![AMS Baseline innehåller start med en dispatcher_vhost.conf som inkluderar alla filer med *.vhost från katalogen /etc/httpd/conf.d/enabled_vhosts/.  Objekten i katalogen /etc/httpd/conf.d/enabled_vhosts/ är länkar till den faktiska konfigurationsfilen som finns i /etc/httpd/conf.d/available_vhosts/](assets/explanation-config-files/Apache-Webserver-AMS-Baseline-Includes.png "Apache-Webserver-AMS-Baseline-Includes")

Bygger på Apache baslinje visar vi hur AMS skapade ytterligare mappar och inkluderingar på översta nivån för `conf.d`-mappar samt modulspecifika kataloger som är kapslade under `/etc/httpd/conf.dispatcher.d/`

När Apache läses in hämtas den i `/etc/httpd/conf.modules.d/02-dispatcher.conf` och den filen inkluderar den binära filen `/etc/httpd/modules/mod_dispatcher.so` i körningstillståndet.

```
LoadModule dispatcher_module modules /mod_dispatcher .so
```

Om du vill använda modulen i `<VirtualHost />` släpper vi en konfigurationsfil i `/etc/httpd/conf.d/` med namnet `dispatcher_vhost.conf` och i den här filen använder du de grundläggande parametrar som behövs för att modulen ska fungera:

```
<IfModule disp_apache2.c> 
    DispatcherConfig conf.dispatcher.d/dispatcher.any 
    ...SNIP... 
</IfModule>
```

Som du ser ovan innehåller detta den översta `dispatcher.any`-filen för Dispatcher-modulen som kan hämta dess konfigurationsfiler från `/etc/httpd/conf.dispatcher.d/dispatcher.any`

Tänk på innehållet i den här filen:

```
/farms { 
    $include "enabled_farms/*_farm.any" 
}
```

Filen `dispatcher.any` på den översta nivån innehåller alla aktiverade servergruppsfiler som finns i `/etc/httpd/conf.dispatcher.d/enabled_farms/` med filnamnet `FILENAME_farm.any` som följer vår standardnamnkonvention.

Senare i filen `dispatcher_vhost.conf` som nämndes tidigare gör vi också en include-sats för att aktivera varje aktiverad virtuell värdfil som finns i `/etc/httpd/conf.d/enabled_vhosts/` med filnamnet `FILENAME.vhost` som följer vår standardnamnkonvention.

```
IncludeOptional /etc/httpd/conf.d/enabled_vhosts/*.vhost
```

I var och en av våra .vhost-filer kommer du att märka att Dispatcher-modulen initieras som en standardfilhanterare för en katalog.  Här är ett exempel på en .vhost-fil som visar syntaxen:

```
<VirtualHost *:80> 
 ServerName "weretail" 
 ServerAlias www.weretail.com weretail.com 
 <Directory /> 
  <IfModule disp_apache2.c> 
   ....SNIP.... 
   SetHandler dispatcher-handler 
  </IfModule> 
  ....SNIP.... 
 </Directory> 
 ....SNIP.... 
</VirtualHost>
```

När den översta nivån innehåller en lösning har de andra underinkluderingar som är värda att nämnas.  Här följer ett diagram på hög nivå över hur servergrupperna och värdfilerna innehåller andra underelement

### AMS virtuella värd innehåller

![Den här bilden visar hur en .vhost-fil innehåller filer från variabler, vitlistor och omskrivningar av mappar](assets/explanation-config-files/Apache-Webserver-AMS-Vhost-Includes.png "Apache-Webserver-AMS-Vhost-Includes")

När en `.vhost`-fil från `/etc/httpd/conf.d/availabled_vhosts/`-katalogen länkas till `/etc/httpd/conf.d/enabled_vhosts/`-katalogen används de i den konfiguration som körs.

Filerna `.vhost` har underinkluderingar baserat på vanliga delar som vi har hittat.  Saker som variabler, vitlistor och skrivregler.

Filen `.vhost` kommer att innehålla programsatser för varje fil baserat på var de måste inkluderas i filen `.vhost`.  Här är ett exempel på syntax för en `.vhost`-fil som en bra referens:

```
Include /etc/httpd/conf.d/variables/weretail.vars 
<VirtualHost *:80> 
 ServerName "${MAIN_DOMAIN}" 
 <Directory /> 
  Include /etc/httpd/conf.d/whitelists/weretail*_whitelist.rules 
  <IfModule disp_apache2.c> 
   ....SNIP.... 
   SetHandler dispatcher-handler 
  </IfModule> 
  ....SNIP.... 
 </Directory> 
 ....SNIP.... 
 <IfModule mod_rewrite.c> 
  ReWriteEngine   on 
  LogLevel warn rewrite:trace1 
  Include /etc/httpd/conf.d/rewrites/weretail_rewrite.rules 
 </IfModule> 
</VirtualHost>
```

Som du ser i exemplet ovan finns det en inkluderingsfunktion för de variabler som behövs i konfigurationsfilen och som används senare.

I filen `/etc/httpd/conf.d/variables/weretail.vars` kan vi se vilka variabler som är definierade:

```
Define MAIN_DOMAIN dev.weretail.com
```

Du kan också se en rad som innehåller en lista med `_whitelist.rules` filer som begränsar vem som kan visa det här innehållet baserat på olika vitlistvillkor.  Här kan du se innehållet i en av de vita listfilerna `/etc/httpd/conf.d/whitelists/weretail_mainoffice_whitelist.rules`:

```
<RequireAny> 
  Require ip 192.150.16.0/23 
</RequireAny>
```

Du kan även se en rad som innehåller en uppsättning regler för omskrivning.  Låt oss titta på innehållet i filen `weretail_rewrite.rules`:

```
RewriteRule ^/robots.txt$ /content/dam/weretail/robots.txt [NC,PT] 
RewriteCond %{SERVER_NAME} brand1.weretail.net [NC] 
RewriteRule ^/favicon.ico$ /content/dam/weretail/favicon.ico [NC,PT] 
RewriteCond %{SERVER_NAME} brand2.weretail.com [NC] 
RewriteRule ^/sitemap.xml$ /content/weretail/general/sitemap.xml [NC,PT] 
RewriteRule ^/logo.jpg$ /content/dam/weretail/general/logo.jpg [NC,PT]
```

### AMS-servergruppen innehåller

![&lt;FILENAME>_farm.any innehåller underordnade .any-filer för att slutföra en servergruppskonfiguration.  I den här bilden ser du att en servergrupp kommer att innehålla varje cache för avsnittsfiler på den översta nivån, klientheaders, filters, renders och vhosts.any-filer](assets/explanation-config-files/Apache-Webserver-AMS-Farm-Includes.png "Apache-Webserver-AMS-Farm-Includes")

När en FILENAME_farm.any-fil från katalogen `/etc/httpd/conf.dispatcher.d/available_farms/` får en länk till katalogen `/etc/httpd/conf.dispatcher.d/enabled_farms/` används de i den konfiguration som körs.

Servergruppsfilerna innehåller undergrupper baserade på [toppnivåavsnitt i servergruppen](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#defining-farms-farms) som cache, klienthuvuden, filter, återgivningar och värdar.

Filerna `FILENAME_farm.any` kommer att innehålla programsatser för varje fil baserat på var de måste inkluderas i servergruppsfilen.  Här är ett exempel på syntax för en `FILENAME_farm.any`-fil som en bra referens:

```
/weretailfarm {   
 /clientheaders { 
  $include "/etc/httpd/conf.dispatcher.d/clientheaders/ams_publish_clientheaders.any" 
  $include "/etc/httpd/conf.dispatcher.d/clientheaders/ams_common_clientheaders.any" 
 } 
 /virtualhosts { 
  $include "/etc/httpd/conf.dispatcher.d/vhosts/weretail_vhosts.any" 
 } 
 /renders { 
  $include "/etc/httpd/conf.dispatcher.d/renders/ams_publish_renders.any" 
 } 
 /filter { 
  $include "/etc/httpd/conf.dispatcher.d/filters/ams_publish_filters.any" 
  $include "/etc/httpd/conf.dispatcher.d/filters/weretail_search_filters.any" 
 } 
 ....SNIP.... 
 /cache { 
  ....SNIP.... 
  /rules { 
   $include "/etc/httpd/conf.dispatcher.d/cache/ams_publish_cache.any" 
  } 
  ....SNIP.... 
  /allowedClients { 
   /0000 { 
    /glob "*.*.*.*" 
    /type "deny" 
   } 
   $include "/etc/httpd/conf.dispatcher.d/cache/ams_publish_invalidate_allowed.any" 
  } 
 ....SNIP.... 
 } 
}
```

Som du kan se varje avsnitt för den lokala servergruppen i stället för att ha all syntax som behövs använder du programsatsen include.

Låt oss titta på syntaxen för några av dessa funktioner för att få en uppfattning om hur varje undergrupp skulle se ut

`/etc/httpd/conf.dispatcher.d/vhosts/weretail_publish_vhosts.any`:

```
"brand1.weretail.com" 
"brand2.weretail.com" 
"www.weretail.comf"
```

Som du ser är det en ny radavgränsad lista med domännamn som ska återges från den här servergruppen över de andra.

Titta sedan på `/etc/httpd/conf.dispatcher.d/filters/weretail_search_filters.any`:

```
/400 { /type "allow" /method "GET" /path "/bin/weretail/lists/*" /extension "json" } 
/401 { /type "allow" /method "POST" /path "/bin/weretail/search/' /extension "html" }
```

[Nästa -> Förstå cache](./understanding-cache.md)
