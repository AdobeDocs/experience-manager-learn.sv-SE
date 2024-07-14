---
title: Kapitel 4 - Definiera mallar för innehållstjänster - Innehållstjänster
description: Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera den JSON-innehållsstruktur AEM Content Services visar.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: ece0bf0d-c4af-4962-9c00-f2849c2d8f6f
duration: 245
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '752'
ht-degree: 0%

---

# Kapitel 4 - Definiera mallar för innehållstjänster

Kapitel 4 i AEM Headless-självstudiekursen behandlar rollen AEM redigerbara mallar i AEM Content Services. Redigerbara mallar används för att definiera JSON-innehållsstrukturen AEM Content Services exponerar för klienterna via kompositionen för Content Services-aktiverade AEM Components.

## Förstå mallarnas roll i AEM Content Services

AEM Redigerbara mallar används för att definiera de HTTP-slutpunkter som är tillgängliga för att visa händelseinnehållet som JSON.

Traditionellt AEM Redigerbara mallar används för att definiera webbsidor, men det är bara vanligt. Redigerbara mallar kan användas för att komponera **valfri**-uppsättning med innehåll. Så här kommer innehållet åt: som HTML i en webbläsare, eftersom JSON används av JavaScript (AEM redigeraren) eller en mobilapp är en funktion av hur sidan efterfrågas.

I AEM Content Services används redigerbara mallar för att definiera hur JSON-data ska visas.

För appen [!DNL WKND Mobile] skapar vi en enda redigerbar mall som används för att skapa en enda API-slutpunkt. Det här exemplet är enkelt att illustrera koncepten AEM Headless, men du kan skapa flera sidor (eller slutpunkter) där varje del visar olika uppsättningar innehåll för att skapa ett mer komplext och välorganiserat API.

## API-slutpunkten

Om du vill förstå hur du komponerar vår API-slutpunkt och förstå vilket innehåll som ska visas för vår [!DNL WKND Mobile]-app kan du låta oss gå igenom designen igen.

![API för händelser - siddisposition](./assets/chapter-4/design-to-component-mapping.png)

Som vi kan se har vi tre logiska uppsättningar innehåll att leverera till mobilappen.

1. **Logotypen**
2. **Taggraden**
3. Listan med **händelser**

För att göra detta kan vi mappa dessa krav till AEM (och i vårt fall AEM WCM Core Components) för att visa nödvändigt innehåll som JSON.

1. **Logotypen** visas via en **Image-komponent**
2. **Taggraden** visas via en **textkomponent**
3. Listan med **händelser** visas via en **Content Fragment List-komponent** som i sin tur refererar till en uppsättning med händelseinnehållsfragment.

>[!NOTE]
>
>Om du vill ha stöd AEM Content Services JSON-export av sidor och komponenter måste sidorna och komponenterna **härledas från AEM WCM Core Components**.
>
>[AEM WCM Core Components](https://github.com/Adobe-Marketing-Cloud/aem-core-wcm-components) har inbyggda funktioner som stöder ett normaliserat JSON-schema med exporterade sidor och komponenter. Alla WKND Mobile-komponenter som används i den här självstudiekursen (lista över sidor, bilder, text och innehållsfragment) kommer från AEM WCM Core-komponenter.

## Definiera API-mallen för händelser

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL General] > [!UICONTROL Templates] >[!DNL WKND Mobile]**.

1. Skapa mallen **[!DNL Events API]**:

   1. Tryck på **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Välj mallen **[!DNL WKND Mobile - Empty Page]**
   1. Tryck på **[!UICONTROL Next]** i det övre åtgärdsfältet
   1. Ange **[!DNL Events API]** i fältet [!UICONTROL Template Title]
   1. Tryck på **[!UICONTROL Create]** i det övre åtgärdsfältet
   1. Tryck på **[!UICONTROL Open]** för att öppna den nya mallen för redigering

1. Först tillåter vi att de tre identifierade AEM komponenterna vi behöver modellera innehållet genom att redigera [!UICONTROL Policy] för roten [!UICONTROL Layout Container]. Kontrollera att läget **[!UICONTROL Structure]** är aktivt, markera **[!DNL Layout Container \[Root\]]** och tryck på knappen **[!UICONTROL Policy]**.
1. Under **[!UICONTROL Properties]>[!UICONTROL Allowed Components]** söker du efter **[!DNL WKND Mobile]**. Tillåt följande komponenter från komponentgruppen [!DNL WKND Mobile] så att de kan användas på API-sidan för [!DNL Events].

   * **[!DNL WKND Mobile > Image]**

      * Programmets logotyp

   * **[!DNL WKND Mobile > Text]**

      * Appens introduktionstext

   * **[!DNL WKND Mobile > Content Fragment List]**

      * Listan med händelsekategorier som är tillgängliga för visning i appen

1. Tryck på bockmarkeringen **[!UICONTROL Done]** i det övre högra hörnet när du är klar.
1. **Uppdatera** webbläsarfönstret om du vill visa den nya listan [!UICONTROL Allowed Components] i den vänstra listen.
1. Dra i följande AEM komponenter från komponentsökaren i den vänstra listen:
   1. **[!DNL Image]** för logotypen
   2. **[!DNL Text]** för taggraden
   3. **[!DNL Content Fragment List]** för händelserna
1. **För var och en av ovanstående komponenter** markerar du dem och trycker på knappen **unlock** .
1. Se dock till att **layoutbehållaren** är **låst** för att förhindra att andra komponenter läggs till eller att dessa tre komponenter tas bort.
1. Tryck på **[!UICONTROL Page Information]>[!UICONTROL View in Admin]** för att återgå till listan med [!DNL WKND Mobile]-mallar. Markera den nyligen skapade mallen **[!DNL Events API]** och tryck på **[!UICONTROL Enable]** i det övre åtgärdsfältet.

>[!VIDEO](https://video.tv.adobe.com/v/28342?quality=12&learn=on)

>[!NOTE]
>
> Observera att komponenterna som används för att visa innehållet läggs till i själva mallen och låses. Detta gör att författare kan redigera de fördefinierade komponenterna, men inte godtyckligt lägga till eller ta bort komponenter eftersom en ändring av själva API:t skulle kunna bryta antagandena kring JSON-strukturen och knäcka konsumerande program. Alla API:er måste vara stabila.

## Nästa steg

Du kan också installera innehållspaketet [com.adobe.aem.guides.wknd-mobile.content.chapter-4.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) på AEM Author via [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 5 - Redigera sidor för innehållstjänster](./chapter-5.md)
