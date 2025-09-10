---
title: Skapa modeller för innehållsfragment | AEM Headless OpenAPI Part 1
description: Kom igång med Adobe Experience Manager (AEM) och OpenAPI. Lär dig modellera innehåll och skapa ett schema med Content Fragment-modeller i AEM. Granska befintliga modeller och skapa en modell. Lär dig mer om de olika datatyper som kan användas för att definiera ett schema.
version: Experience Manager as a Cloud Service
mini-toc-levels: 1
jira: KT-6712
thumbnail: 22452.jpg
feature: Content Fragments
topic: Headless, Content Management
role: Developer
level: Beginner
duration: 430
source-git-commit: a3d2a88232cae941647464be8e215a47c85bc0ab
workflow-type: tm+mt
source-wordcount: '930'
ht-degree: 0%

---

# Skapa modeller för innehållsfragment

I det här kapitlet får du lära dig att modellera innehåll och skapa ett schema med **modeller för innehållsfragment** samt om de olika datatyper som definierar en modell för innehållsfragment.

I den här självstudiekursen skapar du två enkla modeller, **Team** och **Person**. Datamodellen **Team** har namn, kort namn, beskrivning och referenser till datamodellen **Person** som har fullständigt namn, bioinformation, profilbild och yrkeslista.

## Mål

* Skapa en innehållsfragmentmodell.
* Utforska tillgängliga datatyper och valideringsalternativ för att bygga modeller.
* Lär dig hur Content Fragment Models definierar **både** databasschemat och redigeringsmallen för ett Content Fragment.

## Skapa en projektkonfiguration

En projektkonfiguration innehåller alla innehållsfragmentmodeller som är kopplade till ett visst projekt och erbjuder ett sätt att ordna modeller. Skapa minst ett projekt **innan** skapar innehållsfragmentmodellen.

1. Logga in i AEM **Author**-miljö (t.ex. `https://author-p<PROGRAM_ID>-e<ENVIRONMENT_ID>.adobeaemcloud.com/`)
1. På startskärmen i AEM går du till **Verktyg** > **Allmänt** > **Konfigurationsläsaren**.
1. Klicka på **Skapa** i det övre åtgärdsfältet och ange följande konfigurationsinformation:
   * Titel: **Mitt projekt**
   * Namn: **mitt projekt**
   * Modeller för innehållsfragment: **Markerad**

   ![Min projektkonfiguration](assets/1/create-configuration.png)

1. Välj **Skapa** för att skapa projektkonfigurationen.

## Skapa modeller för innehållsfragment

Skapa sedan Content Fragment Models för ett **Team** och en **person**. Dessa fungerar som datamodeller, eller scheman, som representerar ett team och en person som ingår i ett team, och definierar gränssnittet för författare att skapa och redigera innehållsfragment baserat på dessa modeller.

### Skapa personinnehållets fragmentmodell

Skapa en innehållsfragmentmodell för en **person**, som är datamodell, eller schema, som representerar en person som ingår i ett team.

1. På startskärmen i AEM går du till **Verktyg** > **Allmänt** > **Modeller för innehållsfragment**.
1. Navigera till mappen **Mitt projekt**.
1. Välj **Skapa** i det övre högra hörnet för att öppna guiden **Skapa modell**.
1. Skapa en innehållsfragmentmodell med följande egenskaper:

   * Modelltitel: **Person**
   * Aktivera modell: **Markerad**

   Välj **Skapa**. Välj **Öppna** för att skapa modellen i den dialogruta som visas.

1. Dra och släpp ett **enkelradigt textelement** på huvudpanelen. Ange följande egenskaper på fliken **Egenskaper**:

   * Fältetikett: **Fullständigt namn**
   * Egenskapsnamn: `fullName`
   * Kontrollera **krävs**

   Egenskapsnamnet **** definierar namnet på egenskapen där det skapade värdet lagras i AEM. Egenskapsnamnet **Property Name** definierar också **key**-namnet för den här egenskapen som en del av dataschemat och används som nyckel i JSON-svaret när innehållsfragmentet levereras via AEM OpenAPI:er.

