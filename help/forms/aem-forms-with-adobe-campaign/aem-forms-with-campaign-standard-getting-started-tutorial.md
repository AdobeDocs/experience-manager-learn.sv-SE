---
title: Komma igång med AEM Forms och Adobe Campaign Standard
seo-title: Komma igång med AEM Forms och Adobe Campaign Standard
description: Integrera AEM Forms med Adobe Campaign Standard med AEM Forms Form Data Model för att hämta information om ACS-kampanjprofiler osv.
seo-description: Integrera AEM Forms med Adobe Campaign Standard med AEM Forms Form Data Model för att hämta information om ACS-kampanjprofiler osv.
uuid: 56450c9b-3752-4a64-b1b3-8c78e81f5921
feature: '"Adaptive Forms, Form Data Model"'
topics: integrations
audience: developer
doc-type: tutorial
activity: setup
version: 6.3,6.4,6.5
discoiquuid: 89245554-7b99-4e7e-9810-52191f9ea365
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '288'
ht-degree: 0%

---


# Komma igång med AEM Forms och Adobe Campaign Standard {#getting-started-with-aem-forms-and-adobe-campaign-standard}

![formulärsandkampanj](assets/helpx-cards-forms.png)

I den här självstudiekursen listas de olika användningsexemplen för att integrera AEM Forms med Adobe Campaign Standard(ACS).

ACS har en mängd olika API:er som gör att ACS kan interagera med den teknologi vi föredrar. I den här självstudiekursen kommer vi att fokusera på att interagera med AEM Forms med ACS.

Om du vill integrera AEM Forms med ACS måste du göra följande:

* [Konfigurera API-åtkomst för ACS-instansen.](https://docs.campaign.adobe.com/doc/standard/en/api/ACS_API.html#setting-up-api-access)
* Skapa JSON-webbtoken.
* Byt JSON-webbtoken mot Adobe Identity Management-tjänsten för en åtkomsttoken.
* Inkludera denna åtkomsttoken i HTTP-huvudet för auktorisering tillsammans med X-API-Key i varje begäran till ACS-instansen.

Följ nedanstående instruktioner för att komma igång

* [Ladda ned och zippa upp resurser som hör till kursen.](assets/aem-forms-and-acs-bundles.zip)
* Distribuera paketen med [Felix webbkonsol](http://localhost:4502/system/console/bundles)
* Ange lämpliga inställningar för Adobe Campaign i Felix OSGI Configuration.
* [Skapa en tjänstanvändare enligt den här artikeln](/help/forms/adaptive-forms/service-user-tutorial-develop.md). Distribuera det OSGi-paket som är kopplat till artikeln.
* Lagra den privata ACS-nyckeln i etc/key/campaign/private.key. Du måste skapa en mapp som kallas kampanj under etc/key.
* [Ge läsåtkomst till kampanjmappen till tjänstanvändaren &quot;data&quot;.](http://localhost:4502/useradmin)
