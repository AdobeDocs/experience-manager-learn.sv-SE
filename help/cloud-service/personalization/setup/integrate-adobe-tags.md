---
title: Integrera taggar i Adobe Experience Platform
description: Lär dig hur du integrerar AEM as a Cloud Service med taggar i Adobe Experience Platform. Tack vare integreringen kan du driftsätta Adobe Web SDK och lägga in egna JavaScript för datainsamling och personalisering på dina AEM-sidor.
version: Experience Manager as a Cloud Service
feature: Personalization, Integrations
topic: Personalization, Integrations, Architecture, Content Management
role: Developer, Architect, Leader, Data Architect, User
level: Beginner
doc-type: Tutorial
last-substantial-update: 2025-08-07T00:00:00Z
jira: KT-18719
thumbnail: null
source-git-commit: 70665c019f63df1e736292ad24c47624a3a80d49
workflow-type: tm+mt
source-wordcount: '745'
ht-degree: 0%

---


# Integrera taggar i Adobe Experience Platform

Lär dig integrera AEM as a Cloud Service (AEMCS) med taggar i Adobe Experience Platform. Tack vare integreringen med Taggar (även kallad Launch) kan du driftsätta Adobe Web SDK och lägga in anpassade JavaScript för datainsamling och personalisering på dina AEM-sidor.

Tack vare integreringen kan ert marknadsförings- eller utvecklingsteam hantera och driftsätta JavaScript för personalisering och datainsamling - utan att behöva driftsätta AEM-kod på nytt.

## Steg på hög nivå

Integreringsprocessen omfattar fyra huvudsteg som upprättar anslutningen mellan AEM och Taggar:

1. **Skapa, konfigurera och publicera en taggegenskap i Adobe Experience Platform**
2. **Verifiera en Adobe IMS-konfiguration för taggar i AEM**
3. **Skapa en taggkonfiguration i AEM**
4. **Tillämpa taggkonfigurationen på dina AEM-sidor**

## Skapa, konfigurera och publicera en taggegenskap i Adobe Experience Platform

Börja med att skapa en taggegenskap i Adobe Experience Platform. Den här egenskapen hjälper dig att hantera distributionen av Adobe Web SDK och alla anpassade JavaScript som krävs för personalisering och datainsamling.

