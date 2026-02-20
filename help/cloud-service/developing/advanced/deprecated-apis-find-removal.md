---
title: Söka efter och ta bort inaktuella API:er i AEM as a Cloud Service
description: Lär dig hur du söker efter och tar bort inaktuella API:er i AEM as a Cloud Service.
version: Experience Manager as a Cloud Service
role: Developer, Architect
level: Beginner
doc-type: tutorial
duration: null
jira: KT-20288
thumbnail: KT-20288.png
last-substantial-update: 2026-02-09T00:00:00Z
exl-id: 287894ea-9cc1-4c27-ac7e-967ad46f4789
source-git-commit: 08dd5006ebf4ebd94e8bc60594f8f1541feb810f
workflow-type: tm+mt
source-wordcount: '603'
ht-degree: 0%

---

# Söka efter och ta bort inaktuella API:er i AEM as a Cloud Service

Lär dig hur du söker efter och tar bort inaktuella API:er i AEM as a Cloud Service.

## Ökning

Ta bort inaktuella API:er från ditt projekt för att vara säker och effektiv och för att du ska kunna fortsätta att distribuera kod med Cloud Manager-pipelines.

I den här självstudiekursen får du lära dig att hitta och ta bort inaktuella API:er i din AEM as a Cloud Service-miljö med [AEM Analyser Maven Plugin](https://github.com/adobe/aemanalyser-maven-plugin/blob/main/aemanalyser-maven-plugin/README.md).

## Meddelanden om inaktuella API:er

De inaktuella API:erna och de åtgärder som krävs för att åtgärda dem rapporteras regelbundet, vi ska titta på några exempel.

- AEM as a Cloud Service **Actions Center** meddelar dig om _inaktuella API:er_ i ditt projekt.
  ![Föråldrade API:er i Åtgärdscenter](./assets/deprecated-apis/actions-center-deprecated-apis.png)

- I steget **Kodsökning** i Cloud Manager-pipeline rapporteras inaktuella API:er i ditt projekt. Granska rapporten **Hämta information** om du vill se en fullständig lista över inaktuella API:er.
  ![Föråldrade API:er i kodsökning](./assets/deprecated-apis/code-scanning-summary.png)

- **Förberedelsesteget för felaktigheter** i Cloud Manager-pipeline rapporterar inaktuella API:er i ditt projekt, **Hämtningslogg** och söker efter _Analyserarvarningar_ i loggfilen.

  ```
  2026-02-20 15:40:48.376 Analyser warnings have been found 
  2026-02-20 15:40:48.376 The analyser found the following warnings for author and publish : 
  2026-02-20 15:40:48.376 [region-deprecated-api] com.adobe.aem.guides:aem-guides-wknd.core:4.0.5-SNAPSHOT: Usage of deprecated package found : org.apache.commons.lang : Commons Lang 2 is in maintenance mode. Commons Lang 3 should be used instead. Deprecated since 2021-04-30 For removal : 2021-12-31 (com.adobe.aem.guides:aem-guides-wknd.all:4.0.5-SNAPSHOT)
  2026-02-20 15:40:56.458 Convert Merge Analyse finished.
  ```


## Söka efter föråldrade API:er

Följ de här stegen för att hitta inaktuella API:er i ditt AEM as a Cloud Service-projekt.

1. **Använd den senaste AEM Analyser Maven Plugin**

   Använd den senaste versionen av [AEM Analyser Maven Plugin](https://github.com/adobe/aemanalyser-maven-plugin/blob/main/aemanalyser-maven-plugin/README.md) i ditt AEM-projekt.

   - I huvudversionen `pom.xml` deklareras vanligtvis plugin-versionen. Jämför din version med den senaste [versionen](https://mvnrepository.com/artifact/com.adobe.aem/aemanalyser-maven-plugin).

     ```xml
     ...
     <aemanalyser.version>1.6.16</aemanalyser.version> <!-- Latest released version as of 20-Feb-2026 -->
     ...
     <!-- AEM Analyser Plugin -->
     <plugin>
         <groupId>com.adobe.aem</groupId>
         <artifactId>aemanalyser-maven-plugin</artifactId>
         <version>${aemanalyser.version}</version>
         <extensions>true</extensions>
     </plugin>
     ...
     ```

   - Plugin-programmet kontrollerar mot den senaste tillgängliga AEM SDK. Använd den senaste AEM SDK-versionen i projektfilen `pom.xml`. Det hjälper till att identifiera de borttagna API:erna som IDE-varningar.

     ```xml
     ...
     <aem.sdk.api>2026.2.24464.20260214T050318Z-260100</aem.sdk.api> <!-- Latest available AEM SDK version as of 20-Feb-2026 -->
     ...
     ```

   - Kontrollera att modulen `all` kör plugin-programmet i fasen `verify`.

     ```xml
     ...
     <build>
         <plugins>
             ...
             <plugin>
                 <groupId>com.adobe.aem</groupId>
                 <artifactId>aemanalyser-maven-plugin</artifactId>
                 <extensions>true</extensions>
                 <executions>
                     <execution>
                         <id>analyse-project</id>
                         <phase>verify</phase>
                         <goals>
                             <goal>project-analyse</goal>
                         </goals>
                     </execution>
                 </executions>
             </plugin>
             ...
         </plugins>
     </build>
     ...
     ```

2. **Kör ett bygge och sök efter varningar**

   När du kör `mvn clean install` rapporterar analyseraren inaktuella API:er som **[VARNING]** -meddelanden i utdata. Till exempel:

   ```shell
   ...
   [WARNING] The analyser found the following warnings for author and publish :
   [WARNING] [region-deprecated-api] com.adobe.aem.guides:aem-guides-wknd.core:4.0.5-SNAPSHOT: Usage of deprecated package found : org.apache.commons.lang : Commons Lang 2 is in maintenance mode. Commons Lang 3 should be used instead. Deprecated since 2021-04-30 For removal : 2021-12-31 (com.adobe.aem.guides:aem-guides-wknd.all:4.0.5-SNAPSHOT)
   ...
   ```

   Det är enkelt att bortse från de här meddelandena när man fokuserar på framgångar eller misslyckanden i byggprocessen.

3. **Få en lista över inaktuella API:er**

   Ovanstående steg innehåller även samma information. Kör dock `verify`-fasen på `all`-modulen för att se alla **[VARNING]**-meddelanden på ett ställe. Till exempel:

   ```shell
   $ mvn clean verify -pl all
   ```

   **[VARNING]**-meddelandena i utdatalistan för bygge visar de inaktuella API:erna i ditt projekt.

## Ta bort inaktuella API:er

AEM Analyser rapporterar **vad** är föråldrat och ger **rekommendationen** om hur det kan åtgärdas. Använd dock tabellen nedan för att välja rätt åtgärd och följ den länkade dokumentationen när du behöver mer information.

### API-reparationsstrategi är inaktuell

| Varningstyp för analysator | Vad det indikerar | Rekommenderad åtgärd | Referens |
| --------------------- | ----------------- | ------------------ | --------- |
| Inaktuellt AEM API | API ska tas bort från AEM as a Cloud Service | Ersätt användning med det offentliga API som stöds | [API-vägledning för borttagning](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/deprecated-removed-features#api-removal-guidance) |
| Inaktuellt AEM-paket eller -klass | Paket eller klass stöds inte längre | Kod för att använda det rekommenderade alternativet | [Föråldrade API:er](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/deprecated-removed-features#aem-apis) |
| Inaktuellt tredjepartsbibliotek | Biblioteket stöds inte i framtida SDK:er | Uppgradera beroendeförhållandet och användningen av omfakturor | [Allmänna riktlinjer](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/deprecated-removed-features#api-removal-guidance) |
| Inaktuella Sling-/OSGi-mönster | Äldre anteckningar eller API:er har identifierats | Migrera till moderna Sling- och OSGi-API:er | [Borttagning av Sling-/OSGi-mönster](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/deprecated-removed-features#api-removal-guidance) |
| Planerad borttagning (framtida datum) | API fungerar fortfarande, men borttagning framtvingas senare | Schemalägg rensning före implementering av pipeline | [Versionsinformation](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/home) |

### Praktisk vägledning

- Behandla analysvarningar som **framtida pipeline-fel**, inte valfria meddelanden.
- Åtgärda inaktuella API:er lokalt med den **senaste AEM SDK**.
- Behåll analysresultatet rent för att undvika problem vid framtida uppgraderingar av AEM.

Genom att åtgärda inaktuella API:er tidigt kan du hålla ditt projekt **uppgraderingssäkert och körklart**.

## Ytterligare resurser

- [AEM Analyser Maven Plugin](https://github.com/adobe/aemanalyser-maven-plugin/blob/main/aemanalyser-maven-plugin/README.md)
- [Inaktuella och borttagna funktioner och API:er](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/deprecated-removed-features#api-removal-guidance)
