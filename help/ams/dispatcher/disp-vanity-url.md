---
title: AEM Dispatcher vanity URLs feature
description: Lär dig hur AEM hanterar vanity-URL:er och andra tekniker med hjälp av omskrivningsregler för att mappa innehåll närmare leveransgränsen.
version: 6.5
topic: Administration, Performance
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
doc-type: Article
exl-id: 53baef9c-aa4e-4f18-ab30-ef9f4f5513ee
duration: 267
source-git-commit: 0deeaac90e9d181a60b407e17087650e0be1ff28
workflow-type: tm+mt
source-wordcount: '1160'
ht-degree: 0%

---

# Dispatcher Vanity-URL:er

[Innehållsförteckning](./overview.md)

[&lt;- Föregående: Skickartömning](./disp-flushing.md)

## Ökning

Det här dokumentet hjälper dig att förstå hur AEM hanterar vanlighetsadresser och vissa andra tekniker med hjälp av omskrivningsregler för att mappa innehåll närmare leveranskanterna

## Vad är Vanity-URL:er?

När du har innehåll som finns i en mappstruktur som är vettig finns det inte alltid i en URL som är enkel att referera till. Vanity-URL:er fungerar som genvägar. Kortare eller unika URL:er som refererar till det verkliga innehållet.

Ett exempel: `/aboutus` spetsig `/content/we-retail/us/en/about-us.html`

AEM författare har ett alternativ för att ange egenskaper för målarens URL för ett visst innehåll i AEM och publicera det.

För att den här funktionen ska fungera måste du justera Dispatcher-filtren så att de klarar av det. Det här är orimligt när du justerar Dispatcher-konfigurationsfilerna i den takt som författare måste konfigurera dessa poster för vanlighetssidan.

Därför har modulen Dispatcher en funktion för att automatiskt tillåta allt som listas som en avvikelse i innehållsträdet.


## Så här fungerar det

### URL för redigering av Vanity

Författaren besöker en sida i AEM, klickar på sidegenskaperna och lägger till poster i _Vanity URL_ -avsnitt. När du sparar ändringarna och aktiverar sidan tilldelas sidans huvudnamn till sidan.

Författare kan också välja _URL för omdirigering av vanity_ kryssruta när du lägger till _Vanity URL_ poster, detta gör att oskärpa-URL:er beter sig som 302 omdirigeringar. Det innebär att du blir tillsagd att gå till den nya webbadressen (via `Location` svarshuvud) och webbläsaren skickar en ny begäran till den nya URL:en.

#### Pekgränssnitt:

![Nedrullningsbar dialogrutemeny för AEM skapa användargränssnittet på webbplatsredigerarens skärm](assets/disp-vanity-url/aem-page-properties-drop-down.png "aem-page-properties-drop-down")

![Dialogrutan Egenskaper för aem-sida](assets/disp-vanity-url/aem-page-properties.png "aem-page-properties")

#### Classic Content Finder:

![AEM siteadmin classic ui sidekick page properties](assets/disp-vanity-url/aem-page-properties-sidekick.png "aem-page-properties-sidespark")

![Dialogrutan Egenskaper för klassisk användargränssnittssida](assets/disp-vanity-url/aem-page-properties-classic.png "aem-page-properties-classic")


>[!NOTE]
>
>Förstå att det här ofta är ett namn på utrymmesproblem. Vanity-tävlingsbidragen är globala till alla sidor. Det här är bara ett av de korta brister du måste planera för tillfälliga lösningar. Vi kommer att förklara några av dem senare.


## Resurslösningar/mappning

Alla poster i vanity är sling map-post för en intern omdirigering.

Kartorna visas på konsolen AEM förekomsterna Felix ( `/system/console/jcrresolver` )

Här är en skärmbild av ett kartinlägg som skapats av ett värde för vanity:
![skärmbild av en huvudpost i resursmatchningsreglerna](assets/disp-vanity-url/vanity-resource-resolver-entry.png "vanity-resource-resolver-entry")

I ovanstående exempel när vi ber AEM instansen att besöka `/aboutus` den matchar `/content/we-retail/us/en/about-us.html`

## Filter som automatiskt tillåter sändning

Dispatcher i ett säkert läge filtrerar bort begäranden på sökvägen `/` genom Dispatcher eftersom det är roten till JCR-trädet.

Det är viktigt att se till att utgivare bara tillåter innehåll från `/content` och andra säkra banor och så vidare, och inte banor som `/system`.

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

