---
title: Webbplatshierarki, taxonomi och taggningstips
seo-title: Overview of Authoring in AEM Sites
description: I följande video visas en översikt över grundläggande redigeringsbegrepp i en AEM författarmiljö. Den använder platskonsolen som grund.
seo-description: The following video provides an overview of basic concepts of authoring in an AEM author environment. It uses the Sites console as a basis.
feature: Page Editor, Editable Templates
topics: authoring, publishing
audience: author, marketer
doc-type: feature video
activity: use
version: 6.4, 6.5, Cloud Service
kt: 4242
thumbnail: 33594.jpg
topic: Content Management
role: User
level: Beginner
hide: true
hidefromtoc: true
source-git-commit: 3335069883db38a2748af114ab7505cc34dec270
workflow-type: tm+mt
source-wordcount: '2033'
ht-degree: 0%

---


# Metadata och taggar: Sammanfattning på hög nivå

Metadata och taggar är avgörande för att öka effektiviteten i AEM. Användare, chefer och chefer inser att det finns ett behov av en holistisk strategi, men de tycker att det är svårt att göra framsteg. Kunskaperna är ofta isolerade bland användarna, vilket gör en holistisk strategi svår - och gör justeringarna ännu mer problematiska.

Vad är skillnaden mellan metadata och taggar? Vilka affärsaspekter ska beaktas när er strategi utvecklas?

## Vad är syftet med metadata?

Metadata lägger till struktur i mindre strukturerat innehåll.
Exempel: En grundbild har pixlar. Vi kan kalla dessa&quot;kärndata&quot;. Det är metadata som beskriver format, kategori, licensinformation osv.
Metadata används oftast för resurser. Men det finns också ett stort antal användningsfall för metadata på innehållssidor eller upplevelsefragment.

## Källor till metadata

Följande kategorier kan generera metadata:

* Extraherade metadata - Informationen finns redan i dokumentet, t.ex. på det naturliga språket.
* Härledda metadata - Informationen är inte tillgänglig i originaldata, men kan härledas genom korsreferering av tidigare kunskap.
* Manuellt tillagda metadata - Det här är metadata som inte tillhör någon av de första kategorierna och som måste läggas till manuellt av en människa.

## Typer av metadata

Inom kategorierna ovan finns fyra huvudtyper:

* Tekniska och beskrivande metadata: Ger information om teknisk information om innehåll (t.ex. tite, språk)
* Operativa metadata: Dokumenterar en tillgångs livscykel (d.v.s. godkänd, i kreativt syfte, i kampanj)
* Administrativa metadata: Status eller delstat för en tillgång inom en organisation (dvs. licensinformation, ägarskap)
* Strukturella metadata: Hjälper till att kategorisera resurser och sidor för att underlätta affärsprocessen (gäller de flesta taggar och taxonomier)

## Mapp- och filnamn

Mappar är ett naturligt sätt att navigera och bläddra i innehållet i AEM. Hur kommer era intressenter att interagera med AEM? Detta avgör hur mapparna är strukturerade. Normalt är mappstrukturen arkitekturerad med ett (eller två) av följande i åtanke:

* Navigering
* Bläddra
* Kategorisering
* Åtkomstkontroll

För AEM Sites är navigering nyckeln. Mappar används för att styra åtkomsten till resurser och sidor.

Vilka nivåer av författare behöver tillgång till hemsidor? Produktsidor då? Eller kampanj? Använd behörigheter och mappstruktur för att få rätt styrning.

## Lagra metadata

Det finns tre sätt att lagra metadata:

* Binärt: Binärt format relaterat till resursens typ (Photoshop, InDesign, PNG, JPG).
* Resursnod: Detta är metadata för själva resursen, oavsett vilket system eller vilken process som används.
* Extern plats: Metadata som inte finns direkt i tillgången, men som kan användas som en beskrivning av en tillgångs&quot;status&quot; (exempel: ett arbetsflöde som kan påverka en resurs men inte direkt tillämpas på den)

## Metadatamodell

Strukturen för hur metadata hämtas och formateras kallas metadatamodell eller metadatamodell. Detta måste avtalas innan tillgångar eller sidor hämtas in i systemet.

En metadatamodell är vanligtvis utformad för att uppfylla följande användningsfall:

* Sök och hämta: Hjälper till att lagra viktiga aspekter av innehåll som gör det enkelt att hämta in det per företag.
* Återanvänd: Hjälper till att återanvända gamla resurser (spara tid och pengar)
* Licenshantering: Spårar organisationsägarskap för tillgångar (ofta av juridiska skäl)
* Distribuera: Gör innehåll tillgängligt för konsumenter eller syndikera resurser till affärspartners.
* Arkiv: Metadata som anger att en resurs är föråldrad (alltid bästa metoden att sätta en&quot;arkiverad&quot;-flagga på en tillgång så att viktig information inte går förlorad)/
* Korsreferens: Associativa metadata som fångar relationen mellan två eller flera resurser (syntesen av metadata möjliggör korsreferenser och sammanhängande grupporganisation)
* Navigera: Mappstrukturen som resurserna lagras i (används för att hämta information genom att bläddra)

