---
title: Grundläggande fillayout för AMS Dispatcher
description: Förstå den grundläggande layouten för filerna Apache och Dispatcher.
version: 6.5
topic: Administration, Development
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 8a3f2bb9-3895-45c6-8bb5-15a6d2aac50e
duration: 308
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1130'
ht-degree: 0%

---

# Grundläggande fillayout

[Innehållsförteckning](./overview.md)

[&lt;- Previous: What is &quot;The Dispatcher&quot;](./what-is-the-dispatcher.md)

I det här dokumentet förklaras AMS-standardkonfigurationsuppsättningen och hur man tänker bakom den här konfigurationsstandarden

## Standardmappstruktur för Enterprise Linux

I AMS använder grundinstallationen Enterprise Linux som basoperativsystem. När du installerar Apache Webserver finns en standardinställd installationsfil. Här är standardfilerna som installeras genom att grundläggande RPM-moduler som tillhandahålls av yum-databasen installeras

```
/etc/httpd/ 
├── conf 
│   ├── httpd.conf 
│   └── magic 
├── conf.d 
│   ├── autoindex.conf 
│   ├── README 
│   ├── userdir.conf 
│   └── welcome.conf 
├── conf.modules.d 
│   ├── 00-base.conf 
│   ├── 00-dav.conf 
│   ├── 00-lua.conf 
│   ├── 00-mpm.conf 
│   ├── 00-proxy.conf 
│   ├── 00-systemd.conf 
│   └── 01-cgi.conf 
├── logs -> ../../var/log/httpd 
├── modules -> ../../usr/lib64/httpd/modules 
└── run -> /run/httpd
```

När vi följer och följer installationsdesignen/-strukturen får vi följande fördelar:

- Enklare att hantera en förutsägbar layout
- Automatiskt bekant för alla som tidigare arbetat med Enterprise Linux HTTPD
- Tillåter patchningscykler som stöds fullt ut av operativsystemet utan konflikter eller manuella justeringar
- Undviker SELinux-överträdelser av felmärkta filkontexter

>[!BEGINSHADEBOX &quot;Anteckning&quot;]

Adobe Managed Services-serverbilder har vanligtvis små rotenheter i operativsystemet.  Vi placerar våra data i en separat volym som vanligtvis monteras i `/mnt`
Sedan använder vi volymen i stället för standardvärdena för följande standardkataloger

`DocumentRoot`
- Standard:`/var/www/html`
- AMS:`/mnt/var/www/html`

`Log Directory`
- Standard: `/var/log/httpd`
- AMS: `/mnt/var/log/httpd`

Kom ihåg att gamla och nya kataloger mappas tillbaka till den ursprungliga monteringspunkten för att undvika förvirring.
Att använda en separat volym är inte nödvändigt, men det är värt att notera

>[!ENDSHADEBOX]

## AMS-tillägg

AMS lägger till ytterligare information i grundinstallationen av Apache Web Server.

### Dokumentrot

AMS-standarddokumentrötter:
- Författare:
   - `/mnt/var/www/author/`
- Publicera:
   - `/mnt/var/www/html/`
- Underhåll av alla- och hälsokontroller
   - `/mnt/var/www/default/`

### Mellanlagring och aktiverade VirtualHost-kataloger

Med följande kataloger kan du bygga ut konfigurationsfiler med ett mellanlagringsområde som du kan arbeta med filer och bara aktivera när de är klara.
- `/etc/httpd/conf.d/available_vhosts/`
   - Den här mappen är värd för alla VirtualHost/filer som anropas `.vhost`
- `/etc/httpd/conf.d/enabled_vhosts/`
   - När du är redo att använda `.vhost` filer, finns inuti `available_vhosts` mapplänka dem med en relativ sökväg till `enabled_vhosts` katalog

### Ytterligare `conf.d` Kataloger

Det finns ytterligare delar som är vanliga i Apache-konfigurationer och vi har skapat underkataloger för att göra det möjligt att separera dessa filer på ett rent sätt och inte ha alla filer i en katalog

#### Skriver om katalog

