---
title: Skapa ett kodprojekt
description: Skapa ett kodprojekt för Edge Delivery Services som kan redigeras med Universell redigerare.
version: Experience Manager as a Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 900
exl-id: e1fb7a58-2bba-4952-ad53-53ecf80836db
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '287'
ht-degree: 0%

---

# Skapa ett Edge Delivery Services-kodprojekt

Om du vill skapa AEM-webbplatser för Edge Delivery Services och Universal Editor använder du Adobe [AEM Boilerplate XWalk-projektmall](https://github.com/adobe-rnd/aem-boilerplate-xwalk). Den här mallen skapar ett nytt kodprojekt som innehåller CSS och JavaScript som används för att skapa webbplatsupplevelsen. Den här mallen skapar en ny GitHub-databas och läser in den med Adobe standardkod och -konfiguration, vilket ger en stabil grund för AEM webbplatsprojekt.

Kom ihåg att [AEM-webbplatser som levereras av Edge Delivery Services](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/edge-delivery-services/overview) bara har kod för klientsidan (webbläsare). Webbplatskoden körs inte i AEM Author eller Publish Services.

![Nytt Edge Delivery Services-projekt](./assets/1-new-project/new-project.png)

Följ de [detaljerade stegen som beskrivs i dokumentationen](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/edge-delivery/wysiwyg-authoring/edge-dev-getting-started#create-github-project) för att skapa ett Edge Delivery Services-kodprojekt vars innehåll kan redigeras i Universell redigerare.  Nedan finns en sammanfattande lista över stegen, inklusive värdena som används i den här självstudiekursen.

1. **Konfigurera ett GitHub-konto.** Om du skapar ett projekt för din organisation ska du kontrollera att organisationen har ett GitHub-konto och att du är medlem.
2. **Skapa ett nytt kodprojekt** med projektmallen [AEM Boilerplate XWalk](https://github.com/adobe-rnd/aem-boilerplate-xwalk).
3. **Installera AEM Code Sync GitHub-appen** och ge åtkomst till databasen. Du hittar [appen här](https://github.com/apps/aem-code-sync).
4. **Konfigurera det nya projektets`fstab.yaml`** så att det pekar på rätt AEM Author-tjänst.

   * Om du vill experimentera kan du använda lägre AEM as a Cloud Service-miljöer (Stage eller Dev), men verkliga webbplatsimplementeringar bör konfigureras för att använda en AEM-produktionstjänst.

5. **Redigera det nya projektets`paths.json`** för att mappa sökvägen till AEM Author-tjänsten till webbplatsens rot.

Den här Git-databasen klonas i kapitlet [lokal utvecklingsmiljö](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/edge-delivery-services/developing/universal-editor/3-local-development-environment) och där kod utvecklas.
