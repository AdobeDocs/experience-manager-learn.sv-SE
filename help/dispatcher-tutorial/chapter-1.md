---
title: "Kapitel 1 - Dispatcher Concepts, Patterns and Antipatterns"
description: I det här kapitlet ges en kort introduktion om Dispatcher-historiken och -mekanismerna, och vi diskuterar hur detta påverkar hur en AEM utvecklare designar sina komponenter.
feature: Dispatcher
topic: Architecture
role: Architect
level: Beginner
exl-id: 3bdb6e36-4174-44b5-ba05-efbc870c3520
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '17460'
ht-degree: 0%

---

# Kapitel 1 - Dispatcher Concepts, Patterns and Antipatterns

## Översikt

I det här kapitlet ges en kort introduktion om Dispatcher-historiken och -mekanismerna, och vi diskuterar hur detta påverkar hur en AEM utvecklare designar sina komponenter.

## Varför utvecklare ska bry sig om infrastruktur

Dispatcher är en viktig del av de flesta - om inte alla AEM installationer. Det finns många artiklar online som handlar om hur du konfigurerar Dispatcher samt tips och tricks.

Dessa bitar och delar av information börjar dock alltid på en mycket teknisk nivå - förutsatt att du redan vet vad du vill göra och därmed bara ger information om hur du ska uppnå det du vill ha. Vi har aldrig hittat några konceptuella rapporter som beskriver _vad och varför_ när det gäller vad du kan och inte kan göra med dispatchern.

### Mönster: Skicka som en eftertanke

Denna brist på grundläggande information leder till ett antal antimönster som vi har sett i ett antal AEM projekt:

1. När Dispatcher installeras på Apache-webbservern är det jobbet för &quot;Unix-gudarna&quot; i projektet som konfigurerar det. En&quot;dödlig java-utvecklare&quot; behöver inte bekymra sig om den.

2. Java-utvecklaren måste se till att koden fungerar.. så kommer dispatchern att göra det snabbt. Avsändaren är alltid en eftertanke. Detta fungerar dock inte. Utvecklaren måste utforma koden med avsändaren i åtanke. Och han behöver veta de grundläggande begreppen för att göra det.

### &quot;Först får det att fungera - sedan snabbt&quot; är inte alltid rätt

Du kanske har hört programmeringsråden _&quot;Låt det först fungera - och sedan snabbt.&quot;_. Det är inte helt fel. Utan rätt sammanhang brukar det emellertid feltolkas och inte tillämpas korrekt.

De bör hindra utvecklaren från att i förtid optimera kod, som kanske aldrig kommer att köras - eller så sällan körs, att en optimering inte skulle ha tillräcklig effekt för att motivera den insats som gjorts för optimeringen. Optimering kan dessutom leda till mer komplex kod och därmed medföra fel. Om du är utvecklare ska du alltså inte lägga alltför mycket tid på att mikrooptimera varje kodrad. Se bara till att du väljer rätt datastruktur, algoritmer och bibliotek och vänta på en profilerares hotspot-analys för att se var en mer detaljerad optimering kan öka den totala prestandan.

### Arkitektbeslut och artefakter

Men råden&quot;Först får det att fungera - sedan snabbt&quot; är helt fel när det gäller&quot;arkitektoniska&quot; beslut. Vad är arkitektoniska beslut? Det vill säga: det är de beslut som är dyra, svåra och/eller omöjliga att ändra i efterhand. Tänk på att&quot;dyr&quot; ibland är detsamma som&quot;omöjligt&quot;.  När budgeten håller på att ta slut är det till exempel omöjligt att genomföra kostsamma ändringar. De största förändringarna inom infrastrukturen är förändringar inom denna kategori som de flesta kommer att tänka på. Men det finns också en annan typ av &quot;arkitektoniska&quot; artefakter som kan bli mycket otrevliga att förändra:

1. Koddelar i ett programs&quot;mitt&quot;, som många andra delar är beroende av. Om du ändrar dessa måste alla beroenden ändras och testas på nytt samtidigt.

2. Artefakter, som ingår i vissa asynkrona, tidsberoende scenarier där indata - och därmed systemets beteende - kan variera mycket slumpmässigt. Ändringar kan ha oförutsägbara effekter och kan vara svåra att testa.

3. Mönster som används och återanvänds om och om igen, i alla delar av systemet. Om programmönstret visar sig vara suboptimalt måste alla artefakter som använder mönstret kodas om.

Kommer du ihåg? Ovanför den här sidan sade vi att Dispatcher är en viktig del i ett AEM. Åtkomsten till ett webbprogram är mycket slumpmässig - användarna kommer och kommer vid en oförutsägbar tidpunkt. Till sist kommer allt innehåll att (eller ska) cachas i Dispatcher. Om du har uppmärksammat detta kan du ha insett att cachning kan ses som en&quot;arkitektur&quot;-artefakt och därför bör förstås av alla teammedlemmar, utvecklare och administratörer.

Vi säger inte att en utvecklare ska konfigurera Dispatcher. De måste känna till koncepten - särskilt gränserna - för att se till att deras kod också kan utnyttjas av Dispatcher.

Dispatcher förbättrar inte kodens hastighet på ett magiskt sätt. En utvecklare måste skapa sina komponenter med Dispatcher i åtanke. Därför måste han veta hur det fungerar.

## Cachelagring av avsändare - grundläggande principer

### Skickas som cachelagringshttp - belastningsutjämnare

Vad är Dispatcher och varför heter den &quot;Dispatcher&quot; från början?

Dispatcher är

* Först och främst en cache

* En omvänd proxy

* En modul för Apache httpd-webbservern, som lägger till AEM funktioner till Apache-filens mångsidighet och smidigt fungerar tillsammans med alla andra Apache-moduler (som SSL eller SSI-inkluderingar som vi kommer att se senare)

I webbens tidiga dagar förväntar du dig ett par hundra besökare på en webbplats. En installation av en Dispatcher, som&quot;skickas&quot; eller balanserar antalet förfrågningar till ett antal AEM publiceringsservrar och som vanligtvis var tillräckligt - dvs. namnet&quot;Dispatcher&quot;. I dag används dock inte den här inställningen särskilt mycket längre.

Vi kommer att se olika sätt att konfigurera Dispatcher och Publish-system senare i den här artikeln. Först börjar vi med lite http-cachning-grunder.

![Grundläggande funktioner i en Dispatcher Cache](assets/chapter-1/basic-functionality-dispatcher.png)

*Grundläggande funktioner i en Dispatcher Cache*

<br> 

Här förklaras grunderna i dispatchern. Dispatchern är en enkel cachelagring av omvänd proxy med möjlighet att ta emot och skapa HTTP-begäranden. En normal process för begäran/svar ser ut så här:

1. En användare begär en sida
2. Dispatcher kontrollerar om den redan har en återgiven version av sidan. Vi antar att det är den allra första begäran för den här sidan och att Dispatcher inte kan hitta en lokal cachelagrad kopia.
3. Dispatcher begär sidan från publiceringssystemet
4. På publiceringssystemet återges sidan med en JSP- eller HTML-mall
5. Sidan skickas tillbaka till Dispatcher
6. Dispatcher cache-lagrar sidan
7. Dispatcher returnerar sidan till webbläsaren
8. Om samma sida begärs en andra gång kan den hanteras direkt från Dispatcher-cachen utan att den behöver återges på nytt i Publish-instansen. Detta sparar väntetid för användar- och processorcyklerna på Publish-instansen.

Vi pratade om &quot;sidor&quot; i sista delen. Men samma schema gäller även andra resurser som bilder, CSS-filer, PDF-nedladdningar och så vidare.

#### Hur data cachelagras

Dispatcher-modulen utnyttjar de funktioner som finns på Apache-värdservern. Resurser som HTML-sidor, nedladdningar och bilder lagras som enkla filer i Apache-filsystemet. Så enkelt är det.

Filnamnet härleds av URL:en för den begärda resursen. Om du begär en fil `/foo/bar.html` den lagras t.ex. under /`var/cache/docroot/foo/bar.html`.

Om alla filer cachelagras och därmed lagras statiskt i Dispatcher, kan du i princip dra i Publish-systemets plugin och Dispatcher fungerar som en enkel webbserver. Men detta är bara för att illustrera principen. Det verkliga livet är mer komplicerat. Du kan inte cachelagra allt och cachen är aldrig helt&quot;full&quot; eftersom antalet resurser kan vara oändligt på grund av återgivningsprocessens dynamiska karaktär. Modellen för ett statiskt filsystem hjälper till att generera en helhetsbild av avsändarens funktioner. Och det hjälper till att förklara begränsningarna med dispatchern.

#### AEM URL-struktur och filsystemsmappning

Om du vill veta mer om Dispatcher kan du gå igenom strukturen för en enkel exempel-URL.  Låt oss titta på exemplet nedan,

`http://domain.com/path/to/resource/pagename.selectors.html/path/suffix.ext?parameter=value&amp;otherparameter=value#fragment`

* `http` anger protokollet

* `domain.com` är domännamnet

* `path/to/resource` är sökvägen som resursen lagras i CRX och därefter i Apache-serverns filsystem

Härifrån skiljer det sig lite åt mellan AEM och Apache-filsystemet.

AEM

* `pagename` är resursetiketten

* `selectors` står för ett antal väljare som används i Sling för att bestämma hur resursen ska återges. En URL kan ha ett godtyckligt antal väljare. De avgränsas av en punkt. En väljarsektion kan till exempel vara &quot;french.mobile.dit&quot;. Väljarna får endast innehålla bokstäver, siffror och bindestreck.

* `html` som den sista av väljarna kallas ett tillägg. I AEM/Sling avgör det också delvis återgivningsskriptet.

* `path/suffix.ext` är ett sökvägsliknande uttryck som kan vara ett suffix till URL:en.  Den kan användas i AEM skript för att ytterligare styra hur en resurs återges. Vi ska ha en hel sektion om den här delen senare. För tillfället bör det räcka att veta att du kan använda den som en extra parameter. Suffix måste ha ett tillägg.

* `?parameter=value&otherparameter=value` är frågeavsnittet i URL:en. Den används för att skicka godtyckliga parametrar till AEM. URL:er med parametrar kan inte cachelagras och parametrar bör därför begränsas till fall där de är absolut nödvändiga.

* `#fragment`, ska fragmentdelen av en URL inte skickas till AEM den bara används i webbläsaren, i JavaScript-ramverk som&quot;routningsparametrar&quot; eller för att hoppa till en viss del på sidan.

I Apache (*referera till nedanstående diagram*),

* `pagename.selectors.html` används som filnamn i cachens filsystem.

Om URL:en har ett suffix `path/suffix.ext` sedan

* `pagename.selectors.html` skapas som en mapp

* `path` en mapp i `pagename.selectors.html` mapp

* `suffix.ext` är en fil i `path` mapp. Obs! Om suffixet inte har något tillägg cachelagras inte filen.

![Filsystemlayout efter hämtning av URL:er från Dispatcher](assets/chapter-1/filesystem-layout-urls-from-dispatcher.png)

*Filsystemlayout efter hämtning av URL:er från Dispatcher*

<br> 

#### Grundläggande begränsningar

Mappningen mellan en URL-adress, resursen och filnamnet är ganska enkel.

Du kan dock ha lagt märke till några svällningar

1. URL-adresser kan bli mycket långa. Lägga till delen &quot;bana&quot; i en `/docroot` på det lokala filsystemet kan enkelt överskrida gränserna för vissa filsystem. Det kan vara svårt att köra Dispatcher i NTFS i Windows. Men du är säker med Linux.

2. URL:er kan innehålla specialtecken och omljud. Detta är vanligtvis inget problem för dispatchern. Tänk dock på att URL-adressen tolkas på många ställen i programmet. Oftast har vi sett konstiga beteenden i ett program - bara för att ta reda på att en del sällan använd (anpassad) kod inte har testats noggrant för specialtecken. Du borde undvika dem om du kan. Och om du inte kan, planera för grundliga tester.

3. I CRX har resurser underresurser. En sida har t.ex. ett antal underordnade sidor. Detta kan inte matchas i ett filsystem eftersom filsystem har antingen filer eller mappar.

#### URL:er utan tillägg cachelagras inte

URL-adresser måste alltid ha ett tillägg. Även om du kan hantera URL:er utan tillägg i AEM. Dessa URL:er cachelagras inte i Dispatcher.

**Exempel**

`http://domain.com/home.html` är **cacheable**

`http://domain.com/home` är **inte cachelagrad**

Samma regel gäller när URL:en innehåller ett suffix. Suffixet måste ha ett tillägg för att kunna cachelagras.

**Exempel**

`http://domain.com/home.html/path/suffix.html` är **cacheable**

`http://domain.com/home.html/path/suffix` är **inte cachelagrad**

Du kanske undrar vad som händer om resursdelen inte har något tillägg, men suffixet har ett? I det här fallet har URL-adressen inget suffix alls. Titta på nästa exempel:

**Exempel**

`http://domain.com/home/path/suffix.ext`

The `/home/path/suffix` är sökvägen till resursen.. så det finns inget suffix i URL:en.

**Slutsats**

Lägg alltid till tillägg till både sökvägen och suffixet. SEO-medvetna personer hävdar ibland att detta rankar dig i sökresultaten. Men en sida som inte är cachelagrad skulle bli mycket långsam och rankas ännu längre.

#### Suffix-URL i konflikt

Du kan ha två giltiga URL:er

`http://domain.com/home.html`

och

`http://domain.com/home.html/suffix.html`

De är helt giltiga i AEM. Du skulle inte se några problem på din lokala utvecklingsdator (utan en Dispatcher). Troligen kommer du inte heller att få några problem med UAT- eller inläsningstestning. Det problem vi står inför är så subtilt att det glider igenom de flesta tester.  Den kommer att drabba dig hårt när du är i toppläge och du har begränsad tid att ta itu med den, troligen inte har någon serveråtkomst eller resurser att åtgärda den. Vi har varit där..

Så.. vad är problemet?

`home.html` i ett filsystem kan vara en fil eller en mapp. Inte båda samtidigt som i AEM.

Om du begär `home.html` först skapas den som en fil.

Efterföljande begäranden till `home.html/suffix.html` returnera giltiga resultat, men som fil `home.html` &quot;blockerar&quot; positionen i filsystemet,  `home.html` kan inte skapas en andra gång som en mapp och därmed `home.html/suffix.html` är inte cachelagrad.

![Filblockeringspositionen i filsystemet förhindrar att underresurser cachas](assets/chapter-1/file-blocking-position-in-filesystem.png)

*Filblockeringspositionen i filsystemet förhindrar att underresurser cachas*

<br> 

Om du gör det tvärtom, begär du först `home.html/suffix.html` sedan `suffix.html` cachelagras under en mapp `/home.html` först. Den här mappen tas dock bort och ersätts av en fil `home.html` när du efterfrågar `home.html` som en resurs.

![Ta bort en sökvägsstruktur när en överordnad hämtas som en resurs](assets/chapter-1/deleting-path-structure.png)

*Ta bort en sökvägsstruktur när en överordnad hämtas som en resurs*

<br> 

Resultatet av det som cachelagras är alltså helt slumpmässigt och beroende på ordningen för inkommande begäranden. Det som gör det ännu svårare är det faktum att du vanligtvis har mer än en dispatcher. Och prestanda, cache-träfffrekvens och -beteende kan variera från en Dispatcher till en annan. Om du vill ta reda på varför din webbplats inte svarar måste du se till att du tittar på rätt Dispatcher med den felaktiga cachningsordningen. Om du tittar på Dispatcher som - av tur - hade ett mer fördelaktigt begärandemönster, kommer du att gå vilse när du försöker hitta problemet.

#### Undvika URL-konflikter

Du kan undvika&quot;URL-konflikter&quot;, där ett mappnamn och ett filnamn&quot;konkurrerar&quot; om samma sökväg i filsystemet, när du använder ett annat tillägg för resursen när du har ett suffix.

**Exempel**

* `http://domain.com/home.html`

