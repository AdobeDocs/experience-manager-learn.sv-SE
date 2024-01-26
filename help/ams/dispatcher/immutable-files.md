---
title: AMS Dispatcher - skrivskyddade eller oföränderliga filer
description: Förstå varför vissa filer är skrivskyddade eller inte går att redigera och hur du gör de funktionsändringar du vill
version: 6.5
topic: Administration, Development
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 7be6b3f9-cd53-41bc-918d-5ab9b633ffb3
duration: 266
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '825'
ht-degree: 0%

---

# Skrivskydda eller oföränderliga filer i AMS

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Vanliga loggar](./common-logs.md)

## Beskrivning

I det här dokumentet beskrivs vilka filer som är låsta och inte ska ändras, och hur du gör önskade konfigurationsinställningar på rätt sätt.

När AMS etablerar ett system kommer det att implementera en baslinjekonfiguration som gör allting funktionellt och säkert.  Det här är saker som AMS vill ska fungera som en baslinje för funktionalitet och säkerhet.  För att uppnå detta markeras vissa filer som skrivskyddade och oföränderliga, så att du inte kan ändra dem.

Layouten förhindrar inte att du ändrar deras beteende och åsidosätter ändringar som du behöver.  I stället för att du ändrar de här filerna täcker du över din egen fil som ersätter originalfilen.

Detta gör också att du kan vara säker på att när AMS korrigerar utskickarna med de senaste korrigeringarna och säkerhetsförbättringarna så ändras inte filerna.  Sedan kan du fortsätta att dra nytta av förbättringarna och bara använda de ändringar du vill.
![Visar ett bowlingband med en boll som rullar längs körfältet.  Kulan har en pil med ordet som visar dig.  Spaltmellanrummen är upphöjda och de har orden oföränderliga filer ovanför dem.](assets/immutable-files/bowling-file-immutability.png "bowling-file-immutability")
Som framgår av bilden ovan hindrar inte oföränderliga filer dig från att spela spelet.  De hindrar dig bara från att skada din prestanda och håller dig i farten.  Med den här metoden får vi några viktiga funktioner:

- Anpassningar hanteras i sina egna säkra utrymmen
- Övertäckning för anpassade ändringar speglar för övertäckningsmetoder i AEM
- Du kan korrigera AMS-konfigurationer utan att ändra anpassningar
- Testa grundinstallationen jämfört med anpassade konfigurationer kan göras samtidigt för att hjälpa till att avgöra om problemen beror på anpassningar eller något annat. Vilka filer?


Här är en typisk lista över filer som distribuerats med en Dispatcher:

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
│   ├── 01-cgi.conf
│   └── 02-dispatcher.conf
└── modules - ../../usr/lib64/httpd/modules
    └── mod_dispatcher.so
