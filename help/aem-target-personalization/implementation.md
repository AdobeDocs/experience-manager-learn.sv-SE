---
title: Integrera Adobe Experience Manager med Adobe Target
seo-title: En artikel som handlar om olika sätt att integrera Adobe Experience Manager(AEM) med Adobe Target för att leverera personaliserat innehåll.
description: En artikel om hur du konfigurerar Adobe Experience Manager med Adobe Target för olika scenarier.
seo-description: En artikel om hur du konfigurerar Adobe Experience Manager med Adobe Target för olika scenarier.
feature: Experience Fragments
topic: Personanpassning
role: Developer
level: Intermediate
source-git-commit: 7200601c1b59bef5b1546a100589c757f25bf365
workflow-type: tm+mt
source-wordcount: '700'
ht-degree: 2%

---


# Integrera Adobe Experience Manager med Adobe Target

I det här avsnittet ska vi diskutera hur du konfigurerar Adobe Experience Manager med Adobe Target för olika scenarier. Baserat på ditt scenario och organisationens krav.

* **Lägg till Adobe Target JavaScript-bibliotek (krävs för alla scenarier)**
För webbplatser som finns på AEM kan du lägga till Target-bibliotek på webbplatsen med  [Starta](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html). Launch är ett enkelt sätt att driftsätta och hantera alla taggar som behövs för att skapa relevanta kundupplevelser.
* **Lägg till Adobe Target-Cloud Services (krävs för Experience Fragments-scenariot)**
För AEM som vill använda Experience Fragment-erbjudanden för att skapa en aktivitet i Adobe Target måste du integrera Adobe Target med AEM med de äldre Cloud Servicens. Den här integreringen krävs för att överföra Experience Fragments från AEM till Target som HTML/JSON-erbjudanden och för att hålla erbjudandena synkroniserade med AEM. 
*Den här integreringen krävs för att implementera scenario 1.*

## Förutsättningar

* **Adobe Experience Manager (AEM){#aem}**
   * AEM 6.5 (*senaste Service Pack rekommenderas*)
   * Ladda ned AEM WKND-referenspaket
      * [aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip)
      * [aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip)
      * [Kärnkomponenter](https://github.com/adobe/aem-core-wcm-components/releases/download/core.wcm.components.reactor-2.5.0/core.wcm.components.all-2.5.0.zip)
      * [Digitalt datalager](assets/implementation/digital-data-layer.zip)

* **Experience Cloud**
   * Åtkomst till dina organisationer Adobe Experience Cloud - <https://>`<yourcompany>`.experienceCloud.adobe.com
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Experience Platform Launch](https://experiencecloud.adobe.com)
      * [Adobe Target](https://experiencecloud.adobe.com)
      * [Adobe I/O Console](https://console.adobe.io)

* **Miljö**
   * Java 1.8 eller Java 11 (endast AEM 6.5+)
   * Apache Maven (3.3.9 eller senare)
   * Krom

>[!NOTE]
>
> Kunden måste etableras med Experience Platform Launch och Adobe I/O från [Adobe support](https://helpx.adobe.com/se/contact/enterprise-support.ec.html) eller kontakta systemadministratören

### Konfigurera AEM{#set-up-aem}

AEM författare och publiceringsinstans krävs för att slutföra den här självstudiekursen. Vi kör författarinstansen på `http://localhost:4502` och publicerar instansen på `http://localhost:4503`. Mer information finns i: [Konfigurera en lokal AEM utvecklingsmiljö](https://helpx.adobe.com/experience-manager/kt/platform-repository/using/local-aem-dev-environment-article-setup.html).

#### Konfigurera AEM Author och Publish Instances

1. Hämta en kopia av [AEM QuickStart Jar och en licens.](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/deploy.html#GettingtheSoftware)
2. Skapa en mappstruktur på datorn enligt följande:
   ![Mappstruktur](assets/implementation/aem-setup-1.png)
3. Byt namn på Quickstart-burken till `aem-author-p4502.jar` och placera den under katalogen `/author`. Lägg till filen `license.properties` under katalogen `/author`.
   ![AEM Author Instance](assets/implementation/aem-setup-author.png)
4. Skapa en kopia av Quickstart-behållaren, byt namn på den till `aem-publish-p4503.jar` och placera den under katalogen `/publish`. Lägg till en kopia av filen `license.properties` under katalogen `/publish`.
   ![AEM Publish Instance](assets/implementation/aem-setup-publish.png)
5. Dubbelklicka på `aem-author-p4502.jar`-filen för att installera Author-instansen. Detta startar författarinstansen, som körs på port 4502 på den lokala datorn.
6. Logga in med inloggningsuppgifterna nedan och när du har loggat in dirigeras du till AEM hemsidesskärm.
användarnamn: **admin**
lösenord: **admin**
   ![AEM Publish Instance](assets/implementation/aem-author-home-page.png)
7. Dubbelklicka på `aem-publish-p4503.jar`-filen för att installera en publiceringsinstans. Du kan lägga märke till att en ny flik öppnas i webbläsaren för din publiceringsinstans som körs på port 4503 och visar hemsidan för WeRetail. Vi kommer att använda WKND-referensplatsen för den här självstudiekursen och vi installerar paketen på författarinstansen.
8. Gå till AEM Author i webbläsaren på `http://localhost:4502`. På AEM startskärm går du till *[Verktyg > Distribution > Paket](http://localhost:4502/crx/packmgr/index.jsp)*.
9. Hämta och överföra paketen för AEM (visas ovan under *[Krav > AEM](#aem)*)
   * [aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip)
   * [aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip)
   * [core.wcm.components.all-2.5.0.zip](https://github.com/adobe/aem-core-wcm-components/releases/download/core.wcm.components.reactor-2.5.0/core.wcm.components.all-2.5.0.zip)
   * [digital-data-layer.zip](assets/implementation/digital-data-layer.zip)

   >[!VIDEO](https://video.tv.adobe.com/v/28377?quality=12&learn=on)
10. När du har installerat paketen på AEM Author markerar du varje överfört paket i AEM Package Manager och väljer **Mer > Replikera** för att se till att paketen distribueras till AEM Publish.
11. Nu har du installerat WKND-referenswebbplatsen och alla andra paket som krävs för den här självstudiekursen.

[NÄSTA KAPITEL](./using-launch-adobe-io.md): I nästa kapitel ska du integrera Launch med AEM.
