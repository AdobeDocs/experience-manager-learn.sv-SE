---
title: Definiera modeller för innehållsfragment - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Lär dig modellera innehåll och skapa ett schema med Content Fragment Models i AEM. Granska befintliga modeller och skapa en modell. Lär dig mer om de olika datatyper som kan användas för att definiera ett schema.
version: Cloud Service
mini-toc-levels: 1
jira: KT-6712
thumbnail: 22452.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 9400d9f2-f828-4180-95a7-2ac7b74cd3c9
duration: 271
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1110'
ht-degree: 0%

---

# Definiera modeller för innehållsfragment {#content-fragment-models}

Läs om hur du modellerar innehåll och skapar ett schema med **Modeller för innehållsfragment**. Du lär dig mer om de olika datatyper som kan användas för att definiera ett schema som en del av modellen.

Vi skapar två enkla modeller, **Team** och **Person**. The **Team** datamodellen har namn, kort namn, beskrivning och referenser till **Person** datamodell med fullständigt namn, bioinformation, profilbild och yrkeslista.

Du kan också skapa en egen modell som följer de grundläggande stegen och justera respektive steg som GraphQL queries och React App-kod eller helt enkelt följa stegen som beskrivs i dessa kapitel.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att en [AEM är tillgänglig](./overview.md#prerequisites).

## Mål {#objectives}

* Skapa en innehållsfragmentmodell.
* Identifiera tillgängliga datatyper och valideringsalternativ för att bygga modeller.
* Förstå hur Content Fragment Model definierar **båda** dataschemat och redigeringsmallen för ett innehållsfragment.

## Skapa en projektkonfiguration

En projektkonfiguration innehåller alla Content Fragment-modeller som är kopplade till ett visst projekt och erbjuder ett sätt att ordna modeller. Minst ett projekt måste skapas **före** skapar innehållsfragmentmodell.

1. Logga in på AEM **Upphovsman** miljö (ex. `https://author-pYYYY-eXXXX.adobeaemcloud.com/`)
1. Navigera AEM startskärmen till **verktyg** > **Allmänt** > **Konfigurationsläsaren**.

   ![Navigera till Configuration Browser](assets/content-fragment-models/navigate-config-browser.png)
1. Klicka **Skapa**, i det övre högra hörnet
1. I dialogrutan som visas anger du:

   * Titel*: **Mitt projekt**
   * Namn*: **mitt projekt** (I stället för att använda enbart små bokstäver används bindestreck för att avgränsa ord. Strängen påverkar den unika GraphQL-slutpunkt som klientprogram utför begäranden mot.)
   * Kontrollera **Modeller för innehållsfragment**
   * Kontrollera **GraphQL Beständiga frågor**

   ![Min projektkonfiguration](assets/content-fragment-models/my-project-configuration.png)

## Skapa modeller för innehållsfragment

Skapa sedan två modeller för en **Team** och **Person**.

### Skapa personmodellen

Skapa en modell för en **Person**, som är datamodellen som representerar en person som ingår i ett team.

1. Navigera AEM startskärmen till **verktyg** > **Allmänt** > **Modeller för innehållsfragment**.

   ![Navigera till Content Fragment Models](assets/content-fragment-models/navigate-cf-models.png)

1. Navigera till **Mitt projekt** mapp.
1. Tryck **Skapa** i det övre högra hörnet för att visa **Skapa modell** guide.
1. I **Modelltitel** fält, ange **Person** och knacka **Skapa**. Tryck på **Öppna**, för att bygga modellen.

1. Dra och släpp en **Enkelradig text** till huvudpanelen. Ange följande egenskaper på **Egenskaper** tab:

   * **Fältetikett**: **Fullständigt namn**
   * **Egenskapsnamn**: `fullName`
   * Kontrollera **Obligatoriskt**

   ![Egenskapsfältet Fullständigt namn](assets/content-fragment-models/full-name-property-field.png)

   The **Egenskapsnamn** definierar namnet på den egenskap som är beständig för AEM. The **Egenskapsnamn** definierar även **key** den här egenskapens namn som en del av dataschemat. Detta **key** används när Content Fragment-data visas via GraphQL API:er.

1. Tryck på **Datatyper** och dra och släppa **Flerradstext** fält under **Fullständigt namn** fält. Ange följande egenskaper:

   * **Fältetikett**: **Biografi**
   * **Egenskapsnamn**: `biographyText`
   * **Standardtyp**: **RTF**

1. Klicka på **Datatyper** och dra och släppa **Innehållsreferens** fält. Ange följande egenskaper:

   * **Fältetikett**: **Profilbild**
   * **Egenskapsnamn**: `profilePicture`
   * **Rotsökväg**: `/content/dam`

   När du konfigurerar **Rotsökväg** kan du klicka på **mapp** om du vill visa en modal för att markera banan. Detta begränsar vilka mappar författare kan använda för att fylla i sökvägen. `/content/dam` är roten där alla AEM Assets (bilder, videoklipp, andra innehållsfragment) lagras.

1. Lägg till en validering i **Bildreferens** så att bara innehållstyper i **Bilder** kan användas för att fylla i fältet.

   ![Begränsa till bilder](assets/content-fragment-models/picture-reference-content-types.png)

1. Klicka på **Datatyper** och dra och släppa **Uppräkning**  datatypen under **Bildreferens** fält. Ange följande egenskaper:

   * **Återge som**: **Kryssrutor**
   * **Fältetikett**: **Yrke**
   * **Egenskapsnamn**: `occupation`

1. Lägg till flera **Alternativ** med **Lägg till ett alternativ** -knappen. Använd samma värde för **Alternativetikett** och **Alternativvärde**:

   **Konstnär**, **Påverkande**, **Fotograf**, **Resa**, **Författare**, **YouTuber**

1. Den slutliga **Person** modellen ska se ut så här:

   ![Slutlig personmodell](assets/content-fragment-models/final-author-model.png)

1. Klicka **Spara** för att spara ändringarna.

### Skapa teammodellen

Skapa en modell för en **Team**, som är datamodellen för ett team med människor. Teammodellen refererar till personmodellen för att representera teamets medlemmar.

1. I **Mitt projekt** mapp, tryck **Skapa** i det övre högra hörnet för att visa **Skapa modell** guide.
1. I **Modelltitel** fält, ange **Team** och knacka **Skapa**.

   Tryck **Öppna** i den dialogruta som visas när du vill öppna den nya modellen.

1. Dra och släpp en **Enkelradig text** till huvudpanelen. Ange följande egenskaper på **Egenskaper** tab:

   * **Fältetikett**: **Titel**
   * **Egenskapsnamn**: `title`
   * Kontrollera **Obligatoriskt**

1. Tryck på **Datatyper** och dra och släppa **Enkelradig text** till huvudpanelen. Ange följande egenskaper på **Egenskaper** tab:

   * **Fältetikett**: **Kortnamn**
   * **Egenskapsnamn**: `shortName`
   * Kontrollera **Obligatoriskt**
   * Kontrollera **Unik**
   * Under, **Valideringstyp** > välja **Egen**
   * Under, **Anpassad valideringsregion** > ange `^[a-z0-9\-_]{5,40}$` - detta garanterar att endast alfanumeriska gemener och bindestreck mellan 5 och 40 tecken kan anges.

   The `shortName` -egenskapen är ett sätt att fråga ett enskilt team baserat på en förkortad sökväg. The **Unik** inställningen ser till att värdet alltid är unikt per innehållsfragment för den här modellen.

1. Tryck på **Datatyper** och dra och släppa **Flerradstext** fält under **Kortnamn** fält. Ange följande egenskaper:

   * **Fältetikett**: **Beskrivning**
   * **Egenskapsnamn**: `description`
   * **Standardtyp**: **RTF**

1. Klicka på **Datatyper** och dra och släppa **Fragmentreferens** fält. Ange följande egenskaper:

   * **Återge som**: **Flera fält**
   * **Fältetikett**: **Teammedlemmar**
   * **Egenskapsnamn**: `teamMembers`
   * **Tillåtna modeller för innehållsfragment**: Använd mappikonen för att välja **Person** modell.

1. Den slutliga **Team** modellen ska se ut så här:

   ![Slutlig teammodell](assets/content-fragment-models/final-team-model.png)

1. Klicka **Spara** för att spara ändringarna.

1. Nu bör du ha två modeller att arbeta från:

   ![Två modeller](assets/content-fragment-models/two-new-models.png)

## Publicera projektkonfigurationer och innehållsfragmentmodeller

Publicera `Project Configuration` &amp; `Content Fragment Model`

1. Navigera AEM startskärmen till **verktyg** > **Allmänt** > **Konfigurationsläsaren**.

1. Tryck på kryssrutan bredvid **Mitt projekt** och knacka **Publicera**

   ![Publicera projektkonfiguration](assets/content-fragment-models/publish-project-config.png)

1. Navigera AEM startskärmen till **verktyg** > **Allmänt** > **Modeller för innehållsfragment**.

1. Navigera till **Mitt projekt** mapp.

1. Tryck **Person** och **Team** modeller och knacka **Publicera**

   ![Publicera modeller för innehållsfragment](assets/content-fragment-models/publish-content-fragment-model.png)

## Grattis! {#congratulations}

Grattis! Du har precis skapat dina första modeller för innehållsfragment!

## Nästa steg {#next-steps}

I nästa kapitel [Skapa modeller för innehållsfragment](author-content-fragments.md)skapar och redigerar du ett nytt innehållsfragment baserat på en innehållsfragmentmodell. Du får även lära dig hur du skapar varianter av innehållsfragment.

## Relaterad dokumentation

* [Modeller för innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-models.html)

