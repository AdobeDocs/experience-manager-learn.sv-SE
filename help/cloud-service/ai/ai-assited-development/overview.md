---
title: AI-stödd utveckling
description: Lär dig mer om AI-assisterad utveckling som använder en AI-driven IDE eller kodningsagenter tillsammans med AGENTS.md-, Agent Skills- och MCP-servrar för att producera högkvalitativ, produktionsklar kod för projekt på AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
feature: Developer Tools
role: Developer, Architect
level: Beginner
doc-type: Article
duration: 0
last-substantial-update: 2026-04-24T00:00:00Z
jira: KT-20899
thumbnail: KT-20899.pngKT-20899
source-git-commit: e3ef450cfe9005ba940ff1897c216681654341b3
workflow-type: tm+mt
source-wordcount: '906'
ht-degree: 0%

---


# AI-stödd utveckling

AI-assisterad utveckling använder en AI-driven IDE eller kodningsagenter tillsammans med `AGENTS.md` -, Agent Skills- och MCP-servrar för att producera högkvalitativ, produktionsklar kod för AEM as a Cloud Service-projekt.

Verktyg som [Cursor](https://www.cursor.com/), [GitHub Copilot i Visual Studio-kod](https://code.visualstudio.com/docs/copilot/overview), [Claude Code](https://code.claude.com/docs/en/overview) och liknande AI-baserade IDE:er och kodningsagenter hjälper på några viktiga sätt:

- **Snabbare iteration**: Generera eller ändra kodupplösning från förslag på naturliga språk som beskriver den önskade funktionen eller ändringen.
- **Utbildningshjälp**: förklara okända kodsökvägar, konfigurationer, begrepp eller bästa praxis när du uppmanas till det.

Fördelarna är dock beroende av _sammanhanget som är tillgängligt för kodningsagenten_. Allmän utbildningsinformation och en enda databasögonblicksbild är ofta _inte tillräckliga_ för att du säkert ska kunna producera produktionsklar AEM-kod.

## Varför enbart AI är otillräckligt

Utan rätt sammanhang kan AI-modeller (via en AI-driven IDE eller kodningsagent)

- **Hallucinera API:er eller livscykler**: föreslå kod eller konfigurationer som inte följer AEM as a Cloud Service bästa praxis eller senaste funktioner.
- **Saknar procedursteg**: utelämna nödvändiga steg som inte visas i koddatabasen eller utbildningsdata.
- **Gå från projektstandarder**: Ignorera etablerade mönster för komponenter, OSGi-tjänster, arbetsflöden eller Dispatcher-konfiguration.

Den här gapet är den plats där _strukturerad kontext_ (Agent Skills and AGENTS.md) och _körningssynlighet_ (MCP-servrar) blir nödvändiga för att göra AI-assisterad utveckling _produktiv_ och _tillförlitlig_.

## Hur Adobe kan hjälpa till vid AI-stödd utveckling

För AEM as a Cloud Service-projekt tillhandahåller Adobe:

- Agent Skills och AGENTS.md via [Adobe Skills for AI Coding Agents](https://github.com/adobe/skills)
- Lokala MCP-servrar för AEM SDK och lokala Dispatcher via portalen [Programdistribution](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=mcp*&1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2Fdc%3AsoftwareType&1_group.propertyvalues.operation=equals&1_group.propertyvalues.0_values=software-type%3Atooling&orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&orderby.sort=desc&layout=list&p.offset=0&p.limit=3)
- AEM MCP-servrar från Adobe som värd för innehåll och Cloud Manager-arbetsflöden från IDE- eller chattprogram - se [MCP-servrar i AEM](../mcp/overview.md)

I följande avsnitt sammanfattas varje objekt. Använd avsnitten **Inställningar** och **Använd fall** i slutet av den här sidan för installation och genomgångar för AI-stödd utveckling.

## Vad är agentfärdigheter?

Agentfärdigheter är _procedurmässiga kunskaper eller expertis_ som hjälper kodningsagenter _att utföra verkligt arbete på ett tillförlitligt sätt_. Mer information finns i [Agentfärdigheter](https://agentskills.io).

Agentfärdigheter är tillgängliga i databasen [Adobe Skills for AI Coding Agents](https://github.com/adobe/skills) för ett AEM as a Cloud Service-projekt.

## Vad är AGENTS.md

AGENTS.md innehåller _kontext och instruktioner_ som hjälper kodningsagenter _att arbeta med ditt projekt_. Mer information finns i [AGENTS.md](https://agents.md/).

För ett AEM as a Cloud Service-projekt skapar bootstrap-kompetensen `ensure-agents-md` **AGENTS.md** vid databasroten **när den saknas**. Kompetensen inspekterar ditt projekt (till exempel roten `pom.xml` och modulerna) och genererar anpassad vägledning i stället för att använda en statisk fil. Om **AGENTS.md** redan finns skrivs den **inte** över.

När filen finns kan du redigera den för att lägga till mer kontext och instruktioner för ditt team eller din organisations bästa praxis. Kompetensen kan också skapa **CLAUDE.md** som refererar till **AGENTS.md** så att Claude-baserade verktyg kan använda samma vägledning.

## Vad är MCP-servrar?

MCP-servrar exponerar verktyg och data för kodningsagenten via [Model Context Protocol](https://modelcontextprotocol.io/) som stöder åtgärder som felsökning, inspektion, körning och validering av ändringar. En MCP-server kan köras på din arbetsstation (**local**) eller som en värdtjänst (**remote**).

Installera dessa **lokala MCP-servrar** från [programdistributionsportalen](https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html?fulltext=mcp*&1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2Fdc%3AsoftwareType&1_group.propertyvalues.operation=equals&1_group.propertyvalues.0_values=software-type%3Atooling&orderby=%40jcr%3Acontent%2Fjcr%3AlastModified&orderby.sort=desc&layout=list&p.offset=0&p.limit=3) för **lokal utveckling** mot AEM SDK och Dispatcher:

- **AEM Quickstart Local MCP-server**: Exponerar data från en lokal AEM SDK-instans för felsökning och utveckling. Mer information finns i [AEM Quickstart MCP Server](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/ai-in-aem/local-development-with-ai-tools#aem-quickstart-mcp-server).
- **Dispatcher lokal MCP-server**: Aktiverar körningsvalidering och kontroll av en lokal Dispatcher-instans. Mer information finns i [Dispatcher MCP Server](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/ai-in-aem/local-development-with-ai-tools#dispatcher-mcp-server).

Information om AEM MCP-servrar som är värdbaserade för Adobe (till exempel innehåll, skrivskyddat innehåll och Cloud Manager) finns i [MCP-servrar i AEM](../mcp/overview.md).

## Inställningar

<!-- 
CARDS
{target = _self}

* ./setup/agent-skills.md
    {title = Set up AEM Agent Skills}
    {description = Learn how to set up AEM Agent Skills for AI-assisted development.}
    {image = ./assets/agent-skills/select-aem-agent-skills-to-install.png}
    {cta = Install AEM Agent Skills}

-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Set up AEM Agent Skills">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./setup/agent-skills.md" title="Konfigurera AEM Agent Skills" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/agent-skills/select-aem-agent-skills-to-install.png" alt="Konfigurera AEM Agent Skills"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./setup/agent-skills.md" target="_self" rel="referrer" title="Konfigurera AEM Agent Skills">Konfigurera AEM Agent Skills</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du konfigurerar AEM Agent Skills för AI-assisterad utveckling.</p>
                </div>
                <a href="./setup/agent-skills.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Installera AEM Agent Skills </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Användningsexempel

<!-- 
CARDS
{target = _self}

* ./use-cases/component-development.md    
    {title = Create AEM Component with AI-assisted development}
    {description = Learn how to use AI-assisted development to develop AEM components.}
    {image = ./assets/component-development/review-generated-code.png}
    {cta = Create AEM Component}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Create AEM Component with AI-assisted development">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./use-cases/component-development.md" title="Skapa AEM Component med AI-stödd utveckling" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="./assets/component-development/review-generated-code.png" alt="Skapa AEM Component med AI-stödd utveckling"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./use-cases/component-development.md" target="_self" rel="referrer" title="Skapa AEM Component med AI-stödd utveckling">Skapa AEM-komponent med AI-assisterad utveckling</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du använder AI-assisterad utveckling för att utveckla AEM-komponenter.</p>
                </div>
                <a href="./use-cases/component-development.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold"> Skapa AEM-komponent </span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->

## Ytterligare resurser

- [Lokal utveckling med AI-verktyg](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/ai-in-aem/local-development-with-ai-tools)

- [Adobe Skills for AI Coding Agents](https://github.com/adobe/skills)

- [AGENTS.md](https://agents.md/)

- [Agentfärdigheter](https://agentskills.io/home)