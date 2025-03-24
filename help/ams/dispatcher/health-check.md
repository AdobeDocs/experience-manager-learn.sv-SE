---
title: AMS Dispatcher Health Check
description: AMS tillhandahåller ett cgi-bin-skript för hälsokontroll som molnbelastningsutjämnarna kommer att köra för att se om AEM är felfritt och bör förbli i tjänst för allmän trafik.
version: Experience Manager 6.5
topic: Administration
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 69b4e469-52cc-441b-b6e5-2fe7ef18da90
duration: 247
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1143'
ht-degree: 0%

---

# AMS Dispatcher Health Check

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Skrivskyddade filer](./immutable-files.md)

När du har en AMS-baslinje installerad som dispatcher levereras den med några kostnadsfria funktioner.  En av dessa funktioner är en uppsättning hälsokontrollsskript.
Med dessa skript kan belastningsutjämnaren som sätter AEM-stacken i tur och ordning veta vilka ben som är felfria och hålla dem i drift.

![Animerad GIF som visar trafikflödet](assets/load-balancer-healthcheck/health-check.gif "Hälsokontrollsteg")

## Hälsokontroll för grundläggande belastningsutjämnare

När kundtrafiken kommer via internet för att nå din AEM-instans går de igenom en belastningsutjämnare

![Bilden visar trafikflödet från Internet till AEM via en belastningsutjämnare](assets/load-balancer-healthcheck/load-balancer-traffic-flow.png "belastningsutjämnare-trafikflöde")

Alla förfrågningar som kommer via belastningsutjämnaren rundar av robin till varje instans.  Belastningsutjämnaren har en inbyggd funktion för hälsokontroll som ser till att den skickar trafik till en felfri värd.

Standardkontrollen är vanligtvis en portkontroll för att se om servrarna som är målinriktade i belastningsutjämnaren lyssnar på porttrafiken är på (dvs. TCP 80 och 443)

> `Note:` Även om detta fungerar har det ingen riktig mätare för om AEM är hälsosamt.  Testar bara om Dispatcher (webbservern Apache) är igång och körs.

## Hälsokontroll för AMS

För att undvika att skicka trafik till en hälsosam dispatcher som står framför en ohälsosam AEM-instans skapade AMS några extrafunktioner som utvärderar benets hälsa och inte bara Dispatcher.

![Bilden visar de olika delarna som hälsokontrollen kan användas för ](assets/load-balancer-healthcheck/health-check-pieces.png "hälsokontroll-bitar")

Hälsokontrollen består av följande delar
- 1 `Load balancer`
- 1 `Apache web server`
- 3 `Apache *VirtualHost* config files`
- 5 `CGI-Bin scripts`
- 1 `AEM instance`
- 1 `AEM package`

Vi ska ta upp vad varje stycke är utformat för och deras betydelse

### AEM Package

För att ange om AEM fungerar måste du göra en grundläggande sidkompilering och skicka sidan.  Adobe Managed Services har skapat ett grundläggande paket som innehåller testsidan.  Sidan testar att databasen är aktiv och att resurserna och sidmallen kan återges.

![Bilden visar AMS-paketet i CRX-pakethanteraren](assets/load-balancer-healthcheck/health-check-package.png "healt-check-package")

Här är sidan.  Den visar databas-ID:t för installationen

![Bilden visar sidan AMS Regent ](assets/load-balancer-healthcheck/health-check-page.png "health-check-page")

> `Note:` Vi ser till att sidan inte kan cachelagras.  Det skulle inte kontrollera den faktiska statusen om varje gång den returnerade en cachelagrad sida!

Det här är den lätta slutpunkten som vi kan testa för att se att AEM är igång.

### Konfiguration av belastningsutjämnare

Vi konfigurerar belastningsutjämnarna så att de pekar på en CGI-BIN-slutpunkt i stället för att använda en portkontroll.

![Bilden visar hälsokontrollskonfigurationen för AWS belastningsutjämnare](assets/load-balancer-healthcheck/aws-settings.png "aws-lb-settings")

![Bilden visar Azure-belastningsutjämnarens hälsokontrollskonfiguration](assets/load-balancer-healthcheck/azure-settings.png "azure-lb-settings")

### Virtuella värddatorer för hälsoutkontroll i Apache

#### Virtuell CGI-BIN-värd `(/etc/httpd/conf.d/available_vhosts/ams_health.vhost)`

Detta är den `<VirtualHost>` Apache-konfigurationsfil som gör att CGI-Bin-filerna kan köras.

```
Listen 81
<VirtualHost *:81>
    ServerName	"health"
    ...SNIP...
    ScriptAlias /health/ "/var/www/cgi-bin/health/"
</VirtualHost>
```

> `Note:` cgi-bin-filer är skript som kan köras.  Detta kan vara en sårbar attackvektor och de skript som AMS använder är inte tillgängliga för allmänheten enbart för belastningsutjämnaren för att testas.


#### Virtuella värdar för felfritt underhåll

- `/etc/httpd/conf.d/available_vhosts/000_unhealthy_author.vhost`
- `/etc/httpd/conf.d/available_vhosts/000_unhealthy_publish.vhost`

Dessa filer namnges `000_` som prefix för syfte.  Det är avsiktligt konfigurerat att använda samma domännamn som den publicerade webbplatsen.  Avsikten är att den här filen ska aktiveras när hälsokontrollen upptäcker ett problem med en av AEM-serverdelarna.  Erbjud sedan en felsida istället för bara en 503 HTTP-svarskod utan någon sida.  Den stjäl trafik från den normala `.vhost`-filen eftersom den läses in före den `.vhost`-filen och delar samma `ServerName` eller `ServerAlias`.  Detta resulterar i sidor som är avsedda för en viss domän att gå till den ohälsosamma värden i stället för standardvärden, vilket är det normala trafikflödet.

