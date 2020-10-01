---
title: Skapa Adobe Target Cloud Service-konto
description: Steg för steg gå igenom hur du integrerar Adobe Experience Manager som en Cloud Service med Adobe Target med hjälp av Cloud Service och Adobe IMS-autentisering
feature: cloud-services
topics: integrations, administration, development
audience: administrator, developer
doc-type: technical video
activity: setup
version: cloud-service
kt: 6044
thumbnail: 41244.jpg
translation-type: tm+mt
source-git-commit: 25ca90f641aaeb93fc9319692f3b099d6b528dd1
workflow-type: tm+mt
source-wordcount: '193'
ht-degree: 0%

---


# Skapa Adobe Target Cloud Service-konto {#adobe-target-cloud-service}

Steg för steg gå igenom hur du integrerar Adobe Experience Manager som en Cloud Service med Adobe Target med hjälp av Cloud Service och Adobe IMS-autentisering.

>[!VIDEO](https://video.tv.adobe.com/v/41244?quality=12&learn=on)

>[!CAUTION]
>
>Det finns ett känt fel i konfigurationen av Adobe Target-Cloud Services som visas i videon. Vi rekommenderar i stället att du följer samma steg i videon som i [äldre Adobe Target-Cloud Services](https://docs.adobe.com/content/help/en/experience-manager-learn/aem-target-tutorial/aem-target-implementation/using-aem-cloud-services.html).

## Vanliga problem

När du exporterar Experience Fragment till Adobe-målet kan du få ett felmeddelande enligt nedan om målintegrationen i Admin Console inte har rätt behörighet.

**Gränssnittsfel** för![mål-API](assets/error-target-offer.png)

**Loggfel** i![mål-API-konsolfel](assets/target-console-error.png)


**Lösning**

1. Navigera till [Admin Console](https://adminconsole.adobe.com/)
2. Välj Produkter > Adobe Target > Produktprofil
3. Under fliken Integrationer väljer du Integrering (Adobe I/O-projekt)
4. Tilldela redigeraren eller godkännarrollen.

![Mål-API-fel](assets/target-permissions.png)

Genom att lägga till rätt behörighet i Target-integreringen kan du lösa problemet ovan.