---
title: MCP-servrar i AEM
description: Lär dig hur du kan använda AEM Model Context Protocol (MCP)-servrar från en AI-driven utvecklingsmiljö eller chattbaserade program för att effektivisera och snabba upp arbetet med ditt AEM-material.
version: Experience Manager as a Cloud Service
role: Leader, User, Developer
level: Beginner
doc-type: Article
duration: 0
last-substantial-update: 2026-03-04T00:00:00Z
jira: KT-20473
exl-id: 7f2e4e37-6440-423e-9ba9-9228fe03600b
source-git-commit: 794a0109e4b28b452c462c5cab37e2d094ab4897
workflow-type: tm+mt
source-wordcount: '955'
ht-degree: 0%

---

# MCP-servrar i AEM

Lär dig hur du använder AEM _Model Context Protocol (MCP)-servrar_ från en AI-baserad utvecklingsmiljö eller chattbaserade program för att effektivisera och snabba upp ditt arbete med AEM-innehåll. Du beskriver vad du vill ha på ett naturligt språk i stället för att skriva lågnivå-API-kod eller navigera i användargränssnittet i AEM.

## Lista över AEM MCP-servrar

Alla AEM MCP-servrar är tillgängliga under `https://mcp.adobeaemcloud.com/adobe/mcp/`. Mer information finns i [Använda MCP med AEM as a Cloud Service](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/using-mcp-with-aem-as-a-cloud-service).

- **Innehåll** (`/content`) - Innehållsåtgärder som att skapa, läsa, uppdatera och ta bort (CRUD) för sidor och innehållsfragment samt resursimport.
- **Innehåll (skrivskyddat)** (`/content-readonly`) - Skrivskyddade innehållsåtgärder (Get, List/Search) för sidor och innehållsfragment.
- **Cloud Manager** (`/cloudmanager`) - För att hantera Adobe Cloud Manager-program, miljöer, databaser och pipelines.

>[!TIP]
>
>De verktyg som varje server visar kan förändras över tid. Om du vill se vad som är tillgängligt nu ber du din AI att visa alla AEM MCP-verktyg (till exempel `List all AEM MCP tools available from this server and describe what they do`) eller skriver `tools/list`-prompten i din IDE.

## Användningsmönster för MCP-servern

Innan du börjar använda AEM MCP-servrar bör du känna till de två viktigaste användningsmönstren för MCP-servrarna:

- **Mentrisk** - Du sitter i förarsätet. Du frågar, AI föreslår eller kör verktyg för dig i den utvecklingsmiljön.
- **Aktiv** - Ett autentiskt program (agent eller underagent) anropar servern på egen hand och väljer verktyg och arbetar mot ett mål med liten mänsklig insats.

Så här jämför de här två användningsmönstren:

| Proportioner | Människocentral | Byråer |
| ------ | ------------- | ------- |
| **Vem kör åtgärder** | Du. <br> AI föreslår eller kör verktyg åt dig i det IDE- eller chattbaserade programmet. | AI. <br> Det avgör vilka verktyg som ska användas och fortsätter att fungera med minimal vägledning. |
| **Beslutsmyndighet** | Du behåller kontrollen. Du godkänner eller utlöser varje steg. | AI har större frihet. De effektiva åtgärderna kan kräva skyddsräcken eller godkännanden. |
| **Normalt användningsmönster** | **Per utvecklare** använder du den från ditt eget IDE- eller chattbaserade program, en utvecklare per session, som är bra för dagligt utvecklingsarbete. | **Delad** via ett autentiskt program, som delade tjänster och gateways för många användare eller agenter. |
| **Passar bäst för** | Granska innehåll, göra guidade uppdateringar, utforska eller upprepa uppgifter samtidigt som du är kvar i slingan. | Byråa arbetsflöden, batchjobb, rörledningar och mål där systemet ska fungera med minimal insats. |

### Vid användning av MCP i Agentic Systems

MCP-servrar är utformade för **MCP-klienter som används av människor** med interaktiv UX och mänsklig tillsyn. MCP-verktygets specifikation rekommenderar _en människa i slingan_ som kan godkänna eller neka verktygsanrop.

Om du använder MCP-servrar i ett autentiskt eller autonom system hanterar du det som en separat kompatibilitetsnivå. Gör **inte namn på maskinkodsverktyg** i _uppmaningar_, _tillåtelselista_ eller _routningslogik_. I MCP är _verktygsnamnet_ en programmatisk identifierare och _description_ är modellriktningstipset för LLM. Föredra funktioner eller beskrivningsbaserad fråga och val.

Implementera körtidsidentifiering via `tools/list`, hantera ändringar i verktygslistan (`notifications/tools/list_changed`) och justera med MCP-serverprovidern vid introduktion och versionshantering om du behöver stabilitetsgarantier utanför protokollets baslinje.

## MCP-enheter och deras mappning

