---
title: AEM Dispatcher-URL:er
description: Lär dig hur AEM hanterar vanity-URL:er och andra tekniker med hjälp av omskrivningsregler för att mappa innehåll närmare leveransgränsen.
version: 6.5
topic: Administration, Performance
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
source-git-commit: 04cd4002af7028ee9e3b1e1455b6346c56446245
workflow-type: tm+mt
source-wordcount: '994'
ht-degree: 0%

---


# Dispatcher Vanity-URL:er

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Dispatcher-tömning](./disp-flushing.md)

## Översikt

Det här dokumentet hjälper dig att förstå hur AEM hanterar vanlighets-URL:er och vissa andra tekniker som använder omskrivningsregler för att mappa innehåll närmare leveranskanten

## Vad är Vanity-URL:er?

När du har innehåll som finns i en mappstruktur som är vettig finns det inte alltid i en URL som är enkel att referera till.  Vanity-URL:er fungerar som genvägar.  Kortare eller unika URL:er som refererar till det verkliga innehållet.

Ett exempel: `/aboutus` spetsig `/content/we-retail/us/en/about-us.html`

AEM-författare kan ange egenskaper för målarens URL för ett visst innehåll i AEM och publicera det.

För att den här funktionen ska fungera måste du justera Dispatcher-filtren så att de klarar av det.  Detta är orimligt om du justerar Dispatcher-konfigurationsfilerna med den hastighet som författare måste konfigurera dessa poster på huvudsidan.

Därför har modulen Dispatcher en funktion som automatiskt tillåter allt som listas som en avvikelse i innehållsträdet.


## Så här fungerar det

### URL för redigering av Vanity

Författaren besöker en sida i AEM och besöker sidegenskaperna och tilläggets poster i delen med huvudadressen.

När de har sparat sina ändringar och aktiverat sidan tilldelas den här sidan huvudrollen.

#### Pekgränssnitt:

![Nedrullningsbar dialogrutemeny för AEM skapa användargränssnittet på webbplatsredigerarens skärm](assets/disp-vanity-url/aem-page-properties-drop-down.png "aem-page-properties-drop-down")

![Dialogrutan Egenskaper för aem-sida](assets/disp-vanity-url/aem-page-properties.png "aem-page-properties")

#### Classic Content Finder:

![AEM siteadmin classic ui sidekick page properties](assets/disp-vanity-url/aem-page-properties-sidekick.png "aem-page-properties-sidespark")

![Dialogrutan Egenskaper för klassisk användargränssnittssida](assets/disp-vanity-url/aem-page-properties-classic.png "aem-page-properties-classic")

<div style="color: #000;border-left: 6px solid #2196F3;background-color:#ddffff;"><b>Obs!</b>
Det är en stor risk att kalla utrymmesproblem.

Vanity-tävlingsbidragen är globala till alla sidor. Det här är bara ett av de korta brister du måste planera för tillfälliga lösningar. Vi kommer att förklara några av dem senare.
</div>

## Resurslösningar/mappning

Alla poster i vanity är sling map-post för en intern omdirigering.

Kartorna visas på konsolen AEM förekomsterna Felix ( `/system/console/jcrresolver` )

Här är en skärmbild av en kartpost som har skapats av en vanity-post:
![skärmbild av en huvudpost i resursmatchningsreglerna](assets/disp-vanity-url/vanity-resource-resolver-entry.png "vanity-resource-resolver-entry")

I ovanstående exempel när vi ber AEM instansen att besöka `/aboutus` kommer det att leda till `/content/we-retail/us/en/about-us.html`

## Filter som automatiskt tillåter sändning

Dispatcher i ett säkert läge filtrerar bort begäranden på sökvägen `/` genom Dispatcher eftersom det är roten till JCR-trädet.

Det är viktigt att se till att utgivare bara tillåter innehåll från `/content` och andra säkra banor etc.  och inte banor som `/system` osv.

Här är en rub-URL som finns i basmappen för `/` så hur kan vi låta dem nå ut till utgivarna samtidigt som de förblir säkra?

Simple Dispatcher har en autofilterfunktion och du måste installera ett AEM och sedan konfigurera Dispatcher så att den pekar på den paketsidan.

[https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html?package=/content/software-distribution/en/details.html/content/dam/aem/public/adobe/packages/granite/vanityurls-components](https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html?package=/content/software-distribution/en/details.html/content/dam/aem/public/adobe/packages/granite/vanityurls-components)

