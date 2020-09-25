---
title: Smart bildbehandling
description: Smart Imaging in Dynamic Media Classic förbättrar bildleveransen genom att automatiskt optimera bildformat och bildkvalitet baserat på webbläsarens funktioner. Det gör man genom att utnyttja Adobe Sensei AI-funktioner och arbeta med befintliga bildförinställningar. Läs mer om Smart Imaging och hur ni kan använda det för att erbjuda bättre kundupplevelser genom snabbare sidladdning.
sub-product: dynamiska medier
feature: smart-crop
doc-type: tutorial
topics: development, authoring, configuring, renditions, images
audience: all
activity: use
translation-type: tm+mt
source-git-commit: 5eeeb197f9a2ee4216e1f9220c830751c36f01ab
workflow-type: tm+mt
source-wordcount: '678'
ht-degree: 1%

---


# Smart bildbehandling {#smart-imaging}

En av de viktigaste aspekterna av kundupplevelsen på er webbplats eller mobilwebbplats eller i er app är sidans laddningstid. Kunderna överger ofta en webbplats eller app om det tar för lång tid att läsa in en sida. Bilderna utgör större delen av sidans inläsningstid. Smart Imaging in Dynamic Media Classic förbättrar bildleveransen genom att automatiskt optimera bildformat och bildkvalitet baserat på webbläsarens funktioner. Det gör man genom att utnyttja Adobe Sensei AI-funktioner och arbeta med befintliga bildförinställningar. Smart Imaging minskar bildstorleken med 30 procent eller mer - vilket innebär snabbare sidladdning och bättre kundupplevelser.

Smart Imaging drar också nytta av den ökade prestandaförbättringen genom att vara helt integrerad med den bästa premiumtjänsten från Adobe. Den här tjänsten hittar den optimala Internetvägen mellan servrar, nätverk och peering-punkter som har den lägsta latensen och/eller paketförlustfrekvensen än standardvägen på Internet.

Läs mer om [smart bildbehandling](https://docs.adobe.com/content/help/en/experience-manager-64/assets/dynamic/imaging-faq.html).

## Fördelar med smart bildbehandling

Eftersom bilder utgör huvuddelen av en sidas laddningstid kan prestandaförbättringen från Smart Imaging ha en genomgripande effekt på nyckeltal, till exempel högre konvertering, tid på webbplatsen och lägre avhoppsfrekvens för webbplatsen.

![bild](assets/smart-imaging/smart-imaging-1.png)

## Så fungerar Smart Imaging

Smart Imaging utnyttjar Adobe Sensei AI-funktioner och arbetar med befintliga bildförinställningar för att automatiskt konvertera bilder till nästa generationens optimala bildformat som WebP, samtidigt som den visuella återgivningen bibehålls.

Läs mer om [hur Smart Imaging fungerar](https://docs.adobe.com/content/help/en/experience-manager-64/assets/dynamic/imaging-faq.html#how-does-smart-imaging-work), inklusive detaljer som bildformat som stöds (och vad som händer om du inte använder dessa format) och hur de påverkar befintliga bildförinställningar som används.

## Effekter av Smart Imaging

Du är antagligen oroad över att du måste ändra dina URL:er, bildförinställningar och kod på din webbplats för att kunna utnyttja Smart Imaging. Om du uppfyller kraven för Smart Imaging och bara arbetar med bilder i de JPEG- och PNG-format som stöds, behöver du inte göra några ändringar.

Smart bildbehandling fungerar med bilder som levereras via HTTP, HTTPS och HTTP/2.

>[!NOTE]
>
>Om du går över till Smart Imaging rensas cacheminnet vid CDN:n. Cacheminnet i CDN byggs vanligtvis upp igen inom en eller två dagar.

Smart Imaging ingår i din befintliga licens av Dynamic Media Classic. Det finns inga extra kostnader för den här funktionen. Du måste uppfylla två krav för att kunna utnyttja det: har ett CDN-paket i Adobe och en dedikerad domän. Sedan måste du aktivera det för ditt konto eftersom det inte aktiveras automatiskt.

Du börjar med att aktivera Smart Imaging genom att skicka en begäran om teknisk support via e-post till [s7support@adobe.com](mailto:s7support@adobe.com). De kommer att arbeta tillsammans med dig för att konfigurera en anpassad domän som du kopplar till Smart Imaging. Du ändrar en parameter som är relaterad till cachelagring (Time To Live, eller TTL) och stödet rensar cachen. Du kan också göra ett valfritt mellanlagringssteg om du vill innan du går till produktion. När Smart Imaging sedan är aktiverat kan du leverera bilder i mindre storlek till kunderna, men med samma kvalitet som de önskade. Det innebär att de får snabbare sidladdning - och allt detta görs automatiskt eftersom Adobe Sensei hjälper dem att välja den mest effektiva storleken.

När du har aktiverat Smart Imaging vill du kontrollera att den fungerar som förväntat.

Du har antagligen ytterligare frågor om Smart Imaging. Vi har sammanställt en lista med vanliga frågor och svar. Läs [Frågor och svar](https://docs.adobe.com/content/help/en/experience-manager-64/assets/dynamic/imaging-faq.html).

## Ytterligare resurser

Titta på webbseminariet [Dynamic Media Classic Optimizing Page Performance SKill Builder](https://seminars.adobeconnect.com/pzc1gw0cihpv) on-demand om du vill veta mer om Smart Imaging.
