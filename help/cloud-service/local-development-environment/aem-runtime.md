---
title: Konfigurera lokal AEM SDK för AEM as a Cloud Service Development
description: Konfigurera den lokala AEM SDK-miljön med hjälp av den AEM as a Cloud Service SDK:ns QuickStart Jar.
feature: Developer Tools
version: Cloud Service
kt: 4678, 4677
thumbnail: 32551.jpg
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2022-09-02T00:00:00Z
exl-id: 19f72254-2087-450b-909d-2d90c9821486
duration: 411
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1696'
ht-degree: 0%

---

# Konfigurera lokal AEM SDK {#set-up-local-aem-sdk}

>[!CONTEXTUALHELP]
>id="aemcloud_localdev_aemruntime"
>title="Local AEM Runtime"
>abstract="Adobe Experience Manager (AEM) kan köras lokalt med den AEM as a Cloud Service SDK:ns QuickStart Jar. Detta gör att utvecklare kan distribuera till och testa anpassad kod, konfiguration och innehåll innan de implementerar det i källkontrollen och distribuerar det i en AEM as a Cloud Service miljö."
>additional-url="https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/aem-as-a-cloud-service-sdk.html" text="AEM as a Cloud Service SDK"
>additional-url="https://experience.adobe.com/#/downloads/content/software-distribution/en/aemcloud.html" text="Hämta AEM as a Cloud Service SDK"

Adobe Experience Manager (AEM) kan köras lokalt med den AEM as a Cloud Service SDK:ns QuickStart Jar. Detta gör att utvecklare kan distribuera till och testa anpassad kod, konfiguration och innehåll innan de implementerar det i källkontrollen och distribuerar det i en AEM as a Cloud Service miljö.

Observera att `~` används som kortskrift för användarkatalogen. I Windows motsvarar detta `%HOMEPATH%`.

## Installera Java™

Experience Manager är en Java™-applikation och därför krävs Oraclet Java™ SDK för utvecklingsverktygen.

1. [Hämta och installera den senaste Java™ SDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14)
1. Kontrollera att Oraclet Java™ 11 SDK är installerat genom att köra kommandot:

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ java --version
```

>[!TAB Windows]

```shell
$ java -version
```

>[!TAB Linux®]

```shell
$ java --version
```

>[!ENDTABS]

![Java](./assets/aem-runtime/java.png)

## Hämta AEM as a Cloud Service SDK

Den AEM as a Cloud Service SDK, eller AEM SDK, innehåller den QuickStart Jar som används för att köra AEM författare och publicera lokalt för utveckling, samt den kompatibla versionen av Dispatcher Tools.

1. Logga in på [https://experience.adobe.com/#/downloads](https://experience.adobe.com/#/downloads) med din Adobe ID
   + Observera att din Adobe-organisation __måste__ etableras för AEM as a Cloud Service att hämta AEM as a Cloud Service SDK.
1. Navigera till __AEM as a Cloud Service__ tab
1. Sortera efter __Publiceringsdatum__ in __Fallande__ beställa
1. Klicka på den senaste __AEM SDK__ resultatrad
1. Granska och godkänn slutanvändaravtalet och tryck på __Ladda ned__ knapp

## Extrahera Quickstart Jar från AEM SDK-zip

1. Zippa upp det nedladdade `aem-sdk-XXX.zip` fil

## Konfigurera lokal AEM Author Service{#set-up-local-aem-author-service}

Den lokala AEM författartjänsten ger utvecklare en lokal upplevelse som digitala marknadsförare/innehållsförfattare delar för att skapa och hantera innehåll.  AEM Author Service är utformad både som en redigerings- och förhandsvisningsmiljö, vilket gör att de flesta valideringar av funktionsutveckling kan utföras mot den, vilket gör den till en viktig del i den lokala utvecklingsprocessen.

1. Skapa mappen `~/aem-sdk/author`
1. Kopiera __Quickstart JAR__ fil till  `~/aem-sdk/author` och ändra namnet till `aem-author-p4502.jar`
1. Starta den lokala AEM Author Service genom att köra följande från kommandoraden:
   + `java -jar aem-author-p4502.jar`
      + Ange administratörslösenordet som `admin`. Alla administratörslösenord är tillåtna, men du bör använda standardvärdet för lokal utveckling för att minska behovet av att konfigurera om.

   Du *inte* starta AEM som Cloud Service QuickStart Jar [genom att dubbelklicka](#troubleshooting-double-click).
1. Gå till den lokala AEM författartjänsten på [http://localhost:4502](http://localhost:4502) i en webbläsare

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ mkdir -p ~/aem-sdk/author
$ cp aem-sdk-Quickstart-XXX.jar ~/aem-sdk/author/aem-author-p4502.jar
$ cd ~/aem-sdk/author
$ java -jar aem-author-p4502.jar
```

