---
title: Webbkomponent/JS - Exempel AEM Headless
description: Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Den här webbkomponenten/JS-applikationen visar hur du ställer frågor till innehåll med hjälp AEM GraphQL API:er med beständiga frågor.
version: Cloud Service
feature: Content Fragments, GraphQL API
topic: Headless, Content Management
role: Developer
level: Beginner
jira: KT-10797
thumbnail: kt-10797.jpg
last-substantial-update: 2023-05-10T00:00:00Z
badgeVersions: label="AEM Headless as a Cloud Service" before-title="false"
exl-id: 4f090809-753e-465c-9970-48cf0d1e4790
duration: 148
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '488'
ht-degree: 0%

---

# Webbkomponent

Exempelprogram är ett bra sätt att utforska Adobe Experience Manager headless-funktioner (AEM). Detta Web Component-program visar hur man frågar efter innehåll med hjälp AEM GraphQL API:er med beständiga frågor och återger en del av användargränssnittet, med hjälp av ren JavaScript-kod.

![Webbkomponent med AEM Headless](./assets/web-component/web-component.png)

Visa [källkod på GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/web-component)

## Förutsättningar {#prerequisites}

Följande verktyg bör installeras lokalt:

+ [Node.js v18](https://nodejs.org/en/)
+ [Git](https://git-scm.com/)

## AEM

Webbkomponenten fungerar med följande AEM distributionsalternativ.

+ [AEM as a Cloud Service](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/overview.html)
+ Lokal installation med [AEM Cloud Service SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/overview.html)
   + Kräver [JDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14) (vid anslutning till lokal AEM 6.5 eller AEM SDK)

Den här exempelappen använder [basic-tutorial-solution.content.zip](../multi-step/assets/explore-graphql-api/basic-tutorial-solution.content.zip) installeras och [distributionskonfigurationer](../deployment/web-component.md) är på plats.


>[!IMPORTANT]
>
>Webbkomponenten är utformad för att ansluta till en __AEM Publish__ -miljö, men den kan hämta innehåll från AEM författare om autentisering anges i webbkomponentens [`person.js`](https://github.com/adobe/aem-guides-wknd-graphql/blob/main/web-component/src/person.js#L11) -fil.

## Så här använder du

1. Klona `adobe/aem-guides-wknd-graphql` databas:

   ```shell
   $ git clone git@github.com:adobe/aem-guides-wknd-graphql.git
   ```

1. Navigera till `web-component` underkatalog.

   ```shell
   $ cd aem-guides-wknd-graphql/web-component
   ```

1. Redigera `.../src/person.js` filen som ska innehålla AEM anslutningsinformation:

   I `aemHeadlessService` objekt, uppdatera `aemHost` för att hänvisa till AEM Publish-tjänsten.

   ```plain
   # AEM Server namespace
   aemHost=https://publish-p123-e456.adobeaemcloud.com
   
   # AEM GraphQL API and Persisted Query Details
   graphqlAPIEndpoint=graphql/execute.json
   projectName=my-project
   persistedQueryName=person-by-name
   queryParamName=name
   ```

   Om du ansluter till en AEM Author-tjänst går du till `aemCredentials` -objekt, ange lokala AEM användaruppgifter.

   ```plain
   # For Basic auth, use AEM ['user','pass'] pair (for example, when connecting to local AEM Author instance)
   username=admin
   password=admin
   ```

1. Öppna en terminal och kör kommandona från `aem-guides-wknd-graphql/web-component`:

   ```shell
   $ npm install
   $ npm start
   ```

1. Ett nytt webbläsarfönster öppnar den statiska HTML-sidan som bäddar in webbkomponenten i [http://localhost:8080](http://localhost:8080).
1. The _Personinformation_ Webbkomponenten visas på webbsidan.

## Koden

Nedan följer en sammanfattning av hur webbkomponenten är uppbyggd, hur den ansluter till AEM Headless för att hämta innehåll med GraphQL beständiga frågor och hur dessa data presenteras. Den fullständiga koden finns på [GitHub](https://github.com/adobe/aem-guides-wknd-graphql/tree/main/web-component).

### HTML-tagg för webbkomponent

En återanvändbar webbkomponent (även anpassat element) `<person-info>` läggs till i `../src/assets/aem-headless.html` HTML sida. Den har stöd för `host` och `query-param-value` -attribut för att driva komponentens beteende. The `host` attributets värdeåsidosättningar `aemHost` värde från `aemHeadlessService` objekt i `person.js`och `query-param-value` används för att markera den person som ska återges.

```html
    <person-info 
        host="https://publish-p123-e456.adobeaemcloud.com"
        query-param-value="John Doe">
    </person-info>
```

### Implementering av webbkomponenter

The `person.js` definierar Web Component-funktionen och nedan är viktiga högdagrar.

#### Implementering av PersonInfo-element

The `<person-info>` det anpassade elementets klassobjekt definierar funktionen med hjälp av `connectedCallback()` livscykelmetoder, bifoga en skuggrot, hämta GraphQL beständiga fråga och DOM-manipulering för att skapa det anpassade elementets interna skuggstruktur i DOM.

```javascript
// Create a Class for our Custom Element (person-info)
class PersonInfo extends HTMLElement {

    constructor() {
        ...
        // Create a shadow root
        const shadowRoot = this.attachShadow({ mode: "open" });
        ...
    }

    ...

    // lifecycle callback :: When custom element is appended to document
    connectedCallback() {
        ...
        // Fetch GraphQL persisted query
        this.fetchPersonByNamePersistedQuery(headlessAPIURL, queryParamValue).then(
            ({ data, err }) => {
                if (err) {
                    console.log("Error while fetching data");
                } else if (data?.personList?.items.length === 1) {
                    // DOM manipulation
                    this.renderPersonInfoViaTemplate(data.personList.items[0], host);
                } else {
                    console.log(`Cannot find person with name: ${queryParamValue}`);
                }
            }
        );
    }

    ...

    //Fetch API makes HTTP GET to AEM GraphQL persisted query
    async fetchPersonByNamePersistedQuery(headlessAPIURL, queryParamValue) {
        ...
        const response = await fetch(
            `${headlessAPIURL}/${aemHeadlessService.persistedQueryName}${encodedParam}`,
            fetchOptions
        );
        ...
    }

    // DOM manipulation to create the custom element's internal shadow DOM structure
    renderPersonInfoViaTemplate(person, host){
        ...
        const personTemplateElement = document.getElementById('person-template');
        const templateContent = personTemplateElement.content;
        const personImgElement = templateContent.querySelector('.person_image');
        personImgElement.setAttribute('src',
            host + (person.profilePicture._dynamicUrl || person.profilePicture._path));
        personImgElement.setAttribute('alt', person.fullName);
        ...
        this.shadowRoot.appendChild(templateContent.cloneNode(true));
    }
}
```

#### Registrera `<person-info>` element

```javascript
    // Define the person-info element
    customElements.define("person-info", PersonInfo);
```

### Cross-origin resource sharing (CORS)

Den här webbkomponenten är beroende av en AEM baserad CORS-konfiguration som körs på AEM och förutsätter att värdsidan körs på `http://localhost:8080` i utvecklingsläge och nedan är ett exempel på CORS OSGi-konfiguration för den lokala AEM Author-tjänsten.

Granska [distributionskonfigurationer](../deployment/web-component.md) för respektive AEM.
