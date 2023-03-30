---
title: Anslut AEM med taggegenskap med IMS
description: Lär dig hur du ansluter AEM med taggegenskap med hjälp av IMS-konfigurationen i AEM. Den här installationen autentiserar AEM med Launch API och gör att AEM kan kommunicera via Launch API:er för att komma åt taggegenskaper.
topics: integrations
audience: administrator
solution: Experience Manager, Data Collection, Experience Platform
doc-type: technical video
activity: setup
version: Cloud Service
kt: 5981
thumbnail: 38555.jpg
topic: Integrations
role: Developer
level: Intermediate
exl-id: 92dbd185-bad4-4a4d-b979-0d8f5d47c54b
source-git-commit: 18a72187290d26007cdc09c45a050df8f152833b
workflow-type: tm+mt
source-wordcount: '301'
ht-degree: 0%

---

# Anslut AEM med taggegenskap med IMS{#connect-aem-and-tag-property-using-ims}

>[!NOTE]
>
>Processen att byta namn på Adobe Experience Platform Launch som en uppsättning datainsamlingstekniker implementeras i produktgränssnittet, innehållet och dokumentationen för AEM, så termen Launch används fortfarande här.

Lär dig hur du ansluter AEM med taggegenskapen med hjälp av IMS-konfigurationen (Identity Management System) i AEM. Den här installationen autentiserar AEM med Launch API och gör att AEM kan kommunicera via Launch API:er för att komma åt taggegenskaper.

## Skapa eller återanvänd IMS-konfiguration

IMS-konfigurationen som använder Adobe Developer Console-projektet krävs för att integrera AEM med den nyligen skapade taggegenskapen. Med den här konfigurationen kan AEM kommunicera med taggar med hjälp av Launch API:er och IMS hanterar säkerhetsaspekten av den här integreringen.

När en AEM som Cloud Service-miljö etableras skapas automatiskt några IMS-konfigurationer som Asset compute, Adobe Analytics och Adobe Launch. Den automatiskt skapade **Adobe Launch** IMS-konfigurationen kan användas eller så bör en ny IMS-konfiguration skapas om du använder AEM 6.X-miljö.

Granskning har skapats automatiskt **Adobe Launch** IMS-konfiguration med följande steg.

1. Öppna AEM **verktyg** meny

1. I avsnittet Säkerhet väljer du Adobe IMS-konfigurationer.

1. Välj **Adobe Launch** kort och klicka **Egenskaper**, kan du läsa informationen från **Certifikat** och **Konto** -tabbar. Klicka sedan på **Avbryt** för att returnera utan att ändra någon information som skapats automatiskt.

1. Välj **Adobe Launch** och klicka på **Kontrollera hälsa** bör du se **Lyckades** som nedan.

   ![Starta konfigurationen för felfri IMS i Adobe](assets/adobe-launch-healthy-ims-config.png)


## Nästa steg

[Skapa en konfiguration för Starta Cloud Service i AEM](create-aem-launch-cloud-service.md)
