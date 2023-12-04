---
title: Skapa Cloud Service för konfiguration av Acrobat Sign Cloud
description: Skapa integreringen mellan AEM Forms och Acrobat Sign med molntjänstkonfigurationen.
solution: Experience Manager,Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-7428
thumbnail: 332437.jpg
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: a55773a5-0486-413f-ada6-bb589315f0b1
duration: 239
source-git-commit: af928e60410022f12207082467d3bd9b818af59d
workflow-type: tm+mt
source-wordcount: '155'
ht-degree: 0%

---

# Skapa Acrobat Sign Cloud-konfiguration

Med konfigurationen av molntjänster i AEM kan du skapa integrering mellan AEM och andra molnprogram.

I följande video får du hjälp med att skapa en konfiguration för molntjänster för att integrera AEM med Acrobat Sign

>[!VIDEO](https://video.tv.adobe.com/v/332437?quality=12&learn=on)

## Felsökning

Om du får ett felmeddelande när du konfigurerar molnkonfigurationen för Adobe Sign kan du göra följande för att felsöka
* Kontrollera att den omdirigerings-URL som anges i Acrobat Sign API-programmet har följande format
&lt;your instance=&quot;&quot; name=&quot;&quot;>/libs/adobesign/cloudservices/adobesign/createcloudconfigwizard/cloudservices.html&lt;container>.
Till exempel: https://author-p24107-e32034.adobeaemcloud.com/libs/adobesign/cloudservices/adobesign/createcloudconfigwizard/cloudservices.html/conf/FormsCS. FormsCS är namnet på den behållare som ska innehålla molnkonfigurationen
* Kontrollera att autentiseringsadressen är korrekt
* Kontrollera klient-ID och klienthemlighet
* Prova inkognitiva fönsterlägen

