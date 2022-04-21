---
title: Setup ContextHub for Personalization with AEM Sites
description: ContextHub is a framework for storing, manipulating, and presenting context data. The ContextHub Javascript API enables you to access stores to create, update, and delete data as necessary. As such, ContextHub represents a data layer on your pages. This page describes how to add context hub to your AEM site pages.
feature: Context Hub
topics: personalization
audience: developer, architect
doc-type: technical video
activity: setup
version: 6.4, 6.5
topic: Personalization
role: Developer
level: Intermediate
exl-id: 89308dd3-a7e5-4fec-bffb-5f0974125c0a
source-git-commit: 9e4b01173f5d89075ad64adfb8b982b2297e2c39
workflow-type: tm+mt
source-wordcount: '422'
ht-degree: 1%

---

# Setup ContextHub for Personalization {#set-up-contexthub}

ContextHub is a framework for storing, manipulating, and presenting context data. The ContextHub Javascript API enables you to access stores to create, update, and delete data as necessary. As such, ContextHub represents a data layer on your pages. This page describes how to add context hub to your AEM site pages.

>[!VIDEO](https://video.tv.adobe.com/v/23765/?quality=9&learn=on)

>[!NOTE]
>
>We use the WKND reference site for this video and it is not part of AEM release. [](https://github.com/adobe/aem-guides-wknd/releases)

Add ContextHub to your pages to enable the ContextHub features and to link to the ContextHub JavaScript libraries. The ContextHub JavaScript API provides access to the context data that ContextHub manages.

## Adding ContextHub to a Page Component {#adding-contexthub-to-a-page-component}

`contexthub``<head>` The HTL code for your page component resembles the following example:

```java
<!--/* Include Context Hub */-->
<sly data-sly-resource="${'contexthub' @ resourceType='granite/contexthub/components/contexthub'}"/>
```

## Site Configuration and ContextHub Segments {#site-configuration-and-contexthub-segments}

ContextHub includes a segmentation engine that manages segments and determines which segments are resolved for the current context. Several segments are defined. [](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/ch-adding.html#DeterminingResolvedContextHubSegments) [[!UICONTROL Configuration Browser]](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/developing/configurations.html)

## Create Segments {#create-segments}

Create AEM segments that act as rules for the teasers. That is, they define when content within a teaser appears on a web page. Content can then be specifically targeted to the visitor&#39;s needs and interests, depending on the segment(s) they match.

## Assigning Cloud Configuration, Segment path and ContextHub path to your site {#assigning-cloud-configuration-segment-path-and-contexthub-path-to-your-site}

Assigning the Cloud configuration path, segmentation path and ContextHub path to your site root node so you can create a personalized experience for your audience. Using the ContextHub, you can manipulate the context data and test your resolved segments.

![CRXDE Lite](assets/crx-de-properties.png)

You can read more about ContextHub and segmentation below:

* [ContextHub](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/contexthub.html)
* [](https://helpx.adobe.com/experience-manager/6-5/sites/developing/using/ch-adding.html)
* [Förstå segmentering](https://helpx.adobe.com/experience-manager/6-5/sites/classic-ui-authoring/using/classic-personalization-campaigns-segmentation.html)
* [](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/segmentation.html)
