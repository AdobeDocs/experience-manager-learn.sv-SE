---
title: Integrera Adobe Experience Manager med Adobe Target med Experience Platform Launch och Adobe I/O
seo-title: Integrera Adobe Experience Manager med Adobe Target med Experience Platform Launch och Adobe I/O
description: Steg för steg gå igenom hur du integrerar Adobe Experience Manager med Adobe Target med Experience Platform Launch och Adobe I/O
seo-description: Steg för steg gå igenom hur du integrerar Adobe Experience Manager med Adobe Target med Experience Platform Launch och Adobe I/O
translation-type: tm+mt
source-git-commit: 1209064fd81238d4611369b8e5b517365fc302e3
workflow-type: tm+mt
source-wordcount: '1098'
ht-degree: 1%

---


# Använda Adobe Experience Platform Launch via Adobe I/O Console

## Förutsättningar

* [AEM skapar och publicerar ](./implementation.md#set-up-aem) instancerunning på localhost-port 4502 respektive 4503
* **Experience Cloud**
   * Åtkomst till dina organisationer Adobe Experience Cloud - <https://>`<yourcompany>`.experienceCloud.adobe.com
   * Experience Cloud tillhandahålls med följande lösningar
      * [Adobe Experience Platform Launch](https://experiencecloud.adobe.com)
      * [Adobe Target](https://experiencecloud.adobe.com)
      * [Adobe I/O Console](https://console.adobe.io)

      >[!NOTE]
      >Du bör ha behörighet att utveckla, godkänna, publicera, hantera tillägg och hantera miljöer i Launch. Om du inte kan slutföra något av dessa steg eftersom du inte har tillgång till gränssnittsalternativen ber du Experience Cloud-administratören att få åtkomst. Mer information om startbehörigheter finns i [dokumentationen](https://docs.adobelaunch.com/administration/user-permissions).


* **Webbläsarplugin-program**
   * Adobe Experience Cloud Debugger ([Chrome](https://chrome.google.com/webstore/detail/adobe-experience-cloud-de/ocdmogmohccmeicdhlhhgepeaijenapj))
   * Starta och DTM-växel ([Chrome](https://chrome.google.com/webstore/detail/launch-and-dtm-switch/nlgdemkdapolikbjimjajpmonpbpmipk))

## Berörda användare

För den här integreringen måste följande målgrupper vara inblandade, och för att kunna utföra vissa uppgifter kan du behöva administrativ åtkomst.

* Developer
* AEM
* Experience Cloud Administrator

## Introduktion

AEM erbjuder en färdig integrering med Experience Platform Launch. Tack vare den här integreringen kan AEM enkelt konfigurera Experience Platform Launch via ett användarvänligt gränssnitt, vilket minskar antalet fel och arbetsinsatser när dessa två verktyg konfigureras. Och bara genom att lägga till Adobe Target-tillägget i Experience Platform Launch kan vi använda alla funktioner i Adobe Target på AEM webbsida/webbsidor.

I det här avsnittet ska vi ta upp följande integreringssteg:

* Starta
   * Skapa en startegenskap
   * Lägger till måltillägg
   * Skapa ett dataelement
   * Skapa en sidregel
   * Konfigurera miljöer
   * Bygg och publicera
* AEM
   * Skapa en Cloud Service
   * Skapa

### Starta

#### Skapa en startegenskap

En egenskap är en behållare som du fyller med tillägg, regler, dataelement och bibliotek när du distribuerar taggar till webbplatsen.

1. Gå till din organisation [Adobe Experience Cloud](https://experiencecloud.adobe.com/) (<https://>`<yourcompany>`.experienceCloud.adobe.com)
2. Logga in med din Adobe ID och kontrollera att du är i rätt organisation.
3. I lösningsväljaren klickar du på **Starta** och väljer sedan knappen **Gå till start**.

   ![Experience Cloud - Starta](assets/using-launch-adobe-io/exc-cloud-launch.png)

4. Se till att du är i rätt organisation och fortsätt sedan att skapa en Launch-egenskap.
   ![Experience Cloud - Starta](assets/using-launch-adobe-io/launch-create-property.png)

   *Mer information om hur du skapar egenskaper finns i  [Skapa en ](https://docs.adobelaunch.com/administration/companies-and-properties#create-a-property) egenskap i produktdokumentationen.*
5. Klicka på knappen **Ny egenskap**
6. Ange ett namn för egenskapen (till exempel *AEM mållokurs*)
7. Som domän anger du *localhost.com* eftersom det är den domän där WKND-demowebbplatsen körs. Trots att fältet *Domän* är obligatoriskt fungerar egenskapen Launch på alla domäner där det implementeras. Det främsta syftet med det här fältet är att förifylla menyalternativ i regelbyggaren.
8. Klicka på knappen **Spara**.

   ![Launch - ny egenskap](assets/using-launch-adobe-io/exc-launch-property.png)

9. Öppna egenskapen som du nyss skapade och klicka på fliken Tillägg.

#### Lägger till måltillägg

Adobe Target-tillägget stöder implementeringar på klientsidan med Target JavaScript SDK för den moderna webben `at.js`. Kunder som fortfarande använder det äldre målbiblioteket `mbox.js`, [bör uppgradera till at.js](https://docs.adobe.com/content/help/en/target/using/implement-target/client-side/upgrading-from-atjs-1x-to-atjs-20.html) för att använda Launch.

Tillägget Mål består av två huvuddelar:

* Tilläggskonfigurationen som hanterar huvudbiblioteksinställningarna
* Regelåtgärder för att göra följande:
   * Load Target (at.js)
   * Lägg till parametrar i alla rutor
   * Lägg till parametrar i global Mbox
   * Fire Global Mbox

1. Under **Tillägg** kan du se listan över tillägg som redan är installerade för Launch-egenskapen. ([Experience Platform Launch Core Extension](https://exchange.adobe.com/experiencecloud.details.100223.adobe-launch-core-extension.html) är installerat som standard)
2. Klicka på alternativet **Tilläggskatalog** och sök efter mål i filtret.
3. Välj den senaste versionen av Adobe Target at.js och klicka på alternativet **Installera**.
   ![Launch - ny egenskap](assets/using-launch-adobe-io/launch-target-extension.png)

4. Klicka på knappen **Konfigurera** och du kan se konfigurationsfönstret med dina Target-kontoinloggningsuppgifter importerade och at.js-versionen för det här tillägget.
   ![Mål - Tilläggskonfiguration](assets/using-launch-adobe-io/launch-target-extension-2.png)

   När Target distribueras via asynkrona Launch-inbäddningskoder bör du hårdkoda ett fragment som döljs på sidorna före Launch-inbäddningskoderna för att hantera innehållsflimret. Vi kommer att lära oss mer om den fördolda snipparen senare. Du kan hämta det fördolda fragmentet [här](assets/using-launch-adobe-io/prehiding.js)

5. Klicka på **Spara** om du vill lägga till måltillägget i din Launch-egenskap, och du bör nu kunna se måltillägget som listas i listan **Installerade**-tillägg.

6. Upprepa stegen ovan om du vill söka efter tillägget Experience Cloud ID-tjänst och installera det.
   ![Tillägg - Experience Cloud ID-tjänst](assets/using-launch-adobe-io/launch-extension-experience-cloud.png)

#### Konfigurera miljöer

1. Klicka på fliken **Miljö** för platsegenskapen, och du kan se listan över den miljö som skapas för platsegenskapen. Som standard har vi en instans som skapats för utveckling, staging och produktion.

![Dataelement - sidnamn](assets/using-launch-adobe-io/launch-environment-setup.png)

#### Bygg och publicera

1. Klicka på fliken **Publicera** för din webbplatsegenskap, och låt oss skapa ett bibliotek för att bygga och distribuera våra ändringar (dataelement, regler) till en utvecklingsmiljö.
   >[!VIDEO](https://video.tv.adobe.com/v/28412?quality=12&learn=on)
2. Publicera ändringarna från utvecklingsmiljön till en mellanlagringsmiljö.
   >[!VIDEO](https://video.tv.adobe.com/v/28419?quality=12&learn=on)
3. Kör alternativet **Bygg för mellanlagring**.
4. När bygget är klart kör du **Godkänn för publicering**, som flyttar dina ändringar från en mellanlagringsmiljö till en produktionsmiljö.
   ![Mellanlagring till produktion](assets/using-launch-adobe-io/build-staging.png)
5. Kör slutligen alternativet **Skapa och publicera till produktion** för att överföra ändringarna till produktionen.
   ![Bygg och publicera i produktion](assets/using-launch-adobe-io/build-and-publish.png)

### Adobe Experience Manager

>[!VIDEO](https://video.tv.adobe.com/v/28416?quality=12&learn=on)

>[!NOTE]
>
> Ge Adobe I/O-integreringen åtkomst till utvalda arbetsytor med rätt [roll så att ett centralt team kan göra API-drivna ändringar på bara några få arbetsytor](https://docs.adobe.com/content/help/en/target/using/administer/manage-users/enterprise/configure-adobe-io-integration.html).

1. Skapa IMS-integrering i AEM med hjälp av inloggningsuppgifter från Adobe I/O. (01:12 till 03:55)
2. Skapa en egenskap i Experience Platform Launch. (täckt [ovan](#create-launch-property))
3. Använd IMS-integreringen från steg 1 för att skapa integrering med Experience Platform Launch för att importera Launch-egenskapen.
4. I AEM mappar du Experience Platform Launch-integreringen till en webbplats med webbläsarkonfigurationen. (05:28 till 06:14)
5. Validera integreringen manuellt. (06:15 till 06:33)
6. Använda Launch/DTM-webbläsarplugin. (06:34 till 06:50)
7. Använda webbläsarplugin-programmet Adobe Experience Cloud Debugger. (06:51 till 07:22)

Nu har du integrerat [AEM med Adobe Target med Adobe Experience Platform Launch](./using-aem-cloud-services.md#integrating-aem-target-options) enligt alternativ 1.

Om du använder AEM Experience Fragment-erbjudanden för att ge dig möjlighet att anpassa dina aktiviteter går vi vidare till nästa kapitel och integrerar AEM med Adobe Target med hjälp av de gamla molntjänsterna.