*Framtagningsmetadata har huvudsakligen stöd för operationsprocesser. Publicera har stöd för användningsfall för hämtning och distribution.*

## Använda taggar som fördefinierade termer

En tagg är ett nyckelord eller en term som tilldelats till en informationsdel. I stället för att ange &quot;car&quot;, &quot;car&quot;, &quot;car&quot;, tillåter ett taggsystem endast ett värde att välja mellan, vilket gör sökningen mer förutsägbar.  Taggar normaliserar och förenklar kategoriseringen av resurser.

*Obs! Även om AEM tillåter ad hoc-taggning är det bäst att hålla sig från detta eftersom det kan leda till odefinierad och oomfattande taxonomi.*

Vanliga användningsområden för taggar:

* Sökningar efter nyckelord: En tagg kan beskriva att en resurs tillhör en viss grupp av entiteter. Exempel: taggen &quot;image/subject/car&quot; beskriver resursen som tillhör den uppsättning bilder som visar en bil.
* Körförhållanden: Alla resurser som delar samma tagg kan anses vara anslutna. Det är särskilt användbart att tagga i stället för att länka direkt på webbplatser som har mycket dynamiskt och uppkopplat innehåll.
* Enhetsnavigering: Taggar som ordnas i hierarkisk taxonomi kan skapa navigering, en eller länka till liknande dokument.
Taggar bör också betraktas som information som kopplar samman olika typer av data, baserat på affärsvillkor snarare än tekniska egenskaper.

## Vanliga program för taggar

När taggar används i AEM kan de bidra till att uppnå en mycket kortare implementering av den komplexa funktionen, till exempel:

* Fasetterad sökning
* Anpassad navigering
* Relaterat innehåll
* Innehållsreferenser
* Sökmotoroptimering
* Markera viktiga begrepp

## Taxonomier

En taxonomi är ett system för att ordna taggar baserat på delade egenskaper, som vanligtvis är hierarkiskt strukturerade efter organisatoriska behov. Strukturen kan hjälpa dig att hitta en tagg snabbare eller införa en generalisering.
Exempel: Man måste kategorisera bilderna.  Taxonomin kan se ut så här:

/subject/car/ /subject/car/sportscar/subject/car/sportscar/porsche /subject/car/sportscar/ferrari ... /subject/car/minivan /subject/car/minivan/mercedes /subject/car/minivan/volkswagen ... /subject/car/limousine ...

Nu kan användaren välja om han vill söka upp bilder på sportärr i allmänhet eller en Porsche i synnerhet. Båda är ju sportärr.
God praxis: Undvik platta taxonomier. Platta taxonomier saknar de fördelar som beskrivs ovan och kräver konstant underhåll

**Använda en taxonomi som synonymordbok.**  När en användare söker efter ett nyckelord skapas en andra sökning efter alla synonymer som finns där.
I stället för att skriva &quot;car&quot; manuellt kan systemet dessutom tillhandahålla en lista med nyckelord för att förbättra enhetligheten.

**Använda en taxonomi som ordlista.** I stället för att bara skriva ut &quot;car&quot; kan du utöka den enskilda taggen och använda alla taggens synonymer.

**Flera kategorier.** I motsats till en mapphierarki kan taggar användas för att uttrycka flera kategoriseringar samtidigt. En resurs som är taggad med:

/subject/car/minivan/mercedes/subject/people/family/color/red

## Metadata jämfört med tagg

Alla metadata bör inte betraktas som en kandidat för taggningssystem. Tekniska metadata kan duplicera informationen i onödan. Den bästa kandidaten till taggar är affärsmetadata. Taggar är ett bra alternativ för att få till stånd konsekvent vokabulär, avancerad sökning och navigering.

## Tag Management

Tagghanteringsfördelar från ett dedikerat kärnteam. Nya medlemmar bör lära sig syfte och funktion i taxonomin först innan de lägger till nya taggar.  Utvalda experter, som fungerar som vaktmästare på nya taggar, minskar den långsiktiga inkonsekvensen.

## Skapa tagg

Taxonomier ska användas av innehållsförfattare och förstås av slutanvändarna. De bör skapas innan innehållsskapandet. Eventuella genvägar resulterar i ytterligare arbete för hantering och underhåll.

## Löpande underhåll

Saker ändras, och behoven för tagglistan kommer också att förändras. Kom igång med ljudunderhållsprocesser som minskar dubbelarbete.

Se till att skribenterna vet hur de kan föreslå ändringar och att redaktörer och innehållshanterare regelbundet granskar villkoren.

## Bästa praxis med taggar och taxonomier

**Standardisera taggar.** Skapa en ordlista som innehåller ett auktoritativt språk. Utan att etablera standarder kommer dubbelarbete att medföra problem. Dessutom bör du inte bara granska taxonomin utan även hur taggarna används.

**Övertagga inte.** Taggar kan förlora sin betydelse om de är för ofta distribuerade.Prensa bort överflödiga taggar för optimal effektivitet.

