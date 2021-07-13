---
title: Videoöversikt
description: Dynamic Media Classic innehåller automatisk konvertering av video vid överföring, direktuppspelad video till datorer och mobila enheter samt adaptiva videouppsättningar som är optimerade för uppspelning baserat på enhet och bandbredd. Läs mer om videofilmer i Dynamic Media Classic och få en översikt över videokoncept och terminologi. Sedan kan du lära dig att ladda upp och koda video, välja videoförinställningar för att ladda upp, lägga till eller redigera en videoförinställning, förhandsgranska videor i ett videovisningsprogram, distribuera video på webben och mobilsajter, lägga till bildtexter och kapitelmarkörer i video samt publicera videovisningsprogram för dator- och mobilanvändare.
sub-product: dynamiska medier
feature: Dynamic Media Classic, videoprofiler, visningsförinställningar
doc-type: tutorial
topics: development, authoring, configuring, videos, video-profiles
audience: all
activity: use
topic: Innehållshantering
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '6231'
ht-degree: 0%

---


# Videoöversikt {#video-overview}

Dynamic Media Classic innehåller automatisk konvertering av video vid överföring, direktuppspelad video till datorer och mobila enheter samt adaptiva videouppsättningar som är optimerade för uppspelning baserat på enhet och bandbredd. En av de viktigaste sakerna med video är att arbetsflödet är enkelt - det är utformat så att alla kan använda det, även om de inte känner till videotekniken.

I slutet av kursen får du lära dig att:

- Överför och koda (transkoda) video till olika storlekar och format
- Välj bland tillgängliga videoförinställningar för överföring
- Lägga till eller redigera en förinställning för videokodning
- Förhandsgranska videoklipp i ett videovisningsprogram
- Distribuera video till webb- och mobilsajter
- Lägga till bildtexter och kapitelmarkörer i video
- Anpassa och publicera videovisningsprogram för dator- och mobilanvändare

>[!NOTE]
>
>Alla URL-adresser i detta kapitel är endast avsedda som illustrationer. de är inte direktlänkar.

## Översikt över Dynamic Media Classic Video

Först får vi en bättre bild av möjligheterna med Dynamic Media Classic.

### Funktioner och funktioner

Dynamic Media Classic-videoplattformen erbjuder alla delar av videolösningen - överföring, konvertering och hantering av videor. möjlighet att lägga till bildtexter och kapitelmarkörer i en video, och möjligheten att använda förinställningar för enkel uppspelning.

Det gör det enkelt att publicera högkvalitativ adaptiv video för direktuppspelning på flera skärmar, inklusive datorer, iOS, Android, Blackberry och Windows-mobilenheter. En adaptiv videouppsättning grupperar versioner av samma video som är kodade med olika bithastigheter och format som 400 kbit/s, 800 kbit/s och 1 000 kbit/s. Den stationära datorn eller mobila enheten känner av den tillgängliga bandbredden.

Dessutom ändras videokvaliteten dynamiskt automatiskt om nätverksförhållandena ändras på datorn eller den mobila enheten. Om en kund går över till helskärmsläge på en stationär dator svarar den adaptiva videouppsättningen med en bättre upplösning, vilket förbättrar kundens tittarupplevelse. Med adaptiva videouppsättningar får du bästa möjliga uppspelning för kunder som spelar upp Dynamic Media Classic-video på flera skärmar och enheter.

### Videohantering

Att arbeta med video kan vara mer komplext än att arbeta med stillbilder. Med video hanterar du många format och standarder och osäkerheten om publiken ska kunna spela upp dina klipp. Med Dynamic Media Classic är det enkelt att arbeta med video, med många kraftfulla verktyg under huven, men du behöver inte längre jobba med dem.

Dynamic Media Classic känner igen och kan fungera med många olika källformat. Att läsa videon är dock bara en del av arbetet - du måste också konvertera den till ett webbvänligt format. Dynamic Media Classic hanterar detta genom att du kan konvertera video till H.264-video.

Att konvertera videon själv kan bli mycket komplicerat med hjälp av de många professionella och entusiastverktygen som finns. Dynamic Media Classic gör det enkelt genom att erbjuda enkla förinställningar som är optimerade för olika kvalitetsinställningar. Om du vill ha något mer anpassat kan du även skapa egna förinställningar.

Om du har mycket video kommer du att uppskatta möjligheten att hantera allt material tillsammans med bilder och andra medier i Dynamic Media Classic. Du kan ordna, katalogisera och söka efter resurser, inklusive videomaterial, med stöd XMP metadata.

### Videouppspelning

Ungefär som problemet med att konvertera video för att göra den webbvänlig och åtkomlig är problemet med att implementera och distribuera video på webbplatsen. Att välja om du vill köpa en spelare eller skapa en egen, så att den blir kompatibel för olika enheter och skärmar, och sedan underhålla spelarna kan vara en heltidssyssla.

Återigen kan du använda Dynamic Media Classic till att välja den förinställning och det visningsprogram som passar dina behov. Du har många olika visningsprogramalternativ och ett bibliotek med många förinställningar.

