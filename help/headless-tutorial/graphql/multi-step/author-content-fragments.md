---
title: Skapa innehållsfragment - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Skapa och redigera ett nytt innehållsfragment baserat på en modell för innehållsfragment. Lär dig hur du skapar varianter av innehållsfragment.
version: Cloud Service
mini-toc-levels: 1
kt: 6713
thumbnail: 22451.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 701fae92-f740-4eb6-8133-1bc45a472d0f
source-git-commit: 410eb23534e083940bf716194576e099d22ca205
workflow-type: tm+mt
source-wordcount: '819'
ht-degree: 1%

---

# Skapa innehållsfragment {#authoring-content-fragments}

I det här kapitlet skapar och redigerar du ett nytt innehållsfragment baserat på [nydefinierad modell för innehållsfragment](./content-fragment-models.md). Du får också lära dig hur du skapar varianter av innehållsfragment.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i [Definiera modeller för innehållsfragment](./content-fragment-models.md) har slutförts.

## Mål {#objectives}

* Skapa ett innehållsfragment baserat på en innehållsfragmentmodell
* Skapa en variant av innehållsfragment

## Skapa en resursmapp

Innehållsfragment lagras i mappar i AEM Assets. Om du vill skapa innehållsfragment från modeller som skapats i det föregående kapitlet måste du skapa en mapp där de lagras. Mappen måste konfigureras för att du ska kunna skapa fragment från specifika modeller.

1. Navigera AEM startskärmen till **Resurser** > **Filer**.

   ![Navigera till resursfiler](assets/author-content-fragments/navigate-assets-files.png)

1. Tryck **Skapa** i hörnet och tryck **Mapp**. I dialogrutan som visas skriver du:

   * Titel*: **Mitt projekt**
   * Namn: **mitt projekt**

   ![Dialogrutan Skapa mapp](assets/author-content-fragments/create-folder-dialog.png)

1. Välj **Min mapp** mapp och tryck **Egenskaper**.

   ![Öppna mappegenskaper](assets/author-content-fragments/open-folder-properties.png)

1. Tryck på **Cloud Services** -fliken. Under **Molnkonfiguration** använda sökaren för att markera **Mitt projekt** konfiguration. Värdet ska vara `/conf/my-project`.

   ![Ange molnkonfiguration](assets/author-content-fragments/set-cloud-config-my-project.png)

   Om du anger den här egenskapen kan innehållsfragment skapas med hjälp av modellerna som skapades i föregående kapitel.

1. Tryck på **Profiler** -fliken. Under **Tillåtna modeller för innehållsfragment** använda sökaren för att markera **Person** och **Team** modell skapades tidigare.

   ![Tillåtna modeller för innehållsfragment](assets/author-content-fragments/allowed-content-fragment-models.png)

   Dessa profiler ärvs automatiskt av alla undermappar och kan åsidosättas. Observera att du även kan tillåta modeller efter taggar eller aktivera modeller från andra projektkonfigurationer. Den här mekanismen är ett kraftfullt sätt att hantera innehållshierarkin.

1. Tryck **Spara och stäng** om du vill spara ändringarna i mappegenskaperna.

1. Navigera inuti **Mitt projekt** mapp.

1. Skapa en ny mapp med följande värden:

   * Titel*: **Engelska**
   * Namn: **en**

   Ett tips är att skapa projekt för flerspråkigt stöd. Se [följande dokumentsida för mer information](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/translate-assets.html).


## Skapa ett innehållsfragment {#create-content-fragment}

Därefter kommer flera innehållsfragment att skapas baserat på **Team** och **Person** modeller.

1. Tryck på AEM Start Screen (Starta skärm) **Innehållsfragment** för att öppna gränssnittet för innehållsfragment.

   ![Gränssnitt för innehållsfragment](assets/author-content-fragments/cf-fragment-ui.png)

