---
title: Skapa en AEM-webbplats
description: Skapa en webbplats i AEM Sites för Edge Delivery Services, som kan redigeras med den universella redigeraren.
version: Experience Manager as a Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 500
exl-id: d1ebcaf4-cea6-4820-8b05-3a0c71749d33
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '302'
ht-degree: 0%

---

# Skapa en AEM-webbplats

På AEM webbplats kan du redigera, hantera och publicera webbplatsens innehåll. Om du vill skapa en AEM-webbplats som levereras via Edge Delivery Services och har skapats med Universal Editor använder du [Edge Delivery Services med AEM-redigeringsmallen](https://github.com/adobe-rnd/aem-boilerplate-xwalk/releases) och skapar en ny webbplats på AEM Author.

På AEM webbplats lagras och redigeras webbplatsens innehåll. Den slutliga upplevelsen är en kombination av AEM webbplatsinnehåll och koden [&#128279;](./1-new-code-project.md) för webbplatsen .

![Ny AEM-webbplats för Edge Delivery Services och Universal Editor](./assets/2-new-aem-site/new-site.png)

Följ de [detaljerade stegen som beskrivs i dokumentationen](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/edge-delivery/wysiwyg-authoring/edge-dev-getting-started#create-aem-site) för att skapa en ny AEM-webbplats.  Nedan finns en sammanfattande lista över stegen, inklusive värdena som används i den här självstudiekursen.
1. **Skapa en ny webbplats** i AEM Author. I den här självstudien används följande webbplatsnamn:
   * Platstitel: `WKND (Universal Editor)`
   * Platsnamn: `aem-wknd-eds-ue`

      * Värdet för platsnamnet måste matcha webbplatsens sökvägsnamn [ som lagts till i `paths.json`](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/edge-delivery/wysiwyg-authoring/path-mapping).

2. **Importera den senaste mallen** från [Edge Delivery Services med AEM redigeringswebbplatsmall](https://github.com/adobe-rnd/aem-boilerplate-xwalk/releases).
3. **Ge platsen** ett namn som matchar GitHub-databasnamnet och ange GitHub-URL:en som databasens URL.

## Publicera den nya webbplatsen för förhandsgranskning

När du har skapat webbplatsen i AEM Author publicerar du den i Edge Delivery Services-förhandsvisningen och gör innehållet tillgängligt för den [lokala utvecklingsmiljön](./3-local-development-environment.md).

1. Logga in på **AEM Author** och gå till **Sites**.
2. Markera den **nya webbplatsen** (`WKND (Universal Editor)`) och klicka på **Hantera publikationer**.
3. Välj **Förhandsgranska** under **Destinationer** och klicka på **Nästa**.
4. Under **Inkludera underordnade inställningar** markerar du **Inkludera underordnade**, avmarkerar andra alternativ och klickar på **OK**.
5. Klicka på **Publicera** för att publicera webbplatsens innehåll och förhandsgranska det.
6. När sidorna har publicerats för förhandsgranskning är de tillgängliga i Edge Delivery Services förhandsvisningsmiljö (sidorna visas inte i AEM Preview).
