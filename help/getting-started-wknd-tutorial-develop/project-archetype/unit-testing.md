---
title: Enhetstestning
description: Implementera ett enhetstest som validerar beteendet för den inbyggda komponentens Sling Model, som skapats i självstudiekursen för anpassade komponenter.
version: 6.5, Cloud Service
feature: APIs, AEM Project Archetype
topic: Content Management, Development
role: Developer
level: Beginner
jira: KT-4089
mini-toc-levels: 1
thumbnail: 30207.jpg
doc-type: Tutorial
exl-id: b926c35e-64ad-4507-8b39-4eb97a67edda
recommendations: noDisplay, noCatalog
duration: 870
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '2923'
ht-degree: 0%

---

# Enhetstestning {#unit-testing}

I den här självstudiekursen beskrivs implementeringen av ett enhetstest som validerar beteendet för den inbyggda komponentens Sling Model, som skapats i [Egen komponent](./custom-component.md) självstudie.

## Förutsättningar {#prerequisites}

Granska de verktyg och instruktioner som krävs för att ställa in en [lokal utvecklingsmiljö](overview.md#local-dev-environment).

_Om både Java™ 8 och Java™ 11 är installerade i systemet kan VS Code test runner välja den lägre Java™-miljön när testerna utförs, vilket resulterar i testfel. Om detta inträffar avinstallerar du Java™ 8._

### Startprojekt

>[!NOTE]
>
> Om du har slutfört det föregående kapitlet kan du återanvända projektet och hoppa över stegen för att checka ut startprojektet.

Ta en titt på den baslinjekod som självstudiekursen bygger på:

1. Kolla in `tutorial/unit-testing-start` förgrening från [GitHub](https://github.com/adobe/aem-guides-wknd)

   ```shell
   $ cd aem-guides-wknd
   $ git checkout tutorial/unit-testing-start
   ```

1. Distribuera kodbasen till en lokal AEM med dina Maven-kunskaper:

   ```shell
   $ mvn clean install -PautoInstallSinglePackage
   ```

   >[!NOTE]
   >
   > Om du använder AEM 6.5 eller 6.4 ska du lägga till `classic` för alla Maven-kommandon.

   ```shell
   $ mvn clean install -PautoInstallSinglePackage -Pclassic
   ```

Du kan alltid visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd/tree/tutorial/unit-testing-start) eller checka ut koden lokalt genom att växla till grenen `tutorial/unit-testing-start`.

## Syfte

1. Förstå grunderna för enhetstestning.
1. Lär dig mer om ramverk och verktyg som ofta används för att testa AEM kod.
1. Förstå alternativen för att gungera eller simulera AEM när du skriver enhetstester.

## Bakgrund {#unit-testing-background}

I den här självstudiekursen ska vi utforska hur man skriver [Enhetstester](https://en.wikipedia.org/wiki/Unit_testing) för vår Byline-komponents [Sling Model](https://sling.apache.org/documentation/bundles/models.html) (skapade i [Skapa en anpassad AEM](custom-component.md)). Enhetstester är körtidstester skrivna i Java™ som verifierar förväntade beteenden hos Java™-kod. Varje enhetstest är vanligen litet och validerar resultatet av en metod (eller arbetsenheter) mot förväntade resultat.

Vi använder AEM bästa praxis och använder:

* [JUnit 5](https://junit.org/junit5/)
* [Mockito Testing Framework](https://site.mockito.org/)
* [wcm.io Test Framework](https://wcm.io/testing/) (som bygger på [Apache Sling Mocks](https://sling.apache.org/documentation/development/sling-mock.html))

## Enhetstestning och Adobe Cloud Manager {#unit-testing-and-adobe-cloud-manager}

[Adobe Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/introduction.html) integrerar körning av enhetstest och [rapportering av teckningar](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/code-quality-testing.html) i sin pipeline för CI/CD för att uppmuntra och främja bästa praxis för enhetstestning AEM kod.

Även om kod för enhetstestning är en bra vana för alla kodbaser är det viktigt att kunna dra nytta av dess funktioner för kodkvalitetstestning och rapportering när du använder Cloud Manager genom att tillhandahålla enhetstester som Cloud Manager kan köra.

## Uppdatera testberoenden för Maven {#inspect-the-test-maven-dependencies}

Det första steget är att undersöka Maven-beroenden för att stödja skrivandet och körningen av testerna. Det krävs fyra beroenden:

1. JUnit5
1. Mockito Test Framework
1. Apache Sling Mocks
1. AEM Mocks Test Framework (av io.wcm)

The **JUnit5**, **Mockito och **AEM Mocks** testberoenden läggs automatiskt till i projektet under installationen med [AEM Maven Archetype](project-setup.md).

1. Om du vill visa beroendena öppnar du den överordnade reaktorns POM på **aem-guides-wknd/pom.xml**, navigera till `<dependencies>..</dependencies>` och se beroendena för JUnit, Mockito, Apache Sling Mocks och AEM Mock Tests av io.wcm under `<!-- Testing -->`.
1. Se till att `io.wcm.testing.aem-mock.junit5` är inställd på **4.1.0**:

   ```xml
   <dependency>
       <groupId>io.wcm</groupId>
       <artifactId>io.wcm.testing.aem-mock.junit5</artifactId>
       <version>4.1.0</version>
       <scope>test</scope>
   </dependency>
   ```

   >[!CAUTION]
   >
   > Arketyp **35** skapar projektet med `io.wcm.testing.aem-mock.junit5` version **4.1.8**. Uppgradera till **4.1.0** att följa resten av detta kapitel.

1. Öppna **aem-guides-wknd/core/pom.xml** och se att motsvarande testningsberoenden är tillgängliga.

   En parallell källmapp i **kärna** projektet kommer att innehålla enhetstesterna och eventuella stödtestfiler. Detta **test** -mappen separerar testklasser från källkoden men gör att testerna fungerar som om de finns i samma paket som källkoden.

## Skapa JUnit-testet {#creating-the-junit-test}

Enhetstester kan normalt mappa 1 till 1 med Java™-klasser. I det här kapitlet ska vi skriva ett JUnit-test för **BylineImpl.java**, som är den Sling-modell som stöder Byline-komponenten.

![Enhetstestets src-mapp](assets/unit-testing/core-src-test-folder.png)

*Plats där enhetstester lagras.*

1. Skapa ett enhetstest för `BylineImpl.java` genom att skapa en ny Java™-klass under `src/test/java` i en mappstruktur för Java™-paket som speglar platsen för den Java™-klass som ska testas.

   ![Skapa en ny BylineImplTest.java-fil](assets/unit-testing/new-bylineimpltest.png)

   Eftersom vi testar

   * `src/main/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImpl.java`

   skapa motsvarande enhetstest Java™-klass på

   * `src/test/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImplTest.java`

   The `Test` suffix i enhetstestfilen, `BylineImplTest.java` är en konvention som gör att vi kan

   1. Identifiera det enkelt som testfil _for_ `BylineImpl.java`
   1. Men även differentiera testfilen _från_ den klass som testas, `BylineImpl.java`

## Granska BylineImplTest.java {#reviewing-bylineimpltest-java}

Nu är JUnit-testfilen en tom Java™-klass.

1. Uppdatera filen med följande kod:

   ```java
   package com.adobe.aem.guides.wknd.core.models.impl;
   
   import static org.junit.jupiter.api.Assertions.*;
   
   import org.junit.jupiter.api.BeforeEach;
   import org.junit.jupiter.api.Test;
   
   public class BylineImplTest {
   
       @BeforeEach
       void setUp() throws Exception {
   
       }
   
       @Test 
       void testGetName() { 
           fail("Not yet implemented");
       }
   
       @Test 
       void testGetOccupations() { 
           fail("Not yet implemented");
       }
   
       @Test 
       void testIsEmpty() { 
           fail("Not yet implemented");
       }
   }
   ```

1. Den första metoden `public void setUp() { .. }` är kommenterad med JUnit `@BeforeEach`, som instruerar JUnit-testköraren att köra den här metoden innan varje testmetod körs i den här klassen. Detta är en praktisk plats där du kan initiera vanliga testtillstånd som krävs för alla tester.

1. De följande metoderna är testmetoderna, vars namn är prefix `test` efter konvention och markerad med `@Test` anteckning. Observera att som standard kommer alla våra tester att misslyckas eftersom vi ännu inte har implementerat dem.

   Till att börja med har vi en enda testmetod för varje offentlig metod för den klass vi testar, så här:

   | BylineImpl.java |              | BylineImplTest.java |
   | ------------------|--------------|---------------------|
   | getName() | testas av | testGetName() |
   | getOccupations() | testas av | testGetOccupations() |
   | isEmpty() | testas av | testIsEmpty() |

   Dessa metoder kan vid behov färdigställas, vilket vi kommer att se senare i det här kapitlet.

   När denna JUnit-testklass (kallas även JUnit-testfall) körs markeras varje metod med `@Test` kommer att köras som ett test som antingen kan godkännas eller misslyckas.

![genererad BylineImplTest](assets/unit-testing/bylineimpltest-stub-methods.png)

*`core/src/test/java/com/adobe/aem/guides/wknd/core/models/impl/BylineImplTest.java`*

1. Kör JUnit Test Case genom att högerklicka på `BylineImplTest.java` och knackning **Kör**.
Som förväntat misslyckas alla tester eftersom de ännu inte har implementerats.

   ![Kör som skräpposttest](assets/unit-testing/run-junit-tests.png)

   *Högerklicka på BylineImplTests.java > Kör*

## Granska BylineImpl.java {#reviewing-bylineimpl-java}

När enhetstester skrivs finns det två primära metoder:

* [TDD eller testdriven utveckling](https://en.wikipedia.org/wiki/Test-driven_development), vilket innebär att enhetstesterna skrivs stegvis, omedelbart innan implementeringen utvecklas. Skriv ett test, skriv implementeringen för att göra testet godkänt.
* Utveckling av implementering först, vilket innebär att först utveckla arbetskoden och sedan skriva tester som validerar den koden.

I den här självstudiekursen används den senare metoden (eftersom vi redan har skapat en fungerande **BylineImpl.java** i ett tidigare kapitel). På grund av detta måste vi granska och förstå hur dess publika metoder fungerar, men också en del av dess implementeringsdetaljer. Detta kan låta tvärtom, eftersom ett bra test endast bör omfatta in- och utdata, men när AEM utförs måste olika implementeringsöverväganden göras för att man ska kunna konstruera arbetstester.

TDD krävs inom ramen för AEM och är bäst lämpat för AEM utvecklare som är skickliga på AEM utveckling och enhetstestning av AEM kod.

## Konfigurera AEM testkontext  {#setting-up-aem-test-context}

De flesta koder som skrivits för AEM är beroende av JCR-, Sling- eller AEM-API:er, som i sin tur kräver att en AEM körs på rätt sätt.

Eftersom enhetstester utförs vid bygget, utanför en pågående AEM, finns det ingen sådan kontext. För att underlätta detta [wcm.ios AEM Mocks](https://wcm.io/testing/aem-mock/usage.html) skapar en modellkontext som tillåter dessa API:er att _mest_ fungerar som om de springer i AEM.

1. Skapa en AEM kontext med **wcm.io&#39;s** `AemContext` in **BylineImplTest.java** genom att lägga till det som ett JUnit-tillägg som dekoreras med `@ExtendWith` till **BylineImplTest.java** -fil. Tillägget hanterar alla initierings- och rensningsåtgärder som krävs. Skapa en klassvariabel för `AemContext` som kan användas för alla testmetoder.

   ```java
   import org.junit.jupiter.api.extension.ExtendWith;
   import io.wcm.testing.mock.aem.junit5.AemContext;
   import io.wcm.testing.mock.aem.junit5.AemContextExtension;
   ...
   
   @ExtendWith(AemContextExtension.class)
   class BylineImplTest {
   
       private final AemContext ctx = new AemContext();
   ```

   Denna variabel, `ctx`, visar en AEM som innehåller vissa AEM- och Sling-abstraktioner:

   * BylineImpl Sling Model är registrerad i den här kontexten
   * Mock JCR-innehållsstrukturer skapas i det här sammanhanget
   * Anpassade OSGi-tjänster kan registreras i den här kontexten
   * Innehåller olika vanliga nödvändiga modellobjekt och hjälpmedel, till exempel SlingHttpServletRequest-objekt, olika tjänster för modelldelning och AEM OSGi, till exempel ModelFactory, PageManager, Page, Template, ComponentManager, Component, TagManager, Tag, etc.
      * *Alla metoder för de här objekten är inte implementerade!*
   * Och [mycket mer](https://wcm.io/testing/aem-mock/usage.html)!

   The **`ctx`** -objektet fungerar som ingångspunkt för större delen av vår modellkontext.

1. I `setUp(..)` som körs före varje `@Test` -metod, definiera ett vanligt modelltestläge:

   ```java
   @BeforeEach
   public void setUp() throws Exception {
       ctx.addModelsForClasses(BylineImpl.class);
       ctx.load().json("/com/adobe/aem/guides/wknd/core/models/impl/BylineImplTest.json", "/content");
   }
   ```

   * **`addModelsForClasses`** registrerar den Sling-modell som ska testas i AEM-kontexten, så att den kan instansieras i `@Test` metoder.
   * **`load().json`** läser in resursstrukturer i standardkontexten, vilket gör att koden kan interagera med dessa resurser som om de vore från en verklig databas. Resursdefinitionerna i filen **`BylineImplTest.json`** läses in i JCR-kontexten för dummy under **/content**.
   * **`BylineImplTest.json`** finns inte än, så vi skapar den och definierar de JCR-resursstrukturer som behövs för testet.

1. JSON-filerna som representerar modellresursstrukturerna lagras under **core/src/test/resources** följer samma paketsökväg som JUnit Java™-testfilen.

   Skapa en JSON-fil på `core/test/resources/com/adobe/aem/guides/wknd/core/models/impl` namngiven **BylineImplTest.json** med följande:

   ```json
   {
       "byline": {
       "jcr:primaryType": "nt:unstructured",
       "sling:resourceType": "wknd/components/content/byline"
       }
   }
   ```

   ![BylineImplTest.json](assets/unit-testing/bylineimpltest-json.png)

   Denna JSON definierar en modellresurs (JCR-nod) för Byline-komponentenhetstestet. I det här skedet har JSON den minsta uppsättning egenskaper som krävs för att representera en innehållsresurs för en instickskomponent, dvs. `jcr:primaryType` och `sling:resourceType`.

   En allmän regel när du arbetar med enhetstester är att skapa den minimala uppsättningen av modellinnehåll, kontext och kod som krävs för att uppfylla varje test. Undvik frestelsen att bygga ut en komplett modellkontext innan du skriver testerna, eftersom det ofta leder till onödiga artefakter.

   Nu när det finns **BylineImplTest.json**, när `ctx.json("/com/adobe/aem/guides/wknd/core/models/impl/BylineImplTest.json", "/content")` körs, standardresursdefinitionerna läses in i kontexten vid sökvägen **/content.**

## Testar getName() {#testing-get-name}

Nu när vi har en grundläggande konfiguration av modellkontext kan vi skriva vårt första test för **BylineImpl&#39;s getName()**. Detta test måste säkerställa metoden **getName()** returnerar det korrekt skrivna namnet som lagras på resursens **name&quot;** -egenskap.

1. Uppdatera **testGetName**() i **BylineImplTest.java** enligt följande:

   ```java
   import com.adobe.aem.guides.wknd.core.models.Byline;
   ...
   @Test
   public void testGetName() {
       final String expected = "Jane Doe";
   
       ctx.currentResource("/content/byline");
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       String actual = byline.getName();
   
       assertEquals(expected, actual);
   }
   ```

   * **`String expected`** anger det förväntade värdet. Vi ställer in det här på&#x200B;**Jane Done**&quot;.
   * **`ctx.currentResource`** ställer in kontexten för den modellresurs som koden ska utvärderas mot, så detta ställs in på **/content/byline** eftersom det är där som modellens baslinjeinnehållsresurs läses in.
   * **`Byline byline`** instansierar Byline Sling-modellen genom att anpassa den från Mock Request-objektet.
   * **`String actual`** anropar den metod vi testar, `getName()`i objektet Byline Sling Model.
   * **`assertEquals`** kontrollerar att det förväntade värdet matchar det värde som returneras av byline Sling Model-objektet. Om dessa värden inte är lika misslyckas testet.

1. Kör testet.. och det misslyckas med en `NullPointerException`.

   Det här testet misslyckas INTE eftersom vi aldrig har definierat en `name` egenskapen i JSON-dummyn, som gör att testet misslyckas, men testkörningen har inte kommit till den punkten! Testet misslyckas på grund av en `NullPointerException` på själva benypobjektet.

1. I `BylineImpl.java`, if `@PostConstruct init()` genererar ett undantag som förhindrar att Sling Model instansieras och gör att Sling Model-objektet blir null.

   ```java
   @PostConstruct
   private void init() {
       image = modelFactory.getModelFromWrappedRequest(request, request.getResource(), Image.class);
   }
   ```

   Det visar sig att även om tjänsten ModelFactory OSGi tillhandahålls via `AemContext` (med hjälp av Apache Sling Context) är det inte alla metoder som implementeras, inklusive `getModelFromWrappedRequest(...)` som anropas i BylineImpl:er `init()` -metod. Detta resulterar i en [AbstractMethodError](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/AbstractMethodError.html), vilket i sin tur orsakar `init()` att misslyckas, och den resulterande anpassningen av `ctx.request().adaptTo(Byline.class)` är ett null-objekt.

   Eftersom de mocks som tillhandahålls inte kan rymma vår kod måste vi implementera modellsammanhanget själva. För detta kan vi använda Mockito för att skapa ett ModelFactory-modellobjekt som returnerar ett modellbildobjekt när `getModelFromWrappedRequest(...)` är en satsning på den.

   Eftersom den här modelltypen måste finnas på plats för att instansiera Byline Sling-modellen kan vi lägga till den i `@Before setUp()` -metod. Vi måste också lägga till `MockitoExtension.class` till `@ExtendWith` anteckningen ovanför **BylineImplTest** klassen.

   ```java
   package com.adobe.aem.guides.wknd.core.models.impl;
   
   import org.mockito.junit.jupiter.MockitoExtension;
   import org.mockito.Mock;
   
   import com.adobe.aem.guides.wknd.core.models.Byline;
   import com.adobe.cq.wcm.core.components.models.Image;
   
   import io.wcm.testing.mock.aem.junit5.AemContext;
   import io.wcm.testing.mock.aem.junit5.AemContextExtension;
   
   import org.apache.sling.models.factory.ModelFactory;
   import org.junit.jupiter.api.BeforeEach;
   import org.junit.jupiter.api.Test;
   import org.junit.jupiter.api.extension.ExtendWith;
   
   import static org.junit.jupiter.api.Assertions.*;
   import static org.mockito.Mockito.*;
   import org.apache.sling.api.resource.Resource;
   
   @ExtendWith({ AemContextExtension.class, MockitoExtension.class })
   public class BylineImplTest {
   
       private final AemContext ctx = new AemContext();
   
       @Mock
       private Image image;
   
       @Mock
       private ModelFactory modelFactory;
   
       @BeforeEach
       public void setUp() throws Exception {
           ctx.addModelsForClasses(BylineImpl.class);
   
           ctx.load().json("/com/adobe/aem/guides/wknd/core/models/impl/BylineImplTest.json", "/content");
   
           lenient().when(modelFactory.getModelFromWrappedRequest(eq(ctx.request()), any(Resource.class), eq(Image.class)))
                   .thenReturn(image);
   
           ctx.registerService(ModelFactory.class, modelFactory, org.osgi.framework.Constants.SERVICE_RANKING,
                   Integer.MAX_VALUE);
       }
   
       @Test
       void testGetName() { ...
   }
   ```

   * **`@ExtendWith({AemContextExtension.class, MockitoExtension.class})`** markerar klassen Test Case som ska köras med [Mockito JUnit Jupiter Extension](https://www.javadoc.io/static/org.mockito/mockito-junit-jupiter/4.11.0/org/mockito/junit/jupiter/MockitoExtension.html) som gör det möjligt att använda @Mock-anteckningar för att definiera modellobjekt på klassnivå.
   * **`@Mock private Image`** skapar ett modellobjekt av typen `com.adobe.cq.wcm.core.components.models.Image`. Detta definieras på klassnivå så att, efter behov, `@Test` -metoder kan ändra deras beteende efter behov.
   * **`@Mock private ModelFactory`** skapar ett modellobjekt av typen ModelFactory. Det här är en helt sann Mockito-mock och har inga metoder implementerade på den. Detta definieras på klassnivå så att, efter behov, `@Test`-metoder kan ändra deras beteende efter behov.
   * **`when(modelFactory.getModelFromWrappedRequest(..)`** registrerar dummybeteenden för när `getModelFromWrappedRequest(..)` anropas i modellmodellobjektet ModelFactory. Resultatet som definierats i `thenReturn (..)` är att returnera modellbildobjektet. Det här beteendet anropas bara när: den första parametern är lika med `ctx`&#39;s request object, the second param is any Resource object, and the third param must be the Core Components Image class. Vi accepterar alla resurser eftersom vi under testerna ställer in `ctx.currentResource(...)` till olika modellresurser som definieras i **BylineImplTest.json**. Vi lägger till **leenient()** Styrka eftersom vi senare vill åsidosätta det här beteendet för ModelFactory.
   * **`ctx.registerService(..)`.** registrerar Mock ModelFactory-objektet i AemContext, med den högsta rangordningen. Detta är obligatoriskt eftersom ModelFactory används i BylineImpl:er `init()` injiceras via `@OSGiService ModelFactory model` fält. För AemContext att injicera **vår** mock-objekt, som hanterar anrop till `getModelFromWrappedRequest(..)`måste vi registrera den som den högsta rangordningstjänsten av den typen (ModelFactory).

1. Kör testet igen och det misslyckas igen, men den här gången är det tydligt att meddelandet misslyckades.

   ![test name failed assertion](assets/unit-testing/testgetname-failure-assertion.png)

   *testGetName() misslyckades på grund av kontroll*

   Vi får en **AssertionError** vilket betyder att assert-villkoret i testet misslyckades, och det talar om för oss att **förväntat värde är &quot;Jane Doe&quot;** men **verkligt värde är null**. Det här är vettigt eftersom **name&quot;** egenskapen har inte lagts till i mock **/content/byline** resursdefinition i **BylineImplTest.json** så vi lägger till den:

1. Uppdatera **BylineImplTest.json** att definiera `"name": "Jane Doe".`

   ```json
   {
       "byline": {
       "jcr:primaryType": "nt:unstructured",
       "sling:resourceType": "wknd/components/content/byline",
       "name": "Jane Doe"
       }
   }
   ```

1. Kör testet igen, och **`testGetName()`** går nu!

   ![test name pass](assets/unit-testing/testgetname-pass.png)


## Testar getOccupations() {#testing-get-occupations}

Okej bra! Det första testet har klarat! Låt oss gå vidare och testa `getOccupations()`. Sedan modellkontexten initierades i `@Before setUp()`-metod, är den tillgänglig för alla `@Test` metoder i detta testfall, inklusive `getOccupations()`.

Kom ihåg att den här metoden måste returnera en alfabetiskt sorterad lista med befattningar (fallande) som lagras i egenskapen ockupationer.

1. Uppdatera **`testGetOccupations()`** enligt följande:

   ```java
   import java.util.List;
   import com.google.common.collect.ImmutableList;
   ...
   @Test
   public void testGetOccupations() {
       List<String> expected = new ImmutableList.Builder<String>()
                               .add("Blogger")
                               .add("Photographer")
                               .add("YouTuber")
                               .build();
   
       ctx.currentResource("/content/byline");
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       List<String> actual = byline.getOccupations();
   
       assertEquals(expected, actual);
   }
   ```

   * **`List<String> expected`** definiera det förväntade resultatet.
   * **`ctx.currentResource`** ställer in den aktuella resursen så att kontexten utvärderas mot standardresursdefinitionen på /content/byline. Detta säkerställer att **BylineImpl.java** körs i kontexten för vår standardresurs.
   * **`ctx.request().adaptTo(Byline.class)`** instansierar Byline Sling-modellen genom att anpassa den från Mock Request-objektet.
   * **`byline.getOccupations()`** anropar den metod vi testar, `getOccupations()`i objektet Byline Sling Model.
   * **`assertEquals(expected, actual)`** Kontrollerar att den förväntade listan är densamma som den faktiska listan.

1. Kom ihåg, precis som **`getName()`** ovan, **BylineImplTest.json** definierar inte yrken, så det här testet misslyckas om vi kör det, eftersom `byline.getOccupations()` returnerar en tom lista.

   Uppdatera **BylineImplTest.json** för att inkludera en lista över yrken, och de är inställda i icke-alfabetisk ordning för att säkerställa att våra tester validerar att yrkesutövarnas positioner sorteras i alfabetisk ordning efter **`getOccupations()`**.

   ```json
   {
       "byline": {
       "jcr:primaryType": "nt:unstructured",
       "sling:resourceType": "wknd/components/content/byline",
       "name": "Jane Doe",
       "occupations": ["Photographer", "Blogger", "YouTuber"]
       }
   }
   ```

1. Kör testet, och återigen godkänns vi! Det ser ut som att få de sorterade arbetsuppgifterna att fungera!

   ![Få yrkesdiplom](assets/unit-testing/testgetoccupations-pass.png)

   *testGetOccupations() passerar*

## Testing isEmpty() {#testing-is-empty}

Den sista metoden att testa **`isEmpty()`**.

Testning `isEmpty()` är intressant eftersom den kräver testning för olika villkor. Granskning **BylineImpl.java**&#39;s `isEmpty()` Metod som uppfyller följande villkor skall provas:

* Returnera true när namnet är tomt
* Returnera true när yrken är null eller tomma
* Returnera true när bilden är null eller saknar src-URL
* Returnera falskt när namnet, befattningarna och bilden (med en src-URL) finns

Därför måste vi skapa testmetoder, där varje testning av ett specifikt villkor och nya modellresursstrukturer i `BylineImplTest.json` för att köra dessa tester.

Den här kontrollen gjorde att vi kunde hoppa över testning när `getName()`, `getOccupations()` och `getImage()` är tomma eftersom det förväntade beteendet för det läget testas via `isEmpty()`.

1. Det första testet testar villkoret för en helt ny komponent som inte har några egenskaper angivna.

   Lägg till en ny resursdefinition i `BylineImplTest.json`, vilket ger det semantiska namnet &quot;**tom**&quot;

   ```json
   {
       "byline": {
           "jcr:primaryType": "nt:unstructured",
           "sling:resourceType": "wknd/components/content/byline",
           "name": "Jane Doe",
           "occupations": ["Photographer", "Blogger", "YouTuber"]
       },
       "empty": {
           "jcr:primaryType": "nt:unstructured",
           "sling:resourceType": "wknd/components/content/byline"
       }
   }
   ```

   **`"empty": {...}`** definiera en ny resursdefinition med namnet&quot;empty&quot; som bara har en `jcr:primaryType` och `sling:resourceType`.

   Kom ihåg att vi laddar `BylineImplTest.json` till `ctx` innan varje testmetod körs i `@setUp`, så den nya resursdefinitionen är omedelbart tillgänglig för oss i tester på **/content/empty.**

1. Uppdatera `testIsEmpty()` så här anger du den aktuella resursen till den nya **tom**&quot; dummy-resursdefinition.

   ```java
   @Test
   public void testIsEmpty() {
       ctx.currentResource("/content/empty");
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertTrue(byline.isEmpty());
   }
   ```

   Kör testet och se till att det lyckas.

1. Skapa sedan en uppsättning metoder för att se till att eventuella obligatoriska datapunkter (namn, befattningar eller bild) är tomma, `isEmpty()` returnerar true.

   För varje test används en diskret modellresursdefinition, uppdatera **BylineImplTest.json** med ytterligare resursdefinitioner för **without-name** och **utan yrke**.

   ```json
   {
       "byline": {
           "jcr:primaryType": "nt:unstructured",
           "sling:resourceType": "wknd/components/content/byline",
           "name": "Jane Doe",
           "occupations": ["Photographer", "Blogger", "YouTuber"]
       },
       "empty": {
           "jcr:primaryType": "nt:unstructured",
           "sling:resourceType": "wknd/components/content/byline"
       },
       "without-name": {
           "jcr:primaryType": "nt:unstructured",
           "sling:resourceType": "wknd/components/content/byline",
           "occupations": "[Photographer, Blogger, YouTuber]"
       },
       "without-occupations": {
           "jcr:primaryType": "nt:unstructured",
           "sling:resourceType": "wknd/components/content/byline",
           "name": "Jane Doe"
       }
   }
   ```

   Skapa följande testmetoder för att testa alla dessa lägen.

   ```java
   @Test
   public void testIsEmpty() {
       ctx.currentResource("/content/empty");
   
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertTrue(byline.isEmpty());
   }
   
   @Test
   public void testIsEmpty_WithoutName() {
       ctx.currentResource("/content/without-name");
   
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertTrue(byline.isEmpty());
   }
   
   @Test
   public void testIsEmpty_WithoutOccupations() {
       ctx.currentResource("/content/without-occupations");
   
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertTrue(byline.isEmpty());
   }
   
   @Test
   public void testIsEmpty_WithoutImage() {
       ctx.currentResource("/content/byline");
   
       lenient().when(modelFactory.getModelFromWrappedRequest(eq(ctx.request()),
           any(Resource.class),
           eq(Image.class))).thenReturn(null);
   
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertTrue(byline.isEmpty());
   }
   
   @Test
   public void testIsEmpty_WithoutImageSrc() {
       ctx.currentResource("/content/byline");
   
       when(image.getSrc()).thenReturn("");
   
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertTrue(byline.isEmpty());
   }
   ```

   **`testIsEmpty()`** testar mot den tomma modellresursdefinitionen och bekräftar att `isEmpty()` är sant.

   **`testIsEmpty_WithoutName()`** testar mot en modellresursdefinition som har befattningar men inget namn.

   **`testIsEmpty_WithoutOccupations()`** testar mot en modellresursdefinition som har ett namn men inga arbeten.

   **`testIsEmpty_WithoutImage()`** testar mot en modellresursdefinition med ett namn och en funktion, men ställer in att standardbilden ska returneras till null. Vi vill åsidosätta `modelFactory.getModelFromWrappedRequest(..)`beteende definierat i `setUp()` för att se till att det bildobjekt som returneras av anropet är null. Mockito-stubs-funktionen är strikt och vill inte ha duplicerad kod. Därför sätter vi gåtan med **`lenient`** inställningar för att uttryckligen notera att vi åsidosätter beteendet i `setUp()` -metod.

   **`testIsEmpty_WithoutImageSrc()`** testar mot en modellresursdefinition med ett namn och en funktion, men ställer in att modellbilden ska returnera en tom sträng när `getSrc()` anropas.

1. Slutligen bör man göra ett test för att säkerställa att **isEmpty()** returnerar false när komponenten är korrekt konfigurerad. För det här villkoret kan vi återanvända **/content/byline** som representerar en fullt konfigurerad Byline-komponent.

   ```java
   @Test
   public void testIsNotEmpty() {
       ctx.currentResource("/content/byline");
       when(image.getSrc()).thenReturn("/content/bio.png");
   
       Byline byline = ctx.request().adaptTo(Byline.class);
   
       assertFalse(byline.isEmpty());
   }
   ```

1. Kör nu alla enhetstester i filen BylineImplTest.java och granska Java™ Test Report.

![Alla tester har godkänts](./assets/unit-testing/all-tests-pass.png)

## Kör enhetstester som en del av bygget {#running-unit-tests-as-part-of-the-build}

Enhetstester utförs och krävs för att passera som en del av maven-byggnaden. Detta garanterar att alla tester lyckas innan ett program distribueras. För att köra Maven-mål som paketering eller installation anropas automatiskt och alla enhetstester i projektet måste godkännas.

```shell
$ mvn package
```

![mvn-paketet lyckades](assets/unit-testing/mvn-package-success.png)

```shell
$ mvn package
```

Om vi ändrar en testmetod till att misslyckas, misslyckas också bygget och rapporterar att testet misslyckades och varför.

![mvn-paketet misslyckades](assets/unit-testing/mvn-package-fail.png)

## Granska koden {#review-the-code}

Visa den färdiga koden på [GitHub](https://github.com/adobe/aem-guides-wknd) eller granska och distribuera koden lokalt på Git-grenen `tutorial/unit-testing-solution`.
