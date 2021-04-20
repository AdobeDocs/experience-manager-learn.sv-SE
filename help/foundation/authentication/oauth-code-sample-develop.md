---
title: Utveckla OAuth-omfång i AEM
description: Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som är auktoriserat av en slutanvändare. Diagrammet nedan visar hur förfrågningen flödar i samband med AEM.
version: 6.3, 6.4, 6.5
feature: Users and Groups
topics: authentication, security
activity: develop
audience: developer
doc-type: code
topic: Development
role: Developer
level: Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '185'
ht-degree: 2%

---


# Utveckla OAuth-scope

Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som godkänts av en slutanvändare. Diagrammet nedan visar hur förfrågningen flödar i samband med AEM.

![Oauth-omfångsflöde](./assets/oauth-code-sample-develop/oauth-scopes-flow.png)

AEM har tre omfattningar:

* Profil
* Offlineåtkomst
* Replikera

AEM utökningsbara OAuth-omfång gör det möjligt att definiera andra anpassade omfång. Ett anpassat omfång kan till exempel utvecklas och distribueras till AEM som tillåter att en mobilapp som auktoriserats via OAuth begränsas till läsning, men inte till att skriva resurser.

OAuth är den metod som rekommenderas för att auktorisera ett klientprogram eftersom den använder en åtkomsttoken i stället för att kräva att en AEM användares autentiseringsuppgifter anges för det programmet.

* [Visa koden](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/legacy/bundle/src/main/java/com/adobe/acs/samples/authentication/oauth/impl/SampleScopeWithPrivileges.java)