När hälsokontrollsskripten körs loggar de ut sin aktuella hälsostatus.  En gång i minuten körs ett cronjob på servern som söker efter felfria poster i loggen.  Om utvecklaren av AEM-instansen inte är felfri aktiveras symbolen:

Loggpost:

```
# grep "ERROR\|publish" /var/log/lb/health_check.log
E, [2022-11-23T20:13:54.984379 #26794] ERROR -- : AUTHOR -- Exception caught: Connection refused - connect(2)
I, [2022-11-23T20:13:54.984403 #26794]  INFO -- : [checkpublish]-author:0-publish:1-[checkpublish]
```

Kron som plockar upp felet och reagerar:

```
# grep symlink /var/log/lb/health_check_reload.log
I, [2022-11-23T20:34:19.213179 #2275]  INFO -- : ADDING VHOST symlink /etc/httpd/conf.d/available_vhosts/000_unhealthy_author.vhost => /etc/httpd/conf.d/enabled_vhosts/000_unhealthy_author.vhost
```

Du kan kontrollera om författaren eller publicerade webbplatser kan få den här felsidan inläst genom att konfigurera inställningen för inläsningsläge i `/var/www/cgi-bin/health_check.conf`

```
# grep RELOAD_MODE /var/www/cgi-bin/health_check.conf
RELOAD_MODE='author'
```

Giltiga alternativ:
- författare
   - Det här är standardalternativet.
   - Detta skapar en underhållssida för författaren när den inte är felfri
- publicera
   - Med det här alternativet skapas en underhållssida för utgivaren när den inte är felfri
- alla
   - Med det här alternativet skapas en underhållssida för författaren eller utgivaren eller båda om de inte är felfria
- ingen
   - Det här alternativet hoppar över den här funktionen i hälsokontrollen

När du tittar på inställningen `VirtualHost` för dessa ser du att de läser in samma dokument som en felsida för varje begäran som kommer när den är aktiverad:

```
<VirtualHost *:80>
	ServerName	unhealthyauthor
	ServerAlias	${AUTHOR_DEFAULT_HOSTNAME}
	ErrorDocument	503 /error.html
	DocumentRoot	/mnt/var/www/default
	<Directory />
		Options FollowSymLinks
		AllowOverride None
	</Directory>
	<Directory "/mnt/var/www/default">
		AllowOverride None
		Require all granted
	</Directory>
	<IfModule mod_headers.c>
		Header always add X-Dispatcher ${DISP_ID}
		Header always add X-Vhost "unhealthy-author"
	</IfModule>
	<IfModule mod_rewrite.c>
		ReWriteEngine   on
		RewriteCond %{REQUEST_URI} !^/error.html$
		RewriteRule ^/* /error.html [R=503,L,NC]
	</IfModule>
</VirtualHost>
```

Svarskoden är fortfarande en `HTTP 503`

```
# curl -I https://we-retail.com/
HTTP/1.1 503 Service Unavailable
X-Dispatcher: dispatcher1useast1
X-Vhost: unhealthy-author
```

Istället för en tom sida får de den här sidan.

![Bilden visar standardunderhållssidan](assets/load-balancer-healthcheck/unhealthy-page.png "sida som inte är felfri")

### CGI-fackskript

Det finns fem olika skript som kan konfigureras i inställningarna för belastningsutjämnaren av din CSE som ändrar beteendet eller villkoren när en Dispatcher ska dras ut från belastningsutjämnaren.

#### /bin/checkauthor

Det här skriptet används för att kontrollera och logga alla förekomster det kommer att köra men returnera bara ett fel om AEM-förekomsten `author` är ohälsosam

> `Note:` Tänk på att om publiceringsinstansen AEM inte är felfri så stannar dispatchern i tjänst så att trafik kan flöda till författarens AEM-instans

#### /bin/checkpublish (default)

Det här skriptet används för att kontrollera och logga alla förekomster det kommer att köra men returnera bara ett fel om AEM-förekomsten `publish` är ohälsosam

> `Note:` Tänk på att om författaren till AEM-instansen var felfri så stannar dispatchern i tjänst så att trafik kan flöda till den publicerade AEM-instansen

#### /bin/checkeither

Det här skriptet används för att kontrollera och logga alla förekomster det kommer att köra men returnera bara ett fel om `author`- eller `publisher` AEM-förekomsten är ohälsosam

> `Note:` Tänk på att om publiceringsinstansen eller författaren av AEM-instansen inte är felfri, skulle dispatchern sluta använda tjänsten.  Betyder att om någon av dem var hälsosam så skulle den inte heller få någon trafik

#### /bin/checkboth

Det här skriptet används för att kontrollera och logga alla förekomster det kommer att köra men returnera bara ett fel om `author`- och `publisher` AEM-instansen inte är felfri

> `Note:` Tänk på att om publiceringsinstansen eller författaren i AEM inte var felfri så skulle dispatchern inte sluta använda tjänsten.  Det innebär att om någon av dem var ohälsosam så skulle den även i fortsättningen få trafik och ge fel till personer som begär resurser.

#### /bin/fresh

Skriptet kommer att kontrollera och logga alla instanser som det kommer att starta men returnera felfritt oavsett om AEM returnerar ett fel eller inte.

> `Note:` Det här skriptet används när hälsokontrollen inte fungerar som du vill och tillåter en åsidosättning för att behålla AEM-instanser i belastningsutjämnaren.

[Nästa -> GIT-symboler](./git-symlinks.md)
