---
title: Smart bildbehandling
description: Smart Imaging i Dynamic Media Classic förbättrar bildhanteringen genom att automatiskt optimera bildformat och bildkvalitet baserat på webbläsarens funktioner. Det gör man genom att utnyttja Adobe Sensei AI-funktioner och arbeta med befintliga bildförinställningar. Läs mer om Smart Imaging och hur ni kan använda det för att erbjuda bättre kundupplevelser genom snabbare sidladdning.
feature: Dynamic Media Classic
topic: Content Management
role: User
level: Beginner
doc-type: Tutorial
exl-id: 678671c3-af25-4da1-bc14-cbc4cc19be8d
duration: 130
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '654'
ht-degree: 0%

---

# Smart bildbehandling {#smart-imaging}

En av de viktigaste aspekterna av kundupplevelsen på er webbplats eller mobilwebbplats eller i er app är sidans laddningstid. Kunderna överger ofta en webbplats eller app om det tar för lång tid att läsa in en sida. Bilderna utgör större delen av sidans inläsningstid. Smart Imaging i Dynamic Media Classic förbättrar bildhanteringen genom att automatiskt optimera bildformat och bildkvalitet baserat på webbläsarens funktioner. Det gör man genom att utnyttja Adobe Sensei AI-funktioner och arbeta med befintliga bildförinställningar. Smart Imaging minskar bildstorleken med 30 procent eller mer - vilket innebär snabbare sidladdning och bättre kundupplevelser.

Smart Imaging drar också nytta av den ökade prestandaförbättringen genom att vara helt integrerad med den bästa premiumtjänsten från Adobe. Den här tjänsten hittar den optimala Internetvägen mellan servrar, nätverk och peering-punkter som har den lägsta latensen och/eller paketförlustfrekvensen än standardvägen på Internet.

Läs mer om [Smart bildbehandling](https://experienceleague.adobe.com/docs/experience-manager-65/assets/dynamic/imaging-faq.html?lang=sv-SE).

## Fördelar med smart bildbehandling

Eftersom bilder utgör huvuddelen av en sidas laddningstid kan prestandaförbättringen från Smart Imaging ha en genomgripande effekt på nyckeltal, till exempel högre konvertering, tid på webbplatsen och lägre avhoppsfrekvens för webbplatsen.

![bild](assets/smart-imaging/smart-imaging-1.png)

## Så fungerar Smart Imaging

Smart Imaging utnyttjar Adobe Sensei AI-funktioner och arbetar med befintliga bildförinställningar för att automatiskt konvertera bilder till nästa generationens optimala bildformat som WebP, samtidigt som den visuella återgivningen bibehålls.

Läs mer om [Hur smart bildbehandling fungerar](https://experienceleague.adobe.com/docs/experience-manager-65/assets/dynamic/imaging-faq.html?lang=sv-SE#how-does-smart-imaging-work), inklusive information om bildformat som stöds (och vad som händer om du inte använder dessa format) och hur de påverkar befintliga bildförinställningar som används.

## Effekter av Smart Imaging

Du är antagligen oroad över att du måste ändra dina URL:er, bildförinställningar och kod på din webbplats för att kunna utnyttja Smart Imaging. Om du uppfyller kraven för Smart Imaging och bara arbetar med bilder i bildformaten JPEG och PNG som stöds behöver du inte göra några ändringar.

Smart bildbehandling fungerar med bilder som levereras via HTTP, HTTPS och HTTP/2.

>[!NOTE]
>
>Om du går över till Smart Imaging rensas cacheminnet vid CDN:n. Cacheminnet i CDN byggs vanligtvis upp igen inom en eller två dagar.

Smart Imaging ingår i din befintliga licens av Dynamic Media Classic. Det finns inga extra kostnader för den här funktionen. För att kunna dra nytta av det måste du uppfylla två krav: ha ett CDN-paket i Adobe och en dedikerad domän. Sedan måste du aktivera det för ditt konto eftersom det inte aktiveras automatiskt.

Att aktivera Smart Imaging börjar med att du skickar teknisk support via |skapa ett supportärende| [https://helpx.adobe.com/se/enterprise/admin-guide.html/enterprise/using/support-for-experience-cloud.ug.html](https://helpx.adobe.com/se/enterprise/admin-guide.html/enterprise/using/support-for-experience-cloud.ug.html). Support kommer att fungera tillsammans med dig för att konfigurera en anpassad domän som du ska associera med Smart Imaging. Du ändrar en parameter som är relaterad till cachelagring (Time To Live, eller TTL) och stödet rensar cachen. Du kan också göra ett valfritt mellanlagringssteg om du vill innan du går till produktion. När Smart Imaging sedan är aktiverat kan du leverera bilder i mindre storlek till kunderna, men med samma kvalitet som de önskade. Det innebär att de får snabbare sidladdning - och allt detta görs automatiskt eftersom Adobe Sensei hjälper dem att välja den mest effektiva storleken.

När du har aktiverat Smart Imaging vill du kontrollera att den fungerar som förväntat.

Du har antagligen ytterligare frågor om Smart Imaging. Vi har sammanställt en lista med vanliga frågor och svar. Läs [Frågor och svar](https://experienceleague.adobe.com/docs/experience-manager-65/assets/dynamic/imaging-faq.html?lang=sv-SE).

## Ytterligare resurser

Titta på [Dynamic Media Classic Optimizing Page Performance SKill Builder](https://seminars.adobeconnect.com/pzc1gw0cihpv) on-demand-webbinariet om du vill veta mer om Smart Imaging.
