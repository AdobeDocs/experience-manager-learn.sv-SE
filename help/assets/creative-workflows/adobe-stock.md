---
title: Använda Adobe Stock-resurser med AEM Assets
description: AEM ger användarna möjlighet att söka, förhandsgranska, spara och licensiera Adobe Stock-mediefiler direkt från AEM. Organisationer kan nu integrera sin Adobe Stock Enterprise-plan med AEM Assets för att se till att licensierat material nu finns tillgängligt i stor omfattning för kreativa projekt och marknadsföringsprojekt, med de kraftfulla filhanteringsfunktionerna i AEM.
feature: Adobe Stock
version: Experience Manager 6.5
topic: Content Management
role: User
level: Beginner
last-substantial-update: 2022-06-26T00:00:00Z
doc-type: Feature Video
exl-id: a3c3a01e-97a6-494f-b7a9-22057e91f4eb
duration: 1079
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '861'
ht-degree: 0%

---

# Använda Adobe Stock med AEM Assets{#using-adobe-stock-assets-with-aem-assets}

Med AEM 6.4.2 kan man söka, förhandsgranska, spara och licensiera Adobe Stock-material direkt från AEM. Organisationer kan nu integrera sin Adobe Stock Enterprise-plan med AEM Assets för att se till att licensierat material nu finns tillgängligt i stor omfattning för kreativa projekt och marknadsföringsprojekt, med de kraftfulla filhanteringsfunktionerna i AEM.

