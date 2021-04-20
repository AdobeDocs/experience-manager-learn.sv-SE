---
title: Förstå Adobe Cloud Manager
description: Adobe Cloud Manager är en enkel, men robust lösning som gör det enkelt att hantera, granska och självbetjäna AEM miljöer.
sub-product: cloud-manager, grund
topics: best-practices, cicd, development, operations, governance
doc-type: feature video
activity: understand
audience: developer, implementer, administrator, architect
topic: Architecture
role: Architect
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '534'
ht-degree: 2%

---


# Förstå Adobe Cloud Manager

Adobe Cloud Manager är en enkel, men robust lösning som gör det enkelt att hantera, granska och självbetjäna AEM miljöer.

## Översikt över Cloud Manager

I den här videoserien utforskas de viktigaste funktionerna i Cloud Managers för AEM:

* [Program](#programs)
* [Miljöer](#environments)
* [Rapporter](#reports)
* [CI/CD Production Pipeline](#cicd-production-pipeline)
* [Icke-produktionsförlopp för CI/CD](#cicd-non-production-pipeline)
* [Aktivitet](#activity)

En fullständig översikt finns i [användarhandboken för Cloud Manager](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/introduction-to-cloud-manager.html).

## Program {#programs}

[Cloud Manager-](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/getting-started/setting-up-program.html) program representerar uppsättningar AEM miljöer som stöder logiska uppsättningar av affärsinitiativ, som vanligtvis motsvarar ett köpt servicenivåavtal (SLA). Ett program kan t.ex. representera de AEM resurserna för att stödja de globala offentliga webbplatserna, medan ett annat program representerar en intern central DAM.

>[!VIDEO](https://video.tv.adobe.com/v/26313/?quality=12&learn=on)

## Miljöer {#environments}

[Cloud Manager-](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/manage-your-environment.html) miljöer består av instanser av AEM Author, AEM Publish och Dispatcher. Olika miljöer har stöd för roller och kan användas med olika CI/CD-pipelines (beskrivs nedan). Cloud Manager-miljöer har vanligtvis en produktionsmiljö och en scenmiljö.

>[!VIDEO](https://video.tv.adobe.com/v/26318/?quality=12&learn=on)

## Rapporter {#reports}

[Cloud Manager-rapporter ](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/monitor-your-environments.html) ger en översikt över programmets miljöer och AEM genom en uppsättning diagram som rapporterar och håller reda på en mängd mätvärden för varje AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26315/?quality=12&learn=on)

## CI/CD Production Pipeline {#cicd-production-pipeline}

*[Med CI/CD Pipeline i Adobe Cloud ](./use-the-cicd-pipeline-in-cloud-manager-for-aem.md) Managervideoserien får du en djupdykning i körningen av produktionsförloppet, inklusive utforskande av misslyckade och lyckade distributioner.*

>[!NOTE]
>
> I alla dessa videor har tiden för att skapa, testa och distribuera videon ökat för att minska tiden. En fullständig pipeline-körning tar normalt 45 minuter eller mer (inklusive den obligatoriska 30-minuters prestandatestningen), beroende på projektstorlek, antal AEM och UAT-processer.

### Konfiguration

Konfigurationen [CI/CD Production Pipeline](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/configuring-pipeline.html) definierar den utlösare som initierar pipelinen, parametrar som styr produktionsdistributionen och prestandatestparametrarna.

>[!VIDEO](https://video.tv.adobe.com/v/26314/?quality=12&learn=on)

### Körning av pipeline

[CI/CD Production Pipeline](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/deploying-code.html) används för att skapa och distribuera kod genom Stage till produktionsmiljön, vilket minskar tiden till värde.

>[!VIDEO](https://video.tv.adobe.com/v/26317/?quality=12&learn=on)

## CI/CD icke-produktionsförlopp {#cicd-non-production-pipeline}

[CI/CD Icke-producerade ](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/configuring-pipeline.html#non-production--code-quality-only-pipelines) rörledningar delas in i två kategorier: Kodkvalitetsrörledningar och distributionsrörledningar. Kodkvalitetsledningarna genererar all kod från en Git-gren och utvärderas mot Cloud Managers skanning av kodkvalitet. Driftsättningspipelines stöder automatisk driftsättning av kod från Git-databasen till valfri icke-produktionsmiljö, vilket innebär en provisionerad AEM som inte är Stage eller Production.

>[!VIDEO](https://video.tv.adobe.com/v/26316/?quality=12&learn=on)

## Aktivitet {#activity}

Cloud Manager ger en samlad vy över en aktivitet i ett program, med en lista över alla CI/CD Pipeline-körningar, både produktion och icke-produktion, som ger insyn i den tidigare och nuvarande aktiviteten och alla aktiviteters detaljer kan granskas.

Cloud Manager kan även integreras per användare med [Adobe Experience Cloud Notifications](https://docs.adobe.com/content/help/en/experience-manager-cloud-manager/using/how-to-use/notifications.html), vilket ger en helhetsbild av händelser och intressanta åtgärder.

>[!VIDEO](https://video.tv.adobe.com/v/26319/?quality=12&learn=on)
