---
title: Konfigurera miljövariabler för Asset Compute-utbyggbarhet
description: Miljövariabler bevaras i .env-filen för lokal utveckling och används för att ange Adobe I/O-autentiseringsuppgifter och molnlagringsreferenser som krävs för lokal utveckling.
feature: Asset Compute Microservices
version: Experience Manager as a Cloud Service
doc-type: Tutorial
jira: KT-6270
thumbnail: KT-6270.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: c63c5c75-1deb-4c16-ba33-e2c338ef6251
duration: 121
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '587'
ht-degree: 0%

---

# Konfigurera miljövariabler

![punktmiljöfil](assets/environment-variables/dot-env-file.png)

Innan du börjar utveckla Asset Compute-arbetare bör du kontrollera att projektet har konfigurerats med Adobe I/O och molnlagringsinformation. Den här informationen lagras i projektets `.env`, som bara används för lokal utveckling, och inte sparas i Git. Filen `.env` är ett praktiskt sätt att visa nyckelpar/värdepar för den lokala Asset Compute-utvecklingsmiljön. När [distribuerar](../deploy/runtime.md) Asset Compute-arbetare till Adobe I/O Runtime används inte filen `.env`, utan en delmängd av värdena skickas via miljövariabler. Andra anpassade parametrar och hemligheter kan lagras i filen `.env`, t.ex. utvecklingsuppgifter för webbtjänster från tredje part.

## Referera till `private.key`

![privat nyckel](assets/environment-variables/private-key.png)

Öppna filen `.env`, avkommentera nyckeln `ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH` och ange den absoluta sökvägen i filsystemet till den `private.key` som har det offentliga certifikatet som lagts till i ditt Adobe I/O App Builder-projekt.

+ Om nyckelparet genererades av Adobe I/O hämtades det automatiskt som en del av `config.zip`.
+ Om du gav Adobe I/O den offentliga nyckeln bör du också ha den motsvarande privata nyckeln.
+ Om du inte har dessa nyckelpar kan du generera nya nyckelpar eller överföra nya publika nycklar längst ned i:
  [https://console.adobe.com](https://console.adobe.io) > Ditt Asset Compute App Builder-projekt > Arbetsytor @ Utveckling > Tjänstkonto (JWT).

Kom ihåg att `private.key`-filen inte ska checkas in i Git eftersom den innehåller hemligheter, utan bör lagras på en säker plats utanför projektet.

I macOS kan det till exempel se ut så här:

```
...
ASSET_COMPUTE_PRIVATE_KEY_FILE_PATH=/Users/example-user/credentials/aem-guides-wknd-asset-compute/private.key
...
```

## Konfigurera autentiseringsuppgifter för molnlagring

Lokal utveckling av Asset Compute-arbetare kräver åtkomst till [molnlagring](../set-up/accounts-and-services.md#cloud-storage). De autentiseringsuppgifter för molnlagring som används för lokal utveckling anges i filen `.env`.

I den här självstudiekursen föredrar du att använda Azure Blob Storage, men Amazon S3 och dess motsvarande nycklar i filen `.env` kan användas i stället.

### Använda Azure Blob Storage

Avkommentera och fyll i följande nycklar i filen `.env` och fyll i dem med värdena för den tilldelade molnlagringen som finns på Azure Portal.

![Azure Blob Storage](./assets/environment-variables/azure-portal-credentials.png)

1. Värde för nyckeln `AZURE_STORAGE_CONTAINER_NAME`
1. Värde för nyckeln `AZURE_STORAGE_ACCOUNT`
1. Värde för nyckeln `AZURE_STORAGE_KEY`

Det här kan till exempel se ut så här (värden endast för illustrationer):

```
...
AZURE_STORAGE_ACCOUNT=aemguideswkndassetcomput
AZURE_STORAGE_KEY=Va9CnisgdbdsNJEJBqXDyNbYppbGbZ2V...OUNY/eExll0vwoLsPt/OvbM+B7pkUdpEe7zJhg==
AZURE_STORAGE_CONTAINER_NAME=asset-compute
...
```

Den resulterande `.env`-filen ser ut så här:

![Azure Blob Storage-autentiseringsuppgifter](assets/environment-variables/cloud-storage-credentials.png)

Om du INTE använder Microsoft Azure Blob Storage tar du bort eller låter de kommenterade bort (genom att använda `#` som prefix).

### Använda molnlagring i Amazon S3{#amazon-s3}

Om du använder molnlagringen i Amazon S3 avkommenterar du och fyller i följande tangenter i filen `.env`.

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

När det genererade Asset Compute-projektet har konfigurerats ska du validera konfigurationen innan du gör kodändringar för att se till att stödtjänsterna har etablerats i `.env`-filerna.

Så här startar du Asset Compute Development Tool för Asset Compute-projektet:

1. Öppna en kommandorad i Asset Compute-projektroten (i VS-koden kan den öppnas direkt i IDE via Terminal > New Terminal) och kör kommandot:

   ```
   $ aio app run
   ```

1. Det lokala Asset Compute Development Tool öppnas i din standardwebbläsare på __http://localhost:9000__.

   ![AIR-appkörning](assets/environment-variables/aio-app-run.png)

1. Se kommandoradsutdata och webbläsaren för felmeddelanden när utvecklingsverktyget initieras.
1. Stoppa Asset Compute Development Tool genom att trycka på `Ctrl-C` i det fönster som körde `aio app run` för att avsluta processen.

## Felsökning

+ [Utvecklingsverktyget kan inte starta eftersom private.key saknas](../troubleshooting.md#missing-private-key)
