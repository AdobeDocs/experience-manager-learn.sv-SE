---
title: Journalföring och AEM
description: Lär dig hur du hämtar den första uppsättningen AEM händelser från journalen och utforskar detaljer om varje händelse.
version: Cloud Service
feature: Developing, App Builder
topic: Development, Architecture, Content Management
role: Architect, Developer
level: Beginner
doc-type: Tutorial
duration: 280
last-substantial-update: 2023-01-29T00:00:00Z
jira: KT-14734
thumbnail: KT-14734.jpeg
exl-id: 33eb0757-f0ed-4c2d-b8b9-fa6648e87640
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '630'
ht-degree: 0%

---

# Journalföring och AEM

Lär dig hur du hämtar den första uppsättningen AEM händelser från journalen och utforskar detaljer om varje händelse.

>[!VIDEO](https://video.tv.adobe.com/v/3427052?quality=12&learn=on)

Journalföring är en pull-metod för att förbruka AEM händelser, och en journal är en ordnad lista över händelser. Med hjälp av API:t för Adobe I/O Events-journalföring kan du hämta AEM händelser från journalen och bearbeta dem i ditt program. Med den här metoden kan du hantera händelser baserat på en viss gräns och effektivt bearbeta dem flera gånger. Se [Journalföringen](https://developer.adobe.com/events/docs/guides/journaling_intro/) för ingående insikter, inklusive viktiga överväganden som kvarhållningsperioder, sidnumrering med mera.

Inom Adobe Developer Console-projektet aktiveras automatiskt alla händelseregistreringar för journalföring, vilket möjliggör smidig integrering.

I det här exemplet kan du använda ett _webbprogram_ som tillhandahålls av Adobe för att hämta den första gruppen AEM händelser från journalen utan att behöva konfigurera ditt program. Det här webbprogrammet som tillhandahålls av Adobe finns på [Glitch](https://glitch.com/), en plattform som är känd för att erbjuda en webbaserad miljö som underlättar skapandet och distributionen av webbprogram. Alternativet att använda ditt eget program är dock tillgängligt om du vill.

## Förutsättningar

För att kunna genomföra den här självstudiekursen behöver du:

- AEM as a Cloud Service-miljö med [AEM Eventing aktiverat](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#enable-aem-events-on-your-aem-cloud-service-environment).

- [Adobe Developer Console-projekt konfigurerat för AEM ](https://developer.adobe.com/experience-cloud/experience-manager-apis/guides/events/#how-to-subscribe-to-aem-events-in-the-adobe-developer-console).

>[!IMPORTANT]
>
>AEM as a Cloud Service Eventing är endast tillgängligt för registrerade användare i förhandsversionsläge. Om du vill aktivera AEM i din AEM as a Cloud Service-miljö kontaktar du [AEM-Eventing team](mailto:grp-aem-events@adobe.com).

## Åtkomst till webbprogram

Följ de här stegen för att få åtkomst till webbprogrammet som tillhandahålls av Adobe:

- Kontrollera att du har åtkomst till [Glitch - webbprogrammet ](https://indigo-speckle-antler.glitch.me/) på en ny webbläsarflik.

  ![Fel - webbprogram som är värd](../assets/examples/journaling/glitch-hosted-web-application.png)

## Samla in projektinformation om Adobe Developer Console

Om du vill hämta AEM från journalen krävs autentiseringsuppgifter som _IMS-organisations-ID_, _klient-ID_ och _åtkomsttoken_. Så här samlar du in autentiseringsuppgifterna:

- Gå till ditt projekt i [Adobe Developer Console](https://developer.adobe.com) och klicka för att öppna det.

- Klicka på länken **OAuth-server-till-server** under avsnittet **Autentiseringsuppgifter** för att öppna fliken **Information om autentiseringsuppgifter**.

- Klicka på knappen **Generera åtkomsttoken** för att generera åtkomsttoken.

  ![Adobe Developer Console Project Generate Access Token](../assets/examples/journaling/adobe-developer-console-project-generate-access-token.png)

- Kopiera **genererad åtkomsttoken**, **KLIENT-ID** och **ORGANISATIONS-ID**. Du behöver dem senare i kursen.

  ![Adobe Developer Console Project Copy Credentials](../assets/examples/journaling/adobe-developer-console-project-copy-credentials.png)

- Alla händelseregistreringar aktiveras automatiskt för journalföring. Om du vill hämta den _unika journalskrifts-API-slutpunkten_ för din händelseregistrering klickar du på det händelsekort som prenumererar på AEM händelser. Kopiera **JOURNALING UNIQUE API ENDPOINT** från fliken **Registreringsinformation**.

  ![Adobe Developer Console Project Events-kort](../assets/examples/journaling/adobe-developer-console-project-events-card.png)

## Läs in AEM händelsejournal

För att hålla saker och ting enkla hämtar det här värdbaserade webbprogrammet bara den första gruppen AEM händelser från journalen. Det här är äldsta tillgängliga händelser i journalen. Mer information finns i [den första gruppen med händelser](https://developer.adobe.com/events/docs/guides/api/journaling_api/#fetching-your-first-batch-of-events-from-the-journal).

- I webbprogrammet [Glitch - hosted](https://indigo-speckle-antler.glitch.me/) anger du det **IMS Organization ID**, **Client ID** och **Access Token** som du kopierade tidigare från Adobe Developer Console-projektet och klickar på **Submit**.

- När det är klart visas AEM händelseregistreringsdata i tabellkomponenten.

  ![AEM händelsejournaldata](../assets/examples/journaling/load-journal.png)

- Dubbelklicka på raden om du vill visa hela händelsens nyttolast. Du kan se att informationen om AEM har all information som krävs för att bearbeta händelsen i webkroken. Händelsetypen (`type`), händelsekällan (`source`), händelse-ID (`event_id`), händelsetypen (`time`) och händelsedata (`data`).

  ![Slutför AEM ](../assets/examples/journaling/complete-journal-data.png)

## Ytterligare resurser

- [Källkoden för Glitch-webkrok](https://glitch.com/edit/#!/indigo-speckle-antler) är tillgänglig för referens. Det är ett enkelt React-program som använder [Adobe React Spectrum](https://react-spectrum.adobe.com/react-spectrum/index.html) -komponenter för att återge användargränssnittet.

- [API:t för Adobe I/O-händelseregistrering](https://developer.adobe.com/events/docs/guides/api/journaling_api/) innehåller detaljerad information om API:t, till exempel första, nästa och sista gruppbearbetning av händelser, sidnumrering med mera.
