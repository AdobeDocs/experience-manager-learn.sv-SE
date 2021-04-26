---
title: Arbetsflöde för teman
seo-title: Komma igång med AEM Sites - Arbetsflöde för teman
description: Lär dig hur du uppdaterar temakällorna för en Adobe Experience Manager-webbplats för att använda varumärkesspecifika format. Lär dig hur du använder en proxyserver för att visa en direktförhandsvisning av CSS- och JavaScript-uppdateringar. Den här självstudiekursen handlar också om hur du distribuerar temauppdateringar till en AEM webbplats med GitHub-åtgärder.
sub-product: platser
version: Cloud Service
type: Tutorial
feature: Kärnkomponenter
topic: Innehållshantering, utveckling
role: Developer
level: Beginner
kt: 7498
thumbnail: KT-7498.jpg
translation-type: tm+mt
source-git-commit: 67b7f5ee5fc9e42537a9622922327fb7a456d2bd
workflow-type: tm+mt
source-wordcount: '581'
ht-degree: 0%

---


# Temaarbetsflöde {#theming}

>[!CAUTION]
>
> De snabba funktionerna som visas här kommer att släppas under andra halvåret 2021. Den relaterade dokumentationen är tillgänglig för förhandsgranskning.

I det här kapitlet ska vi uppdatera temakällorna för en Adobe Experience Manager-webbplats så att de använder varumärkesspecifika format. Vi får lära oss hur du använder en proxyserver för att förhandsgranska CSS- och Javascript-uppdateringar när vi kodar mot den aktiva webbplatsen. Den här självstudiekursen handlar också om hur du distribuerar temauppdateringar till en AEM webbplats med GitHub-åtgärder.

Slutligen kommer vår webbplats att uppdateras och innehålla format som matchar WKND-varumärket.

## Förutsättningar {#prerequisites}

Det här är en självstudiekurs i flera delar och det antas att stegen som beskrivs i kapitlet [Sidmallar](./page-templates.md) har slutförts.

## Mål

1. Lär dig hur temakällorna för en webbplats kan hämtas och ändras.
1. Lär dig hur koden mot den publicerade webbplatsen ser ut i realtid.
1. Förstå hela arbetsflödet med att leverera kompilerade CSS- och JavaScript-uppdateringar som en del av ett tema med GitHub-åtgärder.

## Uppdatera ett tema {#theme-update}

Gör sedan ändringar i temakällorna så att webbplatsen matchar utseendet och känslan hos WKND-varumärket.

>[!VIDEO](https://video.tv.adobe.com/v/332918/?quality=12&learn=on)

Stegen på hög nivå för videon:

1. Skapa en lokal användare i AEM som kan användas med en proxyutvecklingsserver.
1. Hämta temakällorna från AEM och öppna med en lokal utvecklingsmiljö, som VSCode.
1. Ändra temakällorna och använd en proxydev-server för att förhandsgranska CSS- och JavaScript-ändringar i realtid.
1. Uppdatera temakällorna så att tidskriftsartikeln matchar WKND-profilerade stilar och dummies.

### Lösningsfiler

Hämta de färdiga formaten för [WKND-temat](assets/theming/WKND-THEME-src.zip)

## Distribuera ett tema {#deploy-theme}

Distribuera uppdateringar av ett tema till en AEM miljö med GitHub-åtgärder.

>[!VIDEO](https://video.tv.adobe.com/v/332919/?quality=12&learn=on)

Stegen på hög nivå för videon:

1. Lägg till ditt temakällprojekt i [GitHub som en ny databas](https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line).
1. Skapa [en personlig åtkomsttoken i GitHub](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) och spara på en säker plats.
1. Konfigurera GitHub-inställningarna i din AEM så att de pekar på din GitHub-databas och inkluderar din personliga åtkomsttoken.
1. Skapa följande [krypterade hemligheter](https://docs.github.com/en/actions/reference/encrypted-secrets) i din GitHub-databas:
   * **AEM_SITE** - roten för AEM (dvs  `wknd`)
   * **AEM_URL** - url för din AEM-författarmiljö
   * **GIT_TOKEN**  - Personlig åtkomsttoken från steg 2.
1. Kör GitHub-åtgärden: **Skapa och distribuera Github-artefakter**. Detta kommer att få den efterföljande effekten att åtgärden körs: **Uppdatera temakonfigurationen på AEM med artefakt-ID**, som distribuerar temakällorna till den AEM miljön enligt `AEM_URL` och `AEM_SITE`.

### Exempelrapporter

Det finns några exempel på GitHub-repor som kan användas som referens:

* [aem-site-template-basic-theme-e2e](https://github.com/adobe/aem-site-template-basic-theme-e2e) - Används som exempel för verkliga projekt.
* [https://github.com/godanny86/wknd-theme](https://github.com/godanny86/wknd-theme)  - Används som exempel för dem som följer självstudiekursen.

## Grattis! {#congratulations}

Grattis, du har just skapat ett uppdaterat och distribuerat tema till AEM!

### Nästa steg {#next-steps}

Ta en djupdykning AEM utvecklingen och förstå mer av den underliggande tekniken genom att skapa en webbplats med [AEM Project Archetype](../project-archetype/overview.md).
