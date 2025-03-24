---
title: AEM Dispatcher Common Logs
description: Ta en titt på vanliga loggposter från Dispatcher och lär dig vad de innebär och hur du åtgärdar dem.
version: Experience Manager 6.5
topic: Administration, Performance
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 7fe1b4a5-6813-4ece-b3da-40af575ea0ed
duration: 229
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '796'
ht-degree: 0%

---

# Gemensamma loggar

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Vanity URLs](./disp-vanity-url.md)

## Ökning

Dokumentet beskriver vanliga loggposter som du kommer att se, vad de betyder och hur du hanterar dem.

## GLOB-varning

Exempelloggpost:

```
Fri Jul 20 03:35:09 2018 W pid 8300 (tid 139937910880384) /etc/httpd/conf/publish-filters.any:5: Allowing requests with globs is considered unsafe.
Please consult the documentation at 'https://www.adobe.com/go/docs_dispatcher_config_en' on how to use attributes 
method/url/query/protocol/path/selectors/extension/suffix instead.
```

Sedan Dispatcher modul 4.2.x började de avråda människor från att använda följande typ av matchningar i sina filterfiler:

```
/0041 { /type "allow" /glob "* *.css *"   }
```

I stället är det bättre att använda den nya syntaxen som:

```
/0041 { /type "allow" /url "*.css" }
```

Eller ännu bättre för att inte matcha mot en jokerteckensmatchare:

```
/0041 { /type "allow" /extension "css" }
```

Om du gör någon av de föreslagna metoderna tas felmeddelandet bort från loggarna.

## Filteravslag

>[!NOTE]
>
>De här posterna visas inte alltid, även om det uppstår avslag om loggnivån är för låg. Ställ in den på Info eller debug för att försäkra dig om att du kan se om filtren avvisar förfrågningarna.

Exempel på loggpost:

```
Fri Jul 20 17:25:48 2018 D pid 25939 (tid 139937517123328) Filter rejects: GET /libs/granite/core/content/login.html HTTP/1.1
```

eller:

```
Fri Jul 20 22:16:55 2018 I pid 128803 "GET /system/console/" ! - 8ms publishfarm/-
```

>[!CAUTION]
>
>Förstå att Dispatcher regler var inställda på att filtrera bort den begäran. I det här fallet avvisades sidan med avsikt och vi vill inte göra något med det.

Om loggen ser ut så här:

```
Fri Jul 20 17:26:47 2018 D pid 20051 (tid 139937517123328) Filter rejects: 
GET /etc/designs/exampleco/fonts/montserrat-regular/montserrat-regular-webfont.eot HTTP/1.1
```

Det meddelar oss om att designfilen `.eot` blockeras och vi vill åtgärda det.
Så vi bör titta på vår filterfil och lägga till följande rad för att tillåta `.eot` filer genom

```
/0011 { /type "allow" /method "GET" /extension 'eot' /path "/etc/designs/*" }
```

Detta gör att filen kan loggas igenom och förhindrar att den loggas.
Om du vill se vad som filtreras ut kan du köra det här kommandot i loggfilen:

```
$ grep "Filter rejects\|\!" /var/log/httpd/dispatcher.log | awk 'match($0, /\/.*\//, m){ print m0 }' | awk '{ print $1 }'| sort | uniq -c | sort -rn
```

## Timeout från återgivning

Loggpost för Socket-timeout-exempel:

```
Fri Jul 20 22:31:15 2018 W pid 3648 Unable to connect socket to 10.43.3.40:4502: Connection timed out 
Fri Jul 20 22:31:15 2018 W pid 3648 Unable to connect to any backend in farm authorfarm
```

Detta inträffar när du har konfigurerat fel IP-adress i återgivningsavsnittet i servergruppen. Det eller så slutade AEM-instansen att svara eller lyssna och Dispatcher kan inte nå den.

Kontrollera brandväggsreglerna och att AEM-instansen körs och är felfri.

Exempelloggposter för gateway-timeout:

```
Fri Jul 20 22:32:42 2018 I pid 3648 "GET /favicon.ico" 502 - 54034ms authorfarm/- 
Fri Jul 20 22:35:45 2018 I pid 3648 "GET /favicon.ico" 503 - 54234ms authorfarm/-
```

Detta innebär att AEM-instansen hade en öppen socket som den kunde nå och nådde tidsgränsen med svaret. Detta innebär att din AEM-instans var för långsam eller ohälsosam och att Dispatcher uppnådde de konfigurerade timeoutinställningarna i renderingssektionen i servergruppen. Öka timeoutinställningen eller få AEM-instansen felfri.

## Cachenivåer

Exempel på loggpost:

```
Fri Jul 20 23:00:19 2018 I pid 16004 (tid 140134145820416) Current cache hit ratio: 87.94 %
```