* `http://domain.com/home.dir/suffix.html`

Båda är helt lättåtkomliga.

![](assets/chapter-1/cacheable.png)

Välj en dedikerad dir för ett tillägg för en resurs när du begär ett suffix eller så undviker du att använda suffixet helt och hållet. Det finns sällsynta fall där de är användbara. Och det är enkelt att implementera dessa fall korrekt.  Som vi kommer att se i nästa kapitel när vi talar om cache-ogiltigförklaring och tömning.

#### Otillgängliga begäranden

Låt oss titta på en kort sammanfattning av det sista kapitlet plus några andra undantag. Dispatcher kan cachelagra en URL om den är konfigurerad som cachelagrad och om det är en GET-begäran. Den kan inte cachas med något av följande undantag.

**Cacheable-begäranden**

* Begäran är konfigurerad att vara tillgänglig i Dispatcher-konfigurationen
* Begäran är en ren GET-begäran

**Icke-cachelagrade förfrågningar eller svar**

* Begäran som nekas cachelagring av konfiguration (sökväg, mönster, MIME-typ)
* Svar som returnerar &quot;Dispatcher: no-cache&quot; header
* Svar som returnerar en &quot;Cache-Control: no-cache|private&quot; header
* Svar som returnerar &quot;Pragma: no-cache&quot; header
* Begäran med frågeparametrar
* URL utan tillägg
* URL med ett suffix som inte har något tillägg
* Svar som returnerar en annan statuskod än 200
* Begäran om POST

## Invalidera och tömma cachen

### Översikt

I det sista kapitlet visas ett stort antal undantag när Dispatcher inte kan cachelagra en begäran. Men det finns fler saker att tänka på: Bara för att Dispatcher _kan_ cachelagra en begäran, det behöver inte innebära att den _bör_.

Poängen är: Cachelagring är vanligtvis lätt. Dispatcher behöver bara lagra resultatet av ett svar och returnera det nästa gång samma begäran kommer. Höger? Fel!

Den svåra delen är _ogiltigförklaring_ eller _rodnad_ av cacheminnet. Dispatcher måste ta reda på när en resurs har ändrats - och måste återges igen.

Det här verkar vara en enkel uppgift.. men det är det inte. Läs vidare så kommer du att få reda på några knepiga skillnader mellan enskilda och enkla resurser och sidor som är beroende av en struktur med flera olika resurser som har mycket gemensamt.

### Enkla resurser och tömning

Vi har konfigurerat vårt AEM för att dynamiskt skapa en miniatyrrendering för varje bild när det efterfrågas med en särskild&quot;tumväljare&quot;:

`/content/dam/path/to/image.thumb.png`

Och - naturligtvis - tillhandahåller vi en URL för att skicka originalbilden med en URL utan väljare:

`/content/dam/path/to/image.png`

Om vi laddar ned både miniatyrbilden och originalbilden får vi något som

```
/var/cache/dispatcher/docroot/content/dam/path/to/image.thumb.png

/var/cache/dispatcher/docroot/content/dam/path/to/image.png
```

i Dispatchers filsystem.

Nu laddar användaren upp och aktiverar en ny version av filen. I slutändan skickas en begäran om ogiltigförklaring från AEM till avsändaren.

```
GET /invalidate
invalidate-path:  /content/dam/path/to/image

<no body>
```

Så enkelt är det att verifiera: En enkel GET-begäran till en speciell &quot;/invalidate&quot;-URL i Dispatcher. HTTP-body krävs inte, nyttolasten är bara huvudet invalidate-path. Observera också att invalidate-path i huvudet är den resurs som AEM känner till - och inte den eller de filer som Dispatcher har cachelagrat. AEM känner bara till resurser. Tillägg, väljare och suffix används vid körning när en resurs begärs. AEM bokför inte vilka väljare som har använts på en resurs, så resurssökvägen är helt säker när en resurs aktiveras.

Det räcker i vårt fall. Om en resurs har ändrats kan vi anta att alla återgivningar av den resursen också har ändrats. Om bilden har ändrats återges även en ny miniatyrbild.

Dispatcher kan ta bort resursen med alla återgivningar som den har cachelagrat. Det kommer att göra något som

`$ rm /content/dam/path/to/image.*`

ta bort `image.png` och `image.thumb.png` och alla andra återgivningar som matchar mönstret.

Mycket enkelt ... så länge du bara använder en resurs för att besvara en förfrågan.

### Referenser och maskerat innehåll

#### Problem med det delade innehållet

Till skillnad från bilder eller andra binära filer som överförts till AEM är HTML sidor inte ett enda djur. De lever i flockar och de är i hög grad sammankopplade med varandra genom hyperlänkar och referenser. Den enkla länken är ofarlig, men den blir svår när vi talar om innehållsreferenser. Den vanliga toppnavigeringen eller tassarna på sidorna är innehållsreferenser.

#### Innehållsreferenser och varför de är ett problem

Låt oss titta på ett enkelt exempel. En resebyrå har en webbsida som marknadsför en resa till Kanada. Den här kampanjen visas i teaser-avsnittet på två andra sidor, på hemsidan och på sidan Vintern-special.

Eftersom båda sidorna har samma teaser är det onödigt att be författaren att skapa teaser flera gånger för varje sida som de ska visas på. Målsidan &quot;Canada&quot; reserverar i stället ett avsnitt i sidegenskaperna för att ge information för teaser - eller bättre för att ge en URL som återger så mycket teaser:

`<sling:include resource="/content/home/destinations/canada" addSelectors="teaser" />`

eller

`<sling:include resource="/content/home/destinations/canada/jcr:content/teaser" />`

![](assets/chapter-1/content-references.png)

AEM fungerar bara som charm, men om du använder en Dispatcher i Publish-instansen händer något konstigt.

Tänk dig att du har publicerat din webbplats. Titeln på din Kanadassida är &quot;Kanada&quot;. När en besökare begär din hemsida - som har en stegvis referens till den sidan - återges något som liknar det som komponenten på&quot;Kanadas&quot; sida

```
<div class="teaser">
  <h3>Canada</h3>
  <img …>
</div>
```

*till* hemsidan. Hemsidan lagras av Dispatcher som en statisk HTML-fil, inklusive teaser och filens rubrik.

Nu har marknadsföraren lärt sig att det ska gå att agera med teaserrubriker. Så han bestämmer sig för att ändra titeln från &quot;Kanada&quot; till &quot;Besök Kanada&quot; och uppdaterar även bilden.

Han publicerar den redigerade&quot;Canada&quot;-sidan och går igenom den tidigare publicerade hemsidan för att se ändringarna. Men inget förändrades där. Den visar fortfarande den gamla teaser. Han dubbelkollar &quot;Winter Special&quot;. Den sidan har aldrig begärts tidigare och är därför inte statiskt cachelagrad i Dispatcher. Den här sidan återges alltså nyligen av Publish och den här sidan innehåller nu det nya&quot;Besök Kanada&quot;-teaseret.

![Dispatcher som lagrar inaktuellt innehåll på startsidan](assets/chapter-1/dispatcher-storing-stale-content.png)

*Dispatcher som lagrar inaktuellt innehåll på startsidan*

<br> 

Vad hände? Dispatcher lagrar en statisk version av en sida som innehåller allt innehåll och all kod som har hämtats från andra resurser under återgivningen.

Dispatcher är en webbserver som bara är baserad på filsystem och är snabb men också ganska enkel. Om en inkluderad resurs ändras inser den inte det. Det håller fortfarande fast vid innehållet som fanns där när inkluderingssidan renderades.

Sidan&quot;Vinter special&quot; har inte renderats än, så det finns ingen statisk version på Dispatcher och den visas därför med det nya teaser som den renderas på begäran.

Du kanske tror att Dispatcher håller reda på alla resurser som den rör vid återgivningen och tömmer alla sidor som har använt den här resursen när resursen ändras. Men Dispatcher återger inte sidorna. Återgivningen utförs av publiceringssystemet. Dispatcher vet inte vilka resurser som går till en återgiven HTML-fil.

Fortfarande inte övertygad? Du kanske tror *&quot;det måste finnas ett sätt att implementera någon form av beroendespårning&quot;*. Det finns, eller mer exakt där *var*. Communiqué 3, AEM gammelfarfar, hade en beroendespårare implementerad i _session_ som användes för att återge en sida.

Under en begäran spårades varje resurs som hämtades via den här sessionen som ett beroende av den URL som för närvarande återges.

Men det visade sig att det var väldigt dyrt att hålla reda på beroendena. Folk upptäckte snart att webbplatsen är snabbare om de stängde av funktionen för beroendespårning helt och hållet och förlitade sig på att återge alla HTML-sidor efter att en HTML-sida ändrats. Dessutom var detta system inte heller perfekt - det fanns ett antal fallgropar och undantag på vägen. I vissa fall använde du inte standardsessionen för begäranden för att hämta en resurs, utan en administratörssession för att få hjälp med att återge en begäran. Dessa beroenden spårades vanligtvis inte och ledde till huvudvärk och telefonsamtal till teamet som bad om att manuellt tömma cachen. Du hade tur om de hade en standardprocedur för att göra det. Det fanns fler saker på vägen men.. vi slutar påminna. Detta leder tillbaka till 2005. I slutändan inaktiverades funktionen som standard i Communiqué 4, och den återgick inte till den efterföljare CQ5 som sedan blev AEM.

### Automatisk invalidering

#### När fullständig tömning är billigare än beroendespårning

Sedan CQ5 förlitar vi oss helt och hållet på att göra hela webbplatsen ogiltig, i stort sett om bara en av sidorna ändras. Den här funktionen kallas &quot;Automatisk invalidering&quot;.

Men än en gång - hur kan det vara så att det är billigare att kasta bort och återge hundratals sidor än att göra en riktig beroendespårning och partiell återgivning?

Det finns två viktiga orsaker:

1. På en vanlig webbplats efterfrågas bara en liten del av sidorna ofta. Även om du slänger allt återgivet innehåll efterfrågas bara ett fåtal dussin efteråt. Återgivningen av den långa sidslut kan distribueras över tiden när de faktiskt begärs. Det innebär att belastningen på återgivningssidor inte är så hög som du kan förvänta dig. Det finns förstås alltid undantag.. vi kommer att diskutera några trick som kan hantera lika distribuerade webbplatser på större webbplatser med tomma Dispatcher-cacher senare.

2. Alla sidor är ändå sammankopplade med huvudnavigeringen. Så nästan alla sidor är beroende av varandra. Detta innebär att även den smartaste beroendespåraren kommer att ta reda på vad vi redan vet: Om någon av sidorna ändras måste du göra alla andra ogiltiga.

Tror du inte? Låt oss illustrera den sista punkten.

Vi använder samma argument som i det senaste exemplet med teasers som refererar till en fjärrsidas innehåll. Bara nu använder vi ett mer extremt exempel: En automatiskt återgiven huvudnavigering. Precis som med teaser ritas navigeringsrubriken från den länkade sidan eller&quot;fjärrsidan&quot; som en innehållsreferens. Fjärrnavigeringsrubrikerna lagras inte på den återgivna sidan. Du bör komma ihåg att navigeringen återges på varje sida på webbplatsen. Rubriken på en sida används alltså om och om igen på alla sidor som har en huvudnavigering. Och om du vill ändra en navigeringstitel vill du bara göra det en gång på fjärrsidan, inte på varje sida som refererar till sidan.

I vårt exempel sammanfogar navigeringen alla sidor genom att använda målsidans&quot;NavTitle&quot; för att återge ett namn i navigeringen. Navigeringsrubriken för Island ritas från&quot;Island&quot;-sidan och återges på varje sida som har en huvudnavigering.

![Huvudnavigeringen sammanfogar alltid innehållet på alla sidor genom att dra i&quot;NavTitles&quot;](assets/chapter-1/nav-titles.png)

*Huvudnavigeringen sammanfogar alltid innehållet på alla sidor genom att dra i&quot;NavTitles&quot;*

<br> 

Om du ändrar NavTitle på Islands sida från &quot;Island&quot; till &quot;Beautiful Island&quot; ändras titeln omedelbart på alla andra sidors huvudmeny. De sidor som återges och cachelagras före ändringen blir alltså inaktuella och måste ogiltigförklaras.

#### Så här implementeras automatisk invalidering: .stat-filen

Om du har en stor webbplats med tusentals sidor tar det en hel stund att göra en slinga genom alla sidor och ta bort dem fysiskt. Under den perioden kan Dispatcher oavsiktligt leverera gammalt innehåll. Ännu värre är att vissa konflikter kan uppstå vid åtkomst av cachefilerna, en sida kanske efterfrågas medan den just tas bort eller en sida tas bort igen på grund av en andra ogiltigförklaring som inträffade efter en omedelbar efterföljande aktivering. Tänk på vilken röra det skulle vara. Som tur är är det inte så här. Dispatcher använder ett smart trick för att undvika det: I stället för att ta bort hundratals och tusentals filer placeras en enkel, tom fil i filsystemets rot när en fil publiceras, vilket innebär att alla beroende filer betraktas som ogiltiga. Den här filen kallas för&quot;statfile&quot;. Statusfilen är en tom fil - det viktiga med statusfilen är bara dess skapandedatum.

Alla filer i dispatchern som har ett datum som är äldre än statusfilen har återgetts före den senaste aktiveringen (och ogiltigförklaringen) och betraktas därför som&quot;ogiltiga&quot;. De finns fortfarande fysiskt i filsystemet, men Dispatcher ignorerar dem. De är&quot;föråldrade&quot;. När en begäran om en inaktuell resurs görs ber Dispatcher AEM systemet att återge sidan igen. Den nya återgivna sidan lagras sedan i filsystemet - nu med ett nytt skapandedatum och den är ny igen.

![Datum när .stat-filen skapades definierar vilket innehåll som är inaktuellt och som är färskt](assets/chapter-1/creation-date.png)

*Datum när .stat-filen skapades definierar vilket innehåll som är inaktuellt och som är färskt*

<br> 

Du kan fråga varför det heter &quot;.stat&quot;? Och inte kanske &quot;invalidated&quot;? Du kan tänka dig att om du har den filen i filsystemet kan Dispatcher avgöra vilka resurser som kan *statiskt* bli serverad - precis som på en statisk webbserver. Dessa filer behöver inte längre återges dynamiskt.

Namnets verkliga karaktär är dock mindre metaforisk. Det härleds från Unix-systemanropet `stat()`, som returnerar ändringstiden för en fil (bland annat egenskaper).

#### Mixa enkel och automatisk validering

Men vänta... tidigare sa vi att enstaka resurser tas bort fysiskt. Nu säger vi att en senare staty i princip skulle göra dem ogiltiga i Dispatcher:s ögon. Varför då den fysiska borttagningen först?

Svaret är enkelt. Du använder vanligtvis båda strategierna parallellt, men för olika typer av resurser. Binära resurser, som bilder, är fristående. De är inte kopplade till andra resurser på ett sätt som innebär att deras information måste återges.

HTML sidor å andra sidan är mycket beroende av varandra. Du skulle alltså tillämpa automatisk ogiltigförklaring på dessa. Det här är standardinställningen i Dispatcher. Alla filer som tillhör en ogiltig resurs tas bort fysiskt. Dessutom blir filer som slutar med &quot;.html&quot; automatiskt ogiltiga.

Dispatcher bestämmer om filtillägget ska tillämpas eller inte.

Filsluten för automatisk ogiltigförklaring kan konfigureras. I teorin kan du inkludera alla tillägg till automatisk ogiltigförklaring. Men tänk på att det här kommer till ett mycket högt pris. Du kommer inte att se föråldrade resurser levereras oavsiktligt, men leveransresultaten försämras avsevärt på grund av överogiltigförklaring.

Tänk dig till exempel att du implementerar ett schema där PNG och JPG återges dynamiskt och är beroende av andra resurser för att göra det. Du kanske vill skala om högupplösta bilder till en mindre webbkompatibel upplösning. När du är klar ändras också komprimeringsgraden. Upplösning och komprimeringsgrad i det här exemplet är inga fasta konstanter, men konfigurerbara parametrar i komponenten som använder bilden. Om den här parametern ändras måste du göra bilderna ogiltiga.

