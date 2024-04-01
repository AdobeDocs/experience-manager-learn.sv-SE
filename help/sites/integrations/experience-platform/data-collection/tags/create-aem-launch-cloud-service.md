---
title: Skapa en tagg-Cloud Service-konfiguration i AEM Sites
description: Lär dig hur du skapar en konfiguration för taggar i AEM.
solution: Experience Manager, Data Collection, Experience Platform
jira: KT-5982
thumbnail: 38566.jpg
topic: Integrations
feature: Integrations
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites as a Cloud Service, AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: a72ddced-37de-4b62-9e28-fa5b6c8ce5b7
duration: 139
source-git-commit: adf3fe30474bcfe5fc1a1e2a8a3d49060067726d
workflow-type: tm+mt
source-wordcount: '495'
ht-degree: 0%

---

# Skapa en konfiguration av Cloud Servicen taggar i AEM {#create-launch-cloud-service}

Lär dig hur du skapar en tagg-Cloud Service i Adobe Experience Manager. Konfiguration av AEM taggar kan sedan användas på en befintlig webbplats och tagg-biblioteken kan läsas in både i redigerings- och publiceringsmiljöer.

## Skapa taggar i molntjänsten

Skapa konfigurationen av taggmolntjänsten genom att följa stegen nedan.

1. Från **verktyg** meny, välja **Cloud Service** och klicka **Adobe Launch Configurations**
1. Välj platsens konfigurationsmapp eller välj **WKND-plats** (om du använder WKND-stödlinjeprojekt) och klicka på **Skapa**
1. Från _Allmänt_ -fliken, namnge konfigurationen med **Titel** fält och markera **Adobe Launch** från _Associerad Adobe IMS-konfiguration_ nedrullningsbar meny. Välj sedan ditt företagsnamn på menyn _Företag_ listrutan och välj en egenskap som skapats tidigare i _Egenskap_ nedrullningsbar meny.
1. Från _Mellanlagring_ och _Produktion_ behåller standardkonfigurationerna. Vi rekommenderar dock att du granskar och ändrar konfigurationerna för verkliga produktionsinställningar, särskilt _Läs in bibliotek asynkront_ växla baserat på prestanda och optimeringskrav. Observera även att _Biblioteks-URI_ värdet är annorlunda för Förproduktion och Förproduktion.
1. Klicka slutligen **Skapa** för att slutföra taggar i molntjänster.

   ![tagg Cloud Services Configuration](assets/launch-cloud-services-config.png)

## Lägg till taggar i molntjänsten på webbplatsen

Om du vill läsa in taggegenskapen och dess bibliotek på den AEM platsen används taggarnas molntjänstkonfiguration på platsen. I föregående steg skapas molntjänstkonfigurationen under platsnamnmappen (WKND-plats) så att den ska tillämpas automatiskt. Vi måste verifiera den.

1. Från **Navigering** meny, välja **Webbplatser** -ikon.

1. Markera rotsidan för AEM och klicka på **Egenskaper**. Navigera sedan till **Avancerat** tabb och under **Konfiguration** kontrollerar du att värdet för molnkonfiguration pekar på din platsspecifika `conf` mapp.

   ![Använd konfigurationen för Cloud Service på platsen](assets/apply-cloud-services-config-to-site.png)

## Verifiera inläsning av taggegenskap på författar- och publiceringssidor

Nu är det dags att verifiera att taggegenskapen och dess bibliotek har lästs in på AEM.

1. Öppna din favoritwebbplats i **Visa som publicerad** i webbläsarkonsolen ser du loggmeddelandet. Det är samma meddelande från JavaScript-kodfragmentet i taggegenskapsregeln som utlöses när _Bibliotek inläst (sidan ovanpå)_ -händelsen utlöses.

1. Verifiera vid publicering genom att först publicera **taggar molntjänst** konfigurera och öppna webbplatssidan i Publish-instansen.

   ![Tagga egenskap på författar- och publiceringssidor](assets/tag-property-on-author-publish-pages.png)

Grattis! Du har slutfört integreringen av taggar för AEM och datainsamling som injicerar JavaScript-kod i din AEM utan att uppdatera den AEM projektkoden.

## Problem - uppdatera och publicera regel i tagg-egenskapen

Använd lektioner från föregående [Skapa en taggegenskap](./create-tag-property.md) för att slutföra den enkla utmaningen, uppdatera den befintliga regeln för att lägga till ytterligare konsoluttryck och använda _Publiceringsflöde_ driftsätta den på AEM.

## Nästa steg

[Felsöka en taggimplementering](debug-tags-implementation.md)
