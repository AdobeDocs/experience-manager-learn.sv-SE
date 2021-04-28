---
title: Konfigurera lokal AEM för AEM som en Cloud Service-utveckling
description: Konfigurera den lokala AEM Runtime-miljön med AEM som snabbstartsdarr för en Cloud Service-SDK.
feature: Utvecklarverktyg
topics: development
version: cloud-service
doc-type: tutorial
activity: develop
audience: developer
kt: 4678, 4677
thumbnail: 32551.jpg
topic: Utveckling
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: 9a78cbdb5fd35e4aa7169382494dd014aa8098e9
workflow-type: tm+mt
source-wordcount: '1734'
ht-degree: 1%

---


# Konfigurera lokal AEM

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_aemruntime"
>title="Local AEM Runtime"
>abstract="Adobe Experience Manager (AEM) kan köras lokalt med AEM som en Cloud Service-SDK’s Quickstart Jar. Detta gör att utvecklare kan distribuera till och testa anpassad kod, konfiguration och innehåll innan de implementerar det i källkontrollen och distribuerar det till en AEM som en Cloud Service-miljö."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/aem-as-a-cloud-service-sdk.html" text="SDK för AEM as a Cloud Service"
>additional-url="https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html" text="Hämta AEM som Cloud Service-SDK"

Adobe Experience Manager (AEM) kan köras lokalt med AEM som QuickStart Jar för Cloud Service SDK. Detta gör att utvecklare kan distribuera till och testa anpassad kod, konfiguration och innehåll innan de implementerar det i källkontrollen och distribuerar det till en AEM som en Cloud Service-miljö.

Observera att `~` används som kortskrift för användarens katalog. I Windows motsvarar detta `%HOMEPATH%`.

## Installera Java

Experience Manager är ett Java-program och kräver därför Java SDK för att stödja utvecklingsverktygen.

