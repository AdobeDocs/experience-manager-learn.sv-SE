---
title: Kapitel 4 - Definiera mallar för innehållstjänster - Innehållstjänster
seo-title: Komma igång med AEM utan rubrik - Kapitel 4 - Definiera innehållstjänstmallar
description: Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera den JSON-innehållsstruktur AEM Content Services kommer att visa.
seo-description: Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera den JSON-innehållsstruktur AEM Content Services kommer att visa.
feature: '"Innehållsfragment, API:er"'
topic: '"Headless, Content Management"'
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '819'
ht-degree: 0%

---


# Kapitel 4 - Definiera mallar för innehållstjänster

Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera JSON-innehållsstrukturen AEM Content Services exponerar för klienterna via kompositionen för Content Services-aktiverade AEM Components.

## Förstå mallarnas roll i AEM Content Services

AEM Redigerbara mallar används för att definiera de HTTP-slutpunkter som ska användas för att visa händelseinnehållet som JSON.

Traditionellt AEM Redigerbara mallar används för att definiera webbsidor, men det här är bara vanligt. Redigerbara mallar kan användas för att skapa **valfri** uppsättning med innehåll; hur innehållet nås: som HTML i en webbläsare, som JSON används av JavaScript (AEM SPA Editor) eller en mobilapp är en funktion av hur sidan begärs.

I AEM Content Services används redigerbara mallar för att definiera hur JSON-data ska visas.

För [!DNL WKND Mobile]-appen skapar vi en enda redigerbar mall som används för att skapa en enda API-slutpunkt. Det här exemplet är enkelt att illustrera koncepten AEM Headless, men du kan skapa flera sidor (eller slutpunkter) där varje del visar olika uppsättningar innehåll för att skapa ett mer komplext och välorganiserat API.

## API-slutpunkten

Om du vill förstå hur du komponerar vår API-slutpunkt och förstå vilket innehåll som ska exponeras för vår [!DNL WKND Mobile]-app kan du låta oss gå igenom designen igen.

![Evenemang-API för dekomposition av sida](./assets/chapter-4/design-to-component-mapping.png)

Som vi kan se har vi tre logiska uppsättningar innehåll att leverera till mobilappen.

1. **Logotyp**
2. **Taggraden**
3. Listan med **händelser**

För att göra detta kan vi mappa dessa krav till AEM (och i vårt fall AEM WCM Core Components) för att visa nödvändigt innehåll som JSON.

1. **Logotypen** visas via en **Image-komponent**
2. Taggraden **** visas via en **textkomponent**
3. Listan med **händelser** visas via en **Content Fragment List-komponent** som i sin tur refererar till en uppsättning med händelseinnehållsfragment.

>[!NOTE]
>
>För att ge stöd AEM Content Services JSON-export av sidor och komponenter måste sidorna och komponenterna **härledas från AEM WCM Core Components**.
>
>[AEM WCM Core ](https://github.com/Adobe-Marketing-Cloud/aem-core-wcm-components) Components har inbyggda funktioner som stöder ett normaliserat JSON-schema med exporterade sidor och komponenter. Alla WKND Mobile-komponenter som används i den här självstudiekursen (lista över sidor, bilder, text och innehållsfragment) kommer från AEM WCM Core Components.

## Definiera API-mallen för händelser

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL General] > [!UICONTROL Templates] >[!DNL WKND Mobile]**.

1. Skapa mallen **[!DNL Events API]**:

   1. Tryck på **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Välj mallen **[!DNL WKND Mobile - Empty Page]**
   1. Tryck på **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Ange **[!DNL Events API]** i fältet [!UICONTROL Template Title]
   1. Tryck på **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Tryck på **[!UICONTROL Open]** och öppna den nya mallen för redigering

1. Först tillåter vi att de tre identifierade AEM komponenterna vi behöver modellerar innehållet genom att redigera [!UICONTROL Policy] för roten [!UICONTROL Layout Container]. Kontrollera att **[!UICONTROL Structure]**-läget är aktivt, markera **[!DNL Layout Container \[Root\]]** och tryck på **[!UICONTROL Policy]**.
1. Under **[!UICONTROL Properties]>[!UICONTROL Allowed Components]** sök efter **[!DNL WKND Mobile]**. Tillåt följande komponenter från [!DNL WKND Mobile]-komponentgruppen så att de kan användas på API-sidan för [!DNL Events].

   * **[!DNL WKND Mobile > Image]**

      * Programmets logotyp
   * **[!DNL WKND Mobile > Text]**

      * Appens introduktionstext
   * **[!DNL WKND Mobile > Content Fragment List]**

      * Listan med händelsekategorier som är tillgängliga för visning i appen



1. Tryck på bockmarkeringen **[!UICONTROL Done]** i det övre högra hörnet när du är klar.
1. **Uppdatera** webbläsarfönstret om du vill visa en ny  [!UICONTROL Allowed Components] lista i den vänstra listen.
1. Dra i följande AEM komponenter från komponentsökaren i den vänstra listen:
   1. **[!DNL Image]** för logotypen
   2. **[!DNL Text]** för taggraden
   3. **[!DNL Content Fragment List]** för händelserna
1. **För var och en av komponenterna** ovan markerar du dem och trycker på  **** upplåsningsknappen.
1. Se dock till att **layoutbehållaren** är **låst** för att förhindra att andra komponenter läggs till eller att dessa tre komponenter tas bort.
1. Tryck på **[!UICONTROL Page Information]>[!UICONTROL View in Admin]** för att återgå till listan med [!DNL WKND Mobile] mallar. Markera den nyligen skapade **[!DNL Events API]**-mallen och tryck på **[!UICONTROL Enable]** i det övre åtgärdsfältet.

>[!VIDEO](https://video.tv.adobe.com/v/28342/?quality=12&learn=on)

>[!NOTE]
>
> Observera att komponenterna som används för att visa innehållet läggs till i själva mallen och låses. Detta gör att författare kan redigera de fördefinierade komponenterna, men inte godtyckligt lägga till eller ta bort komponenter eftersom en ändring av själva API:t skulle kunna bryta antagandena kring JSON-strukturen och knäcka konsumerande program. Alla API:er måste vara stabila.

## Nästa steg

Du kan också installera [com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)-innehållspaketet på AEM Author via [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 5 - Sidor för redigering av innehållstjänster](./chapter-5.md)
