---
user-guide-title: Självstudiekurser om Adobe Experience Manager as a Cloud Service
user-guide-description: En samling självstudiekurser om Adobe Experience Manager as a Cloud Service.
breadcrumb-title: Självstudiekurser om AEM as a Cloud Service
solution: Experience Manager, Experience Manager as a Cloud Service
sub-product: Experience Manager as a Cloud Service
version: Experience Manager as a Cloud Service
team: TM
source-git-commit: c367564acb6465d5f203e5db943c5470607b63c9
workflow-type: tm+mt
source-wordcount: '1412'
ht-degree: 4%

---


# Självstudiekurser om Adobe Experience Manager as a Cloud Service {#cloud-service}

+ [Ökning](./overview.md)
+ AEM testversioner {#aem-trials}
   + [Bilder](./aem-trials/images.md)
+ Spellistor{#playlists}
   + [Utveckling av AEM](./playlists/development.md)
+ Introduktion till AEM as a Cloud Service{#introduction}
   + [Vad är AEM as a Cloud Service?](./introduction/what-is-aem-as-a-cloud-service.md)
   + [Arkitektur](./introduction/architecture.md)
   + [Cloud Manager](./introduction/cloud-manager.md)
   + Strategi och tankeledarskap{#strategy}
      + [Experience Manager - Styrnings- och personalmodeller och arkitekter](./introduction/experience-manager-governance-and-staffing-models.md)
+ [Experience Hub](./experience-hub.md)
+ [AEM AI Assistant](./aem-ai-assisstant.md)
+ Experience Cloud-integreringar{#integrations}
   + [Integreringar](./integrations/experience-cloud.md)
   + [AEM Headless och Target](./integrations/target.md)
+ Underliggande teknik {#underlying-technology}
   + [AEM Architecture](./underlying-technology/introduction-architecture.md)
   + [OSGi](./underlying-technology/introduction-osgi.md)
   + [Java Content Repository](./underlying-technology/introduction-jcr.md)
   + [Sling](./underlying-technology/introduction-sling.md)
   + [Författare och publiceringstjänster](./underlying-technology/introduction-author-publish.md)
   + [Dispatcher](./underlying-technology/introduction-dispatcher.md)
+ Edge Delivery Services {#edge-delivery-services}
   + [AEM Assets Sidekick-plugin](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/edge-delivery-services/sidekick-plugin.html?lang=sv-SE){target=_blank}
+ Cloud Manager {#cloud-manager}
   + [Program](./cloud-manager/programs.md)
   + [Miljö](./cloud-manager/environments.md)
   + [Använda en GitHub-databas](./cloud-manager/byogithub.md)
   + [CI/CD Production Pipeline](./cloud-manager/cicd-production-pipeline.md)
   + [CI/CD icke-produktionsförlopp](./cloud-manager/cicd-non-production-pipeline.md)
   + [Aktivitet](./cloud-manager/activity.md)
   + [Anpassade domännamn](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/content-delivery/custom-domain-names){target=_blank}
   + [Innehållsåterställning](./cloud-manager/content-restore.md)
   + Dev Ops{#devops}
      + [Distribuera kod](./cloud-manager/devops/deploy-code.md)
      + [Sammanfoga projekt](./cloud-manager/devops/merge-projects.md)
      + [Konfigurera pipelines](./cloud-manager/devops/configure-pipelines.md)
      + [Kontinuerlig integrering](./cloud-manager/devops/continuous-integration.md)
      + [Analysera testresultat](./cloud-manager/devops/analyze-test-results.md)
      + [Dispatcher Configurations](./cloud-manager/devops/dispatcher-configurations.md)
      + [CDN-logganalys](./cloud-manager/devops/cdn-log-analysis.md)
+ Installation av lokal utvecklingsmiljö {#local-development-environment-set-up}
   + [Ökning](./local-development-environment/overview.md)
   + [Utvecklingsverktyg](./local-development-environment/development-tools.md)
   + [Lokal AEM SDK](./local-development-environment/aem-runtime.md)
   + [Dispatcher verktyg lokalt](./local-development-environment/dispatcher-tools.md)
+ Utvecklar{#developing}
   + Utbyggbarhet{#extensibility}
      + App Builder{#app-builder}
         + [Generera JWT-åtkomsttoken](./developing/extensibility/app-builder/jwt-auth.md)
         + [Generera åtkomsttoken för server-till-server](./developing/extensibility/app-builder/server-to-server-auth.md)
         + [Verifiering av Github-webkrok](./developing/extensibility/app-builder/github-webhook-verification.md)
      + Utbyggbarhet för användargränssnitt{#ui}
         + [Ökning](./developing/extensibility/ui/overview.md)
         + [Adobe Developer Console Project](./developing/extensibility/ui/adobe-developer-console-project.md)
         + [Initiera app](./developing/extensibility/ui/app-initialization.md)
         + [Registrera tillägg](./developing/extensibility/ui/extension-registration.md)
         + [Modal](./developing/extensibility/ui/modal.md)
         + [Adobe I/O Runtime Action](./developing/extensibility/ui/runtime-action.md)
         + [Verifiera](./developing/extensibility/ui/verify.md)
         + [Distribuera](./developing/extensibility/ui/deploy.md)
         + Innehållsfragment{#content-fragments}
            + [Ökning](./developing/extensibility/ui/content-fragments/overview.md)
            + Exempel{#examples}
               + [Generering av AI-bilder](./developing/extensibility/ui/content-fragments/examples/console-image-generation-and-image-upload.md)
               + [Uppdatering av massegenskap](./developing/extensibility/ui/content-fragments/examples/console-bulk-property-update.md)
               + [Kolumner för anpassat stödraster](./developing/extensibility/ui/content-fragments/examples/custom-grid-columns.md)
               + [Exportera som XML](./developing/extensibility/ui/content-fragments/examples/editor-export-to-xml.md)
               + [Verktygsfältsknapp för textredigering](./developing/extensibility/ui/content-fragments/examples/editor-rte-toolbar.md)
               + [RTE-widgetar](./developing/extensibility/ui/content-fragments/examples/editor-rte-widget.md)
               + [RTE-märken](./developing/extensibility/ui/content-fragments/examples/editor-rte-badges.md)
               + [Anpassade fält](./developing/extensibility/ui/content-fragments/examples/editor-custom-field.md)
   + Grundläggande om utveckling{#basics}
      + [AEM SDK](./developing/basics/aem-sdk.md)
      + [Lokal utvecklingsmiljö](./developing/basics/local-development-environment.md)
      + [AEM Project Archetype](./developing/basics/aem-project-archetype.md)
      + [AEM projektstruktur](./developing/basics/project-structure.md)
      + [Mutable vs. Immutable Content](./developing/basics/mutable-immutable.md)
      + [Databasstrukturpaket](./developing/basics/repository-structure-package.md)
      + [Content Publishing](./developing/basics/content-publishing.md)
      + [OSGi-konfigurationer](./developing/basics/osgi-configurations.md)
      + [Migrering av Dispatcher-konfiguration](./developing/basics/dispatcher-configuration.md)
   + AEM Projects{#aem-projects}
      + [AEM Maven Project](./developing/projects/maven-project-structure.md)
      + [Rensa ett AEM Maven Project](./developing/projects/remove-samples.md)
   + OSGi Services{#osgi-services}
      + [OSGi Service Basics](./developing/osgi-services/basics.md)
      + [OSGi Component Lifecycle](./developing/osgi-services/lifecycle.md)
      + [Grundläggande om OSGi-konfigurationer](./developing/osgi-services/configurations.md)
      + [OSGi-konfigurationer med OCD](./developing/osgi-services/configurations-ocd.md)
   + Avancerat{#advanced}
      + [Cachelagrar sidvarianter](./developing/advanced/variant-caching.md)
      + [CSRF-skydd](./developing/advanced/csrf-protection.md)
      + [Anpassade namnutrymmen](./developing/advanced/custom-namespaces.md)
      + [Parametrisera segmenteringsmodeller från HTML](./developing/advanced/sling-model-parameters.md)
      + [Hemligheter](./developing/advanced/secrets.md)
      + [Tjänstanvändare](./developing/advanced/service-users.md)
      + [Webboptimerade bild-API:er](./developing/advanced/web-optimized-image-delivery-java-apis.md)
      + [Kör jobb på ledarinstans i AEM Author](./developing/advanced/run-job-on-leader-instance-in-aem-author.md)
   + Rapid Development Environment{#rde}
      + [Ökning](./developing/rde/overview.md)
      + [Så här konfigurerar du](./developing/rde/how-to-setup.md)
      + [Så här använder du](./developing/rde/how-to-use.md)
      + [Utveckling/livscykeln](./developing/rde/development-life-cycle.md)
   + Universal Editor{#universal-editor}
      + Redigera appar{#react-app-editing}
         + [Ökning](./developing/universal-editor/react-app/overview.md)
         + [Lokal utvecklingskonfiguration](./developing/universal-editor/react-app/local-development-setup.md)
         + [Instrument React App](./developing/universal-editor/react-app/instrument-to-edit-content.md)
   + [AEM SDK API JavaDocs](https://javadoc.io/doc/com.adobe.aem/aem-sdk-api/latest/index.html){target=_blank}
+ Felsöka AEM{#debugging}
   + Felsöka AEM SDK{#debugging-aem-sdk}
      + [Ökning](./debugging/aem-sdk-local-quickstart/overview.md)
      + [Loggar](./debugging/aem-sdk-local-quickstart/logs.md)
      + [Fjärrfelsökning](./debugging/aem-sdk-local-quickstart/remote-debugging.md)
      + [OSGi-webbkonsol](./debugging/aem-sdk-local-quickstart/osgi-web-consoles.md)
      + [Dispatcher Tools](./debugging/aem-sdk-local-quickstart/dispatcher-tools.md)
      + [Andra verktyg](./debugging/aem-sdk-local-quickstart/other-tools.md)
   + Felsöka AEM as a Cloud Service{#debugging-aem-as-a-cloud-service}
      + [Ökning](./debugging/cloud-service/overview.md)
      + [Loggar](./debugging/cloud-service/logs.md)
      + [Bygg och driftsätt](./debugging/cloud-service/build-and-deployment.md)
      + [Developer Console](./debugging/cloud-service/developer-console.md)
      + [Databasläsare](./debugging/cloud-service/repository-browser.md)
      + Risker{#risks}
         + [Traversal-varningar](./debugging/cloud-service/risks/traversals.md)
+ Personalization {#personalization}
   + [Ökning](./personalization/overview.md)
   + Inställningar{#setup}
      + [Integrera Adobe Target](./personalization/setup/integrate-adobe-target.md)
      + [Integrera taggar](./personalization/setup/integrate-adobe-tags.md)
   + Användningsexempel {#use-cases}
      + [Experimentation (A/B-testning)](./personalization/use-cases/experimentation.md)
      + [Beteendeanpassning](./personalization/use-cases/behavioral-targeting.md)
      + [Kända Personalization](./personalization/use-cases/known-user-personalization.md)
+ AEM API:er{#aem-apis}
   + [Ökning](./apis/overview.md)
   + OpenAPI:er{#openapis}
      + [Ökning](./apis/openapis/overview.md)
      + [Så här konfigurerar du](./apis/openapis/setup.md)
      + [Server-till-server-autentisering](./apis/openapis/use-cases/invoke-api-using-oauth-s2s.md)
      + [Användarautentisering (webbprogram)](./apis/openapis/use-cases/invoke-api-using-oauth-web-app.md)
      + [Användarautentisering (SPA)](./apis/openapis/use-cases/invoke-api-using-oauth-single-page-app.md)
      + Så här gör du{#how-to}
         + [Autentiseringsuppgifter och hantering av produktprofiler](./apis/openapis/how-to/credentials-and-product-profile-management.md)
         + [Behörighetshantering](./apis/openapis/how-to/services-user-group-permission-management.md)
+ Innehållsleverans{#content-delivery}
   + [Anpassat domännamn](./content-delivery/custom-domain-names.md)
   + [Anpassat domännamn med Adobe hanterat CDN](./content-delivery/custom-domain-name-with-adobe-managed-cdn.md)
   + [Anpassat domännamn med kundens CDN](./content-delivery/custom-domain-names-with-customer-managed-cdn.md)
   + [Cachelagring](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/caching/overview){target=_blank}
   + [Adobe CDN - bortom cachelagring](./content-delivery/adobe-cdn-beyond-caching.md)
   + [Anpassade felsidor](./content-delivery/custom-error-pages.md)
   + [URL-omdirigeringar](https://experienceleague.adobe.com/docs/experience-manager-learn/foundation/administration/url-redirection.html?lang=sv-SE){target=_blank}
+ Cachning{#caching}
   + [Ökning](./caching/overview.md)
   + [AEM Publish Service](./caching/publish.md)
   + [AEM Author Service](./caching/author.md)
   + [Analys av träffar i CDN-cache](./caching/cdn-cache-hit-ratio-analysis.md)
   + Så här gör du{#how-to}
      + [Aktivera cachelagring](./caching/how-to/enable-caching.md)
      + [Inaktivera cachelagring](./caching/how-to/disable-caching.md)
      + [Rensa cache](./caching/how-to/purge-cache.md)
+ Åtkomst till AEM{#accessing}
   + [Ökning](./accessing/overview.md)
   + [Adobe IMS-användare](./accessing/adobe-ims-users.md)
   + [Adobe IMS-användargrupper](./accessing/adobe-ims-user-groups.md)
   + [Produktprofiler för Adobe IMS](./accessing/adobe-ims-product-profiles.md)
   + [AEM användare, grupper och behörigheter](./accessing/aem-users-groups-and-permissions.md)
   + [Konfigurera åtkomst till AEM genomgång](./accessing/walk-through.md)
+ Autentisering{#authentication}
   + [Ökning](./authentication/authentication.md)
   + [SAML 2.0](./authentication/saml-2-0.md)
+ Avancerat nätverksbyggande{#networking}
   + [Ökning](./networking/advanced-networking.md)
   + [Flexibel portutgång](./networking/flexible-port-egress.md)
   + [Dedikerad IP-adress för utgångar](./networking/dedicated-egress-ip-address.md)
   + [Virtuellt privat nätverk](./networking/vpn.md)
   + Exempel på koder{#examples}
      + [HTTP/HTTPS på portar som inte är standard för flexibel portutgång](./networking/examples/http-on-non-standard-ports-flexible-port-egress.md)
      + [HTTP/HTTPS för dedikerad IP-adress/VPN](./networking/examples/http-dedicated-egress-ip-vpn.md)
      + [SQL-anslutningar med DataSourcePool](./networking/examples/sql-datasourcepool.md)
      + [SQL-anslutningar med Java SQL API:er](./networking/examples/sql-java-apis.md)
      + [E-posttjänst](./networking/examples/email-service.md)
+ Dokumentskydd {#security}
   + [Blockera DoS/DDoS-attacker med trafikfilterregler](./security/blocking-dos-attack-using-traffic-filter-rules.md)
   + Trafikfilterregler inklusive WAF-regler {#traffic-filter-and-waf-rules}
      + [Skydda AEM webbplatser](./security/traffic-filter-and-waf-rules/overview.md)
      + [Så här konfigurerar du](./security/traffic-filter-and-waf-rules/setup.md)
      + [Använda trafikfilterregler](./security/traffic-filter-and-waf-rules/use-cases/using-traffic-filter-rules.md)
      + [Använda WAF-regler](./security/traffic-filter-and-waf-rules/use-cases/using-waf-rules.md)
      + [God praxis](./security/traffic-filter-and-waf-rules/best-practices.md)
      + Så här gör du{#how-to}
         + [Övervaka känsliga begäranden](./security/traffic-filter-and-waf-rules/how-to/request-logging.md)
         + [Begränsa åtkomst](./security/traffic-filter-and-waf-rules/how-to/request-blocking.md)
         + [Normalisera begäranden](./security/traffic-filter-and-waf-rules/how-to/request-transformation.md)
+ AEM Eventing{#aem-eventing}
   + [Ökning](./eventing/overview.md)
   + Exempel{#examples}
      + [Webkrok - Ta emot AEM Events](./eventing/examples/webhook.md)
      + [Journalföring - Läs in AEM-händelser](./eventing/examples/journaling.md)
      + [Adobe I/O Runtime Action - Receive AEM Events](./eventing/examples/runtime-action.md)
      + [Adobe I/O Runtime-åtgärd - Bearbeta AEM-händelser](./eventing/examples/event-processing-using-runtime-action.md)
      + [AEM Assets Events - PIM-integrering](./eventing/examples/assets-pim-integration.md)
+ Migrering {#migration}
   + [Verktyget Innehållsöverföring](./migration/content-transfer-tool.md)
   + [Massimport av resurser](./migration/bulk-import.md)
   + Flyttar till AEM as a Cloud Service {#moving-to-aem-as-a-cloud-service}
      + [Introduktion](./migration/moving-to-aem-as-a-cloud-service/introduction.md)
      + [Onboarding](./migration/moving-to-aem-as-a-cloud-service/onboarding.md)
      + [Cloud Manager](./migration/moving-to-aem-as-a-cloud-service/cloud-manager.md)
      + [BPA och CAM](./migration/moving-to-aem-as-a-cloud-service/bpa-and-cam.md)
      + [AEM moderniseringsverktyg](./migration/moving-to-aem-as-a-cloud-service/aem-modernization-tools.md)
      + [Databasmodernisering](./migration/moving-to-aem-as-a-cloud-service/repository-modernization.md)
      + [Asset Compute Microservices](./migration/moving-to-aem-as-a-cloud-service/asset-compute-microservices.md)
      + [Dispatcher](./migration/moving-to-aem-as-a-cloud-service/dispatcher.md)
      + [Sökning och indexering](./migration/moving-to-aem-as-a-cloud-service/search-and-indexing.md)
      + Innehållsmigrering {#content-migration}
         + [Massimporttjänst](./migration/moving-to-aem-as-a-cloud-service/content-migration/bulk-import-service.md)
         + [Verktyget Innehållsöverföring](./migration/moving-to-aem-as-a-cloud-service/content-migration/content-transfer-tool.md)
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
      + [Kodomfaktoriseringsverktyg](./migration/cloud-acceleration-manager/code-refactoring-tools.md)
      + [Koddatabasmodernizer](./migration/cloud-acceleration-manager/code-repository-modernizer.md)
      + [Dispatcher Converter](./migration/cloud-acceleration-manager/dispatcher-converter.md)
      + [Indexkonverterare](./migration/cloud-acceleration-manager/index-converter.md)
      + [Verktyg för resursarbetsflödesmigrering](./migration/cloud-acceleration-manager/asset-workflow-migration-tool.md)
      + [Navigera i Cloud Acceleration Manager](./migration/cloud-acceleration-manager/navigating.md)
      + [Använda Cloud Acceleration Manager](./migration/cloud-acceleration-manager/using.md)
+ [Innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-learn/content-fragments-console/overview.html?lang=sv-SE){target=_blank}
+ Forms{#forms}
   + Utveckla för Forms as a Cloud Service{#developing-for-cloud-service}
      + [1 - Komma igång](./forms/developing-for-cloud-service/getting-started.md)
      + [2 - Installera IntelliJ](./forms/developing-for-cloud-service/intellij-set-up.md)
      + [3 - Konfigurera Git](./forms/developing-for-cloud-service/setup-git.md)
      + [4 - Sync IntelliJ med AEM](./forms/developing-for-cloud-service/intellij-and-aem-sync.md)
      + [5 - Skapa ett formulär](./forms/developing-for-cloud-service/deploy-your-first-form.md)
      + [6 - Anpassad överföringshanterare](./forms/developing-for-cloud-service/custom-submit-to-servlet.md)
      + [7 - Registrerar serverutrymmet med resurstyp](./forms/developing-for-cloud-service/registering-servlet-using-resourcetype.md)
      + [8 - Aktivera Forms Portal-komponenter](./forms/developing-for-cloud-service/forms-portal-components.md)
      + [9 - Inkludera molntjänster och FDM](./forms/developing-for-cloud-service/azure-storage-fdm.md)
      + [10 - Kontextmedveten molnkonfiguration](./forms/developing-for-cloud-service/context-aware-fdm.md)
      + [11 - Skicka till Cloud Manager](./forms/developing-for-cloud-service/push-project-to-cloud-manager-git.md)
      + [12 - Distribuera till utvecklingsmiljö](./forms/developing-for-cloud-service/deploy-to-dev-environment.md)
      + [13 - Uppdaterar maven-arketype](./forms/developing-for-cloud-service/updating-project-archetype.md)
   + Skapa anpassat formulär{#create-first-af}
      + [Introduktion](./forms/create-first-af/introduction.md)
      + [Skapa tema](./forms/create-first-af/create-theme.md)
      + [Skapa mall](./forms/create-first-af/create-template.md)
      + [Skapa fragment](./forms/create-first-af/create-fragments.md)
      + [Skapa formulär](./forms/create-first-af/create-af.md)
      + [Konfigurera rotpanel](./forms/create-first-af/configure-root-panel.md)
      + [Konfigurera personpanel](./forms/create-first-af/configure-people-panel.md)
      + [Konfigurera inkomstpanel](./forms/create-first-af/configure-income-panel.md)
      + [Konfigurera resurspanelen](./forms/create-first-af/configure-assets-panel.md)
      + [Konfigurera startpanel](./forms/create-first-af/configure-start-panel.md)
      + [Verktygsfältet Lägg till och konfigurera](./forms/create-first-af/add-configure-toolbar.md)
   + Anpassad sändningstjänst med headless-formulär{#custom-submit-headless-forms}
      + [1 - Introduktion](./forms/custom-submit-headless-forms/introduction.md)
      + [2 - Skapa en anpassad skicka-tjänst](./forms/custom-submit-headless-forms/custom-submit-service.md)
      + [3 - Visa svaret](./forms/custom-submit-headless-forms/handle-response-react-app.md)
   + Skapa adressblockskomponent{#create-address-block}
      + [1 - Introduktion](./forms/create-address-block-component/introduction.md)
      + [2 - Inställningar](./forms/create-address-block-component/set-up.md)
      + [3 - Skapa komponent](./forms/create-address-block-component/creating-address-component.md)
      + [4 - Distribuera komponent](./forms/create-address-block-component/deploy-your-project.md)
   + Skapa klickbar bildkomponent{#clickable-image-component}
      + [1 - Introduktion](./forms/clickable-image-component/introduction.md)
      + [2 - Skapa komponent](./forms/clickable-image-component/create-component.md)
      + [3 - Hantera klickningshändelse](./forms/clickable-image-component/handle-click-event.md)
   + AEM Forms och Analytics{#forms-and-analytics}
      + [Introduktion](./forms/form-data-analytics/introduction.md)
      + [Skapa dataelement](./forms/form-data-analytics/data-elements.md)
      + [Skapa regler](./forms/form-data-analytics/rules.md)
      + [Testa lösningen](./forms/form-data-analytics/test.md)
   + Skapa nedrullningskomponent för länder{#countries-drop-down}
      + [Introduktion](./forms/countries-drop-down/introduction.md)
      + [Skapa komponent](./forms/countries-drop-down/component.md)
      + [Dialogrutan Skapa](./forms/countries-drop-down/dialog.md)
      + [Skapa segmentmodell](./forms/countries-drop-down/slingmodel.md)
      + [Bygg och testa](./forms/countries-drop-down/build.md)
   + Skapa knappvariationer{#style-system}
      + [Introduktion](./forms/style-system/introduction.md)
      + [Definiera princip](./forms/style-system/style-policy.md)
      + [Definiera variationer](./forms/style-system/create-variations.md)
      + [Testvariationer](./forms/style-system/build.md)
   + Använda lodräta tabbar{#using-vertical-tabs}
      + [&#x200B;1. Inledning](./forms/using-vertical-tabs/introduction.md)
      + [&#x200B;2. Skapa formulär](./forms/using-vertical-tabs/create-af.md)
      + [&#x200B;3. Navigera](./forms/using-vertical-tabs/navigation.md)
      + [&#x200B;4. Lägga till ikoner](./forms/using-vertical-tabs/icons.md)
   + Använda utdata och blanketttjänster{#forms-cs-output-and-forms-service}
      + [Generera PDF](./forms/forms-cs-output-and-forms-service/outputservice.md)
   + Skapa dokument i AEM Forms CS{#doc-gen-formscs}
      + [Introduktion](./forms/doc-gen-forms-cs/introduction.md)
      + [Skapa tjänstautentiseringsuppgifter](./forms/doc-gen-forms-cs/service-credentials.md)
      + [Skapa JWT-token](./forms/doc-gen-forms-cs/create-jwt.md)
      + [Skapa åtkomsttoken](./forms/doc-gen-forms-cs/create-access-token.md)
      + [Sammanfoga data med mall](./forms/doc-gen-forms-cs/merge-data-with-template.md)
      + [Testa lösningen](./forms/doc-gen-forms-cs/test.md)
      + [Utmaning](./forms/doc-gen-forms-cs/challenge.md)
   + Använda Forms Document Services API{#forms-document-services-api}
      + [Introduktion](./forms/forms-document-services/introduction.md)
      + [Konfigurera OpenAPI](./forms/forms-document-services/using-open-api.md)
      + [Generera åtkomsttoken](./forms/forms-document-services/generate-access-token.md)
      + [Använd användningsbehörighet](./forms/forms-document-services/make-api-calls.md)
      + [Exempelkod](./forms/forms-document-services/sample-project.md)
   + Dokumentgenerering med hjälp av batch-API{#formscs-batch-api}
      + [Introduktion](./forms/formscs-batch-api/introduction.md)
      + [Konfigurera Azure Storage](./forms/formscs-batch-api/configure-azure-storage.md)
      + [Skapa USC-batchkonfiguration](./forms/formscs-batch-api/configure-usc-batch.md)
      + [Skapa batchkonfiguration](./forms/formscs-batch-api/create-batch-config.md)
      + [Kör grupp](./forms/formscs-batch-api/execute-batch-generate-documents.md)
   + PDF Manipulation in Forms CS{#forms-cs-assembler}
      + [Introduktion](./forms/forms-cs-assembler/introduction.md)
      + [Skapa tjänstautentiseringsuppgifter](./forms/forms-cs-assembler/service-credentials.md)
      + [Skapa JWT-token](./forms/forms-cs-assembler/create-jwt.md)
      + [Skapa åtkomsttoken](./forms/forms-cs-assembler/create-access-token.md)
      + [Sammanställ PDF-filer](./forms/forms-cs-assembler/assemble-pdf-files.md)
      + [PDF/A Utilities](./forms/forms-cs-assembler/pdfa-utilities.md)
      + [Testa lösningen](./forms/forms-cs-assembler/test.md)
      + [Utmaning](./forms/forms-cs-assembler/challenge.md)
   + Lagra formuläröverföringar med blobindextaggar{#store-submiited-data-with-metadata-tags}
      + [Introduktion](./forms/store-submiited-data-with-metadata-tags/introduction.md)
      + [Utöka alternativgruppskomponent](./forms/store-submiited-data-with-metadata-tags/extend-choice-group-components.md)
      + [Skapa OSGi-konfiguration](./forms/store-submiited-data-with-metadata-tags/create-osgi-configuration.md)
      + [Skapa indexmärkord](./forms/store-submiited-data-with-metadata-tags/create-blob-index-tags.md)
      + [Skapa anpassad sändning](./forms/store-submiited-data-with-metadata-tags/create-custom-submit.md)
   + Komponentbaserad blankett för förifyllning{#prefill-core-component-based-form}
      + [Introduktion](./forms/prefill-core-component-form/introduction.md)
      + [Skriva förifyllningstjänst](./forms/prefill-core-component-form/pre-fill-service.md)
      + [Testa lösningen](./forms/prefill-core-component-form/test-solution.md)
   + Azure Portal Storage{#forms-cs-azure-portal}
      + [Introduktion](./forms/forms-cs-azure-portal/introduction.md)
      + [Skapa formulärdatamodell](./forms/forms-cs-azure-portal/create-fdm.md)
      + [Lagra formulärdata i Azure Storage](./forms/forms-cs-azure-portal/create-af.md)
      + [Förifyll formulär](./forms/forms-cs-azure-portal/prefill-af-storage.md)
      + [Frågeöverföringar](./forms/forms-cs-azure-portal/query-submitted-data.md)
   + Spara och återuppta ifyllning av formulär{#prefill-azure-storage}
      + [1 - Introduktion](./forms/prefill-azure-storage/introduction.md)
      + [2- komponenten Skapa sida](./forms/prefill-azure-storage/page-component.md)
      + [3- Skapa adaptiv formulärmall](./forms/prefill-azure-storage/associate-page-component.md)
      + [4- Skapa integrering med Azure Storage](./forms/prefill-azure-storage/create-fdm.md)
      + [5 - Skapa integration med SendGrid](./forms/prefill-azure-storage/send-grid-fdm.md)
      + [6 - Skapa det adaptiva formuläret](./forms/prefill-azure-storage/create-af.md)
      + [7 - Distribuera exempelresurserna](./forms/prefill-azure-storage/deploy-sample-assets.md)

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
      + [Konfigurera Source](./forms/formscs-dynamics-crm/configure-odata-data-source.md)
      + [Skapa formulärdatamodell](./forms/formscs-dynamics-crm/create-form-data-model.md)
      + [Skapa anpassat formulär](./forms/formscs-dynamics-crm/create-adaptive-form.md)
   + Integrera med Salesforce{#integrate-with-salesforce}
      + [Introduktion](./forms/integrate-with-salesforce/introduction.md)
      + [Skapa ansluten app](./forms/integrate-with-salesforce/create-connected-app.md)
      + [Skapa swagger-fil](./forms/integrate-with-salesforce/describe-rest-api.md)
      + [Skapa datakälla](./forms/integrate-with-salesforce/create-data-source.md)
      + [Skapa formulärdatamodell](./forms/integrate-with-salesforce/create-form-data-model.md)
      + [Testa formulärinlämning](./forms/integrate-with-salesforce/create-lead-submitting-form.md)
      + [Test click-händelse](./forms/integrate-with-salesforce/create-lead-click-event.md)
   + Spara formulärinskick i en och samma enhet{#one-drive}
      + [Lagra formulärdata på en enhet](./forms/forms-cs-one-drive/store-form-submission-one-drive.md)
      + [Lagra formulärdata i SharePoint](./forms/forms-cs-sharepoint/store-form-submission-in-sharepoint.md)
      + [Fyll i formulär i förväg med data från SharePoint-listan](./forms/forms-cs-sharepoint/prefill-data-from-sharepoint-list.md)
      + [Infoga data i SharePoint-listan med hjälp av arbetsflöde](./forms/forms-cs-sharepoint/submit-data-sharepoint-list-workflow.md)
+ Asset Compute Extensibility{#asset-compute}
   + [Ökning](./asset-compute/overview.md)
   + Konfigurera{#set-up}
      + [Konto- och tjänsteetablering](./asset-compute/set-up/accounts-and-services.md)
      + [Lokal utvecklingsmiljö](./asset-compute/set-up/development-environment.md)
      + [App Builder](./asset-compute/set-up/app-builder.md)
   + Utveckla{#develop}
      + [Skapa ett Asset Compute-projekt](./asset-compute/develop/project.md)
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

+ Självstudiekurser i flera steg{#multi-step-tutorials}
   + [AEM Sites-utveckling](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/overview.html?lang=sv-SE){target=_blank}
   + [GraphQL](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/graphql/overview.html?lang=sv-SE){target=_blank}
   + [SPA Editor (React)](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-react-tutorial/overview.html){target=_blank}
   + [AEM Sites och Adobe Target](https://experienceleague.adobe.com/docs/experience-manager-learn/aem-target-tutorial/overview.html?lang=sv-SE){target=_blank}
   + [Tokenbaserad autentisering](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-with-aem-headless/authentication/overview.html?lang=sv-SE){target=_blank}
+ Expertresurser {#expert-resources}
   + AEM Champions {#aem-champions}
      + [Cloud Manager Onboarding Playbook](./expert-resources/aem-champions/onboarding-playbook.md)
      + [Cloud Manager miljötyper](./expert-resources/aem-champions/environment-types.md)
      + [Cloud Manager UI](./expert-resources/aem-champions/cloud-manager-ui.md)
   + [AEM Experts Series](./expert-resources/expert-series/aem-experts-series.md)
   + Cloud 5{#cloud-5}
      + [Introduktion](./expert-resources/cloud-5/cloud5-introduction.md)
      + [Säsong 4](./expert-resources/cloud-5/cloud5-season-4.md)
      + [Säsong 3](./expert-resources/cloud-5/cloud5-season-3.md)
      + [Säsong 2](./expert-resources/cloud-5/cloud5-season-2.md)
      + [Säsong 1](./expert-resources/cloud-5/cloud5-season-1.md)
      + [AEM CDN Part 1](./expert-resources/cloud-5/cloud5-aem-cdn-part1.md)
      + [AEM CDN Part 2](./expert-resources/cloud-5/cloud5-aem-cdn-part2.md)
      + [AEM loggfiler](./expert-resources/cloud-5/cloud5-aem-log-files.md)
      + [Inloggningstoken](./expert-resources/cloud-5/cloud5-getting-login-token-integrations.md)
      + [Cloud Dispatcher](./expert-resources/cloud-5/cloud5-aem-dispatcher-cloud.md)
      + [Migrering 1](./expert-resources/cloud-5/cloud5-aem-content-migration-part-1.md)
      + [Dispatcher Validator](./expert-resources/cloud-5/cloud5-aem-dispatcher-validator.md)
      + [Sökning och indexering](./expert-resources/cloud-5/cloud5-aem-search-and-indexing.md)
      + [Adobe App Builder](./expert-resources/cloud-5/cloud5-adobe-app-builder.md)
      + Säsong 2{#season-2}
         + [Fragment](./expert-resources/cloud-5/season-2/cloud5-experience-v-content-fragments.md)
         + [Repo Modernizer](./expert-resources/cloud-5/season-2/cloud5-repo-modernizer.md)
         + [Admin Console](./expert-resources/cloud-5/season-2/cloud5-admin-console.md)
         + [ÅTERSTÄLL](./expert-resources/cloud-5/season-2/cloud5-repoinit.md)
         + [Sling Job Scheduler](./expert-resources/cloud-5/season-2/cloud5-sling-job-scheduler.md)
         + [Korrigera din cache](./expert-resources/cloud-5/season-2/cloud5-fix-your-cache.md)
         + [Korrigera återskrivningar](./expert-resources/cloud-5/season-2/cloud5-fix-your-rewrites.md)
         + [Cloud Manager - Experience Audit](./expert-resources/cloud-5/season-2/cloud5-mocm-experience-audit.md)
         + [Cloud Manager - enhetstester](./expert-resources/cloud-5/season-2/cloud5-mocm-unit-tests.md)
         + [Cloud Manager - funktionstester](./expert-resources/cloud-5/season-2/cloud5-mocm-functional-tests.md)
      + Säsong 3{#season-3}
         + [Sökning från tredje part](./expert-resources/cloud-5/season-3/cloud5-3rd-party-search.md)
         + [Edge arbetare](./expert-resources/cloud-5/season-3/cloud5-edge-workers.md)
         + [Publicera, avpublicera händelser i Edge Delivery Services](./expert-resources/cloud-5/season-3/cloud5-publish-events.md)
         + [Frågeindex och Excel-formler](./expert-resources/cloud-5/season-3/cloud5-query-indexes.md)
         + [Använd ditt eget CloudFlex CDN](./expert-resources/cloud-5/season-3/cloud5-byo-cloudflare-cdn.md)
         + [Integrera AEM Assets](./expert-resources/cloud-5/season-3/cloud5-integrate-assets.md)
         + [Generativ AI för AEM Sites](./expert-resources/cloud-5/season-3/cloud5-generative-ai-for-aem-sites.md)
         + [Exploring Universal Editor](./expert-resources/cloud-5/season-3/cloud5-exploring-universal-editor.md)
         + [Importera platser](./expert-resources/cloud-5/season-3/cloud5-import-sites-to-edge-delivery-services.md)
         + [Använda Admin API](./expert-resources/cloud-5/season-3/cloud5-using-admin-api.md)
         + [Optimering av bakgrundsmusik - del1](./expert-resources/cloud-5/season-3/cloud5-lighthouse-score-optimization-part1.md)
         + [Optimering av bakgrundsmusik - del 2](./expert-resources/cloud-5/season-3/cloud5-lighthouse-score-optimization-part2.md)
         + [Optimering av bakgrundsmusik - del3](./expert-resources/cloud-5/season-3/cloud5-lighthouse-score-optimization-part3.md)
      + Säsong 4{#season-4}
         + [Bästa praxis](./expert-resources/cloud-5/season-4/cloud5-edge-delivery-services-best-practices.md)
         + [Sökoptimeringar](./expert-resources/cloud-5/season-4/cloud5-search-optimization.md)
         + [Google Maps](./expert-resources/cloud-5/season-4/cloud5-google-maps.md)
