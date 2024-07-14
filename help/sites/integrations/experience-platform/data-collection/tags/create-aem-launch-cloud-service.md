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
duration: 99
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '495'
ht-degree: 0%

---

# Skapa en konfiguration av Cloud Servicen taggar i AEM {#create-launch-cloud-service}

Lär dig hur du skapar en tagg-Cloud Service i Adobe Experience Manager. Konfiguration av AEM taggar kan sedan användas på en befintlig webbplats och tagg-biblioteken kan läsas in både i Author- och Publish-miljöer.

## Skapa taggar i molntjänsten

Skapa konfigurationen av taggmolntjänsten genom att följa stegen nedan.

1. På menyn **Verktyg** väljer du **Cloud Service** och klickar på **Adobe Launch Configurations**
1. Välj platsens konfigurationsmapp eller välj **WKND-plats** (om du använder WKND-stödlinjeprojekt) och klicka på **Skapa**
1. På fliken _Allmänt_ namnger du konfigurationen med fältet **Titel** och väljer **Adobe Launch** i listrutan _Associerad Adobe IMS-konfiguration_. Välj sedan ditt företagsnamn i listrutan _Företag_ och välj en egenskap som skapats tidigare i listrutan _Egenskap_.
1. På fliken _Förproduktion_ och _Produktion_ behåller du standardkonfigurationerna. Vi rekommenderar dock att du granskar och ändrar konfigurationerna för verkliga produktionsinställningar, särskilt alternativet _Läs in bibliotek asynkront_ baserat på prestanda och optimeringskrav. Observera också att _Library URI_-värdet är annorlunda för Förproduktion och Förproduktion.
1. Klicka slutligen på **Skapa** för att slutföra taggmolntjänsterna.

   ![tags Cloud Services Configuration](assets/launch-cloud-services-config.png)

## Lägg till taggar i molntjänsten på webbplatsen

Om du vill läsa in taggegenskapen och dess bibliotek på den AEM platsen används taggarnas molntjänstkonfiguration på platsen. I föregående steg skapas molntjänstkonfigurationen under platsnamnmappen (WKND-plats) så att den ska tillämpas automatiskt. Vi måste verifiera den.

1. Välj ikonen **Platser** på menyn **Navigering** .

1. Markera rotsidan för AEM och klicka på **Egenskaper**. Gå sedan till fliken **Avancerat** och kontrollera att värdet för molnkonfiguration pekar mot den platsspecifika `conf`-mappen under avsnittet **Konfiguration**.

   ![Använd konfigurationen för Cloud Service på platsen](assets/apply-cloud-services-config-to-site.png)

## Verifiera inläsning av taggegenskap på författar- och Publish-sidor

Nu är det dags att verifiera att taggegenskapen och dess bibliotek har lästs in på AEM.

1. Öppna din favoritwebbplats i läget **Visa som publicerad**, i webbläsarkonsolen som du vill se loggmeddelandet. Det är samma meddelande från JavaScript-kodfragmentet i taggegenskapsregeln som utlöses när händelsen _Bibliotek inläst (överst på sidan)_ utlöses.

1. Om du vill verifiera på Publish publicerar du först din **tags-molntjänst**-konfiguration och öppnar webbplatssidan på Publish-instansen.

   ![Taggegenskap på författarsidor och Publish-sidor](assets/tag-property-on-author-publish-pages.png)

Grattis! Du har slutfört integreringen av taggar för AEM och datainsamling som infogar JavaScript-kod på din AEM utan att uppdatera den AEM projektkoden.

## Problem - uppdatera och publicera regel i tagg-egenskapen

Använd lektioner från föregående [Skapa en taggegenskap](./create-tag-property.md) för att slutföra den enkla utmaningen, uppdatera den befintliga regeln för att lägga till ytterligare konsoluttryck och använda _Publiceringsflöde_ för att distribuera den till den AEM webbplatsen.

## Nästa steg

[Felsöka en taggimplementering](debug-tags-implementation.md)