>[!VIDEO](https://video.tv.adobe.com/v/24678?quality=12&learn=on)

>[!NOTE]
>
>Integreringen kräver en [Enterprise Adobe Stock-plan](https://landing.adobe.com/en/na/products/creative-cloud/ctir-4625-stock-for-enterprise/index.html) och AEM 6.4 med minst Service Pack 2 distribuerat. Information om Service Pack för AEM 6.4 finns i följande [versionsinformation](https://helpx.adobe.com/se/experience-manager/6-4/release-notes/sp-release-notes.html).

Tack vare integreringen med Adobe Stock och AEM Assets kan skribenter och marknadsförare enkelt licensiera och använda mediefiler för kreativa ändamål eller marknadsföringsändamål. Du kan söka efter Stock-resurser antingen med Omni Search, genom att lägga till platsfiltret som Adobe Stock eller genom att navigera i huvudnavigeringen för AEM Assets och klicka på ikonen Sök i Adobe Stock Coral-användargränssnittet.

## Funktioner

### Söka och spara

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
* Resurstypen innehåller foton, illustrationer, vektorer, videoklipp, mallar, 3D, Premium, redaktionellt
* Orienteringen inkluderar Vågrät, Lodrät och Fyrkant.
* Filtret Visa liknande kräver Adobe Stock-filnummer

### Åtkomstkontroll

* Administratörer kan ge vissa användare/grupper behörighet att licensiera mediefiler när de konfigurerar Adobe Stock molntjänst.
* Om en viss användare/grupp inte har behörighet att licensiera Stock-mediefiler inaktiveras funktionen *Sök efter Stock-mediefiler/Tillgångslicensiering*.

## Konfigurera Adobe Stock med AEM Assets{#set-up-adobe-stock-with-aem-assets}

Med AEM 6.4.2 kan man söka, förhandsgranska, spara och licensiera Adobe Stock-material direkt från AEM. Den här videon handlar om hur du snabbt får reda på hur du konfigurerar Adobe Stocks med AEM Assets via Adobe I/O Console.

>[!VIDEO](https://video.tv.adobe.com/v/25043?quality=12&learn=on)

>[!NOTE]
>
>Om du vill konfigurera en Adobe Stock Cloud-tjänst måste du välja produktionsmiljön och sökvägen till licensierad resurs till `/content/dam`. Miljöfältet har nu tagits bort i AEM.

>[!NOTE]
>
>Integreringen kräver en [Enterprise Adobe Stock-plan](https://landing.adobe.com/en/na/products/creative-cloud/ctir-4625-stock-for-enterprise/index.html) och AEM 6.4 med minst [Service Pack 2](https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html?fulltext=AEM*+6*+4*+Service*+Pack*&amp;2_group.propertyvalues.property=.%2Fjcr%3aContent%2Fmetadata%2FDc%3Aversion&amp;2_group.propertyvalues.operation=equals&amp;2_group.propertyvalues.0_values=target-version%3AEM%2F6-4&amp;3_group.propertyvalues.property=.%2Fjcr%3aContent%2Fmetadata%2FDc%3AsoftwareType&amp;3_group.propertyvalues.operation=equals&amp;3_group.propertyvalues.0_values=software-type%3Aservice-and-cumulative-fix&amp;orderBy=%40jcr%3Acontent%2Fmetadata%2Fdc%3Atitle&amp;order.sort=asc &amp;layout=list&amp;p.offset=0&amp;p.limit=24) distribuerad. Information om Service Pack för AEM 6.4 finns i följande [versionsinformation](https://helpx.adobe.com/se/experience-manager/6-4/release-notes/sp-release-notes.html). Du behöver även administratörsbehörighet för [Adobe I/O Console](https://console.adobe.io/), [Adobe Admin Console](https://adminconsole.adobe.com/) och Adobe Experience Manager för att kunna konfigurera integreringen.

### Installation {#installations}

* För AEM 6.4 måste du installera [AEM Service Pack 2](https://experience.adobe.com/#/downloads/content/software-distribution/en/aem.html?fulltext=AEM*+6*+4*+Service*+Pack*&amp;2_group.propertyvalues.property=.%2Fjcr%3aContent%2Fmetadata%2FDc%3Aversion&amp;2_group.propertyvalues.operation=equals&amp;2_group.propertyvalues.0_values=target-version%3AEM%2F6-4&amp;3_group.propertyvalues.property=.%2Fjcr%3aContent%2Fmetadata%2FDc%3AsoftwareType&amp;3_group.propertyvalues.operation=equals&amp;3_group.propertyvalues.0_values=software-type%3Aservice-and-cumulative-fix&amp;orderBy=%40jcr%3Acontent%2Fmetadata%2Fdc%3Atitle&amp;order.sort=asc &amp;layout=list&amp;p.offset=0&amp;p.limit=24) och sedan installera om filen cq-dam-stock-integration-content-1.0.4.zip.
* Kontrollera att du har administratörsbehörighet för [Adobe I/O Console](https://console.adobe.io/), [Adobe Admin Console](https://adminconsole.adobe.com/) och Adobe Experience Manager för att konfigurera integreringen.

#### Konfigurera Adobe IMS med Adobe I/O Console {#set-up-adobe-ims-configuration-using-adobe-i-o-console}

1. Skapa en teknisk kontokonfiguration för Adobe IMS under **Verktyg > Säkerhet**
2. Välj *molnlösningen* som *Adobe Stock* och skapa ett nytt certifikat eller återanvänd ett befintligt certifikat för konfigurationen.
3. Navigera till Adobe I/O Console och skapa en ny tjänstkontointegration för *Adobe Stock*.
4. Överför certifikatet från steg 2 till Adobe Stock tjänstkontointegration.
5. Välj den Adobe Stock-profilkonfiguration som krävs och slutför tjänstintegreringen.
6. Använd integreringsinformationen för att slutföra konfigurationen av Adobe IMS Technical Account
7. Kontrollera att du kan ta emot åtkomsttoken med hjälp av Adobe IMS Technical Account.

![Tekniskt konto för Adobe IMS](assets/screen_shot_2018-10-22at12219pm.png)

#### Konfigurera Adobe Stock Cloud Services {#set-up-adobe-stock-cloud-services}

1. Skapa en ny molntjänstkonfiguration för Adobe Stock under **Verktyg > CLoud-tjänster.**
2. Välj den *Adobe IMS-konfiguration* som skapades i avsnittet ovan för din *Adobe Stock Cloud*-konfiguration

3. Se till att du väljer **MILJÖ** som PROD.
4. **Sökväg till licensierad resurs** kan peka mot valfri katalog under `/content/dam`.
5. Välj språkinställning och slutför inställningarna.
6. Du kan också lägga till användare/grupper i din Adobe Stock Cloud-tjänst för att aktivera åtkomst för specifika användare eller grupper.

![Konfiguration av Adobe Assets Stock](assets/screen_shot_2018-10-22at12425pm.png)

### Ytterligare resurser

* [Enterprise Stock-plan](https://landing.adobe.com/en/na/products/creative-cloud/ctir-4625-stock-for-enterprise/index.html)
* [Versionsinformation om AEM 6.4 Service Pack 2](https://experienceleague.adobe.com/docs/experience-manager-65/release-notes/release-notes.html?lang=sv-SE)
* [Integrera AEM och Adobe Stock](https://experienceleague.adobe.com/docs/experience-manager-65/assets/using/aem-assets-adobe-stock.html?lang=sv-SE)
* [Integrerings-API:t för Adobe I/O Console](https://www.adobe.io/apis/cloudplatform/console/authentication/gettingstarted.html)
* [Adobe Stock API Docs](https://www.adobe.io/apis/creativecloud/stock/docs.html)