>[!TAB Windows]

```shell
$ mkdir -p c:\Users\<My User>\aem-sdk\author
$ copy aem-sdk-Quickstart-XXX.jar c:\Users\<My User>\aem-sdk\author\aem-author-p4502.jar
$ cd c:\Users\<My User>\aem-sdk\author
$ java -jar aem-author-p4502.jar
```

>[!TAB Linux®]

```shell
$ mkdir -p ~/aem-sdk/author
$ cp aem-sdk-Quickstart-XXX.jar ~/aem-sdk/author/aem-author-p4502.jar
$ cd ~/aem-sdk/author
$ java -jar aem-author-p4502.jar
```

>[!ENDTABS]


## Konfigurera lokal AEM Publiceringstjänst

Den lokala AEM-publiceringstjänsten ger utvecklare den lokala upplevelse som slutanvändarna av AEM har, till exempel den webbplats som är AEM. En lokal AEM är viktig eftersom den kan integreras med AEM SDK:er [Dispatcher-verktyg](./dispatcher-tools.md) och gör det möjligt för utvecklare att röka och finjustera slutanvändarupplevelsen.

1. Skapa mappen `~/aem-sdk/publish`
1. Kopiera __Quickstart JAR__ fil till  `~/aem-sdk/publish` och ändra namnet till `aem-publish-p4503.jar`
1. Starta den lokala AEM-publiceringstjänsten genom att köra följande från kommandoraden:
   + `java -jar aem-publish-p4503.jar`
      + Ange administratörslösenordet som `admin`. Alla administratörslösenord är tillåtna, men du bör använda standardvärdet för lokal utveckling för att minska behovet av att konfigurera om.

   Du *inte* starta AEM som Cloud Service QuickStart Jar [genom att dubbelklicka](#troubleshooting-double-click).
1. Åtkomst till den lokala AEM-publiceringstjänsten på [http://localhost:4503](http://localhost:4503) i en webbläsare

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ mkdir -p ~/aem-sdk/publish
$ cp aem-sdk-Quickstart-XXX.jar ~/aem-sdk/publish/aem-publish-p4503.jar
$ cd ~/aem-sdk/publish
$ java -jar aem-publish-p4503.jar
```

>[!TAB Windows]

```shell
$ mkdir -p c:\Users\<My User>\aem-sdk\publish
$ copy aem-sdk-Quickstart-XXX.jar c:\Users\<My User>\aem-sdk\publish\aem-publish-p4503.jar
$ cd c:\Users\<My User>\aem-sdk\publish
$ java -jar aem-publish-p4503.jar
```

>[!TAB Linux®]

```shell
$ mkdir -p ~/aem-sdk/publish
$ cp aem-sdk-Quickstart-XXX.jar ~/aem-sdk/publish/aem-publish-p4503.jar
$ cd ~/aem-sdk/publish
$ java -jar aem-publish-p4503.jar
```

>[!ENDTABS]


## Konfigurera lokala AEM i förhandsversionsläge

Den lokala AEM kan startas i [prerelease-läge](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/release-notes/prerelease.html) som gör det möjligt för en utvecklare att bygga vidare på den AEM as a Cloud Service nästa releases funktioner. Förhandsversionen aktiveras genom att användaren skickar `-r prerelease` argument på den lokala AEM körtidens första start. Detta kan användas med både AEM och AEM publiceringstjänster.


>[!BEGINTABS]

>[!TAB macOS]

```shell
# For AEM Author service in prerelease mode
$ java -jar aem-author-p4502.jar -r prerelease

# For AEM Publish service in prerelease mode
$ java -jar aem-publish-p4503.jar -r prerelease
```

>[!TAB Windows]

```shell
# For AEM Author service in prerelease mode
$ java -jar aem-author-p4502.jar -r prerelease

# For AEM Publish service in prerelease mode
$ java -jar aem-publish-p4503.jar -r prerelease
```

>[!TAB Linux®]

```shell
# For AEM Author service in prerelease mode
$ java -jar aem-author-p4502.jar -r prerelease

# For AEM Publish service in prerelease mode
$ java -jar aem-publish-p4503.jar -r prerelease
```

>[!ENDTABS]

## Simulera innehållsdistribution {#content-distribution}

I en riktig Cloud Service distribueras innehåll från författartjänsten till publiceringstjänsten med [Distribution av säljinnehåll](https://sling.apache.org/documentation/bundles/content-distribution.html) och Adobe Pipeline. The [Adobe Pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/core-concepts/architecture.html?lang=en#content-distribution) är en isolerad mikrotjänst som bara är tillgänglig i molnmiljön.

Under utvecklingen kan det vara önskvärt att simulera distributionen av innehåll med hjälp av den lokala redigerings- och publiceringstjänsten. Detta kan uppnås genom att aktivera de äldre replikeringsagenterna.

>[!NOTE]
>
> Replikeringsagenter är bara tillgängliga för användning i den lokala Quickstart JAR och ger bara en simulering av innehållsdistribution.

1. Logga in på **Upphovsman** och navigera till [http://localhost:4502/etc/replication/agents.author.html](http://localhost:4502/etc/replication/agents.author.html).
1. Klicka **Standardagent (publicera)** om du vill öppna standardreplikeringsagenten.
1. Klicka **Redigera** för att öppna agentens konfiguration.
1. Under **Inställningar** uppdaterar du följande fält:

   + **Aktiverad** - kontrollera sant
   + **Användar-ID för agent** - Lämna fältet tomt

   ![Konfiguration av replikagent - Inställningar](assets/aem-runtime/settings-config.png)

1. Under **Transport** uppdaterar du följande fält:

   + **URI** - `http://localhost:4503/bin/receive?sling:authRequestLogin=1`
   + **Användare** - `admin`
   + **Lösenord** - `admin`

   ![Konfiguration av replikagent - transport](assets/aem-runtime/transport-config.png)

1. Klicka **OK** för att spara konfigurationen och aktivera **Standard** Replikeringsagent.
1. Nu kan du ändra innehåll i författartjänsten och publicera det i publiceringstjänsten.

![Publicera sida](assets/aem-runtime/publish-page-changes.png)

## Snabbstarta JAR-startlägen

Namnet på QuickStart Jar. `aem-<tier>_<environment>-p<port number>.jar` anger hur den kommer att starta. När AEM har startats i ett visst skikt, författare eller publicering kan det inte ändras till det alternativa skiktet. För att göra detta `crx-Quickstart` mappen som skapades under den första körningen måste tas bort och QuickStart Jar måste köras igen. Miljö och portar kan ändras, men de kräver stopp/start för den lokala AEM.

Föränderliga miljöer, `dev`, `stage` och `prod`, kan vara användbart för utvecklare för att säkerställa att miljöspecifika konfigurationer definieras och löses korrekt av AEM. Vi rekommenderar att lokal utveckling huvudsakligen görs mot standardinställningen `dev` miljö, körningsläge.

Tillgängliga permutationer är följande:

| Quickstart JAR-filnamn | Lägesbeskrivning |
|------------------------------|-----------------------------------------------------------------------------|
| `aem-author-p4502.jar` | Som författare i Dev-körningsläge på port 4502 |
| `aem-author_dev-p4502.jar` | Som författare i Dev-körningsläge på port 4502 (samma som `aem-author-p4502.jar`) |
| `aem-author_stage-p4502.jar` | Som författare i mellanlagringsläge på port 4502 |
| `aem-author_prod-p4502.jar` | Som författare i produktionskörningsläge på port 4502 |
| `aem-publish-p4503.jar` | Vid publicering i Dev-körningsläge på port 4503 |
| `aem-publish_dev-p4503.jar` | As Publish in Dev run mode on port 4503 (same as `aem-publish-p4503.jar`) |
| `aem-publish_stage-p4503.jar` | Vid publicering i mellanlagringsläge på port 4503 |
| `aem-publish_prod-p4503.jar` | Vid publicering i produktionskörningsläge på port 4503 |

Observera att portnumret kan vara vilken tillgänglig port som helst på den lokala utvecklingsdatorn, men enligt konvention:

+ Port __4502__ används för __lokal AEM__
+ Port __4503__ används för __lokal AEM__

Om du ändrar dessa kan du behöva justera AEM SDK-konfigurationer

## Stoppa en lokal AEM

Om du vill stoppa en lokal AEM, antingen AEM författare eller publiceringstjänst, öppnar du kommandoradsfönstret som användes för att starta AEM körningsmiljö och trycker på `Ctrl-C`. Vänta på att AEM stängs av. Kommandoradsprompten är tillgänglig när avstängningsprocessen är slutförd.

## Inställningsåtgärder för lokal AEM

+ __OSGi-konfigurationsmiljövariabler och hemliga variabler__ är [särskilt inställd för AEM lokala körningsmiljön](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#local-development)i stället för att hantera dem med AIR CLI.

## När QuickStart Jar ska uppdateras

Uppdatera AEM SDK minst en gång i månaden, eller kort efter, den sista torsdagen i varje månad, vilket är versionsslutet för AEM as a Cloud Service&quot;funktionsreleaser&quot;.

>[!WARNING]
>
> Om du uppdaterar Quickstart Jar till en ny version måste du ersätta hela den lokala utvecklingsmiljön, vilket resulterar i att all kod, konfiguration och innehåll i de lokala AEM-databaserna går förlorad. Se till att kod, konfiguration eller innehåll som inte ska förstöras implementeras på ett säkert sätt i Git, eller exporteras från den lokala AEM instansen som AEM.

### Så här undviker du innehållsförluster när du uppgraderar AEM SDK

Genom att uppgradera AEM SDK skapas en helt ny AEM, inklusive en ny databas, vilket innebär att ändringar som gjorts i en tidigare AEM SDK-databas går förlorade. Följande är användbara strategier för att hjälpa till med bestående innehåll mellan AEM SDK-uppgraderingar och kan användas diskret eller i kombination:

1. Skapa ett innehållspaket som är avsett för att innehålla exempelinnehåll som ska vara till hjälp vid utvecklingen, och behåll det i Git. Allt innehåll som ska bevaras genom AEM SDK-uppgraderingar kommer att finnas kvar i det här paketet och återdistribueras efter uppgraderingen av AEM SDK.
1. Använd [oak-upgrade](https://jackrabbit.apache.org/oak/docs/migration.html) med `includepaths` för att kopiera innehåll från den tidigare AEM SDK-databasen till den nya AEM SDK-databasen.
1. Säkerhetskopiera allt innehåll med AEM Package Manager och innehållspaket på den tidigare AEM SDK:n och installera om dem på den nya AEM SDK:n.

Kom ihåg att om du använder ovanstående metoder för att underhålla kod mellan AEM SDK-uppgraderingar, så visas ett mönster för utveckling. Kod som inte kan användas för engångsbruk ska ha sitt ursprung i din utvecklingsutvecklingsutvecklingsutvecklingsmiljö och flöda in i AEM SDK via distributioner.

## Felsökning

### Om du dubbelklickar på Quickstart JAR-filen uppstår ett fel{#troubleshooting-double-click}

När du dubbelklickar på QuickStart Jar för att starta visas ett felmodalt fel som förhindrar att AEM startas lokalt.

![Felsökning - Dubbelklicka på QuickStart JAR-filen](./assets/aem-runtime/troubleshooting__double-click.png)

Detta beror på att AEM as a Cloud Service QuickStart Jar inte stöder dubbelklickning av QuickStart Jar för att starta AEM lokalt. Du måste i stället köra JAR-filen från kommandoraden.

Om du vill starta AEM författartjänsten `cd` till katalogen som innehåller QuickStart Jar och kör kommandot:

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ java -jar aem-author-p4502.jar
```

>[!TAB Windows]

```shell
$ java -jar aem-author-p4502.jar
```

>[!TAB Linux®]

```shell
$ java -jar aem-author-p4502.jar
```

>[!ENDTABS]

eller, för att starta AEM Publish-tjänsten, `cd` till katalogen som innehåller QuickStart Jar och kör kommandot:

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ java -jar aem-publish-p4503.jar
```

>[!TAB Windows]

```shell
$ java -jar aem-publish-p4503.jar
```

>[!TAB Linux®]

```shell
$ java -jar aem-publish-p4503.jar
```

>[!ENDTABS]

### Starten av snabbstartsgaren från kommandoraden avbryts omedelbart{#troubleshooting-java-8}

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

Detta beror på att AEM as a Cloud Service kräver Java™ SDK 11 och du kör en annan version, troligtvis Java™ 8. Lös problemet genom att hämta och installera [Oracle Java™ SDK 11](https://experience.adobe.com/#/downloads/content/software-distribution/en/general.html?1_group.propertyvalues.property=.%2Fjcr%3Acontent%2Fmetadata%2FDc%3AsoftwareType&amp;1_group.propertyvalues.operation=equals&amp;1_group.propertyvalues.0_values=software-type%3Atooling&amp;fulltext=Oracle%7E+JDK%7E+11%7E&amp;orderby=%40jcr%3Acontent%2FDK jcr%3AlastModified&amp;orderby.sort=desc&amp;layout=list&amp;p.offset=0&amp;p.limit=14).

När Oraclet Java™ 11 SDK är installerat kontrollerar du att det är den aktiva versionen genom att köra kommandot från kommandoraden:

>[!BEGINTABS]

>[!TAB macOS]

```shell
$ java --version
```

>[!TAB Windows]

```shell
$ java -version
```

>[!TAB Linux®]

```shell
$ java --version
```

>[!ENDTABS]

## Ytterligare resurser

+ [Hämta AEM SDK](https://experience.adobe.com/#/downloads)
+ [Adobe Cloud Manager](https://my.cloudmanager.adobe.com/)
+ [Ladda ned Docker](https://www.docker.com/)
+ [Experience Manager Dispatcher-dokumentation](https://experienceleague.adobe.com/docs/experience-manager-dispatcher/using/dispatcher.html)
