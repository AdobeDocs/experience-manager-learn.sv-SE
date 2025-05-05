---
title: Skapa innehållsfragment - Komma igång med AEM Headless - GraphQL
description: Kom igång med Adobe Experience Manager (AEM) och GraphQL. Skapa och redigera ett nytt innehållsfragment baserat på en innehållsfragmentmodell. Lär dig hur du skapar varianter av innehållsfragment.
version: Experience Manager as a Cloud Service
mini-toc-levels: 1
jira: KT-6713
thumbnail: 22451.jpg
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
exl-id: 701fae92-f740-4eb6-8133-1bc45a472d0f
duration: 173
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '853'
ht-degree: 0%

---

# Skapa innehållsfragment {#authoring-content-fragments}

I det här kapitlet skapar och redigerar du ett nytt innehållsfragment baserat på den [nydefinierade modellen för innehållsfragment](./content-fragment-models.md). Du får även lära dig hur du skapar varianter av innehållsfragment.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i [Definiera modeller för innehållsfragment](./content-fragment-models.md) har slutförts.

## Mål {#objectives}

* Skapa ett innehållsfragment baserat på en modell för innehållsfragment
* Skapa en variant av innehållsfragment

## Skapa en resursmapp

Innehållsfragment lagras i mappar i AEM Assets. Om du vill skapa innehållsfragment från modeller som skapats i det föregående kapitlet måste du skapa en mapp där de lagras. Mappen måste konfigureras för att du ska kunna skapa fragment från specifika modeller.

1. På startskärmen i AEM går du till **Assets** > **Filer**.

   ![Navigera till resursfiler](assets/author-content-fragments/navigate-assets-files.png)

1. Tryck på **Skapa** i det övre högra hörnet och tryck på **Mapp**. I dialogrutan som visas anger du:

   * Titel*: **Mitt projekt**
   * Namn: **mitt projekt**

   ![Dialogrutan Skapa mapp](assets/author-content-fragments/create-folder-dialog.png)

1. Markera mappen **Min mapp** och tryck på **Egenskaper**.

   ![Öppna mappegenskaper](assets/author-content-fragments/open-folder-properties.png)

1. Tryck på fliken **Molntjänster**. Använd sökvägssökaren på fliken Molnkonfiguration för att välja konfigurationen **Mitt projekt** . Värdet ska vara `/conf/my-project`.

   ![Ange molnkonfiguration](assets/author-content-fragments/set-cloud-config-my-project.png)

   Om du anger den här egenskapen kan innehållsfragment skapas med hjälp av de modeller som skapades i föregående kapitel.

1. Tryck på fliken **Profiler**, under fältet **Tillåtna modeller för innehållsfragment** använder du sökvägshanteraren för att välja **Person** - och **Team** -modellen som skapades tidigare.

   ![Tillåtna innehållsfragmentmodeller](assets/author-content-fragments/allowed-content-fragment-models.png)

   Dessa profiler ärvs automatiskt av alla undermappar och kan åsidosättas. Du kan också tillåta modeller efter taggar eller aktivera modeller från andra projektkonfigurationer. Den här mekanismen är ett kraftfullt sätt att hantera innehållshierarkin.

1. Tryck på **Spara och stäng** för att spara ändringarna i mappegenskaperna.

1. Navigera i mappen **Mitt projekt**.

1. Skapa en ny mapp med följande värden:

   * Titel*: **Engelska**
   * Namn: **en**

   Ett tips är att skapa projekt för flerspråkigt stöd. Se [följande dokumentsida för mer information](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/admin/translate-assets.html?lang=sv-SE).


## Skapa ett innehållsfragment {#create-content-fragment}

>[!TIP]
>
>För användare av AEM SDK lokalt: använd AEM Assets-gränssnittet för att skapa och redigera innehållsfragment i stället för det användargränssnitt för innehållsfragment som beskrivs nedan. Detaljerade instruktioner finns i [AEM-dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-managing.html?lang=sv-SE).

Därefter skapas flera innehållsfragment baserat på modellerna **Team** och **Person** .

1. Öppna gränssnittet för innehållsfragment genom att trycka på **Innehållsfragment** på startskärmen i AEM.

   ![Gränssnitt för innehållsfragment](assets/author-content-fragments/cf-fragment-ui.png)

