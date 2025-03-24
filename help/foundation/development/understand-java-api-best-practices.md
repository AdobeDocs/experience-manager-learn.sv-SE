---
title: Java&handel; API Best Practices in AEM
description: AEM bygger på en omfattande programstack med öppen källkod som visar många Java&trade; API:er för utveckling. I den här artikeln utforskas de viktigaste API:erna och när och varför de ska användas.
version: Experience Manager 6.4, Experience Manager 6.5
feature: APIs
topic: Development
role: Developer
level: Beginner
doc-type: Article
exl-id: b613aa65-f64b-4851-a2af-52e28271ce88
last-substantial-update: 2022-06-24T00:00:00Z
thumbnail: aem-java-bp.jpg
duration: 416
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '1726'
ht-degree: 0%

---

# Java™ API Best Practices

Adobe Experience Manager (AEM) bygger på en kraftfull programstack med öppen källkod som visar många Java™-API:er för användning under utveckling. I den här artikeln utforskas de viktigaste API:erna och när och varför de ska användas.

AEM bygger på fyra primära Java™ API-uppsättningar.

* **Adobe Experience Manager (AEM)**

   * Produktabstraktioner som sidor, resurser, arbetsflöden osv.

* **Apache Sling Web Framework**

   * REST och resursbaserade abstraktioner som resurser, värdescheman och HTTP-begäranden.

* **JCR (Apache Jackrabbit Oak)**

   * Data- och innehållsabstraktioner som nod, egenskaper och sessioner.

* **OSGi (Apache Felix)**

   * OSSGi-programbehållarabstraktioner som tjänster och OSGi-komponenter.

## Java™ API-inställning för&quot;tumregel&quot;

Den allmänna regeln är att föredra API:erna/abstraktionerna i följande ordning:

1. **AEM**
1. **Sling**
1. **JCR**
1. **OSGi**

Om ett API tillhandahålls av AEM bör du föredra det framför [!DNL Sling], JCR och OSGi. Om AEM inte har något API bör du föredra [!DNL Sling] framför JCR och OSGi.

Den här ordningen är en allmän regel, vilket innebär undantag. Godtagbara orsaker att bryta mot den här regeln är:

* Välkända undantag, enligt beskrivningen nedan.
* Nödvändiga funktioner är inte tillgängliga i ett API på högre nivå.
* Fungerar med befintlig kod (anpassad produktkod eller AEM-produktkod) som i sin tur använder ett mindre prioriterat API, och kostnaden för att gå över till det nya API:t är obefogad.

   * Det är bättre att konsekvent använda API:t på lägre nivå än att skapa en blandning.

## AEM API:er

* [**AEM API JavaDocs**](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/index.html)

AEM API:er innehåller abstraktioner och funktioner som är specifika för produktioner.