```

Om du vill ta reda på vilka filer som inte kan ändras kan du köra följande kommando på en Dispatcher för att se:

```
$ lsattr -Rl /etc/httpd 2>/dev/null | grep Immutable
```

Här följer ett exempel på svar där filer inte kan ändras:

```
/etc/httpd/conf/httpd.conf   Immutable
/etc/httpd/conf.d/available_vhosts/aem_author.vhost Immutable
/etc/httpd/conf.d/available_vhosts/aem_publish.vhost Immutable
/etc/httpd/conf.d/available_vhosts/aem_flush.vhost Immutable
/etc/httpd/conf.d/available_vhosts/aem_health.vhost Immutable
/etc/httpd/conf.d/available_vhosts/000_unhealthy_author.vhost Immutable
/etc/httpd/conf.d/available_vhosts/000_unhealthy_publish.vhost Immutable
/etc/httpd/conf.d/available_vhosts/aem_flush_author.vhost Immutable
/etc/httpd/conf.d/available_vhosts/ams_lc.vhost Immutable
/etc/httpd/conf.d/rewrites/base_rewrite.rules Immutable
/etc/httpd/conf.d/rewrites/xforwarded_forcessl_rewrite.rules Immutable
/etc/httpd/conf.d/whitelists/000_base_whitelist.rules Immutable
/etc/httpd/conf.d/variables/ootb.vars Immutable
/etc/httpd/conf.d/dispatcher_vhost.conf Immutable
/etc/httpd/conf.d/logformat.conf Immutable
/etc/httpd/conf.d/security.conf Immutable
/etc/httpd/conf.d/mimetypes3d.conf Immutable
/etc/httpd/conf.d/remoteip.conf Immutable
/etc/httpd/conf.d/000_init_ootb_vars.conf Immutable
/etc/httpd/conf.d/001_init_ams_vars.conf Immutable
/etc/httpd/conf.modules.d/02-dispatcher.conf Immutable
/etc/httpd/conf.dispatcher.d/available_farms/000_ams_catchall_farm.any Immutable
/etc/httpd/conf.dispatcher.d/available_farms/001_ams_author_flush_farm.any Immutable
/etc/httpd/conf.dispatcher.d/available_farms/001_ams_publish_flush_farm.any Immutable
/etc/httpd/conf.dispatcher.d/available_farms/002_ams_author_farm.any Immutable
/etc/httpd/conf.dispatcher.d/available_farms/002_ams_lc_farm.any Immutable
/etc/httpd/conf.dispatcher.d/available_farms/002_ams_publish_farm.any Immutable
/etc/httpd/conf.dispatcher.d/cache/ams_author_cache.any Immutable
/etc/httpd/conf.dispatcher.d/cache/ams_author_invalidate_allowed.any Immutable
/etc/httpd/conf.dispatcher.d/cache/ams_publish_cache.any Immutable
/etc/httpd/conf.dispatcher.d/cache/ams_publish_invalidate_allowed.any Immutable
/etc/httpd/conf.dispatcher.d/clientheaders/ams_author_clientheaders.any Immutable
/etc/httpd/conf.dispatcher.d/clientheaders/ams_publish_clientheaders.any Immutable
/etc/httpd/conf.dispatcher.d/clientheaders/ams_common_clientheaders.any Immutable
/etc/httpd/conf.dispatcher.d/clientheaders/ams_lc_clientheaders.any Immutable
/etc/httpd/conf.dispatcher.d/filters/ams_author_filters.any Immutable
/etc/httpd/conf.dispatcher.d/filters/ams_publish_filters.any Immutable
/etc/httpd/conf.dispatcher.d/filters/ams_lc_filters.any Immutable
/etc/httpd/conf.dispatcher.d/renders/ams_author_renders.any Immutable
/etc/httpd/conf.dispatcher.d/renders/ams_lc_renders.any Immutable
/etc/httpd/conf.dispatcher.d/renders/ams_publish_renders.any Immutable
/etc/httpd/conf.dispatcher.d/vhosts/ams_author_vhosts.any Immutable
/etc/httpd/conf.dispatcher.d/vhosts/ams_publish_vhosts.any Immutable
/etc/httpd/conf.dispatcher.d/vhosts/ams_lc_vhosts.any Immutable
/etc/httpd/conf.dispatcher.d/dispatcher.any Immutable
```

## Gör ändringar

### Variabel

Med variabler kan du göra funktionella ändringar utan att ändra själva konfigurationsfilerna.  Vissa element i konfigurationen kan justeras genom att variabelvärdena justeras.  Ett exempel som kan markeras från filen `/etc/httpd/conf.d/dispatcher_vhost.conf` visas här:

```
Include /etc/httpd/conf.d/variables/ams_default.vars
IfModule disp_apache2.c
    DispatcherConfig conf.dispatcher.d/dispatcher.any
    DispatcherLog    logs/dispatcher.log
    DispatcherLogLevel ${DISP_LOG_LEVEL}
    DispatcherDeclineRoot 0
    DispatcherUseProcessedURL 1
/IfModule
```

Se hur direktivet DispatcherLogLevel har variabeln `DISP_LOG_LEVEL` i stället för det normala värdet skulle du se där.  Ovanför det kodavsnittet visas även en include-sats till en variabelfil.  Variabelfilen `/etc/httpd/conf.d/variables/ams_default.vars` är där vi vill titta vidare.  Här är innehållet i variabelfilen:

```
Define DISP_LOG_LEVEL info
Define AUTHOR_WHITELIST_ENABLED 0
Define PUBLISH_WHITELIST_ENABLED 0
Define LIVECYCLE_WHITELIST_ENABLED 0
Define AUTHOR_FORCE_SSL 1
Define PUBLISH_FORCE_SSL 0
Define LIVECYCLE_FORCE_SSL 1
```

Det aktuella värdet för `DISP_LOG_LEVEL` variabeln is `info`.  Vi kan justera detta för att spåra eller felsöka, eller det talvärde/den nivå du väljer.  Nu kan du justera loggnivån automatiskt överallt som styr loggen.

### Överläggsmetod

Ta reda på den översta nivån med filer eftersom dessa blir den plats där du börjar göra anpassningar.  För att börja med ett enkelt exempel har vi ett scenario där vi vill lägga till ett nytt domännamn som vi tänker peka på denna Dispatcher.  Domänexemplet som vi använder är is we-retail.adobe.com.  Vi börjar med att kopiera en befintlig konfigurationsfil till en ny där vi kan lägga till våra ändringar:

```
$ cp /etc/httpd/conf.d/available_vhosts/aem_publish.vhost /etc/httpd/conf.d/available_vhosts/weretail_publish.vhost
```

Vi kopierade den befintliga filen aem_publish.vhost eftersom den redan har det vi behöver för att få saker och ting att fungera, och vi vill inte uppfinna en redan stark början på nytt.  Nu redigerar vi den nya filen weretail.vhost och gör de ändringar som behövs.

Före:

```
VirtualHost *:80
    ServerName    publish
    ServerAlias    ${PUBLISH_DEFAULT_HOSTNAME}
    DocumentRoot    ${PUBLISH_DOCROOT}
    IfModule mod_headers.c
            Header always add X-Dispatcher ${DISP_ID}
            Header always add X-Vhost "publish"
            Header merge X-Frame-Options SAMEORIGIN "expr=%{resp:X-Frame-Options}!='SAMEORIGIN'"
            Header merge X-Content-Type-Options nosniff "expr=%{resp:X-Content-Type-Options}!='nosniff'"
        Header append Vary User-Agent env=!dont-vary
    /IfModule
