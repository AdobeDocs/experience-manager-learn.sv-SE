---
title: Integrera Adobe Experience Manager med Adobe Target med Cloud Services
seo-title: Integrating Adobe Experience Manager (AEM) with Adobe Target using Legacy Cloud Services
description: Steg för steg gå igenom hur du integrerar Adobe Experience Manager (AEM) med Adobe Target med hjälp av AEM Cloud Service
seo-description: Step by step walkthrough on how to integrate Adobe Experience Manager (AEM) with Adobe Target using AEM Cloud Service
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
source-git-commit: ea7d49985e69ecf9713e17e51587125b3fb400ee
workflow-type: tm+mt
source-wordcount: '351'
ht-degree: 1%

---


# Använda AEM äldre Cloud Services

I det här avsnittet ska vi diskutera hur du konfigurerar Adobe Experience Manager (AEM) med Adobe Target med hjälp av äldre Cloud Services.

>[!NOTE]
>
> Den AEM äldre Cloud Servicen med Adobe Target är **endast** som används för att upprätta en direkt AEM Author till Adobe Target back-end-anslutning som underlättar publicering av innehåll från AEM till Target. Adobe Launch används för att visa Adobe Target på den offentliga webbplats som AEM betjänar.

För att kunna använda AEM Experience Fragment-erbjudanden som stöd för personaliseringsaktiviteter går vi vidare till nästa kapitel och integrerar AEM med Adobe Target med de äldre molntjänsterna. Den här integreringen krävs för att överföra Experience Fragments från AEM till Target som HTML/JSON-erbjudanden och för att hålla målerbjudandena synkroniserade med AEM. Den här integreringen krävs för implementering av [scenario 1 som beskrivs i översiktsavsnittet](./overview.md#personalization-using-aem-experience-fragment).

## Förutsättningar

* **AEM**

   * AEM författare och publiceringsinstans krävs för att slutföra den här självstudiekursen. Om du inte har konfigurerat AEM än kan du följa stegen [här](./implementation.md#set-up-aem).

* **Experience Cloud**
   * Tillgång till ditt företag Adobe Experience Cloud - `https://<yourcompany>.experiencecloud.adobe.com`
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Target](https://experiencecloud.adobe.com)

      >[!NOTE]
      >
      > Kunden måste etableras med Experience Platform Launch och Adobe I/O från [Adobe support](https://helpx.adobe.com/se/contact/enterprise-support.ec.html) eller kontakta systemadministratören


### Integrera AEM med Adobe Target

>[!VIDEO](https://video.tv.adobe.com/v/28428?quality=12&learn=on)

1. Skapa Adobe Target-Cloud Service med Adobe IMS-autentisering (*Använder Adobe Target API*) (00:34)
2. Hämta Adobe Target-klientkod (01:50)
3. Skapa Adobe IMS-konfiguration för Adobe Target (02:08)
4. Skapa ett tekniskt konto för åtkomst till Target API i Adobe I/O Console (02:08)
5. Lägg till Adobe Target-Cloud Service i AEM Experience Fragments (04:12)

Nu har du integrerat [AEM med Adobe Target med äldre Cloud Services](./using-aem-cloud-services.md#integrating-aem-target-options) enligt alternativ 2. Nu bör du kunna skapa en Experience Fragment i AEM och publicera Experience Fragment som HTML-erbjudande eller JSON-erbjudande till Adobe Target, och sedan kan du använda den för att skapa en aktivitet.