1. Expandera **Mitt projekt** i den vänstra listen och tryck på **Engelska**.
1. Tryck på **Skapa** för att öppna dialogrutan **Nytt innehållsfragment** och ange följande värden:

   * Plats: `/content/dam/my-project/en`
   * Modell för innehållsfragment: **Person**
   * Titel: **John Doe**
   * Namn: `john-doe`

   ![Nytt innehållsfragment](assets/author-content-fragments/new-content-fragment-john-doe.png)
1. Tryck på **Skapa**.
1. Upprepa stegen ovan för att skapa ett fragment som representerar **Alison Smith**:

   * Plats: `/content/dam/my-project/en`
   * Modell för innehållsfragment: **Person**
   * Titel: **Alison Smith**
   * Namn: `alison-smith`

   Tryck på **Skapa** för att skapa personfragmentet.

1. Upprepa sedan stegen för att skapa ett **Team**-fragment som representerar **Team Alpha**:

   * Plats: `/content/dam/my-project/en`
   * Modell för innehållsfragment: **Team**
   * Titel: **Team Alpha**
   * Namn: `team-alpha`

   Tryck på **Skapa** för att skapa teamfragmentet.

1. Det ska finnas tre innehållsfragment under **Mitt projekt** > **Engelska**:

   ![Nya innehållsfragment](assets/author-content-fragments/new-content-fragments.png)

## Redigera personinnehållsfragment {#edit-person-content-fragments}

Fyll sedan i de nyligen skapade fragmenten med data.

1. Tryck på kryssrutan bredvid **John Doe** och tryck på **Öppna**.

   ![Öppna innehållsfragment](assets/author-content-fragments/open-fragment-for-editing.png)

1. Innehållsfragmentsredigeraren innehåller ett formulär baserat på modellen för innehållsfragment. Fyll i de olika fälten för att lägga till innehåll i **John Doe**-fragmentet. Ladda upp din egen bild till AEM Assets som profilbild.

   ![Redigera innehållsfragment](assets/author-content-fragments/content-fragment-editor-jd.png)

1. Tryck på **Spara och stäng** för att spara ändringarna i John Doe-fragmentet.
1. Återgå till gränssnittet för innehållsfragment och öppna filen **Alison Smith** för redigering.
1. Upprepa stegen ovan för att fylla i **Alison Smith**-fragmentet med innehåll.

## Redigera teaminnehållsfragment {#edit-team-content-fragment}

1. Öppna **teamets Alpha**-innehållsfragment med hjälp av gränssnittet för innehållsfragment.
1. Fyll i fälten för **Rubrik**, **Kortnamn** och **Beskrivning**.
1. Markera **John Doe** och **Alison Smith** Content Fragments för att fylla i fältet **Team Members**:

   ![Ange teammedlemmar](assets/author-content-fragments/select-team-members.png)

   >[!NOTE]
   >
   >Du kan också skapa innehållsfragment online med knappen **Nytt innehållsfragment** .

1. Tryck på **Spara och stäng** för att spara ändringarna i Team Alpha-fragmentet.

## Publicera innehållsfragment

>[!TIP]
>
>För användare av AEM SDK lokalt: Använd AEM Assets-gränssnittet för att publicera innehållsfragment i stället för det användargränssnitt för innehållsfragment som beskrivs nedan. Detaljerade instruktioner finns i [AEM-dokumentationen](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-managing.html?lang=sv-SE#publishing-and-referencing-a-fragment).

Publicera den skapade `Content Fragments` vid granskning och verifiering

1. Öppna gränssnittet för innehållsfragment genom att trycka på **Innehållsfragment** på startskärmen i AEM.

1. Expandera **Mitt projekt** i den vänstra listen och tryck på **Engelska**.

1. Tryck på kryssrutan bredvid innehållsfragmenten och tryck sedan på **Publicera**.
   ![Publicera innehållsfragment](assets/author-content-fragments/publish-content-fragment.png)

## Grattis! {#congratulations}

Grattis! Du har skapat flera innehållsfragment och skapat en variant.

## Nästa steg {#next-steps}

I nästa kapitel, [Utforska GraphQL API:er](explore-graphql-api.md), kommer du att utforska AEM GraphQL API:er med det inbyggda GrapiQL-verktyget. Lär dig hur AEM automatiskt genererar ett GraphQL-schema baserat på en Content Fragment-modell. Du kommer att experimentera med att skapa grundläggande frågor med GraphQL-syntax.

## Relaterad dokumentation

* [Hantera innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-managing.html?lang=sv-SE)
* [Variationer – redigera innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/assets/content-fragments/content-fragments-variations.html?lang=sv-SE)
