---
title: Java&trade; API Best Practices in AEM
description: AEM bygger på en omfattande programstack med öppen källkod som visar många Java&trade; API:er för användning under utveckling. I den här artikeln utforskas de viktigaste API:erna och när och varför de ska användas.
version: 6.4, 6.5
feature: APIs
topic: Development
role: Developer
level: Beginner
doc-type: Article
exl-id: b613aa65-f64b-4851-a2af-52e28271ce88
last-substantial-update: 2022-06-24T00:00:00Z
thumbnail: aem-java-bp.jpg
duration: 498
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1726'
ht-degree: 0%

---

# Java™ API Best Practices

Adobe Experience Manager (AEM) bygger på en omfattande programstack med öppen källkod som visar många Java™-API:er för användning under utveckling. I den här artikeln utforskas de viktigaste API:erna och när och varför de ska användas.

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

Om ett API tillhandahålls av AEM föredrar du det framför [!DNL Sling], JCR och OSGi. Om AEM inte har något API bör du [!DNL Sling] över JCR och OSGi.

Den här ordningen är en allmän regel, vilket innebär undantag. Godtagbara orsaker att bryta mot den här regeln är:

* Välkända undantag, enligt beskrivningen nedan.
* Nödvändiga funktioner är inte tillgängliga i ett API på högre nivå.
* Fungerar med befintlig kod (anpassad eller AEM produktkod) som i sin tur använder ett mindre prioriterat API, och kostnaden för att gå över till det nya API:t är obefogad.

   * Det är bättre att konsekvent använda API:t på lägre nivå än att skapa en blandning.

## AEM API:er

* [**AEM API JavaDocs**](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/index.html)

AEM API:er innehåller abstraktioner och funktioner som är specifika för produkterade användningsfall.

