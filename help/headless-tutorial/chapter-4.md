---
title: Kapitel 4 - Definiera mallar för innehållstjänster
seo-title: Komma igång med AEM utan rubrik - Kapitel 4 - Definiera innehållstjänstmallar
description: Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera den JSON-innehållsstruktur AEM Content Services kommer att visa.
seo-description: Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera den JSON-innehållsstruktur AEM Content Services kommer att visa.
translation-type: tm+mt
source-git-commit: 22ccd6627a035b37edb180eb4633bc3b57470c0c
workflow-type: tm+mt
source-wordcount: '809'
ht-degree: 0%

---


# Kapitel 4 - Definiera mallar för innehållstjänster

Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera JSON-innehållsstrukturen AEM Content Services exponerar för klienterna via kompositionen för Content Services-aktiverade AEM Components.

## Förstå mallarnas roll i AEM Content Services

AEM Redigerbara mallar används för att definiera de HTTP-slutpunkter som ska användas för att visa händelseinnehållet som JSON.

Traditionellt AEM Redigerbara mallar används för att definiera webbsidor, men det här är bara vanligt. Redigerbara mallar kan användas för att skapa **alla** typer av innehåll. hur innehållet nås: som HTML i en webbläsare, som JSON används av JavaScript (AEM SPA Editor) eller en mobilapp är en funktion av hur sidan begärs.

I AEM Content Services används redigerbara mallar för att definiera hur JSON-data ska visas.

För [!DNL WKND Mobile] appen skapar vi en enda redigerbar mall som används för att skapa en enda API-slutpunkt. Det här exemplet är enkelt att illustrera koncepten AEM Headless, men du kan skapa flera sidor (eller slutpunkter) där varje del visar olika uppsättningar innehåll för att skapa ett mer komplext och välorganiserat API.

## API-slutpunkten

För att förstå hur vi skapar API-slutpunkten och förstå vilket innehåll som ska visas för vår [!DNL WKND Mobile] app kan vi gå igenom designen igen.

![Evenemang-API för dekomposition av sida](./assets/chapter-4/design-to-component-mapping.png)

Som vi kan se har vi tre logiska uppsättningar innehåll att leverera till mobilappen.

1. The **Logo**
2. Tagglinjen ****
3. Listan med **händelser**

För att göra detta kan vi mappa dessa krav till AEM (och i vårt fall AEM WCM Core Components) för att visa nödvändigt innehåll som JSON.

1. Logotypen **visas via en** **bildkomponent**
2. Taggraden **visas via en** **textkomponent**
3. Listan med **händelser** visas via en **Content Fragment List-komponent** som i sin tur refererar till en uppsättning med händelseinnehållsfragment.

>[!NOTE]
>
>För att ge stöd AEM Content Services JSON-export av sidor och komponenter måste sidorna och komponenterna **härledas AEM WCM-kärnkomponenter**.
>
>[AEM WCM Core Components](https://github.com/Adobe-Marketing-Cloud/aem-core-wcm-components) har inbyggda funktioner som stöder ett normaliserat JSON-schema med exporterade sidor och komponenter. Alla WKND Mobile-komponenter som används i den här självstudiekursen (lista över sidor, bilder, text och innehållsfragment) kommer från AEM WCM Core Components.

## Definiera API-mallen för händelser

1. Navigera till **[!UICONTROL Tools]>[!UICONTROL General]>[!UICONTROL Templates]>[!DNL WKND Mobile]**.

1. Skapa **[!DNL Events API]** mallen:

   1. Tryck **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Select the **[!DNL WKND Mobile - Empty Page]** template
   1. Tryck **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Ange **[!DNL Events API]** i [!UICONTROL Template Title] fältet
   1. Tryck **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Tryck på **[!UICONTROL Open]** öppna den nya mallen för redigering

1. För det första tillåter vi att de tre identifierade AEM komponenterna vi behöver modellerar innehållet genom att redigera [!UICONTROL Policy] roten [!UICONTROL Layout Container]. Kontrollera att **[!UICONTROL Structure]** läget är aktivt, markera **[!DNL Layout Container \[Root\]]** och tryck på **[!UICONTROL Policy]** knappen.
1. Under **[!UICONTROL Properties]>[!UICONTROL Allowed Components]** sök efter **[!DNL WKND Mobile]**. Tillåt följande komponenter från [!DNL WKND Mobile] komponentgruppen så att de kan användas på API-sidan [!DNL Events] .

   * **[!DNL WKND Mobile > Image]**

      * Programmets logotyp
   * **[!DNL WKND Mobile > Text]**

      * Appens introduktionstext
   * **[!DNL WKND Mobile > Content Fragment List]**

      * Listan med händelsekategorier som är tillgängliga för visning i appen



1. Tryck på **[!UICONTROL Done]** bockmarkeringen i det övre högra hörnet när du är klar.
1. **Uppdatera** webbläsarfönstret för att se den nya [!UICONTROL Allowed Components] listan i den vänstra listen.
1. Dra i följande AEM komponenter från komponentsökaren i den vänstra listen:
   1. **[!DNL Image]** för logotypen
   2. **[!DNL Text]** för taggraden
   3. **[!DNL Content Fragment List]** för händelserna
1. **För var och en av komponenterna** ovan markerar du dem och trycker på **upplåsningsknappen** .
1. Se dock till att **layoutbehållaren** är **låst** för att förhindra att andra komponenter läggs till eller att dessa tre komponenter tas bort.
1. Tryck **[!UICONTROL Page Information]>[!UICONTROL View in Admin]** för att gå tillbaka till [!DNL WKND Mobile] malllistan. Markera den nya **[!DNL Events API]** mallen och tryck **[!UICONTROL Enable]** i det övre åtgärdsfältet.

>[!VIDEO](https://video.tv.adobe.com/v/28342/?quality=12&learn=on)

>[!NOTE]
>
> Observera att komponenterna som används för att visa innehållet läggs till i själva mallen och låses. Detta gör att författare kan redigera de fördefinierade komponenterna, men inte godtyckligt lägga till eller ta bort komponenter eftersom en ändring av själva API:t skulle kunna bryta antagandena kring JSON-strukturen och knäcka konsumerande program. Alla API:er måste vara stabila.

## Nästa steg

Du kan också installera [com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) -innehållspaketet på AEM Author via [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 5 - Sidor för redigering av innehållstjänster](./chapter-5.md)
