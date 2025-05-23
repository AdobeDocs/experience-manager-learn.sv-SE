---
title: Skapa Adobe Target Cloud Service-konto i AEM
description: Integrera Adobe Experience Manager as a Cloud Service med Adobe Target med Cloud Service och Adobe IMS-autentisering.
jira: KT-6044
thumbnail: 41244.jpg
topic: Integrations
feature: Integrations
role: Admin
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: dd6c17ae-8e08-4db3-95f9-081cc7dbd86e
duration: 316
source-git-commit: 22bd6237bb1665bf87c6302d2988135b505e40c0
workflow-type: tm+mt
source-wordcount: '191'
ht-degree: 0%

---

# Skapa Adobe Target Cloud Service-konto {#adobe-target-cloud-service}

I följande videofilm får du en genomgång av hur du ansluter AEM as a Cloud Service till Adobe Target.

Tack vare den här integreringen kan AEM Author kommunicera direkt med Adobe Target och skicka Experience Fragments från AEM till Target som erbjudanden.  Den här integreringen lägger *inte* till Adobe Target JavaScript (AT.js) på AEM Sites webbsidor, för att integrera [AEM och taggar med Target-tillägget](../experience-platform/data-collection/tags/connect-aem-tag-property-using-ims.md).

>[!WARNING]
>
>I videon visas den inaktuella JWT-autentiseringsmetoden för att ansluta AEM till Adobe Target. Den rekommenderade metoden är dock att använda autentiseringsmetoden OAuth Server-till-server. Mer information finns i [Migrering av JWT-To-OAuth-autentiseringsuppgifter för AEM](https://experienceleague.adobe.com/en/docs/experience-manager-learn/foundation/authentication/jwt-to-oauth-migration.html). Vi arbetar med att uppdatera videon för att återspegla den här ändringen.


>[!VIDEO](https://video.tv.adobe.com/v/41244?quality=12&learn=on)

>[!CAUTION]
>
>Det finns ett känt fel i konfigurationen av Adobe Target Cloud Services som visas i videon. Följ samma steg i videon tills problemet är löst, men använd den [gamla Adobe Target Cloud Services-konfigurationen](https://experienceleague.adobe.com/docs/experience-manager-learn/aem-target-tutorial/aem-target-implementation/using-aem-cloud-services.html?lang=sv-SE).
