---
title: AEM
description: Lär dig mer om AEM, vad det är, varför och när du ska använda det och exempel på det.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 573
last-substantial-update: 2023-12-07T00:00:00Z
jira: KT-14649
thumbnail: KT-14649.jpeg
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '841'
ht-degree: 0%

---


# AEM

Lär dig mer om AEM, vad det är, varför och när du ska använda det och exempel på det.

>[!VIDEO](https://video.tv.adobe.com/v/3426686?quality=12&learn=on)

>[!IMPORTANT]
>
>AEM as a Cloud Service Eventing är bara tillgängligt för registrerade användare i förhandsversionsläge. Om du vill aktivera AEM på din AEM as a Cloud Service miljö kontaktar du [AEM](mailto:grp-aem-events@adobe.com).

## Vad det är

AEM Eventing är ett molnbaserat händelsehanteringssystem som gör det möjligt att prenumerera AEM händelser för bearbetning i externa system. En AEM händelse är ett meddelande om tillståndsändring som skickas av AEM när en viss åtgärd inträffar. Detta kan till exempel inkludera händelser när ett innehållsfragment skapas, uppdateras eller tas bort.

![AEM](./assets/aem-eventing.png)

I bilden ovan visualiserades hur AEM as a Cloud Service skapar händelser och skickar dem till Adobe I/O Events, som i sin tur exponerar dem för händelseprenumeranter.

Sammanfattningsvis finns det tre huvudkomponenter:

1. **Händelseprovider:** AEM as a Cloud Service.
1. **Adobe I/O-händelser:** Utvecklingsplattform för integrering, utökning och byggande av appar och upplevelser baserade på Adobe produkter och tekniker.
1. **Händelsekonsument:** System som ägs av kunden som prenumererar på AEM Events. Exempel: CRM (Customer Relationship Management), PIM (Product Information Management), OMS (Order Management System) eller ett anpassat program.

### Hur skiljer det sig

The [Apache Sling-händelser](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html), OSGi-händelser och [JCR-observation](https://jackrabbit.apache.org/oak/docs/features/observation.html) alla erbjuder mekanismer för att prenumerera på och bearbeta händelser. De skiljer sig dock från AEM Eventing som beskrivs i den här dokumentationen.

Viktiga distinktioner i AEM Eventing är:

- Händelsens konsumentkod körs utanför AEM och körs inte i samma JVM som AEM.
- AEM produktkod ansvarar för att definiera händelserna och skicka dem till Adobe I/O Events.
- Händelseinformation standardiseras och skickas i JSON-format. Mer information finns i [moln](https://cloudevents.io/).
- För att kunna kommunicera tillbaka till AEM använder händelsekonsumenten det AEM as a Cloud Service API:t.


## Varför och när det ska användas

AEM Eventing har många fördelar för systemarkitektur och driftseffektivitet. De viktigaste skälen att använda AEM Eventing är:

- **Bygga händelsestyrda arkitekturer**: Underlättar skapandet av löst kopplade system som kan byggas ut oberoende av varandra och som är motståndskraftiga mot fel.
- **Låg kod och lägre driftskostnader**: Undviker anpassningar i AEM, vilket gör det enklare att underhålla och utöka system, vilket minskar driftskostnaderna.
- **Förenkla kommunikationen mellan AEM och externa system**: Eliminerar punkt-till-punkt-anslutningar genom att låta Adobe I/O Events hantera kommunikationen, t.ex. avgöra vilka AEM som ska levereras till specifika system eller tjänster.
- **Högre varaktighet för händelser**: Adobe I/O Events är ett mycket tillgängligt och skalbart system som är utformat för att hantera stora volymer händelser och på ett tillförlitligt sätt leverera dem till prenumeranter.
- **Parallell bearbetning av händelser**: Gör det möjligt att leverera händelser till flera prenumeranter samtidigt, vilket möjliggör bearbetning av distribuerade händelser i olika system.
- **Programutveckling utan server**: Stöder driftsättning av händelsens konsumentkod som en serverlös applikation, vilket ger ytterligare flexibilitet och skalbarhet.

### Begränsningar

AEM Eventing har vissa begränsningar att tänka på:

- **Tillgängligheten är begränsad till AEM as a Cloud Service**: För närvarande är AEM Eventing exklusivt tillgängligt för AEM as a Cloud Service.
- **Begränsat händelsestöd**: Från och med nu stöds bara AEM Content Fragment-händelser. Omfattningen förväntas dock expandera med ytterligare händelser i framtiden.

## Aktivera

AEM Eventing är aktiverat per AEM as a Cloud Service miljö och är endast tillgängligt för miljöer i pre-release-läge. Kontakt [AEM](mailto:grp-aem-events@adobe.com) för att möjliggöra AEM med AEM Eventing.

Om den redan är aktiverad, se [Aktivera AEM i din AEM Cloud Service-miljö](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment) för nästa steg.

## Så här prenumererar du

Om du vill prenumerera på AEM händelser behöver du inte skriva någon kod i AEM, utan i stället en [Adobe Developer Console](https://developer.adobe.com/) projektet är konfigurerat. Adobe Developer Console är en gateway till Adobe API:er, SDK:er, Events, Runtime och App Builder.

I det här fallet _projekt_ i Adobe Developer Console kan du prenumerera på händelser som skickas från AEM as a Cloud Service miljöer och konfigurera händelseleveransen till externa system.

Mer information finns i [Prenumerera på AEM händelser i Adobe Developer Console](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#how-to-subscribe-to-aem-events-in-the-adobe-developer-console).

## Hur man konsumerar

Det finns två primära metoder för AEM: _push_ -metoden och _pull_ -metod.

- **Push-metod**: I det här tillvägagångssättet meddelas händelsekonsumenten aktivt av Adobe I/O Events när en händelse blir tillgänglig. Integrationsalternativen är Webhooks, Adobe I/O Runtime och Amazon EventBridge.
- **Pull-metod**: Här avfrågar händelsekonsument aktivt Adobe I/O Events för att söka efter nya händelser. Det primära integrationsalternativet för den här metoden är Adobe I/O-API:t för journalföring.

Mer information finns i [AEM via Adobe I/O Events](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#aem-events-processing-via-adobe-io).

## Exempel

<table>
  <tr>
    <td>
        <a  href="./examples/webhook.md"><img alt="Ta emot AEM på en webkrok" src="./assets/examples/webhook/Eventing-webhook.png"/></a>
        <div><strong><a href="./examples/webhook.md">Ta emot AEM på en webkrok</a></strong></div>
        <p>
          Använd webbkroken som tillhandahålls av Adobe för att ta emot AEM och granska händelseinformationen.
        </p>
      </td>
      <td>
        <a  href="./examples/journaling.md"><img alt="Läs in AEM händelsejournal" src="./assets/examples/journaling/eventing-journal.png"/></a>
        <div><strong><a href="./examples/journaling.md">Läs in AEM händelsejournal</a></strong></div>
        <p>
          Använd webbprogrammet som tillhandahålls av Adobe för att läsa in AEM händelser från journalen och granska händelseinformationen.
        </p>
      </td>
    </tr>
</table>
