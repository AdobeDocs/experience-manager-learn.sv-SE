---
title: Konfigurera AEM Forms Communication API
description: Konfigurera OpenAPI-baserade AEM Forms Communication API:er för autentisering från server till server
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
feature: Document Services
topic: Development
jira: KT-17479
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
exl-id: b9c0b04b-6131-4752-b2f0-58e1fb5f40aa
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '245'
ht-degree: 0%

---

# Konfigurera OpenAPI-baserade AEM Forms Communication API:er i AEM Forms as a Cloud Service

## Förutsättningar

* Senaste instansen av AEM Forms as a Cloud Service.
* Alla nödvändiga [produktprofiler läggs till i miljön.](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/aem-apis/invoke-openapi-based-aem-apis)

* Ge AEM API åtkomst till produktprofilen enligt nedan
  ![product_profile1](assets/product-profiles1.png)
  ![product_profile](assets/product-profiles.png)

## Skapa Adobe Developer Console Project

Logga in på [Adobe Developer Console](https://developer.adobe.com/console/) med din Adobe ID.
Skapa ett nytt projekt genom att klicka på lämplig ikon
![nytt projekt](assets/new-project.png)

Ge projektet ett beskrivande namn och klicka på ikonen Lägg till API
![nytt projekt](assets/new-project2.png)

Välj Experience Cloud
![new-project3](assets/new-project3.png)
Välj AEM Forms Communications API och klicka på Nästa
![new-project4](assets/new-project4.png)

Kontrollera att du har valt server-till-server-autentisering och klicka på Nästa
![new-project5](assets/new-project5.png)
Markera profilerna och klicka på knappen Spara konfigurerad API för att spara inställningarna
![new-project6](assets/new-project6.png)
Klicka i OAuth Server-till-server
![new-project7](assets/new-project7.png)
Kopiera klient-ID, klienthemlighet och omfång
![new-project8](assets/new-project8.png)

## Konfigurera AEM-instans för att aktivera ADC-projektkommunikation

Om du redan har ett AEM Forms-projekt [följer du de här instruktionerna](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/aem-apis/invoke-openapi-based-aem-apis) för att aktivera Adobe Developer Console Projects autentiseringscertifikat OAuth Server-to-Server ClientID för kommunikation med AEM-instansen

Om du inte har något AEM Forms-projekt skapar du ett [AEM Forms-projekt genom att följa den här dokumentationen.](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/forms/developing-for-cloud-service/getting-started) och aktivera sedan klientens-ID:t för OAuth Server-till-Server-autentiseringsuppgifter för Adobe Developer Console Project för att kommunicera med AEM-instansen [med hjälp av den här dokumentationen.](https://experienceleague.adobe.com/sv/docs/experience-manager-learn/cloud-service/aem-apis/invoke-openapi-based-aem-apis)


## Nästa steg

[Generera åtkomsttoken](./generate-access-token.md)
