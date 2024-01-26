---
title: Skapa modeller för innehållsfragment - Avancerade koncept för AEM Headless - GraphQL
description: I det här kapitlet i Avancerade koncept för Adobe Experience Manager (AEM) Headless får du lära dig hur du redigerar en innehållsfragmentmodell genom att lägga till platshållare för flikar, datum och tid, JSON-objekt, fragmentreferenser och innehållsreferenser.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Intermediate
exl-id: 2122ab13-f9df-4f36-9c7e-8980033c3b10
duration: 893
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '1991'
ht-degree: 0%

---

# Skapa modeller för innehållsfragment {#create-content-fragment-models}

I det här kapitlet går vi igenom stegen för att skapa fem modeller för innehållsfragment:

* **Kontaktinformation**
* **Adress**
* **Person**
* **Plats**
* **Team**

Med innehållsfragmentmodeller kan du definiera relationer mellan innehållstyper och beständiga relationer som scheman. Använd kapslade fragmentreferenser, olika innehållsdatatyper och fliktypen för att ordna visuellt innehåll. Mer avancerade datatyper som platshållare för tabbar, fragmentreferenser, JSON-objekt och datatypen date-and-time.

I det här kapitlet beskrivs även hur du förbättrar valideringsregler för innehållsreferenser som bilder.

## Förutsättningar {#prerequisites}

Det här är en avancerad självstudiekurs. Innan du fortsätter med det här kapitlet bör du kontrollera att du har slutfört [snabbinställningar](../quick-setup/cloud-service.md). Se till att du även har läst igenom föregående [översikt](../overview.md) om du vill ha mer information om hur du ställer in den avancerade självstudiekursen.

## Mål {#objectives}

* Skapa modeller för innehållsfragment.
* Lägg till tabbplatshållare, datum och tid, JSON-objekt, fragmentreferenser och innehållsreferenser till modellerna.
* Lägg till validering i innehållsreferenser.

## Översikt över modell för innehållsfragment {#content-fragment-model-overview}

I följande video ges en kort introduktion till modeller för innehållsfragment och hur de används i den här självstudiekursen.

