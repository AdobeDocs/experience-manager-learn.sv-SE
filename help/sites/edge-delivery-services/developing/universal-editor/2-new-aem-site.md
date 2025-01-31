---
title: Skapa en AEM
description: Skapa en webbplats i AEM Sites för Edge Delivery Services som kan redigeras med den universella redigeraren.
version: Cloud Service
feature: Edge Delivery Services
topic: Development
role: Developer
level: Beginner
doc-type: Tutorial
jira: KT-15832
duration: 500
exl-id: d1ebcaf4-cea6-4820-8b05-3a0c71749d33
source-git-commit: b40bf5afc28cb350c470336e38f8ca127fb05d79
workflow-type: tm+mt
source-wordcount: '302'
ht-degree: 0%

---

# Skapa en AEM

Den AEM webbplatsen är den plats där webbplatsens innehåll redigeras, hanteras och publiceras. Om du vill skapa en AEM webbplats som levereras via Edge Delivery Services och redigeras med Universal Editor använder du mallen [Edge Delivery Services med AEM redigeringsplats](https://github.com/adobe-rnd/aem-boilerplate-xwalk/releases) för att skapa en ny plats AEM författaren.

Den AEM webbplatsen är den plats där webbplatsens innehåll lagras och skapas. Den slutliga upplevelsen är en kombination av det AEM webbplatsinnehållet med [webbplatsens kod](./1-new-code-project.md)

![Ny AEM för Edge Delivery Services och universell redigerare](./assets/2-new-aem-site/new-site.png)

Följ de [detaljerade stegen som beskrivs i dokumentationen](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/edge-delivery/wysiwyg-authoring/edge-dev-getting-started#create-aem-site) för att skapa en ny AEM.  Nedan finns en sammanfattande lista över stegen, inklusive värdena som används i den här självstudiekursen.
1. **Skapa en ny plats** i AEM författare. I den här självstudien används följande webbplatsnamn:
   * Platstitel: `WKND (Universal Editor)`
   * Platsnamn: `aem-wknd-eds-ue`

      * Värdet för platsnamnet måste matcha webbplatsens sökvägsnamn [ som lagts till i `paths.json`](https://experienceleague.adobe.com/en/docs/experience-manager-cloud-service/content/edge-delivery/wysiwyg-authoring/path-mapping).

2. **Importera den senaste mallen** från [Edge Delivery Servicens med AEM webbplatsmall för redigering](https://github.com/adobe-rnd/aem-boilerplate-xwalk/releases).
3. **Ge platsen** ett namn som matchar GitHub-databasnamnet och ange GitHub-URL:en som databasens URL.

## Publish den nya webbplatsen som ska förhandsgranskas

När du har skapat webbplatsen i AEM Author publicerar du den i förhandsgranskningen av Edge Delivery Servicens och gör innehållet tillgängligt för den [lokala utvecklingsmiljön](./3-local-development-environment.md).

1. Logga in på **AEM Författare** och navigera till **Webbplatser**.
2. Markera den **nya webbplatsen** (`WKND (Universal Editor)`) och klicka på **Hantera publikationer**.
3. Välj **Förhandsgranska** under **Destinationer** och klicka på **Nästa**.
4. Under **Inkludera underordnade inställningar** markerar du **Inkludera underordnade**, avmarkerar andra alternativ och klickar på **OK**.
5. Klicka på **Publish** om du vill publicera webbplatsens innehåll för förhandsgranskning.
6. När sidorna har publicerats för förhandsgranskning är de tillgängliga i förhandsvisningsmiljön för Edge Delivery Services ( visas inte i AEM förhandsvisningstjänst).
