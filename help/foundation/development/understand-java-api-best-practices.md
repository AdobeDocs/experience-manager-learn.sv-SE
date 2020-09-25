---
title: Förstå bästa praxis för Java API i AEM
description: AEM bygger på en programhög med öppen källkod som visar många Java API:er för användning under utveckling. I den här artikeln utforskas de viktigaste API:erna och när och varför de ska användas.
version: 6.2, 6.3, 6.4, 6.5
sub-product: grund, resurser, platser
feature: null
topics: best-practices, development
activity: develop
audience: developer
doc-type: article
translation-type: tm+mt
source-git-commit: fcb47ee3878f6a789b2151e283431c4806e12564
workflow-type: tm+mt
source-wordcount: '2028'
ht-degree: 0%

---


# Förstå bästa praxis för Java API

Adobe Experience Manager (AEM) bygger på en omfattande programstack med öppen källkod som visar många Java API:er för användning under utveckling. I den här artikeln utforskas de viktigaste API:erna och när och varför de ska användas.

AEM bygger på fyra primära Java API-uppsättningar.

* **Adobe Experience Manager (AEM)**

   * Produktabstraktioner som sidor, resurser, arbetsflöden osv.

* **[!DNL Apache Sling]Web Framework**

   * REST och resursbaserade abstraktioner som resurser, värdescheman och HTTP-begäranden.

* **JCR ([!DNL Apache Jackrabbit Oak])**

   * Data- och innehållsabstraktioner som nod, egenskaper och sessioner.

* **[!DNL OSGi (Apache Felix)]**

   * OSSGi-programbehållarabstraktioner som tjänster och OSGi-komponenter.

## Java API-inställningen &quot;rule of thumb&quot;

Den allmänna regeln är att föredra API:erna/abstraktionerna i följande ordning:

1. **AEM**
1. **[!DNL Sling]**
1. **JCR**
1. **OSGi**

Om ett API tillhandahålls av AEM föredrar du det framför [!DNL Sling], JCR och OSGi. Om AEM inte har något API bör du föredra [!DNL Sling] framför JCR och OSGi.

Den här ordningen är en allmän regel, vilket innebär undantag. Godtagbara orsaker att bryta mot den här regeln är:

* Välkända undantag enligt beskrivningen nedan.
* Nödvändiga funktioner är inte tillgängliga i ett API på högre nivå.
* Fungerar med befintlig kod (anpassad eller AEM produktkod) som i sin tur använder ett mindre prioriterat API, och kostnaden för att gå över till det nya API:t är obefogad.

   * Det är bättre att konsekvent använda API:t på lägre nivå än att skapa en blandning.

## AEM API:er

* [**AEM API JavaDocs**](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/index.html)

AEM API:er innehåller abstraktioner och funktioner som är specifika för produkterade användningsfall.

AEM [API:er för PageManager](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/reference-materials/javadoc/com/day/cq/wcm/api/PageManager.html) och [Page](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/wcm/foundation/model/Page.html) innehåller till exempel abstraktioner för `cq:Page` noder i AEM som representerar webbsidor.

Dessa noder är tillgängliga via API: [!DNL Sling] er som resurser och JCR-API:er som noder, men AEM API:er innehåller abstraktioner för vanliga användningsområden. Genom att använda AEM API:er kan du säkerställa ett konsekvent beteende mellan AEM av produkten samt anpassningar och tillägg till AEM.

### com.adobe.* vs. com.day.* API:er

AEM-API:er har en paketintern inställning som identifieras av följande Java-paket, i prioritetsordning:

1. `com.adobe.cq`
1. `com.adobe.granite`
1. `com.day.cq`

`com.adobe.cq` stöder produktanvändningsexempel medan det `com.adobe.granite` stöder flerproduktsplattformsanvändning, som arbetsflöden och uppgifter (som används i olika produkter: AEM Assets, Sites osv.).