Inga problem - vi fick just veta att vi kunde lägga till bilder till automatisk ogiltigförklaring och alltid ha återgivna bilder när något ändras.

#### Kasta ut babyn med badvattnet

Det stämmer - och det är ett stort problem. Läs det sista stycket igen. &quot;... renderade bilder när något ändras.&quot; Som ni vet ändras en bra webbplats hela tiden; lägga till nytt innehåll här, korrigera ett stavfel där och tweeta ett teaser någon annanstans. Det innebär att alla bilder blir permanent ogiltiga och måste återges på nytt. Underskatta inte det. Dynamisk återgivning och överföring av bilddata fungerar i millisekunder på den lokala utvecklingsdatorn. Din produktionsmiljö behöver göra det hundra gånger oftare - per sekund.

Och här ska vi vara tydliga: dina jpg-filer måste återges igen när en HTML-sida ändras och vice versa. Det finns bara en&quot;bucket&quot; med filer som ska ogiltigförklaras automatiskt. Den spolas som helhet. Utan någon form av indelning i ytterligare detaljerade strukturer.

Det finns en bra anledning till varför den automatiska ogiltigförklaringen behålls som standard till &quot;.html&quot;. Målet är att hålla bucket så litet som möjligt. Kasta inte ut bebisen med badvattnet genom att bara göra allting ogiltigt - bara för att vara på den säkra sidan.

Självständiga resurser ska betjänas på den resursens sökväg. Det hjälper till att ogiltigförklara mycket. Gör det enkelt, skapa inte mappningsscheman som &quot;resource /a/b/c&quot; hämtas från &quot;/x/y/z&quot;. Låt komponenterna fungera med standardinställningarna för automatisk ogiltigförklaring av Dispatcher. Försök inte reparera en dåligt utformad komponent med överogiltigförklaring i Dispatcher.

##### Undantag för automatisk invalidering: Invalidering av endast resurs

Inaktiveringsbegäran för Dispatcher utlöses vanligtvis av en replikeringsagent från publiceringssystemet.

Om du känner dig riktigt säker på dina beroenden kan du försöka skapa en egen ogiltig replikeringsagent.

Det skulle gå lite längre än den här guiden för att gå in på detaljerna, men vi vill ge dig åtminstone några tips.

1. Jag vet verkligen vad du gör. Det är verkligen svårt att få ogiltigförklaringen rätt. Det är en anledning till att den automatiska ogiltigförklaringen är så rigorös. för att undvika att leverera gammalt innehåll.

