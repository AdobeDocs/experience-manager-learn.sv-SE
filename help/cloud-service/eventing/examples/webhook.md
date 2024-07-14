---
title: Webbhooks och AEM
description: Lär dig hur du tar emot AEM händelser på en webbkrok och granskar händelseinformation som nyttolast, rubriker och metadata.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 358
last-substantial-update: 2023-01-29T00:00:00Z
jira: KT-14732
thumbnail: KT-14732.jpeg
exl-id: 00954d74-c4c7-4dac-8d23-7140c49ae31f
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '550'
ht-degree: 0%

---

# Webbhooks och AEM

Lär dig hur du tar emot AEM på en webbkrok och granskar händelseinformation som nyttolast, huvuden och metadata.

>[!VIDEO](https://video.tv.adobe.com/v/3427051?quality=12&learn=on)

I det här exemplet kan du använda en _webbkrok_ som tillhandahålls av Adobe för att ta emot AEM händelser utan att behöva konfigurera en egen webbkrok. Den här webbkroken som tillhandahålls av Adobe finns på [Glitch](https://glitch.com/), en plattform som är känd för att erbjuda en webbaserad miljö som underlättar skapandet och distributionen av webbprogram. Alternativet att använda din egen webkrok är dock också tillgängligt om du vill.

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service-miljö med [AEM Eventing aktiverat](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment).

- [Adobe Developer Console-projekt konfigurerat för AEM ](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#how-to-subscribe-to-aem-events-in-the-adobe-developer-console).

>[!IMPORTANT]
>
>AEM as a Cloud Service Eventing är endast tillgängligt för registrerade användare i förhandsversionsläge. Om du vill aktivera AEM i din AEM as a Cloud Service-miljö kontaktar du [AEM-Eventing team](mailto:grp-aem-events@adobe.com).

## Åtkomst till webkrok

Följ de här stegen för att få åtkomst till webbkroken som tillhandahålls av Adobe:

- Kontrollera att du har åtkomst till [Glitch - webbhokrok](https://lovely-ancient-coaster.glitch.me/) på en ny webbläsarflik.

  ![Fel - webbkrok som finns på webben](../assets/examples/webhook/glitch-hosted-webhook.png)

- Ange ett unikt namn för din webkrok, till exempel `<YOUR_PETS_NAME>-aem-eventing`, och klicka på **Anslut**. Du bör se `Connected to: ${YOUR-WEBHOOK-URL}` meddelande visas på skärmen.

  ![Fel - skapa webkrok](../assets/examples/webhook/glitch-create-webhook.png)

- Anteckna **Webkroks-URL**. Du behöver det senare i den här självstudiekursen.

## Konfigurera webkrok i Adobe Developer Console Project

Följ de här stegen för att ta emot AEM händelser på webbkroks-URL:en ovan:

- Gå till ditt projekt i [Adobe Developer Console](https://developer.adobe.com) och klicka för att öppna det.

- Under avsnittet **Produkter och tjänster** klickar du på ellipser `...` bredvid önskat händelsekort som ska skicka AEM till webbkroken och välja **Redigera**.

  ![Adobe Developer Console Project Edit](../assets/examples/webhook/adobe-developer-console-project-edit.png)

- I den nyligen öppnade dialogrutan **Konfigurera händelseregistrering** klickar du på **Nästa** för att fortsätta till **Så här tar du emot händelser**.

  ![Adobe Developer Console Project Configure](../assets/examples/webhook/adobe-developer-console-project-configure.png)

- I steget **Så här tar du emot händelser** väljer du alternativet **Webkrok** och klistrar in den **Webkrok-URL** som du kopierade tidigare från webkroken Glitch. Klicka sedan på **Spara konfigurerade händelser**.

  ![Adobe Developer Console Project Webkrok](../assets/examples/webhook/adobe-developer-console-project-webhook.png)

- På Glitch-webbbokssidan bör du se en GET-förfrågan. Det är en utmaningsbegäran som skickas av Adobe I/O Events för att verifiera webboks-URL:en.

  ![Fel - utmaningsbegäran](../assets/examples/webhook/glitch-challenge-request.png)


## Utlös AEM

Så här utlöser du AEM händelser från din AEM as a Cloud Service-miljö som har registrerats i ovanstående Adobe Developer Console-projekt:

- Få åtkomst till och logga in i AEM as a Cloud Service redigeringsmiljö via [Cloud Manager](https://my.cloudmanager.adobe.com/).

- Beroende på dina **Prenumererade händelser** kan du skapa, uppdatera, ta bort, publicera eller avpublicera ett innehållsfragment.

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

Du kan se att informationen om AEM har all information som krävs för att bearbeta händelsen i webkroken. Händelsetypen (`type`), händelsekällan (`source`), händelse-ID (`event_id`), händelsetypen (`time`) och händelsedata (`data`).

## Ytterligare resurser

- [Källkoden för Glitch-webkrok](https://glitch.com/edit/#!/bedårande-antika-coaster) är tillgänglig för referens.