1. [Hämta och installera den senaste Java SDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
1. Kontrollera att Java 11 SDK är installerat genom att köra kommandot:
   + Windows:`java -version`
   + macOS / Linux: `java --version`

![Java](./assets/aem-runtime/java.png)

## Hämta AEM som en Cloud Service-SDK

AEM som Cloud Service-SDK, eller AEM SDK, innehåller den QuickStart Jar som används för att köra AEM Author och publicera lokalt för utveckling, samt den kompatibla versionen av Dispatcher Tools.

1. Logga in på [https://experience.adobe.com/#/downloads](https://experience.adobe.com/#/downloads) med din Adobe ID
   + Observera att din Adobe-organisation __måste__ etableras för AEM som Cloud Service för att kunna hämta AEM som en Cloud Service-SDK.
1. Navigera till fliken __AEM som en Cloud Service__
1. Sortera efter __Publiceringsdatum__ i __Fallande__ ordning
1. Klicka på den senaste __AEM SDK__-resultatraden
1. Granska och godkänn slutanvändaravtalet och tryck på knappen __Hämta__

## Extrahera Quickstart Jar från AEM SDK-zip

1. Zippa upp den hämtade `aem-sdk-XXX.zip`-filen

## Konfigurera lokal AEM Author-tjänst{#set-up-local-aem-author-service}

Den lokala AEM Author Service ger utvecklare en lokal upplevelse som digitala marknadsförare/innehållsförfattare delar för att skapa och hantera innehåll.  AEM Author Service är utformad både som en redigerings- och förhandsvisningsmiljö, vilket gör att de flesta valideringar av funktionsutveckling kan utföras mot den, vilket gör den till en viktig del av den lokala utvecklingsprocessen.

1. Skapa mappen `~/aem-sdk/author`
1. Kopiera __Quickstart JAR__-filen till `~/aem-sdk/author` och ge den ett nytt namn till `aem-author-p4502.jar`
1. Starta den lokala AEM Author Service genom att köra följande från kommandoraden:
   + `java -jar aem-author-p4502.jar`
      + Ange administratörslösenordet som `admin`. Alla administratörslösenord är godtagbara, men de rekommenderas att använda standardvärdet för lokal utveckling för att minska behovet av att konfigurera om.

   Du *kan inte* starta AEM som Cloud Service Quickstart Jar [genom att dubbelklicka på](#troubleshooting-double-click).
1. Gå till den lokala AEM Author Service på [http://localhost:4502](http://localhost:4502) i en webbläsare

Windows:

```shell
$ mkdir -p c:\Users\<My User>\aem-sdk\author
$ copy aem-sdk-Quickstart-XXX.jar c:\Users\<My User>\aem-sdk\author\aem-author-p4502.jar
$ cd c:\Users\<My User>\aem-sdk\author
$ java -jar aem-author-p4502.jar
```

macOS / Linux:

```shell
$ mkdir -p ~/aem-sdk/author
$ cp aem-sdk-Quickstart-XXX.jar ~/aem-sdk/author/aem-author-p4502.jar
$ cd ~/aem-sdk/author
$ java -jar aem-author-p4502.jar
```

## Konfigurera lokal AEM-publiceringstjänst

Den lokala AEM-publiceringstjänsten ger utvecklare den lokala upplevelse som slutanvändarna av AEM har, till exempel genom att bläddra på den webbplats som är AEM. En lokal AEM Publish Service är viktig eftersom den integreras med AEM SDK:s [Dispatcher tools](./dispatcher-tools.md) och gör att utvecklare kan röka och finjustera slutanvändarupplevelsen.

1. Skapa mappen `~/aem-sdk/publish`
1. Kopiera __Quickstart JAR__-filen till `~/aem-sdk/publish` och ge den ett nytt namn till `aem-publish-p4503.jar`
1. Starta den lokala AEM-publiceringstjänsten genom att köra följande från kommandoraden:
   + `java -jar aem-publish-p4503.jar`
      + Ange administratörslösenordet som `admin`. Alla administratörslösenord är godtagbara, men de rekommenderas att använda standardvärdet för lokal utveckling för att minska behovet av att konfigurera om.

   Du *kan inte* starta AEM som Cloud Service Quickstart Jar [genom att dubbelklicka på](#troubleshooting-double-click).
1. Gå till den lokala AEM-publiceringstjänsten på [http://localhost:4503](http://localhost:4503) i en webbläsare

Windows:

```shell
$ mkdir -p c:\Users\<My User>\aem-sdk\publish
$ copy aem-sdk-Quickstart-XXX.jar c:\Users\<My User>\aem-sdk\publish\aem-publish-p4503.jar
$ cd c:\Users\<My User>\aem-sdk\publish
$ java -jar aem-publish-p4503.jar
```

macOS / Linux:

```shell
$ mkdir -p ~/aem-sdk/publish
$ cp aem-sdk-Quickstart-XXX.jar ~/aem-sdk/publish/aem-publish-p4503.jar
$ cd ~/aem-sdk/publish
$ java -jar aem-publish-p4503.jar
```

## Simulera innehållsdistribution {#content-distribution}

I en riktig Cloud Service distribueras innehåll från Författartjänsten till Publiceringstjänst med [Sling Content Distribution](https://sling.apache.org/documentation/bundles/content-distribution.html) och Adobe Pipeline. [Adobe Pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/core-concepts/architecture.html?lang=en#content-distribution) är en isolerad mikrotjänst som bara är tillgänglig i molnmiljön.

Under utvecklingen kan det vara önskvärt att simulera distributionen av innehåll med hjälp av den lokala redigerings- och publiceringstjänsten. Detta kan uppnås genom att aktivera de äldre replikeringsagenterna.

>[!NOTE]
>
> Replikeringsagenter är bara tillgängliga för användning i den lokala Quickstart JAR och ger bara en simulering av innehållsdistribution.

1. Logga in på tjänsten **Författare** och gå till [http://localhost:4502/etc/replication/agents.author.html](http://localhost:4502/etc/replication/agents.author.html).
1. Klicka på **Standardagent (publicera)** för att öppna standardsatenten för replikering.
1. Klicka på **Redigera** för att öppna agentens konfiguration.
1. Uppdatera följande fält under fliken **Inställningar**:

   + **Aktiverad**  - kontrollera true
   + **Agentanvändar-ID**  - Lämna det här fältet tomt

   ![Konfiguration av replikagent - Inställningar](assets/aem-runtime/settings-config.png)

1. Uppdatera följande fält under fliken **Transport**:

   + **URI** -  `http://localhost:4503/bin/receive?sling:authRequestLogin=1`
   + **Användare** -  `admin`
   + **Lösenord** -  `admin`

   ![Konfiguration av replikagent - transport](assets/aem-runtime/transport-config.png)

1. Klicka på **OK** om du vill spara konfigurationen och aktivera **standardsvarningsagenten** för replikering.
1. Nu kan du ändra innehåll i författartjänsten och publicera det i publiceringstjänsten.

![Publicera sida](assets/aem-runtime/publish-page-changes.png)

## Snabbstarta JAR-startlägen

Namnet på QuickStart Jar, `aem-<tier>_<environment>-p<port number>.jar`, anger hur det kommer att starta. När AEM har startats i ett visst skikt, författare eller publicering kan det inte ändras till det alternativa skiktet. Om du vill göra det måste mappen `crx-Quickstart` som genereras under den första körningen tas bort och QuickStart Jar måste köras igen. Miljö och portar kan ändras, men de kräver stopp/start för den lokala AEM.

Förändrade miljöer, `dev`, `stage` och `prod`, kan vara användbara för utvecklare för att säkerställa att miljöspecifika konfigurationer definieras och löses korrekt av AEM. Vi rekommenderar att lokal utveckling primärt utförs mot standardmiljöns körläge `dev`.

Tillgängliga permutationer är följande:

+ `aem-author-p4502.jar`
   + Som författare i Dev-körningsläge på port 4502
+ `aem-author_dev-p4502.jar`
   + Som författare i Dev-körningsläge på port 4502 (samma som `aem-author-p4502.jar`)
+ `aem-author_stage-p4502.jar`
   + Som författare i mellanlagringskörningsläge på port 4502
+ `aem-author_prod-p4502.jar`
   + Som författare i produktionskörningsläge på port 4502
+ `aem-publish-p4503.jar`
   + Som författare i Dev-körningsläge på port 4503
+ `aem-publish_dev-p4503.jar`
   + Som författare i Dev-körningsläge på port 4503 (samma som `aem-publish-p4503.jar`)
+ `aem-publish_stage-p4503.jar`
   + Som författare i mellanlagringskörningsläge på port 4503
+ `aem-publish_prod-p4503.jar`
   + Som författare i produktionskörningsläge på port 4503

Observera att portnumret kan vara vilken tillgänglig port som helst på den lokala utvecklingsdatorn, men enligt konvention:

+ Port __4502__ används för den lokala AEM Author-tjänsten ____
+ Port __4503__ används för den lokala AEM-publiceringstjänsten ____

Om du ändrar dessa kan du behöva justera AEM SDK-konfigurationer

## Stoppa en lokal AEM

Om du vill stoppa en lokal AEM, antingen AEM Author eller Publish, öppnar du kommandoradsfönstret som användes för att starta AEM Runtime och trycker på `Ctrl-C`. Vänta på att AEM stängs av. Kommandoradsprompten är tillgänglig när avstängningsprocessen är slutförd.

## Inställningsåtgärder för lokal AEM

+ __Konfigurationsmiljövariabler och hemliga__ variabler för OSGi ställs  [in särskilt för den AEM lokala miljön](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#local-development), i stället för att de hanteras med AIR CLI.

## När QuickStart Jar ska uppdateras

Uppdatera AEM SDK minst en gång i månaden, eller kort efter, den sista torsdagen i varje månad, vilket är den sista releaseferensen för AEM som en Cloud Service&quot;funktionsreleaser&quot;.

>[!WARNING]
>
> Om du uppdaterar Quickstart Jar till en ny version måste du ersätta hela den lokala utvecklingsmiljön, vilket resulterar i att all kod, konfiguration och innehåll i de lokala AEM-databaserna går förlorad. Se till att kod, konfiguration eller innehåll som inte ska förstöras implementeras på ett säkert sätt i Git, eller exporteras från den lokala AEM som AEM.

### Så här undviker du innehållsförluster när du uppgraderar AEM SDK

Genom att uppgradera AEM SDK skapas en helt ny AEM, inklusive en ny databas, vilket innebär att ändringar som gjorts i en tidigare AEM SDK-databas går förlorade. Följande är användbara strategier för att hjälpa till med bestående innehåll mellan AEM SDK-uppgraderingar och kan användas diskret eller i kombination:

1. Skapa ett innehållspaket som är avsett för att innehålla exempelinnehåll som ska vara till hjälp vid utvecklingen, och behåll det i Git. Allt innehåll som ska bevaras genom AEM SDK-uppgraderingar kommer att finnas kvar i det här paketet och återdistribueras efter uppgraderingen av AEM SDK.
1. Använd [eko-uppgradering](https://jackrabbit.apache.org/oak/docs/migration.html) med `includepaths`-direktivet för att kopiera innehåll från den tidigare AEM SDK-databasen till den nya AEM SDK-databasen.
1. Säkerhetskopiera allt innehåll med AEM Package Manager och innehållspaket på föregående AEM SDK och installera om dem på nya AEM SDK.

Kom ihåg att om du använder ovanstående metoder för att underhålla kod mellan AEM SDK-uppgraderingar, så visas ett mönster för utveckling. Kod som inte kan användas för engångsbruk ska ha sitt ursprung i din utvecklingsutvecklingsutvecklingsutvecklingsmiljö och flöda in i AEM SDK via distributioner.

## Felsökning

## Om du dubbelklickar på filen Quickstart JAR uppstår ett fel{#troubleshooting-double-click}

När du dubbelklickar på QuickStart Jar för att starta visas ett felmodalt fel som förhindrar att AEM startas lokalt.

![Felsökning - Dubbelklicka på QuickStart JAR-filen](./assets/aem-runtime/troubleshooting__double-click.png)

Detta beror på att AEM som Cloud Service QuickStart Jar inte stöder dubbelklickning av QuickStart Jar för att starta AEM lokalt. Du måste i stället köra JAR-filen från kommandoraden.

Om du vill starta AEM Author-tjänsten `cd` i katalogen som innehåller snabbstartsverktyget och kör kommandot:

`$ java -jar aem-author-p4502.jar`

eller, för att starta AEM Publish-tjänsten, `cd` i katalogen som innehåller QuickStart Jar och köra kommandot:

`$ java -jar aem-author-p4503.jar`

## Starten av Quickstart Jar från kommandoraden avbryts omedelbart{#troubleshooting-java-8}

När du startar Quickstart Jar från kommandoraden avbryts processen omedelbart och AEM startar inte, med följande fel:

```shell
➜  ~/aem-sdk/author: java -jar aem-author-p4502.jar
Loading quickstart properties: default
Loading quickstart properties: instance
java.lang.Exception: Quickstart requires a Java Specification 11 VM, but your VM (Java HotSpot(TM) 64-Bit Server VM / Oracle Corporation) reports java.specification.version=1.8
  at com.adobe.granite.quickstart.base.impl.Main.checkEnvironment(Main.java:1046)
  at com.adobe.granite.quickstart.base.impl.Main.<init>(Main.java:646)
  at com.adobe.granite.quickstart.base.impl.Main.main(Main.java:981)
Quickstart: aborting
```

AEM som Cloud Service kräver Java SDK 11 och du kör en annan version, troligen Java 8. Lös problemet genom att hämta och installera [Oracle Java SDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14).
När Java SDK 11 har installerats kontrollerar du att det är den aktiva versionen genom att köra följande från kommandoraden.

När Java 11 SDK har installerats kontrollerar du att det är den aktiva versionen genom att köra kommandot från kommandoraden:

+ Windows: `java -version`
+ macOS / Linux: `java --version`

## Ytterligare resurser

+ [Hämta AEM SDK](https://experience.adobe.com/#/downloads)
+ [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/)
+ [Ladda ned Docker](https://www.docker.com/)
+ [Experience Manager Dispatcher-dokumentation](https://docs.adobe.com/content/help/en/experience-manager-dispatcher/using/dispatcher.html)