Den här katalogen kan innehålla alla `_rewrite.rules` filer som du skapar och som innehåller dina vanliga RewriteRuleSyntax som engagerar Apache-webbservrar [mod_rewrite](https://httpd.apache.org/docs/current/mod/mod_rewrite.html) modul

- `/etc/httpd/conf.d/rewrites/`

#### Katalogen Whitelists

Den här katalogen kan innehålla alla `_whitelist.rules` filer som du skapar och som innehåller `IP Allow` eller `Require IP`syntax som engagerar Apache-webbservrar [åtkomstkontroller](https://httpd.apache.org/docs/2.4/howto/access.html)

- `/etc/httpd/conf.d/whitelists/`

#### Variabelkatalog

Den här katalogen kan innehålla alla `.vars` filer som du skapar och som innehåller variabler som du kan använda i dina konfigurationsfiler

- `/etc/httpd/conf.d/variables/`

### Dispatcher-modulspecifik konfigurationskatalog

Apache Web Server är mycket utbyggbar och när en modul har många konfigurationsfiler är det bäst att skapa en egen konfigurationskatalog under installationens baskatalog i stället för att rensa upp standardkatalogen.

Vi följer den bästa metoden och skapar en egen

#### Katalog för modulkonfigurationsfil

- `/etc/httpd/conf.dispatcher.d/`

#### Mellanlagring och aktiverad servergrupp

Med följande kataloger kan du bygga ut konfigurationsfiler med ett mellanlagringsområde som du kan arbeta med filer och bara aktivera när de är klara.
- `/etc/httpd/conf.dispatcher.d/available_farms/`
   - Den här mappen är värd för alla `/myfarm {` filer anropade `_farm.any`
- `/etc/httpd/conf.dispatcher.d/enabled_farms/`
   - När du är redo att använda servergruppsfilen finns det en länk i mappen available_farm med en relativ sökväg till katalogen enabled_farm

### Ytterligare `conf.dispatcher.d` Kataloger

Det finns ytterligare delar som är underavsnitt i filkonfigurationerna för Dispatcher-servergruppen och vi har skapat underkataloger för att göra det möjligt att separera dessa filer på ett rent sätt och inte ha alla filer i en katalog

#### Cachekatalog

Den här katalogen innehåller alla `_cache.any`, `_invalidate.any` filer som du skapar och som innehåller regler för hur du vill att modulen ska hantera cachelagrade element som kommer från AEM samt syntaxen för ogiltighetsregler.  Mer information finns här [här](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en#configuring-the-dispatcher-cache-cache)

- `/etc/httpd/conf.dispatcher.d/cache/`

#### Katalog för klientrubriker

Den här katalogen kan innehålla alla `_clientheaders.any` filer som du skapar som innehåller listor med klientrubriker som du vill skicka till AEM när en begäran kommer in.  Mer information om det här avsnittet finns [här](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=en)

- `/etc/httpd/conf.dispatcher.d/clientheaders/`

#### Filterkatalog

Den här katalogen kan innehålla alla `_filters.any` filer som du skapar och som innehåller alla filterregler för att blockera eller tillåta trafik genom Dispatcher att nå AEM

- `/etc/httpd/conf.dispatcher.d/filters/`

#### Återger katalog

Den här katalogen kan innehålla alla `_renders.any` filer som du skapar och som innehåller anslutningsinformationen till varje backend-server som avsändaren kommer att använda innehåll från

- `/etc/httpd/conf.dispatcher.d/renders/`

#### Vvärkatalog

Den här katalogen kan innehålla alla `_vhosts.any` filer som du skapar och som innehåller en lista med domännamn och sökvägar som matchar en viss servergrupp med en viss serverdel

- `/etc/httpd/conf.dispatcher.d/vhosts/`

## Fullständig mappstruktur

AMS har strukturerat var och en av filerna med anpassade filtillägg och med avsikt att undvika namnutrymmesproblem/konflikter och förvirring.

Här är ett exempel på en standardfiluppsättning från en AMS-standarddistribution:

```
/etc/httpd/
├── conf
│   ├── httpd.conf
│   └── magic
├── conf.d
│   ├── 000_init_ootb_vars.conf
│   ├── 001_init_ams_vars.conf
│   ├── README
│   ├── autoindex.conf
│   ├── available_vhosts
│   │   ├── 000_unhealthy_author.vhost
│   │   ├── 000_unhealthy_publish.vhost
│   │   ├── aem_author.vhost
│   │   ├── aem_flush.vhost
│   │   ├── aem_flush_author.vhost
│   │   ├── aem_health.vhost
│   │   ├── aem_publish.vhost
│   │   └── ams_lc.vhost
│   ├── dispatcher_vhost.conf
│   ├── enabled_vhosts
│   │   ├── aem_author.vhost -> ../available_vhosts/aem_author.vhost
│   │   ├── aem_flush.vhost -> ../available_vhosts/aem_flush.vhost
│   │   ├── aem_health.vhost -> /etc/httpd/conf.d/available_vhosts/aem_health.vhost
│   │   └── aem_publish.vhost -> ../available_vhosts/aem_publish.vhost
│   ├── logformat.conf
│   ├── mimetypes3d.conf
│   ├── remoteip.conf
│   ├── rewrites
│   │   ├── base_rewrite.rules
│   │   └── xforwarded_forcessl_rewrite.rules
│   ├── security.conf
│   ├── userdir.conf
│   ├── variables
│   │   ├── ams_default.vars
│   │   └── ootb.vars
│   ├── welcome.conf
│   └── whitelists
│       └── 000_base_whitelist.rules
├── conf.dispatcher.d
│   ├── available_farms
│   │   ├── 000_ams_catchall_farm.any
│   │   ├── 001_ams_author_flush_farm.any
│   │   ├── 001_ams_publish_flush_farm.any
│   │   ├── 002_ams_author_farm.any
│   │   ├── 002_ams_lc_farm.any
│   │   └── 002_ams_publish_farm.any
│   ├── cache
│   │   ├── ams_author_cache.any
│   │   ├── ams_author_invalidate_allowed.any
│   │   ├── ams_publish_cache.any
│   │   └── ams_publish_invalidate_allowed.any
│   ├── clientheaders
│   │   ├── ams_author_clientheaders.any
│   │   ├── ams_common_clientheaders.any
│   │   ├── ams_lc_clientheaders.any
│   │   └── ams_publish_clientheaders.any
│   ├── dispatcher.any
│   ├── enabled_farms
│   │   ├── 000_ams_catchall_farm.any -> ../available_farms/000_ams_catchall_farm.any
│   │   ├── 001_ams_author_flush_farm.any -> ../available_farms/001_ams_author_flush_farm.any
│   │   ├── 001_ams_publish_flush_farm.any -> ../available_farms/001_ams_publish_flush_farm.any
│   │   ├── 002_ams_author_farm.any -> ../available_farms/002_ams_author_farm.any
│   │   └── 002_ams_publish_farm.any -> ../available_farms/002_ams_publish_farm.any
│   ├── filters
│   │   ├── ams_author_filters.any
│   │   ├── ams_lc_filters.any
│   │   └── ams_publish_filters.any
│   ├── renders
│   │   ├── ams_author_renders.any
│   │   ├── ams_lc_renders.any
│   │   └── ams_publish_renders.any
│   └── vhosts
│       ├── ams_author_vhosts.any
│       ├── ams_lc_vhosts.any
│       └── ams_publish_vhosts.any
├── conf.modules.d
│   ├── 00-base.conf
│   ├── 00-dav.conf
│   ├── 00-lua.conf
│   ├── 00-mpm.conf
│   ├── 00-mpm.conf.old
│   ├── 00-proxy.conf
│   ├── 00-systemd.conf
│   ├── 01-cgi.conf
│   └── 02-dispatcher.conf
├── logs -> ../../var/log/httpd
├── modules -> ../../usr/lib64/httpd/modules
└── run -> /run/httpd
```

## Behåll det idealiskt

Enterprise Linux har patchcykler för Apache Webserver Package (httpd).

De mindre installerade standardfilerna som du ändrar blir bättre. Om några patchade säkerhetskorrigeringar eller konfigurationsförbättringar tillämpas via kommandot RPM/Yum kommer korrigeringarna inte att tillämpas ovanpå en ändrad fil.

Istället skapas en `.rpmnew` -filen bredvid originalet.  Det innebär att du kommer att sakna vissa ändringar som du kan ha önskat och skapat mer skräp i konfigurationsmapparna.

RPM:en under uppdateringsinstallationen kommer att undersöka `httpd.conf` om det finns i `unaltered` ange att den *ersätt* filen så får du de viktigaste uppdateringarna.  Om `httpd.conf` var `altered` sedan *ersätter inte* filen och i stället skapas en referensfil med namnet `httpd.conf.rpmnew` och de många korrigeringar som du vill göra finns i filen som inte gäller vid tjänststart.

Enterprise Linux har konfigurerats korrekt för att hantera det här användningsexemplet på ett bättre sätt.  De ger dig områden där du kan utöka eller åsidosätta de standardvärden som de anger åt dig.  I grundinstallationen av httpd hittar du filen `/etc/httpd/conf/httpd.conf`och har en syntax som:

```
Include conf.modules.d/.conf
IncludeOptional conf.d/.conf
```

Apache vill att du ska utöka modulerna och konfigurationerna genom att lägga till nya filer i `/etc/httpd/conf.d/` och `/etc/httpd/conf.modules.d/` kataloger med filtillägg för `.conf`

Som det perfekta exemplet när du lägger till modulen Dispatcher i Apache skapar du en modul `.so` fil i ` /etc/httpd/modules/` och sedan inkludera den genom att lägga till en fil i `/etc/httpd/conf.modules.d/02-dispatcher.conf` med innehåll som ska läsa in modulen `.so` fil

```
LoadModule dispatcher_module modules/mod_dispatcher.so
```

>[!NOTE]
>
>Inga redan befintliga filer som Apache har tillhandahållits ändrades. Istället har vi lagt till våra i katalogerna de ska gå.

Nu använder vi vår modul i vår fil <b>`/etc/httpd/conf.d/dispatcher_vhost.conf`</b> som initierar modulen och läser in den initiala modulspecifika konfigurationsfilen

```
<IfModule disp_apache2.c> 
    DispatcherConfig conf.dispatcher.d/dispatcher.any 
    ...SNIP... 
</IfModule>
```

Även här kommer du att märka att vi har lagt till filer och moduler, men inte ändrat några originalfiler.  Detta ger oss den önskade funktionaliteten och skyddar oss från saknade korrigeringar samt att hålla oss till högsta kompatibilitetsnivå med varje uppgradering av paketet.

[Nästa -> Förklaring av konfigurationsfiler](./explanation-config-files.md)
