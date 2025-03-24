---
title: Adobe Asset Link och AEM
description: Adobe Experience Manager resurser kan användas av designers och kreativa användare i Adobe Creative Cloud favoritprogram. Tillägget Adobe Asset Link för Adobe Creative Cloud for enterprise ger möjlighet att söka efter och bläddra bland, sortera, förhandsgranska, överföra resurser, checka ut, ändra, checka in och visa metadata för AEM-resurser i Creative Cloud-verktyg som Adobe XD, Photoshop, InDesign och Illustrator.
feature: Adobe Asset Link
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
topic: Content Management
role: User
level: Beginner
thumbnail: 28988.jpg
jira: KT-8413, KT-3707
last-substantial-update: 2022-06-25T00:00:00Z
doc-type: Feature Video
exl-id: 6c49f8c2-f468-4b29-b7b6-029c8ab39ce9
duration: 1027
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1039'
ht-degree: 0%

---

# Adobe Asset Link 3.0

Adobe Experience Manager resurser kan användas av designers och kreativa användare i Adobe Creative Cloud favoritprogram.

Tillägget Adobe Asset Link för Adobe Creative Cloud for enterprise utökar möjligheterna att söka efter och bläddra bland, sortera, förhandsgranska, överföra resurser, checka ut, ändra, checka in och visa metadata för AEM-resurser i Creative Cloud-program.

