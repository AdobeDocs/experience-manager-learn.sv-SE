---
title: Skapa innehållsfragment - Avancerade koncept för AEM Headless - GraphQL
description: I det här kapitlet om avancerade begrepp i Adobe Experience Manager (AEM) Headless kan du lära dig att arbeta med flikar, datum och tid, JSON-objekt och fragmentreferenser i Content Fragments. Konfigurera mappprofiler för att begränsa vad Content Fragment Models kan inkluderas.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
exl-id: 998d3678-7aef-4872-bd62-0e6ea3ff7999
duration: 609
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '2931'
ht-degree: 0%

---

# Skapa innehållsfragment

I det [föregående kapitlet](/help/headless-tutorial/graphql/advanced-graphql/create-content-fragment-models.md) skapade du fem modeller för innehållsfragment: person, team, plats, adress och kontaktinformation. I det här kapitlet får du hjälp med att skapa innehållsfragment baserat på dessa modeller. Den undersöker också hur du skapar mappprofiler för att begränsa vad Content Fragment Models kan användas i mappen.

## Förutsättningar {#prerequisites}

Det här dokumentet är en del av en självstudiekurs i flera delar. Kontrollera att det [föregående kapitlet](create-content-fragment-models.md) har slutförts innan du fortsätter med det här kapitlet.

## Mål {#objectives}

Läs om hur du gör följande i det här kapitlet:

* Skapa mappar och ange gränser med mappprofiler
* Skapa fragmentreferenser direkt från redigeraren för innehållsfragment
* Använd datatyperna Tab, Date och JSON Object
* Infoga innehålls- och fragmentreferenser i textredigeraren med flera rader
* Lägga till flera fragmentreferenser
* Kapsla innehållsfragment

## Installera exempelinnehåll {#sample-content}

Installera ett AEM som innehåller flera mappar och exempelbilder som används för att snabba upp självstudiekursen.

1. Hämta [Advanced-GraphQL-Tutorial-Starter-Package-1.1.zip](/help/headless-tutorial/graphql/advanced-graphql/assets/tutorial-files/Advanced-GraphQL-Tutorial-Starter-Package-1.1.zip)
1. I AEM går du till **Verktyg** > **Distribution** > **Paket** för att komma åt **Pakethanteraren**.
1. Ladda upp och installera det paket (zip-fil) som laddats ned i föregående steg.

   ![Paketet har överförts via pakethanteraren](assets/author-content-fragments/install-starter-package.png)

## Skapa mappar och ange gränser med mappprofiler

På AEM hemsida väljer du **Assets** > **Filer** > **WKND delad** > **Engelska**. Här ser du de olika kategorierna för innehållsfragment, inklusive Anvisningar och Medarbetare.

### Skapa mappar {#create-folders}

Navigera till mappen **Adventures**. Du ser att mappar för team och platser redan har skapats för att lagra innehållsfragment för team och platser.

Skapa en mapp för instruktörsinnehållsfragment som är baserade på personinnehållets fragmentmodell.

1. Välj **Skapa** > **Mapp** i det övre högra hörnet på sidan Tillägg.

   ![Skapa mapp](assets/author-content-fragments/create-folder.png)

1. I fältet Skapa mapp anger du &quot;Instruktörer&quot; i fältet **Titel**. Lägg märke till&quot;s&quot; i slutet. Titlar på mappar som innehåller många fragment måste vara plurala. Välj **Skapa**.

   ![Skapa modal mapp](assets/author-content-fragments/create-folder-modal.png)

   Du har nu skapat en mapp där Adventure Instructors ska lagras.

### Ange gränser med mappprinciper

I AEM kan du definiera behörigheter och profiler för mapparna för innehållsfragment. Genom att använda behörigheter kan du bara ge vissa användare (författare) eller grupper av författare åtkomst till vissa mappar. Genom att använda mappprofiler kan du begränsa vad författare av innehållsfragmentmodeller kan använda i de mapparna. I det här exemplet ska vi begränsa en mapp till modellerna för person- och kontaktinformation. Så här konfigurerar du en mappprincip:

1. Markera mappen **Instruktörer** som du har skapat och välj sedan **Egenskaper** i det övre navigeringsfältet.

   ![Egenskaper](assets/author-content-fragments/properties.png)