....... SNIP.......
/VirtualHost
```

Efter:

```
VirtualHost *:80
    ServerName    weretail-publish
    ServerAlias    we-retail.adobe.com
    DocumentRoot    ${PUBLISH_DOCROOT}
    IfModule mod_headers.c
            Header always add X-Dispatcher ${DISP_ID}
            Header always add X-Vhost "werteail-publish"
            Header merge X-Frame-Options SAMEORIGIN "expr=%{resp:X-Frame-Options}!='SAMEORIGIN'"
            Header merge X-Content-Type-Options nosniff "expr=%{resp:X-Content-Type-Options}!='nosniff'"
        Header append Vary User-Agent env=!dont-vary
    /IfModule
....... SNIP.......
/VirtualHost
```

Nu har vi uppdaterat vår `ServerName` och `ServerAlias` för att matcha de nya domännamnen samt för att uppdatera andra rubriker i vägbeskrivningar.  Låt oss nu aktivera vår nya fil så att apache kan använda vår nya fil:

```
$ cd /etc/httpd/conf.d/enabled_vhosts/; ln -s ../available_vhosts/weretail_publish.vhost .
```

Nu vet webbservern att domänen är något som den ska generera trafik för, men vi måste ändå informera Dispatcher-modulen om att den har ett nytt domännamn att respektera.  Vi börjar med att skapa ett nytt `*_vhost.any` fil `/etc/httpd/conf.dispatcher.d/vhosts/weretail_vhosts.any` och i den filen ska vi ange det domännamn som vi vill använda:

```
"we-retail.adobe.com"
```

Nu behöver vi skapa en ny servergruppsfil som använder vår nya värdevärdanmälningsfil, och vi börjar med att kopiera en stark startfil till vår egen nya.

```
$ cp /etc/httpd/conf.dispatcher.d/available_farms/999_ams_publish_farm.any /etc/httpd/conf.dispatcher.d/available_farms/400_weretail_publish_farm.any
```

Visa de ändringar vi måste göra i den här servergruppsfilen

Före:

```
/publishfarm {  
    /virtualhosts {
        $include "/etc/httpd/conf.dispatcher.d/vhosts/ams_publish_vhosts.any"
    }
........SNIP.........
}
```

Efter:

```
/weretailpublishfarm {  
    /virtualhosts {
        $include "/etc/httpd/conf.dispatcher.d/vhosts/weretail_publish_vhosts.any"
    }
........SNIP.........
}
```

Nu har vi uppdaterat servergruppsnamnet och tagit med det i `/virtualhosts` i servergruppskonfigurationen.  Vi måste aktivera den här nya servergruppsfilen så att den kan användas i konfigurationen som körs:

```
$ cd /etc/httpd/conf.dispatcher.d/enabled_farms/; ln -s ../available_farms/400_weretail_publish_farm.any .
```

Nu läser vi bara in webbservertjänsten igen och använder vår nya domän!

<div style="color: #000;border-left: 6px solid #2196F3;background-color:#ddffff;"><b>Obs!</b>

Observera att vi bara ändrade de delar vi behövde för att ändra och utnyttja den befintliga inkluderings- och koden som medföljde konfigurationsfilerna för baslinjen.  Vi behöver bara dra slutsatser om det vi behöver ändra.  Gör det enklare och gör att vi kan underhålla mindre kod
</div>

[Nästa -> Sändningshälsokontroll](./health-check.md)
