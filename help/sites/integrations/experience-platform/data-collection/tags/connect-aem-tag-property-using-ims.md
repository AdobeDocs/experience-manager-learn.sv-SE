---
title: Koppla AEM Sites med taggegenskap med IMS
description: Lär dig hur du ansluter AEM Sites med taggegenskap med hjälp av IMS-konfigurationen i AEM.
solution: Experience Manager, Data Collection, Experience Platform
jira: KT-5981
thumbnail: 38555.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 92dbd185-bad4-4a4d-b979-0d8f5d47c54b
duration: 72
source-git-commit: adf3fe30474bcfe5fc1a1e2a8a3d49060067726d
workflow-type: tm+mt
source-wordcount: '263'
ht-degree: 0%

---

# Koppla AEM Sites med taggegenskap med IMS{#connect-aem-and-tag-property-using-ims}

Lär dig hur du ansluter AEM med taggegenskap med hjälp av IMS-konfigurationen (Identity Management System) i AEM. Den här installationen autentiserar AEM med tagg-API:t och gör det möjligt för AEM att kommunicera via tagg-API:erna för att komma åt taggegenskaper.

## Skapa eller återanvänd IMS-konfiguration

IMS-konfigurationen som använder Adobe Developer Console-projektet krävs för att integrera AEM med den nyligen skapade taggegenskapen. Med den här konfigurationen kan AEM kommunicera med taggar-program med hjälp av tagg-API:er och IMS hanterar säkerhetsaspekten av den här integreringen.

När en AEM som Cloud Service-miljö etableras skapas automatiskt några IMS-konfigurationer som Asset compute, Adobe Analytics och taggar. Den automatiskt skapade **taggar i Adobe Experience Platform** IMS-konfigurationen kan användas eller så bör en ny IMS-konfiguration skapas om du använder AEM 6.X-miljö.

Granskning har skapats automatiskt **taggar i Adobe Experience Platform** IMS-konfiguration med följande steg.

1. Öppna AEM **verktyg** meny
1. I avsnittet Säkerhet väljer du Adobe IMS-konfigurationer.
1. Välj **Adobe Launch** kort och klicka **Egenskaper**, kan du läsa informationen från **Certifikat** och **Konto** -tabbar. Klicka sedan på **Avbryt** för att returnera utan att ändra någon information som skapats automatiskt.
1. Välj **Adobe Launch** och klicka på **Kontrollera hälsa**, bör du se **Lyckades** som nedan.

   ![Taggar felfri IMS-konfiguration](assets/adobe-launch-healthy-ims-config.png)

## Nästa steg

[Skapa en konfiguration av Cloud Servicen taggar i AEM](create-aem-launch-cloud-service.md)