1. I den vänstra listen expanderar du **Mitt projekt** och trycka **Engelska**.
1. Tryck **Skapa** för att ta fram **Nytt innehållsfragment** och ange följande värden:

   * Plats: `/content/dam/my-project/en`
   * Modell för innehållsfragment: **Person**
   * Titel: **John Doe**
   * Namn: `john-doe`

   ![Nytt innehållsfragment](assets/author-content-fragments/new-content-fragment-john-doe.png)
1. Tryck **Skapa**.
1. Upprepa stegen ovan för att skapa ett nytt fragment som representerar **Alison Smith**:

   * Plats: `/content/dam/my-project/en`
   * Modell för innehållsfragment: **Person**
   * Titel: **Alison Smith**
   * Namn: `alison-smith`

   Tryck **Skapa** för att skapa det nya personfragmentet.

1. Upprepa sedan stegen för att skapa en ny **Team** fragment som representerar **Team Alpha**:

   * Plats: `/content/dam/my-project/en`
   * Modell för innehållsfragment: **Team**
   * Titel: **Team Alpha**
   * Namn: `team-alpha`

   Tryck **Skapa** för att skapa det nya teamfragmentet.

1. Det ska nu finnas tre innehållsfragment under **Mitt projekt** > **Engelska**:

   ![Nya innehållsfragment](assets/author-content-fragments/new-content-fragments.png)

## Redigera personinnehållsfragment {#edit-person-content-fragments}

Fyll sedan i de nyligen skapade fragmenten med data.

1. Tryck på kryssrutan bredvid **John Doe** och trycka **Öppna**.

   ![Öppna innehållsfragment](assets/author-content-fragments/open-fragment-for-editing.png)

1. Innehållsfragmentsredigeraren innehåller ett formulär baserat på modellen för innehållsfragment. Fyll i de olika fälten för att lägga till innehåll i **John Doe** fragment. Ladda upp din egen bild till AEM Assets som profilbild.

   ![Redigera innehållsfragment](assets/author-content-fragments/content-fragment-editor-jd.png)

1. Tryck **Spara och stäng** för att spara ändringarna i John Doe-fragmentet.
1. Återgå till gränssnittet för innehållsfragment och öppna **Alison Smith** fil för redigering.
1. Upprepa stegen ovan för att fylla i **Alison Smith** fragmentera med innehåll.

## Redigera teaminnehållsfragment {#edit-team-content-fragment}

1. Öppna **Team Alpha** Innehållsfragment med hjälp av gränssnittet för innehållsfragment.
1. Fyll i fälten för **Titel**, **Kortnamn** och **Beskrivning**.
1. Välj **John Doe** och **Alison Smith** Innehållsfragment för att fylla i **Teammedlemmar** fält:

   ![Ange teammedlemmar](assets/author-content-fragments/select-team-members.png)

   >[!NOTE]
   >
   >Du kan också skapa nya innehållsfragment online med hjälp av **Nytt innehållsfragment** -knappen.

1. Tryck **Spara och stäng** om du vill spara ändringarna i Team Alpha-fragmentet.

## Publicera innehållsfragment

Publicera den skapade `Content Fragments`

1. Tryck på AEM Start Screen (Starta skärm) **Innehållsfragment** för att öppna gränssnittet för innehållsfragment.

1. I den vänstra listen expanderar du **Mitt projekt** och trycka **Engelska**.

1. Tryck på kryssrutan bredvid innehållsfragmenten och tryck på **Publicera**

   ![Publicera innehållsfragment](assets/author-content-fragments/publish-content-fragment.png)

## Grattis! {#congratulations}

Grattis, du har just skapat flera innehållsfragment och skapat en variant.

## Nästa steg {#next-steps}

I nästa kapitel [Utforska GraphQL API:er](explore-graphql-api.md)kommer du att utforska AEM GraphQL API:er med det inbyggda GrapiQL-verktyget. Lär dig hur AEM automatiskt genererar ett GraphQL-schema baserat på en Content Fragment-modell. Du kommer att experimentera med att skapa grundläggande frågor med GraphQL-syntaxen.

## Relaterad dokumentation

* [Hantera innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-managing.html)
* [Variationer – redigera innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-variations.html)