Du kan enkelt leverera video till webben och mobila enheter, eftersom Dynamic Media Classic har stöd för HTML5-video, vilket betyder att du kan rikta in dig på användare som kör olika webbläsare samt Android- och iOS-plattformsanvändare. Med direktuppspelad video kan du smidigt spela upp längre eller HD-innehåll, medan progressiv HTML5-video har förinställningar som är optimerade för små skärmar.

Visningsförinställningar för video kan delvis konfigureras beroende på visningsprogramtyp.

Precis som alla tittare är integreringen via en enda Dynamic Media Classic-URL per visningsprogram eller video.

>[!NOTE]
>
>Ett tips är att använda Dynamic Media Classic HTML5-videovisningsprogram. De förinställningar som används i HTML5 Video-visningsprogram är robusta videospelare. Genom att i en enda spelare kombinera möjligheten att utforma uppspelningskomponenterna med HTML5 och CSS, ha inbäddad uppspelning och använda adaptiv och progressiv strömning beroende på webbläsarens kapacitet, kan du utöka räckvidden för ditt multimedieinnehåll till datorer, surfplattor och mobilanvändare och få en smidig videoupplevelse.

En sista kommentar om Dynamic Media Classic-videor som kan gälla vissa kunder: inte alla företag har automatisk konvertering, strömning eller videoförinställningar aktiverat för sitt konto. Om du av någon anledning inte kan komma åt URL:er för direktuppspelad video kan det bero på detta. Du kommer fortfarande att kunna överföra och publicera progressivt nedladdad video och ha tillgång till alla videovisningsprogram. Om du vill utnyttja de fullständiga videofunktionerna i Dynamic Media Classic kontaktar du din Account Manager eller Sales Manager och aktiverar dessa funktioner.

Läs mer om [Video i Dynamic Media Classic](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/quick-start-video.html).

## Video 101

### Grundläggande videobegrepp och terminologi

Innan vi börjar ska vi diskutera några termer som du bör känna till för att arbeta med video. Dessa koncept är inte specifika för Dynamic Media Classic, och om du ska hantera video för en professionell webbplats är det bäst att du får lite mer utbildning i ämnet. Vi rekommenderar några resurser i slutet av det här avsnittet.

- **Kodning/omkodning.** Kodning är processen att tillämpa videokomprimering för att konvertera okomprimerade rådata till ett format som gör det enklare att arbeta med. Även om omkodning fungerar på liknande sätt, hänvisar det till konvertering från en kodningsmetod till en annan.

   - Överordnad videofiler som skapats med videoredigeringsprogram är ofta för stora och har inte rätt format för leverans till onlinedestinationer. De kodas vanligtvis för snabb uppspelning på datorn och för redigering, men inte för leverans via webben.
   - Om du vill konvertera digital video till rätt format och specifikationer för uppspelning på olika skärmar, kodas videofiler om till en mindre, effektiv filstorlek som är optimal för distribution på webben och till mobila enheter.

- **Videokomprimering.** Minska mängden data som används för att representera digitala videobilder och är en kombination av spatial bildkomprimering och tidsbestämd rörelsekompensation.

   - De flesta komprimeringstekniker är förstörande, vilket innebär att de genererar data för att uppnå en mindre storlek.
   - DV-video är till exempel komprimerat relativt lite och gör att du enkelt kan redigera källmaterialet, men det är mycket för stort att använda via webben eller till och med på en dvd.

- **Filformat.** Formatet är en behållare, ungefär som en ZIP-fil, som avgör hur filerna ordnas i videofilen, men vanligtvis inte hur de kodas.

   - Vanliga filformat för källvideo är bland annat Windows Media (WMV), QuickTime (MOV), Microsoft AVI och MPEG. Format som publiceras av Dynamic Media Classic är MP4.
   - En videofil innehåller vanligtvis flera spår - ett videospår (utan ljud) och ett eller flera ljudspår (utan video) - som är sammankopplade och synkroniserade.
   - Videofilformatet avgör hur dessa olika dataspår och metadata ordnas.

- **Kodek.** En videokodek beskriver den algoritm med vilken en video kodas med hjälp av komprimering. Ljudet kodas också med en ljudkodek.

   - Kodekar minimerar mängden information som krävs för att spela upp video. I stället för information om varje enskild bildruta sparas bara information om skillnaderna mellan en bildruta och nästa.
   - Eftersom de flesta videoklipp inte ändras så mycket från en bildruta till nästa, kan du använda codecenheter för hög komprimeringshastighet, vilket ger mindre filstorlekar.
   - En videospelare avkodar videon enligt dess kodek och visar sedan en serie bilder, eller bildrutor, på skärmen.
   - Vanliga videokodekar är H.264, On2 VP6 och H.263.

![bild](assets/video-overview/bird-video.png)

- **Upplösning.** Videons höjd och bredd i pixlar.

   - Storleken på källvideon bestäms av kameran och utdata från redigeringsprogrammet. En HD-kamera skapar vanligtvis högupplöst 1 920 x 1 080-video, men om du vill spela upp mjukt på webben nedsamplar du den (ändrar storlek) till en lägre upplösning som 1 280 x 720, 640 x 480 eller lägre.
   - Upplösningen har en direkt inverkan på filstorleken och den bandbredd som krävs för att spela upp videon.

