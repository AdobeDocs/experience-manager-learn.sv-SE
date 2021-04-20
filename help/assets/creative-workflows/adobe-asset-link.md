---
title: Använda Adobe Asset Link Extension med AEM Assets
description: 'Adobe Experience Manager resurser kan nu användas av designers och kreativa användare i Adobe Creative Cloud favoritprogram. Tillägget Adobe Asset Link för Adobe Creative Cloud Enterprise utökar möjligheten att söka efter och bläddra bland, sortera, förhandsgranska, ladda upp resurser, checka ut, ändra, checka in och visa metadata för AEM resurser i Creative Cloud-verktyg som Adobe Photoshop, InDesign och Illustrator. '
feature: Adobe Asset Link
version: 6.4, 6.5
topic: Content Management
role: Business Practitioner
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '1102'
ht-degree: 0%

---


# Använda Adobe Asset Link Extension med AEM Assets{#using-adobe-asset-link-extension-with-aem-assets}

Adobe Experience Manager resurser kan nu användas av designers och kreativa användare i Adobe Creative Cloud favoritprogram. Tillägget Adobe Asset Link för Adobe Creative Cloud Enterprise utökar möjligheten att söka efter och bläddra bland, sortera, förhandsgranska, ladda upp resurser, checka ut, ändra, checka in och visa metadata för AEM resurser i Creative Cloud-verktyg som Adobe Photoshop, InDesign och Illustrator.


## Adobe Asset Link 1.1

Adobe Asset Link v1.1 har nu stöd för direktlänkning mellan Adobe Asset Link och AEM Assets i InDesign. Med stöd för direktlänkning från InDesign kan du nu montera (montera länkat eller montera kopia) eller dra-och-släppa digitala resurser till InDesign från AEM Assets via panelen Länk till Adobe. Dessutom introducerar återgivningen av *Endast för placering* (FPO).

