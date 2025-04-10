---
title: Skapa Cloud Service för Acrobat Sign Cloud-konfiguration
description: Skapa integreringen mellan AEM Forms och Acrobat Sign med molntjänstkonfigurationen.
solution: Experience Manager,Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Adaptive Forms
topic: Development
jira: KT-7428
thumbnail: 332437.jpg
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: a55773a5-0486-413f-ada6-bb589315f0b1
duration: 222
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '155'
ht-degree: 0%

---

# Skapa Acrobat Sign Cloud-konfiguration

Med konfigurationen av molntjänster i AEM kan du skapa integrering mellan AEM och andra molnprogram.

I följande video får du hjälp med att skapa en konfiguration för molntjänster som integrerar AEM med Acrobat Sign

>[!VIDEO](https://video.tv.adobe.com/v/332437?quality=12&learn=on)

## Felsökning

Om du får ett felmeddelande när du konfigurerar molnkonfigurationen för Adobe Sign kan du göra följande för att felsöka
* Kontrollera att den omdirigerings-URL som anges i Acrobat Sign API-programmet har följande format
&lt;ditt instansnamn>/libs/adobesign/cloudservices/adobesign/createcloudconfigwizard/cloudservices.html/conf/&lt;container>.
Till exempel: https://author-p24107-e32034.adobeaemcloud.com/libs/adobesign/cloudservices/adobesign/createcloudconfigwizard/cloudservices.html/conf/FormsCS. FormsCS är namnet på den behållare som ska innehålla molnkonfigurationen
* Kontrollera att autentiseringsadressen är korrekt
* Kontrollera klient-ID och klienthemlighet
* Prova inkognitiva fönsterlägen

