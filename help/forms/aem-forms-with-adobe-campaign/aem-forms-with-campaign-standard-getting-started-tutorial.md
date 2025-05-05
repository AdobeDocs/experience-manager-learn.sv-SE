---
title: Integrera AEM Forms och Adobe Campaign Standard
description: Integrera AEM Forms med Adobe Campaign Standard med AEM Forms Form Data Model för att hämta information om ACS-kampanjprofiler osv.
feature: Adaptive Forms, Form Data Model
version: Experience Manager 6.4, Experience Manager 6.5
topic: Integrations, Development
role: Developer
level: Experienced
exl-id: e028837b-13d8-4058-ac25-ed095f49524c
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
last-substantial-update: 2020-03-20T00:00:00Z
duration: 44
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '238'
ht-degree: 0%

---

# Integrera AEM Forms och Adobe Campaign Standard

![formsandcampaign](assets/helpx-cards-forms.png)

Lär dig integrera AEM Forms med Adobe Campaign Standard (ACS).

ACS har en mängd olika API:er som gör att ACS kan interagera med den teknologi vi föredrar. I den här självstudiekursen kommer vi att fokusera på att interagera med AEM Forms med ACS.

Om du vill integrera AEM Forms med ACS måste du göra följande:

* [Konfigurera API-åtkomst för ACS-instansen.](https://experienceleague.adobe.com/docs/campaign-standard/using/working-with-apis/get-started-apis.html?lang=sv-SE)
* Skapa JSON-webbtoken.
* Byt JSON-webbtoken med Adobe Identity Management-tjänsten för en åtkomsttoken.
* Inkludera denna åtkomsttoken i HTTP-huvudet för auktorisering tillsammans med X-API-Key i varje begäran till ACS-instansen.

Följ nedanstående instruktioner för att komma igång

* [Ladda ned och zippa upp resurser som hör till kursen.](assets/aem-forms-and-acs-bundles.zip)
* Distribuera paketen med [Felix-webbkonsolen](http://localhost:4502/system/console/bundles)
* Ange lämpliga inställningar för Adobe Campaign i Felix OSGI Configuration.
* [Skapa en tjänstanvändare enligt den här artikeln](/help/forms/adaptive-forms/service-user-tutorial-develop.md). Distribuera det OSGi-paket som är kopplat till artikeln.
* Lagra den privata ACS-nyckeln i etc/key/campaign/private.key. Du måste skapa en mapp som kallas kampanj under etc/key.
* [Ge läsåtkomst till kampanjmappen till tjänstanvändaren &quot;data&quot;.](http://localhost:4502/useradmin)

## Nästa steg

[Generera JWT- och åtkomsttoken](partone.md)