- **Visa proportioner.** Förhållandet mellan videons bredd och videons höjd. När videofilens proportioner inte matchar spelarens proportioner kan du se&quot;svarta fält&quot; eller tomt utrymme. Två vanliga proportioner som används för att visa video är:

   - 4:3 (1.33:1). Används för nästan alla tv-sändningar i standardformat.
   - 16:9 (1,78:1). Används för nästan alla HDTV-skärmar och filmer.

- **Bithastighet/datahastighet.** Den datamängd som kodas för att skapa en enda sekund av videouppspelning (i kB per sekund).

   - Ju lägre bithastighet, desto mer önskvärd är den för webben eftersom den kan hämtas snabbare. Det kan dock också betyda att kvaliteten är låg på grund av komprimeringsförluster.
   - En bra kodek bör balansera låg bithastighet med god kvalitet.

- **Bildrutefrekvens (bildrutor per sekund eller bildrutefrekvens).** Antalet bildrutor, eller stillbilder, för varje sekund i videon. Normalt sänds NTSC (North American TV) i 29,97 bildrutor/s. Europeisk och asiatisk TV (PAL) sänds i 25 bildrutor/s. och film (analog och digital) är vanligtvis i 24 (23,976) bildrutor/s.

   - Det finns även progressiva och sammanflätade bildrutor som gör det förvirrande. Varje progressiv bildruta innehåller en hel bildram, medan sammanflätade bildrutor innehåller varannan rad med pixlar i en bildram. Bildrutorna spelas sedan upp mycket snabbt och ser ut att smälta samman. Film använder en progressiv skanningsmetod, medan digital video vanligtvis är sammanflätad.
   - Vanligtvis spelar det ingen roll om källmaterialet är sammanflätat eller inte - Dynamic Media Classic bevarar skanningsmetoden i den konverterade videon.
   - Direktuppspelning/progressiv leverans. Videoströmning är sändning av media i ett kontinuerligt flöde som kan spelas upp när det kommer, medan progressivt nedladdad video laddas ned som vilken annan fil som helst från en server och cachas lokalt i webbläsaren.

Förhoppningsvis hjälper den här introduktionen dig att förstå de olika alternativen som finns när du använder Dynamic Media Classic-video.

## Videoarbetsflöde

När du arbetar med video i Dynamic Media Classic följer du ett grundläggande arbetsflöde som påminner om att arbeta med bilder.

![bild](assets/video-overview/video-overview-2.png)

