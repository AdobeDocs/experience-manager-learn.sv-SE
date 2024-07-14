---
title: Dynamic Media Classic Main Workflow and Preview Assets
description: Lär dig mer om huvudarbetsflödet i Dynamic Media Classic, som innehåller tre steg - Skapa (och ladda upp), Författare (och Publish) och Leverera. Lär dig sedan hur du förhandsgranskar mediefiler i Dynamic Media Classic.
feature: Dynamic Media Classic
topic: Content Management
role: User
level: Beginner
doc-type: Tutorial
exl-id: 04aacd81-bbb2-4742-9306-f0eabc665a41
duration: 569
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '2658'
ht-degree: 0%

---

# Dynamic Media Classic Main Workflow and Preview Assets {#main-workflow}

Dynamic Media har stöd för arbetsflödena Skapa (och Överför), Författare (och Publish) och Leverera. Du börjar med att ladda upp resurser, sedan göra något med dessa resurser, som att skapa en bilduppsättning och slutligen publicera för att göra dem levande. Steget Skapa är valfritt för vissa arbetsflöden. Om målet till exempel är att bara göra dynamiska storleksändringar och zooma in bilder eller konvertera och publicera video för direktuppspelning, finns det inga nödvändiga konstruktionssteg.

![bild](assets/main-workflow/create-author-deliver.jpg)

Arbetsflödet i Dynamic Media Classic lösningar består av tre huvudsteg:

1. Skapa (och överföra) SourceContent
2. Författare (och Publish) Assets
3. Leverera Assets

## Steg 1: Skapa (och överför)

Detta är början på arbetsflödet. I det här steget samlar du in eller skapar det källinnehåll som passar i arbetsflödet som du använder och överför det till Dynamic Media Classic. Systemet har stöd för flera filtyper för bilder, video och teckensnitt, men även för PDF, Adobe Illustrator och Adobe InDesign.

