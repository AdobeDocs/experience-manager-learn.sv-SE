---
title: Använda och förstå variabler i AEM Dispatcher Configuration
description: Lär dig hur du använder variabler i dina konfigurationsfiler för Apache- och Dispatcher-moduler för att ta dem till nästa nivå.
version: 6.5
topic: Administration, Development
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 299b32c3-7922-4eee-aa3a-56039a654f70
duration: 307
source-git-commit: 19beb662b63476f4745291338d944502971638a3
workflow-type: tm+mt
source-wordcount: '1089'
ht-degree: 0%

---

# Använda och förstå variabler

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Mer om cache](./understanding-cache.md)

I det här dokumentet beskrivs hur du kan utnyttja variablerna på webbservern i Apache och i konfigurationsfilerna för modulen Dispatcher.

## Variabel

Apache har stöd för variabler och sedan version 4.1.9 av modulen Dispatther har det också stöd för dem!

Vi kan utnyttja dessa för att göra många användbara saker som:

- Kontrollera att allt som är miljöspecifikt inte är infogat i konfigurationerna utan extraheras för att säkerställa att konfigurationsfilerna från dev fungerar med samma funktionella utdata.
- Växla mellan funktioner och ändra loggnivåer för oföränderliga filer som AMS tillhandahåller och du kan inte ändra dem.
- Ändra vilket inkluderar att använda baserat på variabler som `RUNMODE` och `ENV_TYPE`
- Matcha `DocumentRoot`och `VirtualHost` DNS-namn mellan Apache-konfigurationer och modulkonfigurationer.

## Använda baslinjevariabler

Eftersom AMS baslinjefiler är skrivskyddade och oföränderliga finns det funktioner som kan inaktiveras och aktiveras, liksom konfigureras genom redigering av de variabler som de använder.

### Baslinjevariabler

AMS-standardvariabler deklareras i filen `/etc/httpd/conf.d/variables/ootb.vars`.  Filen går inte att redigera, men finns för att säkerställa att variablerna inte har null-värden.  De ingår först, sedan än vi inkluderar `/etc/httpd/conf.d/variables/ams_default.vars`.  Du kan redigera filen för att ändra värdena på variablerna eller till och med inkludera samma variabelnamn och värden i din egen fil.

Här är ett exempel på filens innehåll `/etc/httpd/conf.d/variables/ams_default.vars`:

```
Define DISP_LOG_LEVEL info
Define AUTHOR_WHITELIST_ENABLED 0
Define PUBLISH_WHITELIST_ENABLED 0
Define AUTHOR_FORCE_SSL 1
Define PUBLISH_FORCE_SSL 0
```

### Exempel 1 - Tvinga SSL

Variablerna som visas ovan `AUHOR_FORCE_SSL`, eller `PUBLISH_FORCE_SSL` kan ställas in på 1 för att koda om omskrivningsregler som tvingar slutanvändare när de kommer in på http-begäran att omdirigeras till https

Här är konfigurationsfilens syntax som gör att den här växlingen fungerar:

```
</VirtualHost *:80> 
 <IfModule mod_rewrite.c> 
  ReWriteEngine on 
  <If "${PUBLISH_FORCE_SSL} == 1"> 
   Include /etc/httpd/conf.d/rewrites/forcessl_rewrite.rules 
  </If> 
 </IfModule> 
</VirtualHost>
```

Som du kan se är reglerna för omskrivning vad som har koden som omdirigerar slutanvändarens webbläsare, men variabeln som anges till 1 är vad som gör att filen kan användas eller inte

### Exempel 2 - Loggningsnivå

Variablerna `DISP_LOG_LEVEL` kan användas för att ange vad du vill ha för loggnivån som faktiskt används i den konfiguration som körs.

Här är syntaxexemplet som finns i AMS-konfigurationsfilerna för baslinjen:

```
<IfModule disp_apache2.c> 
 DispatcherLog    logs/dispatcher.log  
 DispatcherLogLevel ${DISP_LOG_LEVEL} 
</IfModule>
```

Om du behöver öka loggningsnivån för Dispatcher uppdaterar du bara `ams_default.vars` variabel `DISP_LOG_LEVEL` till den nivå du vill ha.

