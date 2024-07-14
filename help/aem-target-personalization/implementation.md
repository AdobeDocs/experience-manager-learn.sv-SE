---
title: Integrera AEM Sites med Adobe Target
description: En artikel om hur du konfigurerar Adobe Experience Manager med Adobe Target för olika scenarier.
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: 54a30cd9-d94a-4de5-82a1-69ab2263980d
duration: 130
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '596'
ht-degree: 0%

---

# Integrera AEM Sites med Adobe Target

I det här avsnittet ska vi diskutera hur du konfigurerar Adobe Experience Manager Sites med Adobe Target för olika scenarier. Baserat på ditt scenario och organisationens krav.

* **Lägg till Adobe Target JavaScript-bibliotek (krävs för alla scenarier)**
För webbplatser som finns på AEM kan du lägga till målbibliotek på din webbplats med [taggar i Adobe Experience Platform](https://experienceleague.adobe.com/docs/experience-platform/tags/home.html) . Taggar är ett enkelt sätt att driftsätta och hantera alla taggar som behövs för att skapa relevanta kundupplevelser.
* **Lägg till Adobe Target-Cloud Service (krävs för scenariot Experience Fragments)**
För AEM kunder som vill använda Experience Fragment-erbjudanden för att skapa en aktivitet i Adobe Target måste ni integrera Adobe Target med AEM med de äldre Cloud Servicen. Den här integreringen krävs för att överföra Experience Fragments från AEM till Target som HTML/JSON-erbjudanden och för att hålla erbjudandena synkroniserade med AEM. *Den här integreringen krävs för att implementera scenario 1.*

## Förutsättningar

* **Adobe Experience Manager (AEM){#aem}**
   * AEM 6.5 (*senaste Service Pack rekommenderas*)
   * Ladda ned AEM WKND-referenspaket
      * [aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip)
      * [aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip)
      * [Kärnkomponenter](https://github.com/adobe/aem-core-wcm-components/releases/download/core.wcm.components.reactor-2.5.0/core.wcm.components.all-2.5.0.zip)
      * [Digitalt datalager](assets/implementation/digital-data-layer.zip)

* **Experience Cloud**
   * Åtkomst till ditt företag Adobe Experience Cloud - `https://<yourcompany>.experiencecloud.adobe.com`
   * Experience Cloud tillhandahålls med följande lösningar
      * [Datainsamling](https://experiencecloud.adobe.com)
      * [Adobe Target](https://experiencecloud.adobe.com)
      * [Adobe I/O Console](https://console.adobe.io)

* **Miljö**
   * Java 1.8 eller Java 11 (endast AEM 6.5+)
   * Apache Maven (3.3.9 eller senare)
   * Chrome

>[!NOTE]
>
> Kunden måste etableras med datainsamling och Adobe I/O från [Adobe support](https://helpx.adobe.com/se/contact/enterprise-support.ec.html) eller kontakta systemadministratören

### Konfigurera AEM{#set-up-aem}

AEM författare och publiceringsinstans krävs för att slutföra kursen. Författarinstansen körs på `http://localhost:4502` och publiceringsinstansen körs på `http://localhost:4503`. Mer information finns i: [Konfigurera en lokal AEM utvecklingsmiljö](https://helpx.adobe.com/experience-manager/kt/platform-repository/using/local-aem-dev-environment-article-setup.html).

#### Konfigurera AEM Author och Publish Instances

1. Hämta en kopia av [AEM QuickStart Jar och en licens.](https://helpx.adobe.com/experience-manager/6-5/sites/deploying/using/deploy.html#GettingtheSoftware)
2. Skapa en mappstruktur på datorn enligt följande:
   ![Mappstruktur](assets/implementation/aem-setup-1.png)
3. Byt namn på Quickstart-burken till `aem-author-p4502.jar` och placera den under katalogen `/author`. Lägg till filen `license.properties` under katalogen `/author`.
   ![AEM författarinstans](assets/implementation/aem-setup-author.png)
4. Gör en kopia av Quickstart-behållaren, byt namn på den till `aem-publish-p4503.jar` och placera den under katalogen `/publish`. Lägg till en kopia av filen `license.properties` under katalogen `/publish`.
   ![AEM Publish-instans](assets/implementation/aem-setup-publish.png)
5. Dubbelklicka på filen `aem-author-p4502.jar` för att installera författarinstansen. Detta startar författarinstansen, som körs på port 4502 på den lokala datorn.
6. Logga in med inloggningsuppgifterna nedan och när du har loggat in dirigeras du till AEM hemsidesskärm.
användarnamn : **admin**
password : **admin**
   ![AEM Publish-instans](assets/implementation/aem-author-home-page.png)
7. Dubbelklicka på filen `aem-publish-p4503.jar` för att installera en publiceringsinstans. Du kan lägga märke till att en ny flik öppnas i webbläsaren för din publiceringsinstans som körs på port 4503 och visar hemsidan för WeRetail. Vi använder WKND-referensplatsen för den här självstudien och vi installerar paketen på författarinstansen.
8. Navigera till AEM författare i webbläsaren på `http://localhost:4502`. På AEM startskärm går du till *[Verktyg > Distribution > Paket](http://localhost:4502/crx/packmgr/index.jsp)*.
9. Hämta och överföra paketen för AEM (visas ovan under *[Krav > AEM](#aem)*)
   * [aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.apps-0.0.1-SNAPSHOT.zip)
   * [aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip](https://github.com/adobe/aem-guides-wknd/releases/download/archetype-18.1/aem-guides-wknd.ui.content-0.0.1-SNAPSHOT.zip)
   * [core.wcm.components.all-2.5.0.zip](https://github.com/adobe/aem-core-wcm-components/releases/download/core.wcm.components.reactor-2.5.0/core.wcm.components.all-2.5.0.zip)
   * [digital-data-layer.zip](assets/implementation/digital-data-layer.zip)

   >[!VIDEO](https://video.tv.adobe.com/v/28377?quality=12&learn=on)
10. När du har installerat paketen på AEM Author markerar du varje överfört paket i AEM Package Manager och väljer **Mer > Replikera** för att se till att paketen distribueras till AEM Publish.
11. Nu har du installerat WKND-referenswebbplatsen och alla andra paket som krävs för den här kursen.

[NÄSTA KAPITEL](./using-launch-adobe-io.md): I nästa kapitel integrerar du taggar med AEM.
