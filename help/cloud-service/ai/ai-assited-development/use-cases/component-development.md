---
title: Komponentutveckling med AEM Agent Skills
description: Lär dig utveckla en AEM-komponent med AEM Agent Skills som en del av AI-assisterad utveckling.
version: Experience Manager as a Cloud Service
feature: Developer Tools
role: Developer, Architect
level: Beginner
doc-type: Article
duration: 0
last-substantial-update: 2026-04-24T00:00:00Z
jira: KT-20901
thumbnail: KT-20901.png
source-git-commit: e3ef450cfe9005ba940ff1897c216681654341b3
workflow-type: tm+mt
source-wordcount: '632'
ht-degree: 0%

---


# Komponentutveckling med AEM Agent Skills

Lär dig hur du utvecklar en AEM-komponent med AEM Agent Skills som en del av [AI-assisterad utveckling](../overview.md).

I den här genomgången använder du ett naturligt språk i en AI-driven IDE (till exempel Markör) för att utveckla en **Promo Banner** -komponent i [WKND Sites Project](https://github.com/adobe/aem-guides-wknd). Kodningsagenten använder AEM Agent-kompetensen `create-component` för att generera implementeringen.

## Förutsättningar

Om du vill följa den här självstudiekursen behöver du följande:

- En AI-driven IDE som Cursor eller Visual Studio Code med GitHub Copilot.
- En lokal klon av [WKND Sites Project](https://github.com/adobe/aem-guides-wknd), som skapats och distribuerats till en _lokal AEM SDK_-instans.
- _AEM Agent Skills_ har installerats i det projektet. Om du inte har gjort det än slutför du [Konfigurera AEM Agent Skills](../setup/agent-skills.md).

## Komponentkrav

Låt oss anta att WKND-teamet vill visa en kampanjbanderoll på startsidan, och designreferensen är följande:

![Promo Banner Design Reference](../assets/component-development/promo-banner-design-reference.png)

Författare måste kunna ange fälten _Promo label_, _CTA label_ och _CTA link_ i komponentdialogrutan.

Designreferensen är en skärmbild som hämtas via trådramar, dummies eller statisk markup capture.

## Utveckla komponenten

1. Öppna WKND-projektet i din utvecklingsmiljö. Bekräfta att AEM Agent Skills finns (till exempel under `.agents/skills`) och starta sedan en ny agentchatt.
   ![Kontrollera att AEM Agent Skills är installerat](../assets/component-development/verify-aem-agent-skills-installed.png)

1. Ange en uppmaning enligt följande. Koppla skärmbilden för komponentdesign (hämtas via trådram, dummies eller statisk markup capture) om din utvecklingsmiljö stöder bilder i chatt:

   ```text
   Create a WKND Promo Banner Component. Please see attached screenshot for design reference.
   
   Dialog specification are:
   
   1. Promo Label - Textfield, required
   2. CTA Text - Textfield, required
   3. CTA Link - Pathfield, required
   ```

1. Kodningsagenten använder AEM Agent-kompetensen `create-component` för att generera komponenten. Granska föreslagna HTML-, Sling Model-, dialog-XML- och relaterade filer.
   ![Granska den genererade koden](../assets/component-development/review-generated-code.png)

>[!TIP]
>
>I stället för att tillhandahålla designreferensen som en skärmbild kan du även skapa komponenten genom att tillhandahålla en Figma-design via [Figma MCP-servern](https://www.figma.com/mcp-catalog/) . `create-component`-kompetensen stöder [Figma-designintegrationen](https://github.com/adobe/skills/blob/main/plugins/aem/cloud-service/skills/create-component/references/figma-design-rules.md)


1. Distribuera komponenten till den lokala AEM-instansen/SDK.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

1. Placera kampanjbanderollen på startsidan och validera beteendet när du redigerar. Förfina implementeringen om den fortfarande avviker från designreferensen.
   ![Skapa komponenten Promo Banner](../assets/component-development/author-promo-banner-component.png)

1. Granska den nya komponenten genom att publicera sidan eller Visa som publicerad.
   ![Granska den nyskapade komponenten](../assets/component-development/review-newly-created-component.png)

Grattis! Du har skapat en ny AEM-komponent med AEM Agent Skills som en del av AI-stödd utveckling.

## Förutom enkla komponenter

Den här genomgången använder en enkel komponent. Samma `create-component`-kompetens har även stöd för fler ärenden, inklusive:

- Flera fält och kapslade dialogrutefält
- AEM Core Components extensions (inklusive Sling Resource Merger patterns)
- Figma fil- eller bildrute-URL:er för layout och format när Figma MCP-servern (till exempel `plugin-figma-figma`) är aktiverad i din IDE

För fälttyper, dialogmönster, Figma-regler och exempel, läs `SKILL.md` i din installerade kompetensmapp, till exempel `.agents/skills/create-component/SKILL.md`.

En översikt, installationssökvägar per IDE och felsökning finns i [AEM Component Development Agent](https://github.com/adobe/skills/blob/main/plugins/aem/cloud-service/skills/create-component/README.md) i Adobe Skills-databasen.

## AGENTS.md

Innan vi går in i bilden måste vi förstå hur AGENTS.md genererades när komponenten skapades.

För AEM as a Cloud Service-projekt skapar bootstrap-kompetensen `ensure-agents-md` (väljs under [Konfigurera AEM Agent Skills](../setup/agent-skills.md)) `AGENTS.md` vid databasroten när den **saknas**. Det använder det som lär sig av din projektlayout.

Den skriver **inte** över en befintlig `AGENTS.md`-fil.

![Skapa AGENTS.md](../assets/component-development/agents-md-creation.png)

## Ytterligare resurser

- [Local Development with AI Tools](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/local-development-with-ai-tools)

- [Adobe Skills for AI Coding Agents](https://github.com/adobe/skills)

- [AGENTS.md](https://agents.md/)

- [Agentfärdigheter](https://agentskills.io/home)
