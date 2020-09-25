---
title: Använda Adobe Stock-resurser med AEM Assets
description: 'AEM ger användarna möjlighet att söka, förhandsgranska, spara och licensiera Adobe Stock-resurser direkt från AEM. Organisationer kan nu integrera sin Adobe Stock Enterprise-plan med AEM Assets för att se till att licensierat material nu är allmänt tillgängligt för kreativa projekt och marknadsföringsprojekt, med de kraftfulla filhanteringsfunktionerna i AEM. '
feature: creative-cloud-integration
topics: authoring, collaboration, operations, sharing, metadata, images, stock
audience: all
doc-type: feature video
activity: use
version: 6.4, 6.5
translation-type: tm+mt
source-git-commit: 67ca08bf386a217807da3755d46abed225050d02
workflow-type: tm+mt
source-wordcount: '966'
ht-degree: 0%

---


# Använda Adobe Stock med AEM Assets{#using-adobe-stock-assets-with-aem-assets}

I AEM 6.4.2 kan användarna söka efter, förhandsgranska, spara och licensiera Adobe Stock-mediefiler direkt från AEM. Organisationer kan nu integrera sin Adobe Stock Enterprise-plan med AEM Assets för att se till att licensierat material nu är allmänt tillgängligt för kreativa projekt och marknadsföringsprojekt, med de kraftfulla filhanteringsfunktionerna i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/24678/?quality=9&learn=on)

