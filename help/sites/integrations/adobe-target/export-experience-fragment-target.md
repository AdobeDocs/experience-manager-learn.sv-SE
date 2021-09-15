---
title: Exportera upplevelsefragment till Adobe Target
description: Lär dig hur du publicerar och exporterar AEM Experience Fragment som Adobe Target-erbjudanden.
feature: Experience Fragments
topics: integrations, authoring
audience: all
doc-type: feature video
activity: use
version: Cloud Service
kt: 6350
thumbnail: 41245.jpg
topic: Integrations
role: User
level: Intermediate
exl-id: 2c01cda8-f72f-47f7-a36b-95afd241906e
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '192'
ht-degree: 1%

---

# Exportera Experience Fragment till Adobe Target {#experience-fragment-target}

Lär dig hur du exporterar AEM Experience Fragment som Adobe Target-erbjudanden.

>[!VIDEO](https://video.tv.adobe.com/v/41245?quality=12&learn=on)

## Nästa steg

+ [Skapa en målaktivitet med Experience Fragment-erbjudanden](./create-target-activity.md)

## Felsökning

### Det går inte att exportera Experience Fragments till Target

#### Fel

Om du exporterar Experience Fragment till Adobe Target utan rätt behörighet i Adobe Admin Console uppstår följande fel i AEM Author-tjänsten:

    ![Mål-API-gränssnittsfel](assets/error-target-offer.png)

... och följande loggmeddelanden i `aemerror`-loggen:

    ![Mål-API-konsolfel](assets/target-console-error.png)

#### Upplösning

1. Logga in på [Admin Console](https://adminconsole.adobe.com/) med administratörsbehörighet för Adobe Target produktprofil som används men AEM integreringen
2. Välj __Produkter > Adobe Target > Produktprofil__
3. Under fliken __Integrationer__ väljer du Cloud Service för AEM (samma namn som Adobe I/O-projektet)
4. Tilldela rollen __Redigerare__ eller __Godkännare__

   ![Mål-API-fel](assets/target-permissions.png)

Du bör åtgärda det här felet genom att lägga till rätt behörighet i Adobe Target-integreringen.

## Stödlänkar

+ [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj)
+ [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)
