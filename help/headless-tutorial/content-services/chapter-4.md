---
title: Kapitel 4 - Definiera mallar för innehållstjänster - Innehållstjänster
description: Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera den JSON-innehållsstruktur AEM Content Services visar.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: ece0bf0d-c4af-4962-9c00-f2849c2d8f6f
duration: 266
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '752'
ht-degree: 0%

---

# Kapitel 4 - Definiera mallar för innehållstjänster

Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera JSON-innehållsstrukturen AEM Content Services exponerar för klienterna via kompositionen för Content Services-aktiverade AEM Components.

## Förstå mallarnas roll i AEM Content Services

AEM Redigerbara mallar används för att definiera de HTTP-slutpunkter som är tillgängliga för att visa händelseinnehållet som JSON.

Traditionellt AEM Redigerbara mallar används för att definiera webbsidor, men det här är bara vanligt. Redigerbara mallar kan användas för att skapa **alla** uppsättning innehåll, hur det innehållet nås: som HTML i en webbläsare, som JSON förbrukas av JavaScript (AEM redigeraren) eller en mobilapp är en funktion av hur sidan begärs.

I AEM Content Services används redigerbara mallar för att definiera hur JSON-data ska visas.

För [!DNL WKND Mobile] Vi skapar en enda redigerbar mall som används för att skapa en enda API-slutpunkt. Det här exemplet är enkelt att illustrera koncepten AEM Headless, men du kan skapa flera sidor (eller slutpunkter) där varje del visar olika uppsättningar innehåll för att skapa ett mer komplext och välorganiserat API.

## API-slutpunkten

För att förstå hur vår API-slutpunkt ska disponeras och förstå vilket innehåll som ska exponeras för [!DNL WKND Mobile] App, låt oss titta på designen igen.

![Evenemang-API för dekomposition av sida](./assets/chapter-4/design-to-component-mapping.png)

Som vi kan se har vi tre logiska uppsättningar innehåll att leverera till mobilappen.

1. The **Logotyp**
2. The **Tagg Line**
3. Listan med **Händelser**

För att göra detta kan vi mappa dessa krav till AEM (och i vårt fall AEM WCM Core Components) för att visa nödvändigt innehåll som JSON.

1. The **Logotyp** visas via en **Bildkomponent**
2. The **Tagg Line** visas via en **Textkomponent**
3. Listan med **Händelser** visas via en **Content Fragment List-komponent** som i sin tur refererar till en uppsättning med händelseinnehållsfragment.

>[!NOTE]
>
>För att ge stöd AEM Content Service JSON-export av sidor och komponenter måste sidorna och komponenterna **härleda från AEM WCM Core Components**.
>
>[AEM WCM-kärnkomponenter](https://github.com/Adobe-Marketing-Cloud/aem-core-wcm-components) har inbyggda funktioner som stöder ett normaliserat JSON-schema med exporterade sidor och komponenter. Alla WKND Mobile-komponenter som används i den här självstudiekursen (lista över sidor, bilder, text och innehållsfragment) kommer från AEM WCM Core Components.

## Definiera API-mallen för händelser

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL General] > [!UICONTROL Templates] >[!DNL WKND Mobile]**.

1. Skapa **[!DNL Events API]** mall:

   1. Tryck **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Välj **[!DNL WKND Mobile - Empty Page]** mall
   1. Tryck **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Retur **[!DNL Events API]** i [!UICONTROL Template Title] fält
   1. Tryck **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Tryck **[!UICONTROL Open]** öppna den nya mallen för redigering

1. Först tillåter vi de tre identifierade AEM komponenterna som vi behöver för att modellera innehållet genom att redigera [!UICONTROL Policy] av roten [!UICONTROL Layout Container]. Kontrollera **[!UICONTROL Structure]** är aktivt, välj **[!DNL Layout Container \[Root\]]** och trycker på **[!UICONTROL Policy]** -knappen.
1. Under **[!UICONTROL Properties]>[!UICONTROL Allowed Components]** sök efter **[!DNL WKND Mobile]**. Tillåt följande komponenter från [!DNL WKND Mobile] komponentgrupp så att de kan användas på [!DNL Events] API-sida.

   * **[!DNL WKND Mobile > Image]**

      * Programmets logotyp

   * **[!DNL WKND Mobile > Text]**

      * Appens introduktionstext

   * **[!DNL WKND Mobile > Content Fragment List]**

      * Listan med händelsekategorier som är tillgängliga för visning i appen

1. Tryck på **[!UICONTROL Done]** bockmarkering i det övre högra hörnet när det är klart.
1. **Uppdatera** webbläsarfönstret för att se [!UICONTROL Allowed Components] listan i den vänstra listen.
1. Dra i följande AEM komponenter från komponentsökaren i den vänstra listen:
   1. **[!DNL Image]** för logotypen
   2. **[!DNL Text]** för taggraden
   3. **[!DNL Content Fragment List]** för händelserna
1. **För var och en av komponenterna ovan**, markerar dem och trycker på **låsa upp** -knappen.
1. Se dock till att **layoutbehållare** är **låst** för att förhindra att andra komponenter läggs till eller att dessa tre komponenter tas bort.
1. Tryck **[!UICONTROL Page Information]>[!UICONTROL View in Admin]** för att gå tillbaka till [!DNL WKND Mobile] malllista. Välj den nyskapade **[!DNL Events API]** mall och knacka **[!UICONTROL Enable]** i det övre åtgärdsfältet.

>[!VIDEO](https://video.tv.adobe.com/v/28342?quality=12&learn=on)

>[!NOTE]
>
> Observera att komponenterna som används för att visa innehållet läggs till i själva mallen och låses. Detta gör att författare kan redigera de fördefinierade komponenterna, men inte godtyckligt lägga till eller ta bort komponenter eftersom en ändring av själva API:t skulle kunna bryta antagandena kring JSON-strukturen och knäcka konsumerande program. Alla API:er måste vara stabila.

## Nästa steg

Du kan också installera [com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) innehållspaket på AEM författare via [AEM](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 5 - Redigera sidor för innehållstjänster](./chapter-5.md)
