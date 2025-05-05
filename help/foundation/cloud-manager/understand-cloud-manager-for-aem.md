---
title: Förstå Adobe Cloud Manager
description: Adobe Cloud Manager är en enkel men ändå robust lösning som gör det enkelt att hantera, granska och självbetjäna AEM.
sub-product: Experience Manager Cloud Manager, Experience Manager
doc-type: Feature Video
topic: Architecture
feature: Cloud Manager
role: Architect
level: Beginner
exl-id: 53279cbb-70c8-4319-b5bb-9a7d350a7f72
last-substantial-update: 2022-05-10T00:00:00Z
thumbnail: understand-cloud-manager.jpg
duration: 1011
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '464'
ht-degree: 0%

---

# Förstå Adobe Cloud Manager

Adobe Cloud Manager är en enkel men ändå robust lösning som gör det enkelt att hantera, granska och självbetjäna AEM.

## Cloud Manager - översikt

I denna videoserie utforskas de viktigaste funktionerna i Cloud Manager för AEM:

* [Program](#programs)
* [Miljö](#environments)
* [Rapporter](#reports)
* [CI/CD Production Pipeline](#cicd-production-pipeline)
* [Icke-produktionsförlopp för CI/CD](#cicd-non-production-pipeline)
* [Aktivitet](#activity)

En fullständig översikt finns i [Cloud Manager användarhandbok](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/introduction.html?lang=sv-SE).

## Program {#programs}

[Cloud Manager-program](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/getting-started/program-setup.html?lang=sv-SE) representerar uppsättningar AEM miljöer som stöder logiska uppsättningar av affärsinitiativ, som vanligtvis motsvarar ett köpt serviceavtal (SLA). Ett program kan t.ex. representera de AEM resurserna för att stödja de globala offentliga webbplatserna, medan ett annat program representerar en intern central DAM.

>[!VIDEO](https://video.tv.adobe.com/v/26313?quality=12&learn=on)

## Miljö {#environments}

[Cloud Manager-miljöer](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/managing-environments.html?lang=sv-SE) består av AEM författare, AEM Publish och Dispatcher. Olika miljöer har stöd för roller och kan användas med olika CI/CD-pipelines (beskrivs nedan). Cloud Manager-miljöer har vanligtvis en produktionsmiljö och en scenmiljö.

>[!VIDEO](https://video.tv.adobe.com/v/26318?quality=12&learn=on)

## Rapporter {#reports}

[Cloud Manager-rapporter](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/monitoring-environments.html?lang=sv-SE) ger en översikt över programmets miljöer och AEM genom en uppsättning diagram som rapporterar och spårar olika mått för varje AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26315?quality=12&learn=on)

## CI/CD Production Pipeline {#cicd-production-pipeline}

*[Använd CI/CD Pipeline i videoserien Adobe Cloud Manager](./use-the-cicd-pipeline-in-cloud-manager-for-aem.md) som ger dig en djupdykning i körningen av produktionspipelinen, inklusive utforskning av misslyckade och lyckade distributioner.*

>[!NOTE]
>
> I alla dessa videoklipp har tiden för att skapa, testa och distribuera videon ökat för att minska tiden. En fullständig pipeline-körning tar normalt 45 minuter eller mer (inklusive den obligatoriska 30-minuters prestandatestningen), beroende på projektstorlek, antal AEM och UAT-processer.

### Konfiguration

Konfigurationen [CI/CD Production Pipeline](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/pipelines/production-pipelines.html?lang=sv-SE) definierar utlösaren som initierar pipelinen och parametrar som styr produktionsdistributionen och prestandatestparametrarna.

>[!VIDEO](https://video.tv.adobe.com/v/26314?quality=12&learn=on)

### Körning av pipeline

Produktionspipelinen [CI/CD](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/code-deployment.html?lang=sv-SE) används för att skapa och distribuera kod genom scenen till produktionsmiljön, vilket minskar tiden till värde.

>[!VIDEO](https://video.tv.adobe.com/v/26317?quality=12&learn=on)

## Icke-produktionsförlopp för CI/CD {#cicd-non-production-pipeline}

[Icke-producerade pipelines för CI/CD](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/pipelines/production-pipelines.html?lang=sv-SE) är indelade i två kategorier, Kodkvalitetspipelines och Distributionspipelines. Kodkvalitetsledningarna genererar all kod från en Git-gren och utvärderas mot Cloud Manager kodkvalitetssökning. Driftsättningspipelines stöder automatisk driftsättning av kod från Git-databasen till valfri icke-produktionsmiljö, vilket innebär en provisionerad AEM som inte är Stage eller Production.

>[!VIDEO](https://video.tv.adobe.com/v/26316?quality=12&learn=on)

## Aktivitet {#activity}

Cloud Manager ger en samlad översikt över en programaktivitet, med en lista över alla CI/CD Pipeline-exekveringar, både produktion och icke-produktion, som ger insyn i den tidigare och nuvarande aktiviteten och alla aktiviteters detaljer kan granskas.

Cloud Manager kan även integreras per användare med [Adobe Experience Cloud Notifications](https://experienceleague.adobe.com/docs/experience-manager-cloud-manager/content/using/notifications.html?lang=sv-SE), vilket ger en helhetsbild av händelser och intressanta åtgärder.

>[!VIDEO](https://video.tv.adobe.com/v/26319?quality=12&learn=on)
