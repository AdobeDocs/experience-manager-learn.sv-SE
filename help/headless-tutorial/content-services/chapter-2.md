---
title: Kapitel 2 - Definiera fragmentmodeller för händelseinnehåll - Innehållstjänster
seo-title: Komma igång med AEM Content Services - Kapitel 2 - Definiera fragmentmodeller för händelseinnehåll
description: Kapitel 2 i den AEM självstudiekursen Headless handlar om att aktivera och definiera Content Fragment-modeller som används för att definiera en normaliserad datastruktur och ett redigeringsgränssnitt för att skapa händelser.
seo-description: Kapitel 2 i den AEM självstudiekursen Headless handlar om att aktivera och definiera Content Fragment-modeller som används för att definiera en normaliserad datastruktur och ett redigeringsgränssnitt för att skapa händelser.
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '865'
ht-degree: 1%

---


# Kapitel 2 - Använda modeller för innehållsfragment

AEM Content Fragment Models definierar innehållsscheman som kan användas för att mallsidigt skapa Raw-innehåll AEM författare. Det här arbetssättet liknar skalning och formulärbaserad redigering. Nyckelkonceptet med innehållsfragment är det innehåll som skapas är presentationsagnostikbaserat, vilket innebär att det är avsett för flerkanalsanvändning där det krävande programmet, t.ex. AEM, ett program med en sida eller en mobilapp, styr hur innehållet visas för användaren.

Det främsta syftet med innehållsfragmentet är att se till att

1. Rätt innehåll samlas in från författaren
2. Innehållet kan visas i ett strukturerat, välförstått format för att användas i olika program.

I det här kapitlet beskrivs hur du aktiverar och definierar Content Fragment-modeller som används för att definiera en normaliserad datastruktur och redigeringsgränssnitt för modellering och för att skapa&quot;händelser&quot;.

## Aktivera modeller för innehållsfragment

Modeller för innehållsfragment **måste** aktiveras via **[AEM [!UICONTROL Configuration Browser]](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/developing/configurations.html)**.

Om Content Fragment Models är **inte** aktiverat för en konfiguration visas inte knappen **[!UICONTROL Create]>[!UICONTROL Content Fragment]** för den aktuella AEM.