1. Välj fliken **Profiler** och avmarkera sedan **Ärvs från /content/dam/wknd-shared**. I fältet **Tillåtna modeller för innehållsfragment per sökväg** väljer du mappikonen.

   ![Mappikon](assets/author-content-fragments/folder-icon.png)

1. I dialogrutan Välj bana som öppnas följer du sökvägen **conf** > **WKND delad**. Personinnehållsfragmentmodellen, som skapades i föregående kapitel, innehåller en referens till kontaktinformationens innehållsfragmentmodell. Både person- och kontaktinformationsmodeller måste tillåtas i mappen Instruktörer för att ett instruktörsinnehållsfragment ska kunna skapas. Välj **Person** och **Kontaktinformation** och tryck sedan på **Välj** för att stänga dialogrutan.

   ![Markera bana](assets/author-content-fragments/select-path.png)

1. Välj **Spara och stäng** och välj **OK** i dialogrutan som visas.

1. Du har nu konfigurerat en mappprofil för mappen Instruktörer. Navigera till mappen **Instruktörer** och välj **Skapa** > **Innehållsfragment**. De enda modeller som du nu kan välja är **Person** och **Kontaktinformation**.

   ![Mappprinciper](assets/author-content-fragments/folder-policies.png)

## Skapa innehållsfragment för lärare

Navigera till mappen **Instruktörer**. Här skapar vi en kapslad mapp där du kan lagra kontaktinformationen för instruktörerna.

