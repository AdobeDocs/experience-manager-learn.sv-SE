---
title: Lagra adaptiva formulärdata i Azure Storage
description: Skapa och konfigurera ett anpassat formulär för att lagra data i Azure Storage
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
thumbnail: 335423.jpg
exl-id: 0b543c6b-9cfd-4fac-b8d0-33153c036f4b
duration: 60
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '287'
ht-degree: 0%

---

# Sammanställ allt

Vi har nu alla konfigurationer/integreringar som krävs för användningsfallet. Det sista steget är att skapa ett anpassat formulär baserat på formulärdatamodellen som backas upp av Azure Storage.

Skapa och anpassa formulär och se till att de är baserade på rätt adaptiv formulärmall. Detta garanterar att den anpassade kod som är kopplad till mallen körs varje gång ett anpassat formulär återges.

## Exempel på adaptiv form

I formuläret har vi lagt till två dolda fält

* Blob ID - Det här fältet fylls i med ett GUID när fältet initieras. Värdet i det här fältet används som blockbid för att unikt identifiera blobblagring av formulärdata. Bloggen används för att identifiera formulärdata.
* Blobb-ID returnerades - Det här fältet fylls i med resultatet av tjänstanropet för att lagra data i Azure Storage. Detta värde kommer att vara samma som det blob-ID som skapades i föregående steg.

Formuläret har följande affärsregler

* Knappen Spara formulär visas när användaren anger en e-postadress. När du klickar på knappen Spara formulär lagras formulärdata i Azure Storage med hjälp av formulärdatamodellens anropsåtgärd.
* Det BlobID som returneras av invoke-tjänsten lagras i fältet Blob ID. När det här värdet ändras skickas ett e-postmeddelande till den sökande med SendGrid. E-postmeddelandet innehåller länken för att öppna det delvis ifyllda formuläret som identifieras av blob-ID:t.
* En bekräftelsetext visas för användaren när data har lagrats i Azure Storage

### Nästa steg

[Distribuera exempelresurserna](./deploy-sample-assets.md)
