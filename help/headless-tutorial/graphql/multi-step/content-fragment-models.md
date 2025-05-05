---
title: Definiera modeller för innehållsfragment - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Lär dig modellera innehåll och skapa ett schema med Content Fragment-modeller i AEM. Granska befintliga modeller och skapa en modell. Lär dig mer om de olika datatyper som kan användas för att definiera ett schema.
version: Experience Manager as a Cloud Service
mini-toc-levels: 1
jira: KT-6712
thumbnail: 22452.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 9400d9f2-f828-4180-95a7-2ac7b74cd3c9
duration: 228
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1110'
ht-degree: 0%

---

# Definiera modeller för innehållsfragment {#content-fragment-models}

Läs om hur du modellerar innehåll och skapar ett schema med **Content Fragment Models** i det här kapitlet. Du lär dig mer om de olika datatyper som kan användas för att definiera ett schema som en del av modellen.

Vi skapar två enkla modeller, **Team** och **Person**. Datamodellen **Team** har namn, kort namn, beskrivning och referenser till datamodellen **Person** som har fullständigt namn, bioinformation, profilbild och yrkeslista.

Du kan också skapa en egen modell som följer de grundläggande stegen och justera respektive steg som GraphQL queries och React App-kod eller helt enkelt följa stegen som beskrivs i dessa kapitel.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att en [AEM-redigeringsmiljö är tillgänglig](./overview.md#prerequisites).

## Mål {#objectives}

* Skapa en innehållsfragmentmodell.
* Identifiera tillgängliga datatyper och valideringsalternativ för att bygga modeller.
* Lär dig hur innehållsfragmentmodellen definierar **både** datarammet och redigeringsmallen för ett innehållsfragment.

## Skapa en projektkonfiguration

En projektkonfiguration innehåller alla Content Fragment-modeller som är kopplade till ett visst projekt och erbjuder ett sätt att ordna modeller. Minst ett projekt måste skapas **innan** skapar innehållsfragmentmodellen.

1. Logga in i AEM **Author**-miljö (t.ex. `https://author-pYYYY-eXXXX.adobeaemcloud.com/`)
1. På startskärmen i AEM går du till **Verktyg** > **Allmänt** > **Konfigurationsläsaren**.

   ![Navigera till Configuration Browser](assets/content-fragment-models/navigate-config-browser.png)
1. Klicka på **Skapa** längst upp till höger
1. I dialogrutan som visas anger du:

   * Titel*: **Mitt projekt**
   * Namn*: **mitt-projekt** (använd endast små bokstäver som bindestreck för att avgränsa ord. Strängen påverkar den unika GraphQL-slutpunkt som klientprogram utför begäranden mot.)
   * Kontrollera **modeller för innehållsfragment**
   * Kontrollera **GraphQL-beständiga frågor**

   ![Min projektkonfiguration](assets/content-fragment-models/my-project-configuration.png)

## Skapa modeller för innehållsfragment

Skapa sedan två modeller för ett **Team** och en **person**.

### Skapa personmodellen

Skapa en modell för en **person**, som är datamodellen som representerar en person som ingår i ett team.

1. På startskärmen i AEM går du till **Verktyg** > **Allmänt** > **Modeller för innehållsfragment**.

   ![Navigera till modeller för innehållsfragment](assets/content-fragment-models/navigate-cf-models.png)

1. Navigera till mappen **Mitt projekt**.
1. Tryck på **Skapa** i det övre högra hörnet för att öppna guiden **Skapa modell**.
1. I fältet **Modelltitel** anger du **Person** och trycker på **Skapa**. Tryck på **Öppna** i den dialogruta som visas för att skapa modellen.

1. Dra och släpp ett **enkelradigt textelement** på huvudpanelen. Ange följande egenskaper på fliken **Egenskaper**:

   * **Fältetikett**: **Fullständigt namn**
   * **Egenskapsnamn**: `fullName`
   * Kontrollera **krävs**

   ![Egenskapsfältet Fullständigt namn](assets/content-fragment-models/full-name-property-field.png)

   Egenskapsnamnet **Egenskap** definierar namnet på egenskapen som är beständig för AEM. Egenskapsnamnet **Property Name** definierar också namnet **key** för den här egenskapen som en del av dataschemat. Den här **nyckeln** används när data för innehållsfragment visas via GraphQL API:er.

1. Tryck på fliken **Datatyper** och dra och släpp ett **flerradigt textfält** under fältet **Fullständigt namn**. Ange följande egenskaper:

   * **Fältetikett**: **Biografi**
   * **Egenskapsnamn**: `biographyText`
   * **Standardtyp**: **RTF**

1. Klicka på fliken **Datatyper** och dra och släpp ett fält för **Innehållsreferens**. Ange följande egenskaper:

   * **Fältetikett**: **Profilbild**
   * **Egenskapsnamn**: `profilePicture`
   * **Rotsökväg**: `/content/dam`

   När du konfigurerar **rotsökvägen** kan du klicka på ikonen **mapp** för att visa en modal sökväg för att välja sökvägen. Detta begränsar vilka mappar författare kan använda för att fylla i sökvägen. `/content/dam` är roten där alla AEM Assets (bilder, videoklipp, andra innehållsfragment) lagras.

1. Lägg till en validering i **bildreferensen** så att endast innehållstyper för **bilder** kan användas för att fylla i fältet.

   ![Begränsa till bilder](assets/content-fragment-models/picture-reference-content-types.png)

1. Klicka på fliken **Datatyper** och dra och släpp en **Uppräkning**-datatyp under fältet **Bildreferens**. Ange följande egenskaper:

   * **Återge som**: **Kryssrutor**
   * **Fältetikett**: **Yrke**
   * **Egenskapsnamn**: `occupation`

1. Lägg till flera **alternativ** med knappen **Lägg till ett alternativ** . Använd samma värde för **alternativetiketten** och **alternativvärdet**:

   **Artist**, **Influencer**, **Fotograf**, **Traveler**, **Writer**, **YouTuber**

1. Den sista **personen**-modellen ska se ut så här:

   ![Slutlig personmodell](assets/content-fragment-models/final-author-model.png)

1. Klicka på **Spara** för att spara ändringarna.

### Skapa teammodellen

Skapa en modell för ett **team**, som är datamodell för ett team med personer. Teammodellen refererar till personmodellen för att representera teamets medlemmar.

1. I mappen **Mitt projekt** trycker du på **Skapa** i det övre högra hörnet för att visa guiden **Skapa modell** .
1. I fältet **Modelltitel** anger du **Team** och trycker på **Create**.

   Tryck på **Öppna** i den resulterande dialogrutan för att öppna den nyskapade modellen.

1. Dra och släpp ett **enkelradigt textelement** på huvudpanelen. Ange följande egenskaper på fliken **Egenskaper**:

   * **Fältetikett**: **Titel**
   * **Egenskapsnamn**: `title`
   * Kontrollera **krävs**

1. Tryck på fliken **Datatyper** och dra och släpp ett **enkelradigt textelement** på huvudpanelen. Ange följande egenskaper på fliken **Egenskaper**:

   * **Fältetikett**: **Kort namn**
   * **Egenskapsnamn**: `shortName`
   * Kontrollera **krävs**
   * Kontrollera **Unik**
   * Under **Valideringstyp** > välj **Egen**
   * Under **Anpassad valideringsregel** > ange `^[a-z0-9\-_]{5,40}$` - säkerställer detta att endast alfanumeriska gemener och bindestreck mellan 5 och 40 tecken kan anges.

   Egenskapen `shortName` ger oss ett sätt att fråga ett enskilt team baserat på en förkortad sökväg. Inställningen **Unik** ser till att värdet alltid är unikt per innehållsfragment för den här modellen.

1. Tryck på fliken **Datatyper** och dra och släpp ett **flerradigt textfält** under fältet **Kortnamn**. Ange följande egenskaper:

   * **Fältetikett**: **Beskrivning**
   * **Egenskapsnamn**: `description`
   * **Standardtyp**: **RTF**

1. Klicka på fliken **Datatyper** och dra och släpp ett **fragmentreferensfält**. Ange följande egenskaper:

   * **Återge som**: **Flera fält**
   * **Fältetikett**: **Teammedlemmar**
   * **Egenskapsnamn**: `teamMembers`
   * **Tillåtna modeller för innehållsfragment**: Använd mappikonen för att välja modellen **Person**.

1. Den sista **Team**-modellen ska se ut så här:

   ![Slutlig teammodell](assets/content-fragment-models/final-team-model.png)

1. Klicka på **Spara** för att spara ändringarna.

1. Nu bör du ha två modeller att arbeta från:

   ![Två modeller](assets/content-fragment-models/two-new-models.png)

## Publicera projektkonfigurationer och innehållsfragmentmodeller

Publicera `Project Configuration` &amp; `Content Fragment Model` vid granskning och verifiering

1. På startskärmen i AEM går du till **Verktyg** > **Allmänt** > **Konfigurationsläsaren**.

1. Tryck på kryssrutan bredvid **Mitt projekt** och tryck på **Publicera**

   ![Publicera projektkonfiguration](assets/content-fragment-models/publish-project-config.png)

1. På startskärmen i AEM går du till **Verktyg** > **Allmänt** > **Modeller för innehållsfragment**.

1. Navigera till mappen **Mitt projekt**.

1. Tryck på modellerna **Person** och **Team** och tryck sedan på **Publicera**

   ![Publicera modeller för innehållsfragment](assets/content-fragment-models/publish-content-fragment-model.png)

## Grattis! {#congratulations}

Grattis! Du har precis skapat dina första modeller för innehållsfragment!

## Nästa steg {#next-steps}

I nästa kapitel, [Skapa modeller för innehållsfragment](author-content-fragments.md), skapar och redigerar du ett nytt innehållsfragment baserat på en modell för innehållsfragment. Du får även lära dig hur du skapar varianter av innehållsfragment.

## Relaterad dokumentation

* [Modeller för innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-models.html?lang=sv-SE)

