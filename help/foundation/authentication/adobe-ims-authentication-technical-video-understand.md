---
title: Om Adobe IMS-autentisering med AEM på Adobes hanterade tjänster
description: Adobe Experience Manager introducerar stöd för Admin Console för AEM instanser och Adobe IMS-baserad (Identity Management System) AEM i Managed Services.   Tack vare den här integreringen kan AEM Managed Services-kunder hantera alla Experience Cloud-användare i en enda enhetlig webbkonsol. Användare och grupper kan tilldelas produktprofiler som är kopplade till AEM instanser, vilket ger centralt hanterad åtkomst till specifika AEM.
version: 6.4, 6.5
feature: authentication
topics: authentication, security
activity: understand
audience: administrator, architect, developer, implementer
doc-type: technical video
kt: 781
translation-type: tm+mt
source-git-commit: e99779b5d42bb9a3b258e2bbe815defde9d40bf7
workflow-type: tm+mt
source-wordcount: '448'
ht-degree: 0%

---


# Om Adobe IMS-autentisering med AEM på Adobes hanterade tjänster{#understanding-adobe-ims-authentication-with-aem-on-adobe-managed-services}

Adobe Experience Manager introducerar stöd för Admin Console för AEM instanser och Adobe IMS-baserad (Identity Management System) AEM i Managed Services.   Tack vare den här integreringen kan AEM Managed Services-kunder hantera alla Experience Cloud-användare i en enda enhetlig webbkonsol. Användare och grupper kan tilldelas produktprofiler som är kopplade till AEM instanser, vilket ger centralt hanterad åtkomst till specifika AEM.

>[!VIDEO](https://video.tv.adobe.com/v/26170?quality=12&learn=on)

* Stöd för Adobe Experience Manager IMS-autentisering gäller endast för&quot;interna&quot; användare (författare, granskare, administratörer, utvecklare osv.) och inte för externa slutanvändare, som besökare på webbplatser.
* [Admin Console](https://adminconsole.adobe.com/) kommer att representera AEM Managed Services-kunder som IMS-organisationer och AEM som produktkontexter. Admin Console system- och produktadministratörer kan definiera och hantera.
* AEM Managed Services synkronisera din topologi med Admin Console och skapa en 1:1-mappning mellan en produktkontext och AEM.
* Produktprofilen i Admin Console avgör vilka AEM som en användare kan komma åt.
* Autentiseringsstödet innefattar kundens SAML2-kompatibla IDP för enkel inloggning.
* Endast Enterprise ID:n eller Federated ID:n (för kundens SSO) stöds (personliga Adobe ID:n stöds inte).

** Den här funktionen stöds för AEM 6.4 SP3 och senare för Adobe Managed Services-kunder.*

## Best practices {#best-practices}

### Tillämpa behörigheter i Admin Console

Tillstånd och åtkomst på användarnivå bör undvikas både i Admin Console och i Adobe Experience Manager.

I Admin Console bör användare ges åtkomst via användargrupper på produktkontextnivå. Användargrupper uttrycks oftast bäst utifrån den logiska rollen inom organisationen för att främja återanvändbarheten för grupper i olika Adobe Experience Cloud-produkter.

>[!NOTE]
>
> Om du använder AEM som Cloud Service ska du tilldela Admin Console användare direkt till produktprofiler. Transitiva behörigheter mellan Admin Console-användare och produktprofiler via Admin Console-användargrupper stöds inte för AEM som Cloud Service.

### Tillämpa behörigheter i Adobe Experience Manager

I Adobe Experience Manager bör användargrupper som synkroniseras från Adobe IMS läggas till i [AEM användargrupper](https://helpx.adobe.com/experience-manager/6-4/sites/administering/using/security.html)som levereras förkonfigurerade med rätt behörighet för att köra vissa uppgifter i AEM. Användare som synkroniseras från Adobe IMS bör inte läggas till direkt i [AEM användargrupper](https://helpx.adobe.com/experience-manager/6-4/sites/administering/using/security.html).