Se den fullständiga listan med [Filtyper som stöds](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/uploading-files.html#supported-asset-file-formats).

Du kan överföra källinnehåll på flera olika sätt:

- Direkt från ditt skrivbord eller lokala nätverk. [Lär dig hur](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/uploading-files.html#upload-files-using-sps-desktop-application).
- Från en Dynamic Media Classic FTP-server. [Lär dig hur](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/uploading-files.html#upload-files-using-via-ftp).

Standardläget är Från skrivbord, där du bläddrar efter filer i det lokala nätverket och startar överföringen.

![bild](assets/main-workflow/upload.jpg)

>[!TIP]
>
>Lägg inte till dina mappar manuellt. Kör i stället en överföring från FTP och använd alternativet **Inkludera undermappar** för att återskapa mappstrukturen i Dynamic Media Classic.

De två viktigaste överföringsalternativen är aktiverade som standard - **Markera för Publish**, som vi har diskuterat tidigare, och **Skriv över**. Skriv över innebär att om filen som överförs har samma namn som en fil som redan finns i systemet kommer den nya filen att ersätta den befintliga versionen. Om du avmarkerar det här alternativet kanske filen inte kan överföras.

### Skriv över alternativ vid överföring av bilder

Det finns fyra varianter av alternativet Skriv över bild som kan ställas in för hela företaget, och de är ofta missförstådda. Kort och gott: antingen anger du reglerna så att du vill att resurser med samma namn ska skrivas över oftare eller så vill du att överskrivningar ska ske mindre ofta (då får den nya bilden ett &quot;-1&quot;- eller &quot;-2&quot;-tillägg).

- **Skriv över i den aktuella mappen, samma basbildnamn/tillägg**.
Det här alternativet är den striktaste regeln för ersättning. Det kräver att du överför ersättningsbilden till samma mapp som originalbilden och att ersättningsbilden har samma filnamnstillägg som originalbilden. Om dessa krav inte uppfylls skapas en dubblett.

- **Skriv över i den aktuella mappen, samma basresursnamn oavsett tillägg**.
Kräver att du överför ersättningsbilden till samma mapp som originalet, men filnamnstillägget kan skilja sig från originalet. Till exempel ersätter stol.tif stol.jpg.

- **Skriv över i valfri mapp, samma basresursnamn/tillägg**.
Kräver att ersättningsbilden har samma filnamnstillägg som den ursprungliga bilden (t.ex. måste stol.jpg ersätta stol.jpg, inte stol.tif). Du kan dock överföra ersättningsbilden till en annan mapp än den ursprungliga. Den uppdaterade bilden finns i den nya mappen. Det går inte längre att hitta filen på den ursprungliga platsen.

- **Skriv över i valfri mapp, samma basresursnamn oavsett tillägg**.
Det här alternativet är den mest omfattande ersättningsregeln. Du kan överföra en ersättningsbild till en annan mapp än den ursprungliga, överföra en fil med ett annat filnamnstillägg och ersätta den ursprungliga filen. Om originalfilen finns i en annan mapp finns ersättningsbilden i den nya mappen som den överfördes till.

Läs mer om alternativet [Skriv över bilder](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/setup/application-setup.html#using-the-overwrite-images-option).

Även om det inte är nödvändigt kan du vid överföring med någon av de två metoderna ovan ange jobbalternativ för just den överföringen, till exempel för att schemalägga en återkommande överföring, ange beskärningsalternativ vid överföring och många andra. Dessa kan vara värdefulla för vissa arbetsflöden, så det är värt att fundera över om de kan vara till för dig.

Läs mer om [jobbalternativ](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/uploading-files.html#upload-options).

Överföring är det första nödvändiga steget i ett arbetsflöde eftersom Dynamic Media Classic inte kan arbeta med innehåll som inte redan finns i systemet. Bakom scenerna under överföringen registrerar systemet alla överförda resurser i den centraliserade Dynamic Media Classic-databasen, tilldelar ett ID och kopierar det till lagringsutrymmet. Dessutom konverterar systemet bildfiler till ett format som tillåter dynamisk storleksändring och zoomning och konverterar videofiler till MP4-format (webbvänligt format).

### Koncept: Så här händer med bilder när du överför dem till Dynamic Media Classic

När du överför en bild av någon typ till Dynamic Media Classic konverteras den till ett huvudbildformat som kallas Pyramid TIFF eller P-TIFF. Ett P-TIFF liknar formatet för en bitmappsbild i TIFF, förutom att filen i stället för att innehålla olika lager innehåller flera storlekar (upplösningar) för samma bild.

![bild](assets/main-workflow/pyramid-p-tiff.png)

När bilden konverteras tar Dynamic Media Classic en&quot;ögonblicksbild&quot; av hela bildstorleken, skalar den till hälften och sparar den, skalar den till hälften igen och sparar den och så vidare tills den fylls med jämna multiplar av originalstorleken. En P-TIFF med 2 000 pixlar har till exempel storlekar på 1 000, 500, 250 och 125 pixlar (och mindre) i samma fil. P-TIFF-filen är ett format som kallas&quot;masterbild&quot; i Dynamic Media Classic.

När du begär en viss storleksbild kan du med P-TIFF skapa Image Server för Dynamic Media Classic för att snabbt hitta nästa större storlek och skala ned den. Om du till exempel överför en bild med 2 000 pixlar och begär en bild med 100 pixlar, hittar Dynamic Media Classic versionen med 125 pixlar och skalar ned den till 100 pixlar i stället för att skala från 2 000 till 100 pixlar. Detta gör att operationen går mycket snabbt. När du zoomar in en bild kan zoomningsvisningsprogrammet dessutom endast begära en del av bilden som zoomas, i stället för hela bilden med full upplösning. Så här fungerar huvudbildformatet, P-TIFF, med stöd för både dynamisk storlek och zoomning.

På samma sätt kan du överföra huvudkällvideon till Dynamic Media Classic, och när du överför den kan Dynamic Media Classic automatiskt ändra storlek på den och konvertera den till det webbanpassade MP4-formatet.

### Regler för reglaget för att fastställa optimal storlek för de bilder du överför

**Överför bilder i den största storlek du behöver.**

- Om du behöver zooma överför du en högupplöst bild med ett intervall på 1 500-2 500 pixlar i det längsta måttet. Tänk på hur mycket detaljskärpa du vill ge, källbildens kvalitet och storleken på den produkt som visas. Du kan till exempel överföra en bild på 1 000 pixlar för en liten ring, men en bild på 3 000 pixlar för en hel rumsscen.
- Om du inte behöver zooma kan du överföra den i exakt den storlek som visas. Om du t.ex. har logotyper eller splash/banner-bilder att montera på sidorna, överför dem exakt i 1:1-storlek och anropar dem exakt i den storleken.

**Uppsampla aldrig, eller spräng, bilderna innan du överför dem till Dynamic Media Classic.** Uppsampla till exempel inte en mindre bild för att göra den till en bild med 2 000 pixlar. Det kommer inte att se bra ut. Gör bilderna så nära att de blir perfekta som möjligt före överföringen.

**Det finns ingen minimistorlek för zoomning, men som standard zoomas inte visningsprogrammen in över 100 %.** Om bilden är för liten zoomar den inte alls eller bara in en liten mängd så att den inte ser dålig ut.

**Även om det inte finns något minimum för bildstorlek rekommenderar vi inte att du överför jättematerial.** En enorm bild kan anses vara över 4 000 pixlar. Om du överför bilder i den här storleken kan det uppstå fel, t.ex. dammkorn eller hårkors i bilden. Sådana bilder tar upp mer utrymme på Dynamic Media Classic-servern, vilket kan göra att du överskrider de avtalade lagringsgränserna.

Läs mer om [Överför filer](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/uploading-files.html#uploading-your-files).

## Steg 2: Författare (och Publish)

När du har skapat och överfört ditt innehåll kan du skapa nya mediefiler från dina överförda resurser genom att utföra ett eller flera delarbetsflöden. Detta inkluderar alla olika typer av samlingar - Bild, Färgruta, Snurra och Blandade media samt Mallar. Den innehåller även video. Vi kommer att gå in mycket mer på varje typ av bildsamlingsuppsättning och multimedia för video senare. I nästan alla fall börjar du med att välja en eller flera resurser (eller inte ha några resurser markerade) och sedan välja vilken typ av resurs du vill skapa. Du kan till exempel välja en huvudbild och några vyer av den bilden och välja att skapa en bilduppsättning, en samling alternativa vyer av samma produkt.

>[!IMPORTANT]
>
>Se till att allt material är markerat för publicering. Som standard markeras alla resurser automatiskt för publicering vid överföring, men alla nyskapade resurser från ditt överförda innehåll måste också markeras för publicering.

När du har skapat din nya resurs kör du ett publiceringsjobb. Du kan göra det manuellt eller schemalägga ett publiceringsjobb som körs automatiskt. När du publicerar kopieras allt innehåll från den privata, Dynamic Media Classic-sfären till den publika, publiceringsserversfären i ekvationen. Produkten av ett Dynamic Media Publish-jobb är en unik URL för varje publicerad resurs.

Vilken server du publicerar på beror på innehållets och arbetsflödets typ. Alla bilder går till exempel till Image Server och direktuppspelande video till FMS-servern. För enkelhetens skull talar vi om ett&quot;publiceringsevenemang&quot; för en enda server.

Publicering publicerar allt innehåll som är markerat för publicering - inte bara innehållet. En enskild administratör publicerar vanligtvis för alla, inte för enskilda användare som kör en publicering. Administratören kan publicera efter behov eller konfigurera ett återkommande jobb varje dag, vecka eller till och med var 10:e minut som ska publiceras automatiskt. Publish enligt ett schema som passar er verksamhet.

>[!TIP]
>
>Automatisera publiceringsjobben och schemalägg en fullständig Publish som kan köras varje dag kl. 02.00 eller någon gång sent på kvällen.

### Koncept: Förstå Dynamic Media Classic URL

Slutprodukten i ett Dynamic Media Classic-arbetsflöde är en URL som pekar på resursen (vare sig det är en bilduppsättning eller en adaptiv videouppsättning). Dessa URL:er är mycket förutsägbara och följer samma mönster. När det gäller bilder genereras varje bild från huvudbilden P-TIFF.

Här är syntaxen för en bilds URL med några exempel:

![bild](assets/main-workflow/dmc-url.jpg)

I URL:en är allt till vänster om frågetecknet den virtuella sökvägen till en viss bild. Allt till höger om frågetecknet är en Image Server-modifierare, en instruktion om hur bilden ska bearbetas. Om du har flera modifierare avgränsas de av et-tecken.

I det första exemplet är den virtuella sökvägen till bilden &quot;Backpack_A&quot; `http://sample.scene7.com/is/image/s7train/BackpackA`. Image Server-modifierarna ändrar storlek på bilden till en bredd på 250 pixlar (från wid=250) och samplar om bilden med interpoleringsalgoritmen Lanczos, som ökar skärpan när storleken ändras (från resMode=sharp2).

I det andra exemplet används det som kallas &quot;bildförinställning&quot; för samma Backpack_A-bild, vilket anges av $!_template300$. $-symbolerna på båda sidor av uttrycket anger att en bildförinställning, en paketerad uppsättning bildmodifierare, används på bilden.

När ni väl förstår hur Dynamic Media Classic URL:er sätts ihop förstår ni hur ni ändrar dem programmatiskt och hur ni integrerar dem djupare i era webbplats- och backend-system.

### Koncept: Förstå cachningsfördröjning

Nyligen överförda och publicerade mediefiler visas direkt, medan uppdaterade mediefiler kan fördröjas med 10 timmars cachelagring. Som standard har alla publicerade resurser minst 10 timmar innan de förfaller. Vi säger minimum, eftersom varje gång bilden visas startar den en klocka som inte går ut förrän tio timmar har gått ut och där ingen har sett den bilden. Denna 10-timmarsperiod är&quot;Time to Live&quot; för en mediefil. När cacheminnet för resursen har upphört att gälla kan den uppdaterade versionen levereras.

Detta är vanligtvis inget problem om det inte har inträffat ett fel och bilden/resursen har samma namn som den tidigare publicerade versionen, men det finns ett problem med bilden. Du kanske av misstag överförde en version med låg upplösning eller så godkändes bilden inte av art director. I det här fallet vill du återkalla originalbilden och ersätta den med en ny version med samma resurs-ID.

Lär dig hur du [rensar cachen manuellt för URL:er som behöver uppdateras](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/assets/dynamicmedia/invalidate-cdn-cache-dynamic-media.html?lang=en).

>[!TIP]
>
>För att undvika problem med cachningsfördröjning ska du alltid arbeta i förväg - en kväll, en dag, två veckor osv. Bygg upp i tid för att interna parter ska godkänna eller godkänna frågor och svar innan de skickar ut materialet till allmänheten. Du kan till och med jobba en kväll innan och göra ändringar och publicera om kvällen. På morgonen har 10 timmar gått och cacheminnet uppdateras med rätt bild.

- Läs mer om [Skapa ett publiceringsjobb](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/publishing-files.html#creating-a-publish-job).
- Läs mer om [Publicering](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/upload-publish/publishing-files.html).

## Steg 3: Leverera

Kom ihåg att slutprodukten i ett Dynamic Media Classic-arbetsflöde är en URL som pekar på resursen. URL:en kan peka på en enskild bild, en bilduppsättning, en snurruppsättning eller någon annan bilduppsättningssamling eller video. Du måste ta den URL-adressen och göra något med den, till exempel redigera HTML så att `<IMG>`-taggarna pekar på Dynamic Media Classic-bilden i stället för att peka på en bild som kommer från den aktuella webbplatsen.

I leveransen måste du integrera dessa URL:er i din webbplats, mobilapp, e-postkampanj eller någon annan digital kontaktyta där du vill visa resursen.

Exempel på hur du integrerar Dynamic Media Classic URL för en bild i en webbplats:

![bild](assets/main-workflow/example-url-1.png)

Den röda URL:en är det enda specifika elementet för Dynamic Media Classic.

IT-teamet eller integreringspartnern kan ta ledningen när det gäller att skriva och ändra kod för att integrera Dynamic Media Classic URL:er på er webbplats. Adobe har ett konsultteam som kan hjälpa till med detta, antingen genom att tillhandahålla teknisk, kreativ eller allmän vägledning.

För mer komplexa lösningar som zoomningsvisningsprogram, eller visningsprogram som kombinerar zoomning med alternativa vyer, pekar URL-adressen vanligtvis på ett visningsprogram som finns på Dynamic Media Classic, och inom den URL-adressen är en referens till ett resurs-ID.

Exempel på en länk (i rött) som öppnar en bilduppsättning i ett visningsprogram i ett nytt popup-fönster:

![bild](assets/main-workflow/example-url-2.png)

>[!IMPORTANT]
>
>Ni måste integrera Dynamic Media Classic URL:er i er webbplats, mobilapp, e-post och andra digitala kontaktytor - Dynamic Media Classic kan inte göra det åt er!

## Förhandsgranska Assets

Du vill antagligen förhandsgranska de mediefiler som du har överfört eller skapar eller redigerar för att vara säker på att de visas som du vill när kunderna tittar på dem. Du kommer åt förhandsgranskningsfönstret genom att klicka på en **förhandsgranskningsknapp** , antingen på miniatyrbilden av resursen, högst upp på **Bläddra/bygg-panelen** eller genom att gå till **Arkiv > Förhandsgranska**. I ett webbläsarfönster förhandsvisas den resurs som för närvarande finns på panelen, oavsett om det är en bild, en video eller en inbyggd resurs som en bilduppsättning.

### Förhandsvisning av dynamisk storlek (bildförinställningar)

Du kan förhandsvisa dina bilder i flera storlekar med förhandsvisningen av **storlekar**. Då visas en lista med tillgängliga bildförinställningar. Vi diskuterar bildförinställningar senare, men tänk på dem som recept för att läsa in bilden i en namngiven storlek med specifika mängder skärpa och bildkvalitet.

### Förhandsgranska zoomning

Du kan också använda alternativet **Zooma** för att förhandsvisa bilden i en av många fördefinierade zoomförinställningar, som baseras på olika inbyggda zoomningsvisningsprogram.

Läs mer om [Förhandsgranska Assets](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/managing-assets/previewing-asset.html).
