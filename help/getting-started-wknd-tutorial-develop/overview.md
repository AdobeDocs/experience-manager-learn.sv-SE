---
title: Komma igång med AEM Sites - WKND självstudiekurs
description: Komma igång med AEM Sites - WKND självstudiekurs. WKND-självstudiekursen är en självstudiekurs i flera delar som utformats för utvecklare som är nybörjare på Adobe Experience Manager. Självstudiekursen går igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND. Självstudiekursen behandlar grundläggande ämnen som projektinställningar, prototyper, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling.
sub-product: sites
topics: development
version: Cloud Service
doc-type: tutorial
activity: develop
audience: developer
KT: 4132
mini-toc-levels: 1
index: y
thumbnail: 30476.jpg
feature: Core Components, Page Editor, Editable Templates, AEM Project Archetype
topic: Content Management, Development
role: Developer
level: Beginner
exl-id: 09a600f4-1ada-4fb7-ae44-586364cff389
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '619'
ht-degree: 0%

---

# Komma igång med AEM Sites - WKND självstudiekurs {#introduction}

Välkommen till en självstudiekurs i flera delar som är utformad för utvecklare som är nybörjare i Adobe Experience Manager (AEM). Den här självstudiekursen går igenom implementeringen av en AEM sajt för ett fiktivt livsstilsmärke, WKND. Självstudiekursen behandlar grundläggande ämnen som projektinställningar, kärnkomponenter, redigerbara mallar, klientbibliotek och komponentutveckling med Adobe Experience Manager Sites.

## Översikt {#wknd-tutorial-overview}

Målet med den här självstudiekursen är att lära en utvecklare hur man implementerar en webbplats med hjälp av de senaste standarderna och teknikerna i Adobe Experience Manager (AEM). Efter att ha avslutat den här självstudiekursen bör utvecklaren förstå plattformens grundläggande grund och med kunskap om vanliga designmönster i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/30476?quality=12&learn=on)

## Alternativ för att starta ett Sites-projekt

Det finns två grundläggande strategier för att starta ett AEM Sites-projekt.

**AEM Project Archetype**  - Traditionell metod för AEM genom att generera ett minimalt AEM med en Maven-mall. Detta är det rekommenderade tillvägagångssättet för AEM 6.5/6.4-projekt och AEM som ett Cloud Service-projekt som förutser omfattande anpassningar. Självstudiekursen ger en djupdykning i AEM utveckling.

[Starta självstudiekursen med AEM Project Archetype](./project-archetype/overview.md)

**AEM webbplatsmallar**  - En lågkodsmetod för att generera en AEM genom att använda en fördefinierad platsmall. Använd färdiga komponenter och mallar för att snabbt komma igång med en webbplats. Använd ett temaarbetsflöde för att tillämpa varumärkesspecifika format och anpassningar med bara CSS och JavaScript. Rekommenderas för nya projekt och utvecklare. Endast tillgänglig för AEM som Cloud Service.

[Starta självstudiekursen med hjälp av en webbplatsmall](./site-template/create-site.md)

## Adobe XD UI Kit

För att den här självstudiekursen ska bli närmare ett verkligt scenario skapade Adobe-designers modeller för webbplatsen med [Adobe XD](https://www.adobe.com/products/xd.html). Under självstudiekursen implementeras olika delar av designen till en helt redigerbar AEM. Ett särskilt tack till **Lorenzo Buosi** och **Kilian Modiola** som skapade den vackra designen för WKND-webbplatsen.

Ladda ned XD UI-kit:

* [AEM Core Component UI Kit](assets/overview/AEM-CoreComponents-UI-Kit.xd)
* [WKND UI Kit](https://github.com/adobe/aem-guides-wknd/releases/download/aem-guides-wknd-0.0.2/AEM_UI-kit-WKND.xd)

## Referenswebbplats {#reference-site}

En färdig version av WKND-webbplatsen finns också som referens: [https://wknd.site/](https://wknd.site/)

Självstudiekursen behandlar de viktigaste utvecklingskunskaperna som en AEM behöver, men *inte* bygger hela webbplatsen från början till slut. Den färdiga referenswebbplatsen är en annan bra resurs att utforska och se mer av AEM funktioner.

Om du vill testa den senaste koden innan du går till självstudiekursen hämtar och installerar du den **[senaste versionen från GitHub](https://github.com/adobe/aem-guides-wknd/releases/latest)**.

### Powered by Adobe Stock

Många av bilderna på WKND Reference-webbplatsen är från [Adobe Stock](https://stock.adobe.com/) och är material från tredje part enligt definitionen i Demo Asset Additional Terms på [https://www.adobe.com/legal/terms.html](https://www.adobe.com/legal/terms.html). Om du vill använda en Adobe Stock-bild för andra ändamål än att visa den här demowebbplatsen, till exempel för att visa den på en webbplats, eller i marknadsföringsmaterial, kan du köpa en licens på Adobe Stock.

Med Adobe Stock får du tillgång till över 140 miljoner högklassiga royaltyfria bilder som foton, grafik, videor och mallar som hjälper dig att komma igång snabbt med dina kreativa projekt.

## Nästa steg {#next-steps}

Vad väntar du på?! Lär dig hur du [skapar ett nytt Adobe Experience Manager-projekt med den AEM Project Archetype](./project-archetype/overview.md) eller [skapar en webbplats med hjälp av en Site Template](./site-template/create-site.md).