Dispatcher har ett konfigurationsavsnitt i sin servergruppsfil:

```
/vanity_urls { 
    /url    "/libs/granite/dispatcher/content/vanityUrls.html" 
    /file   "/tmp/vanity_urls" 
    /delay  300 
}
```

Den här konfigurationen anger för Dispatcher att hämta den här URL:en från dess AEM instans som skickas var 300:e sekund för att hämta listan över objekt som vi vill tillåta igenom.

Den lagrar cache-minnet för svaret i `/file` argument så i det här exemplet `/tmp/vanity_urls`

Så om du besöker den AEM instansen på URI:n ser du vad den hämtar:
![skärmbild av innehållet som återges från /libs/granite/dispatcher/content/vanityUrls.html](assets/disp-vanity-url/vanity-url-component.png "vanity-url-component")

Det är bokstavligen en lista, superenkel

## Skriv om regler som vanlighetsregler

Varför skulle vi nämna att använda omskrivningsregler i stället för standardmekanismen som är inbyggd i AEM som beskrivs ovan?

Förklara enkelt namnutrymmesproblem, prestanda och logik på högre nivå som kan hanteras bättre.

Låt oss gå igenom ett exempel på vanity-posten `/aboutus` till innehållet `/content/we-retail/us/en/about-us.html` med Apache `mod_rewrite` för att uppnå detta.

```
RewriteRule ^/aboutus /content/we-retail/us/en/about-us.html [PT,L,NC]
```

Den här regeln kommer att leta efter fåfängligheten `/aboutus` och hämta den fullständiga sökvägen från renderaren med PT-flaggan (Pass Through).

Den kommer också att sluta bearbeta alla andra regler L-flaggan (sista), vilket innebär att den inte behöver gå igenom en stor lista med regler som JCR Resolving måste göra.

Förutom att du inte behöver göra en proxy för begäran och vänta på att den AEM utgivaren ska svara på de här två elementen i den här metoden gör det mycket mer prestandaförbättrande.

Sedan är ikonen här NC-flaggan (ingen skiftlägeskänslig), vilket innebär att en kund flubar URI:n med `/AboutUs` i stället för `/aboutus` kommer det fortfarande att fungera och rätt sida kan hämtas.

Om du vill skapa en omskrivningsregel för att göra detta skapar du en konfigurationsfil på Dispatcher (exempel: `/etc/httpd/conf.d/rewrites/examplevanity_rewrite.rules`) och inkludera den i `.vhost` -fil som hanterar domänen som behöver dessa vanity-URL:er för att kunna användas.

Här är ett exempel på ett kodfragment för SSI `/etc/httpd/conf.d/enabled_vhosts/we-retail.vhost`

```
<VirtualHost *:80> 
 ServerName weretail.com 
 ServerAlias www.weretail.com 
        ........ SNIP ........ 
 <IfModule mod_rewrite.c> 
  ReWriteEngine on 
  LogLevel warn rewrite:info 
  Include /etc/httpd/conf.d/rewrites/examplevanity_rewrite.rules 
 </IfModule> 
        ........ SNIP ........ 
</VirtualHost>
```

## Vilken metod och var

Att använda AEM för att kontrollera poster i vanity har följande fördelar
- Författare kan skapa dem direkt
- De lever med innehållet och kan paketeras ihop med innehållet

Använda `mod_rewrite` för att kontrollera poster i vanity har följande fördelar
- Snabbare lösning av innehåll
- Nära i kanten av begäran om slutanvändarinnehåll
- Mer utbyggbarhet och alternativ för att styra hur innehåll mappas under andra förhållanden
- Kan vara skiftlägesokänslig

Använd båda metoderna, men här följer råd och kriterier som ska användas när:
- Om vanligheten är tillfällig och har låg planerad trafik ska du använda den inbyggda AEM
- Om vanligheten är en häftklammerslutpunkt som inte ändras ofta och ofta används, ska du använda en `mod_rewrite` regel.
- Om namnutrymmet vanity (till exempel: `/aboutus`) måste återanvändas för många varumärken i samma AEM och sedan använda omskrivningsregler.

<div style="color: #000;border-left: 6px solid #2196F3;background-color:#ddffff;"><b>Obs!</b>

Om du vill använda AEM-funktionen och undvika namnutrymme kan du göra en namnkonvention.  Använda vanity-URL:er som är kapslade som `/brand1/aboutus`, `brand2/aboutus`, `brand3/aboutus`.
</div>

[Nästa -> Vanlig loggning](./common-logs.md)