---
title: Välkommen till självstudiekursen om bästa praxis för Dynamic Media Classic
description: Dynamic Media Classic är navet som kunderna skapar, skapar och levererar multimediematerial runt. Denna självstudiekurs om bästa praxis har tagits fram för att hjälpa nuvarande och nya användare av Dynamic Media Classic att bättre förstå vad de kan göra med denna kraftfulla multimedielösning från Adobe. I den här delen av självstudiekursen får du lära dig vad Dynamic Media Classic är och en kort titt på dess kärnfunktioner och användargränssnitt.
sub-product: dynamiska medier
doc-type: tutorial
topics: best-practices, development, authoring, configuring
audience: all
activity: develop, use
feature: Dynamic Media Classic
topic: Innehållshantering
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '901'
ht-degree: 0%

---


# Välkommen till självstudiekursen om bästa praxis för Dynamic Media Classic

Den här guiden är avsedd att hjälpa nuvarande och nya användare av Dynamic Media Classic att bättre förstå vad de kan göra med sin kraftfulla multimedielösning från Adobe. Vi gör det genom att:

- Vi presenterar Dynamic Media Classic, beskriver vad det är och ger en översikt över dess kärnfunktioner och användargränssnitt.
- Förklara det allmänna arbetsflödet Skapa, Författare och Leverera som du kommer att följa när du arbetar med resurser i lösningen.
- Diskutera viktiga objekt som ska konfigureras innan du hoppar in och använder lösningen.
- En djupdykning i användningen av flera av lösningens kärnfunktioner.

Under hela guiden kommer vi att ge exempel, tips och bästa praxis. Vi kommer också att förklara viktiga termer och koncept som du bör känna till när du arbetar med Dynamic Media Classic. Och när det finns för ett visst ämne kan vi hänvisa dig till relevanta webbinarier, blogginlägg och onlinedokumentation.

Vi hoppas att den här guiden ger dig den information du behöver för att utnyttja din Dynamic Media Classic-lösning till fullo. Klicka på bokmärkesikonen till vänster om stödlinjen för att visa innehållet.

## Översikt över Dynamic Media Classic

Dynamic Media Classic är navet som kunderna skapar, skapar och levererar multimediematerial runt. Dynamic Media Classic är en integrerad miljö för hantering, publicering och visning av multimedia. Multimedia kan levereras till alla marknadsförings- och försäljningskanaler, inklusive webben, trycksaker, e-postkampanjer, webbapplikationer, datorer och enheter.

Bildvisning är kanske den mest använda funktionen i Dynamic Media Classic. Faktum är att de flesta kunder använder Dynamic Media Classic för att visa upp alla bilder på sina webbplatser, inklusive bilder för zoomning och multimedia. Den kan dock även användas för många andra syften, bland annat leverans av video och användning av AI för att optimera de bilder som levereras.

## Kärnfunktioner i Dynamic Media Classic

I den här guiden diskuterar vi följande viktiga funktioner i Dynamic Media Classic.

- **Dynamic Imaging.** Paraplytermen för redigering i realtid, formatering och storleksändring samt interaktiv zoom och panorering. Färg- och texturtittande. 360-graders centrifugering, bildmallar, och multimediavisare.
- **Video.** Ladda upp färdiga videor, publicera dem och ladda sedan ned dem progressivt till konfigurerbara videovisningsprogram.
- **Smart bildbehandling.** Teknik som utnyttjar Adobe Sensei AI-funktioner och fungerar med befintliga &quot;Image Presets&quot; för att förbättra bildleveransen genom att automatiskt optimera bildformat, storlek och kvalitet baserat på webbläsarens kapacitet.

Om du vill ha mer information om lösningen går du till [Dokumentation för Dynamic Media Classic](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/intro/introduction.html).

## Dynamic Media Classic User Interface (UI)

Huvudgränssnittet i Dynamic Media Classic består av tre huvudområden: det globala navigeringsfältet, resursbiblioteket och panelen Bläddra/Bygg.

![bild](assets/overview/overview-dmc-ui-ew.png)

_Dynamic Media Classic UI_

**Globalt navigeringsfält.** Överst på skärmen finns knapparna i det här fältet för att komma åt nyckelområden och funktioner i lösningen. Du kommer till exempel att använda den för att komma åt uppladdningsfunktioner, öppna olika resursuppbyggnadsområden (bilduppsättning, snurruppsättning osv.), utföra viktiga uppgifter som att konfigurera bildförinställningar och visningsförinställningar och publicera dina resurser. Här kan du också övervaka dina jobb, se de senaste aktiviteterna och välja bland en mängd olika hjälpalternativ.

**Resursbibliotek.** Längst ned till vänster på skärmen finns resursbiblioteket, en panel som du använder för att ordna dina resurser i mappar och undermappar som du skapar. Längst upp på panelen hittar du sök och filter som hjälper dig att hitta resurser. Med avancerad sökning kan du söka genom att ange flera alternativ som sökvillkor, inklusive dolda metadatafält som är kopplade till den aktuella resursen. Längst ned på panelen kan du se borttagna objekt genom att klicka på papperskorgen. Till att börja med börjar du inte med några mappar, förutom den översta mappen som har samma namn som ditt kontonamn.

>[!NOTE]
>
>Resurser i papperskorgen tas automatiskt bort permanent sju dagar efter att de placerats där, såvida du inte återställer dem.

**Panelen Bläddra/bygg.** Det här är mitten av användargränssnittet, där du antingen bläddrar bland resurser i bläddringsläge eller, om du använder det i byggläge, som en arbetsyta för att skapa resurser som en del av ett arbetsflöde. När du loggar in visas panelen Bläddra. Mitten av skärmen är miniatyrversioner av dina bilder i stödrastervyn. Du kan ändra till en listvy eller välja en resurs och visa information om den i detaljvyn.

>[!IMPORTANT]
>
>Förutom varje resurs-ID finns växeln **Mark for Publish**. När växeln är aktiverad (grön) visar det att resursen är markerad för publicering.

![bild](assets/overview/overview-mark-for-publish.png)

>[!TIP]
>
>Markera kryssrutan **Publicera efter överföring** i dialogrutan Överför för att automatiskt publicera resurser vid överföring.

Läs mer om [Navigera i användargränssnittet för Dynamic Media Classic](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/getting-started/navigation-basics.html).
