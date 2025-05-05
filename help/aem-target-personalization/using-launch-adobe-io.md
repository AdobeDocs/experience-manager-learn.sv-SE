---
title: Integrera Adobe Experience Manager med Adobe Target med taggar och Adobe Developer
description: Stegvisa steg-för-steg-anvisningar om hur du integrerar Adobe Experience Manager med Adobe Target med hjälp av taggar och Adobe Developer
feature: Experience Fragments
topic: Personalization
role: Developer
level: Intermediate
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Sites 6.5" before-title="false"
doc-type: Tutorial
exl-id: b1d7ce04-0127-4539-a5e1-802d7b9427dd
duration: 663
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '985'
ht-degree: 0%

---

# Använda taggar via Adobe Developer Console

## Förutsättningar

* [AEM författare och publiceringsinstans](./implementation.md#set-up-aem) som körs på lokal värdport 4502 respektive 4503
* **Experience Cloud**
   * Åtkomst till ditt företag Adobe Experience Cloud - `https://<yourcompany>.experiencecloud.adobe.com`
   * Tillhandahållande av Experience Cloud med följande lösningar
      * [Datainsamling](https://experiencecloud.adobe.com)
      * [Adobe Target](https://experiencecloud.adobe.com)
      * [Adobe Developer Console](https://developer.adobe.com/console/)

     >[!NOTE]
     >Du bör ha behörighet att utveckla, godkänna, Publish, hantera tillägg och hantera miljöer i datainsamling. Om du inte kan slutföra något av dessa steg eftersom du inte har tillgång till gränssnittsalternativen ber du Experience Cloud-administratören att få åtkomst. Mer information om taggbehörigheter finns i [dokumentationen](https://experienceleague.adobe.com/docs/experience-platform/tags/admin/user-permissions.html?lang=sv-SE).

* **Chrome webbläsartillägg**
   * Adobe Experience Cloud Debugger(https://chrome.google.com/webstore/detail/adobe-experience-platform/bfnnokhpnncpkdmbokanobigaccjkpob)

## Berörda användare

För den här integreringen måste följande målgrupper vara inblandade, och för att kunna utföra vissa uppgifter kan du behöva administrativ åtkomst.

* Developer
* AEM
* Experience Cloud Administrator

## Introduktion

AEM erbjuder en färdig integrering med taggar. Tack vare den här integreringen kan AEM enkelt konfigurera taggar via ett användarvänligt gränssnitt, vilket minskar antalet fel och arbetsinsatser när dessa två verktyg konfigureras. Och bara genom att lägga till Adobe Target-tillägg i taggar kan vi använda alla funktioner i Adobe Target på AEM webbsida/webbsidor.

I det här avsnittet ska vi ta upp följande integreringssteg:

* Taggar
   * Skapa en taggegenskap
   * Lägger till måltillägg
   * Skapa ett dataelement
   * Skapa en sidregel
   * Konfigurera miljöer
   * Bygg och Publish
* AEM
   * Skapa en Cloud Service
   * Skapa

### Taggar

#### Skapa en taggegenskap

En egenskap är en behållare som du fyller med tillägg, regler, dataelement och bibliotek när du distribuerar taggar till webbplatsen.

1. Navigera till din organisation [Adobe Experience Cloud](https://experiencecloud.adobe.com/) (`https://<yourcompany>.experiencecloud.adobe.com`)
1. Logga in med din Adobe ID och kontrollera att du är i rätt organisation.
1. Klicka på **Experience Platform**, **Datainsamling** och välj **Taggar** i lösningsväljaren.

![Experience Cloud - taggar](assets/using-launch-adobe-io/exc-cloud-launch.png)

1. Se till att du är i rätt organisation och fortsätt sedan att skapa en taggegenskap.
   ![Experience Cloud - taggar](assets/using-launch-adobe-io/launch-create-property.png)

   *Mer information om hur du skapar egenskaper finns i [Skapa en egenskap](https://experienceleague.adobe.com/docs/experience-platform/tags/admin/companies-and-properties.html?lang=sv-SE#create-or-configure-a-property) i produktdokumentationen.*
1. Klicka på knappen **Ny egenskap**
1. Ange ett namn för egenskapen (till exempel *AEM mållokurs*)
1. Som domän anger du *localhost.com* eftersom det är den domän där WKND-demowebbplatsen körs. Trots att fältet *Domän* krävs fungerar taggegenskapen på alla domäner där det implementeras. Det främsta syftet med det här fältet är att förifylla menyalternativ i regelbyggaren.
1. Klicka på knappen **Spara**.

   ![taggar - ny egenskap](assets/using-launch-adobe-io/exc-launch-property.png)

1. Öppna egenskapen som du nyss skapade och klicka på fliken Tillägg.

#### Lägger till måltillägg

Adobe Target-tillägget stöder implementeringar på klientsidan med Target JavaScript SDK för den moderna webben, `at.js`. Kunder som fortfarande använder det äldre målbiblioteket, `mbox.js`, [bör uppgradera till at.js](https://experienceleague.adobe.com/docs/target-dev/developer/client-side/at-js-implementation/upgrading-from-atjs-1x-to-atjs-20.html?lang=sv-SE) för att använda taggar.

Tillägget Mål består av två huvuddelar:

* Tilläggskonfigurationen, som hanterar huvudbiblioteksinställningarna
* Regelåtgärder för att göra följande:
   * Load Target (at.js)
   * Lägg till parametrar i alla rutor
   * Lägg till parametrar i global Mbox
   * Fire Global Mbox

1. Under **Tillägg** kan du se en lista över tillägg som redan har installerats för taggegenskapen. ([Kärntillägg för Adobe-start](https://exchange.adobe.com/apps/ec/100223/adobe-launch-core-extension) är installerat som standard)
2. Klicka på alternativet **Tilläggskatalog** och sök efter mål i filtret.
3. Välj den senaste versionen av Adobe Target at.js och klicka på alternativet **Install** .
   ![Taggar - ny egenskap](assets/using-launch-adobe-io/launch-target-extension.png)

4. Klicka på knappen **Konfigurera** och du kan se konfigurationsfönstret med dina Target-kontoinloggningsuppgifter importerade och at.js-versionen för det här tillägget.
   ![Mål - Tilläggskonfiguration](assets/using-launch-adobe-io/launch-target-extension-2.png)

   När Target distribueras via asynkrona taggar för inbäddning bör du hårdkoda ett fragment som döljs på sidorna före taggarna för att hantera innehållsflimret. Vi kommer att lära oss mer om den fördolda snipparen senare. Du kan hämta det fördolda fragmentet [här](assets/using-launch-adobe-io/prehiding.js)

5. Klicka på **Spara** för att lägga till måltillägget i taggegenskapen, och du bör nu kunna se måltillägget som listas i listan med **installerade** tillägg.

6. Upprepa stegen ovan om du vill söka efter tillägget Experience Cloud ID-tjänst och installera det.
   ![Tillägg - Experience Cloud ID-tjänst](assets/using-launch-adobe-io/launch-extension-experience-cloud.png)

#### Konfigurera miljöer

1. Klicka på fliken **Miljö** för din webbplatsegenskap, så ser du en lista över den miljö som skapas för din webbplatsegenskap. Som standard har vi en instans som skapats för utveckling, staging och produktion.

![Dataelement - sidnamn](assets/using-launch-adobe-io/launch-environment-setup.png)

#### Bygg och Publish

1. Klicka på fliken **Publicering** för din webbplatsegenskap och låt oss skapa ett bibliotek för att bygga och distribuera våra ändringar (dataelement, regler) till en utvecklingsmiljö.
   >[!VIDEO](https://video.tv.adobe.com/v/28412?quality=12&learn=on)
2. Publish dina ändringar från utvecklingsmiljön till mellanlagringsmiljön.
   >[!VIDEO](https://video.tv.adobe.com/v/28419?quality=12&learn=on)
3. Kör alternativet **Skapa för mellanlagring**.
4. När bygget är klart kör du **Godkänn för publicering**, vilket flyttar dina ändringar från en mellanlagringsmiljö till en produktionsmiljö.
   ![Förproduktion](assets/using-launch-adobe-io/build-staging.png)
5. Kör slutligen alternativet **Build och Publish till produktion** för att överföra ändringarna till produktionen.
   ![Skapa och Publish till produktion](assets/using-launch-adobe-io/build-and-publish.png)

### Adobe Experience Manager

>[!VIDEO](https://video.tv.adobe.com/v/28416?quality=12&learn=on)

>[!NOTE]
>
> Ge Adobe Developer-integreringen åtkomst till utvalda arbetsytor med rätt [roll så att ett centralt team kan göra API-drivna ändringar på bara några få arbetsytor](https://experienceleague.adobe.com/docs/target/using/administer/manage-users/enterprise/configure-adobe-io-integration.html?lang=sv-SE).

1. Skapa IMS-integrering i AEM med inloggningsuppgifter från Adobe Developer. (01:12 till 03:55)
2. Skapa en egenskap i Datainsamling. (täckt [över](#create-launch-property))
3. Använd IMS-integreringen från steg 1 för att skapa taggar för att importera taggegenskaperna.
4. I AEM mappar du taggintegreringen till en webbplats med webbläsarkonfigurationen. (05:28 till 06:14)
5. Validera integreringen manuellt. (06:15 till 06:33)
6. Använda webbläsarplugin-programmet Adobe Experience Cloud Debugger. (06:51 till 07:22)

Nu har du integrerat [AEM med Adobe Target med hjälp av taggar](./using-aem-cloud-services.md#integrating-aem-target-options), vilket beskrivs i alternativ 1.

Om du använder AEM Experience Fragment-erbjudanden för att ge dig möjlighet att anpassa dina aktiviteter går vi vidare till nästa kapitel och integrerar AEM med Adobe Target med hjälp av de gamla molntjänsterna.
