---
user-guide-title: Självstudiekurser om Adobe Experience Manager as a Cloud Service
user-guide-description: En samling självstudiekurser för Adobe Experience Manager as a Cloud Service.
breadcrumb-title: AEM as a Cloud Service Tutorials
sub-product: Experience Manager as a Cloud Service
version: Cloud Service
team: TM
source-git-commit: 8b683fdcea05859151b929389f7673075c359141
workflow-type: tm+mt
source-wordcount: '874'
ht-degree: 9%

---


# Självstudiekurser om Adobe Experience Manager as a Cloud Service {#cloud-service}

+ [Översikt](./overview.md)
+ Introduktion till AEM as a Cloud Service{#introduction}
   + [Vad är AEM as a Cloud Service?](./introduction/what-is-aem-as-a-cloud-service.md)
   + [Utveckling](./introduction/evolution.md)
   + [Arkitektur](./introduction/architecture.md)
   + [Cloud Manager](./introduction/cloud-manager.md)
   + Strategi och tankeledarskap{#strategy}
      + [Experience Manager - Styrnings- och personalmodeller och arkitekter](./introduction/experience-manager-governance-and-staffing-models.md)
      + [Skapa innehåll snabbare med Adobe Experience Manager](./introduction/drive-content-velocity-for-sites.md)
      + [Snabba upp materialets hastighet med AEM](./introduction/accelerate-content-velocity-aem.md)
+ [Experience Cloud-integreringar](./experience-cloud/integrations.md)
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
   + Utbyggbarhet{#extensibility}
      + Konsol för innehållsfragment{#content-fragments}
         + [Översikt](./developing/extensibility/content-fragments/overview.md)
         + [Tilläggsregistrering](./developing/extensibility/content-fragments/extension-registration.md)
         + [Sidhuvudsmenyn](./developing/extensibility/content-fragments/header-menu.md)
         + [Åtgärdsfält](./developing/extensibility/content-fragments/action-bar.md)
         + [Modal](./developing/extensibility/content-fragments/modal.md)
         + [Adobe I/O Runtime action](./developing/extensibility/content-fragments/runtime-action.md)
         + [Testa](./developing/extensibility/content-fragments/test.md)
         + [Distribuera](./developing/extensibility/content-fragments/deploy.md)
         + Exempel på tillägg{#example-extensions}
            + [Uppdateringstillägg för massegenskap](./developing/extensibility/content-fragments/example-extensions/bulk-property-update.md)
            + [Bildgenerering och överföring till AEM](./developing/extensibility/content-fragments/example-extensions/image-generation-and-image-upload.md)
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
   + AEM{#aem-projects}
      + [AEM Maven Project](./developing/projects/maven-project-structure.md)
      + [Rensa ett AEM Maven Project](./developing/projects/remove-samples.md)
   + OSGi Services{#osgi-services}
      + [OSGi Service Basics](./developing/osgi-services/basics.md)
      + [OSGi Component Lifecycle](./developing/osgi-services/lifecycle.md)
      + [Grundläggande om OSGi-konfigurationer](./developing/osgi-services/configurations.md)
      + [OSGi-konfigurationer med OCD](./developing/osgi-services/configurations-ocd.md)
   + Avancerat{#advanced}
      + [Tjänstanvändare](./developing/advanced/service-users.md)
      + [Anpassade namnutrymmen](./developing/advanced/custom-namespaces.md)
      + [Cachelagrar sidvarianter](./developing/advanced/variant-caching.md)
   + [AEM SDK API JavaDocs](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/index.html)
+ AEM{#debugging}
   + Felsöka AEM SDK{#debugging-aem-sdk}
      + [Översikt](./debugging/aem-sdk-local-quickstart/overview.md)
      + [Loggar](./debugging/aem-sdk-local-quickstart/logs.md)
      + [Fjärrfelsökning](./debugging/aem-sdk-local-quickstart/remote-debugging.md)
      + [OSGi-webbkonsol](./debugging/aem-sdk-local-quickstart/osgi-web-consoles.md)
      + [Dispatcher Tools](./debugging/aem-sdk-local-quickstart/dispatcher-tools.md)
      + [Andra verktyg](./debugging/aem-sdk-local-quickstart/other-tools.md)
   + Felsökning AEM as a Cloud Service{#debugging-aem-as-a-cloud-service}
      + [Översikt](./debugging/cloud-service/overview.md)
      + [Loggar](./debugging/cloud-service/logs.md)
      + [Bygg och driftsätt](./debugging/cloud-service/build-and-deployment.md)
      + [Developer Console](./debugging/cloud-service/developer-console.md)
      + [Databasläsare](./debugging/cloud-service/repository-browser.md)
      + Risker{#risks}
         + [Traversionsvarningar](./debugging/cloud-service/risks/traversals.md)
+ Innehållsleverans{#content-delivery}
   + [URL-omdirigeringar](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/administration/url-redirection.html)
+ Åtkomst till AEM{#accessing}
   + [Översikt](./accessing/overview.md)
   + [Adobe IMS-användare](./accessing/adobe-ims-users.md)
   + [Adobe IMS-användargrupper](./accessing/adobe-ims-user-groups.md)
   + [Produktprofiler för Adobe IMS](./accessing/adobe-ims-product-profiles.md)
   + [AEM användare, grupper och behörigheter](./accessing/aem-users-groups-and-permissions.md)
   + [Konfigurera åtkomst till AEM genomgång](./accessing/walk-through.md)
+ Autentisering{#authentication}
   + [Översikt](./authentication/authentication.md)
   + [SAML 2.0](./authentication/saml-2-0.md)
+ Avancerat nätverksbyggande{#networking}
   + [Översikt](./networking/advanced-networking.md)
   + [Flexibel portutgång](./networking/flexible-port-egress.md)
   + [Dedikerad IP-adress för utgångar](./networking/dedicated-egress-ip-address.md)
   + [Virtuellt privat nätverk](./networking/vpn.md)
   + Exempel på koder{#examples}
      + [HTTP/HTTPS på portar som inte är standard för flexibel portutgång](./networking/examples/http-on-non-standard-ports-flexible-port-egress.md)
      + [HTTP/HTTPS för dedikerad IP-adress/VPN](./networking/examples/http-dedicated-egress-ip-vpn.md)
      + [SQL-anslutningar med DataSourcePool](./networking/examples/sql-datasourcepool.md)
      + [SQL-anslutningar med Java SQL API:er](./networking/examples/sql-java-apis.md)
      + [E-posttjänst](./networking/examples/email-service.md)
+ Migrering {#migration}
   + [Content Transfer Tool](./migration/content-transfer-tool.md)
   + [Massimport av resurser](./migration/bulk-import.md)
   + Flytta till AEM as a Cloud Service {#moving-to-aem-as-a-cloud-service}
      + [Introduktion](./migration/moving-to-aem-as-a-cloud-service/introduction.md)
      + [Onboarding](./migration/moving-to-aem-as-a-cloud-service/onboarding.md)
      + [Cloud Manager](./migration/moving-to-aem-as-a-cloud-service/cloud-manager.md)
      + [BPA och CAM](./migration/moving-to-aem-as-a-cloud-service/bpa-and-cam.md)
      + [Verktyg för AEM](./migration/moving-to-aem-as-a-cloud-service/aem-modernization-tools.md)
      + [Databasmodernisering](./migration/moving-to-aem-as-a-cloud-service/repository-modernization.md)
      + [asset compute Microservices](./migration/moving-to-aem-as-a-cloud-service/asset-compute-microservices.md)
      + [Dispatcher](./migration/moving-to-aem-as-a-cloud-service/dispatcher.md)
      + [Sökning och indexering](./migration/moving-to-aem-as-a-cloud-service/search-and-indexing.md)
      + Innehållsmigrering {#content-migration}
         + [Massimporttjänst](./migration/moving-to-aem-as-a-cloud-service/content-migration/bulk-import-service.md)
         + [Content Transfer Tool](./migration/moving-to-aem-as-a-cloud-service/content-migration/content-transfer-tool.md)
         + [Vanliga frågor](./migration/moving-to-aem-as-a-cloud-service/content-migration/faq.md)
      + [Felsökning](./migration/moving-to-aem-as-a-cloud-service/troubleshooting.md)
      + AEM Forms as a Cloud Service {#aem-forms}
         + [Introduktion](./migration/moving-to-aem-as-a-cloud-service/aem-forms/introduction.md)
         + [Digital registrering](./migration/moving-to-aem-as-a-cloud-service/aem-forms/digital-enrollment.md)
         + [Kommunikation](./migration/moving-to-aem-as-a-cloud-service/aem-forms/communications.md)
   + Cloud Acceleration Manager {#cloud-acceleration-manager}
      + [Introduktion](./migration/cloud-acceleration-manager/introduction.md)
      + [Analysera beredskap och bästa praxis](./migration/cloud-acceleration-manager/readiness-and-best-practice-analyzer.md)
      + [Implementeringsfas](./migration/cloud-acceleration-manager/implementation-phase.md)
      + [Content Transfer Tool](./migration/cloud-acceleration-manager/content-transfer-tool.md)
      + [Kodomfaktoriseringsverktyg](./migration/cloud-acceleration-manager/code-refactoring-tools.md)
      + [Koddatabasmodernizer](./migration/cloud-acceleration-manager/code-repository-modernizer.md)
      + [Dispatcher Converter](./migration/cloud-acceleration-manager/dispatcher-converter.md)
      + [Indexkonverterare](./migration/cloud-acceleration-manager/index-converter.md)
      + [Verktyg för resursarbetsflödesmigrering](./migration/cloud-acceleration-manager/asset-workflow-migration-tool.md)
      + [Navigera i molnaccelerationshanteraren](./migration/cloud-acceleration-manager/navigating.md)
      + [Använda Cloud Acceleration Manager](./migration/cloud-acceleration-manager/using.md)
+ Forms{#forms}
   + Developing for Forms as a Cloud Service{#developing-for-cloud-service}
      + [Komma igång](./forms/developing-for-cloud-service/getting-started.md)
      + [Installera IntelliJ](./forms/developing-for-cloud-service/intellij-set-up.md)
      + [Konfigurera Git](./forms/developing-for-cloud-service/setup-git.md)
      + [Synkronisera IntelliJ med AEM](./forms/developing-for-cloud-service/intellij-and-aem-sync.md)
      + [Skapa ett formulär](./forms/developing-for-cloud-service/deploy-your-first-form.md)
      + [Aktivera Forms Portal-komponenter](./forms/developing-for-cloud-service/forms-portal-components.md)
      + [Inkludera Cloud Services och FDM](./forms/developing-for-cloud-service/azure-storage-fdm.md)
      + [Kontextmedveten molnkonfiguration](./forms/developing-for-cloud-service/context-aware-fdm.md)
      + [Push to Cloud Manager](./forms/developing-for-cloud-service/push-project-to-cloud-manager-git.md)
      + [Distribuera till utvecklingsmiljö](./forms/developing-for-cloud-service/deploy-to-dev-environment.md)
      + [Uppdaterar makarnas arketype](./forms/developing-for-cloud-service/updating-project-archetype.md)
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
   + Skapa dokument i AEM Forms CS{#doc-gen-formscs}
      + [Introduktion](./forms/doc-gen-forms-cs/introduction.md)
      + [Skapa tjänstautentiseringsuppgifter](./forms/doc-gen-forms-cs/service-credentials.md)
      + [Skapa JWT-token](./forms/doc-gen-forms-cs/create-jwt.md)
      + [Skapa åtkomsttoken](./forms/doc-gen-forms-cs/create-access-token.md)
      + [Sammanfoga data med mall](./forms/doc-gen-forms-cs/merge-data-with-template.md)
      + [Testa lösningen](./forms/doc-gen-forms-cs/test.md)
      + [Utmaning](./forms/doc-gen-forms-cs/challenge.md)
   + Dokumentgenerering med hjälp av batch-API{#formscs-batch-api}
      + [Introduktion](./forms/formscs-batch-api/introduction.md)
      + [Konfigurera Azure Storage](./forms/formscs-batch-api/configure-azure-storage.md)
      + [Skapa USC-batchkonfiguration](./forms/formscs-batch-api/configure-usc-batch.md)
      + [Skapa batchkonfiguration](./forms/formscs-batch-api/create-batch-config.md)
      + [Kör grupp](./forms/formscs-batch-api/execute-batch-generate-documents.md)
   + manipulering av PDF i Forms CS{#forms-cs-assembler}
      + [Introduktion](./forms/forms-cs-assembler/introduction.md)
      + [Skapa tjänstautentiseringsuppgifter](./forms/forms-cs-assembler/service-credentials.md)
      + [Skapa JWT-token](./forms/forms-cs-assembler/create-jwt.md)
      + [Skapa åtkomsttoken](./forms/forms-cs-assembler/create-access-token.md)
      + [Sammanställ filer i PDF](./forms/forms-cs-assembler/assemble-pdf-files.md)
      + [PDF/A-verktyg](./forms/forms-cs-assembler/pdfa-utilities.md)
      + [Testa lösningen](./forms/forms-cs-assembler/test.md)
      + [Utmaning](./forms/forms-cs-assembler/challenge.md)
   + Azure Portal Storage{#forms-cs-azure-portal}
      + [Introduktion](./forms/forms-cs-azure-portal/introduction.md)
      + [Skapa formulärdatamodell](./forms/forms-cs-azure-portal/create-fdm.md)
      + [Lagra formulärdata i Azure Storage](./forms/forms-cs-azure-portal/create-af.md)
      + [Förifyll formulär](./forms/forms-cs-azure-portal/prefill-af-storage.md)
      + [Skicka frågor](./forms/forms-cs-azure-portal/query-submitted-data.md)
   + Skapa granskningsarbetsflöde{#create-aem-workflow}
      + [Extern arbetsflödeslagring](./forms/create-aem-workflow/externalize-workflow.md)
      + [Skapa arbetsflödesmodell](./forms/create-aem-workflow/create-workflow.md)
      + [Arbetsflöde för utlösare](./forms/create-aem-workflow/configure-af.md)
   + Acrobat Sign med AEM Forms{#forms-and-sign}
      + [Introduktion](./forms/forms-and-sign/introduction.md)
      + [Acrobat Sign API-program](./forms/forms-and-sign/create-sign-api-application.md)
      + [Konfiguration av Acrobat Sign Cloud](./forms/forms-and-sign/create-adobe-sign-cloud-configuration.md)
      + [Skapa anpassat formulär](./forms/forms-and-sign/create-adaptive-form.md)
      + [Konfigurera för fyllning och signering](./forms/forms-and-sign/configure-form-fill-and-sign.md)
   + Integrera med Microsoft Power Automate{#forms-cs-and-power-automate}
      + [Konfigurera integreringen](./forms/forms-cs-and-power-automate/integrate-formscs-power-automate.md)
      + [Tolka skickade formulärdata](./forms/forms-cs-and-power-automate/send-email-notification.md)
      + [Skicka DoR som e-postbilaga](./forms/forms-cs-and-power-automate/send-dor-email-attachment.md)
      + [Extrahera formulärbilagor från inskickade data](./forms/forms-cs-and-power-automate/send-af-attachments-in-email.md)
   + Integrera med Microsoft Dynamics{#formscs-dynamics-crm}
      + [Skapa Dynamics-program](./forms/formscs-dynamics-crm/create-dynamics-account.md)
      + [Konfigurera datakälla](./forms/formscs-dynamics-crm/configure-odata-data-source.md)
      + [Skapa formulärdatamodell](./forms/formscs-dynamics-crm/create-form-data-model.md)
      + [Skapa anpassat formulär](./forms/formscs-dynamics-crm/create-adaptive-form.md)
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
      + [App Builder](./asset-compute/set-up/app-builder.md)
   + Utveckla{#develop}
      + [Skapa ett Asset compute-projekt](./asset-compute/develop/project.md)
      + [Konfigurera miljövariabler](./asset-compute/develop/environment-variables.md)
      + [Konfigurera manifest.yml](./asset-compute/develop/manifest.md)
      + [Utveckla en arbetare](./asset-compute/develop/worker.md)
      + [Använda utvecklingsverktyget](./asset-compute/develop/development-tool.md)
   + Testa och felsöka{#test-debug}
      + [Testa en arbetare](./asset-compute/test-debug/test.md)
      + [Felsöka en arbetare](./asset-compute/test-debug/debug.md)
   + Distribuera{#deploy}
      + [Distribuera till Adobe I/O Runtime](./asset-compute/deploy/runtime.md)
      + [Integrera med AEM](./asset-compute/deploy/processing-profiles.md)
   + Avancerat{#advanced}
      + [Metadataarbetare](./asset-compute/advanced/metadata.md)
   + [Felsökning](./asset-compute/troubleshooting.md)
+ Cloud 5{#cloud-5}
   + [Introduktion](./cloud-5/cloud5-introduction.md)
   + [Säsong 1](./cloud-5/cloud5-season-1.md)
   + [Säsong 2](./cloud-5/cloud5-season-2.md)
   + [AEM CDN del 1](./cloud-5/cloud5-aem-cdn-part1.md)
   + [AEM CDN del 2](./cloud-5/cloud5-aem-cdn-part2.md)
   + [AEM loggfiler](./cloud-5/cloud5-aem-log-files.md)
   + [Inloggningstoken](./cloud-5/cloud5-getting-login-token-integrations.md)
   + [Cloud Dispatcher](./cloud-5/cloud5-aem-dispatcher-cloud.md)
   + [Migrering 1](./cloud-5/cloud5-aem-content-migration-part-1.md)
   + [Migrering 2](./cloud-5/cloud5-aem-content-migration-part-2.md)
   + [Dispatcher Validator](./cloud-5/cloud5-aem-dispatcher-validator.md)
   + [Sökning och indexering](./cloud-5/cloud5-aem-search-and-indexing.md)
   + [Adobe App Builder](./cloud-5/cloud5-adobe-app-builder.md)
   + Säsong 2{#season-2}
      + [Fragment](./cloud-5/season-2/cloud5-experience-v-content-fragments.md)
      + [Repo Modernizer](./cloud-5/season-2/cloud5-repo-modernizer.md)
      + [Admin Console](./cloud-5/season-2/cloud5-admin-console.md)
      + [ÅTERSTÄLL](./cloud-5/season-2/cloud5-repoinit.md)
      + [Sling Job Scheduler](./cloud-5/season-2/cloud5-sling-job-scheduler.md)
      + [Korrigera din cache](./cloud-5/season-2/cloud5-fix-your-cache.md)
      + [Korrigera återskrivningar](./cloud-5/season-2/cloud5-fix-your-rewrites.md)
      + [Cloud Manager - Experience Audit](./cloud-5/season-2/cloud5-mocm-experience-audit.md)
      + [Cloud Manager - enhetstester](./cloud-5/season-2/cloud5-mocm-unit-tests.md)
      + [Cloud Manager - funktionstester](./cloud-5/season-2/cloud5-mocm-functional-tests.md)
+ [AEM Experts Series](./aem-experts-series.md)
+ Tutorials i flera steg{#multi-step-tutorials}
   + [Utveckling av AEM Sites](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html)
   + [GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html)
   + [SPA Editor (React)](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-react-tutorial/overview.html)
   + [AEM Sites och Adobe Target](https://experienceleague.adobe.com/docs/experience-manager-learn/aem-target-tutorial/overview.html)
   + [Tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html)
