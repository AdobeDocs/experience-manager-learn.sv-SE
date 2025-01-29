---
title: Skapa ett kodprojekt
description: Skapa ett kodprojekt för Edge Delivery Services som kan redigeras med Universell redigerare.
version: Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 900
exl-id: e1fb7a58-2bba-4952-ad53-53ecf80836db
source-git-commit: 9b10d79190d805b86884f033e040891655c3c890
workflow-type: tm+mt
source-wordcount: '269'
ht-degree: 0%

---

# Skapa ett kodprojekt för Edge Delivery Services

Om du vill skapa AEM webbplatser för Edge Delivery Services och Universal Editor använder du projektmallen Adobe [AEM Boilerplate XWalk ](https://github.com/adobe-rnd/aem-boilerplate-xwalk) . Den här mallen skapar ett nytt kodprojekt som innehåller CSS och JavaScript som används för att skapa webbplatsupplevelsen. Den här mallen skapar en ny GitHub-databas och läser in den med Adobe-mallkod och konfiguration, vilket ger en stabil grund för ditt AEM webbplatsprojekt.

Kom ihåg att [AEM webbplatser som levereras av Edge Delivery Services](https://experienceleague.adobe.com/en/docs/experience-manager-learn/sites/edge-delivery-services/overview) bara har kod för klientsidan (webbläsare). Webbplatskoden körs inte i AEM Author eller Publish.

![Nytt Edge Delivery Services-projekt](./assets/1-new-project/new-project.png)

Följ stegen nedan för att skapa ett kodprojekt för Edge Delivery Services vars innehåll kan redigeras i Universell redigerare:

1. **Konfigurera ett GitHub-konto.** Om du skapar ett projekt för din organisation ska du kontrollera att organisationen har ett GitHub-konto och att du är medlem.
2. **Skapa ett nytt kodprojekt** med [AEM-mallens XWalk-projektmall ](https://github.com/adobe-rnd/aem-boilerplate-xwalk).
3. **Installera appen AEM Code Sync GitHub** och ge åtkomst till databasen. Du hittar [appen här](https://github.com/apps/aem-code-sync).
4. **Konfigurera det nya projektets`fstab.yaml`** så att det pekar på rätt AEM författartjänst.

   * Om du vill experimentera kan du använda lägre AEM as a Cloud Service-miljöer (Stage eller Dev), men verkliga webbplatser ska konfigureras för att använda en AEM.

5. **Redigera det nya projektets`paths.json`** om du vill mappa sökvägen AEM författaren till webbplatsens rot.

Mer detaljerade anvisningar finns i [Skapa ditt GitHub-projektavsnitt](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/edge-delivery/wysiwyg-authoring/edge-dev-getting-started#create-github-project) i guiden Komma igång.
