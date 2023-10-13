---
title: Spara formulärinlämning i Azure Storage
description: Lagra formulärdata i Azure Storage med REST API
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2023-08-14T00:00:00Z
kt: 13781
exl-id: 2bec5953-2e0c-4ae6-ae98-34492d4cfbe4
source-git-commit: 097ff8fd0f3a28f3e21c10e03f6dc28695cf9caf
workflow-type: tm+mt
source-wordcount: '453'
ht-degree: 0%

---

# Lagra formuläröverföringar i Azure Storage

I den här artikeln visas hur du gör REST-anrop för att lagra skickade AEM Forms-data i Azure Storage.
För att kunna lagra skickade formulärdata i Azure Storage måste följande steg följas.

## Skapa Azure Storage-konto

[Logga in på ditt Azure Portal-konto och skapa ett lagringskonto](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal#create-a-storage-account-1). Ange ett beskrivande namn för ditt lagringskonto, klicka på Granska och sedan på Skapa. Då skapas ditt lagringskonto med alla standardvärden. I den här artikeln har vi namngett ditt lagringskonto `aemformstutorial`.

## Skapa delad åtkomst

Vi kommer att göra oss av med auktoriseringsmetoden för delad åtkomst eller SAS för att interagera med Azure Storage-behållaren.
På sidan för lagringskonto i portalen klickar du på menyalternativet Delad åtkomstsignatur till vänster för att öppna den nya inställningssidan för signaturnyckel för delad åtkomst. Se till att du anger inställningar och lämpligt slutdatum enligt skärmbilden nedan och klicka på knappen Generera SAS och anslutningssträng. Kopiera plumppjänstens SAS-URL. Vi kommer att använda den här URL:en för att göra våra HTTP-anrop
![shared-access-keys](./assets/shared-access-signature.png)

## Skapa behållare

Nästa vi måste göra är att skapa en behållare för att lagra data från inskickade formulär.
Klicka på menyalternativet Behållare till vänster på sidan Lagringskonto och skapa en behållare som kallas `formssubmissions`. Kontrollera att åtkomstnivån public är inställd på private
![container](./assets/new-container.png)

## Skapa PUT-begäran

Nästa steg är att skapa en PUT-begäran om att lagra skickade formulärdata i Azure Storage. Vi måste ändra Plumb Service SAS-URL:en för att inkludera behållarnamnet och BLOB-ID:t i URL:en. Varje formulärinlämning måste identifieras med ett unikt BLOB-ID. Det unika BLOB-ID:t skapas vanligtvis i koden och infogas i URL:en för PUT-begäran.
Följande är den partiella URL:en för begäran från PUT. The `aemformstutorial` är namnet på lagringskontot, är formuläröverföringar den behållare i vilken data lagras med ett unikt BLOB ID. Resten av URL:en förblir densamma.
https://aemformstutorial.blob.core.windows.net/formsubmissions/00cb1a0c-a891-4dd7-9bd2-67a22bef3b8b?...............

Följande funktion har skrivits för att lagra skickade formulärdata i Azure Storage med en PUT-begäran. Observera användningen av behållarnamnet och uuid i url:en. Du kan skapa en OSGi-tjänst eller en sling-server med exempelkoden nedan och lagra formulärskicken i Azure Storage.

```java
 public String saveFormDatainAzure(String formData) {
        System.out.println("in SaveFormData!!!!!"+formData);
        org.apache.http.impl.client.CloseableHttpClient httpClient = HttpClientBuilder.create().build();
        UUID uuid = UUID.randomUUID();
        
        String url = "https://aemformstutorial.blob.core.windows.net/formsubmissions/"+uuid.toString();
        url = url+"?sv=2022-11-02&ss=bf&srt=o&sp=rwdlaciytfx&se=2024-06-28T00:42:59Z&st=2023-06-27T16:42:59Z&spr=https&sig=v1MR%2FJuhEledioturDFRTd9e2fIDVSGJuAiUt6wNlkLA%3D";
        HttpPut httpPut = new HttpPut(url);
        httpPut.addHeader("x-ms-blob-type","BlockBlob");
        httpPut.addHeader("Content-Type","text/plain");
        try {
            httpPut.setEntity(new StringEntity(formData));
            CloseableHttpResponse response = httpClient.execute(httpPut);
            log.debug("Response code "+response.getStatusLine().getStatusCode());
        } catch (IOException e) {
            log.error("Error: "+e.getMessage());
            throw new RuntimeException(e);
        }
        return uuid.toString();


    }
```

## Verifiera lagrade data i behållaren

![form-data-in-container](./assets/form-data-in-container.png)
