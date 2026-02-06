---
title: Felsöka CI/CD Pipeline med AEM Development Agent
description: Lär dig hur du felsöker och åtgärdar en misslyckad CI/CD-pipeline med AEM Development Agent.
version: Experience Manager as a Cloud Service
role: Developer, Admin
level: Beginner
doc-type: tutorial
duration: null
jira: KT-20279
thumbnail: KT-20279.png
last-substantial-update: null
source-git-commit: 6fa0f88c231f7b68392a77a60491d4f741140a5a
workflow-type: tm+mt
source-wordcount: '1227'
ht-degree: 0%

---


# Felsöka CI/CD Pipeline med AEM Development Agent

Lär dig hur du felsöker och åtgärdar en misslyckad CI/CD-pipeline med AEM Development Agent.

AEM Development Agent hjälper tekniska team, inklusive utvecklare, DevOps-ingenjörer och administratörer att **snabba upp sina arbetsflöden** genom att tillhandahålla _AI-styrd vägledning och åtgärder_.

>[!TIP]
>
> Se även [Översikt över agenter i AEM](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/agents/overview) för en fullständig lista över tillgängliga agenter i AEM as a Cloud Service, deras funktioner och hur du kan få tillgång till dem.


## Ökning

AEM Development Agent erbjuder flera funktioner, bland annat möjlighet att lista, felsöka och åtgärda felaktiga CI/CD-ledningar. Du kan anropa AEM Development Agent via AI Assistant för att åtgärda dina specifika användningsfall.