AEM-API:erna [PageManager](https://developer.adobe.com/experience-manager/reference-materials/cloud-service/javadoc/com/day/cq/wcm/api/PageManager.html) och [Page](https://developer.adobe.com/experience-manager/reference-materials/cloud-service/javadoc/com/day/cq/wcm/api/Page.html) innehåller till exempel abstraktioner för `cq:Page` noder i AEM som representerar webbsidor.

Dessa noder är tillgängliga via [!DNL Sling] API:er som resurser och JCR-API:er som noder, men AEM API:er innehåller abstraktioner för vanliga användningsområden. Med AEM API:er säkerställs ett konsekvent beteende mellan AEM och AEM samt anpassningar och tillägg.

### com.adobe.&#42; vs com.day.&#42; API:er

AEM-API:er har en paketspecifik inställning som identifieras av följande Java™-paket, i prioritetsordning:

1. `com.adobe.cq`
1. `com.adobe.granite`
1. `com.day.cq`

Paketet `com.adobe.cq` har stöd för produktanvändningsfall, medan `com.adobe.granite` har stöd för flerproduktsplattformsanvändning, som arbetsflöde eller uppgifter (som används för olika produkter: AEM Assets, Sites, osv.).

Paketet `com.day.cq` innehåller ursprungliga API:er. Dessa API:er åtgärdar viktiga abstraktioner och funktioner som fanns före och/eller runt Adobe förvärv av [!DNL Day CQ]. Dessa API:er stöds och bör undvikas, såvida inte `com.adobe.cq`- eller `com.adobe.granite`-paketen inte har ett (nyare) alternativ.

Nya abstraktioner som [!DNL Content Fragments] och [!DNL Experience Fragments] är inbyggda i `com.adobe.cq`-utrymmet i stället för `com.day.cq` som beskrivs nedan.

### Fråga API:er

AEM stöder flera frågespråk. De tre huvudspråken är [JCR-SQL2](https://docs.jboss.org/jbossdna/0.7/manuals/reference/html/jcr-query-and-search.html), XPath och [AEM Query Builder](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html).

Det viktigaste problemet är att ha ett konsekvent frågespråk i hela kodbasen, vilket minskar komplexiteten och gör att du lättare kan förstå kostnaderna.

Alla frågespråk har i princip samma prestandaprofiler, eftersom [!DNL Apache Oak] kopplar dem till JCR-SQL2 för slutlig frågekörning, och konverteringstiden till JCR-SQL2 är försumbar jämfört med själva frågetiden.

Det önskade API:t är [AEM Query Builder](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html), som är den högsta nivån för abstraktion och som tillhandahåller ett robust API för att skapa, köra och hämta resultat för frågor, och som ger följande:

* Enkel, parametriserad frågekonstruktion (frågeparametrar som modelleras som en karta)
* Inbyggt [Java™ API och HTTP API:er](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/previous-updates/aem-previous-versions.html)
* [AEM Query Debugger](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html)
* [AEM förutsäger](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-predicate-reference.html) som stöder gemensamma frågekrav

* Utbyggbart API, som möjliggör utveckling av anpassade [frågepredikat](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/previous-updates/aem-previous-versions.html)
* JCR-SQL2 och XPath kan köras direkt via [[!DNL Sling]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html#findResources-java.lang.String-java.lang.String-) och [JCR API:er](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/index.html), vilket returnerar resultatet [[!DNL Sling] Resources](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) respektive [JCR Nodes](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/javax/jcr/Node.html).

>[!CAUTION]
>
>AEM QueryBuilder API läcker ett ResourceResolver-objekt. Följ det här [kodexemplet](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/core/src/main/java/com/adobe/acs/samples/search/querybuilder/impl/SampleQueryBuilder.java#L164) om du vill minska läckan.
>

## [!DNL Sling] API:er

* [**Apache [!DNL Sling] API JavaDocs**](https://sling.apache.org/apidocs/sling10/)

[Apache [!DNL Sling]](https://sling.apache.org/) är det RESTful-webbramverk som stöder AEM. [!DNL Sling] tillhandahåller routning av HTTP-begäran, modeller av JCR-noder som resurser, ger säkerhetskontext och mycket annat.

[!DNL Sling] API:er har dessutom fördelen att skapas för tillägg, vilket innebär att det ofta är enklare och säkrare att förstärka beteendet för program som skapats med [!DNL Sling] API:er än de mindre utökningsbara JCR-API:erna.

### Vanliga användningsområden för [!DNL Sling] API:er

* Åtkomst till JCR-noder som [[!DNL Sling Resources]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) och åtkomst till deras data via [ValueMaps](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ValueMap.html).

* Tillhandahåller säkerhetskontext via [ResourceResolver](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Skapar och tar bort resurser via ResourceResolver [create/move/copy/delete-metoder](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Uppdaterar egenskaper via [ModiitableValueMap](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html).
* Byggstenar för bearbetning av begäranden

   * [Servlets](https://sling.apache.org/documentation/the-sling-engine/servlets.html)
   * [Serverfilter](https://sling.apache.org/documentation/the-sling-engine/filters.html)

* Byggstenar för asynkron bearbetning

   * [Händelse- och jobbhanterare](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html)
   * [Schemaläggaren](https://sling.apache.org/documentation/bundles/scheduler-service-commons-scheduler.html)
   * [Sling Models](https://sling.apache.org/documentation/bundles/models.html)

* [Tjänstanvändare](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security-service-users.html)

## JCR-API:er

* **[JCR 2.0 JavaDocs](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/index.html)**

[JCR-API:erna (Java™ Content Repository) 2.0](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/index.html) är en del av en specifikation för JCR-implementeringar (för AEM [Apache Jackrabbit Oak](https://jackrabbit.apache.org/oak/docs/)). All JCR-implementering måste följa och implementera dessa API:er, och är därför den lägsta nivån för API för interaktion med AEM-innehåll.

Själva JCR är ett hierarkiskt/trädbaserat NoSQL-datalager som AEM använder som innehållsdatabas. JCR har en mängd API:er som stöds, från innehålls-CRUD till frågor om innehåll. Trots detta robusta API är det sällsynt att de föredras framför AEM- och [!DNL Sling]-abstraktioner på högre nivå.

Använd alltid JCR-API:erna framför API:erna i Apache Jackrabbit Oak. JCR-API:erna är till för ***interaktion*** med en JCR-databas, medan Oak-API:erna är till för ***implementering*** av en JCR-databas.

### Vanliga missuppfattningar om JCR-API:er

Även om JCR är AEM innehållsdatabas är dess API:er INTE den metod som rekommenderas för interaktion med innehållet. Använd i stället AEM API:er (Page, Assets, Tag o.s.v.) eller Sling Resource API:er så att de ger bättre abstraktioner.

>[!CAUTION]
>
>En stor användning av JCR-API:ernas Session- och Node-gränssnitt i ett AEM-program är kodlukt. Se till att [!DNL Sling] API:er används i stället.

### Vanliga användningsområden för JCR-API:er

* [Hantering av åtkomstkontroll](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security-service-users.html)
* [Auktoriserbar hantering (användare/grupper)](https://jackrabbit.apache.org/api/2.12/org/apache/jackrabbit/api/security/user/package-summary.html)
* JCR-observation (lyssnar efter JCR-händelser)
* Skapa djupnodsstrukturer

   * Även om Sling-API:erna har stöd för att skapa resurser, har JCR-API:erna bekväma metoder i [JcrUtils](https://jackrabbit.apache.org/api/2.12/org/apache/jackrabbit/commons/JcrUtils.html) och [JcrUtil](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/com/day/cq/commons/jcr/JcrUtil.html) som gör det lättare att skapa djupstrukturer.

## OSGi API:er

* [**OSGi R6 JavaDocs**](https://docs.osgi.org/javadoc/r6/cmpn/index.html?overview-summary.html)
* **[OSGi Declarative Services 1.2 Component Annotations JavaDocs](https://docs.osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html)**
* **[OSGi Declarative Services 1.2 Metatype Annotations JavaDocs](https://docs.osgi.org/javadoc/r6/cmpn/org/osgi/service/metatype/annotations/package-summary.html)**
* [**OSGi Framework JavaDocs**](https://docs.osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html)

Det finns liten överlappning mellan OSGi-API:erna och API:erna på den högre nivån (AEM, [!DNL Sling] och JCR), och behovet av att använda OSGi-API:er är sällsynt och kräver en hög nivå av AEM utvecklingsexpertis.

### API:er för OSGi och Apache Felix

OSGi definierar en specifikation som alla OSGi-behållare måste implementera och följa. AEM OSGi-implementering, Apache Felix, har också ett antal egna API:er.

* Föredra OSGi-API:er (`org.osgi`) framför Apache Felix-API:er (`org.apache.felix`).

### Vanliga användningsområden för OSGi-API:er

* OSGi-anteckningar för att deklarera OSGi-tjänster och -komponenter.

   * Föredra [OSGi Declarative Services (DS) 1.2 Anteckningar](https://docs.osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html) över [Felix SCR Annotations](https://felix.apache.org/documentation/subprojects/apache-felix-maven-scr-plugin/scr-annotations.html) för deklaration av OSGi-tjänster och -komponenter

* OSGi-API:er för dynamiskt inkodade [Kör/registrera OSGi-tjänster/komponenter](https://docs.osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html).

   * Föredra användningen av OSGi DS 1.2-anteckningar när villkorlig OSGi Service/Component Management inte behövs (vilket oftast är fallet).

## Undantag för regeln

Följande är vanliga undantag till reglerna som definieras ovan.

### OSGi API:er

När du hanterar OSGi-abstreringar på låg nivå, som att definiera eller läsa i OSGi-komponentegenskaper, föredras de nyare abstreringarna från `org.osgi` framför Sling-abstraktioner på högre nivå. Motsvarande Sling-abstractions har inte markerats som `@Deprecated` och föreslår alternativet `org.osgi`.

Observera också att noddefinitionen för OSGi-konfigurationen föredrar `cfg.json` framför formatet `sling:OsgiConfig`.

### AEM Resurser-API:er

* Föredra [`com.day.cq.dam.api`](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/com/day/cq/dam/api/package-summary.html) över [`com.adobe.granite.asset.api`](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/com/adobe/granite/asset/api/package-summary.html).

   * Assets-API:n för `com.day.cq` erbjuder mer kostnadsfria verktyg för användning av AEM-resurser.
   * Granite Assets API:er har stöd för resurshanteringsfall på låg nivå (version, relationer).

### Fråga API:er

* AEM QueryBuilder stöder inte vissa frågefunktioner som [förslag](https://jackrabbit.apache.org/oak/docs/query/query-engine.html#Suggestions), stavningskontroll och indextips bland andra mindre vanliga funktioner. Du bör använda JCR-SQL2 för att fråga med dessa funktioner.

### [!DNL Sling] servletregistrering {#sling-servlet-registration}

* [!DNL Sling] serverregistrering, använd [ OSGi DS 1.2-anteckningar med @SlingServletResourceTypes](https://sling.apache.org/documentation/the-sling-engine/servlets.html) istället för `@SlingServlet`

### [!DNL Sling] Filterregistrering {#sling-filter-registration}

* [!DNL Sling] filterregistrering, använd [ OSGi DS 1.2-anteckningar med @SlingServletFilter](https://sling.apache.org/documentation/the-sling-engine/filters.html) framför `@SlingFilter`

## Användbara kodfragment

Nedan följer några praktiska Java™-kodfragment som illustrerar de effektivaste strategierna för vanliga användningsområden med hjälp av beskrivna API:er. De här fragmenten visar också hur du går från mindre prioriterade API:er till mer önskade API:er.

### JCR-session till [!DNL Sling] ResourceResolver

#### Automatisk stängning av Sling ResourceResolver

Sedan AEM 6.2 är [!DNL Sling] ResourceResolver `AutoClosable` i en [try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) -sats. Med den här syntaxen behövs inget explicit anrop till `resourceResolver .close()`.

```java
@Reference
ResourceResolverFactory rrf;
...
Map<String, Object> authInfo = new HashMap<String, Object>();
authInfo.put(JcrResourceConstants.AUTHENTICATION_INFO_SESSION, jcrSession);

try (ResourceResolver resourceResolver = rrf.getResourceResolver(authInfo)) {
    // Do work with the resourceResolver
} catch (LoginException e) { .. }
```

#### Manuellt stängd Sling ResourceResolver

ResourceResolvers kan stängas manuellt i ett `finally`-block om det inte går att använda tekniken som visas ovan.

```java
@Reference
ResourceResolverFactory rrf;
...
Map<String, Object> authInfo = new HashMap<String, Object>();
authInfo.put(JcrResourceConstants.AUTHENTICATION_INFO_SESSION, jcrSession);

ResourceResolver resourceResolver = null;

try {
    resourceResolver = rrf.getResourceResolver(authInfo);
    // Do work with the resourceResolver
} catch (LoginException e) {
   ...
} finally {
    if (resourceResolver != null) { resourceResolver.close(); }
}
```

### JCR-sökväg till [!DNL Sling] [!DNL Resource]

```java
Resource resource = ResourceResolver.getResource("/path/to/the/resource");
```

### JCR-nod till [!DNL Sling] [!DNL Resource]

```java
Resource resource = resourceResolver.getResource(node.getPath());
```

### [!DNL Sling] [!DNL Resource] till AEM Asset

#### Rekommenderad metod

Funktionen `DamUtil.resolveToAsset(..)` löser alla resurser under `dam:Asset` till objektet Asset genom att gå uppåt i trädet efter behov.

```java
Asset asset = DamUtil.resolveToAsset(resource);
```

#### Alternativ metod

Om du anpassar en resurs till en resurs måste själva resursen vara noden `dam:Asset`.

```java
Asset asset = resource.adaptTo(Asset.class);
```

### [!DNL Sling] resurs till AEM-sida

#### Rekommenderad metod

`pageManager.getContainingPage(..)` löser alla resurser under `cq:Page` till sidobjektet genom att gå uppåt i trädet efter behov.

```java
PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
Page page = pageManager.getContainingPage(resource);
Page page2 = pageManager.getContainingPage("/content/path/to/page/jcr:content/or/component");
```

#### Alternativ metod {#alternative-approach-1}

Om du anpassar en resurs till en sida måste själva resursen vara noden `cq:Page`.

```java
Page page = resource.adaptTo(Page.class);
```

### Läs AEM Page-egenskaper

Använd Page-objektets get-metoder för att hämta välkända egenskaper (`getTitle()`, `getDescription()` o.s.v.) och `page.getProperties()` för att hämta `[cq:Page]/jcr:content` ValueMap för att hämta andra egenskaper.

```java
Page page = resource.adaptTo(Page.class);
String title = page.getTitle();
Calendar value = page.getProperties().get("cq:lastModified", Calendar.getInstance());
```

### Läs AEM Asset-metadataegenskaper

Resurs-API:t innehåller praktiska metoder för att läsa egenskaper från noden `[dam:Asset]/jcr:content/metadata`. Detta är inte en ValueMap, den andra parametern (standardvärde och datatypsbyte) stöds inte.

```java
Asset asset = resource.adaptTo(Asset.class);
String title = asset.getMetadataValue("dc:title");
Calendar lastModified = (Calendar) asset.getMetadata("cq:lastModified");
```

### Läs [!DNL Sling] [!DNL Resource]-egenskaper {#read-sling-resource-properties}

När egenskaper lagras på platser (egenskaper eller relativa resurser) där AEM-API:erna (Sida, Tillgång) inte kan komma åt direkt, kan [!DNL Sling]-resurserna och ValueMaps användas för att hämta data.

```java
ValueMap properties = resource.getValueMap();
String value = properties.get("jcr:title", "Default title");
String relativeResourceValue = properties.get("relative/propertyName", "Default value");
```

I det här fallet kan AEM-objektet behöva konverteras till [!DNL Sling] [!DNL Resource] för att effektivt hitta önskad egenskap eller underresurs.

#### AEM Page to [!DNL Sling] [!DNL Resource]

```java
Resource resource = page.adaptTo(Resource.class);
```

#### AEM-resurs till [!DNL Sling] [!DNL Resource]

```java
Resource resource = asset.adaptTo(Resource.class);
```

### Skriva egenskaper med ModiitableValueMap för [!DNL Sling]

Använd [ för ](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html) från [!DNL Sling] för att skriva egenskaper till noder. Detta kan bara skriva till den omedelbara noden (relativa egenskapssökvägar stöds inte).

Observera att anropet till `.adaptTo(ModifiableValueMap.class)` kräver skrivbehörighet för resursen, annars returneras null.

```java
ModifiableValueMap properties = resource.adaptTo(ModifiableValueMap.class);

properties.put("newPropertyName", "new value");
properties.put("propertyNameToUpdate", "updated value");
properties.remove("propertyToRemove");

resource.getResourceResolver().commit();
```

### Skapa en AEM-sida

Använd alltid PageManager för att skapa sidor när en sidmall används, vilket krävs för att du ska kunna definiera och initiera sidor i AEM.

```java
String templatePath = "/conf/my-app/settings/wcm/templates/content-page";
boolean autoSave = true;

PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
pageManager.create("/content/parent/path", "my-new-page", templatePath, "My New Page Title", autoSave);

if (!autoSave) { resourceResolver.commit(); }
```

### Skapa en [!DNL Sling]-resurs

ResourceResolver har stöd för grundläggande åtgärder för att skapa resurser. När du skapar abstraktioner på högre nivå (AEM Pages, Assets, Tags osv.) använder du de metoder som deras respektive hanterare tillhandahåller.

```java
resourceResolver.create(parentResource, "my-node-name", new ImmutableMap.Builder<String, Object>()
           .put("jcr:primaryType", "nt:unstructured")
           .put("jcr:title", "Hello world")
           .put("propertyName", "Other initial properties")
           .build());

resourceResolver.commit();
```

### Ta bort en [!DNL Sling]-resurs

ResourceResolver stöder borttagning av en resurs. När du skapar abstraktioner på högre nivå (AEM Pages, Assets, Tags osv.) använder du de metoder som deras respektive hanterare tillhandahåller.

```java
resourceResolver.delete(resource);

resourceResolver.commit();
```
