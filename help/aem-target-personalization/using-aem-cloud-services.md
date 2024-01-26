---
title: Integrera Adobe Experience Manager med Adobe Target med Cloud Service
description: Steg för steg gå igenom hur du integrerar Adobe Experience Manager (AEM) med Adobe Target med AEM Cloud Service
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 9b191211-2030-4b62-acad-c7eb45b807ca
duration: 357
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '358'
ht-degree: 0%

---

# Använda AEM äldre Cloud Service

I det här avsnittet ska vi diskutera hur du konfigurerar Adobe Experience Manager (AEM) med Adobe Target med hjälp av äldre Cloud Service.

>[!NOTE]
>
> Den AEM äldre Cloud Servicen med Adobe Target är **endast** som används för att skapa en direktanslutning AEM författare till Adobe Target back-end-anslutning som underlättar publicering av innehåll från AEM till Target. Adobe Launch används för att visa Adobe Target på den offentliga sajten som AEM betjänar.

För att kunna använda AEM Experience Fragment-erbjudanden som stöd för personaliseringsaktiviteter går vi vidare till nästa kapitel och integrerar AEM med Adobe Target med de äldre molntjänsterna. Den här integreringen krävs för att överföra Experience Fragments från AEM till Target som HTML/JSON-erbjudanden och för att hålla målerbjudandena synkroniserade med AEM. Den här integreringen krävs för implementering [Scenario 1 som diskuteras i översiktsavsnittet](./overview.md#personalization-using-aem-experience-fragment).

## Förutsättningar

* **AEM**

   * AEM författare och publiceringsinstans krävs för att slutföra kursen. Om du inte har konfigurerat AEM än kan du följa stegen [här](./implementation.md#set-up-aem).

* **Experience Cloud**
   * Tillgång till er organisation Adobe Experience Cloud - `https://<yourcompany>.experiencecloud.adobe.com`
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Target](https://experiencecloud.adobe.com)

     >[!NOTE]
     >
     > Kunden måste tillhandahållas med Experience Platform Launch och Adobe I/O från [Stöd för Adobe](https://helpx.adobe.com/se/contact/enterprise-support.ec.html) eller kontakta systemadministratören

### Integrera AEM med Adobe Target

>[!VIDEO](https://video.tv.adobe.com/v/28428?quality=12&learn=on)

1. Skapa Adobe Target-Cloud Service med Adobe IMS-autentisering (*Använder Adobe Target API*) (00:34)
2. Hämta Adobe Target-klientkod (01:50)
3. Skapa Adobe IMS-konfiguration för Adobe Target (02:08)
4. Skapa ett tekniskt konto för åtkomst till Target API i Adobe I/O Console (02:08)
5. Lägg till Adobe Target-Cloud Service i AEM Experience Fragments (04:12)

Nu har du lyckats integrera [AEM med Adobe Target med äldre Cloud Service](./using-aem-cloud-services.md#integrating-aem-target-options) enligt alternativ 2. Nu bör ni kunna skapa en Experience Fragment inom AEM och publicera Experience Fragment som HTML eller JSON Offer till Adobe Target, och sedan kan ni använda den för att skapa en aktivitet.
