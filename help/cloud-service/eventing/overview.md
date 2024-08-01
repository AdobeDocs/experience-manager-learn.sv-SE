---
title: AEM
description: Lär dig mer om AEM, vad det är, varför och när du ska använda det och exempel på det.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 540
last-substantial-update: 2023-12-07T00:00:00Z
jira: KT-14649
thumbnail: KT-14649.jpeg
exl-id: 142ed6ae-1659-4849-80a3-50132b2f1a86
source-git-commit: efa0a16649c41fab8309786a766483cfeab98867
workflow-type: tm+mt
source-wordcount: '910'
ht-degree: 0%

---

# AEM

Lär dig mer om AEM, vad det är, varför och när du ska använda det och exempel på det.

>[!VIDEO](https://video.tv.adobe.com/v/3426686?quality=12&learn=on)

## Vad det är

AEM Eventing är ett molnbaserat händelsehanteringssystem som gör det möjligt att prenumerera AEM händelser för bearbetning i externa system. En AEM händelse är ett meddelande om tillståndsändring som skickas av AEM när en viss åtgärd inträffar. Detta kan till exempel inkludera händelser när ett innehållsfragment skapas, uppdateras eller tas bort.

![AEM-händelser](./assets/aem-eventing.png)

I bilden ovan visualiserades hur AEM as a Cloud Service skapar händelser och skickar dem till Adobe I/O Events, som i sin tur exponerar dem för händelseabonnenterna.

Sammanfattningsvis finns det tre huvudkomponenter:

1. **Händelseprovider:** AEM as a Cloud Service.
1. **Adobe I/O Events:** Utvecklarplattform för att integrera, utöka och bygga appar och upplevelser baserade på Adobe och tekniker.
1. **Händelsekonsument:** System som ägs av kunden som prenumererar på AEM. Exempel: CRM (Customer Relationship Management), PIM (Product Information Management), OMS (Order Management System) eller ett anpassat program.

### Hur skiljer det sig

[Apache Sling-händelser](https://sling.apache.org/documentation/bundles/apache-sling-eventing-and-job-handling.html), OSGi-händelser och [JCR-observation](https://jackrabbit.apache.org/oak/docs/features/observation.html) innehåller alla funktioner för att prenumerera på och bearbeta händelser. De skiljer sig dock från AEM Eventing som beskrivs i den här dokumentationen.

Viktiga distinktioner i AEM Eventing är:

- Händelsens konsumentkod körs utanför AEM och körs inte i samma JVM som AEM.
- AEM produktkod ansvarar för att definiera händelserna och skicka dem till Adobe I/O Events.
- Händelseinformation standardiseras och skickas i JSON-format. Mer information finns i [molnändringar](https://cloudevents.io/).
- För att kunna kommunicera tillbaka till AEM använder händelsekonsumenten AEM as a Cloud Service API.


## Varför och när det ska användas

AEM Eventing har många fördelar för systemarkitektur och driftseffektivitet. De viktigaste skälen att använda AEM Eventing är:

- **Så här skapar du händelsestyrda arkitekturer**: Gör det enklare att skapa löst kopplade system som kan skalas oberoende av varandra och som är motståndskraftiga mot fel.
- **Låg kod och lägre driftskostnader**: Undviker anpassningar i AEM, vilket leder till system som är enklare att underhålla och utöka, vilket minskar driftskostnaderna.
- **Förenkla kommunikationen mellan AEM och externa system**: Eliminerar punkt-till-punkt-anslutningar genom att låta Adobe I/O Events hantera kommunikationen, till exempel avgöra vilka AEM händelser som ska levereras till specifika system eller tjänster.
- **Högre varaktighet för händelser**: Adobe I/O Events är ett mycket tillgängligt och skalbart system som är utformat för att hantera stora volymer händelser och leverera dem till prenumeranter på ett tillförlitligt sätt.
- **Parallell bearbetning av händelser**: Aktiverar leverans av händelser till flera prenumeranter samtidigt, vilket möjliggör bearbetning av distribuerade händelser i olika system.
- **Programutveckling utan server**: Stöder distribution av händelsens konsumentkod som ett serverlöst program, vilket ger ytterligare flexibilitet och skalbarhet.

### Begränsningar

AEM Eventing har vissa begränsningar att tänka på:

- **Tillgängligheten är begränsad till AEM as a Cloud Service**: För närvarande är AEM endast tillgänglig för AEM as a Cloud Service.
- **Begränsat händelsestöd**: Nu stöds bara AEM Content Fragment-händelser. Omfattningen förväntas dock expandera med ytterligare händelser i framtiden.

## Aktivera

AEM Eventing är aktiverat per AEM as a Cloud Service-miljö och är endast tillgängligt för miljöer i pre-release-läge. Kontakta <a href="mailto:grp-aem-events@adobe.com">AEM-Eventing-teamet</a> om du vill aktivera din AEM med AEM Eventing.

Om den redan är aktiverad kan du läsa [Aktivera AEM i din AEM Cloud Service-miljö](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment) för nästa steg.

## Så här prenumererar du

Om du vill prenumerera på AEM händelser behöver du inte skriva någon kod i AEM, utan i stället är ett [Adobe Developer Console](https://developer.adobe.com/) -projekt konfigurerat. Adobe Developer Console är en gateway till Adobe API:er, SDK:er, Events, Runtime och App Builder.

I det här fallet kan du med ett _projekt_ i Adobe Developer Console prenumerera på händelser som skickas från AEM as a Cloud Service-miljön och konfigurera händelseleveransen till externa system.

Mer information finns i [Prenumerera på AEM i Adobe Developer Console](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#how-to-subscribe-to-aem-events-in-the-adobe-developer-console).

## Hur man konsumerar

Det finns två primära metoder för att använda AEM händelser: metoden _push_ och metoden _pull_.

- **Push-metod**: I den här metoden meddelas händelsekonsumenten aktivt av Adobe I/O-händelser när en händelse blir tillgänglig. Integrationsalternativen är Webhooks, Adobe I/O Runtime och Amazon EventBridge.
- **Pull-metod**: Här avfrågar händelsekonsument aktivt Adobe I/O-händelser för att söka efter nya händelser. Det primära integreringsalternativet för den här metoden är Adobe Developer Journaling API.

Mer information finns i [AEM händelsebearbetning via Adobe I/O-händelser](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#aem-events-processing-via-adobe-io).

## Exempel

<table>
  <tr>
    <td>
        <a  href="./examples/webhook.md"><img alt="Ta emot AEM på en webkrok" src="./assets/examples/webhook/webhook-example.png"/></a>
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
  <tr>
    <td>
        <a  href="./examples/runtime-action.md"><img alt="Ta emot AEM om Adobe I/O Runtime-åtgärd" src="./assets/examples/runtime-action/eventing-runtime.png"/></a>
        <div><strong><a href="./examples/runtime-action.md">Ta emot AEM på Adobe I/O Runtime-åtgärd</a></strong></div>
        <p>
          Ta emot AEM och granska händelseinformationen.
        </p>
      </td>
      <td>
        <a  href="./examples/event-processing-using-runtime-action.md"><img alt="AEM händelsehantering med Adobe I/O Runtime Action" src="./assets/examples/event-processing-using-runtime-action/event-processing.png"/></a>
        <div><strong><a href="./examples/event-processing-using-runtime-action.md">AEM händelsebearbetning med Adobe I/O Runtime Action</a></strong></div>
        <p>
          Lär dig hur du bearbetar mottagna AEM med Adobe I/O Runtime Action. Händelsebearbetningen innehåller AEM återanrop, händelsedatans beständighet och visar dem i SPA.
        </p>
      </td>
  </tr>    
  <tr>
    <td>
        <a  href="./examples/assets-pim-integration.md"><img alt="AEM Assets event for PIM integration" src="./assets/examples/assets-pim-integration/PIM-integration-tile.png"/></a>
        <div><strong><a href="./examples/assets-pim-integration.md">AEM Assets-händelser för PIM-integrering</a></strong></div>
        <p>
          Lär dig hur du integrerar AEM Assets- och PIM-system (Product Information Management) för metadatauppdateringar.
        </p>
      </td>
  </tr>  
</table>
