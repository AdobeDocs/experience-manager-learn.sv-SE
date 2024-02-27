---
title: AEM Content Fragments extensions
description: Lär dig hur du skapar och distribuerar AEM as a Cloud Service Content Fragment-tillägg
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay
jira: KT-11603
thumbnail: KT-11603.png
last-substantial-update: 2023-06-02T00:00:00Z
exl-id: 9164423b-a609-4bc5-9777-112d229ae748
duration: 388
source-git-commit: bb902089a709ab00853f4856d9bf42c18a5097e7
workflow-type: tm+mt
source-wordcount: '773'
ht-degree: 0%

---

# AEM Content Fragments extensibility

Gränssnittet AEM innehållsfragment är ett kraftfullt, utbyggbart gränssnitt för att hantera, skapa, hantera och redigera innehållsfragment. Det finns flera tilläggspunkter som du kan använda för att anpassa användargränssnittet efter dina behov. Olika tilläggspunkter är tillgängliga, baserat på vilket gränssnitt du utökar.

## Tilläggspunkter för konsoltillägg för innehållsfragment

Content Fragment Console i AEM (Adobe Experience Manager) är ett användargränssnitt som är en central plats för hantering och organisering av innehållsfragment. Det innehåller en omfattande uppsättning verktyg och funktioner för att skapa, redigera, publicera och spåra innehållsfragment, vilket gör det möjligt för användare att effektivt hantera strukturerat innehåll över olika kanaler och kontaktytor.

![Konsol för innehållsfragment](./assets/overview/cfc.png)

[AEM Content Fragments Console](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/content-fragments/content-fragments-console.html) är ett utbyggbart gränssnitt för att lista och hantera innehållsfragment. [AEM Content Fragment Console-tillägg skapas](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/code-generation) med `@adobe/aem-cf-admin-ui-ext-tpl` App Builder-mall.

Följande utökningspunkter för Content Fragments Console är tillgängliga:

<div class="columns is-multiline">
      <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Action bar">
        <div class="card" style="height: 100%">
          <div class="card-image">
            <figure class="image is-16by9">
              <a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/" title="Åtgärdsfält" tabindex="-1" target="_blank" rel="referrer">
                <img class="is-bordered-r-small" src="./assets/overview/cfc-action-bar.png" alt="Åtgärdsfält">
              </a>
            </figure>
          </div>
          <div class="card-content is-padded-small">
            <div class="content">
              <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/" title="Åtgärdsfält" target="_blank" rel="referrer">Åtgärdsfält</a></p>
              <p class="is-size-6">Anpassa åtgärder för när en eller flera innehållsfragment är markerade.</p>
              <a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/action-bar/" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
              </a>
            </div>
          </div>
        </div>
      </div>
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Grid columns">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/grid-columns/" title="Stödrasterkolumner" tabindex="-1" target="_blank" rel="referrer">
            <img class="is-bordered-r-small" src="./assets/overview/cfc-grid-columns.png" alt="Stödrasterkolumner">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/grid-columns/" title="Stödrasterkolumner" target="_blank" rel="referrer">Stödrasterkolumner</a></p>
          <p class="is-size-6">Anpassa de data som visas i listan Innehållsfragment.</p>
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/grid-columns/" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
          </a>
        </div>
      </div>
    </div>
  </div>
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Header menu">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/header-menu/" title="Sidhuvudsmenyn" tabindex="-1" target="_blank" rel="referrer">
            <img class="is-bordered-r-small" src="./assets/overview/cfc-header-menu.png" alt="Sidhuvudsmenyn">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/header-menu/" title="Sidhuvudsmenyn" target="_blank" rel="referrer">Sidhuvudsmenyn</a></p>
          <p class="is-size-6">Anpassa åtgärder för när inga innehållsfragment är markerade.</p>
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/api/header-menu/" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
          </a>
        </div>
      </div>
    </div>
  </div>  
</div>

## Tilläggspunkter för Content Fragments Editor

Innehållsfragmentsredigeraren i AEM (Adobe Experience Manager) är en användargränssnittskomponent som gör att användare kan skapa, redigera och hantera innehållsfragment. Det är en visuellt intuitiv och användarvänlig miljö för att arbeta med strukturerat innehåll, där användarna kan definiera och ordna innehållselement, använda mallar, hantera variationer och förhandsgranska hur innehållet ser ut i olika kanaler. Med Content Fragment Editor effektiviseras processen att skapa återanvändbart och modulärt innehåll som enkelt kan distribueras och publiceras i flera digitala upplevelser.