The `/delay` parametern, mätt i sekunder, fungerar inte med ett fast intervall utan i stället med en villkorsbaserad kontroll. Dispatcher utvärderar ändringstidsstämpeln för `/file` (som lagrar listan över kända URL:er för immunitet) när en begäran om en URL som inte finns med tas emot. The `/file` kommer inte att uppdateras om tidsskillnaden mellan den aktuella tidpunkten och `/file`Den senaste ändringen är mindre än `/delay` varaktighet. Uppdaterar `/file` inträffar under två förhållanden:

1. Den inkommande begäran är för en URL som inte är cachelagrad eller listad i `/file`.
1. Minst `/delay` sekunder har gått sedan `/file` uppdaterades senast.

Den här mekanismen är utformad för att skydda mot DoS-attacker (Denial of Service) som annars skulle kunna överbelasta Dispatcher med förfrågningar och utnyttja Vanity URL:er.

I enklare termer är `/file` som innehåller mål-URL:er uppdateras bara om en begäran kommer fram för en URL som inte redan finns i `/file` och om `/file`Den senaste ändringen var längre än den `/delay` punkt.

Så här utlöser du en uppdatering av `/file`kan du begära en URL som inte finns efter att du har säkerställt att det obligatoriska `/delay` tiden har gått sedan den senaste uppdateringen. Exempel-URL:er för detta ändamål är:

- `https://dispatcher-host-name.com/this-vanity-url-does-not-exist`
- `https://dispatcher-host-name.com/please-hand-me-that-planet-maestro`
- `https://dispatcher-host-name.com/random-vanity-url`

På det här sättet måste Dispatcher uppdatera `/file`, förutsatt att det angivna `/delay` intervallet har gått sedan den senaste ändringen.

Cacheminnet för svaret lagras i `/file` argument så i det här exemplet `/tmp/vanity_urls`

Så om du besöker den AEM instansen på URI:n ser du vad den hämtar:

![skärmbild av innehållet som återges från /libs/granite/dispatcher/content/vanityUrls.html](assets/disp-vanity-url/vanity-url-component.png "vanity-url-component")

Det är bokstavligen en lista, superenkel

## Skriv om regler som vanlighetsregler

Varför skulle vi använda omskrivningsregler istället för standardmekanismen som är inbyggd i AEM som beskrivs ovan?

Förklara enkelt namnutrymmesproblem, prestanda och logik på högre nivå som kan hanteras bättre.

Låt oss gå igenom ett exempel på vanity-posten `/aboutus` till innehållet `/content/we-retail/us/en/about-us.html` med Apache `mod_rewrite` för att uppnå detta.

```
RewriteRule ^/aboutus /content/we-retail/us/en/about-us.html [PT,L,NC]
```

Den här regeln letar efter vanheten `/aboutus` och hämta den fullständiga sökvägen från renderaren med PT-flaggan (Pass Through).

Den slutar också att bearbeta alla andra regler L-flaggan (sista), vilket innebär att den inte behöver gå igenom en stor lista med regler som JCR Resolving måste göra.

Förutom att du inte behöver göra någon proxy för begäran, och vänta på att den AEM utgivaren ska svara på dessa två element i den här metoden, gör den mycket bättre.

Sedan är ikonen här NC-flaggan (No Case-Sensitive), vilket innebär att en kund skriver URI med `/AboutUs` i stället för `/aboutus` den fungerar fortfarande.

Om du vill skapa en omskrivningsregel för att göra detta skapar du en konfigurationsfil på Dispatcher (exempel: `/etc/httpd/conf.d/rewrites/examplevanity_rewrite.rules`) och inkludera den i `.vhost` -fil som hanterar domänen som behöver dessa vanity-URL:er för att kunna användas.

Här är ett exempel på ett kodfragment som innehåller `/etc/httpd/conf.d/enabled_vhosts/we-retail.vhost`

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
- Nära gränsen mellan förfrågningar om slutanvändarinnehåll
- Mer utbyggbarhet och alternativ för att styra hur innehåll mappas under andra förhållanden
- Kan vara skiftlägeskänsligt

Använd båda metoderna, men här följer råd och kriterier som ska användas när:

- Om huvudrollen är tillfällig och har låg planerad trafik ska du använda den AEM inbyggda funktionen
- Om vanligheten är en häftklammerslutpunkt som inte ändras ofta och ofta används, ska du använda en `mod_rewrite` regel.
- Om namnutrymmet vanity (till exempel: `/aboutus`) måste återanvändas för många varumärken i samma AEM och sedan använda omskrivningsregler.

<div style="color: #000;border-left: 6px solid #2196F3;background-color:#ddffff;"><b>Obs!</b>

Om du vill använda AEM-funktionen och undvika namnutrymme kan du göra en namnkonvention. Använda vanity-URL:er som är kapslade som `/brand1/aboutus`, `brand2/aboutus`, `brand3/aboutus`.
</div>

[Nästa -> Vanlig loggning](./common-logs.md)
