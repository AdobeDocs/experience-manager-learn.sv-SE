---
title: Webbhooks och AEM
description: Lär dig hur du tar emot AEM händelser på en webbkrok och granskar händelseinformation som nyttolast, rubriker och metadata.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 156
last-substantial-update: 2023-01-29T00:00:00Z
jira: KT-14732
thumbnail: KT-14732.jpeg
source-git-commit: f0930e517254b6353fe50c3bbf9ae915d9ef6ca3
workflow-type: tm+mt
source-wordcount: '550'
ht-degree: 0%

---


# Webbhooks och AEM

Lär dig hur du tar emot AEM på en webbkrok och granskar händelseinformation som nyttolast, huvuden och metadata.

>[!VIDEO](https://video.tv.adobe.com/v/3427051?quality=12&learn=on)

I det här exemplet används en Adobe _webbkrok_ gör att du kan ta emot AEM händelser utan att behöva skapa en egen webkrok. Den här webbkroken som tillhandahålls av Adobe är värd för [Glitch](https://glitch.com/), en plattform som är känd för att erbjuda en webbaserad miljö som underlättar utveckling och driftsättning av webbprogram. Alternativet att använda din egen webkrok är dock också tillgängligt om du vill.

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service miljö med [AEM Eventing aktiverad](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment).

- [Adobe Developer Console-projekt konfigurerat för AEM](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#how-to-subscribe-to-aem-events-in-the-adobe-developer-console).

>[!IMPORTANT]
>
>AEM as a Cloud Service Eventing är bara tillgängligt för registrerade användare i förhandsversionsläge. Om du vill aktivera AEM på din AEM as a Cloud Service miljö kontaktar du [AEM](mailto:grp-aem-events@adobe.com).

## Åtkomst till webkrok

Följ de här stegen för att få åtkomst till webbkroken som tillhandahålls av Adobe:

- Kontrollera att du har åtkomst till [Glitch - webbkrok som värd](https://lovely-ancient-coaster.glitch.me/) på en ny flik i webbläsaren.

  ![Glitch - webbkrok som värd](../assets/examples/webhook/glitch-hosted-webhook.png)

- Ange ett unikt namn för din webkrok, till exempel `<YOUR_PETS_NAME>-aem-eventing` och klicka **Anslut**. Du borde se `Connected to: ${YOUR-WEBHOOK-URL}` visas på skärmen.

  ![Glitch - skapa webkrok](../assets/examples/webhook/glitch-create-webhook.png)

- Anteckna **Webkroks-URL**. Du behöver det senare i den här självstudiekursen.

## Konfigurera webkrok i Adobe Developer Console Project

Följ de här stegen för att ta emot AEM händelser på webbkroks-URL:en ovan:

- I [Adobe Developer Console](https://developer.adobe.com)navigera till projektet och klicka för att öppna det.

- Under **Produkter och tjänster** avsnitt, klicka på ovaler `...` bredvid det önskade händelsekortet som ska skicka AEM till webbkroken och välja **Redigera**.

  ![Redigera Adobe Developer Console-projekt](../assets/examples/webhook/adobe-developer-console-project-edit.png)

- I den nyligen öppnade **Konfigurera händelseregistrering** dialogruta, klicka **Nästa** fortsätta till **Så här tar du emot händelser** steg.

  ![Konfigurera Adobe Developer Console-projekt](../assets/examples/webhook/adobe-developer-console-project-configure.png)

- I **Så här tar du emot händelser** steg, välja **Webkrok** och klistra in **Webkroks-URL** du kopierade tidigare från Glitch-webbkroken och klicka på **Spara konfigurerade händelser**.

  ![Adobe Developer Console Project Webkrok](../assets/examples/webhook/adobe-developer-console-project-webhook.png)

- På Glitch-webbbokssidan bör du se en GET-förfrågan. Det är en utmaningsbegäran som skickas av Adobe I/O Events för att verifiera webboks-URL:en.

  ![Fel - utmaningsbegäran](../assets/examples/webhook/glitch-challenge-request.png)


## Utlös AEM

Så här utlöser du AEM händelser från din AEM as a Cloud Service miljö som har registrerats i ovanstående Adobe Developer Console-projekt:

- Få åtkomst till och logga in i AEM as a Cloud Service redigeringsmiljö via [Cloud Manager](https://my.cloudmanager.adobe.com/).

- Beroende på din **Prenumererade händelser**, skapa, uppdatera, ta bort, publicera eller avpublicera ett innehållsfragment.

## Granska händelseinformation

När du är klar med ovanstående steg bör du se AEM händelser levereras till webbkroken. Leta efter POSTENS förfrågan på Glitch-webbkroksidan.

![Fel - begäran om POST](../assets/examples/webhook/glitch-post-request.png)

Här är viktig information om POSTEN:

- sökväg: `/webhook/${YOUR-WEBHOOK-URL}`, till exempel `/webhook/AdobeTM-aem-eventing`

- rubriker: begäranrubriker som skickas av Adobe I/O-händelser, till exempel:

```json
{
"connection": "close",
"x-forwarded-for": "34.205.178.127,::ffff:10.10.10.136,::ffff:10.10.84.114",
"x-forwarded-proto": "https,http,http",
"x-forwarded-port": "443,80,80",
"host": "lovely-ancient-coaster.glitch.me",
"content-length": "826",
"x-adobe-public-key2-path": "/prod/keys/pub-key-IkpzhSpTw0.pem",
"x-adobe-delivery-id": "18abfb47-d24a-4684-ade8-f442a3444033",
"x-adobe-provider": "aemsites_7ABB3E6A5A7491460A495D61@AdobeOrg_acct-aem-p46652-e1074060@adobe.com",
"x-adobe-public-key1-path": "/prod/keys/pub-key-Ptc2pD9vT9.pem",
"x-adobe-event-id": "a0f3fb7d-b02c-4612-aac6-e472b80af793",
"x-adobe-event-code": "aem.sites.contentFragment.modified",
"user-agent": "Adobe/1.0",
"x-adobe-digital-signature-2": "zGLso15+6PV6X6763/x6WqgxDlEXpkv5ty8q4njaq3aUngAI9VCcYonbScEjljRluzjZ05uMJmRfNxwjj60syxEJPuc0dpmMU635gfna7I4T7IaHs496wx4m2E5mvCM+aKbNQ+NPOutyTqI8Ovq29P2P87GIgMlGhAtOaxRVGNc6ksBxc2tCWbrKUhW8hPJ0sHphU499dN4TT32xrZaiRw4akT3M/hYydsA8dcWpJ7S4dpuDS21YyDHAB8s9Dawtr3fyPEyLgZzpwZDfCqQ8gdSCGqKscE4pScwqPkKOYCHDnBvDZVe583jhcZbHGjk7Ncp/FrgQk7avWsk5XlzcuA==",
"x-adobe-digital-signature-1": "QD7THFJ1vmJqD/BatIpzO6+ACQ9cSKPR7XVaW0LI7cN/xs7ucyri6dmkerOPe9EJpjGoqCg8rxWedrIRQB3lgVskChbHH3Ujx5YG0aTQLSd1Lsn5CFbW1U0l0GqId9Cnd6MccrqSznZXcdW1rMFuRk8+gqwabBifSaLbu3r30G5hmqQd72VtiYTE4m23O3jYIMiv62pRP+a+p4NjNj1XG320uRSry+BPniTjDJ6oN/Ng7aUEKML8idZ/ZTqeh/rJSrVO95UryUolFDRwDkRn5zKonbvhSLAeXzaPhvimWUHtldq9M1WTyRMpsBk8BRzaklxlq+woJ2UjYPUIEzjotw==",
"accept-encoding": "deflate,compress,identity",
"content-type": "application/cloudevents+json; charset=UTF-8",
"x-forwarded-host": "lovely-ancient-coaster.glitch.me",
"traceparent": "00-c27558588d994f169186ca6a3c6607d4-a7e7ee36625488d4-01"
}
```

- body/payload: request body sent by the Adobe I/O Events, till exempel:

```json
{
  "specversion": "1.0",
  "type": "aem.sites.contentFragment.modified",
  "source": "acct:aem-p46652-e1074060@adobe.com",
  "id": "bf922a49-9db4-4377-baf4-70e96e15c45f",
  "time": "2023-12-12T20:36:43.583228Z",
  "dataschema": "https://ns.adobe.com/xdm/aem/sites/events/content-fragment-modified.json",
  "datacontenttype": "application/json",
  "data": {
    "user": {
      "imsUserId": "933E1F8A631CAA0F0A495E53@80761f6e631c0c7d495fb3.e",
      "principalId": "xxx@adobe.com",
      "displayName": "First LastName",
    },
    "path": "/content/dam/wknd-shared/en/adventures/beervana-portland/beervana-in-portland",
    "model": {
      "id": "/conf/wknd-shared/settings/dam/cfm/models/adventure"
    },
    "id": "9a2d3e6a-efda-4079-a86e-0ef2ede692da",
    "properties": [
      {
        "name": "groupSize",
        "changeType": "modified"
      }
    ]
  },
  "event_id": "a0f3fb7d-b02c-4612-aac6-e472b80af793",
  "recipient_client_id": "f51ea733ba404db299fefbf285dc1c42"
}
```

Du kan se att informationen om AEM har all information som krävs för att bearbeta händelsen i webkroken. Händelsetypen (`type`), händelsekälla (`source`), händelse-id (`event_id`), händelsetid (`time`) och händelsedata (`data`).

## Ytterligare resurser

- [Källkod för webbkrok med fel](https://glitch.com/edit/#!/bedårande-antika-coaster) finns att referera till.