1. Markera fliken **Datatyper** och dra och släpp ett **flerradigt textfält** under fältet **Fullständigt namn**. Ange följande egenskaper:

   * Fältetikett: **Biografi**
   * Egenskapsnamn: `biographyText`
   * Standardtyp: **RTF**

1. Klicka på fliken **Datatyper** och dra och släpp ett fält för **Innehållsreferens**. Ange följande egenskaper:

   * Fältetikett: **Profilbild**
   * Egenskapsnamn: `profilePicture`
   * Rotsökväg: `/content/dam`

     När du konfigurerar **rotsökvägen** kan du klicka på ikonen **mapp** för att visa en modal sökväg för att välja sökvägen. Detta begränsar vilka mappar författare kan använda för att fylla i sökvägen. `/content/dam` är roten där alla AEM Assets (bilder, videoklipp, andra innehållsfragment) lagras.

   * Acceptera endast specifika innehållstyper: **Bild**

     Lägg till en validering i **bildreferensen** så att endast innehållstyper för **bilder** kan användas för att fylla i fältet.

   * Visa miniatyrbild: **Markerad**

1. Klicka på fliken **Datatyper** och dra och släpp en **Uppräkning**-datatyp under fältet **Bildreferens**. Ange följande egenskaper:

   * Återge som: **Kryssrutor**
   * Fältetikett: **Yrke**
   * Egenskapsnamn: `occupation`
   * Alternativ:
      * **Konstnär**
      * **Påverkar**
      * **Fotograf**
      * **Resa**
      * **Skrivare**
      * **YouTuber**

   Ange samma värde för både alternativetiketten och värdet.

1. Den sista **personen**-modellen ska se ut så här:

   ![Personinnehållsfragmentmodell](assets/1/person-content-fragment-model.png)

1. Klicka på **Spara** för att spara ändringarna.

### Skapa fragmentmodellen för teaminnehåll

Skapa en innehållsfragmentmodell för ett **team**, som är datamodell för ett team med personer. Teammodellen refererar till personinnehållsfragment, som representerar teamets medlemmar.

1. I mappen **Mitt projekt** väljer du **Skapa** i det övre högra hörnet för att visa guiden **Skapa modell**.
1. I fältet **Modelltitel** anger du **Team** och väljer **Skapa**.

   Välj **Öppna** i den resulterande dialogrutan för att öppna den nyskapade modellen.

1. Dra och släpp ett **enkelradigt textelement** på huvudpanelen. Ange följande egenskaper på fliken **Egenskaper**:

   * Fältetikett: **Rubrik**
   * Egenskapsnamn: `title`
   * Kontrollera **krävs**

1. Markera fliken **Datatyper** och dra och släpp ett **flerradigt textfält** under fältet **Kortnamn**. Ange följande egenskaper:

   * Fältetikett: **Beskrivning**
   * Egenskapsnamn: `description`
   * Standardtyp: **RTF**

1. Klicka på fliken **Datatyper** och dra och släpp ett **fragmentreferensfält**. Ange följande egenskaper:

   * Återge som: **Flera fält**
   * Minsta antal objekt: **2**
   * Fältetikett: **Teammedlemmar**
   * Egenskapsnamn: `teamMembers`
   * Tillåtna modeller för innehållsfragment: Använd mappikonen för att välja modellen **Person**.

1. Den sista **Team**-modellen ska se ut så här:

   ![Slutlig fragmentmodell för teaminnehåll](assets/1/team-content-fragment-model.png)

1. Klicka på **Spara** för att spara ändringarna.

1. Nu bör du ha två modeller att arbeta från:

   ![Två innehållsfragmentmodeller](assets/1/two-content-fragment-models.png)

## Grattis!

Grattis! Du har precis skapat dina första modeller för innehållsfragment!

## Nästa steg

I nästa kapitel, [Skapa modeller för innehållsfragment](2-author-content-fragments.md), skapar och redigerar du ett nytt innehållsfragment baserat på en modell för innehållsfragment. Du får även lära dig hur du skapar varianter av innehållsfragment.

## Relaterad dokumentation

* [Modeller för innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-models.html)

