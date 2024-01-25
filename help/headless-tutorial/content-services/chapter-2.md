---
title: Kapitel 2 - Definiera fragmentmodeller för händelseinnehåll - Innehållstjänster
description: Kapitel 2 i den AEM självstudiekursen Headless handlar om att aktivera och definiera Content Fragment-modeller som används för att definiera en normaliserad datastruktur och ett redigeringsgränssnitt för att skapa händelser.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: 8b05fc02-c0c5-48ad-a53e-d73b805ee91f
duration: 421
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '807'
ht-degree: 0%

---

# Kapitel 2 - Använda modeller för innehållsfragment

AEM Content Fragment Models definierar innehållsscheman som kan användas för att mallsidigt skapa Raw-innehåll AEM författare. Det här arbetssättet liknar skalning och formulärbaserad redigering. Nyckelkonceptet med innehållsfragment är det innehåll som skapas är presentationsagnostikbaserat, vilket innebär att det är avsett för flerkanalsanvändning där det krävande programmet, t.ex. AEM, ett program med en sida eller en mobilapp, styr hur innehållet visas för användaren.

Det främsta syftet med innehållsfragmentet är att se till att

1. Rätt innehåll samlas in från författaren
2. Innehållet kan visas i ett strukturerat, välförstått format för att användas i olika program.

I det här kapitlet beskrivs hur du aktiverar och definierar Content Fragment-modeller som används för att definiera en normaliserad datastruktur och redigeringsgränssnitt för modellering och för att skapa&quot;händelser&quot;.

## Aktivera modeller för innehållsfragment

Modeller för innehållsfragment **måste** aktiveras via **[AEM [!UICONTROL Configuration Browser]](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/configurations.html)**.

Om modeller för innehållsfragment är **not** aktiverad för en konfiguration **[!UICONTROL Create]>[!UICONTROL Content Fragment]** visas inte för den aktuella AEM-konfigurationen.

