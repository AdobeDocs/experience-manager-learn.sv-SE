---
title: Utveckla OAuth-scope i AEM
description: Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som är auktoriserat av en slutanvändare. Bilden nedan visar hur begäran flödar i AEM.
version: Experience Manager 6.4, Experience Manager 6.5
feature: User and Groups
topic: Development
role: Developer
level: Experienced
doc-type: Article
exl-id: dd37355e-cfc7-4581-ac22-d89c951c22cf
duration: 27
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '162'
ht-degree: 0%

---

# Utveckla OAuth-scope

Adobe Experience Manager utökningsbara OAuth-scope ger åtkomstkontroll för resurser från ett klientprogram som godkänts av en slutanvändare. Bilden nedan visar hur begäran flödar i AEM.

![Autoanpassa omfångsflöde](./assets/oauth-code-sample-develop/oauth-scopes-flow.png)

AEM har tre områden:

* Profil
* Offlineåtkomst
* Replikera

AEM utökningsbara OAuth-omfång gör att andra anpassade omfång kan definieras. Ett anpassat omfång kan till exempel utvecklas och distribueras till AEM som tillåter att en mobilapp som auktoriserats via OAuth begränsas till läsning, men inte till att skriva resurser.

OAuth är det rekommenderade sättet att auktorisera ett klientprogram eftersom det använder en åtkomsttoken i stället för att kräva att en AEM-användares inloggningsuppgifter anges för det programmet.

* [Visa koden](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/legacy/bundle/src/main/java/com/adobe/acs/samples/authentication/oauth/impl/SampleScopeWithPrivileges.java)