>[!TIP]
>
> Läs mer om hur [Adobe XD Premium Training Program](https://helpx.adobe.com/support/xd.html) kan hjälpa dig att integrera Asset Link med ditt Adobe Experience Manager-arbetsflöde.

## Adobe Asset Link och AEM kreativa arbetsflöden

I följande video visas ett arbetsflöde som används av kreatörer som arbetar i Adobe Creative Cloud-program och som integreras direkt med AEM via Adobe Asset Link.

>[!VIDEO](https://video.tv.adobe.com/v/335927?quality=12&learn=on)

## Adobe Asset Link-funktioner

+ Adobe Asset Link är integrerat med AEM Assets och Assets Essentials.
+ Adobe Asset Link konfigurerar automatiskt anslutningen till molnbaserade AEM-miljöer (AEM Assets as a Cloud Service och Assets Essentials)
+ Adobe Asset Link är ett tillägg som fungerar i Adobe Creative Cloud-program:

   + Adobe XD
   + Adobe Photoshop
   + Adobe Illustrator
   + Adobe InDesign

+ Automatisk autentisering till AEM med Adobe Enterprise ID eller Federated ID
+ Sök efter digitalt material i AEM
+ Få åtkomst till filinformation för resurser i AEM från panelen:
   + Miniatyrbild
   + Grundläggande metadata
   + Versioner
+ Montera, ladda ned eller dra-och-släpp-material i layouten
+ Ändra mediefiler genom att checka ut dem från AEM och arbeta med dem (PIA) på deras Creative Cloud Assets-konto
+ Checka in en mediefil i AEM när de är klara med ändringen och den nya versionen visas i AEM
+ Söka efter resurser i AEM från panelen Adobe-resurslänk i appen
+ Bläddra bland AEM Assets-samlingar och smarta samlingar direkt från panelen Resurslänk
+ Lägg till nyskapade resurser i AEM direkt från panelen
+ Dra-och-släpp material direkt i InDesign ramar

## Placera resurser i InDesign

Adobe Asset Link har stöd för InDesign direktlänkar mellan Adobe Asset Link och AEM. Med stöd för direktlänkar i InDesign kan du montera (__Montera länkat__ eller __Montera kopia__) eller dra och släppa digitala resurser till InDesign från AEM via panelen Adobe Asset Link. Dessutom introduceras återgivningen av *For Placement Only+ (FPO).

>[!VIDEO](https://video.tv.adobe.com/v/28988?quality=12&learn=on)

>[!NOTE]
>
>Använd endast Adobe Creative Cloud Enterprise ID eller Federated ID. Kontrollera att du [konfigurerar AEM för Adobe Asset Link](https://helpx.adobe.com/enterprise/using/adobe-asset-link.html).

Du kan montera en resurs i din InDesign-layout med något av följande alternativ:

+ **Montera kopia** - Bädda in en resurs (med alternativet Montera kopia) placerar en kopia av den ursprungliga resursen i din InDesign-layout när binärfilerna har hämtats till ditt lokala system. Adobe Asset Link bevarar ingen länk mellan den inbäddade kopian och originalresursen. Om den ursprungliga resursen ändras i AEM måste du ta bort den inbäddade resursen från InDesign-filen och bädda in resursen på nytt från AEM.

+ **Montera länkad** - När du arbetar med InDesign-dokument kan du referera till resurserna från AEM, förutom att bädda in resurserna direkt (med alternativet Montera kopia på snabbmenyn). Genom att referera till resurser kan du samarbeta med andra användare och införliva eventuella uppdateringar som gjorts i den ursprungliga resursen i AEM. Om du vill referera till en resurs från AEM använder du alternativet Montera länkad på snabbmenyn.

### Endast för placeringsbilder

När stora resursfiler placeras i InDesign-dokument från AEM med hjälp av Adobe Asset Link, måste användare vänta några sekunder efter att monteringen initierats. Detta påverkar den övergripande användarupplevelsen. Med Adobe Asset Link kan du tillfälligt montera en lågupplöst bild av den ursprungliga resursen från AEM, vilket minskar tiden det tar att montera en bild. Samtidigt ökar det användarupplevelsen och produktiviteten. Bilden med lägre upplösning placeras tillfälligt och när den slutliga utskriften krävs för utskrift eller publicering måste du ersätta FPO-återgivningarna med originalen. Om du vill ersätta flera FPO-bilder med respektive originalbilder går du till panelen **_Fönster > Länkar_** och hämtar sedan originalresurserna. När originalbilderna har laddats ned väljer du Ersätt alla FPO:er med original.

FPO-återgivningar är enkla ersättningar av de ursprungliga resurserna. De har samma proportioner, men har mindre storlek än originalbilderna. För närvarande stöder InDesign endast import av FPO-återgivningar för följande bildtyper:

+ JPEG
+ GIF
+ PNG
+ TIFF
+ PSD
+ BMP

Om en FPO-återgivning inte är tillgänglig för en viss resurs i AEM refereras den ursprungliga högupplösta resursen i stället. För FPO-bilder visas status FPO på länkpanelen i InDesign.

## Adobe Asset Link-autentisering med AEM Assets

Hur Adobe Asset Link-autentisering fungerar i samband med Adobe Identity Management Services (IMS) och Adobe Experience Manager Author.

![Adobe Asset Link Architecture](assets/adobe-asset-link-article-understand.png)

1. Tillägget Adobe Asset Link gör att en auktoriseringsbegäran görs via Adobe Creative Cloud-datorprogrammet till Adobe Identity Manage Service (IMS) och när den lyckas får den en Bearer-token.
1. Tillägget Adobe Asset Link ansluter till AEM Author via HTTP(S), inklusive den Bearer-token som fås i **Steg 1**, med schemat (HTTP/HTTPS), värd och port som finns i tilläggets JSON-inställningar.
1. AEM Bearer Authentication Handler extraherar Bearer-token från begäran och validerar den med Adobe IMS.
1. När Adobe IMS validerar Bearer-token skapas en användare i AEM (om det inte redan finns) och synkroniserar profil- och grupp-/medlemskapsdata från Adobe IMS. AEM-användaren får en AEM-inloggningstoken som skickas tillbaka till Adobe Asset Link-tillägget som cookie i HTTP(S)-svaret.
1. Efterföljande interaktioner (t.ex. Om du bläddrar bland, söker efter, checkar in/ut resurser osv.) med Adobe Asset Link-tillägget resulterar det i HTTP(S)-begäranden till AEM Author som valideras med AEM inloggningstoken med hjälp av AEM standardhanterare för tokenautentisering.

>[!NOTE]
>
>När inloggningstoken har upphört att gälla anropas **Steg 1-5** automatiskt, Adobe Asset Link-tillägget autentiseras med Bearer-token och en ny, giltig inloggningstoken utfärdas på nytt.

## Ytterligare resurser

+ [Adobe Asset Link-webbplatsen](https://www.adobe.com/creativecloud/business/enterprise/adobe-asset-link.html)