Exempelvärden kan vara ett heltal eller ordet:

| Loggnivå | Heltalsvärde | Word-värde |
| --- | --- | --- |
| Kalkera | 4 | trace |
| Felsök | 3 | debug |
| Info | 2 | info |
| Varning | 1 | varna |
| Fel | 0 | fel |

### Exempel 3 - Vitalister

Variablerna `AUTHOR_WHITELIST_ENABLED` och `PUBLISH_WHITELIST_ENABLED` kan anges till 1 för att aktivera regler för omskrivning som innehåller regler som tillåter eller tillåter inte användartrafik baserat på IP-adress.  Om du vill aktivera den här funktionen måste du kombinera den med att skapa en whitelist-regelfil så att den kan inkluderas.

Här är några syntaxexempel på hur variabeln aktiverar inkluderingen av vitlistfiler och ett exempel på vitlistfiler

`sample.vhost`:

```
<VirtualHost *:80> 
 <Directory /> 
  <If "${AUTHOR_WHITELIST_ENABLED} == 1"> 
   Include /etc/httpd/conf.d/whitelists/*_whitelist.rules 
  </If> 
 </Directory> 
</VirtualHost>
```

`sample_whitelist.rules`:

```
<RequireAny> 
  Require ip 10.43.0.10/24 
</RequireAny>
```

Som du kan se `sample_whitelist.rules` tvingar IP-begränsningen men om variabeln växlas kan den inkluderas i `sample.vhost`

## Var variablerna ska placeras

### Startargument för webbserver

AMS placerar server-/topologispecifika variabler i Apache-processens startargument i filen `/etc/sysconfig/httpd`

Den här filen har fördefinierade variabler som visas här:

```
AUTHOR_IP="10.43.0.59" 
AUTHOR_PORT="4502" 
AUTHOR_DOCROOT='/mnt/var/www/author' 
PUBLISH_IP="10.43.0.20" 
PUBLISH_PORT="4503" 
PUBLISH_DOCROOT='/mnt/var/www/html' 
ENV_TYPE='dev' 
RUNMODE='sites'
```

Detta är inte något du kan ändra, men det är bra att utnyttja i dina konfigurationsfiler

>[!NOTE]
>
>På grund av att den här filen bara inkluderas när tjänsten startas.  Tjänsten måste startas om för att ändringarna ska kunna hämtas.  Det räcker inte med en omladdning, men du måste starta om i stället

### Variabelfiler (`.vars`)

Egna variabler som anges i koden ska finnas i `.vars` filer i katalogen `/etc/httpd/conf.d/variables/`

De här filerna kan innehålla valfria anpassade variabler och vissa syntaxexempel kan visas i följande exempelfiler

`/etc/httpd/conf.d/variables/weretail_domains_dev.vars`:

```
Define WERETAIL_DOMAIN dev.weretail.com 
Define WERETAIL_ALT_DOMAIN dev.weretail.net
```

`/etc/httpd/conf.d/variables/weretail_domains_stage.vars`:

```
Define WERETAIL_DOMAIN stage.weretail.com
Define WERETAIL_ALT_DOMAIN stage.weretail.net
```

`/etc/httpd/conf.d/variables/weretail_domains_prod.vars`:

```
Define WERETAIL_DOMAIN www.weretail.com 
Define WERETAIL_ALT_DOMAIN www..weretail.net
```