>[!NOTE]
>
>AEM är en uppsättning [kontextmedvetna klientkonfigurationer](https://sling.apache.org/documentation/bundles/context-aware-configuration/context-aware-configuration.html) lagras under `/conf`. Vanligtvis AEM konfigurationer korrelerar med en viss webbplats som hanteras i AEM Sites eller en affärsenhet som ansvarar för en underuppsättning av innehåll (resurser, sidor osv.) AEM.
>
>För att en konfiguration ska kunna påverka en innehållshierarki måste det finnas referenser till konfigurationen via `cq:conf` på den innehållshierarkin. (Detta uppnås för [!DNL WKND Mobile] konfiguration i **Steg 5** nedan).
>
>När `global` konfigurationen används, konfigurationen gäller allt innehåll, och `cq:conf` behöver inte anges.
>
>Se [[!UICONTROL Configuration Browser] dokumentation](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/configurations.html) för mer information.

1. Logga in på AEM författare som en användare med tillräcklig behörighet för att ändra den relevanta konfigurationen.
   * För den här självstudiekursen **admin** kan användas.
1. Navigera till **[!UICONTROL Tool]> [!UICONTROL General] >[!UICONTROL Configuration Browser]**
1. Tryck på **mappikon** nästa **[!DNL WKND Mobile]** för att markera och sedan trycka på **[!UICONTROL Edit]knapp** överst till vänster.
1. Välj **[!UICONTROL Content Fragment Models]** och trycka **[!UICONTROL Save & Close]** längst upp till höger.

   Detta aktiverar Content Fragment Models på innehållsträd i resursmappen som har [!DNL WKND Mobile] konfiguration används.

   >[!NOTE]
   >
   >Den här konfigurationsändringen går inte att ångra från [!UICONTROL AEM Configuration] Webbgränssnitt. Så här ångrar du den här konfigurationen:
   >    
   >    1. Öppna [CRXDE Lite](http://localhost:4502/crx/de)
   >    1. Navigera till `/conf/wknd-mobile/settings/dam/cfm`
   >    1. Ta bort `models` nod
   >    
   >Alla befintliga modeller för innehållsfragment som skapas med den här konfigurationen tas bort, och deras definitioner lagras under `/conf/wknd-mobile/settings/dam/cfm/models`.

1. Använd **[!DNL WKND Mobile]** till **[!DNL WKND Mobile]Resursmapp** om du vill tillåta att innehållsfragment från modeller för innehållsfragment skapas i mapphierarkin för resurser:

   1. Navigera till **[!UICONTROL AEM]> [!UICONTROL Assets] >[!UICONTROL Files]**
   1. Välj **[!UICONTROL WKND Mobile]mapp**
   1. Tryck på **[!UICONTROL Properties]** knappen i det övre åtgärdsfältet för att öppna [!UICONTROL Folder Properties]
   1. I [!UICONTROL Folder Properties], tryck på **[!UICONTROL Cloud Services]** tab
   1. Verifiera **[!UICONTROL Cloud Configuration]** fältet är inställt på **/conf/wknd-mobile**
   1. Tryck **[!UICONTROL Save & Close]** i det övre högra hörnet om du vill behålla ändringarna

>[!VIDEO](https://video.tv.adobe.com/v/28336?quality=12&learn=on)

>[!WARNING]
>
> __Modeller för innehållsfragment__ har flyttats från __Verktyg > Resurser__ till __Verktyg > Allmänt__.

## Förstå innehållsfragmentmodellen som ska skapas

Innan vi definierar vår Content Fragment-modell ska vi granska upplevelsen vi ska köra för att säkerställa att vi hämtar alla nödvändiga datapunkter. Därför ska vi gå igenom designen av mobilappar och mappa designelementen till innehåll som ska samlas in.

Vi kan dela upp datapunkter som definierar en händelse på följande sätt:

![Skapa innehållsfragmentmodellen](assets/chapter-2/design-to-model-mapping.png)

Med mappningen kan vi definiera innehållsfragment som används för att samla in och exponera händelsedata.

## Skapa innehållsfragmentmodellen

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL General] >[!UICONTROL Content Fragment Models]**.
1. Tryck på **[!DNL WKND Mobile]** mapp att öppna.
1. Tryck **[!UICONTROL Create]** om du vill öppna guiden Skapa innehållsfragmentmodell.
1. Retur **[!DNL Event]** som **[!UICONTROL Model Title]** *(description is optional)* och knacka **[!UICONTROL Create]** att spara.

>[!VIDEO](https://video.tv.adobe.com/v/28337?quality=12&learn=on)

## Definiera strukturen för innehållsfragmentmodellen

1. Navigera till **[!UICONTROL Tools]> [!UICONTROL General] > [!UICONTROL Content Fragment Models] >[!DNL WKND]**.
1. Välj **[!DNL Event]** Content Fragment Model och tryck **[!UICONTROL Edit]** i det övre åtgärdsfältet.
1. Från **[!UICONTROL Data Types]tab** till höger drar du **[!UICONTROL Single line text input]** till vänster släppzon för att definiera **[!DNL Question]** fält.
1. Se till att nya **[!UICONTROL Single line text input]** markeras till vänster och **[!UICONTROL Properties]tab** är markerat till höger. Fyll i egenskapsfälten enligt följande:

   * [!UICONTROL Render As] : `textfield`
   * [!UICONTROL Field Label] : `Event Title`
   * [!UICONTROL Property Name] : `eventTitle`
   * [!UICONTROL Max Length] : 25
   * [!UICONTROL Required] : `Yes`

Upprepa dessa steg med indatadefinitionerna som definieras nedan för att skapa resten av Event Content Fragment Model.

>[!NOTE]
>
> The **Egenskapsnamn** fälten MÅSTE matcha exakt eftersom Android-programmet är programmerat för att göra dessa namn transparenta.

### Händelsebeskrivning

* [!UICONTROL Data Type] : `Multi-line text`
* [!UICONTROL Field Label] : `Event Description`
* [!UICONTROL Property Name] : `eventDescription`
* [!UICONTROL Default Type] : `Rich text`

### Datum och tid för händelse

* [!UICONTROL Data Type] : `Date and time`
* [!UICONTROL Field Label] : `Event Date and Time`
* [!UICONTROL Property Name] : `eventDateAndTime`
* [!UICONTROL Required] : `Yes`

### Händelsetyp

* [!UICONTROL Data Type] : `Enumeration`
* [!UICONTROL Field Label] : `Event Type`
* [!UICONTROL Property Name] : `eventType`
* [!UICONTROL Options] : `Art,Music,Performance,Photography`

### Biljettpris

* [!UICONTROL Data Type] : `Number`
* [!UICONTROL Render As] : `numberfield`
* [!UICONTROL Field Label] : `Ticket Price`
* [!UICONTROL Property Name] : `eventPrice`
* [!UICONTROL Type] : `Integer`
* [!UICONTROL Required] : `Yes`

### Händelseavbildning

* [!UICONTROL Data Type] : `Content Reference`
* [!UICONTROL Render As] : `contentreference`
* [!UICONTROL Field Label] : `Event Image`
* [!UICONTROL Property Name] : `eventImage`
* [!UICONTROL Root Path] : `/content/dam/wknd-mobile/images`
* [!UICONTROL Required] : `Yes`

### Platsnamn

* [!UICONTROL Data Type] : `Single-line text`
* [!UICONTROL Render As] : `textfield`
* [!UICONTROL Field Label] : `Venue Name`
* [!UICONTROL Property Name] : `venueName`
* [!UICONTROL Max Length] : 20
* [!UICONTROL Required] : `Yes`

### Ort

* [!UICONTROL Data Type] : `Enumeration`
* [!UICONTROL Field Label] : `Venue City`
* [!UICONTROL Property Name] : `venueCity`
* [!UICONTROL Options] : `Basel,London,Los Angeles,Paris,New York,Tokyo`

>[!VIDEO](https://video.tv.adobe.com/v/28335?quality=12&learn=on)

>[!NOTE]
>
>The **[!UICONTROL Property Name]** anger **båda** JCR-egenskapsnamnet där värdet lagras samt nyckeln i JSON-filen. Det ska vara ett semantiskt namn som inte ändras under Content Fragment Model.

När du är klar med att skapa innehållsfragmentmodellen bör du avsluta med en definition som ser ut så här:


![Modell för händelseinnehållsfragment](assets/chapter-2/event-content-fragment-model.png)

## Nästa steg

Du kan också installera [com.adobe.aem.guides.wknd-mobile.content.chapter-2.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) innehållspaket på AEM författare via [AEM](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i den här delen av självstudiekursen.

* [Kapitel 3 - Innehållsfragment för redigeringshändelse](./chapter-3.md)