>[!NOTE]
>
>AEM representerar en uppsättning [kontextmedvetna klientkonfigurationer](https://sling.apache.org/documentation/bundles/context-aware-configuration/context-aware-configuration.html) som lagras under `/conf`. Vanligtvis AEM konfigurationer korrelerar med en viss webbplats som hanteras i AEM Sites eller en affärsenhet som ansvarar för en underuppsättning av innehåll (resurser, sidor osv.) AEM.
>
>För att en konfiguration ska kunna påverka en innehållshierarki måste det finnas en referens till konfigurationen via egenskapen `cq:conf` i den innehållshierarkin. (Detta uppnås för [!DNL WKND Mobile]-konfigurationen i **steg 5** nedan).
>
>När `global`-konfigurationen används gäller konfigurationen allt innehåll och `cq:conf` behöver inte anges.
>
>Mer information finns i [[!UICONTROL Configuration Browser]-dokumentationen](https://docs.adobe.com/content/help/en/experience-manager-cloud-service/implementing/developing/configurations.html).

1. Logga in på AEM Author som användare med tillräcklig behörighet för att ändra konfigurationen.
   * I den här självstudiekursen kan du använda **admin**-användaren.
1. Navigera till **[!UICONTROL Tool]> [!UICONTROL General] >[!UICONTROL Configuration Browser]**
1. Tryck på **mappikonen** bredvid **[!DNL WKND Mobile]** för att markera och tryck sedan på knappen **[!UICONTROL Edit]** i det övre vänstra hörnet.
1. Välj **[!UICONTROL Content Fragment Models]** och tryck på **[!UICONTROL Save & Close]** i det övre högra hörnet.

   Detta aktiverar innehållsfragmentsmodeller i innehållsträden i resursmappen som har [!DNL WKND Mobile]-konfigurationen tillämpad.

   >[!NOTE]
   >
   >Den här konfigurationsändringen går inte att ångra från webbgränssnittet för [!UICONTROL AEM Configuration]. Så här ångrar du konfigurationen:
   >    
   >    1. Öppna [CRXDE Lite](http://localhost:4502/crx/de)
   >    1. Navigera till `/conf/wknd-mobile/settings/dam/cfm`
   >    1. Ta bort noden `models`

   >    
   >Alla befintliga modeller för innehållsfragment som skapas med den här konfigurationen tas bort, och deras definitioner lagras under `/conf/wknd-mobile/settings/dam/cfm/models`.

1. Använd **[!DNL WKND Mobile]**-konfigurationen i resursmappen **[!DNL WKND Mobile]** för att tillåta att innehållsfragment från modeller för innehållsfragment skapas i resursmapphierarkin:

   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] >[!UICONTROL Files]**
   1. Välj mappen **[!UICONTROL WKND Mobile]**
   1. Tryck på knappen **[!UICONTROL Properties]** i det övre åtgärdsfältet för att öppna [!UICONTROL Folder Properties]
   1. Tryck på fliken **[!UICONTROL Cloud Services]** i [!UICONTROL Folder Properties]
   1. Kontrollera att fältet **[!UICONTROL Cloud Configuration]** är inställt på **/conf/wknd-mobile**
   1. Tryck på **[!UICONTROL Save & Close]** i det övre högra hörnet om du vill behålla ändringarna

>[!VIDEO](https://video.tv.adobe.com/v/28336/?quality=12&learn=on)

## Förstå innehållsfragmentmodellen som ska skapas

Innan vi definierar modellen för innehållsfragment ska vi granska den upplevelse vi ska köra för att säkerställa att vi hämtar alla nödvändiga datapunkter. Därför ska vi gå igenom designen av mobilappar och mappa designelementen till innehåll som ska samlas in.

Vi kan dela upp datapunkter som definierar en händelse på följande sätt:

![Skapa innehållsfragmentmodellen](assets/chapter-2/design-to-model-mapping.png)

Med mappningen kan vi definiera innehållsfragment som ska användas för att samla in och visa händelsedata.

## Skapa innehållsfragmentmodellen

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL Assets] >[!UICONTROL Content Fragment Models]**.
1. Tryck på mappen **[!DNL WKND Mobile]** för att öppna den.
1. Tryck på **[!UICONTROL Create]** för att öppna guiden Skapa innehållsfragmentmodell.
1. Ange **[!DNL Event]** som **[!UICONTROL Model Title]** *(description is optional)* och tryck på **[!UICONTROL Create]** för att spara.

>[!VIDEO](https://video.tv.adobe.com/v/28337/?quality=12&learn=on)

## Definiera strukturen för innehållsfragmentmodellen

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL Assets] > [!UICONTROL Content Fragment Models] >[!DNL WKND]**.
1. Markera **[!DNL Event]** Content Fragment Model och tryck på **[!UICONTROL Edit]** i det övre åtgärdsfältet.
1. På fliken **[!UICONTROL Data Types]till höger drar du **[!UICONTROL Single line text input]**till den vänstra släppzonen för att definiera fältet **[!DNL Question]**.**
1. Kontrollera att den nya **[!UICONTROL Single line text input]** är markerad till vänster och att fliken **[!UICONTROL Properties]** är markerad till höger. Fyll i egenskapsfälten enligt följande:

   * [!UICONTROL Render As] : `textfield`
   * [!UICONTROL Field Label] :  `Event Title`
   * [!UICONTROL Property Name] :  `eventTitle`
   * [!UICONTROL Max Length] : 25
   * [!UICONTROL Required] :  `Yes`

Upprepa dessa steg med indatadefinitionerna som definieras nedan för att skapa resten av Event Content Fragment Model.

>[!NOTE]
>
> Fälten **Egenskapsnamn** MÅSTE matcha exakt eftersom Android-programmet är programmerat för att göra namnen transparenta.

### Händelsebeskrivning

* [!UICONTROL Data Type] :  `Multi-line text`
* [!UICONTROL Field Label] :  `Event Description`
* [!UICONTROL Property Name] :  `eventDescription`
* [!UICONTROL Default Type] :  `Rich text`

### Datum och tid för händelse

* [!UICONTROL Data Type] :  `Date and time`
* [!UICONTROL Field Label] :  `Event Date and Time`
* [!UICONTROL Property Name] :  `eventDateAndTime`
* [!UICONTROL Required] :  `Yes`

### Händelsetyp

* [!UICONTROL Data Type] :  `Enumeration`
* [!UICONTROL Field Label] :  `Event Type`
* [!UICONTROL Property Name] :  `eventType`
* [!UICONTROL Options] :  `Art,Music,Performance,Photography`

### Biljettpris

* [!UICONTROL Data Type] :  `Number`
* [!UICONTROL Render As] :  `numberfield`
* [!UICONTROL Field Label] :  `Ticket Price`
* [!UICONTROL Property Name] :  `eventPrice`
* [!UICONTROL Type] :  `Integer`
* [!UICONTROL Required] :  `Yes`

### Händelseavbildning

* [!UICONTROL Data Type] :  `Content Reference`
* [!UICONTROL Render As] :  `contentreference`
* [!UICONTROL Field Label] :  `Event Image`
* [!UICONTROL Property Name] :  `eventImage`
* [!UICONTROL Root Path] :  `/content/dam/wknd-mobile/images`
* [!UICONTROL Required] :  `Yes`

### Platsnamn

* [!UICONTROL Data Type] :  `Single-line text`
* [!UICONTROL Render As] :  `textfield`
* [!UICONTROL Field Label] :  `Venue Name`
* [!UICONTROL Property Name] :  `venueName`
* [!UICONTROL Max Length] : 20
* [!UICONTROL Required] :  `Yes`

### Ort

* [!UICONTROL Data Type] :  `Enumeration`
* [!UICONTROL Field Label] :  `Venue City`
* [!UICONTROL Property Name] :  `venueCity`
* [!UICONTROL Options] :  `Basel,London,Los Angeles,Paris,New York,Tokyo`

>[!VIDEO](https://video.tv.adobe.com/v/28335/?quality=12&learn=on)

>[!NOTE]
>
>**[!UICONTROL Property Name]** betecknar både **JCR-egenskapsnamnet där det här värdet ska lagras och nyckeln i JSON-filen.** Det ska vara ett semantiskt namn som inte ändras under Content Fragment Model.

När du är klar med att skapa innehållsfragmentmodellen bör du avsluta med en definition som ser ut så här:


![Modell för händelseinnehållsfragment](assets/chapter-2/event-content-fragment-model.png)

## Nästa steg

Du kan också installera [com.adobe.aem.guides.wknd-mobile.content.chapter-2.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)-innehållspaketet på AEM Author via [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i den här delen av självstudiekursen.

* [Kapitel 3 - Innehållsfragment för redigeringshändelse](./chapter-3.md)