När du skapar egna variabler namnger filerna enligt deras innehåll och följer namngivningsstandarderna i handboken [här](https://experienceleague.adobe.com/docs/experience-cloud-kcs/kbarticles/KA-17477.html#naming-convention).  I exemplet ovan ser du att variabelfilen är värd för de olika DNS-posterna som variabler som ska användas i konfigurationsfilerna.

## Använda variabler

Nu när du har definierat variablerna i dina variabelfiler vill du veta hur du använder dem på rätt sätt i dina andra konfigurationsfiler.

Vi ska använda exemplet `.vars` filer ovan för att illustrera ett korrekt användningssätt.

Vi vill inkludera alla miljöbaserade variabler globalt så skapar vi filen `/etc/httpd/conf.d/000_load_env_vars.conf`

```
IncludeOptional /etc/httpd/conf.d/variables/*_${ENV_TYPE}.vars
IncludeOptional /etc/httpd/conf.d/variables/*_${RUNMODE}.vars
```

Vi vet att när httpd-tjänsten startas hämtas den in de variabler som AMS anger i `/etc/sysconfig/httpd` och har variabeluppsättningen `ENV_TYPE` och `RUNMODE`

När denna globala `.conf` filen hämtas in tidigt eftersom filernas inbördes ordning `conf.d` är en alfanumerisk inläsningsordning som innebär 000 i filnamnet, vilket garanterar att det läses in före de andra filerna i katalogen.

Programsatsen include använder också en variabel i filnamnet.  Detta kan ändra vilken fil som läses in baserat på vilket värde som finns i `ENV_TYPE` och `RUNMODE` variabler.

Om `ENV_TYPE` värdet är `dev` så är filen som används:

`/etc/httpd/conf.d/variables/weretail_domains_dev.vars`

Om `ENV_TYPE` värdet är `stage` så är filen som används:

`/etc/httpd/conf.d/variables/weretail_domains_stage.vars`

Om `RUNMODE` värdet är `preview` så är filen som används:

`/etc/httpd/conf.d/variables/weretail_domains_preview.vars`

När den filen inkluderas kan vi använda de variabelnamn som finns lagrade i den.

I vår `/etc/httpd/conf.d/available_vhosts/weretail.vhost` kan vi byta ut den normala syntaxen som bara fungerade för dev:

```
<VirtualHost *:80> 
 ServerName dev.weretail.com 
 ServerAlias dev.weretail.net
```

Med en nyare syntax som utnyttjar kraften i variabler för att arbeta med dev, stage och prod:

```
<VirtualHost *:80> 
 ServerName ${WERETAIL_DOMAIN} 
 ServerAlias ${WERETAIL_ALT_DOMAIN}
```

I vår `/etc/httpd/conf.dispatcher.d/vhosts/weretail_vhosts.any` kan vi byta ut den normala syntaxen som bara fungerade för dev:

```
"dev.weretail.com" 
"dev.weretail.net"
```

Med en nyare syntax som utnyttjar kraften i variabler för att arbeta med dev, stage och prod:

```
"${WERETAIL_DOMAIN}" 
"${WERETAIL_ALT_DOMAIN}"
```

Dessa variabler har en enorm mängd återanvändning för att anpassa körningsinställningar utan att behöva ha olika distribuerade filer per miljö.  Du kan i stort sett mallanpassa dina konfigurationsfiler med hjälp av variabler och inkludera filer som är baserade på variabler.

## Visa variabelvärden

När vi använder variabler måste vi ibland söka efter vilka värden som kan finnas i konfigurationsfilerna.  Du kan visa de lösta variablerna genom att köra följande kommandon på servern:

```
source /etc/sysconfig/httpd;/sbin/httpd -S | grep Define | grep "="
```

Hur variablerna såg ut i din kompilerade Apache-konfiguration:

```
$ source /etc/sysconfig/httpd;/sbin/httpd -t -D DUMP_CONFIG | grep -v "#"
```

Hur variablerna såg ut i den kompilerade Dispatcher-konfigurationen:

```
$ source /etc/sysconfig/httpd;/sbin/httpd -t -D DUMP_ANY
```

Från utdata från kommandona ser du skillnaderna mellan variabeln i config-filen och den kompilerade utskriften.

Exempelkonfiguration

`/etc/httpd/conf.d/enabled_vhosts/aem_publish.vhost`:

```
<VirtualHost *:80> 
    DocumentRoot    ${PUBLISH_DOCROOT} 
```

Kör nu kommandona för att se kompilerade utdata

Kompilerad Apache-konfiguration:

```
$ source /etc/sysconfig/httpd;/sbin/httpd -t -D DUMP_CONFIG | grep DocumentRoot
DocumentRoot /mnt/var/www/html
```

Konfiguration för kompilerad utskickare:

```
$ source /etc/sysconfig/httpd;/sbin/httpd -t -D DUMP_ANY | grep docroot
/docroot "/mnt/var/www/html"
```

[Nästa -> Tömning](./disp-flushing.md)
