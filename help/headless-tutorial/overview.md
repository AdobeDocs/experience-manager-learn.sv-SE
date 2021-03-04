---
title: AEM Headless-självstudiekurser
description: En samling självstudiekurser om hur du använder Adobe Experience Manager som Headless CMS.
feature: Innehållsfragment, API:er
topic: Headless, Content Management
role: Developer
level: Nybörjare
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '468'
ht-degree: 0%

---


# AEM Headless-självstudiekurser

Adobe Experience Manager har flera alternativ för att definiera headless-slutpunkter och leverera innehållet som JSON. Använd praktiska självstudiekurser för att utforska hur du använder de olika alternativen och väljer vad som passar dig bäst.

## AEM GraphQL API:er, genomgång

>[!CAUTION]
>
> AEM GraphQL API för leverans av innehållsfragment är tillgänglig på begäran.
> Kontakta Adobe Support för att aktivera API:t för din AEM som ett Cloud Service-program.

AEM GraphQL API:er för innehållsfragment
har stöd för headless CMS-scenarier där externa klientprogram återger upplevelser med innehåll som hanteras i AEM.

Ett modernt API för innehållsleverans är avgörande för effektiviteten och prestandan i Javascript-baserade klientprogram. Att använda ett REST API medför utmaningar:

* Ett stort antal begäranden om att hämta ett objekt i taget
* Innehåll som ofta&quot;överlevererar&quot;, vilket innebär att programmet får mer än det behöver

För att övervinna dessa utmaningar tillhandahåller GraphQL ett frågebaserat API som gör att klienter kan fråga AEM efter endast det innehåll som behövs och ta emot via ett enda API-anrop.

* Lär dig använda AEM GraphQL API:er i självstudiekursen [Komma igång med AEM GraphQL API:er](./graphql/overview.md)

## Självstudiekurs om tokenbaserad autentisering

AEM visar en mängd olika HTTP-slutpunkter som kan interagera med utan kanter, från GraphQL AEM Content Services till Assets HTTP API. Dessa headless-användare kan ofta behöva autentisera sig för AEM för att få tillgång till skyddat innehåll eller skyddade åtgärder. För att underlätta detta stöder AEM tokenbaserad autentisering av HTTP-begäranden från externa program, tjänster eller system.

* Lär dig hur du autentiserar till AEM via HTTP med åtkomsttoken i [Autentiserar till AEM som en Cloud Service från en extern programsjälvstudiekurs](./authentication/overview.md)

## AEM Content Services, genomgång

AEM Content Services använder traditionella AEM Pages för att skapa rubrikfria REST API-slutpunkter och AEM Components definierar, eller refererar, innehållet som ska visas på dessa slutpunkter.

AEM Content Services tillåter att samma innehållsavvikelser som används för att skapa webbsidor i AEM Sites definierar innehållet och schemana för dessa HTTP API:er. Med AEM Pages och AEM Components kan marknadsförarna snabbt komponera och uppdatera flexibla JSON API:er som kan användas i alla applikationer.

* Lär dig använda AEM Content Services i självstudiekursen [Komma igång med AEM Content Services](./content-services/overview.md)

## AEM GraphQL vs. AEM Content Services

|  | AEM GraphQL API:er | AEM Content Services |
|--------------------------------|:-----------------|:---------------------|
| Schemadefinition | Strukturerade modeller för innehållsfragment | AEM |
| Innehåll | Innehållsfragment | AEM |
| Innehållsidentifiering | Efter GraphQL-fråga | Efter AEM |
| Leveransformat | GraphQL JSON | AEM ComponentExporter JSON |

## Andra praktiska självstudiekurser

Andra självstudiekurser AEM headless concepts är:

* [Komma igång med AEM SPA Editor och Angular](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-angular-tutorial/overview.html)
* [Komma igång med AEM SPA Editor och React](https://experienceleague.adobe.com/docs/experience-manager-learn/spa-react-tutorial/overview.html)