>[!VIDEO](https://video.tv.adobe.com/v/340037?quality=12&learn=on)

## Skapa modeller för innehållsfragment {#create-models}

Låt oss skapa några innehållsfragmentmodeller för WKND-appen. Om du behöver en grundläggande introduktion till att skapa modeller för innehållsfragment kan du läsa motsvarande kapitel i [grundläggande självstudiekurs](../multi-step/content-fragment-models.md).

1. Navigera till **verktyg** > **Allmänt** > **Modeller för innehållsfragment**.

   ![Sökväg till modeller för innehållsfragment](assets/define-content-fragment-models/content-fragment-models-path.png)

1. Välj **WKND delad** om du vill visa en lista över befintliga modeller för innehållsfragment för webbplatsen.

### Kontaktinformationsmodell {#contact-info-model}

Skapa sedan en modell som innehåller kontaktinformationen för en person eller plats.

1. Välj **Skapa** längst upp till höger.

1. Ge modellen titeln &quot;Kontaktinformation&quot; och välj sedan **Skapa**. Välj **Öppna** för att redigera den nya modellen.

1. Börja med att dra en **Enkelradig text** till modellen. Ge den en **Fältetikett** i &quot;Telefon&quot; i dialogrutan **Egenskaper** -fliken. Egenskapsnamnet fylls i automatiskt som `phone`. Markera kryssrutan för att skapa fältet **Obligatoriskt**.

1. Navigera till **Datatyper** och sedan lägga till en ny **Enkelradig text** under fältet &quot;Telefon&quot;. Ge den en **Fältetikett** av&quot;Email&quot; (E-post) och ange det som **Obligatoriskt**.

Adobe Experience Manager innehåller några inbyggda valideringsmetoder. Dessa valideringsmetoder gör att du kan lägga till styrningsregler i specifika fält i Content Fragment Models. I det här fallet lägger vi till en valideringsregel som säkerställer att användare bara kan ange giltiga e-postadresser när de fyller i det här fältet. Under **Valideringstyp** listruta, välja **E-post**.

Din färdiga innehållsfragmentmodell bör se ut så här:

![Sökväg till kontaktinformationsmodell](assets/define-content-fragment-models/contact-info-model.png)

När du är klar väljer du **Spara** för att bekräfta ändringarna och stänga Modellredigeraren för innehållsfragment.

### Adressmodell {#address-model}

Skapa sedan en modell för en adress.

1. Från **WKND delad**, markera **Skapa** från det övre högra hörnet.

1. Ange en titel på &quot;Adress&quot; och välj **Skapa**. Välj **Öppna** för att redigera den nya modellen.

1. Dra och släpp en **Enkelradig text** till modellen och ge den en **Fältetikett** på&quot;Gatuadress&quot;. Egenskapsnamnet fylls sedan i som `streetAddress`. Välj **Obligatoriskt** kryssrutan.

1. Upprepa stegen ovan och lägg till ytterligare fyra&quot;Enkelradig text&quot;-fält i modellen. Använd följande etiketter:

   * Ort
   * Läge
   * Postnummer
   * Land

1. Välj **Spara** om du vill spara ändringarna i adressmodellen.

   Den färdiga adressfragmentmodellen ska se ut så här:
   ![Adressmodell](assets/define-content-fragment-models/address-model.png)

### Personmodell {#person-model}

Skapa sedan en modell som innehåller information om en person.

1. Välj i det övre högra hörnet **Skapa**.

1. Ge modellen titeln Person och välj sedan **Skapa**. Välj **Öppna** för att redigera den nya modellen.

1. Börja med att dra en **Enkelradig text** till modellen. Ge den en **Fältetikett** &quot;Fullständigt namn&quot;. Egenskapsnamnet fylls i automatiskt som `fullName`. Markera kryssrutan för att skapa fältet **Obligatoriskt**.

   ![Alternativ för fullständigt namn](assets/define-content-fragment-models/full-name.png)

1. Content Fragment Models kan refereras till i andra modeller. Navigera till **Datatyper** och sedan dra och släppa **Fragmentreferens** och ge den etiketten &quot;Kontaktinformation&quot;.

1. I **Egenskaper** -fliken, under **Tillåtna modeller för innehållsfragment** markerar du mappikonen och väljer **Kontaktinformation** fragmentmodellen skapades tidigare.

1. Lägg till en **Innehållsreferens** fält och ge det en **Fältetikett** av &quot;Profilbild&quot;. Markera mappikonen under **Rotsökväg** om du vill öppna banmarkeringen modal. Välj en rotsökväg genom att välja **innehåll** > **Resurser** markerar du kryssrutan för **WKND delad**. Använd **Välj** längst upp till höger för att spara banan. Den slutliga textbanan ska vara `/content/dam/wknd-shared`.

   ![Rotsökväg för innehållsreferens](assets/define-content-fragment-models/content-reference-root-path.png)

1. Under **Acceptera endast angivna innehållstyper** väljer du &quot;Bild&quot;.

   ![Profilbildsalternativ](assets/define-content-fragment-models/profile-picture.png)

1. Om du vill begränsa bildfilens storlek och mått tittar vi på några valideringsalternativ för innehållsreferensfältet.

   Under **Acceptera endast angiven filstorlek**väljer du &quot;Mindre än eller lika med&quot; och ytterligare fält visas nedan.
   ![Acceptera endast angiven filstorlek](assets/define-content-fragment-models/accept-specified-file-size.png)

1. För **Max**, ange &quot;5&quot; och för **Välj enhet** väljer du &quot;Megabyte (MB)&quot;. Valideringen tillåter bara att bilder med den angivna storleken väljs.

1. Under **Acceptera endast angiven bildbredd** väljer du Maximal bredd. I **Max (pixlar)** anger du &quot;10000&quot;. Välj samma alternativ för **Acceptera endast en angiven bildhöjd**.

   Dessa valideringar säkerställer att tillagda bilder inte överskrider de angivna värdena. Valideringsreglerna ska nu se ut så här:

   ![Valideringsregler för innehållsreferens](assets/define-content-fragment-models/content-reference-validation.png)

1. Lägg till en **Flerradstext** fält och ge det en **Fältetikett** av &quot;Biografi&quot;. Lämna **Standardtyp** som standardalternativ för RTF.

   ![Alternativ för biografi](assets/define-content-fragment-models/biography.png)

1. Navigera till **Datatyper** och sedan dra en **Uppräkning** fält under &quot;Biografi&quot;. I stället för standardinställningen **Återge som** alternativ, markera **Listruta** och ge den en **Fältetikett** för&quot;Instruktörsupplevelsenivå&quot;. Ange ett urval av alternativ på lärarupplevelsenivå, till exempel _Expert, avancerad, mellanliggande_.

1. Dra sedan en annan **Uppräkning** under &quot;Instruktörsupplevelsenivå&quot; och välj &quot;kryssrutor&quot; under **Återge som** alternativ. Ge den en **Fältetikett** av&quot;Skills&quot;. Ange olika kunskaper, t.ex. Klimatning av sten, Surfing, Cycling, Skiing och Backpackaging. Alternativets etikett och alternativvärde ska matcha följande:

   ![Kunskapsuppräkning](assets/define-content-fragment-models/skills-enum.png)

1. Skapa slutligen en etikett för fältet &quot;Administratörsinformation&quot; med en **Flerradstext** fält.

Välj **Spara** för att bekräfta ändringarna och stänga Modellredigeraren för innehållsfragment.

### Platsmodell {#location-model}

Nästa Content Fragment Model beskriver en fysisk plats. I den här modellen används tabbplatshållare. Med platshållare för flikar kan du ordna dina datatyper i modellredigeraren och i innehållet i fragmentredigeraren genom att kategorisera innehållet. Varje platshållare skapar en flik som liknar en flik i en webbläsare i Content Fragment-redigeraren. Platsmodellen ska ha två flikar: Platsinformation och Platsadress.

1. Som tidigare, markera **Skapa** om du vill skapa en annan innehållsfragmentmodell. Ange&quot;Plats&quot; i modelltitel. Välj **Skapa** följt av **Öppna** i den framgångstrafik som visas.

1. Lägg till en **Platshållare för flik** till modellen och ge den etiketten&quot;Platsinformation&quot;.

1. Dra och släpp en **Enkelradstext** och ge den etiketten&quot;Namn&quot;. Lägg till en **text med flera rader** och ge den etiketten&quot;Beskrivning&quot;.

1. Lägg sedan till en **Fragmentreferens** och ge den etiketten&quot;Kontaktinformation&quot;. På fliken Egenskaper, under **Tillåtna modeller för innehållsfragment** väljer du **Mappikon** och välj fragmentmodellen &quot;Kontaktinformation&quot; som skapades tidigare.

1. Lägg till en **Innehållsreferens** under Kontaktinformation. Ge den etiketten&quot;Platsbild&quot;. The **Rotsökväg** bör `/content/dam/wknd-shared.` Under **Acceptera endast angivna innehållstyper** väljer du &quot;Bild&quot;.

1. Låt oss också lägga till en **JSON-objekt** -fältet under &quot;Platsbild&quot;. Eftersom den här datatypen är flexibel kan den användas för att visa alla data som du vill inkludera i ditt innehåll. I det här fallet används JSON-objektet för att visa information om vädret. Märk JSON-objektet &quot;Väder efter säsong&quot;. I **Egenskaper** flik, lägga till **Beskrivning** så det är tydligt för användaren vilka data som ska anges här:&quot;JSON-data om händelseplatsens väder per säsong (vår, sommar, höst, vinter).&quot;

   ![Alternativ för JSON-objekt](assets/define-content-fragment-models/json-object.png)

1. Skapa fliken Platsadress genom att lägga till en **Platshållare för flik** till modellen och ge den etiketten&quot;Platsadress&quot;.

1. Dra och släpp en **Fragmentreferens** och etikettera den som&quot;Adress&quot; och under egenskapsfliken **Tillåtna modeller för innehållsfragment** väljer du **Adress** modell.

1. Välj **Spara** för att bekräfta ändringarna och stänga Modellredigeraren för innehållsfragment. Den färdiga platsmodellen ska se ut så här:

   ![Alternativ för innehållsreferens](assets/define-content-fragment-models/location-model.png)

### Teammodell {#team-model}

Skapa slutligen en modell som beskriver ett team med människor.

1. Från **WKND delad** sida, markera **Skapa** om du vill skapa en annan innehållsfragmentmodell. Skriv&quot;Team&quot; i Modelltitel. Som tidigare, markera **Skapa** följt av **Öppna** i den framgångstrafik som visas.

1. Lägg till en **Flerradstext** till formuläret. Under **Fältetikett**, ange&quot;Beskrivning&quot;.

1. Lägg till en **Datum och tid** till modellen och etikettera den som&quot;Team Founding Date&quot;. I det här fallet ska du behålla standardinställningen **Typ** anges till &quot;Datum&quot;, men observera att det också går att använda &quot;Datum och tid&quot; eller &quot;Tid&quot;.

   ![Alternativ för datum och tid](assets/define-content-fragment-models/date-and-time.png)

1. Navigera till **Datatyper** -fliken. Lägg till en **Fragmentreferens**. I **Återge som** väljer du &quot;multifield&quot;. För **Fältetikett**, ange&quot;Teammedlemmar&quot;. Det här fältet länkar till _Person_ tidigare skapad modell. Eftersom datatypen består av flera fält kan flera personfragment läggas till, vilket gör det möjligt att skapa ett team med personer.

   ![Alternativ för fragmentreferens](assets/define-content-fragment-models/fragment-reference.png)

1. Under **Tillåtna modeller för innehållsfragment**, använder du mappikonen för att öppna modal Markera bana och väljer sedan alternativet **Person** modell. Använd **Välj** för att spara banan.

   ![Välj personmodell](assets/define-content-fragment-models/select-person-model.png)

1. Välj **Spara** för att bekräfta ändringarna och stänga Modellredigeraren för innehållsfragment.

## Lägg till fragmentreferenser till Adventure-modellen {#fragment-references}

På liknande sätt som Team-modellen har en fragmentreferens till personmodellen, måste Team- och Location-modellerna refereras från Adventure-modellen för att dessa nya modeller ska kunna visas i WKND-appen.

1. Från **WKND delad** väljer du **Adventure** modell, välj sedan **Redigera** i den övre navigeringen.

   ![Adventure edit path](assets/define-content-fragment-models/adventure-edit-path.png)

1. Längst ned i formuläret, under &quot;What to Bring&quot;, lägger du till en **Fragmentreferens** fält. Ange en **Fältetikett** av &quot;Location&quot;. Under **Tillåtna modeller för innehållsfragment** väljer du **Plats** modell.

   ![Referensalternativ för platsfragment](assets/define-content-fragment-models/location-fragment-reference.png)

1. Lägg till en till **Fragmentreferens** och ge den etiketten&quot;Instruktörsgrupp&quot;. Under **Tillåtna modeller för innehållsfragment** väljer du **Team** modell.

   ![Referensalternativ för gruppfragment](assets/define-content-fragment-models/team-fragment-reference.png)

1. Lägg till ytterligare **Fragmentreferens** och ge den etiketten&quot;Administratör&quot;.

   ![Referensalternativ för administratörsfragment](assets/define-content-fragment-models/administrator-fragment-reference.png)

1. Välj **Spara** för att bekräfta ändringarna och stänga Modellredigeraren för innehållsfragment.

## Bästa praxis {#best-practices}

Det finns några tips om hur du skapar modeller för innehållsfragment:

* Skapa modeller som mappar till UX-komponenter. Till exempel har WKND-appen Content Fragment Models för äventyr, artiklar och plats. Du kan också lägga till rubriker, kampanjer eller friskrivningsklausuler. Vart och ett av dessa exempel utgör en specifik UX-komponent.

* Skapa så få modeller som möjligt. Genom att begränsa antalet modeller kan ni maximera återanvändningen och förenkla innehållshanteringen.

* Kapsla innehållsfragmentmodeller så djupt som behövs, men bara efter behov. Kom ihåg att kapsling görs med fragmentreferenser eller innehållsreferenser. Överväg att kapsla upp till fem nivåer.

## Grattis! {#congratulations}

Grattis! Du har nu lagt till flikar, använt datatyperna date-and-time och JSON-objekt och lärt dig mer om fragment- och innehållsreferenser. Du har också lagt till valideringsregler för innehållsreferenser.

## Nästa steg {#next-steps}

Nästa kapitel i serien kommer att omfatta [skapa innehållsfragment](/help/headless-tutorial/graphql/advanced-graphql/author-content-fragments.md) från de modeller som du har skapat i det här kapitlet. Lär dig hur du använder de datatyper som introduceras i det här kapitlet och skapa mappprofiler för att begränsa vad Content Fragment-modeller kan skapa i en resursmapp.

Det är valfritt för den här självstudiekursen, men se till att publicera allt innehåll i verkliga produktionssituationer. En recension av redigerings- och publiceringsmiljöer i AEM finns i
[AEM Headless och GraphQL videoserie](/help/headless-tutorial/graphql/video-series/author-publish-architecture.md).