>[!VIDEO](https://video.tv.adobe.com/v/28988/?quality=12&learn=on)

>[!NOTE]
>
>Använd endast Adobe Creative Cloud-Enterprise ID eller Federated ID. Se till att du [konfigurerar AEM för Adobe Asset Link](https://helpx.adobe.com/enterprise/admin-guide.html/enterprise/using/adobe-asset-link.ug.html).


### Adobe Asset Link-funktioner

* Adobe Asset Link är ett tillägg som fungerar i PS, AI och ID och ger direkt åtkomst till digitala resurser som finns i AEM Assets
* Kreatörerna loggas in AEM automatiskt med sitt Adobe IMS-Enterprise ID eller Federated ID
* Kreatörer kan bläddra bland digitala resurser som finns i AEM Assets, förutom att söka bland AEM Assets- och Creative Cloud-resurser
* Kreatörerna kan få tillgång till filinformation om mediefiler som finns i AEM Assets. miniatyrbilder, grundläggande metadata och versioner inifrån panelen
* Kreatörer kan montera, ladda ned eller dra-och-släppa resurser i sin layout
* Kreatörer kan ändra mediefiler genom att checka ut dem från AEM Assets och arbeta med dem (PIA) i Creative Cloud Assets-kontot
* Kreatörer kan checka in en mediefil i AEM Assets när de har ändrat den och den nya versionen återspeglas i AEM Assets
* Stöder datorprogrammen Creative Cloud 2020, 2019 och 2018 InDesign, Photoshop och Illustrator
* En användare kan göra en resurssökning från panelen Adobe Asset Link In-App och sortera dem baserat på storlek, i bokstavsordning och relevans
* Användare kan komma åt och bläddra bland AEM Assets-samlingar och smarta samlingar direkt från panelen Resurslänk
* Lägg till nyskapade resurser i AEM Assets direkt från panelen
* En användare kan dra och släppa resurser direkt i InDesign-bildrutor

### Placera AEM Assets i InDesign

Du kan montera en resurs i din InDesign-layout med något av följande alternativ:

* **Montera kopia**  - När du bäddar in en resurs (med alternativet Montera kopia) placeras en kopia av den ursprungliga resursen i InDesign-layouten när binärfilerna har hämtats till det lokala systemet. Adobe Asset Link bevarar ingen länk mellan den inbäddade kopian och den ursprungliga resursen. Om den ursprungliga resursen ändras i AEM Assets måste du ta bort den inbäddade resursen från InDesign-filen och bädda in resursen på nytt från AEM Assets.

* **Montera länkad**  - När du arbetar med InDesign-dokument kan du nu välja att referera till resurser från AEM Assets förutom att direkt bädda in resurserna (med alternativet Montera kopia på snabbmenyn). Genom att referera till resurser kan du samarbeta med andra användare och införliva eventuella uppdateringar som gjorts av originalresursen i AEM Assets. Om du vill referera till en resurs från AEM Assets använder du alternativet Montera länkad på snabbmenyn.

### För upplösning av endast placering (FPO)

När stora resursfiler placeras i InDesign-dokument från AEM Assets med Adobe Asset Link måste användare vänta i några sekunder efter att monteringen initierats. Detta påverkar den övergripande användarupplevelsen. Med Adobe Asset Link kan du nu tillfälligt montera en lågupplöst bild av den ursprungliga resursen från AEM Assets, vilket minskar tiden det tar att montera en bild. Samtidigt ökar det den övergripande användarupplevelsen och produktiviteten. Bilden med lägre upplösning placeras tillfälligt och när den slutliga versionen krävs för utskrift eller publicering måste du ersätta FPO-återgivningarna med originalen. Om du vill ersätta flera FPO-bilder med respektive originalbilder går du till panelen **_Fönster > Länkar_** och hämtar sedan originalresurserna. När originalbilderna har laddats ned väljer du Ersätt alla FPO:er med original.

>[!NOTE]
>
> *För FPO-* återgivning (Placement Only) fungerar endast för alternativet Montera länkad. Du bör även aktivera stöd för FPO-återgivning i arbetsflödet för AEM Assets *Dam Update Asset*.

FPO-återgivningar är enkla ersättningar av de ursprungliga resurserna. De har samma proportioner, men har mindre storlek än originalbilderna. För närvarande stöder InDesign import av FPO-renderingar endast för följande bildtyper:

* JPEG
* GIF
* PNG
* TIFF
* PSD
* BMP

Om en FPO-återgivning inte är tillgänglig för en viss resurs i AEM Assets refereras den ursprungliga högupplösta resursen i stället. För FPO-bilder visas status FPO på länkpanelen i InDesign.

## Om autentisering med Adobe Asset Link med AEM Assets{#understanding-adobe-asset-link-authentication-with-aem-assets}

Hur Adobe Asset Link-autentisering fungerar i samband med Adobe Identity Management Services (IMS) och Adobe Experience Manager Author.

![Adobe Asset Link Architecture](assets/adobe-asset-link-article-understand.png)

Hämta [arkitekturen för Adobe Asset Link](assets/adobe-asset-link-article-understand-1.png)

1. Tillägget Adobe Asset Link skickar en auktoriseringsbegäran via Adobe Creative Cloud-datorprogrammet till IMS-tjänsten (Adobe Identity Manage Service) och får en Bearer-token när den lyckas.
2. Tillägget Adobe Asset Link ansluter till AEM Author via HTTP(S), inklusive den Bearer-token som fås i **Steg 1**, med schemat (HTTP/HTTPS), värd och port som finns i tilläggets JSON-inställningar.
3. AEM Bearer Authentication Handler extraherar Bearer-token från begäran och validerar den mot Adobe IMS.
4. När Adobe IMS validerar Bearer-token skapas en användare i AEM (om den inte redan finns) och synkroniserar profil- och grupp-/medlemskapsdata från Adobe IMS. Den AEM användaren får en AEM inloggningstoken som skickas tillbaka till tillägget Adobe Asset Link som cookie i HTTP(S)-svaret.
5. Efterföljande interaktioner (t.ex. bläddra, söka, checka in/ut resurser osv.) med tillägget Adobe Asset Link resulterar i HTTP(S)-begäranden till AEM Author som valideras med AEM inloggningstoken, med hjälp av AEM Token Authentication Handler.

>[!NOTE]
>
>När inloggningstoken har upphört att gälla anropas **steg 1-5** automatiskt, Adobe Asset Link-tillägget autentiseras med Bearer-token och en ny, giltig inloggningstoken utfärdas på nytt.

## Ytterligare resurser{#additional-resources}

* [Adobe Asset Link-webbplatsen](https://www.adobe.com/creativecloud/business/enterprise/adobe-asset-link.html)