![Redigera innehållsfragment](./assets/overview/cfe.png)

AEM Content Fragments Editor är ett utbyggbart gränssnitt för redigering av innehållsfragment. [AEM tillägg för innehållsfragmentredigeraren skapas](https://developer.adobe.com/uix/docs/services/aem-cf-editor/code-generation/) med `@adobe/aem-cf-editor-ui-ext-tpl` App Builder-mall.

Följande tilläggspunkter för Content Fragments Editor är tillgängliga:

<div class="columns is-multiline">
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Header menu">
      <div class="card" style="height: 100%">
        <div class="card-image">
          <figure class="image is-16by9">
            <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/header-menu" title="Sidhuvudsmenyn" tabindex="-1" target="_blank" rel="referrer">
              <img class="is-bordered-r-small" src="./assets/overview/cfe-header-menu.png" alt="Sidhuvudsmenyn">
            </a>
          </figure>
        </div>
        <div class="card-content is-padded-small">
          <div class="content">
            <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/header-menu/" title="Sidhuvudsmenyn" target="_blank" rel="referrer">Sidhuvudsmenyn</a></p>
            <p class="is-size-6">Anpassa åtgärder på rubrikmenyn i Content Fragment Editor.</p>
            <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/header-menu" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
              <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
            </a>
          </div>
        </div>
      </div>
    </div>
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Rich Text Editor toolbar">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-toolbar/" title="Verktygsfältet för textredigeraren" tabindex="-1" target="_blank" rel="referrer">
            <img class="is-bordered-r-small" src="./assets/overview/cfe-rte-toolbar.png" alt="Verktygsfältet för textredigeraren">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-toolbar/" title="Verktygsfältet för textredigeraren"  target="_blank" rel="referrer">Verktygsfältet för textredigeraren</a></p>
          <p class="is-size-6">Lägg till en anpassad knapp i RTE (Rich Text Editor) i Content Fragment Editor.</p>
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-toolbar/" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
          </a>
        </div>
      </div>
    </div>
  </div>

<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Rich Text Editor widgets">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-widgets/" title="RTF-redigeringswidgetar" tabindex="-1"  target="_blank" rel="referrer">
            <img class="is-bordered-r-small" src="./assets/overview/cfe-rte-widgets.png" alt="RTF-redigeringswidgetar">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-widgets/" title="RTF-redigeringswidgetar" target="_blank" rel="referrer">RTF-redigeringswidgetar</a></p>
          <p class="is-size-6">Anpassa åtgärder i RTE som är bundna till tangenttryckningar.</p>
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-widgets/" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
          </a>
        </div>
      </div>
    </div>
  </div>
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Rich Text Editor badges">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-badges/" title="Märken för textredigerare" tabindex="-1" target="_blank" rel="referrer">
            <img class="is-bordered-r-small" src="./assets/overview/cfe-rte-badges.png" alt="Märken för textredigerare">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-badges/ " title="Märken för textredigerare" target="_blank" rel="referrer">Märken för textredigerare</a></p>
          <p class="is-size-6">Anpassa icke-redigerbara formaterade block inuti RTE.</p>
          <a href="https://developer.adobe.com/uix/docs/services/aem-cf-editor/api/rte-badges/" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM" target="_blank" rel="referrer">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa dokumenten</span>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

## Exempel på tillägg

Välkommen till en samling AEM exempel på utökningskod för användargränssnitt! Resursen är utformad för att ge dig praktiska demonstrationer och insikter om hur du utökar Adobe Experience Manager (AEM) användargränssnitt. Oavsett om du är utvecklare och vill förbättra funktionaliteten hos AEM kan dessa kodexempel vara en värdefull referens.

<div class="columns is-multiline">
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Bulk property update">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/console-bulk-property-update.md" title="Uppdatering av massegenskap" tabindex="-1">
            <img class="is-bordered-r-small" src="./assets/../examples/assets/bulk-property-update/card.png" alt="Uppdatering av massegenskap">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/console-bulk-property-update.md" title="Uppdatering av massegenskap">Egenskapsuppdatering för massinnehåll</a></p>
          <p class="is-size-6">Ett tillägg till åtgärdsfältet för Content Fragment Console med modal- och Adobe I/O Runtime-åtgärd.</p>
          <a href="./examples/console-bulk-property-update.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div>
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="OpenAI-based image generation and upload to AEM extension">
        <div class="card" style="height: 100%">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./examples/console-image-generation-and-image-upload.md" title="OpenAI-baserad bildgenerering och överföring till AEM" tabindex="-1">
                        <img class="is-bordered-r-small" src="./examples/assets/digital-image-generation/card.png" alt="OpenAI-baserad bildgenerering och överföring till AEM">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/console-image-generation-and-image-upload.md" title="OpenAI-baserad bildgenerering och överföring till AEM">Generering av OpenAPI-bilder</a></p>
                    <p class="is-size-6">Utforska ett exempel på ett åtgärdsfälttillägg som genererar en bild med OpenAI, överför den till AEM och uppdaterar bildegenskapen för det valda innehållsfragmentet.</p>
                    <a href="./examples/console-image-generation-and-image-upload.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
                    </a>
                </div>
            </div>
        </div>
    </div>    
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Custom columns">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/custom-grid-columns.md" title="Anpassade kolumner" tabindex="-1">
            <img class="is-bordered-r-small" src="./examples/assets/custom-grid-columns/card.png" alt="Anpassade kolumner">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/custom-grid-columns.md" title="Anpassade kolumner">Anpassade kolumner</a></p>
          <p class="is-size-6">Lägg till en anpassad kolumn i konsolen för innehållsfragment.</p>
          <a href="./examples/custom-grid-columns.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div>    
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Export to XML">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/editor-export-to-xml.md" title="Exportera till XML" tabindex="-1">
            <img class="is-bordered-r-small" src="./examples/assets/export-to-xml/card.png" alt="Exportera till XML">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/editor-export-to-xml.md" title="Exportera till XML">Exportera till XML</a></p>
          <p class="is-size-6">Exportera ett innehållsfragment som XML från Content Fragment Editor.</p>
          <a href="./examples/editor-export-to-xml.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div>    
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Rich Text Editor toolbar button">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/editor-rte-toolbar.md" title="RTF-redigerare (verktygsfältsknapp)" tabindex="-1">
            <img class="is-bordered-r-small" src="./examples/assets/rte/rte-toolbar-card.png" alt="RTF-redigerare (verktygsfältsknapp)">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/editor-rte-toolbar.md" title="RTF-redigerare (verktygsfältsknapp)">RTF-redigerare (verktygsfältsknapp)</a></p>
          <p class="is-size-6">Lägg till anpassade verktygsfältsknappar i RTE-fält i Content Fragment Editor.</p>
          <a href="./examples/editor-rte-toolbar.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div>   
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Rich Text Editor Widget">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/editor-rte-widget.md" title="Widget för textredigeraren" tabindex="-1">
            <img class="is-bordered-r-small" src="./examples/assets/rte/rte-widget-card.png" alt="Widget för textredigeraren">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/editor-rte-toolbar.md" title="Widget för textredigeraren">Widget för textredigeraren</a></p>
          <p class="is-size-6">Lägg till widgetar i RTF-redigeraren i Content Fragment Editor.</p>
          <a href="./examples/editor-rte-widget.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div>   
  <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Rich Text Editor Badge">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/editor-rte-badges.md" title="Rich Text Editor Badge" tabindex="-1">
            <img class="is-bordered-r-small" src="./examples/assets/rte/rte-badge-card.png" alt="Rich Text Editor Badge">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/editor-rte-badges.md" title="Rich Text Editor Badge">Rich Text Editor Badge</a></p>
          <p class="is-size-6">Lägg till märken i RTF-redigeraren i Content Fragment Editor.</p>
          <a href="./examples/editor-rte-badges.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div>

<div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Custom fields">
    <div class="card" style="height: 100%">
      <div class="card-image">
        <figure class="image is-16by9">
          <a href="./examples/editor-custom-field.md" title="Anpassade fält" tabindex="-1">
            <img class="is-bordered-r-small" src="https://video.tv.adobe.com/v/3427585?format=jpeg" alt="Anpassade fält">
          </a>
        </figure>
      </div>
      <div class="card-content is-padded-small">
        <div class="content">
          <p class="headline is-size-6 has-text-weight-bold"><a href="./examples/editor-custom-field.md" title="Anpassade fält">Anpassade fält</a></p>
          <p class="is-size-6">Skapa anpassade fält för innehållsfragment.</p>
          <a href="./examples/editor-custom-field.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
            <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Visa exemplet</span>
          </a>
        </div>
      </div>
    </div>
  </div> 
</div>
