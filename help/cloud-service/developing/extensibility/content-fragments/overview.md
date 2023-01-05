---
title: AEM Content Fragment-konsoltillägg
description: Lär dig hur du skapar och distribuerar AEM as a Cloud Service Content Fragment-konsoltillägg
feature: Developer Tools
version: Cloud Service
topic: Development
role: Developer
level: Beginner
recommendations: noDisplay
kt: 11603
thumbnail: KT-11603.png
last-substantial-update: 2022-12-09T00:00:00Z
source-git-commit: fbc8c11841f5b5e04a99ba74fac6f01dc3e3a2da
workflow-type: tm+mt
source-wordcount: '742'
ht-degree: 0%

---


# AEM Content Fragments Console-tillägg

[AEM Content Fragments Console](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/content-fragments/content-fragments-console.html) Tillägg kan läggas till via två tilläggspunkter: en knapp i [Content Fragment Console&#39;s](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/administering/content-fragments/content-fragments-console.html) rubrikmeny eller åtgärdsfält. Tilläggen är skrivna i JavaScript som körs som App Builder-program och kan implementera ett anpassat webbgränssnitt och serverlösa Adobe I/O Runtime-åtgärder för att utföra mer krävande, långvariga arbetsmoment.

![AEM Content Fragments Console-tillägg](./assets/overview/example.png){align="center"}

| Tilläggstyp | Beskrivning | Parametrar |
| :--- | :--- | :--- |
| Sidhuvudsmenyn | Lägger till en knapp i sidhuvudet som visas när __noll__ Innehållsfragment markeras. | Inget. |
| Åtgärdsfält | Lägger till en knapp i åtgärdsfältet som visas när __en eller flera__ Innehållsfragment markeras. | En array med de markerade innehållsfragmentens sökvägar. |

Ett enda tillägg AEM Content Fragments Console kan innehålla noll eller en rubrikmeny och noll eller en tilläggstyp för åtgärdsfältet. Om flera tilläggstyper av samma typ krävs måste flera AEM Content Fragments Console-tillägg skapas.

AEM Content Fragments Console-tillägg, kräver en [Adobe Developer Console-projekt](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/extension-development/#create-a-project-in-adobe-developer-console) och [App Builder-app](https://developer.adobe.com/uix/docs/services/aem-cf-console-admin/code-generation) med `@adobe/aem-cf-admin-ui-ext-tpl` -mall som är kopplad till Adobe Developer Console-projektet.

Välj bland följande funktioner när du genererar appen App Builder, baserat på vad tillägget gör. Alla kombinationer av alternativ kan användas i ett tillägg.

|  | Lägg till knapp i [Sidhuvudsmenyn](./header-menu.md) | Lägg till knapp i [Åtgärdsfält](./action-bar.md) | Visa [Modal](./modal.md) | Lägg till [hanterare på serversidan](./runtime-action.md) |
| ------------------------------------------ | :-----------------------: | :----------------------: | :--------: | :--------------------:  |
| Tillgängligt när innehållsfragment inte har valts | ✔ |  |  |  |
| Tillgängligt när ett eller flera innehållsfragment är markerade |  | ✔ |  |  |
| Samlar in anpassade indata från användaren |  |  | ✔️ |  |
| Visar anpassad feedback för användaren |  |  | ✔️ |  |
| Anropar HTTP-begäranden till AEM |  |  |  | ✔ |
| Anropar HTTP-begäranden till Adobe/tredjepartstjänster |  |  |  | ✔ |


## Adobe Developer-dokumentation

Adobe Developer innehåller utvecklarinformation om AEM Content Fragment Console-tillägg. Granska [Adobe Developer content for more technical details](https://developer.adobe.com/uix/docs/).

## Utveckla ett tillägg

Följ stegen nedan för att lära dig hur du genererar, utvecklar och distribuerar ett AEM Content Fragment Console-tillägg för AEM as a Cloud Service.

<div class="columns is-multiline">
    <!-- Create Adobe Developer Project -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Create Adobe Developer Project">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./adobe-developer-console-project.md" title="Skapa Adobe Developer Project" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/project/card.png" alt="Skapa Adobe Developer Project">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">1. Skapa ett projekt</p>
                    <p class="is-size-6">Skapa ett Adobe Developer Console-projekt som definierar åtkomst till andra Adobe-tjänster och hanterar distributionen av det.</p>
                    <a href="./adobe-developer-console-project.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Skapa ett Adobe Developer-projekt</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Generate an Extension app -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Generate an Extension app">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./app-initialization.md" title="Skapa en tilläggsapp" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/initialize-app/card.png" alt="Initiera en tilläggsapp">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">2. Initiera en tilläggsapp</p>
                    <p class="is-size-6">Initiera ett AEM Content Fragment Console-tillägg i App Builder som definierar var tillägget visas och hur det fungerar.</p>
                    <a href="./app-initialization.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Initiera en tilläggsapp</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Extension registration -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Extension registration">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./extension-registration.md" title="Tilläggsregistrering" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/extension-registration/card.png" alt="Tilläggsregistrering">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">3. Tilläggsregistrering</p>
                    <p class="is-size-6">Registrera tillägget i AEM Content Fragment Console som en huvudmeny eller tilläggstyp för åtgärdsfältet.</p>
                    <a href="./extension-registration.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Registrera tillägget</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Header Menu -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Header menu">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./header-menu.md" title="Sidhuvudsmenyn" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/header-menu/card.png" alt="Sidhuvudsmenyn">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">4a. Sidhuvud-menyn</p>
                    <p class="is-size-6">Lär dig hur du skapar ett AEM Content Fragment Console-rubrikmenytillägg.</p>
                    <a href="./header-menu.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Utöka rubrikmenyn</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Action Bar -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Action Bar">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./action-bar.md" title="Åtgärdsfält" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/action-bar/card.png" alt="Åtgärdsfält">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">4b. Åtgärdsfält</p>
                    <p class="is-size-6">Lär dig hur du skapar ett AEM tillägg till åtgärdsfältet för innehållsfragmentkonsolen.</p>
                    <a href="./action-bar.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Utöka åtgärdsfältet</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Modal">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./modal.md" title="Modal" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/modal/card.png" alt="Modal">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">5. Modal</p>
                    <p class="is-size-6">Lägg till en anpassad modal till tillägget som kan användas för att skapa anpassade upplevelser för användarna. Modaler samlar ofta in indata från användare och visar resultatet av en åtgärd.</p>
                    <a href="./modal.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lägg till en modal</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Adobe I/O Runtime action -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Adobe I/O Runtime action">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./runtime-action.md" title="Adobe I/O Runtime action" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/runtime-action/card.png" alt="Adobe I/O Runtime action">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">6. Adobe I/O Runtime action</p>
                    <p class="is-size-6">Lägg till en serverlös Adobe I/O Runtime-åtgärd som tillägget kan anropa för att interagera med innehållsfragment och AEM för att utföra anpassade affärsåtgärder.</p>
                    <a href="./runtime-action.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Lägg till en Adobe I/O Runtime-åtgärd</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Test -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Test">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./test.md" title="Testa" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/test/card.png" alt="Testa">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">7. Testa</p>
                    <p class="is-size-6">Testa tilläggen under utveckling och dela färdiga tillägg till QA- eller UAT-testare med en särskild URL.</p>
                    <a href="./test.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Testa tillägget</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Extension deployment -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Extension deployment">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./deploy.md" title="Tilläggsdistribution" tabindex="-1">
                        <img class="is-bordered-r-small" src="./assets/deploy/card.png" alt="Tilläggsdistribution">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">8. Produktionsdistribution</p>
                    <p class="is-size-6">Distribuera tillägget till Adobe I/O så att det blir tillgängligt för AEM användare. Tillägg kan uppdateras och tas bort.</p>
                    <a href="./deploy.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Distribuera till produktion</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

## Exempel på tillägg

Exempel AEM tillägg för Content Fragment Console.

<div class="columns is-multiline">
    <!-- Bulk property update extension -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Bulk property update extension">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./example-extensions/bulk-property-update.md" title="Uppdateringstillägg för massegenskap" tabindex="-1">
                        <img class="is-bordered-r-small" src="./example-extensions/assets/bulk-property-update/card.png" alt="Uppdateringstillägg för massegenskap">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">Uppdateringstillägg för massegenskap</p>
                    <p class="is-size-6">Utforska ett exempel på ett åtgärdsfälttillägg som massuppdaterar en egenskap på valda innehållsfragment.</p>
                    <a href="./example-extensions/bulk-property-update.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Utforska exempeltillägget</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- Bulk property update extension -->
    <div class="column is-half-tablet is-half-desktop is-one-third-widescreen" aria-label="Image generation and upload to AEM extension">
        <div class="card">
            <div class="card-image">
                <figure class="image is-16by9">
                    <a href="./example-extensions/image-generation-and-image-upload.md" title="Bildgenerering och överföring till AEM" tabindex="-1">
                        <img class="is-bordered-r-small" src="./example-extensions/assets/digital-image-generation/screenshot.png" alt="Bildgenerering och överföring till AEM">
                    </a>
                </figure>
            </div>
            <div class="card-content is-padded-small">
                <div class="content">
                    <p class="headline is-size-5 has-text-weight-bold">Bildgenerering och överföring till AEM</p>
                    <p class="is-size-6">Utforska ett exempel på ett åtgärdsfälttillägg som genererar en bild med OpenAI, överför den till AEM och uppdaterar bildegenskapen för det valda innehållsfragmentet.</p>
                    <a href="./example-extensions/image-generation-and-image-upload.md" class="spectrum-Button spectrum-Button--outline spectrum-Button--primary spectrum-Button--sizeM">
                        <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Utforska exempeltillägget</span>
                    </a>
                </div>
            </div>
        </div>
    </div>



</div>
