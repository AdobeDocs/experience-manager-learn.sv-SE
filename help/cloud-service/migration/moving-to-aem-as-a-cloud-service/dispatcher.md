---
title: Konfigurera Dispatcher vid flyttning till AEM as a Cloud Service
description: Lär dig mer om AEM Dispatcher för AEM as a Cloud Service, Dispatcher-konverteringsverktyget och hur du använder Dispatcher Tools SDK.
version: Cloud Service
feature: Dispatcher
topic: Migration, Upgrade
role: Developer
level: Experienced
jira: KT-8633
thumbnail: 336962.jpeg
exl-id: 81397b21-b4f3-4024-a6da-a9b681453eff
duration: 1642
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '237'
ht-degree: 2%

---


# Dispatcher

Lär dig mer om AEM Dispatcher for AEM as a Cloud Service, med fokus på betydande ändringar från Dispatcher för AEM 6, Dispatcher-konverteringsverktyget och hur du använder Dispatcher Tools SDK.

>[!VIDEO](https://video.tv.adobe.com/v/336962?quality=12&learn=on)

## Dispatcher Converter

![Dispatcher Converter](./assets/dispatcher-converter-diagram.png)

När du omfaktoriserar din kodbas använder du [AEM Dispatcher Converter](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/moving/refactoring-tools/dispatcher-transformation-utility-tools.html) för att refaktorisera befintliga Managed Services Dispatcher-konfigurationer på plats eller Adobe till AEM as a Cloud Service kompatibla Dispatcher-konfigurationer.

## Viktiga aktiviteter

+ Använd [Adobe I/O Dispatcher Converter](https://github.com/adobe/aio-cli-plugin-aem-cloud-service-migration#aio-aem-migrationdispatcher-converter) för att migrera en befintlig Dispatcher-konfiguration.
+ Referera till modulen Dispatcher från [AEM Project Archettype](https://github.com/adobe/aem-project-archetype/tree/develop/src/main/archetype/dispatcher.cloud) som bästa praxis.
+ [Konfigurera lokala Dispatcher-verktyg](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/dispatcher-tools.html) för att validera dispatchern, innan du testar i en Cloud Service-miljö.

## Handövning

Prova det du lärt dig med övningen.

Innan du provar övningen bör du kontrollera att du har tittat på och förstått videon ovan och följande material:

+ [AEM Modernization Tools](./aem-modernization-tools.md)
+ [Onboarding](./onboarding.md)
+ [Cloud Manager](./cloud-manager.md)

Se även till att du har fullföljt tidigare övningar:

+ [Handövning i Cloud Manager](./cloud-manager.md#hands-on-exercise)

<table style="border-width:0">
    <tr>
        <td style="width:150px">
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session5-dispatcher#cloud-acceleration-bootcamp---session-5-dispatcher"><img alt="Handövande GitHub-databas" src="./assets/github.png"/>
            </a>        
        </td>
        <td style="width:100%;margin-bottom:1rem;">
            <div style="font-size:1.25rem;font-weight:400;">Handverktyget med Dispatcher Tools</div>
            <p style="margin:1rem 0">
                Använd AEM SDK:s Dispatcher Tools för att validera Dispatcher-konfigurationer och köra AEM Dispatcher lokalt med Docker.
            </p>
            <a  rel="noreferrer"
                target="_blank"
                href="https://github.com/adobe/aem-cloud-engineering-video-series-exercises/tree/session5-dispatcher#cloud-acceleration-bootcamp---session-5-dispatcher" class="spectrum-Button spectrum-Button--primary spectrum-Button--sizeM">
                <span class="spectrum-Button-label has-no-wrap has-text-weight-bold">Prova Dispatcher Tools</span>
            </a>
        </td>
    </tr>
</table>