**Utvärdera taggar på nytt över tid.** Kom ihåg att företagsterminologi och företagskontext sällan förblir statiska. Du kan behöva göra om taggarna och lägga till dem på nytt.

**Använda AI-baserad smart taggning.** Smart taggning [se länk] är en AI-funktion i AEM som minskar arbetet med att tagga resurser manuellt. Smart taggning använder en AI för att få information om motivet i en bild. Den genererar beskrivande taggar som beskriver innehållet i en bild.

## Metadatakvalitet och underhåll

Förståelse av affärskrav är ett viktigt steg när det gäller att implementera en metadatahanteringsmodell. Utan definition kan informationen inte lagras. Det är nödvändigt att regelbundet gå tillbaka till modellen. Detta är en viktig kvalitetskontroll.

Dessutom bör metadata samlas in så tidigt som möjligt när innehållet skapas. Om metadata inte används vid rätt tidpunkt finns det en liten risk att använda dem retroaktivt.

**Använd metadata** för att förbättra samarbetet: Använd Adobe Asset Link, Adobe Bridge och AEM Desktop för att knyta ihop kreativa processer och utnyttja metadata för att effektivisera de kreativa arbetsflödena. Med dessa verktyg blir metadata bättre och användarupplevelsen bättre i hela den kreativa processen.

## Bästa praxis för metadatahantering

* Tilldela kärnteamet ett starkt mandat: Bli ett metadatasteam som har fullständig förståelse för affärsekosystemet och ett starkt mandat från organisationens ledning.
* Definiera strategi och styrning för metadata: En bra metadatastrategi kan hjälpa organisationer att förklara behovet och fördelarna med metadata.  En strategi består av metadata, metadata, taxonomi, affärsprocesser (för datakvalitet och datainhämtning), roller och ansvarsområden samt styrningsprocesser. *
* Definiera och kommunicera en enhetlig metadatamodell: Definierad strategi och resonemang bör dokumenteras och kommuniceras väl inom organisationerna.
* Standardnamnkonvention: Skapa enhetliga och beskrivande filnamnskonventioner för förbättrad branding, informationshantering och användbarhet.
* Säkra tecken i filnamn: Filnamnet ska kunna tolkas av alla vanliga operativsystem. Du kan använda tecken, siffror, omljud, mellanrum och understrykning utan risk. Minustecknet är också säkert, men om du klipper ut och klistrar in kan det se ut som ett streck.
* Versionsnamnkonvention: AEM har vissa funktioner för att behålla tidigare versioner av mediefiler. I vissa fall kanske du vill behålla flera versioner. Du bör dock se till att versionshanteringsschemat är konsekvent.

## Organisations- eller beskrivande metadata

Några riktlinjer kan hjälpa dig att bestämma hur metadata ska kategoriseras:

**Beskrivning** - Om data beskriver resursen eller innehållet bör de ingå i de bifogade metadata.

**Sök** - Om metadata ska användas i sökningar måste de bifogas.

**Exponering** - Om du visar metadata på en distributionsplattform för en tredje part ska du se till att inte visa interna metadata.

**Varaktighet** - Ju längre metadata ska vara live, desto troligare är det att det är en bra kandidat för bifogade metadata.

**Närliggande affärsprocesser** - Det är definitivt praktiskt att ha ett permanent produkt-ID som en del av metadata. Men kategorin för en artikel i relation till produktkatalogen är en tvivelaktig metadata för resursen.

**Organisation och hantering** - Om metadatans art är organisatorisk, t.ex. i ett arbetsflöde för godkännande eller ägarskap av en viss avdelning, bör externa metadata övervägas framför att bifoga metadata till resursen.

*Ställ följande frågor för att skapa strategin:*

* Vilken typ av innehåll och&quot;ytterligare information&quot; (= metadata) behövs för att lösa affärsproblem/affärsfrågor/affärsfrågor?
* Vilka är variablerna, fälten i schemat och vilka är möjliga värden? Vilka variabler som kräver fritextindata, vilka kan minskas med typ (tal, datum, boolesk, ...), en uppsättning fasta värden (t.ex. länder) eller taggar från en given taxonomi. Hur många taggar krävs, tillåts?
* Vilka tekniska problem/problem/frågor kan lösas med metadata?
* Hur kan du få fram/skapa innehållet/metadata? Hur mycket kostar det att hämta/skapa dessa metadata?
* Vilka typer av metadata behövs för en viss användargrupp?
* Hur underhålls och uppdateras metadata?
* Vem ansvarar för vilken del i processen?
* Hur kan ni säkerställa att överenskomna affärsprocesser följs?
* Vilka standarder ska du följa? Bör du anta och ändra en branschstandard (Dublin Core, ISO 19115, PRISM osv.)? eller bör organisationen skapa egna standarder?
* Var dokumenteras strategin? Hur kan ni se till att alla intressenter har åtkomst? Hur kan du vara säker på att nyanställda följer den överenskomna standarden (t.ex. gå till kursen innan du får tillgång till den)?
