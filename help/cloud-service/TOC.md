---
user-guide-title: Självstudiekurser om Adobe Experience Manager as a Cloud Service
user-guide-description: En samling självstudiekurser för Adobe Experience Manager som Cloud Service.
breadcrumb-title: AEM som Cloud Service Tutorials
sub-product: molntjänst
team: TM
translation-type: tm+mt
source-git-commit: 59b786d95d1428916adad37ceca4412b93463e9b
workflow-type: tm+mt
source-wordcount: '329'
ht-degree: 14%

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
   + [AEM SDK API JavaDocs](https://docs.adobe.com/content/help/en/experience-manager-cloud-service-javadoc/)
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
   + [Utveckling av AEM Sites](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/develop-wknd-tutorial.html)
   + [GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html)
   + [SPA Editor (React)](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-react-tutorial/overview.html)
   + [SPA (Angular)](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-angular-tutorial/overview.html)
   + [AEM Sites och Adobe Target](https://experienceleague.adobe.com/docs/experience-manager-learn/aem-target-tutorial/overview.html)
   + [Tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html)

