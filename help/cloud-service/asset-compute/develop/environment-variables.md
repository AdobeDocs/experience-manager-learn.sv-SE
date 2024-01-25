---
title: Konfigurera miljövariabler för Asset compute-utökningsbarhet
description: Miljövariabler bevaras i .env-filen för lokal utveckling, och används för att ange autentiseringsuppgifter för Adobe I/O och molnlagring som krävs för lokal utveckling.
feature: Asset Compute Microservices
version: Cloud Service
doc-type: Tutorial
jira: KT-6270
thumbnail: KT-6270.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: c63c5c75-1deb-4c16-ba33-e2c338ef6251
duration: 144
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '587'
ht-degree: 0%

---

# Konfigurera miljövariabler

![punktmiljöfil](assets/environment-variables/dot-env-file.png)

Innan du börjar utveckla Asset compute-arbetare bör du kontrollera att projektet har konfigurerats med Adobe I/O och molnlagringsinformation. Den här informationen lagras i projektets `.env`  som endast används för lokal utveckling och inte sparas i Git. The `.env` -filen är ett praktiskt sätt att visa nyckelpar/värdepar för den lokala utvecklingsmiljön i Asset compute. När [distribuera](../deploy/runtime.md) Asset compute till Adobe I/O Runtime `.env` -filen används inte, utan en delmängd av värden skickas via miljövariabler. Andra anpassade parametrar och hemligheter kan lagras i `.env` även, till exempel utvecklingsuppgifter för webbtjänster från tredje part.

## Referera till `private.key`

![privat nyckel](assets/environment-variables/private-key.png)

Öppna `.env` fil, avkommentera `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` och ange den absoluta sökvägen i filsystemet till `private.key` som paras med det offentliga certifikatet som lagts till i ditt Adobe I/O App Builder-projekt.

+ Om nyckelparet genererades av Adobe I/O laddades det ned automatiskt som en del av  `config.zip`.
+ Om du har gett Adobe I/O den offentliga nyckeln bör du också ha den motsvarande privata nyckeln.
+ Om du inte har dessa nyckelpar kan du generera nya nyckelpar eller överföra nya publika nycklar längst ned i:
  [https://console.adobe.com](https://console.adobe.io) > Ditt Asset compute App Builder-projekt > Workspaces @ Development > Service Account (JWT).

Kom ihåg `private.key` filen bör inte checkas in i Git eftersom den innehåller hemligheter, utan bör lagras på en säker plats utanför projektet.

I macOS kan det till exempel se ut så här:

```
...
ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH=/Users/example-user/credentials/aem-guides-wknd-asset-compute/private.key
...
```

## Konfigurera autentiseringsuppgifter för molnlagring

Lokal utveckling av Asset compute kräver tillgång till [molnlagring](../set-up/accounts-and-services.md#cloud-storage). De autentiseringsuppgifter för molnlagring som används för lokal utveckling finns i `.env` -fil.

I den här självstudiekursen föredrar du att använda Azure Blob Storage, men Amazon S3 och det är motsvarande nycklar i `.env` kan användas i stället.

### Använda Azure Blob Storage

Avkommentera och fyll i följande tangenter i `.env` och fylla i dem med värdena för den provisionerade molnlagringen som finns på Azure Portal.

![Azure Blob Storage](./assets/environment-variables/azure-portal-credentials.png)

1. Värde för `AZURE_STORAGE_CONTAINER_NAME` key
1. Värde för `AZURE_STORAGE_ACCOUNT` key
1. Värde för `AZURE_STORAGE_KEY` key

Det här kan till exempel se ut så här (värden endast för illustrationer):

```
...
AZURE_STORAGE_ACCOUNT=aemguideswkndassetcomput
AZURE_STORAGE_KEY=Va9CnisgdbdsNJEJBqXDyNbYppbGbZ2V...OUNY/eExll0vwoLsPt/OvbM+B7pkUdpEe7zJhg==
AZURE_STORAGE_CONTAINER_NAME=asset-compute
...
```

Resultat `.env` filen ser ut så här:

![Autentiseringsuppgifter för Azure Blob Storage](assets/environment-variables/cloud-storage-credentials.png)

Om du INTE använder Microsoft Azure Blob Storage tar du bort eller låter de kommenterade bort (genom att använda prefix med `#`).

### Använda molnlagring i Amazon S3{#amazon-s3}

Om du använder molnlagringen i Amazon S3 avkommenterar du och fyller i följande knappar i `.env` -fil.

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

När det genererade Asset compute-projektet har konfigurerats validerar du konfigurationen innan du gör kodändringar för att se till att stödtjänsterna tillhandahålls i `.env` filer.

Så här startar du Asset compute Development Tool för projektet Asset compute:

1. Öppna en kommandorad i Asset compute projektroten (i VS-koden kan du öppna den direkt i IDE via Terminal > New Terminal) och köra kommandot:

   ```
   $ aio app run
   ```

1. Det lokala utvecklingsverktyget i Asset compute öppnas i standardwebbläsaren på __http://localhost:9000__.

   ![aio-appkörning](assets/environment-variables/aio-app-run.png)

1. Se kommandoradsutdata och webbläsaren för felmeddelanden när utvecklingsverktyget initieras.
1. Stoppa utvecklingsverktyget i Asset compute genom att trycka på `Ctrl-C` i det fönster som kördes `aio app run` för att avsluta processen.

## Felsökning

+ [Utvecklingsverktyget kan inte starta eftersom private.key saknas](../troubleshooting.md#missing-private-key)
