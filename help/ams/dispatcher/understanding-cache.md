---
title: Dispatcher förstärkta cachning
description: Lär dig hur Dispatcher-modulen fungerar, dess cache.
topic: Administration, Performance
version: Experience Manager 6.5
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 66ce0977-1b0d-4a63-a738-8a2021cf0bd5
duration: 407
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1708'
ht-degree: 0%

---

# Cachelagring

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Förklaring av konfigurationsfiler](./explanation-config-files.md)

Det här dokumentet förklarar hur Dispatcher cachning går till och hur det kan konfigureras

## Cachelagra kataloger

Vi använder följande standardcachekataloger i våra baslinjeinstallationer

- Författare
   - `/mnt/var/www/author`
- Utgivare
   - `/mnt/var/www/html`

När varje begäran går igenom Dispatcher följer förfrågningarna de konfigurerade reglerna för att behålla en lokalt cachelagrad version som svar på giltiga objekt

>[!NOTE]
>
>Vi håller avsiktligt den publicerade arbetsbelastningen åtskild från författarens arbetsbelastning, eftersom när Apache söker efter en fil i DocumentRoot så vet det inte vilken AEM-instans den kommer från. Så även om du har inaktiverat cache i författargruppen, och om författarens DocumentRoot är samma som utgivaren, kommer den att leverera filer från cachen när den finns. Det innebär att du kan leverera författarfiler från publicerade cacheminnen och skapa en riktigt fantastisk mixningsupplevelse för besökarna.
>
>Att ha separata DocumentRoot-kataloger för olika publicerat innehåll är också en dålig idé. Du måste skapa flera omcachelagrade objekt som inte skiljer sig åt mellan platser som clientlibs, och du måste också konfigurera en agent för att tömma replikeringen för varje DocumentRoot som du konfigurerar. Öka mängden spolning över huvudet när varje sida aktiveras. Använd namnutrymmet för filer och deras fullständiga cachelagrade sökvägar för att undvika flera DocumentRoot-filer för publicerade webbplatser.

## Konfigurationsfiler

Dispatcher kontrollerar vad som kvalificerar sig som cacheable i avsnittet `/cache {` i en servergruppsfil. 
I AMS baslinjekonfigurationsgrupper hittar du våra inkluderingar enligt nedan:


```
/cache { 
    /rules { 
        $include "/etc/httpd/conf.dispatcher.d/cache/ams_author_cache.any" 
    }
```