2. Om din agent skickar en HTTP-rubrik `CQ-Action-Scope: ResourceOnly`, vilket innebär att denna enda ogiltigförklaring inte utlöser en automatisk ogiltigförklaring. Detta ( [https://github.com/cqsupport/webinar-dispatchercache/tree/master/src/refetching-flush-agent/refetch-bundle](https://github.com/cqsupport/webinar-dispatchercache/tree/master/src/refetching-flush-agent/refetch-bundle)) kod kan vara en bra startpunkt för din egen replikeringsagent.

3. `ResourceOnly`förhindrar endast automatisk ogiltigförklaring. För att kunna utföra den nödvändiga beroendematchningen och ogiltigförklaringarna måste du själv utlösa invalideringen. Du kan kontrollera rensningsreglerna för paketet Dispatcher ([https://adobe-consulting-services.github.io/acs-aem-commons/features/dispatcher-flush-rules/index.html](https://adobe-consulting-services.github.io/acs-aem-commons/features/dispatcher-flush-rules/index.html)) för att få inspiration om hur det faktiskt skulle kunna hända.

Vi rekommenderar inte att du skapar ett system för beroendematchning. Det finns bara för mycket arbete och lite vinst - och som tidigare har sagts, det är för mycket som du kommer att få fel.

Du bör i stället ta reda på vilka resurser som inte är beroende av andra resurser och som kan ogiltigförklaras utan automatisk ogiltigförklaring. Du behöver dock inte använda en anpassad replikeringsagent för den delen. Skapa bara en anpassad regel i Dispatcher-konfigurationen som utesluter dessa resurser från automatisk ogiltigförklaring.

Vi sa att de viktigaste navigationsfunktionerna är en källa till beroenden. Om du läser in navigeringen och teasynkront eller inkluderar dem med ett SSI-skript i Apache, har du inte det beroendet att spåra. Vi kommer att gå vidare med asynkron inläsning av komponenter senare i det här dokumentet när vi talar om&quot;Sling Dynamic Includes&quot;.

Detsamma gäller för popup-fönster eller innehåll som läses in i en ljuslåda. De här bitarna har sällan navigering (dvs. &quot;beroenden&quot;) och kan ogiltigförklaras som en enskild resurs.

## Bygga komponenter med Dispatcher i åtanke

### Använda Dispatcher Mechanics i ett Real-World-exempel

I det sista kapitlet förklarar vi hur Dispatcher&#39;s basic mekanics fungerar i allmänhet och vilka begränsningar som finns.

Vi vill nu tillämpa dessa mekaniker på en typ av komponenter som du antagligen hittar i projektets krav. Vi väljer avsiktligt komponenten för att demonstrera problem som du också kommer att stöta på förr eller senare. Rädsla inte - alla komponenter behöver inte det som vi kommer att presentera. Men om du ser behovet av att bygga en sådan komponent är du väl medveten om konsekvenserna och vet hur man hanterar dem.

### Komponenten Spooling (Anti)

#### Komponenten för responsiv bild

Låt oss illustrera ett vanligt mönster (eller ett antimönster) för en komponent med sammankopplade binärfiler. Vi ska skapa en komponent som&quot;respi&quot; - för&quot;responsiv-image&quot;. Den här komponenten bör kunna anpassa den visade bilden till den enhet som den visas på. På stationära datorer och surfplattor visas bildens fullständiga upplösning, i telefoner en mindre version med en smal beskärning - eller kanske till och med ett helt annat motiv (det kallas&quot;konsthändelse&quot; i den responsiva världen).

Resurserna överförs bara till DAM-området i AEM _refererad_ i komponenten responsiv-image.

Responskomponenten tar hand om både återgivningen av markeringen och leveransen av binära bilddata.

Det sätt vi implementerar det här är ett gemensamt mönster som vi har sett i många projekt, och till och med en av de AEM kärnkomponenterna är baserad på det mönstret. Därför är det mycket troligt att du som utvecklare kan anpassa det mönstret. Den har sina ljuvliga fläckar när det gäller inkapsling, men det kräver en hel del arbete för att få den klar för Dispatcher. Vi kommer att diskutera flera olika alternativ för att minska problemet senare.

Vi kallar det mönster som används här för &quot;Utskriftsmönster&quot;, eftersom problemet är en del av de tidiga dagarna i Communiqué 3 där det fanns en metod som kunde anropas på en resurs för att strömma dess binära rådata till svaret.

Den ursprungliga termen &quot;mellanlagring&quot; avser egentligen delad kringutrustning som är offline, som skrivare, så den används inte korrekt här. Men vi gillar termen i alla fall eftersom den sällan finns i onlinevärlden och därmed är urskiljbar. Och varje mönster ska ändå ha ett unikt namn. Det är upp till dig att bestämma om detta är ett mönster eller ett antimönster.

#### Implementering

Så här implementeras vår komponent för responsiv bild:

Komponenten har två delar. den första delen återger bildens HTML-kod, den andra delen &quot;mellanlagras&quot; den refererade bildens binära data. Eftersom det här är en modern webbplats med responsiv design renderar vi inte en enkel `<img src"…">` -tagg, men en uppsättning bilder i `<picture/>` -tagg. För varje enhet överför vi två olika bilder till DAM och refererar till dem från vår bildkomponent.

Komponenten har tre återgivningsskript (implementerade i JSP, HTL eller som en servlet) som var och en är adresserad med en dedikerad väljare:

1. `/respi.jsp` - utan väljare som återger HTML-koden
2. `/respi.img.java` för att återge skrivbordsversionen
3. `/respi.img.mobile.java` för att återge mobilversionen.


Komponenten placeras i parsys på hemsidan. Den resulterande strukturen i CRX illustreras nedan.

![Resursstruktur för den responsiva bilden i CRX](assets/chapter-1/responsive-image-crx.png)

*Resursstruktur för den responsiva bilden i CRX*

<br> 

Komponentkoden återges så här:

```plain
  #GET /content/home.html

  <html>

  …

  <div class="responsive-image>

  <picture>
    <source src="/content/home/jcr:content/par/respi.img.mobile.jpg" …/>
    <source src="/content/home/jcr:content/par/respi.img.jpg …/>

    …

  </picture>
  </div>
  …
```

och... har vi gjort klart med vår eleganta inkapslade komponent.

#### Responsive Image Component in action

Nu begär en användare sidan - och resurserna via Dispatcher. Detta resulterar i filer i Dispatcher-filsystemet enligt bilden nedan,

![Cachelagrad struktur för den inkapslade responsiva bildkomponenten](assets/chapter-1/cached-structure-encapsulated-image-comonent.png)

*Cachelagrad struktur för den inkapslade responsiva bildkomponenten*

<br> 

Överväg att en användare överför och aktiverar en ny version av de två blombilderna till DAM. AEM skickar enligt invalidiseringsbegäran för

`/content/dam/flower.jpg`

och

`/content/dam/flower-mobile.jpg`

till Dispatcher. De här förfrågningarna är dock förgäves. Innehållet har cachelagrats som filer under komponentens understruktur. De här filerna är nu inaktuella, men hanteras fortfarande på begäran.

![Strukturmatchningsfel som leder till inaktuellt innehåll](assets/chapter-1/structure-mismatch.png)

*Strukturmatchningsfel som leder till inaktuellt innehåll*

<br> 

Det finns en annan grovlek på detta tillvägagångssätt. Du bör använda samma blomma.jpg på flera sidor. Sedan kan du cachelagra samma resurs under flera URL:er eller filer,

```
/content/home/products/jcr:content/par/respi.img.jpg

/content/home/offers/jcr:content/par/respi.img.jpg

/content/home/specials/jcr:content/par/respi.img.jpg

…
```

Varje gång en ny och icke cachelagrad sida begärs hämtas resurserna från AEM på olika URL:er. Ingen Dispatcher-cachning och ingen webbläsarcachning kan snabba upp leveransen.

#### Där mönstret Spooler lyser

Det finns ett naturligt undantag där det här mönstret även i sin enkla form är användbart: Om binärfilen lagras i själva komponenten, och inte i DAM. Detta är emellertid bara användbart för bilder som används en gång på webbplatsen, och om du inte lagrar resurser i DAM innebär det att du har svårt att hantera dina resurser. Tänk dig bara att din användningslicens tar slut för en viss mediefil. Hur får du reda på vilka komponenter du har använt resursen?

Ser du? &quot;M&quot; i DAM står för &quot;Management&quot; - som i Digital Asset Management. Du vill inte ge bort den funktionen.

#### Slutsats

Ur AEM perspektiv såg mönstret superelegant ut. Men med Dispatcher i ekvationen kanske du håller med om att det naiva tillvägagångssättet kanske inte räcker.

Vi låter dig bestämma om det är ett mönster eller ett antimönster för tillfället. Och du kanske redan har bra idéer i åtanke om hur du kan mildra problemen som beskrivs ovan? Bra. Då ska du vara angelägen om att se hur andra projekt har löst dessa problem.

### Lösa vanliga utskicksproblem

#### Översikt

Låt oss prata om hur det kunde ha implementerats lite mer cachevänligt. Det finns flera alternativ. Ibland kan man inte välja den bästa lösningen. Du kanske kommer i ett projekt som redan körs och du har begränsad budget för att bara åtgärda det aktuella cacheproblemet och inte tillräckligt för att utföra en fullständig omfaktorisering. Eller så har du ett problem som är mer komplext än exempelbildkomponenten.

Vi kommer att beskriva principerna och taktiken i följande avsnitt.

Återigen baseras detta på verkliga erfarenheter. Vi har redan sett alla dessa mönster i naturen så det är inte en akademisk övning. Därför visar vi dig några antimönster, så du har chansen att lära dig av misstag som andra redan har gjort.

#### Cachemördare

>[!WARNING]
>
>Det här är ett antimönster. Använd den inte. Någonsin.

Har du någonsin sett frågeparametrar som `?ck=398547283745`? De kallas cacheminnesmördare (&quot;ck&quot;). Tanken är att om du lägger till en frågeparameter kommer resursen inte att cachelagras. Om du dessutom lägger till ett slumpmässigt tal som parameterns värde (till exempel &quot;398547283745&quot;) blir URL-adressen unik och du ser till att ingen annan cache mellan AEM och skärmen kan cachelagra något. Vanligtvis är mellanliggande misstänkta ett&quot;Varnish&quot;-cache framför Dispatcher, ett CDN eller till och med webbläsarens cache. Igen: Gör inte så. Du vill verkligen att dina resurser ska cachas så mycket och så länge som möjligt. Cacheminnet är din vän. Dödar inte vänner.

#### Automatisk invalidering

>[!WARNING]
>
>Det här är ett antimönster. Undvik att använda det för digitala resurser. Försök att behålla Dispatcher-standardkonfigurationen, som > är automatisk ogiltigförklaring för .html-filer, endast

På kort sikt kan du lägga till&quot;.jpg&quot; och&quot;.png&quot; i konfigurationen för automatisk ogiltigförklaring i Dispatcher. Det innebär att när en ogiltigförklaring inträffar måste alla&quot;.jpg&quot;,&quot;.png&quot; och&quot;.html&quot; återges på nytt.

Det här mönstret är superenkelt att implementera om företagsägare klagar över att deras ändringar inte syns tillräckligt snabbt på den publicerade webbplatsen. Men det här kan bara ge dig lite tid att komma på en mer sofistikerad lösning.

Se till att ni förstår de omfattande prestandaeffekterna. Detta kommer att göra webbplatsen betydligt långsammare och kan till och med påverka stabiliteten - om webbplatsen är en högbelastad webbplats med ofta förekommande ändringar - som en nyhetsportal.

#### URL-fingeravtryck

Ett URL-fingeravtryck ser ut som ett cacheminneri. Men det är det inte. Det är inte ett slumptal utan ett värde som karakteriserar resursens innehåll. Detta kan vara en hash av resursens innehåll eller - ännu enklare - en tidsstämpel när resursen överfördes, redigerades eller uppdaterades.

En Unix-tidsstämpel är tillräckligt bra för en implementering i verkligheten. För bättre läsbarhet använder vi ett mer läsbart format i den här kursen: `2018 31.12 23:59 or fp-2018-31-12-23-59`.

Fingeravtrycket får inte användas som frågeparameter eftersom URL:er med frågeparametrar inte kan cachelagras. Du kan använda en väljare eller suffixet för fingeravtrycket.

Låt oss anta att filen `/content/dam/flower.jpg` har en `jcr:lastModified` den 31 december 2018, 23:59. URL:en med fingeravtryck är `/content/home/jcr:content/par/respi.fp-2018-31-12-23-59.jpg`.

Den här URL:en är stabil så länge som den refererade resursen (`flower.jpg`) ändras inte. Det kan cachas på obestämd tid och är ingen cacheminnesmördare.

Observera att den här URL:en måste skapas och hanteras av den responsiva bildkomponenten. Det är inte en körklar AEM.

Det är det grundläggande konceptet. Det finns dock några detaljer som lätt kan förbises.

I vårt exempel renderades och cachelagrades komponenten vid 23:59. Nu har bilden ändrats, till exempel 00:00.  Komponenten _skulle_ generera en ny fingeravtrycksadress i markeringen.

Du kanske tror det _bör_... men det gör det inte. Eftersom endast bildens binärfil har ändrats och inkluderingssidan inte har berörts, behövs ingen återgivning av HTML-markeringen. Dispatcher visar sidan med det gamla fingeravtrycket och därmed den gamla versionen av bilden.

![Bildkomponenten är senare än den refererade bilden, inget nytt fingeravtryck återges.](assets/chapter-1/recent-image-component.png)

*Bildkomponenten är senare än den refererade bilden, inget nytt fingeravtryck återges.*

<br> 

Om du nu återaktiverade startsidan (eller någon annan sida på den webbplatsen) uppdateras statusfilen, tar Dispatcher hänsyn till home.html-förinställningen och återger den med ett nytt fingeravtryck i bildkomponenten.

Men vi aktiverade inte hemsidan, eller hur? Och varför ska vi aktivera en sida som vi inte rörde vid ändå? Dessutom kanske vi inte har tillräckliga rättigheter för att aktivera sidor eller så är godkännandeprocessen så lång och tidskrävande att vi inte kan göra det med kort varsel. Så vad ska jag göra?

#### Lazy Admin&#39;s Tool - Minska statusfilsnivåer

>[!WARNING]
>
>Det här är ett antimönster. Använd det bara på kort sikt för att köpa lite tid och hitta en mer sofistikerad lösning.

Administratören brukar&quot;_ställer in automatisk ogiltigförklaring på jpgs och statfile-nivån på noll, vilket alltid hjälper vid cachelagring av alla typer av problem_.&quot; Du hittar dessa råd i tekniska forum och det hjälper dig med ditt invalideringsproblem.

Tills nu har vi inte diskuterat statfilnivån. Automatisk ogiltigförklaring fungerar i princip bara för filer i samma underträd. Problemet är dock att sidor och resurser vanligtvis inte finns i samma underträd. Sidorna är någonstans under `/content/mysite` Resurser finns nedan `/content/dam`.

&quot;statfile level&quot; definierar var på vilka djuprotnoder underträden finns. I exemplet ovan skulle nivån vara &quot;2&quot; (1=/content, 2=/mysite,dam)

Tanken på att&quot;minska&quot; statusfilnivån till 0 är i princip att definiera hela /content-trädet som det enda underordnade trädet, så att sidor och resurser blir tillgängliga i samma domän för automatisk ogiltigförklaring. Vi har alltså bara ett stort träd på nivå (vid dokumentroten &quot;/&quot;). Om du gör det blir alla webbplatser på servern ogiltiga när något publiceras - även på helt orelaterade webbplatser. Lita på oss: Det här är en dålig idé i det långa loppet eftersom du kommer att försämra den totala cacheminnesträffen avsevärt. Allt du kan göra är att hoppas att dina AEM har tillräckligt med brandkraft för att kunna köras utan cache.

Du kommer att förstå de fullständiga fördelarna med djupare statusnivåer lite senare.

#### Implementera en anpassad valideringsagent

Hur som helst - vi måste berätta för Dispatcher på något sätt för att göra HTML-sidor ogiltiga om en .jpg eller .png ändras så att återgivning tillåts med en ny URL.

Det vi har sett i projekt är till exempel särskilda replikeringsagenter i publiceringssystemet som skickar ogiltigförklaringsbegäranden för en plats när en bild av den platsen publiceras.

Här är det till stor hjälp om du kan härleda platsens sökväg från resursens sökväg genom att namnge en konvention.

Generellt sett är det en bra idé att matcha platserna och resurssökvägarna så här:

**Exempel**

```
/content/dam/site-a
/content/dam/site-b

/content/site-a
/content/site-b
```

På så sätt kan din anpassade Dispatcher Flushing-agent enkelt skicka och ogiltigförklara en begäran till /content/site-a när en ändring upptäcks i `/content/dam/site-a`.

Faktiskt så spelar det ingen roll vilken sökväg du ber Dispatcher att ogiltigförklara - så länge den befinner sig på samma plats, i samma &quot;underträd&quot;. Du behöver inte ens använda en riktig resurssökväg. Det kan även vara&quot;virtuellt&quot;:

```
GET /dispatcher-invalidate
Invalidate-path /content/mysite/dummy
```

![](assets/chapter-1/resource-path.png)

1. En avlyssnare i publiceringssystemet aktiveras när en fil i DAM ändras

2. Avlyssnaren skickar en ogiltig begäran till Dispatcher. På grund av automatisk ogiltigförklaring spelar det ingen roll vilken väg vi skickar in den automatiska ogiltigförklaringen, såvida den inte ligger under webbplatsens hemsida - eller mer exakt på webbplatsens statusnivå.

3. Statusfilen uppdateras.

4. Nästa gång hemsidan begärs återges den på nytt. Det nya fingeravtrycket/datumet hämtas från bildens lastModified-egenskap som en extra väljare

5. Detta skapar implicit en referens till en ny bild

6. Om bilden verkligen efterfrågas skapas en ny rendering som lagras i Dispatcher


#### Behovet av rensning

Phew. Slutförd. Hurra!

Inte riktigt än.

Banan

`/content/mysite/home/jcr:content/par/respi.img.fp-2018-31-12-23-59.jpg`

inte avser någon av de ogiltiga resurserna. Kommer du ihåg? Vi ogiltigförklarade bara en &quot;dummy&quot;-resurs och förlitade oss på automatisk ogiltigförklaring för att anse &quot;home&quot; som ogiltig. Själva bilden kanske aldrig _fysiskt_ borttagen. Så cacheminnet kommer att växa och växa och växa. När bilder ändras och aktiveras får de nya filnamn i filsystemet i Dispatcher.

Det finns tre problem med att inte ta bort de cachelagrade filerna fysiskt och behålla dem i oändlighet:

1. Du slösar helt klart bort lagringskapacitet. Beviljad - lagringsutrymmet har blivit billigare och billigare under de senaste åren. Men bildupplösningar och filstorlekar har också växt under de senaste åren - med näthinneliknande skärmar som är hungriga efter kristallskarpa bilder.

2. Trots att hårddiskarna har blivit billigare har &quot;lagring&quot; kanske inte blivit billigare. Vi har sett en trend där din datacenterleverantör inte har tillgång till (billig) lagring i rent metall utan hyr ut virtuell lagring på en NAS. Den här typen av lagring är lite mer tillförlitlig och skalbar men också lite dyrare. Du kanske inte vill slösa bort den genom att lagra föråldrad skräp. Detta gäller inte bara den primära lagringen - tänk också på säkerhetskopieringar. Om du har en färdig lösning för säkerhetskopiering kanske du inte kan utesluta cachekatalogerna. Till slut säkerhetskopierar du också skräpdata.

3. Ännu värre: Du kan ha köpt användningslicenser för vissa bilder endast under en begränsad tid - så länge du behöver dem. Om du fortfarande lagrar bilden efter att en licens har upphört att gälla kan detta ses som en upphovsrättsöverträdelse. Du kanske inte längre använder bilden på dina webbsidor, men Google hittar dem fortfarande.

Till slut kommer du att få lite jobb att städa alla filer som är äldre än... en vecka för att hålla den här typen av strö under kontroll.

#### Förskjuter URL-fingeravtryck för denial of service-attacker

Men vänta, det finns ett annat fel i den här lösningen:

Vi missbrukar en väljare som parameter: fp-2018-31-12-23-59 genereras dynamiskt som något slags&quot;cache-mördare&quot;. Men en liten liten skugga (eller en krypbägare i sökmotorn) börjar begära sidorna:

```
/content/mysite/home/jcr:content/par/img.fp-0000-00-00-00-00.jpg
/content/mysite/home/jcr:content/par/img.fp-0000-00-00-00-01.jpg
/content/mysite/home/jcr:content/par/img.fp-0000-00-00-00-02.jpg

…
```

Varje begäran kommer att kringgå Dispatcher, vilket orsakar inläsning på en Publish-instans. Och ännu värre - skapa en bildfil i Dispatcher.

I stället för att bara använda fingeravtrycket som en enkel cacheminnesmördare måste du kontrollera jcr:lastModified-datumet för bilden och returnera 404 om det inte är det förväntade datumet. Det tar en stund och processorkraft i publiceringssystemet ... vilket är vad du vill förhindra från början.

#### Värden för URL-fingeravtryck i högfrekventa versioner

Du kan använda fingeravtrycksschemat inte bara för resurser som kommer från DAM, utan även för JS- och CSS-filer och relaterade resurser.

[Versionsklientlibs](https://adobe-consulting-services.github.io/acs-aem-commons/features/versioned-clientlibs/index.html) är en modul som använder det här arbetssättet.

Men här kan du stå inför en annan kavaat med URL-fingeravtryck: Den kopplar URL:en till innehållet. Du kan inte ändra innehållet utan att ändra URL-adressen (d.v.s. uppdatera ändringsdatumet). Det är det fingeravtrycken är utformade för i första hand. Men tänk på att ni nu lanserar en ny release med nya CSS- och JS-filer och därmed nya URL:er med nya fingeravtryck. Alla dina HTML-sidor har fortfarande referenser till de gamla fingeravtrycks-URL:erna. För att få den nya versionen att fungera på ett konsekvent sätt måste du ogiltigförklara alla HTML-sidor samtidigt för att tvinga fram en omrendering med referenser till de nya fingeravtrycksfilerna. Om du har flera platser som är beroende av samma bibliotek kan det vara en avsevärd mängd återgivning - och här kan du inte utnyttja `statfiles`. Så var redo att se belastningstoppar i dina Publish-system efter en utrullning. Du kan överväga en blågrön distribution med cacheuppvärmning eller kanske ett TTL-baserat cacheminne framför Dispatcher ... möjligheterna är oändliga.

#### En kort brytning

Wow - Det är en hel del detaljer att tänka på, eller hur? Och den vägrar att vara lätt att förstå, testa och felsöka. Och allt för en till synes elegant lösning. Visserligen är det elegant - men bara ur ett AEM perspektiv. Tillsammans med Dispatcher blir det otrevligt.

Och ändå - det löser inte ett enkelt cavat, om en bild används flera gånger på olika sidor cachelagras de under dessa sidor. Det finns inte mycket cachelagring av synergi där.

I allmänhet är URL-fingeravtryck ett bra verktyg i verktygslådan, men du måste använda det med försiktighet, eftersom det kan orsaka nya problem medan du bara löser några få befintliga.

Så.. det var ett långt kapitel. Men vi har sett det här mönstret så ofta att vi kände att det var nödvändigt att ge dig hela bilden med alla för- och nackdelar. URL-fingeravtryck löser ett par av de inneboende problemen i Utskriftsmönster, men implementeringen är ganska hög och du måste även överväga andra - enklare - lösningar. Vi rekommenderar att du alltid kontrollerar om du kan basera dina URL-adresser på de hanterade resurssökvägarna och inte har någon mellanliggande komponent. Vi kommer till detta i nästa kapitel.

##### Beroendeupplösning vid körning

Beroendelösning vid körning är ett koncept som vi har övervägt i ett projekt. Men att tänka igenom det blev ganska komplicerat och vi bestämde oss för att inte genomföra det.

Här är grundtanken:

Dispatcher känner inte till resursberoenden. Det är bara en massa enstaka filer med lite semantik.

AEM vet också lite om beroenden. Det saknas en korrekt semantik eller en &quot;beroendespårare&quot;.

AEM är medvetna om några av referenserna. Den här informationen används för att varna dig när du försöker ta bort eller flytta en refererad sida eller resurs. Det gör du genom att fråga den interna sökningen när du tar bort en resurs. Innehållsreferenser har ett mycket specifikt formulär. De är sökvägsuttryck som börjar med &quot;/content&quot;. De kan enkelt indexeras i fulltext - och efterfrågas vid behov.

I det här fallet behöver vi en anpassad replikeringsagent i publiceringssystemet som utlöser en sökning efter en specifik sökväg när sökvägen har ändrats.

Låt oss säga

`/content/dam/flower.jpg`

Har ändrats vid publicering. Agenten skulle starta en sökning efter&quot;/content/dam/flower.jpg&quot; och hitta alla sidor som refererar till dessa bilder.

Sedan kan den skicka ett antal ogiltigförklaringsbegäranden till Dispatcher. En för varje sida som innehåller resursen.

Teoretiskt sett, det borde fungera. Men bara för förstanivåberoenden. Du vill inte använda det schemat för beroenden på flera nivåer, till exempel när du använder bilden på ett upplevelsefragment som används på en sida. Faktiskt anser vi att det här tillvägagångssättet är för komplext - och det kan finnas körningsproblem. Och oftast är det bästa rådet att inte göra dyr datorhantering i händelsehanterare. Och särskilt sökandet kan bli ganska dyrt.

##### Slutsats

Vi hoppas att vi har diskuterat buffertmönstret noggrant nog för att hjälpa dig att bestämma när du ska använda det och inte använda det i implementeringen.

## Undvika utskicksproblem

### Resursbaserade URL:er

Ett mycket mer elegant sätt att lösa beroendeproblemet är att inte ha beroenden alls. Undvik artificiella beroenden som uppstår när du använder en resurs för att proxyta en annan - som vi gjorde i det senaste exemplet. Försök att se resurserna som &quot;solitära&quot; enheter så ofta som möjligt.

Vårt exempel är enkelt att lösa:

![Samla bilden med en servett som är bunden till bilden, inte komponenten.](assets/chapter-1/spooling-image.png)

*Samla bilden med en servett som är bunden till bilden, inte komponenten.*

<br> 

Resursernas ursprungliga resurssökvägar används för att återge data. Om vi behöver återge originalbilden som den är kan vi bara använda AEM standardåtergivning för resurser.

Om vi behöver utföra någon speciell bearbetning för en viss komponent, registrerar vi en dedikerad server på den banan och väljaren för att utföra omvandlingen för komponentens räkning. Vi gjorde det här exemplariskt med&quot;.respi&quot;. väljare. Det är klokt att hålla reda på väljarnamnen som används i det globala URL-området (till exempel `/content/dam`) och har en bra namnkonvention för att undvika namnkonflikter.

Förresten - vi ser inga problem med kodens konsekvens. Serleten kan definieras i samma Java-paket som komponenternas sling-modell.

Vi kan till och med använda ytterligare väljare i det globala rummet, som

`/content/dam/flower.respi.thumbnail.jpg`

Lätt, eller hur? Varför kommer folk då på komplicerade mönster som Spooler?

Vi kan lösa problemet med att undvika den interna innehållsreferensen eftersom den yttre komponenten tillför lite värde eller information till återgivningen av den inre resursen, så att den enkelt kan kodas i en uppsättning statiska väljare som styr representationen av en fristående resurs.

Men det finns en typ av fall som du inte enkelt kan lösa med en resursbaserad URL. Vi kallar den här typen av fall, &quot;Parameter Injection Components&quot;, och diskuterar dem i nästa kapitel.

### Parametern matar in komponenter

#### Översikt

Utskriftshanteraren i det sista kapitlet var bara en tunn wrapper runt en resurs. Det orsakade mer problem än att hjälpa till att lösa problemet.

Vi kan enkelt ersätta den radbrytningen genom att använda en enkel väljare och lägga till en servett för att hantera sådana förfrågningar.

Men tänk om &quot;respi&quot;-komponenten är mer än bara en proxy. Vad händer om komponenten verkligen bidrar till återgivningen av komponenten?

Låt oss presentera en liten förlängning av vår&quot;respi&quot;-komponent, det är lite av en spelförändring. Vi kommer återigen att börja med att presentera några naiva lösningar för att tackla de nya utmaningarna och visa var de kommer att ta slut.

#### Komponenten RESPI2

Responsiv2-komponenten är en komponent som visar en responsiv bild, precis som responsiv-komponenten. Men den har en liten tilläggsfunktion,

![CRX-struktur: respi2-komponent som lägger till en kvalitetsegenskap i leveransen](assets/chapter-1/respi2.png)

*CRX-struktur: respi2-komponent som lägger till en kvalitetsegenskap i leveransen*

<br> 

Bilderna är jpegs och jpegs kan komprimeras. När du komprimerar en jpeg-bild utökar du kvaliteten för filstorleken. Komprimering definieras som en numerisk kvalitetsparameter som sträcker sig från &quot;1&quot; till &quot;100&quot;. &quot;1&quot; betyder &quot;liten men dålig kvalitet&quot;, &quot;100&quot; står för &quot;utmärkt kvalitet men stora filer&quot;. Vilket är då det perfekta värdet?

Som i alla IT-frågor är svaret: &quot;Det beror på.&quot;

Här beror det på motivet. Filmer med högkontrastkanter som motiv, inklusive skriven text, foton av byggnader, illustrationer, skisser eller foton av produktrutor (med skarpa konturer och text skrivna på den) hör vanligtvis till den kategorin. Filmer med mjukare färg- och kontrastövergångar som landskap och porträtt kan komprimeras lite mer utan synliga kvalitetsförluster. Naturfotografier hör vanligtvis till den kategorin.

Beroende på var bilden används kanske du vill använda en annan parameter. En liten miniatyrbild i ett teaser kan medföra bättre komprimering än samma bild som används i en skärmbred hjältebanderoll. Det innebär att parametern quality inte är inbyggd i bilden utan i bilden och sammanhanget. Och till författarens smak.

Kort och gott: Det finns ingen perfekt inställning för alla bilder. Det finns ingen enstorlek-passar-alla. Det är bäst författaren bestämmer. Han kommer att finjustera parametern &quot;quality&quot; som en egenskap i komponenten tills han är nöjd med kvaliteten och inte går längre för att inte offra bandbredden.

Vi har nu en binär fil i DAM och en komponent som tillhandahåller en quality-egenskap. Hur ska URL:en se ut? Vilken komponent ansvarar för mellanlagringen?

#### Tidigare metod 1: Skicka egenskaper som frågeparametrar

>[!WARNING]
>
>Det här är ett antimönster. Använd den inte.

I det sista kapitlet såg vår bild-URL som återgetts av komponenten ut så här:

`/content/dam/flower.respi.jpg`

Allt som saknas är värdet för kvaliteten. Komponenten vet vilken egenskap som författaren anger.. Den kan enkelt skickas till bildåtergivningsservern som en frågeparameter när koden återges, som `flower.respi2.jpg?quality=60`:

```plain
  <div class="respi2">
  <picture>
    <source src="/content/dam/flower.respi2.jpg?quality=60" …/>
    …
  </picture>
  </div>
  …
```

Det här är en dålig idé. Kommer du ihåg? Begäranden med frågeparametrar är inte cachelagrade.

#### Tidigare metod 2: Skicka ytterligare information som väljare

>[!WARNING]
>
>Detta kan bli ett antimönster. Använd den noggrant.

![Skicka komponentegenskaper som väljare](assets/chapter-1/passing-component-properties.png)

*Skicka komponentegenskaper som väljare*

<br> 

Detta är en liten variation av den sista URL:en. Bara den här gången använder vi en väljare för att skicka egenskapen till servern, så att resultatet blir tillgängligt:

`/content/dam/flower.respi.q-60.jpg`

Det här är mycket bättre, men kom ihåg den otrevliga skript-killen från det sista kapitlet som letar efter sådana mönster? Han skulle se hur långt han kan komma med att slingra sig över värden:

```plain
  /content/dam/flower.respi.q-60.jpg
  /content/dam/flower.respi.q-61.jpg
  /content/dam/flower.respi.q-62.jpg
  /content/dam/flower.respi.q-63.jpg
  …
```

Detta gör att cacheminnet kringgås och inläsning skapas i publiceringssystemet. Det kan vara en dålig idé. Du kan begränsa detta genom att bara filtrera en liten delmängd av parametrarna. Du vill bara tillåta `q-20, q-40, q-60, q-80, q-100`.

#### Filtrering av ogiltiga begäranden när väljare används

Att minska antalet väljare var en bra början. Som tumregel bör du alltid begränsa antalet giltiga parametrar till ett absolut minimum. Om du gör detta smart kan du även använda en brandvägg för webbaserade program utanför AEM med en statisk uppsättning filter utan djupa kunskaper om det underliggande AEM för att skydda dina system:

```
Allow: /content/dam/(-\_/a-z0-9)+/(-\_a-z0-9)+
       \.respi\.q-(20|40|60|80|100)\.jpg
```

Om du inte har någon brandvägg för webbprogram måste du filtrera i Dispatcher eller i AEM. Om du gör det i AEM, vänligen kontrollera att

1. Filtret implementeras supereffektivt utan att CRX-värdet behöver användas för mycket och minne och tid går förlorad.

2. Filtret svarar på felmeddelandet&quot;404 - Hittades inte&quot;

Låt oss betona den sista punkten igen. HTTP-konversationen skulle se ut så här:

```plain
  GET /content/dam/flower.respi.q-41.jpg

  Response: 404 – Not found
  << empty response body >>
```

Vi har också sett implementeringar som filtrerade ogiltiga parametrar men returnerade en giltig reservåtergivning när en ogiltig parameter används. Låt oss anta att vi bara tillåter parametrar från 20 till 100. Värdena däremellan mappas till de giltiga. Så,

`q-41, q-42, q-43, …`

skulle alltid svara på samma bild som q-40 skulle ha:

```plain
  GET /content/dam/flower.respi.q-41.jpg

  Response: 200 – OK
  << flower.jpg with quality = 40 >>
```

Den metoden hjälper inte alls. Dessa begäranden är i själva verket giltiga begäranden.  De förbrukar processorkraft och tar upp utrymme i cachekatalogen på Dispatcher.

Bättre är att returnera en `301 – Moved permanently`:

```plain
  GET /content/dam/flower.respi.q-41.jpg

  Response: 301 – Moved permanently
  Location: /content/dam/flower.respi.q-40.jpg
```

Här säger AEM till webbläsaren. &quot;Jag har inte `q-41`. Men du kan fråga mig om `q-40` &quot;.

Då läggs en extra begäransvarsslinga till i konversationen, som är lite dyr, men det är billigare än att utföra fullständig bearbetning på `q-41`. Och du kan utnyttja filen som redan cachas under `q-40`. Du måste dock förstå att 302 svar inte cachas i Dispatcher, vi talar om logik som körs i AEM. Om och om igen. Det är bäst att du gör den smal och snabb.

Personligen tycker vi om att 404 svarar mest. Det gör det superuppenbart vad som händer. Och hjälper till att identifiera fel på webbplatsen när du analyserar loggfiler. 301s kan vara avsett, där 404 alltid ska analyseras och elimineras.

## Säkerhet - exursion

### Förfrågningar om filtrering

#### Bästa filtrering

I slutet av det sista kapitlet påpekade vi behovet av att filtrera inkommande trafik för kända väljare. Då återstår frågan: Var ska jag egentligen filtrera förfrågningar?

Det beror på. Ju förr desto bättre.

#### Brandväggar för webbaserade program

Om du har en Brandvägg för webbaserade program eller &quot;WAF&quot; som är utformad för webbsäkerhet bör du utnyttja dessa funktioner. Men du kanske får reda på att WAF hanteras av personer som bara har begränsad kunskap om ditt innehållsprogram och som antingen filtrerar giltiga begäranden eller låter skicka för många skadliga förfrågningar. Kanske kommer du att få reda på att de personer som driver WAF är tilldelade till en annan avdelning med olika tidsplaner och releaser, att kommunikationen kanske inte är lika noggrann som med era direkta teamkamrater och att ni inte alltid får ändringarna i tid, vilket betyder att utvecklingen och innehållets hastighet i slutändan blir lidande.

Du kanske får några allmänna regler, eller till och med en blockeringslista, som din magkänsla säger, kan bli åtstramad.

#### Dispatcher- och Publish Filtering

Nästa steg är att lägga till regler för URL-filtrering i Apache-kärnan och/eller i Dispatcher.

Här har du bara tillgång till URL:er. Du är begränsad till mönsterbaserade filter. Om du behöver konfigurera en mer innehållsbaserad filtrering (som att bara tillåta filer med rätt tidsstämpel) eller om du vill att en del av filtreringen ska styras på författaren, kommer du att skriva något som liknar ett anpassat servletsfilter.

#### Övervakning och felsökning

I praktiken har du en viss säkerhet på varje nivå. Men se till att du har möjlighet att ta reda på på vilken nivå en begäran filtreras bort. Kontrollera att du har direkt åtkomst till publiceringssystemet, Dispatcher och loggfilerna på WAF för att ta reda på vilket filter i kedjan som blockerar begäranden.

### Väljare och spridning av väljare

Den metod som använder&quot;väljarparametrar&quot; i det sista kapitlet är snabb och enkel och kan snabba upp utvecklingstiden för nya komponenter, men har begränsningar.

Att ställa in en&quot;quality&quot;-egenskap är bara ett enkelt exempel. Men serverfunktionen förväntar sig också att parametrar för &quot;width&quot; ska vara mer mångsidiga.

Du kan minska antalet giltiga URL-adresser genom att minska antalet möjliga väljarvärden. Du kan även göra samma sak med bredden:

quality = q-20, q-40, q-60, q-80, q-100

width = w-100, w-200, w-400, w-800, w-1000, w-1200

Alla kombinationer är nu giltiga URL:er:

```
/content/dam/flower.respi.q-40.w-200.jpg
/content/dam/flower.respi.q-60.w-400.jpg
…
```

Nu har vi redan 5x6=30 giltiga URL:er för en resurs. Varje ytterligare egenskap ökar komplexiteten. Och det kan finnas egenskaper som inte kan minskas till ett rimligt värde.

Så den här metoden har också begränsningar.

#### Oavsiktligt exponera ett API

Vad händer här? Om vi tittar noga ser vi att vi gradvis går från en statiskt renderad till en mycket dynamisk webbplats. Och vi råkar oavsiktligt stöta på ett API för bildåtergivning i kundens webbläsare, som faktiskt bara var avsett att användas av författare.

Du bör ange bildens kvalitet och storlek genom att författaren redigerar sidan. Om du har samma funktioner som en server exponeras för kan det ses som en funktion eller som en vektor för en denial of service-attack. Vad det faktiskt är beror på sammanhanget. Hur affärskritisk är webbplatsen? Hur mycket belastning finns det på servrarna? Hur mycket utrymme finns kvar? Hur mycket budget har ni för implementering? Du måste balansera dessa faktorer. Du borde vara medveten om proffsen och konerna.

## Utskriftsmönstret - besökt och rehabiliterat

### Hur Utskriftshanteraren undviker att exponera API:t

Vi fick lite misskrediter till Spooler-mönstret i det sista kapitlet. Det är dags att återupprätta det.

![](assets/chapter-1/spooler-pattern.png)

Utskriftsmönstret förhindrar problemet med att ett API som vi diskuterade i det senaste kapitlet exponeras. Egenskaperna lagras och kapslas in i komponenten. Allt vi behöver för att komma åt dessa egenskaper är sökvägen till komponenten. Vi behöver inte använda URL:en som ett fordon för att överföra parametrarna mellan markering och binär återgivning:

1. Klienten återger HTML-koden när komponenten begärs i den primära frågeslingan

2. Komponentbanan fungerar som en bakåtreferens från markeringen till komponenten

3. Webbläsaren använder den här bakåtreferensen för att begära binärfilen

4. När begäran når komponenten har vi alla egenskaper i handen för att ändra storlek på, komprimera och buffra binära data

5. Bilden överförs via komponenten till klientwebbläsaren

Utlysningsmönstret är inte så illa trots allt, det är därför det är så populärt. Om det bara är där det inte är så krångligt när det gäller cache-ogiltigförklaring...

### Den inverterade bufferten - bäst av båda världar?

Då kommer vi till frågan. Varför kan vi inte bara få det bästa av två världar? Den bra inkapslingen av buffertmönstret och de fina cachelagringsegenskaperna för en resursbaserad URL?

Vi måste erkänna att vi inte har sett det i ett verkligt direktprojekt. Men låt oss ändå våga lite tankeexperiment här - som en startpunkt för er egen lösning.

Vi kallar mönstret _Inverterad buffert_.. Den inverterade bufferthanteraren måste baseras på bildresursen för att ha alla giltiga cacheogiltighetsegenskaper.

Men den får inte visa några parametrar. Alla egenskaper ska kapslas in i komponenten. Men vi kan visa komponentbanan som en ogenomskinlig referens till egenskaperna.

Detta leder till en URL i formuläret:

`/content/dam/flower.respi3.content-mysite-home-jcrcontent-par-respi.jpg`

`/content/dam/flower` är sökvägen till bildens resurs

`.respi3` är en väljare för att välja rätt servlet för att leverera bilden

`.content-mysite-home-jcrcontent-par-respi` är ytterligare en väljare. Den kodar sökvägen till komponenten som lagrar den egenskap som krävs för bildomformningen. Väljarna är begränsade till ett mindre teckenintervall än banor. Kodningsschemat här är bara exemplariskt. &quot;/&quot; ersätts med &quot;-&quot;. Man tar inte hänsyn till att själva sökvägen också kan innehålla &quot;-&quot;. Ett mer sofistikerat kodningsschema skulle vara tillrådligt i ett verkligt exempel. Base64 ska vara ok. Men det gör felsökningen lite svårare.

`.jpg` är filsuffixet

### Slutsats

Wow... diskussionen om spooler blev längre och mer komplicerad än förväntat. Vi är skyldiga dig en ursäkt. Men vi kände att det var nödvändigt att presentera en mängd olika aspekter - bra och dåliga - så att du kan utveckla lite intuition om vad som fungerar bra i Dispatcher-land och vad som inte gör det.

## Status- och statusfilnivå

### Grunderna

#### Introduktion

Vi nämnde redan kortfattat _statfile_ före. Det är relaterat till automatisk ogiltigförklaring:

Alla cachefiler i Dispatcher-filsystemet som har konfigurerats att ogiltigförklaras automatiskt anses vara ogiltiga om deras senaste ändringsdatum är äldre än `statfile's` senast ändrat datum.

>[!NOTE]
>
>Det senaste ändringsdatumet vi talar om är den cachelagrade filen det datum då filen begärdes från klientens webbläsare och slutligen skapades i filsystemet. Det är inte `jcr:lastModified` datum för resursen.

Senaste ändringsdatum för statusfilen (`.stat`) är det datum då begäran om ogiltigförklaring från AEM togs emot på Dispatcher.

Om du har fler än en Dispatcher kan det leda till märkliga effekter. Webbläsaren kan ha en senare version av Dispatcher (om du har fler än en Dispatcher). Eller så kanske Dispatcher tror att webbläsarens version som utfärdades av den andra Dispatcher är inaktuell och i onödan skickar en ny kopia. Dessa effekter påverkar inte prestanda eller funktionskrav i någon större utsträckning. Och de kommer att jämna ut över tid när webbläsaren har den senaste versionen. Det kan dock vara lite förvirrande när du optimerar och felsöker webbläsarens cachelagring. Var så varnad.

#### Konfigurera invalideringsdomäner med /statfileslevel

När vi införde automatisk ogiltigförklaring och den status vi sa, att *alla* filer anses vara ogiltiga när någon ändring görs och att alla filer ändå är beroende av varandra.

Det är inte riktigt exakt. Vanligtvis är alla filer som delar en gemensam huvudnavigeringsrot beroende av varandra. Men en AEM kan vara värd för ett antal webbplatser - *oberoende* webbplatser. Att inte dela en gemensam navigering - faktiskt, att inte dela någonting.

Skulle det inte vara slöseri att ogiltigförklara webbplats B eftersom det är en förändring i plats A? Ja, det är det. Och det behöver inte vara så.

Med Dispatcher kan du enkelt skilja olika platser från varandra: The `statfiles-level`.

Det är ett tal som definierar från vilken nivå i filsystemet två underträd betraktas som&quot;oberoende&quot;.

Vi tittar på standardfallet där statusfilnivån är 0.

![/statfileslevel &quot;0&quot;: The_ _.stat_ _skapas i dokumentroten. Domänen för ogiltigförklaring omfattar hela installationen inklusive alla webbplatser](assets/chapter-1/statfile-level-0.png)

`/statfileslevel "0":` The `.stat` filen skapas i dokumentroten. Domänen för ogiltigförklaring omfattar hela installationen inklusive alla webbplatser.

Oavsett vilken fil som blir ogiltig visas `.stat` filen högst upp i avsändardokumentet uppdateras alltid. Så när du gör dig ogiltig `/content/site-b/home`, även alla filer i `/content/site-a` också ogiltigförklaras eftersom de nu är äldre än `.stat` i dokumentroten. Tydligen inte vad du behöver, när du gör dig ogiltig `site-b`.

I det här exemplet vill du hellre ställa in `statfileslevel` till `1`.

Om du publicerar - och därmed gör det ogiltigt `/content/site-b/home` eller någon annan resurs nedan `/content/site-b`, `.stat` filen skapades på `/content/site-b/`.

Innehåll nedan `/content/site-a/` påverkas inte. Det här innehållet skulle jämföras med `.stat` fil på `/content/site-a/`. Vi har skapat två separata invalideringsdomäner.

![En statusnivå &quot;1&quot; skapar olika ogiltiga domäner](assets/chapter-1/statfiles-level-1.png)

*En statusnivå &quot;1&quot; skapar olika ogiltiga domäner*

<br> 

Stora installationer är oftast lite mer komplicerade och djupare. Ett gemensamt system är att strukturera webbplatser efter varumärke, land och språk. I så fall kan du ange en ännu högre statusfilnivå. _1_ skulle skapa ogiltiga domäner per varumärke, _2_ per land och _3_ per språk.

### Behovet av en homogen webbplatsstruktur

Statusfilnivån används på samma sätt för alla webbplatser i din konfiguration. Därför är det nödvändigt att ha alla platser i samma struktur och börja på samma nivå.

Tänk på att ni har några varumärken i er portfolio som bara säljs på ett fåtal små marknader medan andra säljs över hela världen. De små marknaderna råkar bara ha ett lokalt språk medan det på den globala marknaden finns länder där mer än ett språk talas:

```plain
  /content/tiny-local-brand/finland/home
  /content/tiny-local-brand/finland/products
  /content/tiny-local-brand/finland/about
                              ^
                          /statfileslevel "2"
  …

  /content/tiny-local-brand/norway
  …

  /content/shiny-global-brand/canada/en
  /content/shiny-global-brand/canada/fr
  /content/shiny-global-brand/switzerland/fr
  /content/shiny-global-brand/switzerland/de
  /content/shiny-global-brand/switzerland/it
                                          ^
                                /statfileslevel "3"
  ..
```

Den första skulle kräva en `statfileslevel` av _2_, medan den senare kräver _3_.

Inte en idealisk situation. Om du ställer in den på _3_ så fungerar inte automatisk ogiltigförklaring på de mindre platserna mellan undergrenarna `/home`, `/products` och `/about`.

Ange _2_ innebär att på de större platserna deklarerar du `/canada/en` och `/canada/fr` beroende, vilket de inte är. Varje ogiltigförklaring `/en` blir också ogiltigt `/fr`. Detta leder till en något minskad cache-träff, men det är ändå bättre än att leverera inaktuellt cachelagrat innehåll.

Den bästa lösningen är naturligtvis att göra alla webbplatsers rötter lika djupa:

```
/content/tiny-local-brand/finland/fi/home
/content/tiny-local-brand/finland/fi/products
/content/tiny-local-brand/finland/fi/about
…
/content/tiny-local-brand/norway/no/home
                                 ^
                        /statfileslevel "3"
```

### Länka mellan platser

Vilken är den rätta nivån nu? Det beror på hur många beroenden du har mellan platserna. Inklusioner som du löser för återgivning av en sida betraktas som&quot;beroende&quot;. Vi har visat en sådan _inkludering_ när vi införde _Teaser_ i början av den här guiden.

_Hyperlänkar_ är en mjukare form av beroenden. Det är mycket troligt att du kommer att hyperlänka inom en webbplats.. och det är inte osannolikt att du har länkar mellan dina webbplatser. Enkla hyperlänkar skapar vanligtvis inte beroenden mellan webbplatser. Tänk bara på en extern länk som du länkar från din webbplats till facebook... Du behöver inte återge din sida om något ändras på facebook och vice versa, eller hur?

Ett beroende inträffar när du läser innehåll från den länkade resursen (t.ex. navigeringstiteln). Sådana beroenden kan undvikas om du bara förlitar dig på lokalt angivna navigeringsrubriker och inte ritar dem från målsidan (som med externa länkar).

#### Ett oväntat beroende

Det kan dock finnas en del av konfigurationen, där webbplatser - som sägs vara oberoende - samlas ihop. Låt oss titta på ett verkligt scenario som vi råkade ut för i ett av våra projekt.

Kunden hade en webbplatsstruktur som den som skissades i det sista kapitlet:

```
/content/brand/country/language
```

Till exempel,

```
/content/shiny-brand/switzerland/fr
/content/shiny-brand/switzerland/de

/content/shiny-brand/france/fr

/content/shiny-brand/germany/de
```

Varje land hade sin egen domän,

```
www.shiny-brand.ch

www.shiny-brand.fr

www.shiny-brand.de
```

Det fanns inga navigerbara länkar mellan språkwebbplatserna och inga synliga inkluderingar, så vi anger statusfilnivån till 3.

Alla webbplatser har i stort sett samma innehåll. Den enda stora skillnaden var språket.

Sökmotorer som Google kan ha samma innehåll på olika URL-adresser som &quot;bedrägligt&quot;. En användare kanske vill komma på en högre rankning eller lista oftare genom att skapa grupper med identiskt innehåll. Sökmotorer känner igen dessa försök och rangordnar sidor som är mindre än att bara återvinna innehåll.

Du kan förhindra att du blir nedrankad genom att göra det transparent, att du faktiskt har mer än en sida med samma innehåll och att du inte försöker &quot;spela&quot; systemet (se [&quot;Berätta för Google om lokaliserade versioner av er sida&quot;](https://support.google.com/webmasters/answer/189077?hl=en)) genom att ange `<link rel="alternate">` taggar till varje relaterad sida i sidhuvudsavsnittet på varje sida:

```
# URL: www.shiny-brand.fr/fr/home/produits.html

<head>

  <link rel="alternate" 
        hreflang="fr-ch" 
        href="http://www.shiny-brand.ch/fr/home/produits.html">
  <link rel="alternate" 
        hreflang="de-ch" 
        href="http://www.shiny-brand.ch/de/home/produkte.html">
  <link rel="alternate" 
        hreflang="de-de" 
        href="http://www.shiny-brand.de/de/home/produkte.html">

</head>

----

# URL www.shiny-brand.de/de/home/produkte.html

<head>

  <link rel="alternate" 
        hreflang="fr-fr" 
        href="http://www.shiny-brand.fr/fr/home/produits.html">
  <link rel="alternate" 
        hreflang="fr-ch" 
        href="http://www.shiny-brand.ch/fr/home/produits.html">
  <link rel="alternate" 
        hreflang="de-ch"
         href="http://www.shiny-brand.ch/de/home/produits.html">

</head>
```

![Länka alla mellan](assets/chapter-1/inter-linking-all.png)

*Länka alla mellan*

<br> 

En del SEO-experter hävdar till och med att detta skulle kunna överföra rykte eller&quot;länkjuice&quot; från en högt rankad webbplats på ett språk till samma webbplats på ett annat språk.

Schemat skapade inte bara ett antal länkar utan även vissa problem. Antal länkar som krävs för _p_ in _n_ språk är _p x (n<sup>2</sup>-n)_: Varje sida länkar till varandra (_n x n_) utom sig själv (_-n_). Det här schemat används för varje sida. Om vi har en liten webbplats på fyra språk med 20 sidor är varje sida _240_ länkar.

För det första vill du inte att en redigerare ska behöva underhålla länkarna manuellt - de måste genereras automatiskt av systemet.

För det andra borde de vara korrekta. När systemet identifierar en ny &quot;relativ&quot; vill du länka den från alla andra sidor med samma innehåll (men på ett annat språk).

I vårt projekt har nya relativa sidor dykt upp ofta. Men de blev inte &quot;alternativa&quot; länkar. När `de-de/produkte` sidan publicerades på den tyska webbplatsen, den var inte omedelbart synlig på de andra webbplatserna.

Anledningen var att sajterna i vår konfiguration skulle vara oberoende. En ändring på den tyska webbplatsen innebar alltså inte någon ogiltigförklaring på den franska webbplatsen.

Du vet redan hur man löser det problemet. Minska bara statusnivån till 2 för att bredda invalideringsdomänen. Det minskar förstås också cacheminnets träffgrad - särskilt när publikationer används - och därmed blir det vanligare att ogiltigförklara.

I vårt fall var det ännu mer komplicerat:

Även om vi hade samma innehåll var de faktiska namnen inte olika i de olika länderna.

`shiny-brand` anropades `marque-brillant` i Frankrike och `blitzmarke` i Tyskland:

```
/content/marque-brillant/france/fr
/content/shiny-brand/switzerland/fr
/content/shiny-brand/switzerland/de
/content/blitzmarke/germany/de
…
```

Det skulle ha varit meningen att ställa in `statfiles` nivå till 1, vilket skulle ha lett till en för stor invalideringsdomän.

Omstruktureringen av anläggningen skulle ha åtgärdat detta. Sammanfoga alla varumärken under en gemensam rot. Men vi hade inte den kapacitet som fanns på den tiden och det skulle bara ha gett oss nivå 2.

Vi bestämde oss för att hålla nivå 3 och betalade priset för att inte alltid ha uppdaterade alternativa länkar. För att mildra detta hade vi ett &quot;reaper&quot;-jobb på Dispatcher som ändå skulle rensa filer som är äldre än en vecka. Så så småningom återgavs alla sidor ändå vid något tillfälle. Men det är en kompromiss som måste avgöras individuellt i varje projekt.

## Slutsats

Vi gick igenom några grundläggande principer om hur Dispatcher fungerar i allmänhet och vi gav dig några exempel där du kanske måste göra lite mer implementeringsarbete för att få det rätt och var du kanske vill göra kompromisser.

Vi gick inte in på detaljerad information om hur detta är konfigurerat i Dispatcher. Vi ville att du skulle förstå de grundläggande begreppen och problemen först, utan att förlora dig till konsolen för tidigt. Och - det faktiska konfigurationsarbetet är väldokumenterat - om du förstår de grundläggande begreppen bör du veta vilka de olika switcharna används för.

## Tips och tricks för Dispatcher

Vi ska avsluta den första delen av denna bok med en slumpmässig samling tips och tricks som kan vara användbara i en eller annan situation. Som vi gjorde tidigare presenterar vi inte lösningen, utan idén så att du får en chans att förstå idén och konceptet och länka till artiklar som beskriver den faktiska konfigurationen mer detaljerat.

### Korrigera invalideringstider

Om du installerar en AEM-författare och publicerar direkt är topologin lite udda. Författaren skickar samtidigt innehållet till publiceringssystemen och ogiltighetsbegäran till Dispatcher. Eftersom både Publish-systemen och Dispatcher är åtskilda från Author by queues kan det vara lite olyckligt att tajmingen görs. Dispatcher kan ta emot invalideringsbegäran från författaren innan innehållet uppdateras i publiceringssystemet.

Om en kund begär det innehållet under tiden kommer Dispatcher att begära och lagra inaktuellt innehåll.

En tillförlitligare inställning skickar en begäran om ogiltigförklaring från publiceringssystemen _efter_ de har tagit emot innehållet. Artikeln &quot;[Invaliderar Dispatcher Cache från en publiceringsinstans](https://helpx.adobe.com/experience-manager/dispatcher/using/page-invalidate.html#InvalidatingDispatcherCachefromaPublishingInstance)&quot; beskriver detaljerna.

**Referenser**

[helpx.adobe.com - Invaliderar Dispatcher Cache från en Publishing-instans](https://helpx.adobe.com/experience-manager/dispatcher/using/page-invalidate.html#InvalidatingDispatcherCachefromaPublishingInstance)

### HTTP Header and Header Caching

På den gamla tiden lagrade Dispatcher bara oformaterade filer i filsystemet. Om du behövde HTTP-headers för att kunna levereras till kunden gjorde du det genom att konfigurera Apache baserat på den lilla information du hade från filen eller platsen. Det var särskilt irriterande när du implementerade ett webbprogram i AEM som var starkt beroende av HTTP-huvuden. Allt fungerade bra i den AEM förekomsten, men inte när du använde en Dispatcher.

Vanligtvis började du återanvända de saknade rubrikerna på resurserna på Apache-servern med `mod_headers` genom att använda information som kan härledas av resurssökvägen och suffixet. Men det var inte alltid tillräckligt.

Särskilt irriterande var att även med Dispatcher var det första _ocachelagrad_ svar på webbläsaren kom från publiceringssystemet med ett stort antal rubriker, medan de efterföljande svaren genererades av Dispatcher med en begränsad uppsättning rubriker.

Från och med Dispatcher 4.1.11 kan Dispatcher lagra rubriker som genererats av Publish-systemen.

På så sätt slipper du duplicera rubriklogik i Dispatcher och frigör den fulla uttryckskraften i HTTP och AEM.

**Referenser**

* [helpx.adobe.com - Caching Response Headers](https://helpx.adobe.com/experience-manager/kb/dispatcher-cache-response-headers.html)

### Undantag för enskild cachelagring

Du kanske vill cachelagra alla sidor och bilder i allmänhet, men under vissa omständigheter bör du göra ett undantag. Du vill till exempel cachelagra PNG-bilder, men inte PNG-bilder som visar en captcha (som kan ändras vid varje begäran). Dispatcher kanske inte känner igen en captcha som en captcha.. men det gör AEM. Den kan be Dispatcher att inte cachelagra en begäran genom att skicka en rubrik tillsammans med svaret:

```plain
  response.setHeader("Dispatcher", "no-cache");

  response.setHeader("Cache-Control: no-cache");

  response.setHeader("Cache-Control: private");

  response.setHeader("Pragma: no-cache");
```

Cache-Control och Pragma är officiella HTTP-headers, som sprids till och tolkas av övre cachelagringslager, till exempel ett CDN. The `Dispatcher` -huvudet är bara ett tips för Dispatcher att inte cachelagra. Den kan användas för att ange att Dispatcher inte ska cachelagra, samtidigt som de övre cachelagringslagren fortfarande tillåts göra det. Det är faktiskt svårt att hitta ett fall där det kan vara användbart. Men vi är säkra på att det finns några, någonstans.

**Referenser**

* [Dispatcher - ingen cache](https://helpx.adobe.com/experience-manager/kb/DispatcherNoCache.html)

### Webbläsarcachelagring

Det snabbaste http-svaret är det svar som webbläsaren själv ger. Där begäran och svaret inte behöver resa över ett nätverk till en webbserver under hög belastning.

Du kan hjälpa webbläsaren att bestämma när servern ska fråga efter en ny version av filen genom att ange ett förfallodatum för en resurs.

Vanligtvis gör du det statiskt med Apache `mod_expires` eller genom att lagra rubriken Cache-Control och Expires som kommer från AEM om du behöver en mer individuell kontroll.

Ett cachelagrat dokument i webbläsaren kan ha tre nivåer av aktuell information.

1. _Garanterad färsk_ - Webbläsaren kan använda det cachelagrade dokumentet.

2. _Potentiellt stale_ - Webbläsaren bör fråga servern först om det cachelagrade dokumentet fortfarande är uppdaterat.

3. _Inaktuell_ - Webbläsaren måste be servern om en ny version.

Det första garanteras av det förfallodatum som servern har angett. Om en resurs inte har gått ut behöver du inte fråga servern igen.

Om dokumentet har nått sitt förfallodatum kan det fortfarande vara aktuellt. Förfallodatumet anges när dokumentet levereras. Men ofta vet man inte i förväg när nytt innehåll är tillgängligt - så detta är bara en konservativ uppskattning.

Om du vill avgöra om dokumentet i webbläsarens cache fortfarande är detsamma som det skulle vara när en ny begäran skickades kan webbläsaren använda `Last-Modified` dokumentets datum. Webbläsaren frågar servern:

&quot;_Jag har en version från den 10 juni ... behöver jag en uppdatering?_&quot; Och servern kan antingen svara med

&quot;_304 - Din version är fortfarande uppdaterad_&quot; utan att överföra resursen igen, eller så kunde servern svara med

&quot;_200 - här är en nyare version_&quot; i HTTP-huvudet och det senaste innehållet i HTTP-brödtexten.

För att få den andra delen att fungera måste du skicka `Last-Modified` datum till webbläsaren så att den har en referenspunkt att be om uppdateringar.

Vi förklarade tidigare att när `Last-Modified` datumet genereras av Dispatcher, det kan variera mellan olika begäranden eftersom den cachelagrade filen - och dess datum - genereras när filen begärs av webbläsaren. Ett alternativ är att använda &quot;e-taggar&quot; - det är tal som identifierar det faktiska innehållet (t.ex. genom att generera en hash-kod) i stället för ett datum.

&quot;[Stöd för taggar](https://adobe-consulting-services.github.io/acs-aem-commons/features/etag/index.html)&quot; från _ACS-kommandopaket_ använder den här metoden. Men det här kostar: Eftersom e-taggen måste skickas som en rubrik, men beräkningen av hash-koden kräver att svaret läses fullständigt, måste svaret buffras helt i huvudminnet innan det kan levereras. Detta kan påverka fördröjningen negativt när det är mer sannolikt att din webbplats har ocachelagrade resurser och du måste naturligtvis hålla ett öga på det minne som AEM använder.

Om du använder URL-fingeravtryck kan du ange mycket långa förfallodatum. Du kan cachelagra fingeravtrycksresurser för gott i webbläsaren. En ny version är markerad med en ny URL och äldre versioner behöver aldrig uppdateras.

Vi använde URL-fingeravtryck när vi introducerade buffertmönstret. Statiska filer från `/etc/design` (CSS, JS) ändras sällan, vilket även gör dem bra att använda som fingeravtryck.

För vanliga filer skapar vi vanligtvis ett fast schema, som att kontrollera HTML var 30:e minut, bilder var 4:e timme och så vidare.

Webbläsarcachelagring är mycket användbart i redigeringssystemet. Du vill cacha så mycket du kan i webbläsaren för att förbättra redigeringsupplevelsen. Tyvärr är de dyraste resurserna, HTML-sidorna kan inte cachelagras.. de ska ändras ofta på författaren.

Granitbiblioteken, som utgör AEM, kan cachas under en hel del tid. Du kan även cachelagra platsens statiska filer (teckensnitt, CSS och JavaScript) i webbläsaren. Jämna bilder i `/content/dam` kan vanligtvis cachas i cirka 15 minuter eftersom de inte ändras lika ofta som kopieringstext på sidorna. Bilder redigeras inte interaktivt i AEM. De redigeras och godkänns först, innan de överförs till AEM. Du kan alltså anta att de inte ändras lika ofta som text.

När du cachelagrar gränssnittsfiler kan platsens biblioteksfiler och bilder göra att det går betydligt snabbare att läsa in sidor när du är i redigeringsläge.



**Referenser**

*[developer.mozilla.org - Caching](https://developer.mozilla.org/en-US/docs/Web/HTTP/Caching)

* [apache.org - Mod Expires](https://httpd.apache.org/docs/current/mod/mod_expires.html)

* [ACS-kommandon - Etag-stöd](https://adobe-consulting-services.github.io/acs-aem-commons/features/etag/index.html)

### Trunkerar URL:er

Dina resurser lagras under

`/content/brand/country/language/…`

Men det här är förstås inte den URL som du vill visa för kunden. Av estetiska skäl, läsbarhets- och SEO-skäl kanske du vill korta av den del som redan finns representerad i domännamnet.

Om du har en domän

`www.shiny-brand.fi`

Det finns oftast inget behov av att sätta varumärket och landet i vägen. I stället för

`www.shiny-brand.fi/content/shiny-brand/finland/fi/home.html`

du skulle vilja ha,

`www.shiny-brand.fi/home.html`

Du måste implementera mappningen på AEM eftersom AEM behöver veta hur länkar ska återges enligt det trunkerade formatet.

Men lita inte bara på AEM. Om du gör det har du banor som `/home.html` i cachens rotkatalog. Är det där &quot;hem&quot; till Finish, tyskan eller Kanadas webbplats? Och om det finns en fil `/home.html` i Dispatcher, hur vet Dispatcher att detta måste ogiltigförklaras när en invaliditetsbegäran om `/content/brand/fi/fi/home` kommer in.

Vi har sett ett projekt med separata dokument för varje domän. Det var en mardröm att felsöka och underhålla - och vi såg faktiskt aldrig den felfritt.

Vi kan lösa problemen genom att strukturera om cachen. Vi hade en enda dokumentrot för alla domäner, och ogiltigförklaringsbegäranden kunde hanteras 1:1 eftersom alla filer på servern började med `/content`.

Den trunkerande delen var också mycket enkel.  AEM genererade trunkerade länkar på grund av en konfiguration i `/etc/map`.

Nu när en förfrågan `/home.html` klickar på Dispatcher, det första som händer är att tillämpa en omskrivningsregel som utökar sökvägen internt.

Den regeln konfigurerades statiskt i varje värdkonfiguration. Kort sagt, reglerna såg ut så här,

```plain
  # vhost www.shiny-brand.fi

  RewriteRule "^(.\*\.html)" "/content/shiny-brand/finland/fi/$1"
```

I filsystemet har vi nu en `/content`-baserade sökvägar som också finns i författaren och publiceringen - vilket har varit till stor hjälp vid felsökningen. För att inte tala om korrekt ogiltigförklaring - det var inte längre något problem.

Observera att vi bara gjorde det för &quot;synliga&quot; URL:er, URL:er som visas i webbläsarens URL-plats. URL:er för bilder var till exempel fortfarande rena &quot;/content&quot;-URL:er. Vi anser att det räcker att förfina&quot;huvud&quot;-URL:en för att optimera sökmotorn.

Att ha ett gemensamt dokument hade också en annan bra funktion. När något gick fel i Dispatcher kunde vi rensa hela cachen genom att köra

`rm -rf /cache/dispatcher/*`

(något du kanske inte vill göra vid höga belastningstoppar).

**Referenser**

* [apache.org - skriv om metod](https://httpd.apache.org/docs/2.4/mod/mod_rewrite.html)

* [helpx.adobe.com - Resursmappning](https://helpx.adobe.com/experience-manager/6-4/sites/deploying/using/resource-mapping.html)

### Felhantering

I AEM klasser får du lära dig att programmera en felhanterare i Sling. Detta skiljer sig inte så mycket från att skriva en vanlig mall. Du skriver bara en mall i JSP eller HTML, eller hur?

Ja, men det här är bara AEM. Kom ihåg - Dispatcher cachelagrar inte `404 – not found` eller `500 – internal server error` svar.

Om du återger de här sidorna dynamiskt i varje (misslyckad) begäran kommer du att få en onödig hög belastning på publiceringssystemen.

Det vi tyckte var användbart är att inte återge hela felsidan när ett fel inträffar, utan bara en superförenklad och liten - till och med statisk version av den sidan, utan några utsmyckningar eller logik.

Detta är förstås inte vad kunden såg. I Dispatcher registrerade vi `ErrorDocuments` gilla so:

```
ErrorDocument 404 "/content/shiny-brand/fi/fi/edocs/error-404.html"
ErrorDocument 500 "/content/shiny-brand/fi/fi/edocs/error-500.html"
```

Nu kan AEM bara meddela Dispatcher att något var fel och Dispatcher kan leverera en blankt och tilltalande version av feldokumentet.

Två saker bör noteras här.

Först `error-404.html` alltid är samma sida. Det finns alltså inget personligt meddelande som &quot;Din sökning efter&quot;_lagring_&quot; gav inget resultat&quot;. Vi kunde lätt leva med det där.

För det andra.. Om vi ser ett internt serverfel - eller ännu värre om vi stöter på ett avbrott i AEM system, finns det inget sätt att be AEM att återge en felsida, eller hur? Nödvändig efterföljande begäran enligt definitionen i `ErrorDocument` direktivet skulle också misslyckas. Vi arbetade runt problemet genom att köra ett cron-job som regelbundet skulle hämta felsidorna från sina definierade platser via `wget` och lagra dem på statiska filplatser som definieras i `ErrorDocuments` -direktivet.

**Referenser**

* [apache.org - anpassade feldokument](https://httpd.apache.org/docs/2.4/custom-error.html)

### Cachelagra skyddat innehåll

Dispatcher kontrollerar inte behörigheter när en resurs levereras som standard. Den implementeras så här med syftet - för att påskynda er offentliga webbplats. Om du vill skydda vissa resurser genom att logga in har du i princip tre alternativ:

1. Protect resursen innan begäran når cacheminnet, dvs. av en SSO-gateway (Single Sign On) framför Dispatcher, eller som en modul i Apache-servern

2. Undvik att cachelagra känsliga resurser och betjäna dem därför alltid direkt från publiceringssystemet.

3. Använd behörighetskänslig cachelagring i Dispatcher

Och du kan förstås välja en egen blandning av alla tre metoderna.

**Alternativ 1**. Din organisation kan använda en SSO-gateway i alla fall. Om åtkomstschemat är mycket grovt kornigt kanske du inte behöver information från AEM för att avgöra om du ska bevilja eller neka åtkomst till en resurs.

>[!NOTE]
>
>Det här mönstret kräver en _Gateway_ att _spärrar_ varje begäran och utför de faktiska _auktorisation_ - att bevilja eller neka förfrågningar till Dispatcher. Om SSO-systemet är en _autentiserare_, som bara fastställer identiteten för en användare som du måste implementera alternativ 3. Om du läser termer som &quot;SAML&quot; eller &quot;OAauth&quot; i SSO-systemets handbok är det en stark indikator på att du måste implementera alternativ 3.


**Alternativ 2**. &quot;Att inte cacha&quot; är vanligtvis en dålig idé. Om du gör det ska du se till att mängden trafik och antalet känsliga resurser som är undantagna är små. Eller se till att du har ett visst minnescache i publiceringssystemet installerat, att publiceringssystemen kan hantera den resulterande belastningen - mer därtill i del III i den här serien.

**Alternativ 3**. &quot;Behörighetskänslig cachning&quot; är ett intressant tillvägagångssätt. Dispatcher cachelagrar en resurs, men innan den levereras blir AEM om den kan göra det. Detta skapar en extra begäran från Dispatcher till Publish (Publicera), men medför vanligtvis att Publish-systemet inte kan återge en sida om den redan är cache-lagrad. Den här metoden kräver dock en viss anpassad implementering. Mer information finns här i artikeln [Behörighetskänslig cachelagring](https://helpx.adobe.com/experience-manager/dispatcher/using/permissions-cache.html).

**Referenser**

* [helpx.adobe.com - Behörighetskänslig cachelagring](https://helpx.adobe.com/experience-manager/dispatcher/using/permissions-cache.html)

### Ange respitperiod

Om du ofta gör dig ogiltig i en kort följd, t.ex. genom en trädaktivering eller helt enkelt behöver hålla innehållet uppdaterat, kan det hända att du hela tiden tömmer cachen och att besökarna nästan alltid stöter på ett tomt cacheminne.

Diagrammet nedan visar en möjlig tidpunkt för åtkomst till en enstaka sida.  Problemet blir förstås värre när antalet olika sidor som efterfrågas blir större.

![Vanliga aktiveringar som leder till ogiltig cache för större delen av tiden](assets/chapter-1/frequent-activations.png)

*Vanliga aktiveringar som leder till ogiltig cache för större delen av tiden*

<br> 

För att minska problemet med den här &quot;cache invalidation storm&quot; som den ibland kallas, kan du vara mindre sträng med `statfile` tolkning.

Du kan ange att Dispatcher ska använda en `grace period` för automatisk ogiltigförklaring. Detta skulle lägga till extra tid internt i `statfiles` ändringsdatum.

Säg: `statfile` har en ändringstid på idag kl. 12:00 och `gracePeriod` är inställt på 2 minuter. Därefter betraktas alla automatiskt ogiltigförklarade filer som giltiga kl. 12:01 och kl. 12:02. De återges efter 12:02.

Referenskonfigurationen föreslår en `gracePeriod` av två minuter av goda skäl. Du kanske tror &quot;Två minuter? Det är nästan ingenting. Jag kan enkelt vänta i 10 minuter på att innehållet ska visas ...&quot;.  Så du kan vara frestad att ange en längre period, till exempel tio minuter, under förutsättning att ditt innehåll visas minst efter dessa tio minuter.

>[!WARNING]
>
>Så är det inte `gracePeriod` arbetar. Respitperioden är _not_ den tid efter vilken det garanteras att ett dokument ogiltigförklaras, men en tidsram inte ogiltigförklaras. Varje efterföljande ogiltigförklaring som faller inom den här bildrutan _förlängningar_ tidsramen - detta kan vara oändligt långt.

Låt oss illustrera hur `gracePeriod` arbetar faktiskt med ett exempel:

Anta att du driver en mediewebbplats och att din redigeringspersonal tillhandahåller regelbundna innehållsuppdateringar var femte minut. Tänk på att du anger värdet 5 minuter för GracePeriod.

Vi börjar med ett kort exempel kl. 12.00.

12:00 - Statfile är inställd på 12:00. Alla cachelagrade filer anses vara giltiga till kl. 12.05.

12:01 - En ogiltigförklaring inträffar. Detta förlänger hastighetstiden till 12:06

12:05 - en annan redigerare publicerar artikeln - som förlänger fristen med en annan GracePeriod till 12:10.

Och så vidare ... innehållet blir aldrig ogiltigt. Varje ogiltigförklaring *inom* respitperioden förlänger respittiden. The `gracePeriod` är utformat för att vädja invalideringsstormen.. men du måste gå ut i regnet så småningom.. så håll kvar `gracePeriod` avsevärt kort för att förhindra att man gömmer sig i skyddsrummet för evigt.

#### A Deterministisk giltighetsperiod

Vi skulle vilja presentera en annan idé om hur du kan vädja en invalideringsstorm. Det är bara en idé. Vi har inte testat det i produktion, men vi tyckte att konceptet var intressant nog att dela idén med dig.

The `gracePeriod` kan bli oförutsägbart lång om det normala replikeringsintervallet är kortare än `gracePeriod`.

Den alternativa idén är följande: Gör bara fasta tidsintervall ogiltiga. Tiden däremellan innebär alltid att gammalt innehåll hanteras. Invalidering kommer så småningom att ske, men ett antal ogiltigförklaringar samlas in till en&quot;massogiltigförklaring&quot;, så att Dispatcher kan leverera visst cachelagrat innehåll under tiden och ge publiceringssystemet lite andningskapacitet.

Implementeringen skulle se ut så här:

Du använder ett anpassat valideringsskript (se referens) som körs efter att ogiltigförklaringen inträffade. Skriptet skulle läsa `statfile's` det senaste ändringsdatumet och avrunda det till nästa intervallstopp. Unix-kommando `touch --time`, låt oss ange en tid.

Om du t.ex. anger respitperioden till 30 sek, kommer Dispatcher att avrunda det senast ändrade datumet för statusfilen till nästa 30 sek. Invaliderade begäranden som inträffar mellan bara inställda på samma nästa fullständiga 30 sek.

![Om du skjuter upp ogiltigförklaringen till nästa fullständiga 30-sekunders ökning av träfffrekvensen.](assets/chapter-1/postponing-the-invalidation.png)

*Om du skjuter upp ogiltigförklaringen till nästa fullständiga 30-sekunders ökning av träfffrekvensen.*

<br> 

Cacheträffarna som inträffar mellan invalideringsbegäran och nästa runda 30 sek-fack anses sedan vara inaktuella. Det fanns en uppdatering för Publish - men Dispatcher visar fortfarande gammalt innehåll.

Detta tillvägagångssätt skulle kunna hjälpa till att definiera längre fristen utan att behöva oroa sig för att efterföljande förfrågningar förlänger perioden obestämt. Fast som vi sa förut - är det bara en idé och vi hade inte chansen att testa den.

**Referenser**

[helpx.adobe.com - Dispatcher Configuration](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html)

### Automatisk återhämtning

Platsen har ett särskilt åtkomstmönster. Du har en hög belastning av inkommande trafik och större delen av trafiken är koncentrerad till en liten del av dina sidor. Hemsidan, era kampanjlandningssidor och era mest aktuella produktinformationssidor får 90 % av trafiken. Eller om du använder en ny plats har de nyare artiklarna högre trafik jämfört med äldre.

Nu är det mycket troligt att dessa sidor cachelagras i Dispatcher eftersom de begärs så ofta.

En godtycklig begäran om ogiltigförklaring skickas till Dispatcher, vilket gör att alla sidor, inklusive den mest populära, ogiltigförklaras.

Eftersom dessa sidor är så populära finns det nya inkommande förfrågningar från olika webbläsare. Låt oss ta hemsidan som exempel.

Eftersom cacheminnet nu är ogiltigt vidarebefordras alla begäranden till startsidan som kommer in samtidigt till publiceringssystemet och genererar en hög belastning.

![Parallella begäranden till samma resurs på tom cache: Begäranden vidarebefordras till Publicera](assets/chapter-1/parallel-requests.png)

*Parallella begäranden till samma resurs på tom cache: Begäranden vidarebefordras till Publicera*

Med automatisk omhämtning kan du i viss utsträckning minska detta. De flesta ogiltiga sidor lagras fortfarande fysiskt på Dispatcher efter automatisk ogiltigförklaring. De är bara _övervägd_ föråldrad. _Automatisk uppdatering_ innebär att du fortfarande kan skicka de här inaktuella sidorna några sekunder medan du initierar _en_ begära att publiceringssystemet hämtar det inaktuella innehållet igen:

![Leverera gammalt innehåll samtidigt som det hämtas i bakgrunden igen](assets/chapter-1/fetching-background.png)

*Leverera gammalt innehåll samtidigt som det hämtas i bakgrunden igen*

<br> 

Om du vill aktivera omhämtning måste du tala om för Dispatcher vilka resurser som ska hämtas igen efter en automatisk ogiltigförklaring. Kom ihåg att alla sidor som du aktiverar automatiskt gör alla andra sidor ogiltiga, även de som är populära.

Att hämta igen innebär i själva verket att du måste berätta för Dispatcher i varje (!) ogiltigförklaring begär att du vill hämta in de populäraste igen - och vilka de populäraste är.

Detta uppnås genom att en lista med resurs-URL:er (faktiska URL:er - inte bara sökvägar) läggs till i texten för ogiltigförklaringsbegäranden:

```
POST /dispatcher/invalidate.cache HTTP/1.1

CQ-Action: Activate
CQ-Handle: /content/my-brand/home/path/to/some/resource
Content-Type: Text/Plain
Content-Length: 207

/content/my-brand/home.html
/content/my-brand/campaigns/landing-page-1.html
/content/my-brand/campaigns/landing-page-2.html
/content/my-brand/products/product-1.html
/content/my-brand/products/product-2.html
```

När Dispatcher ser en sådan begäran, utlöser den automatiskt ogiltigförklaring som vanligt och skickar omedelbart in begäranden om att hämta nytt innehåll från publiceringssystemet.

Eftersom vi nu använder en begärandetext måste vi också ange innehållstyp och innehållslängd enligt HTTP-standarden.

Dispatcher markerar också URL:erna internt så att de vet att de kan leverera dessa resurser direkt även om de betraktas som ogiltiga av automatisk ogiltigförklaring.

Alla listade URL:er begärs en i taget. Du behöver alltså inte bekymra dig om att skapa för hög belastning på publiceringssystemen. Men du vill inte heller lägga in för många URL:er i listan. Till slut måste kön bearbetas så småningom inom en begränsad tid för att inte gammalt innehåll ska spelas upp för länge. Lägg bara in de 10 mest använda sidorna.

Om du tittar in i Dispatchers cachekatalog ser du tillfälliga filer markerade med tidsstämplar. Detta är de filer som för närvarande läses in i bakgrunden.

**Referenser**

[helpx.adobe.com - Cachelagrade sidor från AEM valideras](https://helpx.adobe.com/experience-manager/dispatcher/using/page-invalidate.html)

### Shielding the Publish System

Dispatcher ger lite extra säkerhet genom att skydda Publish-systemet från begäranden som bara är avsedda för underhåll. Du vill till exempel inte visa dig `/crx/de` eller `/system/console` URL:er till allmänheten.

Det skadar inte att ha en brandvägg för ett webbprogram (WAF) installerad i datorn. Men det ökar budgeten avsevärt och inte alla projekt befinner sig i en situation där de har råd och - för att inte glömma det - driver och underhåller en WAF.

Det vi ofta ser är en uppsättning regler för Apache-omskrivning i Dispatcher-konfigurationen som förhindrar åtkomst till de mer sårbara resurserna.

Men du kan också tänka dig ett annat tillvägagångssätt:

Enligt Dispatcher-konfigurationen är Dispatcher-modulen bunden till en viss katalog:

```
<Directory />
  SetHandler dispatcher-handler
  …
</Directory>
```

Men varför binda hanteraren till hela dokumentroten när du behöver filtrera nedåt efteråt?

Du kan begränsa bindningen för hanteraren från början. `SetHandler` bara binder en hanterare till en katalog, du kan binda hanteraren till en URL eller till ett URL-mönster:

```
<LocationMatch "^(/content|/etc/design|/dispatcher/invalidate.cache)/.\*">
  SetHandler dispatcher-handler
</LocationMatch>

<LocationMatch "^/dispatcher/invalidate.cache">
  SetHandler dispatcher-handler
</LocationMatch>

…
```

Om du gör det ska du inte glömma att alltid binda dispatcher-hanteraren till Dispatcher-hanterarens invalidation URL (invalideringsURL), annars kan du inte skicka invalideringsbegäranden från AEM till Dispatcher.

Ett annat sätt att använda Dispatcher som filter är att ställa in filterdirektiv i `dispatcher.any`

```
/filter {
  /0001  { /glob "\*" /type "deny" }
  /0002  { /type "allow"  /url "/content\*"  }
```

Vi kräver inte att ett direktiv används framför ett annat, utan vi rekommenderar en lämplig blandning av alla direktiv.

Men vi föreslår att du ska överväga att begränsa URL-utrymmet så tidigt som möjligt i kedjan, så mycket du behöver, och göra det på ett så enkelt sätt som möjligt. Tänk fortfarande på att dessa tekniker inte ersätter en WAF-fil på mycket känsliga webbplatser. En del människor kallar teknikerna &quot;Stackars mans brandvägg&quot; av en anledning.

**Referenser**

[apache.org-sethandler, direktiv](https://httpd.apache.org/docs/2.4/mod/core.html#sethandler)

[helpx.adobe.com - Konfigurera åtkomst till innehållsfilter](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html#ConfiguringAccesstoContentfilter)

### Filtrera med reguljära uttryck och glober

På den tidiga tiden kunde du bara använda &quot;globs&quot; - enkla platshållare för att definiera filter i Dispatcher-konfigurationen.

Som tur är har det ändrats i de senare versionerna av Dispatcher. Nu kan du även använda reguljära uttryck för POSIX och komma åt olika delar av en begäran för att definiera ett filter. För någon som just har börjat med Dispatcher som kan tas för givet. Men om du bara är van vid glober är det en överraskning och kan lätt förbises. Förutom syntaxen för glober och regex är den för likartad. Låt oss jämföra två versioner som gör samma sak:

```
# Version A

/filter {
  /0001  { /glob "\*" /type "deny" }
  /0002  { /type "allow"  /url "/content\*"  }

# Version B

/filter {
  /0001  { /glob "\*" /type "deny" }
  /0002  { /type "allow"  /url '/content.\*'  }
```

Ser du skillnaden?

Version B använder enkla citattecken `'` för att markera _reguljärt uttrycksmönster_. &quot;Valfritt tecken&quot; uttrycks med `.*`.

_Globbningsmönster_, i motsats till dubbla citattecken `"` och du kan bara använda enkla platshållare som `*`.

Om du vet den skillnaden är den enkel - men om du inte vet det kan du enkelt blanda ihop citattecknen och lägga en solig eftermiddag på att felsöka konfigurationen. Nu varnas du.

&quot;Jag känner igen `'/url'` i konfigurationen ... Men vad är det? `'/glob'` i filtret du frågar?

Det direktivet representerar hela begärandesträngen, inklusive metoden och sökvägen. Det kan stå för

`"GET /content/foo/bar.html HTTP/1.1"`

det här är strängen som mönstret ska jämföras med. Nybörjare brukar glömma den första delen, `method` (GET, POST, ...). Så ett mönster

`/0002  { /glob "/content/\*" /type "allow" }`

Misslyckas alltid eftersom &quot;/content&quot; inte matchar &quot;GET ..&quot; om begäran.

Så när du vill använda Globs

`/0002  { /glob "GET /content/\*" /type "allow" }`

skulle ha rätt.

För en inledande nekanderegel, som

`/0001  { /glob "\*" /type "deny" }`

Det här är bra. Men för den efterföljande metoden är det bättre och tydligare och mer uttrycksfullt och säkrare att använda de enskilda delarna i en begäran:

```
/method
/url
/path
/selector
/extension
/suffix
```

Så här:

```
/005  {

  /type "allow"
  /method "GET"
  /extension '(css|gif|ico|js|png|swf|jpe?g)' }
```

Observera att du kan blanda regex- och glob-uttryck i en regel.

Ett sista ord om &quot;radnummer&quot; som `/005` framför varje definition,

De har ingen mening alls! Du kan välja valfria nämnare för regler. Att använda siffror kräver inte särskilt mycket arbete, men tänk på att ordningen är viktig.

Om du har hundratals regler som så:

```
/001
/002
/003
…
/100
…
```

och du vill infoga ett mellan /001 och /002 vad händer med de följande siffrorna? Ökar du deras antal? Infogar du mellantal?

```
/001
/001a
/002
/003
…
/100
…
```

Eller vad händer om du ändrar till omordning /003 och /001 kommer du att ändra namnen och deras identiteter eller är du

```
/003
/002
/001
…
/100
…
```

Numrering, som i första hand verkar vara ett enkelt val, når sin gräns i längden. Ärligt talat är det ändå inte bra att välja tal som identifierare.

Vi vill föreslå ett annat tillvägagångssätt: Troligen kommer du inte att hitta meningsfulla identifierare för varje enskild filterregel. Men de har antagligen ett större syfte, så de kan grupperas på olika sätt beroende på det syftet. Exempel: &quot;grundläggande konfiguration&quot;, &quot;programspecifika undantag&quot;, &quot;globala undantag&quot; och &quot;säkerhet&quot;.

Du kan sedan namnge och gruppera reglerna utifrån detta och ange läsaren för konfigurationen (din kära kollega), en viss orientering i filen:

```plain
  # basic setup:

  /filter {

    # basic setup

    /basic_01  { /glob "\*"             /type "deny"  }
    /basic_02  { /glob "/content/\*"    /type "allow" }
    /basic_03  { /glob "/etc/design/\*" /type "allow" }

    /basic_04  { /extension '(json|xml)'  /type "deny"  }
    …


    # login

    /login_01 { /glob "/api/myapp/login/\*" /type "allow" }
    /login_02 { … }

    # global exceptions

    /global_01 { /method "POST" /url '.\*contact-form.html' }
```


Troligen kommer du att lägga till en ny regel i en av grupperna - eller kanske till och med skapa en ny grupp. I så fall är antalet objekt som ska namnändras/numreras om begränsat till den gruppen.

>[!WARNING]
>
>Mer sofistikerade inställningar delar upp filtreringsregler i ett antal filer som inkluderas av huvudfilen `dispatcher.any` konfigurationsfil. En ny fil innehåller dock inte något nytt namnutrymme. Om du har regeln &quot;001&quot; i en fil och &quot;001&quot; i en annan får du ett felmeddelande. Ännu fler skäl att komma på semantiskt starka namn.

**Referenser**

[helpx.adobe.com - Designing Patterns for glob Properties](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html#DesigningPatternsforglobProperties)

### Protokollspecifikation

Det sista tipset är inget riktigt tips, men vi kände att det var värt att dela det med dig i alla fall.

AEM och Dispatcher fungerar oftast som de ska. Därför kommer du inte att hitta någon omfattande Dispatcher-protokollspecifikation om invalidation-protokollet för att kunna skapa ditt eget program överst. Informationen är offentlig, men är lite spridd över ett antal resurser.

Vi försöker fylla gapet i viss utsträckning här. Så här ser en ogiltigförklaring ut:

```
POST /dispatcher/invalidate.cache HTTP/1.1
CQ-Action: <action>
CQ-Handle: <path-pattern>
[CQ-Action-Scope]
[Content-Type: Text/Plain]
[Content-Length: <bytes in request body>]

<newline>

<refetch-url-1>
<refetch-url-2>

…

<refetch-url-n>
```

`POST /dispatcher/invalidate.cache HTTP/1.1` - Den första raden är URL:en för kontrollslutpunkten Dispatcher och du kommer troligen inte att ändra den.

`CQ-Action: <action>` - Vad som ska hända. `<action>` antingen:

* `Activate:` delete `/path-pattern.*`
* `Deactive:` delete `/path-pattern.*`
OCH ta bort `/path-pattern/*`
* `Delete:`   delete `/path-pattern.*`
OCH ta bort 
`/path-pattern/*`
* `Test:`   Returnera&quot;ok&quot;, men gör ingenting

`CQ-Handle: <path-pattern>` - Den innehållsresurssökväg som ska ogiltigförklaras. Obs! `<path-pattern>` är i själva verket en&quot;bana&quot; och inte ett&quot;mönster&quot;.

`CQ-Action-Scope: ResourceOnly` - Valfritt: Om rubriken är inställd visas `.stat` filen inte rörs.

```
[Content-Type: Text/Plain]
[Content-Length: <bytes in request body>]
```

Ange de här rubrikerna om du definierar en lista med automatisk uppdatering av URL:er. `<bytes in request body>` är antalet tecken i HTTP-texten

`<newline>` - Om du har en begärandetext måste den separeras från rubriken med en tom rad.

```
<refetch-url-1>
<refetch-url-2>
…
<refetch-url-n>
```

Ange de URL:er som du vill hämta omedelbart efter ogiltigförklaringen.

## Ytterligare resurser

En bra översikt och introduktion till Dispatcher-cachning: [https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher.html](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher.html)

Dokumentation till Dispatcher med alla direktiv: [https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html)

Frågor och svar: [https://helpx.adobe.com/experience-manager/using/dispatcher-faq.html](https://helpx.adobe.com/experience-manager/using/dispatcher-faq.html)

Inspelning av ett webbinarium om Dispatcher-optimering - rekommenderas: [https://my.adobeconnect.com/p7th2gf8k43?proto=true](https://my.adobeconnect.com/p7th2gf8k43?proto=true)

Presentationen&quot;The underskattad power of content invalidation&quot;,&quot;customiTo()&quot;, konferensen i Potsdam 2018 [https://adapt.to/2018/en/schedule/the-underappreciated-power-of-content-invalidation.html](https://adapt.to/2018/en/schedule/the-underappreciated-power-of-content-invalidation.html)

Ogiltiga cachelagrade sidor från AEM: [https://helpx.adobe.com/experience-manager/dispatcher/using/page-invalidate.html](https://helpx.adobe.com/experience-manager/dispatcher/using/page-invalidate.html)

## Nästa steg

* [2 - Infrastrukturmönster](chapter-2.md)