1. Börja med att ladda upp videofiler till Dynamic Media Classic. Det gör du genom att öppna menyn **Verktyg** längst ned i panelen för Dynamic Media Classic-tillägg och välja **Överför till Dynamic Media Classic > Filer till mappnamn** eller **Överför till Dynamic Media Classic > Mappar till mappnamn**. &quot;Mappnamn&quot; är den mapp du bläddrar i med tillägget. Videofiler kan vara stora, så vi rekommenderar att du använder FTP för att överföra stora filer. Som en del av överföringen väljer du en eller flera videoförinställningar för kodning av videoklipp. Video kan konverteras till MP4-video vid överföring. Mer information om hur du använder och skapar kodningsförinställningar finns i avsnittet Videoförinställningar nedan. Lär dig mer om [Överföra och koda video](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/uploading-encoding-videos.html).
2. Markera eller markera och ändra en förinställning för visningsprogrammet för video och förhandsgranska videon. Du kan antingen välja en färdig visningsförinställning eller anpassa en egen. Om ni riktar er till mobilanvändare behöver ni inte göra något här, eftersom mobilplattformarna inte kräver ett visningsprogram eller en förinställning. Läs mer om [Förhandsgranska videoklipp i ett visningsprogram för video](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/previewing-videos-video-viewer.html) och [Lägga till eller redigera en förinställning för visningsprogram för video](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/previewing-videos-video-viewer.html#adding-or-editing-a-video-viewer-preset).
3. Kör en videopublicering, hämta URL:en och integrera. Den största skillnaden mellan det här steget för videoarbetsflödet och bildarbetsflödet är att du kör en särskild videopublicering i stället för (eller kanske också) standardpubliceringen för bildservrar. Videovisningsprogramintegrationen på datorn fungerar precis som bildvisningsprogramintegrationen, men för mobila enheter är det ännu enklare - allt du behöver är URL:en till själva videon.

### Om omkodning

Omkodning definierades tidigare som processen att konvertera från en kodningsmetod till en annan. I Dynamic Media Classic konverteras källvideon från det aktuella formatet till MP4. Detta krävs innan videon visas i datorwebbläsaren eller på en mobil enhet.

Dynamic Media Classic kan hantera all omkodning åt dig, vilket är en stor fördel. Du kan omkoda videon själv och överföra filer som redan konverterats till MP4, men det kan vara en komplex process som kräver avancerad programvara. Om du inte vet vad du gör får du vanligtvis inga bra resultat vid ditt första försök.

Det är inte bara Dynamic Media Classic som konverterar filerna åt dig, det blir också enkelt genom lättanvända förinställningar. Du behöver verkligen inte känna till så mycket om den tekniska sidan av den här processen - allt du bör veta är ungefär den eller de slutliga storlekar som du vill komma ut ur systemet och en uppfattning om den bandbredd som slutanvändarna har.

De färdiga förinställningarna är praktiska och täcker de flesta behov, men ibland vill du ha något mer anpassat. I så fall kan du skapa en egen kodningsförinställning. I Dynamic Media Classic kallas en kodningsförinställning för en videoförinställning. Detta förklaras senare i detta kapitel.

### Om direktuppspelning

En annan viktig funktion som är värd att notera är direktuppspelad video, en standardfunktion i videoplattformen Dynamic Media Classic. Direktuppspelningsmedia tas kontinuerligt emot av och presenteras för slutanvändaren medan de levereras. Detta är viktigt och önskvärt av många skäl.

Strömning kräver vanligtvis mindre bandbredd än progressiv nedladdning eftersom bara den del av videon som bevakas faktiskt levereras. Dynamic Media Classic-servern för videoströmning och visningsprogrammen använder automatisk bandbreddsidentifiering för att leverera bästa möjliga ström för en användares internetanslutning.

Med direktuppspelning börjar videon spelas upp tidigare än med andra metoder. Den utnyttjar också nätverksresurserna effektivare eftersom bara de delar av videon som visas skickas till klienten.

Den andra leveransmetoden är progressiv nedladdning. Jämfört med direktuppspelad video finns det egentligen bara en enda fördel med progressiv nedladdning - du behöver ingen direktuppspelningsserver för att kunna leverera videon. Det är här som Dynamic Media Classic kommer in - Dynamic Media Classic har en direktuppspelningsserver inbyggd i plattformen, så du behöver inte besväret eller kostnaden för att underhålla denna dedikerade maskinvara.

Progressiv nedladdning av video kan göras från vilken webbserver som helst. Detta kan vara bekvämt och potentiellt kostnadseffektivt, men tänk på att progressiva nedladdningar har begränsade sök- och navigeringsmöjligheter och att användarna kan komma åt och återanvända innehållet. I vissa situationer, t.ex. uppspelning bakom mycket strikta brandväggar för nätverk, kan direktuppspelning blockeras. I dessa fall kan det vara önskvärt att återställa till progressiv leverans.

Progressiv nedladdning är ett bra val för amatörer eller webbplatser som har låg trafik. om de inte har något emot att deras innehåll cachas på användarens dator, om de endast behöver leverera videor med kortare längd (under 10 minuter), eller om besökarna av någon anledning inte kan ta emot strömmande video.

Du måste strömma videon om du behöver avancerade funktioner och har kontroll över videoleveransen, och/eller om du behöver visa videon för en större publik (t.ex. flera hundra samtidiga tittare), spåra och rapportera användning eller visningsstatistik, eller om du vill erbjuda tittarna den bästa interaktiva uppspelningsupplevelsen.

Slutligen, om du är orolig för att skydda dina medier för immateriell egendom eller rättighetshanteringsproblem, ger direktuppspelning säkrare leverans av video eftersom mediet inte sparas i klientens cache när det direktuppspelas.

## Videoförinställningar

När du överför videon kan du välja bland en eller flera förinställningar som innehåller inställningarna för konvertering av den överordnad videon till ett webbvänligt format via kodning. Videoförinställningar finns i två versioner, Adaptiva videoförinställningar och Encoding Presets.

Se [Tillgängliga videoförinställningar](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/setup/application-setup.html#video-presets-for-encoding-video-files).

Anpassade videoförinställningar aktiveras som standard, vilket betyder att de är tillgängliga för kodning. Om du vill använda en förinställning för enskild kodning måste administratören aktivera den för att den ska visas i listan med videoförinställningar.

Lär dig hur du [aktiverar eller inaktiverar videoförinställningar](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/uploading-encoding-videos.html#activating-or-deactivating-video-encoding-presets).

Du kan välja någon av många förinställningar som medföljer Dynamic Media Classic eller skapa en egen, Inga förinställningar är dock markerade för överföring som standard. Med andra ord **Om du inte väljer en videoförinställning vid överföring kommer videon inte att konverteras och kan vara opublicerbar**. Men du kan konvertera videon själv offline och överföra och publicera precis som du vill. Videoförinställningar krävs bara om du vill att Dynamic Media Classic ska göra konverteringen åt dig.

Vid överföring väljer du en videoförinställning genom att välja **Videoalternativ** på panelen Jobbalternativ. Sedan väljer du om du vill koda för Dator, Mobil eller Tablet.

- Datorn är till för persondator. Här finns vanligtvis större förinställningar (till exempel HD) som förbrukar mer bandbredd.
- Mobil och surfplatta skapar MP4-video för enheter som iPhone och Android-smarttelefoner. Den enda skillnaden mellan Mobile och Tablet är att surfplattans förinställningar vanligtvis har en högre bandbredd eftersom de baseras på WiFi-användning. Mobilförinställningar är optimerade för långsammare 3G-användning.

### Frågor att ställa innan du väljer en förinställning

När du väljer en förinställning bör du känna till både målgruppen och källmaterialet. Vad vet ni om era kunder? Hur ser de på videon - med en datorskärm eller en mobil enhet?

Vilken upplösning är din video? Om du väljer en förinställning som är större än originalet kan du få en oskarp/pixeliserad video. Det är bra om videon är större än förinställningen, men välj inte en förinställning som är större än källvideon.

Vad är dess proportioner? Om du ser svarta fält runt den konverterade videon väljer du fel proportioner. Dynamic Media Classic kan inte identifiera de här inställningarna automatiskt eftersom filen först måste granskas innan den kan överföras.

### Videoalternativ, uppdelning

Videoförinställningarna avgör hur videon kodas genom att ange de här inställningarna. Om du inte är bekant med dessa termer kan du läsa avsnittet Grundläggande videobegrepp och terminologi ovan.

![bild](assets/video-overview/video-overview-3.jpg)

- **Proportioner.** Vanligtvis standard 4:3 eller widescreen16:9.
- **Storlek.** Detta är samma som visningsupplösningen och mäts i pixlar. Detta är relaterat till proportionerna. Med förhållandet 16:9 blir videon 432 x 240 pixlar, medan den vid 4:3 är 320 x 240 pixlar.
- **FPS.** Standardbildhastigheten är 30, 25 eller 24 bildrutor per sekund (fps), beroende på videostandarden - NTSC, PAL eller Film. Den här inställningen spelar ingen roll eftersom samma bildrutehastighet som källvideon alltid används i Dynamic Media Classic.
- **Format.** Detta är MP4.
- **Bandbredd.** Detta är den önskade anslutningshastigheten för målanvändaren. Har de en snabb internetuppkoppling eller en långsam? Använder de oftast stationära datorer eller mobila enheter? Detta är också relaterat till upplösning (storlek), eftersom ju större videon är, desto mer bandbredd krävs.

### Bestämma datahastigheten eller bithastigheten för videon

Att beräkna bithastigheten för videon är en av de minst kända faktorerna för att visa videon på webben, men det kan vara den viktigaste eftersom den direkt påverkar användarupplevelsen. Om du anger för hög bithastighet får du hög videokvalitet men sämre prestanda. Användare med långsammare internetanslutningar måste vänta medan videon hela tiden pausas när den spelas upp. Men om du anger för lågt blir kvaliteten sämre. I videoförinställningen föreslår Dynamic Media Classic ett dataintervall som beror på målbandbredden. Det är en bra plats att börja på.

Men om du vill komma på det själv behöver du en beräknare av bithastigheten. Det här är ett verktyg som ofta används av videoproffs och entusiaster för att uppskatta hur mycket data som får plats i en viss ström eller media (t.ex. en dvd).

## Skapa en anpassad videoförinställning

Ibland kanske du behöver en speciell videoförinställning som inte matchar inställningarna för de inbyggda videoförinställningarna. Detta kan inträffa om du har en anpassad video med en viss storlek, till exempel en video som skapats från ett 3D-animeringsprogram eller en som har beskurits från sin ursprungliga storlek. Du kanske vill experimentera med olika bandbreddsinställningar för att få en video med högre eller lägre kvalitet. Oavsett hur du gör måste du skapa en anpassad videoförinställning för enskild kodning.

### Arbetsflöde för videoförinställning

1. Videoförinställningarna finns under **Konfigurera > Programinställningar > Videoförinställningar**. Här finns en lista med alla kodningsförinställningar som är tillgängliga för ditt företag.

   - Alla konton för direktuppspelad video har dussintals förinställningar, och om du skapar egna förinställningar visas de också här.
   - Du kan filtrera efter typ med hjälp av den nedrullningsbara menyn. Förinställningarna är uppdelade i Dator, Mobil och Tablet.
      ![bild](assets/video-overview/video-overview-4.jpg)

2. I kolumnen Aktiv kan du välja om du vill visa alla förinställningar vid överföring eller bara de du väljer. Om du är i USA kan du avmarkera de europeiska PAL-förinställningarna och avmarkera NTSC-förinställningarna om du är i Storbritannien/EMEA.
3. Klicka på knappen **Lägg till** för att skapa en anpassad förinställning. Då öppnas panelen Lägg till videoförinställning. Processen här liknar den du gör när du skapar en bildförinställning.
4. Ge den först ett **förinställningsnamn** som ska visas i listan med förinställningar. I exemplet ovan är den här förinställningen för videoklipp med skärmdumpar.
5. **Beskrivningen** är valfri, men den ger användarna ett verktygstips som beskriver syftet med den här förinställningen.
6. **Kodningsfilsuffixet** läggs till i slutet av namnet på videon som du skapar här. Kom ihåg att du kommer att ha både en Överordnad Video och den här kodade videon, som är en variant av den överordnad videon, och att inga två resurser i Dynamic Media Classic kan ha samma resurs-ID.
7. **Uppspelningsenheter** är där du väljer vilket videofilformat du vill ha (dator, mobil eller surfplatta). Kom ihåg att Mobile och Tablet har samma MP4-format. Dynamic Media Classic behöver bara veta i vilken kategori förinställningen ska placeras. Den teoretiska skillnaden är dock att förinställningar för surfplattor vanligtvis används för en snabbare internetanslutning eftersom alla stöder WiFi.
8. **Måldatahastighet är något du måste räkna ut själv, men du kan se ett föreslaget intervall i bilden nedan.** Du kan också dra skjutreglaget till den ungefärliga målbandbredden. För en mer exakt bild använder du en bithastighetskalkylator. Det finns en del testversioner och fel.

   ![bild](assets/video-overview/video-overview-5.jpg)

9. Ange källfilens **proportioner**. Den här inställningen är direkt kopplad till storleken nedan. Om du väljer _Egen_ måste du ange både bredd och höjd manuellt.
10. Om du väljer en proportion anger du ett värde för **Upplösningsstorlek** så fylls det andra värdet automatiskt i Dynamic Media Classic. Om du vill ha en anpassad proportion fyller du i båda värdena. Storleken bör vara i linje med datahastigheten. Om du anger en mycket låg datahastighet och en stor storlek förväntar du dig sämre kvalitet.
11. Klicka på **Spara** för att spara förinställningen. Till skillnad från alla andra förinställningar behöver du inte publicera just nu, eftersom förinställningarna bara är till för att överföra filer. Senare måste du publicera de kodade videoklippen, men förinställningarna gäller endast för intern Dynamic Media Classic-användning.
12. Om du vill verifiera att videoförinställningen finns i överföringslistan går du till **Överför**.Välj **Jobbalternativ** och expanderar **Videoalternativ**. Din förinställning visas i kategorin för den uppspelningsenhet du väljer (Dator, Mobil eller Surfplatta).

Läs mer om [Lägga till eller redigera en videoförinställning](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/uploading-encoding-videos.html#adding-or-editing-a-video-encoding-preset).

## Lägg till bildtexter i videon

I vissa fall kan det vara praktiskt att lägga till beskrivningar i videon, t.ex. när du behöver visa videon på flera språk, men inte vill duplicera ljudet på ett annat språk eller spela in videon igen på olika språk. Om du lägger till bildtexter blir de som har hörselnedsättning mer tillgängliga och använder undertextning. Med Dynamic Media Classic är det enkelt att lägga till bildtexter i videoklipp.

Lär dig hur du [lägger till bildtexter till video](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/adding-captions-video.html).

## Lägg till kapitelmarkörer i videon

För videor med långa format kommer de som tittar att uppskatta den möjlighet och bekvämlighet som finns genom att navigera i videon med kapitelmarkörer. I Dynamic Media Classic kan du enkelt lägga till kapitelmarkörer i videon.

Lär dig hur du [lägger till kapitelmarkörer i video](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/adding-chapter-markers-video.html).

## Videoimplementeringsämnen

### Publicera och kopiera URL

Det sista steget i Dynamic Media Classic-arbetsflödet är att publicera videoinnehåll. Men videon har ett eget publiceringsjobb, som kallas Video Server-publicering, som finns under Avancerat.

![bild](assets/video-overview/video-overview-6.jpg)

Lär dig hur du [publicerar din video](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/deploying-video-websites-mobile-sites.html#publishing-video).

När du har kört en videopublicering kan du få en URL-adress för att komma åt dina videor och eventuella förinställningar för Dynamic Media Classic Viewer i en webbläsare. Men om du anpassar eller skapar en egen förinställning för Video Viewer måste du ändå köra en separat Image Server-publicering.

- Lär dig hur du [länkar en URL till en mobilwebbplats eller en webbplats](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/deploying-video-websites-mobile-sites.html#linking-a-video-url-to-a-mobile-site-or-a-website).
- Lär dig hur du [bäddar in visningsprogrammet på en webbsida](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/deploying-video-websites-mobile-sites.html#embedding-the-video-viewer-on-a-web-page).

Du kan också distribuera videon med en tredjeparts eller anpassad videospelare.

Lär dig hur du [distribuerar video med en tredjeparts videospelare](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/deploying-video-websites-mobile-sites.html#deploying-video-using-a-third-party-video-player).

Om du också vill använda videominiatyrbilderna - den bild som extraheras från videon - måste du också köra en Image Server-publicering. Det beror på att videons miniatyrbild finns på bildservern, medan videon finns på videoservern. Videominiatyrbilder kan användas i videosökresultat, videouppspelningslistor och kan användas som den inledande&quot;affischbildrutan&quot; som visas i videobildrutan innan videon spelas upp.

Läs mer om [Arbeta med videominiatyrer](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/video/deploying-video-websites-mobile-sites.html#working-with-video-thumbnails).

### Välja och anpassa en visningsförinställning

Processen för att välja och anpassa en visningsförinställning är exakt densamma som för bilder. Du kan antingen skapa en ny förinställning eller ändra en befintlig förinställning och spara under ett nytt namn, göra redigeringar och köra en Image Serving-publicering. Alla visningsförinställningar publiceras på bildservern, inte bara förinställningar för bilder, och därför måste du köra en bildpublicering för att kunna se dina nya eller ändrade förinställningar.

>[!TIP]
>
>Kör en Image Serving-publicering efter din Video Server-publicering för att publicera miniatyrbilder som är kopplade till dina videor.

## Optimering av videosökmotor

sökmotoroptimering (SEO) är processen att förbättra synligheten för en webbplats eller en webbsida i sökmotorer. Sökmotorer är utmärkta på att samla in information om textbaserat innehåll, men de kan inte hämta in information om video på ett adekvat sätt om de inte får den här informationen. Med hjälp av Dynamic Media Classic Video SEO kan du använda metadata för att ge sökmotorer beskrivningar av videoklipp. Med funktionen Video SEO kan du skapa videosemappningar och medie-RSS-flöden (mRSS).

- **Video Sitemap**. Informerar Google om exakt var och vad videomaterialet finns på en webbplats. Därför är videor helt sökbara på Google. En webbplatskarta för video kan till exempel ange körningstid och videokategorier.
- **mRSS-flöde**. Används av innehållsutgivare för att skicka mediefiler till Yahoo! Videosökning. Google har stöd för att skicka information till sökmotorer, både via RSS-protokollet (Video Sitemap och Media RSS).

När du skapar videosemappningar och mRSS-flöden bestämmer du vilka metadatafält från videofiler som ska inkluderas. På det här sättet beskriver du videoklipp för sökmotorer så att sökmotorer kan dirigera trafik till videofilmer på din webbplats på ett mer exakt sätt.

När du har skapat webbplatskartan eller feeden kan du låta Dynamic Media Classic publicera den automatiskt, publicera den manuellt eller helt enkelt generera en fil som du kan redigera senare. Dessutom kan Dynamic Media Classic automatiskt generera och publicera den här filen varje dag.

När du är klar skickar du filen eller URL-adressen till sökmotorn. Detta görs utanför Dynamic Media Classic, Vi kommer dock att diskutera det kort nedan.

### Krav för platskarta/mRSS-filer

För att Google och andra sökmotorer inte ska kunna avvisa dina filer måste de ha rätt format och innehålla viss information. Dynamic Media Classic kommer att generera en korrekt formaterad fil; Men om informationen inte är tillgänglig för vissa videoklipp inkluderas de inte i filen.

De obligatoriska fälten är Landningssida (URL:en för sidan som visar videon, inte URL:en till själva videon), Titel och Beskrivning. Varje video måste ha en post för dessa objekt, annars inkluderas den inte i den genererade filen. Valfria fält är taggar och kategori.

Det finns två andra obligatoriska fält - Innehålls-URL, URL:en till själva videomaterialet och Miniatyrbild, en URL till en miniatyrbild av videon - men Dynamic Media Classic fyller automatiskt i dessa värden åt dig.

Det rekommenderade arbetsflödet är att bädda in dessa data i videoklipp innan de överförs med XMP metadata, och Dynamic Media Classic extraherar dem när de överförs. Du använder ett program som Adobe Bridge - som ingår i alla Adobe Creative Cloud-program - för att fylla i data i standardmetadatafält.

Om du väljer den här metoden behöver du inte ange dessa data manuellt med Dynamic Media Classic. Du kan också använda metadataförinställningar i Dynamic Media Classic som ett snabbt sätt att ange samma data varje gång.

Mer information om det ämnet finns i [Visa, lägga till och exportera metadata](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/managing-assets/viewing-adding-exporting-metadata.html).

![bild](assets/video-overview/video-overview-7.jpg)

När metadata har fyllts i kan du se dem i detaljvyn för videomaterialet. Nyckelord kan också finnas, men de finns under fliken Nyckelord.

- Läs mer om att [lägga till nyckelord](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/managing-assets/viewing-adding-exporting-metadata.html#add-or-edit-keywords).
- Läs mer om [Video SEO](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/setup/video-seo-search-engine-optimization.html).
- Läs mer om [Inställningar för Video SEO](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/setup/video-seo-search-engine-optimization.html#choosing-video-seo-settings).

#### Konfigurera video-SEO

När du konfigurerar Video SEO börjar du med att välja vilken typ av format du vill ha, vilken genereringsmetod och vilka metadatafält som ska placeras i filen.

1. Gå till **Inställningar > Programinställningar > Video SEO > Inställningar**.
2. Välj ett filformat på menyn **Genereringsläge**. Standardvärdet är Av, så om du vill aktivera det väljer du Videosemap, mRSS eller Båda.
3. Välj om du vill generera automatiskt eller manuellt. För enkelhetens skull rekommenderar vi att du ställer in det på **Automatiskt läge**. Om du väljer Automatiskt anger du även **Markera för publicering**, annars aktiveras inte filerna. Platskarta och RSS-filer är typer av XML-dokument och måste publiceras som alla andra resurser. Använd ett av de manuella lägena om du inte har all information klar just nu eller bara vill göra en engångsgenerering.
4. Fyll i metadatataggar som ska användas i filerna. Det här steget är inte valfritt. Du måste minst inkludera de tre fälten som är markerade med en asterisk (\*): **Startsida**, **Titel** och **Beskrivning**. Om du vill använda dina metadata för dessa åtgärder drar och släpper du fälten från panelen Metadata till höger i ett motsvarande fält i formuläret. Dynamic Media Classic fyller automatiskt i platshållarfältet med faktiska data från varje video. Du behöver inte använda metadatafält. Du kan istället skriva en del statisk text här, men samma text visas för varje video.
5. När du har angett information i de tre obligatoriska fälten aktiverar Dynamic Media Classic knapparna **Spara** och **Spara och generera**. Klicka på en för att spara inställningarna. Använd **Spara** om du är i automatiskt läge och vill att Dynamic Media Classic ska generera filerna senare. Använd **Spara och generera** för att skapa filen direkt.

### Testa och publicera din webbplatskarta för video, mRSS-flöden eller båda filer

Genererade filer visas i kontots rotkatalog (baskatalog).

![bild](assets/video-overview/video-overview-8.jpg)

Dessa filer måste publiceras eftersom Video SEO-verktyget inte kan köra en publicering av sig själv. Så länge de är markerade för publicering skickas de till publiceringsservrarna nästa gång en publicering körs.

När publiceringen är klar är filerna tillgängliga i det här URL-formatet.

![bild](assets/video-overview/video-url-format.png)

Exempel:

![bild](assets/video-overview/video-format-example.png)

### Skicka till sökmotorer

Det sista steget i processen är att skicka filer och/eller URL:er till sökmotorer. Dynamic Media Classic kan inte utföra det här steget åt dig; Om du däremot skickar webbadressen och inte själva XML-filen, bör din feed uppdateras nästa gång filen skapas och publiceras.

Hur du skickar till sökmotorn varierar, men för Google använder du Google Webmaster Tools. Gå sedan till **Platskonfiguration > Platskartor** och klicka på knappen **Skicka en platskarta**. Här kan du placera Dynamic Media Classic-URL:en i dina SEO-filer.

### SEO-rapport för video

I Dynamic Media Classic finns en rapport som visar hur många videoklipp som har tagits med i filerna, och ännu viktigare, vilka inte togs med på grund av fel. Du öppnar rapporten genom att gå till **Inställningar > Programinställningar > Video SEO > Rapport**.

![bild](assets/video-overview/video-overview-9.jpg)

## Mobilimplementering för MP4-video

Dynamic Media Classic innehåller inte visningsförinställningar för mobiler eftersom visningsprogram inte behöver spela upp video på mobila enheter som stöds. Så länge du kodar till H.264 MP4-formatet - antingen genom att konvertera vid överföring eller förkoda på datorn - kan surfplattor och smarttelefoner som stöds spela upp dina videor utan att behöva använda ett visningsprogram. Detta stöds på Android- och iOS-enheter (iPhone och iPad).

Orsaken till att inget visningsprogram krävs är att båda plattformarna har inbyggt H.264-stöd. Du kan antingen bädda in videon på en HTML5-webbsida eller bädda in videon i själva programmet, så att Android- och iOS-operativsystemen har en kontrollenhet som kan spela upp videon.

På grund av detta ger inte Dynamic Media Classic dig någon URL-adress till ett visningsprogram för mobila enheter, utan i stället en URL-adress direkt till videon. I förhandsgranskningsfönstret för en MP4-video finns det länkar för Skrivbord och Mobil. Mobil-URL:en pekar på den publicerade videon.

En viktig sak att tänka på när det gäller publicerad video är att URL:en visar den fullständiga sökvägen till videon, inte bara resurs-ID:t. När du hanterar bilder kan du anropa bilden med dess resurs-ID, oavsett mappstrukturen. För video måste du dock även ange mappstrukturen. I URL:erna ovan lagras videon i sökvägen:

![bild](assets/video-overview/mobile-implement-1.png)

Detta kan också uttryckas som företagsnamn/mappsökväg/namn för videon.

### Metod 1: Webbläsaruppspelning - HTML5-kod

Om du vill bädda in MP4-video på en webbsida använder du HTML5-videotaggen.

![bild](assets/video-overview/browser-playback.png)

Den här metoden fungerar även för datorwebben, men du kan råka ut för problem med webbläsarstödet - inte alla webbläsare på datorn stöder H.264-video, inklusive Firefox.

### Metod 2: Appuppspelning på iOS - Media Player Framework

Du kan också bädda in Dynamic Media Classic MP4-videon i din mobilprogramkod. Här är ett generiskt exempel för iOS med Media Player-ramverket som endast ges i illustrativa syften:

![bild](assets/video-overview/app-playback.png)

## Ytterligare resurser

Titta på [Dynamic Media Experience Builder: Video i Dynamic Media Classic](https://seminars.adobeconnect.com/p2ueiaswkuze) on-demand-webbinariet som visar hur du använder videofunktionerna i Dynamic Media Classic.