När du skapar regler för vad som ska cachelagras eller inte, se dokumentationen [här](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#configuring-the-dispatcher-cache-cache)


## Cacheförfattare

Det finns många implementeringar vi har sett där folk inte cachelagrar författarinnehåll. 
De saknar en stor uppgradering vad gäller prestanda och lyhördhet för författarna.

Låt oss prata om strategin som har tagits för att konfigurera vår författargrupp så att den cachelagras ordentligt.

Här är en `/cache {`-del av författarservergruppens fil:


```
/cache { 
    /docroot "/mnt/var/www/author" 
    /statfileslevel "2" 
    /allowAuthorized "1" 
    /rules { 
        $include "/etc/httpd/conf.dispatcher.d/cache/ams_author_cache.any" 
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
        $include "/etc/httpd/conf.dispatcher.d/cache/ams_author_invalidate_allowed.any" 
    } 
}
```

Det viktiga att notera här är att `/docroot` är inställt på cachekatalogen för författaren.

>[!NOTE]
>
>Kontrollera att `DocumentRoot` i författarens `.vhost`-fil matchar parametern `/docroot` för servergrupper

Cachereglerna innehåller programsatsen filen `/etc/httpd/conf.dispatcher.d/cache/ams_author_cache.any` som innehåller följande regler:

```
/0000 { 
 /glob "*" 
 /type "deny" 
} 
/0001 { 
 /glob "/libs/*" 
 /type "allow" 
} 
/0002 { 
 /glob "/libs/*.html" 
 /type "deny" 
} 
/0003 { 
 /glob "/libs/granite/csrf/token.json" 
 /type "deny" 
} 
/0004 { 
 /glob "/apps/*" 
 /type "allow" 
} 
/0005 { 
 /glob "/apps/*.html" 
 /type "deny" 
} 
/0006 { 
 /glob "/libs/cq/core/content/welcome.*" 
 /type "deny" 
}
```

I ett författarscenario ändras innehållet hela tiden och i rätt syfte. Du vill bara cachelagra objekt som inte ändras så ofta.
Vi har regler för att cachelagra `/libs` eftersom de ingår i den grundläggande AEM-installationen och kommer att ändras tills du har installerat Service Pack, Cumulative Fix Pack, Upgrade eller Hotfix. Att cachelagra dessa element är därför en smula vettigt och har stora fördelar med författarupplevelsen för de slutanvändare som använder webbplatsen.

>[!NOTE]
>
>Kom ihåg att de här reglerna även cachelagrar <b>`/apps`</b>, det är här den anpassade programkoden finns. Om du utvecklar din kod för den här instansen blir den väldigt förvirrande när du sparar filen och du ser inte om den återspeglar den i användargränssnittet eftersom den sparar en cachelagrad kopia. Avsikten här är att om du distribuerar koden till AEM så är det också ovanligt, och en del av driftsättningsstegen bör vara att rensa författarcachen. Även här är fördelen stor, vilket gör att den tillgängliga koden kan köras snabbare för slutanvändarna.

## ServeOnStale (AKA-server vid föråldrad/SOS)

Det här är en av dessa pärlor i en av Dispatcher:s särdrag. Om utgivaren är under belastning eller inte svarar kommer den oftast att generera en http-svarskod på 502 eller 503. Om det händer och den här funktionen är aktiverad får Dispatcher instruktioner att fortsätta leverera det som finns kvar i cachen som en bra åtgärd, även om det inte är en ny kopia. Det är bättre att skicka något om du har det, i stället för att bara visa ett felmeddelande som inte har någon funktionalitet.

>[!NOTE]
>
>Tänk på att om utgivarrenderaren har en sockettimeout eller ett felmeddelande om 500 kommer den här funktionen inte att aktiveras. Om AEM bara inte kan nås händer ingenting

Den här inställningen kan ställas in i vilken grupp som helst, men det är bara bra att använda den i publiceringsservergruppens filer. Här följer ett syntaxexempel på funktionen som är aktiverad i en servergruppsfil:

```
/cache { 
    /serveStaleOnError "1"
```

## Cachelagra sidor med frågeparametrar/argument

>[!NOTE]
>
>Ett av de normala beteendena för Dispatcher-modulen är att om en begäran har en frågeparameter i URI:n (visas vanligtvis som `/content/page.html?myquery=value`), kommer den att hoppa över cachelagring av filen och gå direkt till AEM-instansen. Den här begäran behandlas som en dynamisk sida och bör inte cachas. Detta kan orsaka skadliga effekter på cacheeffektiviteten.

Se den här [artikeln](https://github.com/adobe/aem-dispatcher-optimizer-tool/blob/main/docs/Rules.md#dot---the-dispatcher-publish-farm-cache-should-have-its-ignoreurlparams-rules-configured-in-an-allow-list-manner) som visar hur viktiga frågeparametrar kan påverka webbplatsens prestanda.

Som standard vill du ange att reglerna `ignoreUrlParams` ska tillåta `*`.  Betyder att alla frågeparametrar ignoreras och tillåter att alla sidor cachelagras oavsett vilka parametrar som används.

Här är ett exempel där någon har skapat en mekanism för djuplänksreferens för sociala medier som använder argumentreferensen i URI:n för att ta reda på var personen kom ifrån.

*Okänt exempel:*

- https://www.we-retail.com/home.html?reference=android
- https://www.we-retail.com/home.html?reference=facebook

Sidan är 100 % tillgänglig men cachelagras inte eftersom argumenten finns. 
Om du konfigurerar `ignoreUrlParams` som tillåtelselista kan du åtgärda det här problemet:

```
/cache { 
    /ignoreUrlParams { 
        /0001 { /glob "*" /type "allow" }
    }
```

När Dispatcher ser begäran kommer den att ignorera det faktum att begäran har parametern `query` för referensen `?` och fortfarande cachelagra sidan

<b>Dynamiskt exempel:</b>

- https://www.we-retail.com/search.html?q=fruit
- https://www.we-retail.com/search.html?q=vegetables

Tänk på att om du har frågeparametrar som gör att en sidändring görs i utdata måste du undanta dem från din ignorerade lista och göra sidan icke-cachelagrad igen.  En söksida som använder en frågeparameter ändrar till exempel den återgivna råa-html-filen.

Här är alltså HTML-källan för varje sökning:

`/search.html?q=fruit`:

```
<html>
...SNIP...
    <div id='results'>
        <div class='result'>
            Orange
        </div>
        <div class='result'>
            Apple
        </div>
        <div class='result'>
            Strawberry
        </div>
    </div>
</html>
```

`/search.html?q=vegetables`:

```
<html>
...SNIP...
    <div id='results'>
        <div class='result'>
            Carrot
        </div>
        <div class='result'>
            Cucumber
        </div>
        <div class='result'>
            Celery
        </div>
    </div>
</html>
```

Om du besökte `/search.html?q=fruit` först cachelagrades HTML-koden med resultat som visar frukt.

Sedan besöker du `/search.html?q=vegetables` sekunder, men då visas resultatet av frukten.
Detta beror på att frågeparametern för `q` ignoreras när det gäller cachelagring.  För att undvika det här problemet måste du anteckna sidor som återger olika HTML baserat på frågeparametrar och neka cachelagring för dessa.

Exempel:

```
/cache { 
    /ignoreUrlParams { 
        /0001 { /glob "*" /type "allow" }
        /0002 { /glob "q" /type "deny"  }
    }
```

Sidor som använder frågeparametrar via Javascript fungerar fortfarande helt och hållet utan parametrar i den här inställningen.  Eftersom de inte ändrar HTML-filen i vila.  De använder javascript för att uppdatera webbläsarnas körtider i den lokala webbläsaren.  Det innebär att om du använder frågeparametrarna med javascript är det högst troligt att du kan ignorera den här parametern för sidcachning.  Tillåt att den sidan cache-lagras och utnyttja prestandaförbättringarna!

>[!NOTE]
>
>Att hålla koll på dessa sidor kräver viss uppladdning men är väl värt prestandavinster.  Du kan be din CSE att köra en rapport om webbplatstrafiken för att ge dig en lista över alla sidor som använder frågeparametrar under de senaste 90 dagarna så att du vet vilka sidor du ska titta på och vilka frågeparametrar du inte ska ignorera

## Cachelagra svarsrubriker

Det är ganska uppenbart att Dispatcher cachelagrar `.html` sidor och klientlibs (t.ex. `.js`, `.css`), men visste du att det även kan cachelagra vissa svarshuvuden längs med innehållet i en fil med samma namn men ett `.h` filtillägg. På så sätt kan nästa svar inte bara på innehållet utan även på de svarshuvuden som ska följa med det från cachen.

AEM kan hantera mer än bara UTF-8-kodning

Ibland har objekt särskilda rubriker som hjälper till att styra cachefilens kodningsinformation och de senaste ändrade tidsstämplarna.

Dessa värden rensas som standard när de cachelagras och Apache httpd-webbservern gör sin egen bearbetning av resursen med sina vanliga filhanteringsmetoder, som vanligtvis är begränsad till mime-typgissning baserat på filtillägg.

Om du har Dispatcher cachelagrar resursen och de rubriker du vill ha kan du visa rätt upplevelse och se till att alla detaljer gör det i klientens webbläsare.

Här är ett exempel på en servergrupp med de rubriker som ska cachelagras angivna:

```
/cache { 
 /headers { 
  "Cache-Control" 
  "Content-Disposition" 
  "Content-Type" 
  "Expires" 
  "Last-Modified" 
  "X-Content-Type-Options" 
 } 
}
```


I det exempel de har konfigurerat AEM för att hantera rubriker letar CDN efter för att veta när cachen ska ogiltigförklaras. AEM kan nu avgöra vilka filer som blir ogiltiga baserat på sidhuvuden.

>[!NOTE]
>
>Kom ihåg att du inte kan använda reguljära uttryck eller matchning av glob. Det är en litteral lista över de rubriker som ska cachelagras. Placera bara i en lista över de literalrubriker som du vill att de ska cachelagras.

## Förvräng giltighetsperiod automatiskt

På AEM-system som har mycket aktivitet från författare som gör många sidaktiveringar kan du ha ett konkurrensvillkor där upprepade ogiltigförklaringar förekommer. Omfattande upprepad rensningsbegäran är inte nödvändig och du kan skapa en viss tolerans för att inte upprepa en tömning förrän respitperioden har rensats.

### Exempel på hur detta fungerar:

Om du har fem begäranden om att ogiltigförklara `/content/exampleco/en/` inträffar alla inom en 3-sekundersperiod.

Om den här funktionen är inaktiverad blir cachekatalogen `/content/exampleco/en/` ogiltig fem gånger

Om den här funktionen är aktiverad och inställd på 5 sekunder blir cachekatalogen `/content/exampleco/en/` <b>en gång</b> ogiltig

Här följer ett exempel på syntaxen för den här funktionen som konfigureras för en respitperiod på 5 sekunder:

```
/cache { 
    /gracePeriod "5"
```

## TTL-baserad invalidering

En nyare funktion i Dispatcher-modulen var `Time To Live (TTL)`-baserade invalideringsalternativ för cachelagrade objekt. När ett objekt cachelagras söker det efter cachekontrollhuvuden och skapar en fil i cachekatalogen med samma namn och ett `.ttl`-tillägg.

Här är ett exempel på funktionen som konfigureras i servergruppens konfigurationsfil:

```
/cache { 
    /enableTTL "1"
```

>[!NOTE]
>
>Kom ihåg att AEM fortfarande måste konfigureras för att skicka TTL-rubriker för Dispatcher för att de ska respekteras. Om du växlar den här funktionen kan Dispatcher bara veta när de filer som AEM har skickat cachekontrollrubriker för ska tas bort. Om AEM inte börjar skicka TTL-rubriker kommer Dispatcher inte att göra något särskilt här.

## Regler för cachefilter

Här är ett exempel på en baslinjekonfiguration för vilken element ska cachelagras på en utgivare:

```
/cache{ 
    /0000 { 
        /glob "*" 
        /type "allow" 
    } 
    /0001 { 
        /glob "/libs/granite/csrf/token.json" 
        /type "deny" 
    }
```

Vi vill göra vår publicerade webbplats så girig som möjligt och cachelagra allt.

Om det finns element som bryter upplevelsen vid cachelagring kan du lägga till regler som tar bort alternativet att cachelagra det objektet. Som du ser i exemplet ovan bör csrf-tokens aldrig cachelagras och har uteslutits. Mer information om hur du skriver dessa regler finns [här](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/configuring/dispatcher-configuration.html?lang=sv-SE#configuring-the-dispatcher-cache-cache)

[Nästa -> Använda och förstå variabler](./variables.md)