Det innebär att hämtningen från renderingsnivån kontra från cacheminnet mäts. Du vill uppnå 80+ procent från cacheminnet och du bör följa hjälpen [här](https://experienceleague.adobe.com/docs/experience-cloud-kcs/kbarticles/KA-17458.html):

För att få så många siffror som möjligt.

>[!NOTE]
>
>Även om du har cacheinställningarna i servergruppsfilen för att cachelagra allt som du kanske tömmer för ofta eller för aggressivt, vilket kan orsaka en lägre procentandel av cacheträffen

## Katalog saknas

Exempel på loggpost:

```
Fri Jul 20 14:02:43 2018 E pid 4728 (tid 140662586435328) Unable to create parent directory /mnt/var/www/author/libs/dam/content/asseteditors/formitems.overlay.infinity.json/application: Not a directory
```

Detta visas vanligtvis när ett objekt hämtas samtidigt som en cacherensning sker.

Det eller dokumentets rotkatalog har felaktiga behörigheter eller fel SELinux-filkontext i mappen som nekar apache att skapa de nya underkatalogerna som behövs.

Om du har behörighetsproblem kan du kontrollera behörigheterna för dokumentroten och se till att de ser ut ungefär så här:

```
dispatcher$ ls -Z /var/www/
drwxr-xr-x+ apache apache system_u:object_r:httpd_sys_content_t:s0 html
```

## Vanity URL not found

Exempel på loggpost:

```
Thu Sep 27 17:35:11 2018 D pid 18936 Checking vanity URLs 
Thu Sep 27 17:35:11 2018 D pid 18936 Vanity URL file (/tmp/vanity_urls) not found, fetching... 
Thu Sep 27 17:35:11 2018 W pid 18936 Unable to fetch vanity URLs from 10.43.0.42:4503/libs/granite/dispatcher/content/vanityUrls.html: remote server returned: HTTP/1.1 404 Not Found
```

Det här felet inträffar när du har konfigurerat din Dispatcher att använda det dynamiska autofiltret för att tillåta URL:er för innehållshantering, men inte slutfört installationen genom att installera paketet på AEM-renderaren.

Du åtgärdar detta genom att installera funktionsmakropaketet för vanity-URL på AEM-instansen och tillåta att det är klart av den anonyma användaren. Information [här](https://experienceleague.adobe.com/docs/experience-cloud-kcs/kbarticles/KA-17463.html)

En fungerande URL-adress ser ut så här:

```
Thu Sep 27 17:40:29 2018 D pid 21844 Checking vanity URLs 
Thu Sep 27 17:40:29 2018 D pid 21844 Vanity URL file (/tmp/vanity_urls) not found, fetching... 
Thu Sep 27 17:40:29 2018 D pid 21844 Loaded 18 vanity URLs from file /tmp/vanity_urls
```

## Grupp saknas

Exempel på loggpost:

```
Wed Nov 13 17:17:26 2019 W pid 19173:tid 140542738364160 No farm matches host 'we-retail.com', selected last farm 'publishfarm'
```

Detta fel indikerar att det inte gick att hitta en matchande post från `/virtualhost`-avsnittet från alla servergruppsfiler som är tillgängliga i `/etc/httpd/conf.dispatcher.d/enabled_farms/`.

Servergruppsfilerna matchar trafik baserat på det domännamn eller den sökväg som förfrågan kom in med. Den använder matchning av glob, och om den inte matchar så har du antingen inte konfigurerat din servergrupp korrekt, skrivit in posten i servergruppen eller låtit posten saknas helt. När servergruppen inte matchar några poster används den till slut som standard för den senaste servergruppen som ingår i gruppen med servergruppsfiler. I det här exemplet var det `999_ams_publish_farm.any` som har fått det generiska namnet för publiceringsservergruppen.

Här är ett exempel på servergruppsfilen `/etc/httpd/conf.dispatcher.d/enabled_farms/300_weretail_publish_farm.any` som har reducerats för att markera de relevanta delarna.

## Objekt som har betjänats från

Exempel på loggpost:

```
Tue Nov 26 16:41:34 2019 I pid 9208 (tid 140112092391168) "GET /content/we-retail/us/en.html" - + 24034ms publishfarm/0
```

Sidan hämtades via GET http-metod för innehållet `/content/we-retail/us/en.html` och tog 24034 millisekunder. Den del vi ville uppmärksamma finns i den sista `publishfarm/0`. Du kommer att se att det riktade och matchade `publishfarm`. Begäran hämtades från rendering 0. Det innebär att den här sidan måste hämtas från AEM och sedan cachas. Nu ska vi begära den här sidan igen och se vad som händer med loggen.

[Nästa -> Skrivskyddade filer](./immutable-files.md)
