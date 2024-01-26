---
title: Utveckla OAuth-omfång i AEM
description: Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som är auktoriserat av en slutanvändare. Diagrammet nedan visar hur förfrågningen flödar i samband med AEM.
version: 6.4, 6.5
feature: User and Groups
topic: Development
role: Developer
level: Experienced
doc-type: Article
exl-id: dd37355e-cfc7-4581-ac22-d89c951c22cf
duration: 34
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '162'
ht-degree: 0%

---

# Utveckla OAuth-scope

Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som godkänts av en slutanvändare. Diagrammet nedan visar hur förfrågningen flödar i samband med AEM.

![Oauth-omfångsflöde](./assets/oauth-code-sample-develop/oauth-scopes-flow.png)

AEM har tre omfattningar:

* Profil
* Offlineåtkomst
* Replikera

AEM utökningsbara OAuth-omfång tillåter andra anpassade omfång att definieras. Ett anpassat omfång kan till exempel utvecklas och distribueras till AEM som tillåter att en mobilapp som auktoriserats via OAuth begränsas till läsning, men inte till att skriva resurser.

OAuth är den metod som rekommenderas för att auktorisera ett klientprogram eftersom den använder en åtkomsttoken i stället för att kräva att en AEM användares autentiseringsuppgifter anges för det programmet.

* [Visa koden](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/legacy/bundle/src/main/java/com/adobe/acs/samples/authentication/oauth/impl/SampleScopeWithPrivileges.java)
