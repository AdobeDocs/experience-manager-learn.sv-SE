---
title: Om Adobe IMS-autentisering med AEM på Adobe Managed Services
description: Adobe Experience Manager introducerar stöd för Admin Console för AEM och Adobe IMS-baserad (Identity Management System) autentisering för AEM på Managed Services.   Tack vare den här integreringen kan AEM Managed Services-kunder hantera alla Experience Cloud-användare i en enda enhetlig webbkonsol. Användare och grupper kan tilldelas till produktprofiler som är kopplade till AEM instanser, vilket ger centralt hanterad åtkomst till specifika AEM.
version: 6.4, 6.5
feature: User and Groups
doc-type: Technical Video
jira: KT-781
topic: Architecture
role: Architect
level: Experienced
exl-id: 52dd8a3f-6461-4acb-87ca-5dd9567d15a6
last-substantial-update: 2022-10-01T00:00:00Z
thumbnail: KT-781.jpg
duration: 405
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '399'
ht-degree: 0%

---

# Om Adobe IMS-autentisering med AEM på Adobe Managed Services{#understanding-adobe-ims-authentication-with-aem-on-adobe-managed-services}

Adobe Experience Manager introducerar stöd för Admin Console för AEM och Adobe Identity Management System-baserad autentisering för AEM på Managed Services.   Tack vare den här integreringen kan AEM Managed Services-kunder hantera alla Experience Cloud-användare i en enda enhetlig webbkonsol. Användare och grupper kan tilldelas produktprofiler som är kopplade till AEM instanser, vilket ger centralt hanterad åtkomst till specifika AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26170?quality=12&learn=on)

* Stöd för Adobe Experience Manager IMS-autentisering är endast avsett för&quot;interna&quot; användare (författare, granskare, administratörer, utvecklare och så vidare) och inte för externa slutanvändare, som besökare på webbplatser.
* [Admin Console](https://adminconsole.adobe.com/) representerar AEM Managed Services-kunder som IMS-organisationer och AEM som produktkontexter. Admin Console system- och produktadministratörer kan definiera och hantera.
* AEM Managed Services synkronisera din topologi med Admin Console och skapa en 1:1-mappning mellan en produktkontext och AEM.
* Produktprofilen i Admin Console avgör vilka AEM som en användare kan komma åt.
* Autentiseringsstödet innefattar kundens SAML2-kompatibla IDP för enkel inloggning.
* Endast Enterprise ID:n eller Federated ID:n (för kundens SSO) stöds (personliga Adobe ID:n stöds inte).

*&#42;Den här funktionen stöds för AEM 6.4 SP3 och senare för Adobe Managed Services-kunder.*

## God praxis {#best-practices}

### Tillämpa behörigheter i Admin Console

Tillstånd och åtkomst på användarnivå bör undvikas både i Admin Console och i Adobe Experience Manager.

I Admin Console bör användare ges åtkomst via användargrupper på produktkontextnivå. Användargrupper uttrycks oftast bäst utifrån den logiska rollen inom organisationen för att främja återanvändbarheten för grupper i olika Adobe Experience Cloud-produkter.

### Tillämpa behörigheter i Adobe Experience Manager

I Adobe Experience Manager ska användargrupper som synkroniseras från Adobe IMS läggas till i [AEM användargrupper](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security.html), som är förkonfigurerade med rätt behörighet för att köra vissa uppgifter i AEM. Användare som synkroniseras från Adobe IMS ska inte läggas till direkt i [AEM användargrupper](https://experienceleague.adobe.com/docs/experience-manager-65/administering/security/security.html).