`com.day.cq` innehåller &quot;original&quot;-API:er. Dessa API:er åtgärdar viktiga abstraktioner och funktioner som fanns före och/eller runt Adobe förvärv av [!DNL Day CQ]. Dessa API:er stöds och bör inte undvikas om inte `com.adobe.cq` eller `com.adobe.granite` tillhandahåller ett (nyare) alternativ.

Nya abstraktioner som [!DNL Content Fragments] och [!DNL Experience Fragments] byggs ut i `com.adobe.cq` rymden i stället för `com.day.cq` som beskrivs nedan.

### Fråga API:er

AEM har stöd för flera frågespråk. De tre huvudspråken är [JCR-SQL2](https://docs.jboss.org/jbossdna/0.7/manuals/reference/html/jcr-query-and-search.html), XPath och [AEM Query Builder](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-api.html).

Det viktigaste problemet är att ha ett konsekvent frågespråk i hela kodbasen, vilket minskar komplexiteten och gör att du lättare kan förstå kostnaderna.

Alla frågespråk har i själva verket samma prestandaprofiler, eftersom [!DNL Apache Oak] de överförs till JCR-SQL2 för slutlig frågekörning, och konverteringstiden till JCR-SQL2 är försumbar jämfört med själva frågetiden.

Det önskade API:t är [AEM Query Builder](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-api.html), som är den högsta nivån för abstraktion och ger ett robust API för att skapa, köra och hämta resultat för frågor, och som ger följande:

* Enkel, parametriserad frågekonstruktion (frågeparametrar som modelleras som en karta)
* Inbyggt [Java API och HTTP API:er](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/querybuilder-api.html)
* [OOTB-frågefelsökning](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-api.html#TestingandDebugging)
* [OOTB-predikat](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/querybuilder-predicate-reference.html) som stöder gemensamma frågekrav

* Utbyggbart API, som möjliggör utveckling av anpassade [frågepredikat](https://helpx.adobe.com/experience-manager/6-3/sites/developing/using/implementing-custom-predicate-evaluator.html)
* JCR-SQL2 och XPath kan köras direkt via API:erna [[!DNL Sling]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html#findResources-java.lang.String-java.lang.String-) och [JCR](https://docs.adobe.com/docs/en/spec/jsr170/javadocs/jcr-2.0/javax/jcr/query/package-summary.html), vilket returnerar [[!DNL Sling] Resurser](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) eller [JCR-noder](https://docs.adobe.com/docs/en/spec/jsr170/javadocs/jcr-2.0/javax/jcr/Node.html).

>[!CAUTION]
>
>AEM QueryBuilder API läcker ett ResourceResolver-objekt. Följ det här [kodexemplet](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/core/src/main/java/com/adobe/acs/samples/search/querybuilder/impl/SampleQueryBuilder.java#L164)för att minska läckan.


## [!DNL Sling] API:er

* [**Apache[!DNL Sling]API JavaDocs**](https://sling.apache.org/apidocs/sling10/)

[Apache [!DNL Sling]](https://sling.apache.org/) är det RESTful-webbramverk som stöder AEM. [!DNL Sling] tillhandahåller routning av HTTP-begäran, modeller av JCR-noder som resurser, ger säkerhetskontext och mycket annat.

[!DNL Sling] API:er har dessutom fördelen att byggas för tillägg, vilket innebär att det ofta är enklare och säkrare att förstärka beteendet hos program som byggts med API: [!DNL Sling] er än de mindre utbyggbara JCR-API:erna.

### Vanliga användningsområden för [!DNL Sling] API:er

* Åtkomst till JCR-noder som [[!DNL Sling Resources]](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/Resource.html) och åtkomst av deras data via [ValueMaps](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ValueMap.html).

* Tillhandahåller säkerhetskontext via [ResourceResolver](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html).
* Skapa och ta bort resurser via ResourceResolvers [metoder](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ResourceResolver.html)för att skapa/flytta/kopiera/ta bort.
* Uppdaterar egenskaper via [ModiitableValueMap](https://sling.apache.org/apidocs/sling10/org/apache/sling/api/resource/ModifiableValueMap.html).
* Byggstenar för bearbetning av begäranden

   * [Servlets](https://sling.apache.org/documentation/the-sling-engine/servlets.html)
   * [Serverfilter](https://sling.apache.org/documentation/the-sling-engine/filters.html)

* Byggstenar för asynkron bearbetning av arbete

   * [Händelse- och jobbhanterare](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html)
   * [Scheman](https://sling.apache.org/documentation/bundles/scheduler-service-commons-scheduler.html)
   * [Sling Models](https://sling.apache.org/documentation/bundles/models.html)

* [Tjänstanvändare](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html)

## JCR-API:er

* **[JCR 2.0 JavaDocs](https://docs.adobe.com/docs/en/spec/javax.jcr/javadocs/jcr-2.0/index.html)**

API:erna [för](https://docs.adobe.com/docs/en/spec/javax.jcr/javadocs/jcr-2.0/index.html) JCR (Java Content Repository) 2.0 ingår i en specifikation för JCR-implementeringar (för AEM [Apache Jackrabbit Oak](https://jackrabbit.apache.org/oak/)). All JCR-implementering måste följa och implementera dessa API:er, och är därför den lägsta nivån för API för interaktion med AEM.

Själva JCR är en hierarkisk/trädbaserad NoSQL-AEM som används som innehållsdatabas. JCR har en mängd API:er som stöds, från innehålls-CRUD till frågor om innehåll. Trots detta robusta API är det sällan de föredras framför AEM och [!DNL Sling] abstraktioner på högre nivå.

Använd alltid JCR-API:erna framför API:erna för Apache Jackrabbit Oak. JCR-API:erna används för ***interaktion*** med en JCR-databas, medan Oak API:er används för ***implementering*** av en JCR-databas.

### Vanliga missuppfattningar om JCR-API:er

Även om JCR är AEM innehållsdatabas är dess API:er INTE den föredragna metoden för interaktion med innehållet. Använd i stället AEM API:er (Sida, Resurser, Tagg osv.) eller Sling Resource APIs eftersom de ger bättre abstraktioner.

>[!CAUTION]
>
>En stor användning av JCR-API:ernas Session- och Node-gränssnitt i ett AEM program är kodlukt. Se till att [!DNL Sling] API:er inte används i stället.

### Vanliga användningsområden för JCR-API:er

* [Hantering av åtkomstkontroll](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-service-users.html)
* [Auktoriserbar hantering (användare/grupper)](https://jackrabbit.apache.org/api/2.8/org/apache/jackrabbit/api/security/user/package-summary.html)
* JCR-observation (avlyssna JCR-händelser)
* Skapa djupnodsstrukturer

   * Även om Sling-API:erna har stöd för att skapa resurser, har JCR-API:erna bekväma metoder i [JcrUtils](https://jackrabbit.apache.org/api/2.10/index.html?org/apache/jackrabbit/commons/JcrUtils.html) och [JcrUtil](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/commons/jcr/JcrUtil.html) som gör det lättare att skapa djupa strukturer.

## OSGi API:er

* [**OSGi R6 JavaDocs**](https://osgi.org/javadoc/r6/cmpn/index.html?overview-summary.html)
* **[OSGi Declarative Services 1.2 Component Annotations JavaDocs](https://osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html)**
* **[OSGi Declarative Services 1.2 Metatype Annotations JavaDocs](https://osgi.org/javadoc/r6/cmpn/org/osgi/service/metatype/annotations/package-summary.html)**
* [**OSGi Framework JavaDocs**](https://osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html)

Det finns liten överlappning mellan API:erna för OSGi och API:er på högre nivå (AEM, [!DNL Sling]och JCR), och behovet av att använda API:er för OSGi är sällsynt och kräver hög AEM utvecklingskompetens.

### API:er för OSGi och Apache Felix

OSGi definierar en specifikation som alla OSGi-behållare måste implementera och följa. AEM OSGi-implementering, Apache Felix, innehåller också flera egna API:er.

* Föredra API:er för OSGi (`org.osgi`) framför API:er för Apache Felix (`org.apache.felix`).

### Vanliga användningsområden för OSGi-API:er

* OSGi-anteckningar för att deklarera OSGi-tjänster och -komponenter.

   * Föredra [OSGi Declarative Services (DS) 1.2 Anteckningar](https://osgi.org/javadoc/r6/cmpn/org/osgi/service/component/annotations/package-summary.html) framför [Felix SCR Annotations](https://felix.apache.org/documentation/subprojects/apache-felix-maven-scr-plugin/scr-annotations.html) för att deklarera OSGi-tjänster och -komponenter

* OSGi-API:er för dynamisk [körning/registrering av OSGi-tjänster/-komponenter](https://osgi.org/javadoc/r6/core/org/osgi/framework/package-summary.html)i kod.

   * Föredra användningen av OSGi DS 1.2-anteckningar när villkorlig OSGi Service/Component Management inte behövs (vilket oftast är fallet).

## Undantag för regeln

Följande är vanliga undantag till reglerna som definieras ovan.

### AEM resurs-API:er

* Föredra [ över `com.day.cq.dam.api`](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/day/cq/dam/api/package-summary.html)[ `com.adobe.granite.asset.api`](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/reference-materials/javadoc/com/adobe/granite/asset/api/package-summary.html).

   * Assets-API: `com.day.cq` :n erbjuder mer kostnadsfria verktyg för att AEM användningsfall för tillgångshantering.
   * Granite Assets API:er har stöd för resurshanteringsfall på låg nivå (version, relationer).

### Fråga API:er

* AEM QueryBuilder stöder inte vissa frågefunktioner som [förslag](https://jackrabbit.apache.org/oak/docs/query/query-engine.html#Suggestions), stavningskontroll och indextips bland andra mindre vanliga funktioner. Du bör använda JCR-SQL2 för att fråga med dessa funktioner.

### [!DNL Sling] Registrering av serverdel {#sling-servlet-registration}

* [!DNL Sling] serverregistrering, använd [OSGi DS 1.2-anteckningar med @SlingServletResourceTypes](https://sling.apache.org/documentation/the-sling-engine/servlets.html) istället för `@SlingServlet`

### [!DNL Sling] Filterregistrering {#sling-filter-registration}

* [!DNL Sling] filterregistrering, använd [OSGi DS 1.2-anteckningar med @SlingServletFilter](https://sling.apache.org/documentation/the-sling-engine/filters.html) framför `@SlingFilter`

## Användbara kodfragment

Nedan följer några praktiska Java-kodfragment som illustrerar de effektivaste strategierna för vanliga användningsområden med hjälp av beskrivna API:er. De här fragmenten visar också hur du går från mindre prioriterade API:er till mer önskade API:er.

### JCR-session till [!DNL Sling] ResourceResolver

#### Stänger automatiskt Sling ResourceResolver

Sedan AEM 6.2 finns [!DNL Sling] ResourceResolver `AutoClosable` i en [try-with-resources](https://docs.oracle.com/javase/tutorial/essential/exceptions/tryResourceClose.html) -sats. Om du använder den här syntaxen behövs inget explicit anrop till `resourceResolver .close()` .

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

ResourceResolvers kan stängas manuellt i ett `finally` block om tekniken som visas ovan inte kan användas.

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

`DamUtil.resolveToAsset(..)`löser alla resurser under `dam:Asset` till Asset-objektet genom att gå upp i trädet efter behov.

```java
Asset asset = DamUtil.resolveToAsset(resource);
```

#### Alternativ metod

Om du anpassar en resurs till en resurs måste själva resursen vara `dam:Asset` noden.

```java
Asset asset = resource.adaptTo(Asset.class);
```

### [!DNL Sling] Resurs till AEM

#### Rekommenderad metod

`pageManager.getContainingPage(..)` löser alla resurser under `cq:Page` till Page-objektet genom att gå uppåt i trädet efter behov.

```java
PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
Page page = pageManager.getContainingPage(resource);
Page page2 = pageManager.getContainingPage("/content/path/to/page/jcr:content/or/component");
```

#### Alternativ metod {#alternative-approach-1}

Om du anpassar en resurs till en sida måste själva resursen vara `cq:Page` noden.

```java
Page page = resource.adaptTo(Page.class);
```

### AEM sidegenskaper

Använd objektets get-metoder för att hämta välkända egenskaper (`getTitle()`, `getDescription()`osv.) och `page.getProperties()` för att hämta `[cq:Page]/jcr:content` ValueMap för att hämta andra egenskaper.

```java
Page page = resource.adaptTo(Page.class);
String title = page.getTitle();
Calendar value = page.getProperties().get("cq:lastModified", Calendar.getInstance());
```

### Läs AEM Resursmetadataegenskaper

Resurs-API:t innehåller praktiska metoder för att läsa egenskaper från `[dam:Asset]/jcr:content/metadata` noden. Observera att detta inte är en ValueMap. Den andra parametern (standardvärde och datatypsbyte) stöds inte.

```java
Asset asset = resource.adaptTo(Asset.class);
String title = asset.getMetadataValue("dc:title");
Calendar lastModified = (Calendar) asset.getMetadata("cq:lastModified");
```

### Läsa [!DNL Sling][!DNL Resource] egenskaper {#read-sling-resource-properties}

När egenskaper lagras på platser (egenskaper eller relativa resurser) där AEM-API:erna (Sida, Tillgång) inte kan komma åt direkt, kan [!DNL Sling] resurserna och ValueMaps användas för att hämta data.

```java
ValueMap properties = resource.getValueMap();
String value = properties.get("jcr:title", "Default title");
String relativeResourceValue = properties.get("relative/propertyName", "Default value");
```

I det här fallet måste AEM-objektet konverteras till ett objekt [!DNL Sling] [!DNL Resource] för att effektivt hitta den önskade egenskapen eller underresursen.

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

Observera att anropet till `.adaptTo(ModifiableValueMap.class)` kräver skrivbehörighet för resursen, annars returneras null.

```java
ModifiableValueMap properties = resource.adaptTo(ModifiableValueMap.class);

properties.put("newPropertyName", "new value");
properties.put("propertyNameToUpdate", "updated value");
properties.remove("propertyToRemove");

resource.getResourceResolver().commit();
```

### Skapa en AEM sida

Använd alltid PageManager för att skapa sidor när en sidmall används, vilket krävs för att definiera och initiera sidor i AEM.

```java
String templatePath = "/conf/my-app/settings/wcm/templates/content-page";
boolean autoSave = true;

PageManager pageManager = resourceResolver.adaptTo(PageManager.class);
pageManager.create("/content/parent/path", "my-new-page", templatePath, "My New Page Title", autoSave);

if (!autoSave) { resourceResolver.commit(); }
```

### Skapa en [!DNL Sling] resurs

ResourceResolver stöder grundläggande åtgärder för att skapa resurser. När du skapar abstraktioner på högre nivå (AEM sidor, resurser, taggar osv.) använda de metoder som deras respektive chefer tillhandahåller.

```java
resourceResolver.create(parentResource, "my-node-name", new ImmutableMap.Builder<String, Object>()
           .put("jcr:primaryType", "nt:unstructured")
           .put("jcr:title", "Hello world")
           .put("propertyName", "Other initial properties")
           .build());

resourceResolver.commit();
```

### Ta bort en [!DNL Sling] resurs

ResourceResolver stöder borttagning av en resurs. När du skapar abstraktioner på högre nivå (AEM sidor, resurser, taggar osv.) använda de metoder som deras respektive chefer tillhandahåller.

```java
resourceResolver.delete(resource);

resourceResolver.commit();
```
