---
user-guide-title: Självstudiekurser om Adobe Experience Manager as a Cloud Service
user-guide-description: En samling självstudiekurser för Adobe Experience Manager som Cloud Service.
breadcrumb-title: AEM som Cloud Service Tutorials
sub-product: cloud-service
team: TM
source-git-commit: f22a37f80a9c9698718e1c75576b7ca705e658fc
workflow-type: tm+mt
source-wordcount: '560'
ht-degree: 13%

---


# Självstudiekurser om Adobe Experience Manager as a Cloud Service {#cloud-service}

+ [Översikt](./overview.md)
+ Introduktion till AEM as a Cloud Service{#introduction}
   + [Vad är AEM som en Cloud Service?](./introduction/what-is-aem-as-a-cloud-service.md)
   + [Utveckling](./introduction/evolution.md)
   + [Arkitektur](./introduction/architecture.md)
   + [Cloud Manager](./introduction/cloud-manager.md)
+ Underliggande teknik {#underlying-technology}
   + [AEM](./underlying-technology/introduction-architecture.md)
   + [OSGi](./underlying-technology/introduction-osgi.md)
   + [Java Content Repository](./underlying-technology/introduction-jcr.md)
   + [Sling](./underlying-technology/introduction-sling.md)
   + [Författare och publiceringstjänster](./underlying-technology/introduction-author-publish.md)
   + [Dispatcher](./underlying-technology/introduction-dispatcher.md)
+ Cloud Manager {#cloud-manager}
   + [Program](./cloud-manager/programs.md)
   + [Miljöer](./cloud-manager/environments.md)
   + [CI/CD Production Pipeline](./cloud-manager/cicd-production-pipeline.md)
   + [CI/CD icke-produktionsförlopp](./cloud-manager/cicd-non-production-pipeline.md)
   + [Aktivitet](./cloud-manager/activity.md)
   + Dev Ops{#devops}
      + [Distribuera kod](./cloud-manager/devops/deploy-code.md)
      + [Sammanfoga projekt](./cloud-manager/devops/merge-projects.md)
      + [Konfigurera pipelines](./cloud-manager/devops/configure-pipelines.md)
      + [Kontinuerlig integrering](./cloud-manager/devops/continuous-integration.md)
      + [Analysera testresultat](./cloud-manager/devops/analyze-test-results.md)
      + [Dispatcher Configurations](./cloud-manager/devops/dispatcher-configurations.md)
      + [API:er för Cloud Manager](./cloud-manager/devops/cloud-manager-apis.md)
+ Installation av lokal utvecklingsmiljö {#local-development-environment-set-up}
   + [Översikt](./local-development-environment/overview.md)
   + [Utvecklingsverktyg](./local-development-environment/development-tools.md)
   + [Local AEM Runtime](./local-development-environment/aem-runtime.md)
   + [Local Dispatcher Tools](./local-development-environment/dispatcher-tools.md)
+ Utveckling{#developing}
   + Grundläggande om utveckling{#basics}
      + [AEM SDK](./developing/basics/aem-sdk.md)
      + [Lokal utvecklingsmiljö](./developing/basics/local-development-environment.md)
      + [AEM Project Archetype](./developing/basics/aem-project-archetype.md)
      + [AEM-projektstruktur](./developing/basics/project-structure.md)
      + [Mutable vs. Immutable Content](./developing/basics/mutable-immutable.md)
      + [Databasstrukturpaket](./developing/basics/repository-structure-package.md)
      + [Content Publishing](./developing/basics/content-publishing.md)
      + [OSGi-konfigurationer](./developing/basics/osgi-configurations.md)
      + [Migrering av Dispatcher-konfiguration](./developing/basics/dispatcher-configuration.md)
   + AEM projekt{#aem-projects}
      + [AEM Maven Project](./developing/projects/maven-project-structure.md)
   + OSGi Services{#osgi-services}
      + [OSGi Service Basics](./developing/osgi-services/basics.md)
      + [OSGi Component Lifecycle](./developing/osgi-services/lifecycle.md)
      + [Grundläggande om OSGi-konfigurationer](./developing/osgi-services/configurations.md)
      + [OSGi-konfigurationer med OCD](./developing/osgi-services/configurations-ocd.md)
   + [AEM SDK API JavaDocs](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/index.html)
+ Felsöka AEM{#debugging}
   + Felsöka AEM SDK{#debugging-aem-sdk}
      + [Översikt](./debugging/aem-sdk-local-quickstart/overview.md)
      + [Loggar](./debugging/aem-sdk-local-quickstart/logs.md)
      + [Fjärrfelsökning](./debugging/aem-sdk-local-quickstart/remote-debugging.md)
      + [OSGi-webbkonsol](./debugging/aem-sdk-local-quickstart/osgi-web-consoles.md)
      + [Dispatcher Tools](./debugging/aem-sdk-local-quickstart/dispatcher-tools.md)
      + [Andra verktyg](./debugging/aem-sdk-local-quickstart/other-tools.md)
   + Felsöka AEM som en Cloud Service{#debugging-aem-as-a-cloud-service}
      + [Översikt](./debugging/cloud-service/overview.md)
      + [Loggar](./debugging/cloud-service/logs.md)
      + [Bygg och driftsätt](./debugging/cloud-service/build-and-deployment.md)
      + [Developer Console](./debugging/cloud-service/developer-console.md)
      + [CRXDE Lite](./debugging/cloud-service/crxde-lite.md)
+ Åtkomst till AEM{#accessing}
   + [Översikt](./accessing/overview.md)
   + [Adobe IMS-användare](./accessing/adobe-ims-users.md)
   + [Adobe IMS-användargrupper](./accessing/adobe-ims-user-groups.md)
   + [Adobe IMS-produktprofiler](./accessing/adobe-ims-product-profiles.md)
   + [AEM användare, grupper och behörigheter](./accessing/aem-users-groups-and-permissions.md)
   + [Konfigurera åtkomst till AEM genomgång](./accessing/walk-through.md)
+ Migrering {#migration}
   + [Content Transfer Tool](./migration/content-transfer-tool.md)
   + [Massimport av resurser](./migration/bulk-import.md)

   + Flytta till AEM as a Cloud Service {#moving-to-aem-as-a-cloud-service}
      + [Introduktion](./migration/moving-to-aem-as-a-cloud-service/introduction.md)
      + [BPA och CAM](./migration/moving-to-aem-as-a-cloud-service/bpa-and-cam.md)
      + [Verktyg för AEM](./migration/moving-to-aem-as-a-cloud-service/aem-modernization-tools.md)
      + [Databasmodernisering](./migration/moving-to-aem-as-a-cloud-service/repository-modernization.md)
      + [Onboarding](./migration/moving-to-aem-as-a-cloud-service/onboarding.md)
      + [Cloud Manager](./migration/moving-to-aem-as-a-cloud-service/cloud-manager.md)
      + [Dispatcher](./migration/moving-to-aem-as-a-cloud-service/dispatcher.md)
      + Innehållsmigrering {#content-migration}
         + [Massimporttjänst](./migration/moving-to-aem-as-a-cloud-service/content-migration/bulk-import-service.md)
         + [Verktyget Innehållsöverföring](./migration/moving-to-aem-as-a-cloud-service/content-migration/content-transfer-tool.md)
      + [Sökning och indexering](./migration/moving-to-aem-as-a-cloud-service/search-and-indexing.md)
      + [asset compute Microservices](./migration/moving-to-aem-as-a-cloud-service/asset-compute-microservices.md)
      + AEM Forms som Cloud Service {#aem-forms}
         + [Introduktion](./migration/moving-to-aem-as-a-cloud-service/aem-forms/introduction.md)
         + [Digital registrering](./migration/moving-to-aem-as-a-cloud-service/aem-forms/digital-enrollment.md)
         + [Kommunikation](./migration/moving-to-aem-as-a-cloud-service/aem-forms/communications.md)
   + Cloud Acceleration Manager {#cloud-acceleration-manager}
      + [Introduktion](./migration/cloud-acceleration-manager/introduction.md)
      + [Analysera beredskap och bästa praxis](./migration/cloud-acceleration-manager/readiness-and-best-practice-analyzer.md)
      + [Implementeringsfas](./migration/cloud-acceleration-manager/implementation-phase.md)
      + [Verktyget Innehållsöverföring](./migration/cloud-acceleration-manager/content-transfer-tool.md)
      + [Kodomfaktoriseringsverktyg](./migration/cloud-acceleration-manager/code-refactoring-tools.md)
      + [Koddatabasmodernizer](./migration/cloud-acceleration-manager/code-repository-modernizer.md)
      + [Dispatcher Converter](./migration/cloud-acceleration-manager/dispatcher-converter.md)
      + [Indexkonverterare](./migration/cloud-acceleration-manager/index-converter.md)
      + [Verktyg för resursarbetsflödesmigrering](./migration/cloud-acceleration-manager/asset-workflow-migration-tool.md)
      + [Navigera i molnaccelerationshanteraren](./migration/cloud-acceleration-manager/navigating.md)
      + [Använda Cloud Acceleration Manager](./migration/cloud-acceleration-manager/using.md)
+ Forms{#forms}
   + Skapa anpassat formulär{#create-first-af}
      + [Introduktion](./forms/create-first-af/introduction.md)
      + [Skapa tema](./forms/create-first-af/create-theme.md)
      + [Skapa mall](./forms/create-first-af/create-template.md)
      + [Skapa fragment](./forms/create-first-af/create-fragments.md)
      + [Skapa formulär](./forms/create-first-af/create-af.md)
      + [Konfigurera rotpanel](./forms/create-first-af/configure-root-panel.md)
      + [Konfigurera personpanel](./forms/create-first-af/configure-people-panel.md)
      + [Konfigurera inkomstpanelen](./forms/create-first-af/configure-income-panel.md)
      + [Konfigurera resurspanelen](./forms/create-first-af/configure-assets-panel.md)
      + [Konfigurera startpanelen](./forms/create-first-af/configure-start-panel.md)
      + [Verktygsfältet Lägg till och konfigurera](./forms/create-first-af/add-configure-toolbar.md)
   + Document Cloud API och AEM Forms CS{#doc-cloud-sdk}
      + [Introduktion](./forms/doc-cloud-sdk/introduction.md)
      + [Skapa Adobe I/O-projekt](./forms/doc-cloud-sdk/create-document-cloud-credentials.md)
      + [Skapa OSGi-konfiguration](./forms/doc-cloud-sdk/create-doc-cloud-configuration.md)
      + [Definiera gränssnitt](./forms/doc-cloud-sdk/create-interface.md)
      + [Implementeringsgränssnitt](./forms/doc-cloud-sdk/implement-interface.md)
      + [Skapa JSON-del](./forms/doc-cloud-sdk/get-content-analyzer.md)
      + [Anpassat processsteg](./forms/doc-cloud-sdk/custom-process-step.md)
   + Azure Portal Storage{#forms-cs-azure-portal}
      + [Introduktion](./forms/forms-cs-azure-portal/introduction.md)
      + [Skapa formulärdatamodell](./forms/forms-cs-azure-portal/create-fdm.md)
      + [Lagra formulärdata i Azure Storage](./forms/forms-cs-azure-portal/create-af.md)
      + [Förifyll formulär](./forms/forms-cs-azure-portal/prefill-af-storage.md)
      + [Skicka frågor](./forms/forms-cs-azure-portal/query-submitted-data.md)


      + Skapa granskningsarbetsflöde{#create-aem-workflow}
         + [Skapa arbetsflödesmodell](./forms/create-aem-workflow/create-workflow.md)
         + [Arbetsflöde för utlösare](./forms/create-aem-workflow/configure-af.md)
      + Adobe Sign med AEM Forms{#forms-and-sign}
         + [Introduktion](./forms/forms-and-sign/introduction.md)
         + [Adobe Sign API-program](./forms/forms-and-sign/create-sign-api-application.md)
         + [Konfiguration av Adobe Sign Cloud](./forms/forms-and-sign/create-adobe-sign-cloud-configuration.md)
         + [Skapa anpassat formulär](./forms/forms-and-sign/create-adaptive-form.md)
         + [Konfigurera för fyllning och signering](./forms/forms-and-sign/configure-form-fill-and-sign.md)
      + Integrera med Salesforce{#integrate-with-salesforce}
         + [Introduktion](./forms/integrate-with-salesforce/introduction.md)
         + [Skapa ansluten app](./forms/integrate-with-salesforce/create-connected-app.md)
         + [Skapa swagger-fil](./forms/integrate-with-salesforce/describe-rest-api.md)
         + [Skapa datakälla](./forms/integrate-with-salesforce/create-data-source.md)
         + [Skapa formulärdatamodell](./forms/integrate-with-salesforce/create-form-data-model.md)
         + [Testa formulärinlämning](./forms/integrate-with-salesforce/create-lead-submitting-form.md)
         + [Testa klickningshändelse](./forms/integrate-with-salesforce/create-lead-click-event.md)
+ Utbyggbarhet för asset compute{#asset-compute}
   + [Översikt](./asset-compute/overview.md)
   + Konfigurera{#set-up}
      + [Konto- och tjänsteetablering](./asset-compute/set-up/accounts-and-services.md)
      + [Lokal utvecklingsmiljö](./asset-compute/set-up/development-environment.md)
      + [Adobe Project Fire](./asset-compute/set-up/firefly.md)
   + Utveckla{#develop}
      + [Skapa ett Asset compute-projekt](./asset-compute/develop/project.md)
      + [Konfigurera miljövariabler](./asset-compute/develop/environment-variables.md)
      + [Konfigurera manifest.yml](./asset-compute/develop/manifest.md)
      + [Utveckla en arbetare](./asset-compute/develop/worker.md)
      + [Använda utvecklingsverktyget](./asset-compute/develop/development-tool.md)
   + Testa och felsök{#test-debug}
      + [Testa en arbetare](./asset-compute/test-debug/test.md)
      + [Felsöka en arbetare](./asset-compute/test-debug/debug.md)
   + Distribuera{#deploy}
      + [Distribuera till Adobe I/O Runtime](./asset-compute/deploy/runtime.md)
      + [Integrera med AEM](./asset-compute/deploy/processing-profiles.md)
   + Avancerat{#advanced}
      + [Metadataarbetare](./asset-compute/advanced/metadata.md)
   + [Felsökning](./asset-compute/troubleshooting.md)
+ Tutorials i flera steg{#multi-step-tutorials}
   + [Utveckling av AEM Sites](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html)
   + [GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html)
   + [SPA Editor (React)](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-react-tutorial/overview.html)
   + [SPA (Angular)](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-angular-tutorial/overview.html)
   + [AEM Sites och Adobe Target](https://experienceleague.adobe.com/docs/experience-manager-learn/aem-target-tutorial/overview.html)
   + [Tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html)