AEM [PageManager](https://developer.adobe.com/experience-manager/reference-materials/cloud-service/javadoc/com/day/cq/wcm/api/PageManager.html) och [Sida](https://developer.adobe.com/experience-manager/reference-materials/cloud-service/javadoc/com/day/cq/wcm/api/Page.html) API:er innehåller abstraktioner för `cq:Page` noder i AEM som representerar webbsidor.

Dessa noder är tillgängliga via [!DNL Sling] API:er som resurser och JCR-API:er som noder, AEM API:er innehåller abstraktioner för vanliga användningsområden. Genom att använda AEM API:er kan du säkerställa ett konsekvent beteende mellan AEM och anpassningar och tillägg till AEM.

### com.adobe.&#42; jämfört med com.day.&#42; API:er

AEM-API:er har en paketintern inställning som identifieras av följande Java™-paket, i prioritetsordning:

1. `com.adobe.cq`
1. `com.adobe.granite`
1. `com.day.cq`

The `com.adobe.cq` paketet har stöd för produktanvändning. `com.adobe.granite` har stöd för användning på olika plattformar, t.ex. arbetsflöden eller uppgifter (som används i olika produkter: AEM Assets, Sites osv.).

The `com.day.cq` paketet innehåller &quot;original&quot;-API:er. Dessa API:er åtgärdar viktiga abstraktioner och funktioner som fanns före och/eller runt Adobe förvärv av [!DNL Day CQ]. Dessa API:er stöds och bör undvikas om inte `com.adobe.cq` eller `com.adobe.granite` paket har INTE ett (nyare) alternativ.

Nya abstraktioner som [!DNL Content Fragments] och [!DNL Experience Fragments] är inbyggd i `com.adobe.cq` blanksteg i stället för `com.day.cq` beskrivs nedan.

### Fråga API:er

AEM stöder flera frågespråk. De tre huvudspråken är [JCR-SQL2](https://docs.jboss.org/jbossdna/0.7/manuals/reference/html/jcr-query-and-search.html), XPath och [AEM Query Builder](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html).

Det viktigaste problemet är att ha ett konsekvent frågespråk i hela kodbasen, vilket minskar komplexiteten och gör att du lättare kan förstå kostnaderna.

Alla frågespråk har i princip samma prestandaprofiler som [!DNL Apache Oak] överför dem till JCR-SQL2 för slutlig frågekörning, och konverteringstiden till JCR-SQL2 är försumbar jämfört med själva frågetiden.

Rekommenderat API är [AEM Query Builder](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html), som är den högsta nivån för abstraktion och ger ett robust API för att skapa, köra och hämta resultat för frågor, och som ger följande:

* Enkel, parametriserad frågekonstruktion (frågeparametrar som modelleras som en karta)
* Inbyggt [Java™ API och HTTP API:er](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/previous-updates/aem-previous-versions.html)
* [AEM Query Debugger](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-api.html)
* [AEM predikat](https://experienceleague.adobe.com/docs/experience-manager-65/developing/platform/query-builder/querybuilder-predicate-reference.html) stöder gemensamma frågekrav

* Utbyggbart API, som möjliggör utveckling av anpassat [frågepredikat](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/previous-updates/aem-previous-versions.html)
* JCR-SQL2 och XPath kan köras direkt via [[!DNL Sling]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html#findResources-java.lang.String-java.lang.String-) och [JCR-API:er](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/index.html)returnerar resultaten [[!DNL Sling] Resurs](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) eller [JCR-noder](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/javax/jcr/Node.html), respektive

>[!CAUTION]
>
>AEM QueryBuilder API läcker ett ResourceResolver-objekt. Följ detta för att minska läckan [kodexempel](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/core/src/main/java/com/adobe/acs/samples/search/querybuilder/impl/SampleQueryBuilder.java#L164).
>

## [!DNL Sling] API:er

* [**Apache [!DNL Sling] API JavaDocs**](https://sling.apache.org/apidocs/sling10/)

[Apache [!DNL Sling]](https://sling.apache.org/) är RESTful-webbramverket som stöder AEM. [!DNL Sling] tillhandahåller routning av HTTP-begäran, modeller av JCR-noder som resurser, ger säkerhetskontext och mycket annat.

[!DNL Sling] API:er har dessutom fördelen att byggas för tillägg, vilket innebär att det ofta är enklare och säkrare att förstärka beteendet i applikationer som byggts med [!DNL Sling] API:er än de mindre utökningsbara JCR-API:erna.

### Vanliga användningsområden för [!DNL Sling] API:er

* Åtkomst till JCR-noder som [[!DNL Sling Resources]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) och få tillgång till deras data via [ValueMaps](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ValueMap.html).

* Tillhandahålla säkerhetskontext via [ResursResolver](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Skapa och ta bort resurser via ResourceResolver [skapa/flytta/kopiera/ta bort metoder](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Uppdatera egenskaper via [ModiitableValueMap](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html).
* Byggstenar för bearbetning av begäranden

   * [Servlets](https://sling.apache.org/documentation/the-sling-engine/servlets.html)
   * [Servletfilter](https://sling.apache.org/documentation/the-sling-engine/filters.html)

* Byggstenar för asynkron bearbetning

   * [Händelse- och jobbhanterare](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html)
   * [Schemaläggare](https://sling.apache.org/documentation/bundles/scheduler-service-commons-scheduler.html)
   * [Sling Models](https://sling.apache.org/documentation/bundles/models.html)

* [Tjänstanvändare](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security-service-users.html)

## JCR-API:er

* **[JCR 2.0 JavaDocs](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/index.html)**

The [JCR (Java™ Content Repository) 2.0 API:er](https://developer.adobe.com/experience-manager/reference-materials/spec/javax.jcr/javadocs/jcr-2.0/index.html) ingår i en specifikation för JCR-implementeringar (i AEM fall, [Apache Jackrabbit Oak](https://jackrabbit.apache.org/oak/docs/)). All JCR-implementering måste följa och implementera dessa API:er, och är därför den lägsta nivån för API för interaktion med AEM.

Själva JCR är en hierarkisk/trädbaserad NoSQL-AEM som används som innehållsdatabas. JCR har en mängd API:er som stöds, från innehålls-CRUD till frågor om innehåll. Trots detta robusta API är det sällan de föredras framför de AEM och [!DNL Sling] abstraktioner.

Använd alltid JCR-API:erna framför API:erna för Apache Jackrabbit Oak. JCR-API:erna är för ***interagera*** med en JCR-databas, medan Oak API:er är för ***implementera*** en JCR-databas.

### Vanliga missuppfattningar om JCR-API:er

Även om JCR är AEM innehållsdatabas är dess API:er INTE den föredragna metoden för interaktion med innehållet. Använd i stället AEM API:er (Sida, Resurser, Tagg o.s.v.) eller Sling Resource API:er för att få bättre abstraktioner.

>[!CAUTION]
>
>En stor användning av JCR-API:ernas Session- och Node-gränssnitt i ett AEM program är kodlukt. Säkerställ [!DNL Sling] API:er bör användas i stället.

### Vanliga användningsområden för JCR-API:er

* [Hantering av åtkomstkontroll](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security-service-users.html)
* [Auktoriserbar hantering (användare/grupper)](https://jackrabbit.apache.org/api/2.12/org/apache/jackrabbit/api/security/user/package-summary.html)
* JCR-observation (lyssnar efter JCR-händelser)
* Skapa djupnodsstrukturer

   * Även om Sling-API:erna har stöd för att skapa resurser har JCR-API:erna praktiska metoder i [JCRUtils](https://jackrabbit.apache.org/api/2.12/org/apache/jackrabbit/commons/JcrUtils.html) och [JcrUtil](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/com/day/cq/commons/jcr/JcrUtil.html) som gör det lättare att skapa djupgående strukturer.

## OSGi API:er

* [**OSGi R6 JavaDocs**](https://docs.osgi.org/javadoc/r6/cmpn/index.html?overview-summary.html)
* **[OSGi Declarative Services 1.2 Component Annotations JavaDocs](https://docs.osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html)**
* **[OSGi Declarative Services 1.2 Metatype Annotations JavaDocs](https://docs.osgi.org/javadoc/r6/cmpn/org/osgi/service/metatype/annotations/package-summary.html)**
* [**OSGi Framework JavaDocs**](https://docs.osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html)

Det finns liten överlappning mellan OSGi-API:erna och API:erna på den högre nivån (AEM, [!DNL Sling], och JCR) och behovet av att använda API:er för OSGi är sällsynt och kräver stor AEM utvecklingskompetens.

### API:er för OSGi och Apache Felix

OSGi definierar en specifikation som alla OSGi-behållare måste implementera och följa. AEM OSGi-implementering, Apache Felix, innehåller också flera egna API:er.

* Föredra OSGi-API:er (`org.osgi`) över API:er för Apache Felix (`org.apache.felix`).

### Vanliga användningsområden för OSGi-API:er

* OSGi-anteckningar för att deklarera OSGi-tjänster och -komponenter.

   * Föredra [OSGi Declarative Services (DS) 1.2 Anteckningar](https://docs.osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html) över [Felix SCR Annotations](https://felix.apache.org/documentation/subprojects/apache-felix-maven-scr-plugin/scr-annotations.html) för att deklarera OSGi-tjänster och -komponenter

* OSGi-API:er för dynamiskt kodning [Kör/registrera OSGi-tjänster/komponenter](https://docs.osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html).

   * Föredra användningen av OSGi DS 1.2-anteckningar när villkorlig OSGi Service/Component Management inte behövs (vilket oftast är fallet).

## Undantag för regeln

Följande är vanliga undantag till reglerna som definieras ovan.

### OSGi API:er

När det gäller OSGi-abstraktioner på låg nivå, som att definiera eller läsa i OSGi-komponentegenskaper, finns de nyare abstreringarna i `org.osgi` är att föredra framför Sling-abstraktioner på högre nivå. De konkurrerande Sling-abstraktionerna har inte markerats som `@Deprecated` och föreslå `org.osgi` alternativ.

Observera även att noddefinitionen för OSGi-konfigurationen föredrar `cfg.json` över `sling:OsgiConfig` format.

### AEM resurs-API:er

* Föredra [`com.day.cq.dam.api`](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/com/day/cq/dam/api/package-summary.html) över [`com.adobe.granite.asset.api`](https://developer.adobe.com/experience-manager/reference-materials/6-5/javadoc/com/adobe/granite/asset/api/package-summary.html).

   * Med `com.day.cq` Med Assets API:er får du mer kostnadsfria verktyg för att AEM användningsfall för resurshantering.
   * Granite Assets API:er har stöd för resurshanteringsfall på låg nivå (version, relationer).

### Fråga API:er

* AEM QueryBuilder stöder inte vissa frågefunktioner som [förslag](https://jackrabbit.apache.org/oak/docs/query/query-engine.html#Suggestions), stavningskontroll och indextips med andra mindre vanliga funktioner. Du bör använda JCR-SQL2 för att fråga med dessa funktioner.

### [!DNL Sling] Registrering av serverdel {#sling-servlet-registration}

* [!DNL Sling] serletregistrering, använd [OSGi DS 1.2-anteckningar med @SlingServletResourceTypes](https://sling.apache.org/documentation/the-sling-engine/servlets.html) över `@SlingServlet`

### [!DNL Sling] Filterregistrering {#sling-filter-registration}

* [!DNL Sling] filterregistrering, använd [OSGi DS 1.2 annotations w/ @SlingServletFilter](https://sling.apache.org/documentation/the-sling-engine/filters.html) över `@SlingFilter`

## Användbara kodfragment

Nedan följer några praktiska Java™-kodfragment som illustrerar de effektivaste strategierna för vanliga användningsområden med hjälp av beskrivna API:er. De här fragmenten visar också hur du går från mindre prioriterade API:er till mer önskade API:er.

### JCR-session till [!DNL Sling] ResursResolver

#### Automatisk stängning av Sling ResourceResolver

Sedan AEM 6.2 har [!DNL Sling] ResourceResolver är `AutoClosable` i en [try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) -programsats. Med den här syntaxen anropas `resourceResolver .close()` behövs inte.

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

ResourceResolvers kan bara stängas manuellt i en `finally` om tekniken för automatisk stängning som visas ovan inte kan användas.

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

### [!DNL Sling] [!DNL Resource] till AEM

#### Rekommenderad metod

The `DamUtil.resolveToAsset(..)` funktionen löser alla resurser under `dam:Asset` till objektet Asset genom att gå upp i trädet efter behov.

```java
Asset asset = DamUtil.resolveToAsset(resource);
```

#### Alternativ metod

Att anpassa en resurs till en resurs kräver att själva resursen är `dam:Asset` nod.

```java
Asset asset = resource.adaptTo(Asset.class);
```

### [!DNL Sling] Resurs till AEM

#### Rekommenderad metod

`pageManager.getContainingPage(..)` löser alla resurser under `cq:Page` till objektet Page genom att gå upp i trädet efter behov.

```java
PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
Page page = pageManager.getContainingPage(resource);
Page page2 = pageManager.getContainingPage("/content/path/to/page/jcr:content/or/component");
```

#### Alternativ metod {#alternative-approach-1}

Att anpassa en resurs till en sida kräver att själva resursen är `cq:Page` nod.

```java
Page page = resource.adaptTo(Page.class);
```

### AEM sidegenskaper

Använd Page-objektets get-metoder för att få välkända egenskaper (`getTitle()`, `getDescription()`och så vidare) och `page.getProperties()` för att få `[cq:Page]/jcr:content` ValueMap för att hämta andra egenskaper.

```java
Page page = resource.adaptTo(Page.class);
String title = page.getTitle();
Calendar value = page.getProperties().get("cq:lastModified", Calendar.getInstance());
```

### Läs AEM Resursmetadataegenskaper

Resurs-API:t innehåller praktiska metoder för att läsa egenskaper från `[dam:Asset]/jcr:content/metadata` nod. Detta är inte en ValueMap, den andra parametern (standardvärde och datatypsbyte) stöds inte.

```java
Asset asset = resource.adaptTo(Asset.class);
String title = asset.getMetadataValue("dc:title");
Calendar lastModified = (Calendar) asset.getMetadata("cq:lastModified");
```

### Läs [!DNL Sling] [!DNL Resource] egenskaper {#read-sling-resource-properties}

När egenskaper lagras på platser (egenskaper eller relativa resurser) där AEM-API:erna (Sida, Resurs) inte har direktåtkomst, [!DNL Sling] Resurser och ValueMaps kan användas för att hämta data.

```java
ValueMap properties = resource.getValueMap();
String value = properties.get("jcr:title", "Default title");
String relativeResourceValue = properties.get("relative/propertyName", "Default value");
```

I det här fallet kan AEM-objektet behöva konverteras till [!DNL Sling] [!DNL Resource] för att effektivt hitta önskad egenskap eller underresurs.

#### AEM sida till [!DNL Sling] [!DNL Resource]

```java
Resource resource = page.adaptTo(Resource.class);
```

#### AEM resurs till [!DNL Sling] [!DNL Resource]

```java
Resource resource = asset.adaptTo(Resource.class);
```

### Skriv egenskaper med [!DNL Sling]&#39;s ModiitableValueMap

Använd [!DNL Sling]&#39;s [ModiitableValueMap](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html) för att skriva egenskaper till noder. Detta kan bara skriva till den omedelbara noden (relativa egenskapssökvägar stöds inte).

Anteckna samtalet till `.adaptTo(ModifiableValueMap.class)` kräver skrivbehörighet för resursen, annars returneras null.

```java
ModifiableValueMap properties = resource.adaptTo(ModifiableValueMap.class);

properties.put("newPropertyName", "new value");
properties.put("propertyNameToUpdate", "updated value");
properties.remove("propertyToRemove");

resource.getResourceResolver().commit();
```

### Skapa en AEM

Använd alltid PageManager för att skapa sidor när en sidmall används, vilket krävs för att definiera och initiera sidor i AEM.

```java
String templatePath = "/conf/my-app/settings/wcm/templates/content-page";
boolean autoSave = true;

PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
pageManager.create("/content/parent/path", "my-new-page", templatePath, "My New Page Title", autoSave);

if (!autoSave) { resourceResolver.commit(); }
```

### Skapa en [!DNL Sling] Resurs

ResourceResolver har stöd för grundläggande åtgärder för att skapa resurser. När du skapar abstraktioner på högre nivå (AEM sidor, resurser, taggar och så vidare) använder du de metoder som deras respektive hanterare tillhandahåller.

```java
resourceResolver.create(parentResource, "my-node-name", new ImmutableMap.Builder<String, Object>()
           .put("jcr:primaryType", "nt:unstructured")
           .put("jcr:title", "Hello world")
           .put("propertyName", "Other initial properties")
           .build());

resourceResolver.commit();
```

### Ta bort en [!DNL Sling] Resurs

ResourceResolver stöder borttagning av en resurs. När du skapar abstraktioner på högre nivå (AEM sidor, resurser, taggar och så vidare) använder du de metoder som deras respektive hanterare tillhandahåller.

```java
resourceResolver.delete(resource);

resourceResolver.commit();
```
