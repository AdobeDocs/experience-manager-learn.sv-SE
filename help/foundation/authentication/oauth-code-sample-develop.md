---
title: Utveckla OAuth-omfång i AEM
description: Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som är auktoriserat av en slutanvändare. Diagrammet nedan visar hur förfrågningen flödar i samband med AEM.
version: 6.3, 6.4, 6.5
feature: Användare och grupper
topic: Utveckling
role: Developer
level: Experienced
source-git-commit: 7200601c1b59bef5b1546a100589c757f25bf365
workflow-type: tm+mt
source-wordcount: '183'
ht-degree: 0%

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