I den här självstudien används [WKND Sites Project](https://github.com/adobe/aem-guides-wknd) för att demonstrera hur du felsöker och åtgärdar en misslyckad CI/CD-pipeline med hjälp av AEM Development Agent. Samma principer gäller för alla AEM-projekt.

För enkelhetens skull introduceras i den här självstudien ett enhetstestfel i filen `BylineImpl.java` som visar AEM Development Agent felsökningsfunktioner för pipeline.

## Förutsättningar

Om du vill följa den här självstudiekursen behöver du:

- AI-assistenten och agenter i AEM har aktiverats. Mer information finns i [Konfigurera AI i AEM](./setup.md) och observera att de spelgrunder som nämns i den artikeln inte har funktioner för AEM Development Agent.
- Åtkomst till Adobe [Cloud Manager](https://my.cloudmanager.adobe.com/) med en utvecklar- eller programhanterarroll. Mer information finns i [rolldefinitioner](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-manager/content/requirements/users-and-roles#role-definitions).
- En AEM as a Cloud Service-miljö
- Åtkomst till agenter i AEM via programmet [Beta](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/release-notes/release-notes/release-notes-current#aem-beta-programs)
- [WKND-webbplatsprojektet](https://github.com/adobe/aem-guides-wknd) klonades till din lokala dator

### Aktuella funktioner i AEM Development Agent

Innan vi går in på självstudiekursen ska vi gå igenom de aktuella funktionerna i AEM Development Agent:

- Lista CI/CD-pipelines och deras status
- Felsökning och korrigering misslyckades med **rörledningar i full hög**, inklusive typerna _Kodkvalitet_ och _Distribution_.
- Stegen _Build_ (kompilering av koden för att skapa en distributionsbar artefakt) och _Code Quality_ (statisk kodanalys via SonarQube-regler) i **helstacksrörledningarna** stöds.

Funktionerna hos AEM Development Agent utökas och uppdateras regelbundet. Om du vill ha feedback och förslag kan du skicka ett e-postmeddelande till [aem-devagent@adobe.com](mailto:aem-devagent@adobe.com).

## Inställningar

Följ de här stegen för att slutföra den här självstudiekursen:

1. Klona [WKND Sites Project](https://github.com/adobe/aem-guides-wknd) och skicka det till din Cloud Manager Git-databas
2. Skapa och konfigurera en pipeline för kodkvalitet
3. Kör pipeline och observera den misslyckade körningen
4. Använd AEM Development Agent för att felsöka och åtgärda den misslyckade pipeline

Vi går igenom varje steg i detalj.

### Använd WKND Sites Project som ett demoprojekt

I den här självstudien används WKND Sites Projects `tutorial/dev-agent/unit-test-failure`-gren för att visa hur du använder AEM Development Agent. Samma principer kan tillämpas på alla AEM-projekt.

- Ett enhetstestfel har introducerats i filen `BylineImpl.java` enligt följande. Om du använder ditt eget AEM-projekt kan du få ett liknande enhetstestfel.

  ```java
  ...
  @Override
  public String getName() {
      if (name != null) {
          return "Author: " + name; // This line is intentionally incorrect to introduce a unit test failure.
      }
      return name;
  }
  ...
  ```

- Klona [WKND Sites Project](https://github.com/adobe/aem-guides-wknd) till din lokala dator, navigera till projektkatalogen och växla till grenen `tutorial/dev-agent/unit-test-failure`.

  ```shell
  git clone https://github.com/adobe/aem-guides-wknd.git
  cd aem-guides-wknd
  git checkout tutorial/dev-agent/unit-test-failure
  ```

- Skapa en ny Cloud Manager Git-databas för WKND Sites Project och lägg till den som en fjärrplats i din lokala Git-databas:

   - Navigera till Adobe [Cloud Manager](https://my.cloudmanager.adobe.com/) och välj ditt program.
   - Klicka på **Databaser** i den vänstra sidofältet.
   - Klicka på **Lägg till databas** längst upp till höger.
   - Ange ett **databasnamn** (till exempel &quot;wknd-site-tutorial&quot;) och klicka på **Spara**. Vänta tills databasen har skapats.

     ![Lägg till databas](./assets/dev-agent/add-repository.png)

   - Klicka på **Åtkomst till upprepningsinformation** i det övre högra hörnet och kopiera databasens URL.

     ![Åtkomst till svarsinformation](./assets/dev-agent/access-repo-info.png)

   - Lägg till den nya Cloud Manager Git-databasen som en fjärrplats i din lokala Git-databas:

     ```shell
     git remote add adobe https://git.cloudmanager.adobe.com/<your-adobe-organization>/wknd-site-tutorial/
     ```

- Flytta din lokala Git-databas till Cloud Manager Git-databasen:

  ```shell
  git push adobe
  ```

  Ange **användarnamn** och **lösenord** från Cloud Manager **databasinformation** när du uppmanas att ange autentiseringsuppgifter.

### Skapa och konfigurera en pipeline för kodkvalitet

I den här självstudien används en pipeline för kodkvalitet (icke-produktion) för att utlösa ett pipeline-fel för felsökning. Mer information om pipelines för kodkvalitet finns i [Introduktion till CI/CD-pipelines](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/cicd-pipelines/introduction-ci-cd-pipelines#introduction).

- I Cloud Manager navigerar du till avsnittet **Förgreningar** och väljer **Lägg till** > **Lägg till icke-produktionsförlopp**.
- Konfigurera följande i dialogrutan **Lägg till icke-produktionspipeline**:

   - **Konfigurationssteg**:
      - Behåll standardvärden som **Förloppstyp** som `Code Quality Pipeline` och **Distributionutlösare** som `Manual`.
      - Ange **för** icke-produktionsförloppsnamn`Code Quality::Fullstack`

     ![Lägg till icke-produktionsförloppskonfiguration](./assets/dev-agent/add-non-production-pipeline-configuration.png)

   - **Source Code** - steg:
      - Välj **Fullständig stackkod**
      - För **databas** väljer du den nya Cloud Manager Git-databasen
      - För **Git-grenen** väljer du `tutorial/dev-agent/unit-test-failure`
      - Klicka på **Spara**

     ![Lägg till icke-produktionsförlopp, Source-kod](./assets/dev-agent/add-non-production-pipeline-source-code.png)

- Kör den nyligen skapade kodkvalitetspipelinen genom att klicka på **Kör** på menyn med tre punkter i pipeline-posten.

  ![Kör pipeline för kodkvalitet](./assets/dev-agent/run-code-quality-pipeline.png)


>[!IMPORTANT]
>
> Distributionsflödet ingår inte i den här självstudiekursen. Du kan dock följa samma principer för att felsöka och korrigera en misslyckad distributionsprocess.


### Observera misslyckad pipeline-körning

Kodkvalitetspipelinen misslyckas i steget **Förberedelse av felaktigheter** med ett fel:

![Det gick inte att köra pipeline](./assets/dev-agent/failed-pipeline-execution.png)

Utan AEM Development Agent kräver detta manuellt felsökning. Utvecklaren måste kontrollera loggarna och granska koden - en tidsödande och tidsödande process.

Därefter får du se hur AI kan felsöka och åtgärda felsökningen.

## Använd AEM Development Agent för att felsöka och korrigera den felaktiga pipelinen

Du kan anropa AEM Development Agent med hjälp av AI Assistant i AEM genom att beskriva pipeline-felet på det naturliga språket.

- Klicka på ikonen **AI-assistenten** i det övre högra hörnet.

- Ange information om pipeline-fel på det naturliga språket **Fråga**. Till exempel:

  ```text
  I have a failed pipeline execution on %PROGRAM-NAME% program, help me to troubleshoot and fix it.
  ```

  ![Anropa AEM Development Agent](./assets/dev-agent/invoke-aem-development-agent.png)

  **AEM Development Agent** anropas för att felsöka och korrigera den misslyckade pipelinekörningen.

  >[!NOTE]
  >
  > Om uppmaningen inte är tydlig ber AI-assistenten om klargöranden och ger information som hjälper dig att förfina prompten.

- Klicka på ikonen **Öppna i helskärmsläge** för att visa den detaljerade felsökningsprocessen när argumentationen är klar.

  ![Öppna i helskärmsläge](./assets/dev-agent/open-in-full-screen.png)

  Resultatet innehåller värdefulla insikter, bland annat felinformation, källfilen, radnummer och ett **Så här korrigerar du** -avsnitt med tydliga steg för att lösa problemet.

- I det här fallet föreslog agenten korrekt att implementeringen (`getName()`-metoden) skulle ändras eller att enhetstestet (`getNameTest()` -metoden) skulle uppdateras för att åtgärda problemet. Man slipper hallucinationer och använde sig av en mänsklig strategi i en slinga samtidigt som man tillhandahöll åtgärdbara kodändringar för utvecklaren.

  ![Kopiera kodändringar](./assets/dev-agent/copy-code-changes.png)

- Uppdatera filen `BylineImpl.java` med de föreslagna kodändringarna och implementera och skicka sedan ändringarna till Cloud Manager Git-databasen.

  ```java
  ...
  @Override
  public String getName() {
      return name;
  }
  ...
  ```

- Kör pipelinen igen och observera att det lyckades.

## Ytterligare exempel

WKND Sites Project innehåller ytterligare exempel på problem med trasig kod och konfiguration, till exempel saknade beroenden och felaktig konfiguration. Du kan utforska de här exemplen genom att checka ut [grenarna som börjar med `tutorial/dev-agent/`](https://github.com/adobe/aem-guides-wknd/branches/all?query=tutorial%2Fdev-agent&lastTab=overview). Om du vill se brytningsändringarna kan du jämföra grenen `tutorial/dev-agent/unit-test-failure` med grenen `main` genom att klicka på knappen **Jämför**. Leta sedan efter avsnittet _ändrad fil_.

![Jämför grenar](./assets/dev-agent/compare-branches.png)

Se även [Exempeluppmaningarna](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/agents/development/overview#sample-prompts) om du vill ha mer information om hur du använder AEM Development Agent.

## Sammanfattning

I den här självstudiekursen lärde du dig att använda AEM Development Agent för att felsöka och korrigera en misslyckad CI/CD-pipeline med hjälp av AI-assistenten. Du har också lärt dig hur AI snabbar upp de tekniska arbetsflödena genom att ge användbara insikter och kodändringar.

Börja använda AEM Development Agent och andra agenter i AEM för att snabba upp arbetsflödena. Mer information finns i [Översikt över agenter i AEM](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/agents/overview).

## Ytterligare resurser

- [AI i Experience Manager](./overview.md)
- [Översikt över agenter i AEM](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/agents/overview)
- [Översikt över utvecklingsagenten](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/agents/development/overview)
- [Översikt över agenter i AEM](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/ai-in-aem/agents/overview)