MCP är byggt kring tre entiteter, **host**, **client** och **server**. [MCP-specifikationen](https://modelcontextprotocol.io/docs/getting-started/intro) definierar dem formellt. Tabellen nedan förklarar dock de olika termerna och deras mappning när du använder AEM MCP-servrar.

| Komponent | Standarddefinition | När AEM MCP-servrar används |
| --------- | ------------------- | ---------------- |
| **Värd** | Appen som kör allt, samlar kontext, pratar med AI, hanterar behörigheter och skapar klienter. | Ditt **IDE**- (Cursor) eller chattbaserade program är värden. Den kör MCP-klienten och avgör vilka verktyg och servrar din session kan använda. |
| **Klient** | En enda anslutning från värden till en server. Den skickar meddelanden fram och tillbaka och ser till att den serverns åtkomst är åtskild från andra. | **MCP-klienten** finns i ditt IDE- eller chattbaserade program. När du lägger till AEM Content MCP Server i inställningarna skapar det IDE- eller chattbaserade programmet en klient som kommunicerar med den servern. Dina uppmaningar och verktygsanrop går igenom den här klienten. |
| **Server** | En tjänst som visar verktyg, data och uppmaningar via MCP. Den kan köras på din dator eller på fjärrbasis. | Adobe **AEM MCP-servrar** har verktyg för att skapa, läsa, uppdatera och ta bort sidor, innehållsfragment och resurser så att AI i din IDE- eller chattbaserade applikation kan fungera med din AEM-miljö. |

Kort och gott: **Host** är ditt IDE- eller chattbaserade program, **Client** är anslutningen från den IDE- eller chattbaserade applikationen till AEM, **Server** är Adobe värdbaserade MCP-servrar som utför arbetet.

## Inställningar

AEM MCP-servrar är utformade för att fungera med en definierad uppsättning MCP-kompatibla program.
Mer information finns i [MCP-program som stöds](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/mcp-support/using-mcp-with-aem-as-a-cloud-service#supported-mcp-applications) om du vill konfigurera AEM MCP-servrar i en IDE- eller chattbaserad applikation.

## Användningsexempel

<!-- 
CARDS
{target = _self}

* ./accelerate-content-operations-with-aem-mcp-server.md    
  {title = Accelerate Content Operations with AEM MCP Server}
  {description = Learn how to use the AEM Content MCP Server from Cursor IDE to streamline and accelerate your AEM content work.}
  {image = ../assets/content-mcp-server/update-adventure-price-prompt-response.png}
  {cta = Learn Content MCP Server}

* ./cloud-manager.md
  {title = Cloud Manager MCP Server}
  {description = Learn how to use the AEM Cloud Manager MCP Server from Cursor IDE to streamline and accelerate your AEM cloud manager work.}
  {image = ../assets/cm-mcp-server/start-pipeline.png}
  {cta = Learn Cloud Manager MCP Server}
-->
<!-- START CARDS HTML - DO NOT MODIFY BY HAND -->
<div class="columns">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Accelerate Content Operations with AEM MCP Server">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./accelerate-content-operations-with-aem-mcp-server.md" title="Snabba upp innehållshanteringen med AEM MCP Server" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="../assets/content-mcp-server/update-adventure-price-prompt-response.png" alt="Snabba upp innehållshanteringen med AEM MCP Server"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./accelerate-content-operations-with-aem-mcp-server.md" target="_self" rel="referrer" title="Snabba upp innehållshanteringen med AEM MCP Server">Snabba upp innehållsåtgärder med AEM MCP Server</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du använder AEM Content MCP Server från Cursor IDE för att effektivisera och snabba upp ditt arbete med AEM-material.</p>
                </div>
                <a href="./accelerate-content-operations-with-aem-mcp-server.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig MCP-servern </span>
                </a>
            </div>
        </div>
    </div>
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Cloud Manager MCP Server">
        <div class="card" style="height: 100%; display: flex; flex-direction: column; height: 100%;">
            <div class="card-image">
                <figure class="image x-is-16by9">
                    <a href="./cloud-manager.md" title="Cloud Manager MCP Server" target="_self" rel="referrer">
                        <img class="is-bordered-r-small" src="../assets/cm-mcp-server/start-pipeline.png" alt="Cloud Manager MCP Server"
                             style="width: 100%; aspect-ratio: 16 / 9; object-fit: cover; overflow: hidden; display: block; margin: auto;">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small" style="display: flex; flex-direction: column; flex-grow: 1; justify-content: space-between;">
                <div class="top-card-content">
                    <p class="headline is-size-6 has-text-weight-bold">
                        <a href="./cloud-manager.md" target="_self" rel="referrer" title="Cloud Manager MCP Server">Cloud Manager MCP Server</a>
                    </p>
                    <p class="is-size-6">Lär dig hur du använder AEM Cloud Manager MCP Server från Cursor IDE för att effektivisera och snabba upp arbetet i AEM molnhanterare.</p>
                </div>
                <a href="./cloud-manager.md" target="_self" rel="referrer" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" style="align-self: flex-start; margin-top: 1rem;">
                    <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lär dig Cloud Manager MCP Server</span>
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END CARDS HTML - DO NOT MODIFY BY HAND -->