1. Gå till [Adobe Experience Platform](https://experience.adobe.com/platform), logga in med din Adobe ID och navigera till **Taggar** på den vänstra menyn.\
   ![Adobe Experience Platform-taggar](../assets/setup/aep-tags.png)

2. Klicka på **Ny egenskap** om du vill skapa en ny taggegenskap.\
   ![Skapa ny taggegenskap](../assets/setup/aep-create-tags-property.png)

3. Ange följande i dialogrutan **Skapa egenskap**:
   - **Egenskapsnamn**: Ett namn för taggegenskapen
   - **Egenskapstyp**: Välj **Webb**
   - **Domän**: Domänen där du distribuerar egenskapen (till exempel `.adobeaemcloud.com`)

   Klicka på **Spara**.

   ![Adobe-taggegenskap](../assets/setup/adobe-tags-property.png)

4. Öppna den nya egenskapen. Tillägget **Core** ska redan inkluderas. Senare kommer du att lägga till tillägget **Web SDK** när du konfigurerar användningsfallet Experimentation, eftersom det kräver ytterligare konfiguration, till exempel **DataStream ID**.\
   ![Kärntillägg för Adobe-taggar](../assets/setup/adobe-tags-core-extension.png)

5. Publicera taggegenskapen genom att gå till **Publiceringsflöde** och klicka på **Lägg till bibliotek** för att skapa ett distributionsbibliotek.
   ![Publiceringsflöde för Adobe-taggar](../assets/setup/adobe-tags-publishing-flow.png)

6. Ange följande i dialogrutan **Skapa bibliotek**:
   - **Namn**: Ett namn för ditt bibliotek
   - **Miljö**: Välj **Utveckling**
   - **Resursändringar**: Välj **Lägg till alla ändrade resurser**

   Klicka på **Spara och skapa till utveckling**.

   ![Adobe Tags Create Library](../assets/setup/adobe-tags-create-library.png)

7. Om du vill publicera biblioteket i produktion klickar du på **Godkänn och publicera i produktion**. När publiceringen är klar är egenskapen klar att användas i AEM.\
   ![Adobe Tags Godkänn och publicera](../assets/setup/adobe-tags-approve-publish.png)

## Verifiera en Adobe IMS-konfiguration för taggar i AEM

När en AEMCS-miljö etableras innehåller den automatiskt en Adobe IMS-konfiguration för taggar, tillsammans med ett motsvarande Adobe Developer Console-projekt. Den här konfigurationen säkerställer säker API-kommunikation mellan AEM och taggar.

1. I AEM går du till **Verktyg** > **Säkerhet** > **Adobe IMS-konfigurationer**.\
   ![Adobe IMS-konfigurationer](../assets/setup/aem-ims-configurations.png)

2. Leta reda på **Adobe Launch** -konfigurationen. Om den är tillgänglig markerar du den och klickar på **Kontrollera hälsa** för att verifiera anslutningen. Du borde se ett lyckat svar.\
   ![Hälsokontroll för Adobe IMS-konfiguration](../assets/setup/aem-ims-configuration-health-check.png)

## Skapa en taggkonfiguration i AEM

Skapa en taggkonfiguration i AEM för att ange de egenskaper och inställningar som behövs för webbplatssidorna.

1. I AEM går du till **Verktyg** > **Cloud-tjänster** > **Adobe Launch Configurations**.\
   ![Adobe-startkonfigurationer](../assets/setup/aem-launch-configurations.png)

2. Markera platsens rotmapp (till exempel WKND-plats) och klicka på **Skapa**.\
   ![Skapa startkonfiguration för Adobe](../assets/setup/aem-create-launch-configuration.png)

3. Ange följande i dialogrutan:
   - **Titel**: Till exempel&quot;Adobe-taggar&quot;
   - **IMS-konfiguration**: Välj den verifierade **IMS-konfigurationen för Adobe Launch**
   - **Företag**: Välj det företag som är länkat till din taggegenskap
   - **Egenskap**: Välj taggegenskapen som skapades tidigare

   Klicka på **Nästa**.

   ![Konfigurationsinformation för Adobe Launch](../assets/setup/aem-launch-configuration-details.png)

4. I demonstrationssyfte bör du behålla standardvärdena för **Förproduktion**- och **Produktion**-miljöer. Klicka på **Skapa**.\
   ![Konfigurationsinformation för Adobe Launch](../assets/setup/aem-launch-configuration-create.png)

5. Markera den nyligen skapade konfigurationen och klicka på **Publicera** för att göra den tillgänglig för webbplatsens sidor.\
   ![Publicering av startkonfiguration för Adobe](../assets/setup/aem-launch-configuration-publish.png)

## Använda taggkonfigurationen på din AEM-plats

Använd tagg-konfigurationen för att mata in Web SDK och anpassningslogiken på webbplatsens sidor.

1. Gå till **Webbplatser** i AEM, markera din rotwebbplatsmapp (till exempel WKND-plats) och klicka på **Egenskaper**.\
   ![AEM webbplatsegenskaper](../assets/setup/aem-site-properties.png)

2. Öppna fliken **Avancerat** i dialogrutan **Webbplatsegenskaper** . Under **Konfigurationer** kontrollerar du att `/conf/wknd` är markerat för **molnkonfiguration**.\
   ![Avancerade egenskaper för AEM-webbplatser](../assets/setup/aem-site-advanced-properties.png)

## Verifiera integreringen

För att bekräfta att taggkonfigurationen fungerar som den ska kan du:

1. Kontrollera vykällan för en AEM-publiceringssida eller inspektera den med hjälp av webbläsarutvecklarverktygen
2. Använd [Adobe Experience Platform Debugger](https://chromewebstore.google.com/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob) för att validera Web SDK- och JavaScript-injektionen

![Adobe Experience Platform Debugger](../assets/setup/aep-debugger.png)

## Ytterligare resurser

- [Adobe Experience Platform Debugger - översikt](https://experienceleague.adobe.com/en/docs/experience-platform/debugger/home)
- [Översikt över taggar](https://experienceleague.adobe.com/en/docs/experience-platform/tags/home)
