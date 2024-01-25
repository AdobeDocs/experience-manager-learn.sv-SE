---
title: Förstå Adobe Cloud Manager
description: Adobe Cloud Manager är en enkel men ändå robust lösning som gör det enkelt att hantera, granska och självbetjäna AEM miljöer.
sub-product: Experience Manager Cloud Manager, Experience Manager
doc-type: Feature Video
topic: Architecture
feature: Cloud Manager
role: Architect
level: Beginner
exl-id: 53279cbb-70c8-4319-b5bb-9a7d350a7f72
last-substantial-update: 2022-05-10T00:00:00Z
thumbnail: understand-cloud-manager.jpg
duration: 1026
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '464'
ht-degree: 0%

---

# Förstå Adobe Cloud Manager

Adobe Cloud Manager är en enkel men ändå robust lösning som gör det enkelt att hantera, granska och självbetjäna AEM miljöer.

## Översikt över Cloud Manager

I den här videoserien utforskas de viktigaste funktionerna i Cloud Managers för AEM:

* [Program](#programs)
* [Miljö](#environments)
* [Rapporter](#reports)
* [CI/CD Production Pipeline](#cicd-production-pipeline)
* [Icke-produktionsförlopp för CI/CD](#cicd-non-production-pipeline)
* [Aktivitet](#activity)

En fullständig översikt finns i [Användarhandbok för Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/introduction.html).

## Program {#programs}

[Cloud Manager-program](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/getting-started/program-setup.html) representerar uppsättningar AEM miljöer som stöder logiska uppsättningar av affärsinitiativ, som vanligtvis motsvarar ett köpt serviceavtal (SLA). Ett program kan t.ex. representera de AEM resurserna för att stödja de globala offentliga webbplatserna, medan ett annat program representerar en intern central DAM.

>[!VIDEO](https://video.tv.adobe.com/v/26313?quality=12&learn=on)

## Miljö {#environments}

[Cloud Manager-miljöer](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/managing-environments.html) består av AEM Author, AEM Publish and Dispatcher-instanser. Olika miljöer har stöd för roller och kan användas med olika CI/CD-pipelines (beskrivs nedan). Cloud Manager-miljöer har vanligtvis en produktionsmiljö och en scenmiljö.

>[!VIDEO](https://video.tv.adobe.com/v/26318?quality=12&learn=on)

## Rapporter {#reports}

[Cloud Manager-rapporter](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/monitoring-environments.html) ge en översikt över programmets miljöer och AEM genom en uppsättning diagram som rapporterar och håller reda på olika mätvärden för varje AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26315?quality=12&learn=on)

## CI/CD Production Pipeline {#cicd-production-pipeline}

*[Använda CI/CD-pipeline i Adobe Cloud Manager](./use-the-cicd-pipeline-in-cloud-manager-for-aem.md) videoserien ger en djupdykning i körningen av produktionspipelinen, bland annat utforskande av misslyckade och lyckade distributioner.*

>[!NOTE]
>
> I alla dessa videoklipp har tiden för att skapa, testa och distribuera videon ökat för att minska tiden. En fullständig pipeline-körning tar normalt 45 minuter eller mer (inklusive den obligatoriska 30-minuters prestandatestningen), beroende på projektstorlek, antal AEM och UAT-processer.

### Konfiguration

The [CI/CD Production Pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/pipelines/production-pipelines.html) konfiguration definierar den utlösare som initierar pipelinen och parametrar som styr produktionsdistributionen och prestandatestparametrarna.

>[!VIDEO](https://video.tv.adobe.com/v/26314?quality=12&learn=on)

### Körning av pipeline

The [CI/CD Production Pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/code-deployment.html) används för att skapa och distribuera kod genom Stage till produktionsmiljön, vilket minskar tiden till värde.

>[!VIDEO](https://video.tv.adobe.com/v/26317?quality=12&learn=on)

## Icke-produktionsförlopp för CI/CD {#cicd-non-production-pipeline}

[Rörledningar för CI/CD, ej produktion](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/pipelines/production-pipelines.html) är uppdelade i två kategorier, Kodkvalitetsledningar och distributionsledningar. Kodkvalitetsledningarna genererar all kod från en Git-gren och utvärderas mot Cloud Managers skanning av kodkvalitet. Driftsättningspipelines stöder automatisk driftsättning av kod från Git-databasen till valfri icke-produktionsmiljö, vilket innebär en provisionerad AEM som inte är Stage eller Production.

>[!VIDEO](https://video.tv.adobe.com/v/26316?quality=12&learn=on)

## Aktivitet {#activity}

Cloud Manager ger en samlad vy över en aktivitet i ett program, med en lista över alla CI/CD Pipeline-körningar, både produktion och icke-produktion, som ger insyn i den tidigare och nuvarande aktiviteten och alla aktiviteters detaljer kan granskas.

Cloud Manager kan även integreras per användare med [Adobe Experience Cloud Notifications](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/notifications.html), som ger en heltäckande bild av händelser och intressanta åtgärder.

>[!VIDEO](https://video.tv.adobe.com/v/26319?quality=12&learn=on)
