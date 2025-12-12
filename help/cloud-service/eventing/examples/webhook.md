---
title: Webbhooks och AEM Events
description: Lär dig hur du tar emot AEM Events på en webbkrok och granskar händelseinformation som nyttolast, rubriker och metadata.
version: Experience Manager as a Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
duration: 358
last-substantial-update: 2023-01-29T00:00:00Z
jira: KT-14732
thumbnail: KT-14732.jpeg
exl-id: 00954d74-c4c7-4dac-8d23-7140c49ae31f
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '523'
ht-degree: 0%

---

# Webbhooks och AEM Events

Lär dig hur du tar emot AEM-händelser på en webbkrok och granskar händelseinformation som nyttolast, sidhuvuden och metadata.


>[!VIDEO](https://video.tv.adobe.com/v/3427051?quality=12&learn=on)


>[!IMPORTANT]
>
>Videon refererar till en Glitch-webbkrok-slutpunkt. Eftersom Glitch har upphört med sin värdtjänst har webkroken migrerats till Azure App Service.
>
>Funktionen är densamma - bara värdplattformen har ändrats.


I stället för att använda Adobe webbkrok som exempel kan du också använda din egen webbkrokslutpunkt för att ta emot AEM Events.

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service-miljö med [AEM Eventing aktiverat](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment).

- [Adobe Developer Console-projekt konfigurerat för AEM Events](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#how-to-subscribe-to-aem-events-in-the-adobe-developer-console).


## Åtkomst till webkrok

Följ de här stegen för att få åtkomst till Adobe exempelwebkrok:

- Kontrollera att du har åtkomst till [Adobe-exempelwebkroken](https://aemeventing-webhook.azurewebsites.net/) på en ny webbläsarflik.

  ![Adobe tillhandahöll exempel-webkrok](../assets/examples/webhook/adobe-provided-webhook.png)

- Ange ett unikt namn för din webkrok, till exempel `<YOUR_PETS_NAME>-aem-eventing`, och klicka på **Anslut**. Du bör se `Connected to: ${YOUR-WEBHOOK-URL}` meddelande visas på skärmen.

  ![Skapa din webkrok-slutpunkt](../assets/examples/webhook/create-webhook-endpoint.png)

- Anteckna **Webkroks-URL**. Du behöver det senare i den här självstudiekursen.

## Konfigurera webkrok i Adobe Developer Console Project

Så här tar du emot AEM Events på webbholländarens URL:

- Gå till ditt projekt i [Adobe Developer Console](https://developer.adobe.com) och klicka för att öppna det.

- Under avsnittet **Produkter och tjänster** klickar du på ellipser `...` bredvid önskat händelsekort som ska skicka AEM-händelser till webbkroken och välja **Redigera**.

  ![Adobe Developer Console Project Edit](../assets/examples/webhook/adobe-developer-console-project-edit.png)

- I den nyligen öppnade dialogrutan **Konfigurera händelseregistrering** klickar du på **Nästa** för att fortsätta till **Så här tar du emot händelser**.

  ![Adobe Developer Console Project Configure](../assets/examples/webhook/adobe-developer-console-project-configure.png)

- I steget **Så här tar du emot händelser** väljer du alternativet **Webkrok** och klistrar in den **Webkrok-URL** som du kopierade tidigare från Adobe-exempelwebbkroken. Klicka sedan på **Spara konfigurerade händelser**.

  ![Adobe Developer Console Project Webkrok](../assets/examples/webhook/adobe-developer-console-project-webhook.png)

- På Adobe exempelwebbplats bör du se en GET-förfrågan. Det är en förfrågan från Adobe I/O Events att verifiera webkroks-URL:en.

  ![Webkrok - utmaningsbegäran](../assets/examples/webhook/webhook-challenge-request.png)


## Utlös AEM-event

Så här utlöser du AEM-händelser från din AEM as a Cloud Service-miljö som har registrerats i ovanstående Adobe Developer Console-projekt:

- Få åtkomst till och logga in i AEM as a Cloud Service redigeringsmiljö via [Cloud Manager](https://my.cloudmanager.adobe.com/).

- Beroende på dina **Prenumererade händelser** kan du skapa, uppdatera, ta bort, publicera eller avpublicera ett innehållsfragment.

## Granska händelseinformation

När du är klar med ovanstående steg bör du se vilka AEM Events som levereras till webbkroken. Leta efter POST-begäran på Adobe exempelwebbkroksida.

![Webkrok - POST-begäran](../assets/examples/webhook/webhook-post-request.png)

Här är viktig information om POST-begäran:

- sökväg: `/webhook/${YOUR-WEBHOOK-URL}`, till exempel `/webhook/AdobeTM-aem-eventing`

- rubriker: begäranrubriker som skickas av Adobe I/O Events, till exempel:

```json
{
  "host": "aemeventing-webhook.azurewebsites.net",
  "user-agent": "Adobe/1.0",
  "accept-encoding": "deflate,compress,identity",
  "max-forwards": "10",
  "x-adobe-public-key2-path": "/prod/keys/pub-key-kruhWwu4Or.pem",
  "x-adobe-delivery-id": "25c36f70-9238-4e4c-b1d8-4d9a592fed9d",
  "x-adobe-provider": "aemsites_7ABB3E6A5A7491460A495D61@AdobeOrg_acct-aem-p63947-e1249010@adobe.com",
  "x-adobe-public-key1-path": "/prod/keys/pub-key-lyTiz3gQe4.pem",
  "x-adobe-event-id": "b555a1b1-935b-4541-b410-1915775338b5",
  "x-adobe-event-code": "aem.sites.contentFragment.modified",
  "x-adobe-digital-signature-2": "Lvw8+txbQif/omgOamJXJaJdJMLDH5BmPA+/RRLhKG2LZJYWKiomAE9DqKhM349F8QMdDq6FXJI0vJGdk0FGYQa6JMrU+LK+1fGhBpO98LaJOdvfUQGG/6vq8/uJlcaQ66tuVu1xwH232VwrQOKdcobE9Pztm6UX0J11Uc7vtoojUzsuekclKEDTQx5vwBIYK12bXTI9yLRsv0unBZfNRrV0O4N7KA9SRJFIefn7hZdxyYy7IjMdsoswG36E/sDOgcnW3FVM+rhuyWEizOd2AiqgeZudBKAj8ZPptv+6rZQSABbG4imOa5C3t85N6JOwffAAzP6qs7ghRID89OZwCg==",
  "x-adobe-digital-signature-1": "ZQywLY1Gp/MC/sXzxMvnevhnai3ZG/GaO4ThSGINIpiA/RM47ssAw99KDCy1loxQyovllEmN0ifAwfErQGwDa5cuJYEoreX83+CxqvccSMYUPb5JNDrBkG6W0CmJg6xMeFeo8aoFbePvRkkDOHdz6nT0kgJ70x6mMKgCBM+oUHWG13MVU3YOmU92CJTzn4hiSK8o91/f2aIdfIui/FDp8U20cSKKMWpCu25gMmESorJehe4HVqxLgRwKJHLTqQyw6Ltwy2PdE0guTAYjhDq6AUd/8Fo0ORCY+PsS/lNxim9E9vTRHS7TmRuHf7dpkyFwNZA6Au4GWHHS87mZSHNnow==",
  "x-arr-log-id": "881073f0-7185-4812-9f17-4db69faf2b68",
  "client-ip": "52.37.214.82:46066",
  "disguised-host": "aemeventing-webhook.azurewebsites.net",
  "x-site-deployment-id": "aemeventing-webhook",
  "was-default-hostname": "aemeventing-webhook.azurewebsites.net",
  "x-forwarded-proto": "https",
  "x-appservice-proto": "https",
  "x-arr-ssl": "2048|256|CN=Microsoft Azure RSA TLS Issuing CA 03, O=Microsoft Corporation, C=US|CN=*.azurewebsites.net, O=Microsoft Corporation, L=Redmond, S=WA, C=US",
  "x-forwarded-tlsversion": "1.3",
  "x-forwarded-for": "52.37.214.82:46066",
  "x-original-url": "/webhook/AdobeTechMarketing-aem-eventing",
  "x-waws-unencoded-url": "/webhook/AdobeTechMarketing-aem-eventing",
  "x-client-ip": "52.37.214.82",
  "x-client-port": "46066",
  "content-type": "application/cloudevents+json; charset=UTF-8",
  "content-length": "1178"
}
```

- body/payload: request body sent by Adobe I/O Events, till exempel:

```json
{
  "specversion": "1.0",
  "id": "83b0eac0-56d6-4499-afa6-4dc58ff6ac7f",
  "source": "acct:aem-p63947-e1249010@adobe.com",
  "type": "aem.sites.contentFragment.modified",
  "datacontenttype": "application/json",
  "dataschema": "https://ns.adobe.com/xdm/aem/sites/events/content-fragment-modified.json",
  "time": "2025-07-24T13:53:23.994109827Z",
  "eventid": "b555a1b1-935b-4541-b410-1915775338b5",
  "event_id": "b555a1b1-935b-4541-b410-1915775338b5",
  "recipient_client_id": "606d4074c7ea4962aaf3bc2a5ac3b7f9",
  "recipientclientid": "606d4074c7ea4962aaf3bc2a5ac3b7f9",
  "data": {
    "user": {
      "imsUserId": "ims-933E1F8A631CAA0F0A495E53@80761f6e631c0c7d495fb3.e",
      "principalId": "xx@adobe.com",
      "displayName": "Sachin Mali"
    },
    "path": "/content/dam/wknd-shared/en/adventures/beervana-portland/beervana-in-portland",
    "sourceUrl": "https://author-p63947-e1249010.adobeaemcloud.com",
    "model": {
      "id": "L2NvbmYvd2tuZC1zaGFyZWQvc2V0dGluZ3MvZGFtL2NmbS9tb2RlbHMvYWR2ZW50dXJl",
      "path": "/conf/wknd-shared/settings/dam/cfm/models/adventure"
    },
    "id": "9e1e9835-64c8-42dc-9d36-fbd59e28f753",
    "tags": [
      "wknd-shared:region/nam/united-states",
      "wknd-shared:activity/social",
      "wknd-shared:season/fall"
    ],
    "properties": [
      {
        "name": "price",
        "changeType": "modified"
      }
    ]
  }
}
```

Du ser att informationen om AEM-händelsen innehåller all information som krävs för att händelsen ska kunna bearbetas i webkroken. Händelsetypen (`type`), händelsekällan (`source`), händelse-ID (`event_id`), händelsetypen (`time`) och händelsedata (`data`).

## Ytterligare resurser

- [AEM-Eventing Webkroks](../assets/examples/webhook/aemeventing-webhook.tgz)-källkoden finns tillgänglig för referens.
