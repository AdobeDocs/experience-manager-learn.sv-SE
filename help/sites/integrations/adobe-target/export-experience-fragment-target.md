---
title: Exportera upplevelsefragment till Adobe Target
description: Lär dig hur du publicerar och exporterar AEM Experience Fragment som Adobe Target-erbjudanden.
feature: Experience Fragments
version: Cloud Service
jira: KT-6350
thumbnail: 41245.jpg
topic: Integrations
role: User
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 2c01cda8-f72f-47f7-a36b-95afd241906e
duration: 225
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '186'
ht-degree: 1%

---

# Exportera Experience Fragment till Adobe Target {#experience-fragment-target}

Lär dig hur du exporterar AEM Experience Fragment som Adobe Target-erbjudanden.

>[!VIDEO](https://video.tv.adobe.com/v/41245?quality=12&learn=on)

## Nästa steg

+ [Skapa en målaktivitet med Experience Fragment-erbjudanden](./create-target-activity.md)

## Felsökning

### Export av Experience Fragments till Target misslyckas

#### Fel

Om du exporterar Experience Fragment till Adobe Target utan rätt behörighet i Adobe Admin Console uppstår följande fel i AEM Author-tjänsten:

![Fel i mål-API](assets/error-target-offer.png)

... och följande loggmeddelanden i `aemerror` log:

![Mål-API-konsolfel](assets/target-console-error.png)

#### Upplösning

1. Logga in på [Admin Console](https://adminconsole.adobe.com/) med administratörsbehörighet för Adobe Target produktprofil som används, men AEM integrering
2. Välj __Produkter > Adobe Target > Produktprofil__
3. Under __Integreringar__ väljer du integrering för AEM as a Cloud Service miljö (samma namn som Adobe Developer-projektet)
4. Tilldela __Redigerare__ eller __Godkännare__ roll

   ![Mål-API-fel](assets/target-permissions.png)

Du bör åtgärda det här felet genom att lägga till rätt behörighet i Adobe Target-integreringen.

## Stödlänkar

+ [Adobe Experience Cloud Debugger - Chrome](https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob)
+ [Adobe Experience Cloud Debugger - Firefox](https://addons.mozilla.org/en-US/firefox/addon/adobe-experience-platform-dbg/)
