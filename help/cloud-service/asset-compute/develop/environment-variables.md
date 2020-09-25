---
title: Konfigurera miljövariabler för resursberäkningens utbyggbarhet
description: Miljövariabler bevaras i .env-filen för lokal utveckling, och används för att ange Adobe I/O-autentiseringsuppgifter och autentiseringsuppgifter för molnlagring som krävs för lokal utveckling.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6270
thumbnail: KT-6270.jpg
translation-type: tm+mt
source-git-commit: 50519b9526182b528047069f211498099e3a4c88
workflow-type: tm+mt
source-wordcount: '642'
ht-degree: 0%

---


# Konfigurera miljövariabler

![punktmiljöfil](assets/environment-variables/dot-env-file.png)

Kontrollera att projektet har konfigurerats med Adobe I/O och molnlagringsinformation innan du börjar utveckla resursberäkningspersonal. Den här informationen lagras i projektets `.env` , som bara används för lokal utveckling, och inte sparas i Git. Filen `.env` är ett praktiskt sätt att visa nyckelpar/värdepar för den lokala utvecklingsmiljön Resursberäkning. När du [distribuerar](../deploy/runtime.md) Assets Compute-arbetare till Adobe I/O Runtime används inte `.env` filen, utan en delmängd av värdena skickas via miljövariabler. Andra anpassade parametrar och hemligheter kan lagras i `.env` filen, till exempel utvecklingsuppgifter för webbtjänster från tredje part.

## Referera till `private.key`

![privat nyckel](assets/environment-variables/private-key.png)

Öppna `.env` filen, avkommentera `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` nyckeln och ange den absoluta sökvägen i filsystemet till `private.key` den som parar ihop det offentliga certifikatet som lagts till i Adobe I/O FireFly-projektet.

+ Om nyckelparet genererades av Adobe i/O hämtades det automatiskt som en del av `config.zip`.
+ Om du har gett Adobe I/O den offentliga nyckeln bör du också ha den motsvarande privata nyckeln.
+ Om du inte har dessa nyckelpar kan du generera nya nyckelpar eller överföra nya offentliga nycklar längst ned i:
   [https://console.adobe.com](https://console.adobe.io) > Ditt resurshanteringsprojekt > Arbetsytor @ Utveckling > Tjänstkonto (JWT).

Kom ihåg att `private.key` filen inte ska checkas in i Git eftersom den innehåller hemligheter, utan bör lagras på en säker plats utanför projektet.

I macOS kan det se ut så här:

```
...
ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH=/Users/example-user/credentials/aem-guides-wknd-asset-compute/private.key
...
```

## Konfigurera autentiseringsuppgifter för molnlagring

Lokal utveckling av Asset Compute-arbetare kräver åtkomst till [molnlagring](../set-up/accounts-and-services.md#cloud-storage). De autentiseringsuppgifter för molnlagring som används för lokal utveckling anges i `.env` filen.

I den här självstudiekursen föredrar du att använda Azure Blob Storage, men Amazon S3 och dess motsvarande nycklar i `.env` filen kan användas i stället.

### Använda Azure Blob Storage

Avkommentera och fyll i följande nycklar i `.env` filen och fyll i dem med värdena för den tilldelade molnlagringen som finns på Azure Portal.

![Azure Blob Storage](./assets/environment-variables/azure-portal-credentials.png)

1. Värde för `AZURE_STORAGE_CONTAINER_NAME` nyckeln
1. Värde för `AZURE_STORAGE_ACCOUNT` nyckeln
1. Värde för `AZURE_STORAGE_KEY` nyckeln

Det här kan till exempel se ut så här (värden endast för illustrationer):

```
...
AZURE_STORAGE_ACCOUNT=aemguideswkndassetcomput
AZURE_STORAGE_KEY=Va9CnisgdbdsNJEJBqXDyNbYppbGbZ2V...OUNY/eExll0vwoLsPt/OvbM+B7pkUdpEe7zJhg==
AZURE_STORAGE_CONTAINER_NAME=asset-compute
...
```

Den resulterande `.env` filen ser ut så här:

![Autentiseringsuppgifter för Azure Blob Storage](assets/environment-variables/cloud-storage-credentials.png)

Om du INTE använder Microsoft Azure Blob Storage tar du bort eller låter de kommenterade bort (med prefix with `#`).

### Använda molnlagring i Amazon S3{#amazon-s3}

Om du använder molnlagringen i Amazon S3 avkommenterar du och fyller i följande tangenter i `.env` filen.

Det här kan till exempel se ut så här (värden endast för illustrationer):

```
...
S3_BUCKET=aemguideswkndassetcompute
AWS_ACCESS_KEY_ID=KKIXZLZYNLXJLV24PLO6
AWS_SECRET_ACCESS_KEY=Ba898CnisgabdsNJEJBqCYyVrYttbGbZ2...OiNYExll0vwoLsPtOv
AWS_REGION=us-east-1
...
```

## Validerar projektkonfigurationen

När det genererade resursberäkningsprojektet har konfigurerats validerar du konfigurationen innan du gör kodändringar för att säkerställa att stödtjänsterna tillhandahålls i `.env` filerna.

Så här startar du verktyget Resursberäkning för projektet Resursberäkning:

1. Öppna en kommandorad i projektroten Resursberäkning (i VS-koden kan den öppnas direkt i IDE via Terminal > New Terminal) och kör kommandot:

   ```
   $ aio app run
   ```

1. Det lokala verktyget Resursberäkning öppnas i standardwebbläsaren på __http://localhost:9000__.

   ![aio-appkörning](assets/environment-variables/aio-app-run.png)

1. Se kommandoradsutdata och webbläsaren för felmeddelanden när utvecklingsverktyget initieras.
1. Om du vill stoppa verktyget Resursberäkning trycker du `Ctrl-C` i fönstret som utfördes `aio app run` för att avsluta processen.

## Felsökning

### Lokala utvecklingsverktyg för resursberäkning kan inte starta på grund av att private.key saknas

+ __Fel:__ Local Dev ServerError: Nödvändiga filer saknas vid validatePrivateKeyFile... (via standard ut från `aio app run` kommando)
+ __Orsak:__ Värdet `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` i `.env` filen pekar inte på `private.key` eller `private.key` är inte läsbart av den aktuella användaren.
+ __Upplösning:__ Granska `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` värdet i `.env` filen och se till att den innehåller den fullständiga, absoluta sökvägen till `private.key` filsystemet.