>[!NOTE]
>
>För integreringen krävs en Adobe Stock-plan [för](https://landing.adobe.com/en/na/products/creative-cloud/ctir-4625-stock-for-enterprise/index.html) företag och AEM 6.4 med minst Service Pack 2. AEM 6.4 Service Pack-information finns i [versionsinformationen](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html).

Tack vare integreringen med Adobe Stock och AEM Assets kan skribenter och marknadsförare enkelt licensiera och använda mediefiler för kreativa ändamål eller marknadsföringsändamål. Du kan söka efter Stock-resurser antingen med Omni Search, genom att lägga till platsfiltret som Adobe Stock eller genom att navigera i huvudnavigeringen för AEM Assets och klicka på ikonen Sök i Adobe Stock Coral-användargränssnittet.

## Funktioner

### Sök och spara

* Utför sökning av Adobe Stock-resurser utan att lämna AEM arbetsyta.
* Spara Adobe Stock-mediefiler för förhandsgranskning utan att behöva licensiera mediefilen.
* Möjlighet att licensiera och spara Adobe Stock-material till AEM Assets
* Möjlighet att söka efter liknande resurser från Adobe Stock i AEM Assets användargränssnitt
* Visa en markerad resurs från Stock Search i AEM Assets på Adobe Stock webbplats
* Licensierade mediefiler är märkta med ett blått licensierat märke för enkel identifiering

### Resursmetadata

* Licensierad mediefil lagras i AEM Assets. Resursegenskaper innehåller Stock-metadata under en separat metadataflik för resurser
* Möjlighet att lägga till licensreferenser till metadata för mediefiler

### Resursarkivprofil

* En användare kan välja Adobe Stock-profil under *Användare > Mina inställningar > Stock-konfiguration*
* Obligatoriska och valfria referenser kan läggas till i fönstret Resurslicensiering.
* Möjlighet att välja språk i fönstret Resurslicenser baserat på region.

### Filter

* En användare kan filtrera mediefiler baserat på tillgångstyp, orientering och liknande
* Resurstypen innehåller foton, illustrationer, vektorer, videor, mallar, 3D, Premium, redaktionellt
* Orienteringen inkluderar Vågrät, Lodrät och Fyrkant.
* Filtret Visa liknande kräver Adobe Stock-filnummer

### Åtkomstkontroll

* Administratörer kan ge vissa användare/grupper behörighet att licensiera Stock-resurser när de konfigurerar Adobe Stock molntjänstkonfiguration.
* Om en viss användare/grupp inte har behörighet att licensiera mediefiler, inaktiveras funktionen Sök efter *Stock-mediefiler/Tillgångslicensiering* .

## Konfigurera Adobe Stock med AEM Assets{#set-up-adobe-stock-with-aem-assets}

I AEM 6.4.2 kan användarna söka efter, förhandsgranska, spara och licensiera Adobe Stock-mediefiler direkt från AEM. I den här videon får du snabbt veta hur du konfigurerar Adobe Stocks med AEM Assets via Adobe I/O Console.

>[!VIDEO](https://video.tv.adobe.com/v/25043/?quality=12&learn=on)

>[!NOTE]
>
>Om du vill konfigurera en Adobe Stock Cloud-tjänst måste du välja sökvägen till PROD-miljön och den licensierade resursen till /content/dam. Miljöfältet skulle tas bort i nästa AEM och sökvägen till den licensierade resursen är en del av en kommande funktion och stöd för det här fältet kommer att introduceras i nästa AEM.

>[!NOTE]
>
>För integreringen krävs en Adobe Stock-plan [för](https://landing.adobe.com/en/na/products/creative-cloud/ctir-4625-stock-for-enterprise/index.html) företag och AEM 6.4 med minst [Service Pack 2](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq640/servicepack/AEM-6.4.2.0) distribuerad. AEM 6.4 Service Pack-information finns i [versionsinformationen](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html). Du behöver även administratörsbehörighet för [Adobe I/O-konsolen](https://console.adobe.io/), [Adobe Admin Console](https://adminconsole.adobe.com/) och Adobe Experience Manager för att kunna konfigurera integreringen.

### Installation {#installations}

* För AEM 6.4 måste du installera [AEM Service Pack 2](https://www.adobeaemcloud.com/content/marketplace/marketplaceProxy.html?packagePath=/content/companies/public/adobe/packages/cq640/servicepack/AEM-6.4.2.0) och sedan installera om filen cq-dam-stock-integration-content-1.0.4.zip.
* Kontrollera att du har administratörsbehörighet för [Adobe I/O-konsolen](https://console.adobe.io/), [Adobe Admin Console](https://adminconsole.adobe.com/) och Adobe Experience Manager för att konfigurera integreringen.

#### Konfigurera Adobe IMS med Adobe I/O-konsolen {#set-up-adobe-ims-configuration-using-adobe-i-o-console}

1. Skapa en teknisk kontokonfiguration för Adobe IMS under **Verktyg > Säkerhet**
2. Välj *molnlösningen* som *Adobe Stock* och skapa ett nytt certifikat eller återanvänd ett befintligt certifikat för konfigurationen.
3. Navigera till Adobe I/O-konsolen och skapa en ny integrering av tjänstkontot för *Adobe Stock*.
4. Överför certifikatet från steg 2 till Adobe Stock tjänstkontointegration.
5. Välj den Adobe Stock-profilkonfiguration som krävs och slutför tjänstintegreringen.
6. Använd integreringsinformationen för att slutföra konfigurationen av det tekniska kontot för Adobe IMS
7. Kontrollera att du kan ta emot åtkomsttoken med hjälp av Adobe IMS Technical Account.

![Adobe IMS Technical Account](assets/screen_shot_2018-10-22at12219pm.png)

#### Konfigurera Adobe Stock-Cloud Services {#set-up-adobe-stock-cloud-services}

1. Skapa en ny molntjänstkonfiguration för Adobe Stock under **Verktyg > Cloud Services.**
2. Markera den IMS-konfiguration *för* Adobe som skapas i avsnittet ovan för din *Adobe Stock Cloud* -konfiguration

3. Se till att du väljer **MILJÖN** som PROD. Mellanlagringsmiljön stöds inte och kommer att tas bort i nästa version av AEM.
4. **Licensierad resurssökväg** kan peka mot valfri katalog under /content/dam. Funktionsstöd för det här fältet kommer att läggas till i nästa version av AEM
5. Välj språkinställning och slutför inställningarna.
6. Du kan också lägga till användare/grupper i din Adobe Stock Cloud-tjänst för att aktivera åtkomst för specifika användare eller grupper.

![Konfiguration av Adobe Assets Stock](assets/screen_shot_2018-10-22at12425pm.png)

### Ytterligare resurser

* [Enterprise Stock-plan](https://landing.adobe.com/en/na/products/creative-cloud/ctir-4625-stock-for-enterprise/index.html)
* [Versionsinformation för AEM 6.4 Service Pack 2](https://helpx.adobe.com/experience-manager/6-4/release-notes/sp-release-notes.html)
* [Integrera AEM och Adobe Stock](https://helpx.adobe.com/experience-manager/6-5/assets/using/aem-assets-adobe-stock.html#IntegrateAEMandAdobeStock)
* [API för integrering med Adobe I/O-konsol](https://www.adobe.io/apis/cloudplatform/console/authentication/gettingstarted.html)
* [Adobe Stock API Docs](https://www.adobe.io/apis/creativecloud/stock/docs.html)