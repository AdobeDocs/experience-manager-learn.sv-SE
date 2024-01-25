---
title: Kom igång med AEM och Adobe Target
description: En komplett självstudiekurs som visar hur man skapar och levererar personaliserade upplevelser med Adobe Experience Manager och Adobe Target. I den här självstudiekursen får du även lära dig mer om olika personer som deltar i den sista processen och hur de samarbetar med varandra
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: b632883f-65fd-4f89-bf39-ec2bce352d2d
duration: 193
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '846'
ht-degree: 0%

---

# Integrera AEM Sites och Adobe Target {#getting-started-with-aem-target}

AEM och Target är båda kraftfulla lösningar med synbarligen överlappande funktioner. Kunderna kämpar ibland med att förstå hur och när de ska använda dessa produkter tillsammans för att leverera personaliserade upplevelser. För att kunna leverera optimerade upplevelser för alla slutanvändare bör olika team i organisationen ha ett nära samarbete och definiera vem som ska göra vad.

I den här självstudiekursen beskriver vi tre olika scenarier för AEM och Target, som hjälper dig att förstå vad som fungerar bäst för din organisation och hur olika team samarbetar.

* Scenario 1: Personalisering med AEM Experience Fragments
* Scenario 2: Personalisering med Visual Experience Composer
* Scenario 3: Personalisering av helwebbsidesupplevelser

## Personalisering med AEM Experience Fragments {#personalization-using-aem-experience-fragment}

I det här scenariot kommer vi att använda AEM och Target. Det är tydligt att båda produkterna har sina egna styrkor, och när det gäller att leverera personaliserade upplevelser till användarna på webbplatsen behöver ni **personaliserat innehåll (innehåll från AEM)** och **intelligent way (Target)** för att leverera innehållet baserat på en viss användare.

AEM hjälper er att skapa personaliserat innehåll och samla allt innehåll och alla resurser på en central plats för att understödja er personaliseringsstrategi. AEM gör det enkelt att skapa innehåll för datorer, surfplattor och mobila enheter på ett och samma ställe utan att behöva skriva kod. Du behöver inte skapa sidor för alla enheter. AEM justerar automatiskt varje upplevelse med ditt innehåll. Du kan också exportera innehåll från AEM till Adobe Target som erbjudanden med en knapptryckning.

Vi har nu personaliserat innehåll i form av erbjudanden från AEM i Target. Med Target kan ni leverera dessa erbjudanden i stor skala baserat på en kombination av regelbaserade och AI-drivna maskininlärningsstrategier som innehåller beteendevariabler, sammanhangsbaserade variabler och offlinevariabler.  Med Target kan ni enkelt konfigurera och köra A/B- och Multivariate-aktiviteter (MVT) för att fastställa de bästa erbjudandena, innehållet och upplevelserna.

**Upplevelsefragment** utgör ett stort steg framåt för att länka samman de som skapar innehåll/upplevelser med de som arbetar med personalisering och som driver affärsresultaten med Target.

* AEM skapar personaliserat innehåll som Experience Fragments och dess varianter
* AEM exporterar Experience Fragment HTML till &#x200B;
* För &#x200B; används AEM Experience Fragment markup som erbjudanden i aktiviteter
* Target levererar Experience Fragment HTML, AEM tillhandahåller refererade bilder

  ![Personalisering med Experience Fragments-diagram](assets/personalization-use-case-1/use-case-1-diagram.png)

**För att implementera detta scenario måste du:**

* [Integrera AEM och Adobe Target med Launch och Adobe I/O](./implementation.md#integrating-aem-target-options)
* [AEM och Adobe Target med äldre Cloud Service](./implementation.md#integrating-aem-target-options)

***När du har implementerat integreringarna ovan kan du [scenario i detalj](./personalization-use-case-1.md).***

## Personalisering med Visual Experience Composer

Marknadsförarna kan göra snabba ändringar på sin webbplats utan att ändra någon kod för att köra ett test med Adobe Target Visual Experience Composer (VEC). VEC är ett WYSIWYG-användargränssnitt (det du ser är det du får) som gör att du enkelt kan skapa och testa personaliserade upplevelser och erbjudanden i webbplatskontexten. Du kan skapa upplevelser och erbjudanden för Target-aktiviteter genom att dra och släppa, byta och ändra layouten och innehållet på en webbsida (eller Erbjudande) eller en mobilwebbsida.

VEC är en av huvudfunktionerna i Adobe Target. Med VEC kan marknadsförare och designers skapa och ändra innehåll med ett visuellt gränssnitt. Många designalternativ kan göras utan att koden behöver redigeras direkt. Det går också att redigera HTML och JavaScript med de redigeringsalternativ som finns i dispositionen.

* Innehållet finns i AEM och redaktörer skapar och hanterar webbplatssidorna
* Målet använder AEM värdbaserade webbplatssidor för att köra tester och personalisering
* Target levererar personaliserat innehåll
* Nytt innehåll netto skapas med Adobe Target VEC
* Gäller både AEM värdbaserade webbplatser och icke-AEM värdbaserade webbplatser

  ![Personalisering med Visual Experience Composer-diagram](assets/personalization-use-case-3/use-case-diagram-3.png)

**För att implementera detta scenario måste du:**

* [Integrera AEM och Adobe Target med Launch och Adobe I/O](./implementation.md#integrating-aem-target-options)

***När du har implementerat integreringen ovan kan du [scenario i detalj.](./personalization-use-case-3.md)***

## Personalisering av fullständiga webbsidesupplevelser

Genom att integrera Adobe Experience Manager med Adobe Target kan ni leverera en personaliserad upplevelse till era webbplatsanvändare. Dessutom hjälper det er att bättre förstå vilka versioner av webbplatsinnehållet som bäst förbättrar konverteringsgraden under en viss testperiod. Ett A/B-test jämför till exempel två eller flera versioner av webbplatsinnehållet för att se vilka som är bäst på att lyfta konverteringarna, försäljningen eller andra mätvärden som du identifierar. En marknadsförare kan skapa aktiviteter inom Adobe Target för att förstå hur användare interagerar med webbplatsens innehåll och hur det påverkar webbplatsens mått.

* Innehållet finns i AEM och redaktörer skapar och hanterar webbplatssidorna
* Målet använder AEM värdbaserade webbplatssidor för att köra tester och personalisering
* Target levererar personaliserat innehåll
* Inget nytt nettoinnehåll skapas här
* Gäller både AEM och icke-AEM webbplatser

  ![diagram](assets/personalization-use-case-2/use-case-2-diagram.png)

**För att implementera detta scenario måste du:**

* [Integrera AEM och Adobe Target med Launch och Adobe I/O](./implementation.md#integrating-aem-target-options)

***När du har implementerat integreringen ovan kan du [scenario i detalj.](./personalization-use-case-2.md)***