Följ stegen som beskrivs i avsnittet [skapa mappar](#create-folders) för att skapa en mapp med namnet &quot;Kontaktinformation&quot;. Den kapslade mappen ärver mapprinciper för den överordnade mappen. Du kan konfigurera mer specifika profiler så att den nya mappen bara tillåter att kontaktinformationsmodellen används.

### Skapa ett innehåll för instruktörer

Låt oss skapa fyra personer som kan läggas till i ett team med Adventure Instructors.

1. I mappen Instruktörer skapar du ett innehållsfragment baserat på modellen Personinnehållsfragment och ger det titeln&quot;Jacob Wester&quot;.

   Det nya innehållsfragmentet ser ut så här:

   ![Personinnehållsfragment](assets/author-content-fragments/person-content-fragment.png)

1. Ange följande innehåll i fälten:

   * **Fullständigt namn**: Jacob Wester
   * **Biografi**: Jacob Wester har varit instruktör i vandring i tio år och har älskat honom varje minut! Jacob är en äventyrssökande med talang för klättring och ryggsäck. Jacob är vinnare i klättertävlingar, bland annat i strid med tävlingen i Bay bouldering. Jacob bor för närvarande i Kalifornien.
   * **Instruktörsnivå**: Expert
   * **Kompetens**: Klimatning av sten, Surfing, Backpackaging
   * **Administratörsinformation**: Jacob Wester har samordnat bakåtpackningsäventyr i tre år.

1. Lägg till en innehållsreferens till en bild i fältet **Profilbild**. Bläddra till **WKND delad** > **Engelska** > **Medarbetare** > **jacob_wester.jpg** för att skapa en sökväg till bilden.

### Skapa en fragmentreferens från redigeraren för innehållsfragment {#fragment-reference-from-editor}

AEM gör att du kan skapa en fragmentreferens direkt från redigeraren för innehållsfragment. Låt oss skapa en referens till Jakobs kontaktinformation.

1. Välj **Nytt innehållsfragment** under fältet **Kontaktinformation**.

   ![Nytt innehållsfragment](assets/author-content-fragments/new-content-fragment.png)

1. Det nya innehållsfragmentet öppnas. Under fliken Välj mål följer du sökvägen **Anvisningar** > **Instruktörer** och markerar kryssrutan bredvid mappen **Kontaktinformation**. Välj **Nästa** för att fortsätta till fliken Egenskaper.

   ![Nytt innehållsfragment modal](assets/author-content-fragments/new-content-fragment-modal.png)

1. Under fliken Egenskaper anger du &quot;Jacob Wester Contact Info&quot; i fältet **Title**. Välj **Skapa** och tryck sedan på **Öppna** i dialogrutan som visas.

   ![Fliken Egenskaper](assets/author-content-fragments/properties-tab.png)

   Nya fält visas där du kan redigera innehållsfragmentet för kontaktinformation.

   ![Innehållsfragment för kontaktinformation](assets/author-content-fragments/contact-info-content-fragment.png)

1. Ange följande innehåll i fälten:

   * **Telefon**: 209-888-0000
   * **E-post**: jwester@wknd.com

   När du är klar väljer du **Spara**. Du har nu skapat ett innehållsfragment för kontaktinformation.

1. Om du vill gå tillbaka till Instruktörens innehållsfragment väljer du **Jacob Wester** i det övre vänstra hörnet av redigeraren.

   ![Navigera tillbaka till det ursprungliga innehållsfragmentet](assets/author-content-fragments/back-to-jacob-wester.png)

   Fältet **Kontaktinformation** innehåller nu sökvägen till det refererade kontaktinformationsfragmentet. Detta är en kapslad fragmentreferens. Det färdiga innehållsfragmentet för instruktören ser ut så här:

   ![Jacob Wester Content Fragment](assets/author-content-fragments/jacob-wester-content-fragment.png)

1. Välj **Spara och stäng** om du vill spara innehållsfragmentet. Nu har du ett nytt innehållsfragment för instruktörer.

### Skapa ytterligare fragment

Följ samma process som beskrivs i [föregående avsnitt](#fragment-reference-from-editor) för att skapa ytterligare tre innehållsfragment för instruktörer och tre innehållsfragment för kontaktinformation för dessa instruktörer. Lägg till följande innehåll i instruktionsfragmenten:

**Stacey Roswells**

| Fält | Värden |
| --- | --- |
| Content Fragment Title | Stacey Roswells |
| Fullständigt namn | Stacey Roswells |
| Kontaktinformation | /content/dam/wknd-shared/en/adventures/instructors/contact-info/stacey-roswells-contact-info |
| Profilbild | /content/dam/wknd-shared/en/contributors/stacey-roswells.jpg |
| Biografi | Stacey Roswells är en skicklig klippare och alfanäventyrare. Stacey är född i Baltimore, Maryland, och är yngst av sex barn. Staceys far var överste i USA:s flotta och mor var en modern dansinstruktör. Staceys familj flyttade ofta med fars arbetsuppgifter och tog de första bilderna när fadern var stationerad i Thailand. Det här är också där Stacey lärde sig att klättra. |
| Upplevelsenivå för lärare | Avancerat |
| Kompetens | Groda klättrar | Skickar | Bakpackning |

**Kumar Selvaraj**

| Fält | Värden |
| --- | --- |
| Content Fragment Title | Kumar Selvaraj |
| Fullständigt namn | Kumar Selvaraj |
| Kontaktinformation | /content/dam/wknd-shared/en/adventures/instructors/contact-info/kumar-selvaraj-contact-info |
| Profilbild | /content/dam/wknd-shared/en/contributors/kumar-selvaraj.jpg |
| Biografi | Kumar Selvaraj är en erfaren AMGA Certified Professional-instruktör vars främsta mål är att hjälpa eleverna att förbättra sina klättring- och vandringsfärdigheter. |
| Upplevelsenivå för lärare | Avancerat |
| Kompetens | Groda klättrar | Bakpackning |

**Ayo Ogunseinde**

| Fält | Värden |
| --- | --- |
| Content Fragment Title | Ayo Ogunseinde |
| Fullständigt namn | Ayo Ogunseinde |
| Kontaktinformation | /content/dam/wknd-shared/en/adventures/instructors/contact-info/ayo-ogunseinde-contact-info |
| Profilbild | /content/dam/wknd-shared/en/contributors/ayo-ogunseinde-237739.jpg |
| Biografi | Ayo Ogunseinde är en professionell timmerlärare och handledare i Fresno i CentralKalifornien. Ayos mål är att vägleda de anställda i deras mest episnationella parkäventyr. |
| Upplevelsenivå för lärare | Avancerat |
| Kompetens | Groda klättrar | Cykling | Bakpackning |

Lämna fältet **Ytterligare information** tomt.

Lägg till följande information i kontaktinformationsfragmenten:

| Content Fragment Title | Telefon | E-post |
| ------- | -------- | -------- |
| Kontaktinformation för Stacey Roswells | 209-888-0011 | sroswells@wknd.com |
| Kumar Selvaraj-kontaktinformation | 209-888-0002 | kselvaraj@wknd.com |
| Ayo Ogunseinde Contact Info | 209-888-0304 | aogunseinde@wknd.com |

Nu kan du skapa ett team!

## Skapa innehållsfragment för platser

Navigera till mappen **Platser**. Här ser du två kapslade mappar som redan har skapats: Yosemite nationalpark och Yosemite Valley Lodge.

![Platsmapp](assets/author-content-fragments/locations-folder.png)

Ignorera mappen Yosemite Valley Lodge för tillfället. Vi kommer tillbaka till det senare i det här avsnittet när vi skapar en plats som fungerar som hembas för vårt team med instruktörer.

Gå till mappen **Yosemite National Park**. För närvarande innehåller den bara en bild på Yosemite nationalpark. Låt oss skapa ett innehållsfragment med Location Content Fragment Model och ge det namnet&quot;Yosemite National Park&quot;.

### Platshållare för flikar

Med AEM kan du använda platshållare för flikar för att gruppera olika typer av innehåll och göra dina innehållsfragment enklare att läsa och hantera. I föregående kapitel lade du till platshållare för tabbar i platsmodellen. Det innebär att det nu finns två flikavsnitt i platsinnehållsfragment: **Platsinformation** och **Platsadress**.

![Platshållare för flikar](assets/author-content-fragments/tabs.png)

Fliken **Platsinformation** innehåller fälten **Namn**, **Beskrivning**, **Kontaktinformation**, **Platsbild** och **Väder efter säsong**, medan fliken **Platsadress** innehåller en referens till ett adressinnehållsfragment. Flikarna gör det tydligt vilka typer av innehåll som måste fyllas i, så att det blir enklare att hantera redigeringsinnehållet.

### JSON-objektdatatyp

Fältet **Väder efter säsong** är en JSON-objekttyp, vilket betyder att det accepterar data i JSON-format. Den här datatypen är flexibel och kan användas för alla data som du vill inkludera i ditt innehåll.

Du kan se fältbeskrivningen som skapades i föregående kapitel genom att hålla markören över informationsikonen till höger om fältet.

![Ikon för JSON-objektinformation](assets/author-content-fragments/json-object-info.png)

I det här fallet måste vi ange det genomsnittliga vädret för platsen. Ange följande data:

```json
{
    "summer": "81 / 89°F",
    "fall": "56 / 83°F",
    "winter": "46 / 51°F",
    "spring": "57 / 71°F"
}
```

Fältet **Väder efter säsong** ska nu se ut så här:

![JSON-objekt](assets/author-content-fragments/json-object.png)

### Lägg till innehåll

Låt oss lägga till resten av innehållet i Location Content Fragment för att fråga efter informationen med GraphQL i nästa kapitel.

1. På fliken **Platsinformation** anger du följande information i fälten:

   * **Namn**: Yosemite nationalpark
   * **Beskrivning**: Yosemite National Park är i California&#39;s Sierra Nevada-bergen. Det är känt för sina fantastiska vattenfall, enorma sekvoiaträd och ikoniska vyer av klippen El Capitan och Half Dome. Att gå på vandring och tält är det bästa sättet att uppleva Yosemite. Många spår ger oändliga möjligheter till äventyr och utforskande.

1. I fältet **Kontaktinformation** skapar du ett innehållsfragment baserat på kontaktinformationsmodellen och ger det rubriken&quot;Yosemite National Park Contact Info&quot;. Följ samma process som beskrivs i föregående avsnitt om att [skapa en fragmentreferens från redigeraren](#fragment-reference-from-editor) och ange följande data i fälten:

   * **Telefon**: 209-999-0000
   * **E-post**: yosemite@wknd.com

1. I fältet **Platsbild** bläddrar du till **Anteckningar** > **Platser** > **Yosemite National Park** > **yosemite-national-park.jpeg** för att skapa en sökväg till bilden.

   Kom ihåg, i föregående kapitel som du konfigurerade bildvalideringen, att platsbildens mått måste vara mindre än 2 560 x 1 800 och att filstorleken måste vara mindre än 3 MB.

1. När all information har lagts till ser nu fliken **Platsinformation** ut så här:

   ![Fliken Platsinformation har slutförts](assets/author-content-fragments/location-details-tab-completed.png)

1. Gå till fliken **Platsadress**. I fältet **Adress** skapar du ett innehållsfragment med namnet Yosemite National Park Address med adressfragmentmodellen som du skapade i föregående kapitel. Följ samma process som beskrivs i avsnittet [skapa en fragmentreferens från redigeraren](#fragment-reference-from-editor) och ange följande data i fälten:

   * **Gatuadress**: 9010 CFued Village Drive
   * **City**: Yosemite Valley
   * **Läge**: CA
   * **Postnummer**: 95389
   * **Land**: USA

1. Den färdiga fliken **Platsadress** i Yosemite-avsnittet i nationalparken ser ut så här:

   ![Fliken Platsadress har slutförts](assets/author-content-fragments/location-address-tab-completed.png)

1. Välj **Spara och stäng**.

### Skapa ett fragment till

1. Gå till mappen **Yosemite Valley Lodge**. Skapa ett innehållsfragment med Location Content Fragment Model och ge det rubriken&quot;Yosemite Valley Lodge&quot;.

1. På fliken **Platsinformation** anger du följande information i fälten:

   * **Namn**: Yosemite Valley Lodge
   * **Beskrivning**: Yosemite Valley Lodge är ett nav för gruppmöten och alla typer av aktiviteter, som att handla, äta, fiska, vandra och mycket annat.

1. I fältet **Kontaktinformation** skapar du ett innehållsfragment baserat på kontaktinformationsmodellen och ger det rubriken&quot;Yosemite Valley-kontaktinformation&quot;. Följ samma process som beskrivs i avsnittet [skapa en fragmentreferens från redigeraren](#fragment-reference-from-editor) och ange följande data i fälten för det nya innehållsfragmentet:

   * **Telefon**: 209-992-0000
   * **E-post**: yosemitelodge@wknd.com

   Spara det nya innehållsfragmentet.

1. Gå tillbaka till **Yosemite Valley Lodge** och gå till fliken **Platsadress**. I fältet **Adress** skapar du ett innehållsfragment med namnet Yosemite Valley Language Address med adressfragmentmodellen som du skapade i föregående kapitel. Följ samma process som beskrivs i avsnittet [skapa en fragmentreferens från redigeraren](#fragment-reference-from-editor) och ange följande data i fälten:

   * **Gatuadress**: 9006 Yosemite-logotypenhet
   * **City**: Yosemite National Park
   * **Läge**: CA
   * **Postnummer**: 95389
   * **Land**: USA

   Spara det nya innehållsfragmentet.

1. Gå tillbaka till **Yosemite Valley Lodge** och välj sedan **Spara och stäng**. Mappen **Yosemite Valley Lodge** innehåller nu tre innehållsfragment: Yosemite Valley Lodge, Yosemite Valley Lodge Contact Info och Yosemite Valley Lodge Address.

   ![Yosemite Valley Lodge-mapp](assets/author-content-fragments/yosemite-valley-lodge-folder.png)

## Skapa ett teaminnehållsfragment

Bläddra bland mappar till **Team** > **Yosemite Team**. Du ser att Yosemite Team-mappen för närvarande bara innehåller teamlogotypen.

![Yosemite-teammapp](assets/author-content-fragments/yosemite-team-folder.png)

Låt oss skapa ett innehållsfragment med teamets innehållsfragmentmodell och ge det namnet&quot;Yosemite Team&quot;.

### Innehålls- och fragmentreferenser i en textredigerare med flera rader

Med AEM kan du lägga till innehåll och fragmentreferenser direkt i textredigeraren med flera rader och hämta dem senare med hjälp av GraphQL-frågor. Vi lägger till både innehåll- och fragmentreferenser i fältet **Beskrivning**.

1. Lägg först till följande text i fältet **Beskrivning**:&quot;The team of professional adventurers and hiking instructors working in Yosemite National Park.&quot;

1. Om du vill lägga till en innehållsreferens väljer du ikonen **Infoga resurs** i verktygsfältet i textredigeraren med flera rader.

   ![Infoga resursikon](assets/author-content-fragments/insert-asset-icon.png)

1. Välj **team-yosemite-logo.png** och tryck på **Select** i det modala dokumentet som visas.

   ![Välj bild](assets/author-content-fragments/select-image.png)

   Innehållsreferensen har nu lagts till i fältet **Beskrivning**.

Kom ihåg att du i föregående kapitel tillät att fragmentreferenser läggs till i fältet **Beskrivning**. Vi lägger till en här.

1. Välj ikonen **Infoga innehållsfragment** i verktygsfältet i textredigeraren med flera rader.

   ![Ikonen Infoga innehållsfragment](assets/author-content-fragments/insert-content-fragment-icon.png)

1. Bläddra till **WKND delad** > **Engelska** > **Anteckningar** > **Platser** > **Yosemite Valley Lodge** > **Yosemite Valley Lodge**. Tryck på **Markera** för att infoga innehållsfragmentet.

   ![Infoga modalt innehållsfragment](assets/author-content-fragments/insert-content-fragment-modal.png)

   Fältet **Beskrivning** ser nu ut så här:

   ![Beskrivningsfält](assets/author-content-fragments/description-field.png)

Du har nu lagt till innehålls- och fragmentreferenserna direkt i textredigeraren med flera rader.

### Datatypen Datum och tid

Låt oss titta på datatypen Datum och tid. Välj ikonen **Kalender** till höger om fältet **Grunddatum för team** för att öppna kalendervyn.

![Datumkalendervy](assets/author-content-fragments/date-calendar-view.png)

Tidigare eller framtida datum kan anges med hjälp av framåt- och bakåtpilarna på båda sidor om månaden. Låt oss säga att Yosemite-teamet grundades den 24 maj 2016, så vi bestämmer datumet då.

### Lägga till flera fragmentreferenser

Låt oss lägga till instruktörer i fragmentreferensen för teammedlemmar.

1. Välj **Lägg till** i fältet **Teammedlemmar**.

   ![Lägg till knapp](assets/author-content-fragments/add-button.png)

1. I det nya fältet som visas väljer du mappikonen för att öppna modal Välj sökväg. Bläddra bland mapparna till **WKND Delad** > **Engelska** > **Anteckningar** > **Instruktörer** och markera sedan kryssrutan bredvid **jacob-wester**. Tryck på **Markera** för att spara sökvägen.

   ![Fragmentreferenssökväg](assets/author-content-fragments/fragment-reference-path.png)

1. Välj knappen **Lägg till** tre gånger till. Använd de nya fälten för att lägga till de tre återstående lärarna i teamet. Fältet **Teammedlemmar** ser nu ut så här:

   ![Fältet Teammedlemmar](assets/author-content-fragments/team-members-field.png)

1. Välj **Spara och stäng** om du vill spara teaminnehållsfragmentet.

### Lägga till fragmentreferenser till ett Adventure-innehållsfragment

Låt oss slutligen lägga till våra nya innehållsfragment i en äventyr.

1. Navigera till **Anteckningar** > **Yosemite Backpackaging** och öppna Yosemite Backpackaging Content Fragment. Längst ned i formuläret kan du se de tre fälten som du har skapat i föregående kapitel: **Plats**, **Instruktörsgrupp** och **Administratör**.

1. Lägg till fragmentreferensen i fältet **Plats**. Platssökvägen ska referera till Yosemite National Park Content Fragment som du skapade: `/content/dam/wknd-shared/en/adventures/locations/yosemite-national-park/yosemite-national-park`.

1. Lägg till fragmentreferensen i fältet **Instruktörsgrupp**. Teamsökvägen ska referera till det Yosemite Team Content Fragment som du skapade: `/content/dam/wknd-shared/en/adventures/teams/yosemite-team/yosemite-team`. Detta är en kapslad fragmentreferens. Team Content Fragment innehåller en referens till personmodellen som refererar till kontaktinformation och adressmodeller. Därför har du kapslat innehållsfragment tre nivåer ned.

1. Lägg till fragmentreferensen i fältet **Administratör**. Säg att Jacob Wester är administratör för Yosemite Backpackaging Adventure. Sökvägen ska leda till Jacob Wester-innehållsfragment och visas enligt följande: `/content/dam/wknd-shared/en/adventures/instructors/jacob-wester`.

1. Du har nu lagt till tre fragmentreferenser till ett Adventure Content Fragment. Fälten ser ut så här:

   ![Äventyrsfragmentreferenser](assets/author-content-fragments/adventure-fragment-references.png)

1. Välj **Spara och stäng** om du vill spara innehållet.

## Grattis!

Grattis! Du har nu skapat innehållsfragment baserat på de avancerade modeller för innehållsfragment som skapades i föregående kapitel. Du har också skapat en mappprofil som begränsar vad Content Fragment Models kan väljas i en mapp.

## Nästa steg

I [nästa kapitel](/help/headless-tutorial/graphql/advanced-graphql/explore-graphql-api.md) får du lära dig att skicka avancerade GraphQL-frågor med GraphiQL Integrated Development Environment (IDE). Med hjälp av de här frågorna kan vi visa de data som skapas i det här kapitlet och till slut lägga till de här frågorna i WKND-appen.
