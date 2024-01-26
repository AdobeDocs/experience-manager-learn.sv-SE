---
title: Skapa en plats | Skapa AEM
description: Lär dig hur du använder guiden Skapa webbplats för att skapa en ny webbplats. Standardwebbplatsmallen som tillhandahålls av Adobe är en startpunkt för den nya webbplatsen.
version: Cloud Service
topic: Content Management
feature: Core Components, Page Editor
role: Developer
level: Beginner
jira: KT-7496
thumbnail: KT-7496.jpg
doc-type: Tutorial
exl-id: 6d0fdc4d-d85f-4966-8f7d-d53506a7dd08
recommendations: noDisplay, noCatalog
duration: 265
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '959'
ht-degree: 0%

---

# Skapa en plats {#create-site}

Som en del av guiden Skapa webbplats i Adobe Experience Manager, AEM, skapar du en ny webbplats. Standardwebbplatsmallen som tillhandahålls av Adobe används som startpunkt för den nya platsen.

## Förutsättningar {#prerequisites}

Stegen i det här kapitlet kommer att utföras i en Adobe Experience Manager as a Cloud Service-miljö. Kontrollera att du har administratörsbehörighet för AEM. Det rekommenderas att du använder [Sandlådeprogram](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/onboarding/getting-access/sandbox-programs/introduction-sandbox-programs.html) och [Utvecklingsmiljö](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/using-cloud-manager/manage-environments.html) när du slutför den här självstudiekursen.

[Produktionsprogram](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/programs/introduction-production-programs.html) Du kan även använda miljöer för den här självstudiekursen, men se till att aktiviteterna i den här självstudiekursen inte påverkar det arbete som utförs i målmiljöerna, eftersom den här självstudiekursen distribuerar innehåll och kod till AEM.

The [AEM SDK](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/local-development-environment-set-up/aem-runtime.html) kan användas för delar av kursen. Proportioner av den här självstudiekursen som bygger på molntjänster, som [driftsätta teman med Cloud Managers frontendpipeline](https://experienceleague.adobe.com/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/site-template/theming.html), kan inte utföras på AEM SDK.

Granska [dokumentation om introduktion](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/onboarding/home.html) för mer information.

## Syfte {#objective}

1. Lär dig hur du använder guiden Skapa plats för att skapa en ny plats.
1. Förstå webbplatsmallarnas roll.
1. Utforska den genererade AEM.

## Logga in på Adobe Experience Manager Author {#author}

Som ett första steg loggar du in i din AEM as a Cloud Service miljö. AEM-miljöer delas mellan **Författartjänst** och **Publiceringstjänst**.

* **Författartjänst** - där webbplatsinnehållet skapas, hanteras och uppdateras. Vanligtvis har bara interna användare åtkomst till **Författartjänst** och ligger bakom en inloggningsskärm.
* **Publiceringstjänst** - är värd för den publicerade webbplatsen. Detta är den tjänst som slutanvändarna kommer att se och vanligtvis är allmänt tillgänglig.

Huvuddelen av självstudiekursen kommer att äga rum med **Författartjänst**.

1. Navigera till Adobe Experience Cloud [https://experience.adobe.com/](https://experience.adobe.com/). Logga in med ditt personliga konto eller ett företags-/skolkonto.
1. Kontrollera att rätt organisation är vald på menyn och klicka på **Experience Manager**.

   ![Experience Cloud - startsida](assets/create-site/experience-cloud-home-screen.png)

1. Under **Cloud Manager** klicka **Starta**.
1. Håll muspekaren över det program du vill använda och klicka på **Cloud Manager-program** -ikon.

   ![Programikon för Cloud Manager](assets/create-site/cloud-manager-program-icon.png)

1. Klicka på den översta menyn **Miljö** för att visa de provisionerade miljöerna.

1. Hitta den miljö du vill använda och klicka på **Författar-URL**.

   ![Anslutningsutvecklare](assets/create-site/access-dev-environment.png)

   >[!NOTE]
   >
   >Det rekommenderas att du använder **Utveckling** miljö för den här självstudiekursen.

1. En ny flik öppnas för AEM **Författartjänst**. Klicka **Logga in med Adobe** och du bör loggas in automatiskt med samma inloggningsuppgifter för Experience Cloud.

1. När du har omdirigerat och autentiserat dig bör du nu se AEM startskärm.

   ![AEM startskärm](assets/create-site/aem-start-screen.png)

>[!NOTE]
>
> Har du svårt att få åtkomst till Experience Manager? Granska [dokumentation om introduktion](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/onboarding/home.html)

## Ladda ned mallen för grundläggande webbplats

En platsmall är en startpunkt för en ny plats. En webbplatsmall innehåller grundläggande teman, sidmallar, konfigurationer och exempelinnehåll. Det är utvecklaren som bestämmer vad som ingår i webbplatsmallen. Adobe tillhandahåller en **Grundläggande webbplatsmall** för att snabba upp nya implementeringar.

1. Öppna en ny flik i webbläsaren och gå till projektet Basic Site Template på GitHub: [https://github.com/adobe/aem-site-template-standard](https://github.com/adobe/aem-site-template-standard). Projektet har öppen källkod och licensierats för att användas av alla.
1. Klicka **Utgåvor** och navigera till [senaste versionen](https://github.com/adobe/aem-site-template-standard/releases/latest).
1. Expandera **Resurser** listruta och ladda ned zip-mallfilen:

   ![Postnummer för grundläggande webbplatsmall](assets/create-site/template-basic-zip-file.png)

   Den här ZIP-filen används i nästa övning.

   >[!NOTE]
   >
   > Den här självstudiekursen är skriven med version **1.1.0** av mallen för grundläggande plats. När du startar ett nytt projekt för produktion bör du alltid använda den senaste versionen.

## Skapa en ny plats

Generera sedan en ny plats med hjälp av platsmallen från föregående övning.

1. Återgå till AEM. Navigera AEM startskärmen till **Webbplatser**.
1. Klicka i det övre högra hörnet **Skapa** > **Plats (mall)**. Det här tar upp **Guiden Skapa plats**.
1. Under **Välj en webbplatsmall** klicka på **Importera** -knappen.

   Ladda upp **.zip** mallfil som hämtats från föregående övning.

1. Välj **AEM webbplatsmall** och klicka **Nästa**.

   ![Välj platsmall](assets/create-site/select-site-template.png)

1. Under **Webbplatsinformation** > **Platsrubrik** enter `WKND Site`.

   I en implementering skulle&quot;WKND Site&quot; ersättas av företagets eller organisationens varumärke. I den här självstudiekursen simulerar vi skapandet av en sajt för ett påhittat livsstilsmärke,&quot;WKND&quot;.

1. Under **Platsnamn** enter `wknd`.

   ![Information om platsmall](assets/create-site/site-template-details.png)

   >[!NOTE]
   >
   > Om du använder en delad AEM-miljö lägger du till en unik identifierare i **Platsnamn**. Till exempel `wknd-site-johndoe`. Detta garanterar att flera användare kan slutföra samma självstudiekurs, utan några kollisioner.

1. Klicka **Skapa** för att skapa platsen. Klicka **Klar** i **Lyckades** när AEM har skapat webbplatsen.

## Utforska den nya webbplatsen

1. Navigera till AEM Sites-konsolen, om den inte redan är där.
1. En ny **WKND-plats** har genererats. Den kommer att innehålla en platsstruktur med en flerspråkig hierarki.
1. Öppna **Engelska** > **Startsida** genom att markera sidan och klicka på **Redigera** på menyraden:

   ![WKND-platshierarki](assets/create-site/wknd-site-starter-hierarchy.png)

1. Startinnehåll har redan skapats och flera komponenter är tillgängliga för att läggas till på en sida. Experimentera med de här komponenterna för att få en uppfattning om funktionerna. Du får lära dig grunderna för en komponent i nästa kapitel.

   ![Startsida](assets/create-site/start-home-page.png)

   *Exempelinnehåll från webbplatsmallen*

## Grattis! {#congratulations}

Grattis, du har just skapat din första AEM webbplats!

### Nästa steg {#next-steps}

Använd sidredigeraren i Adobe Experience Manager, AEM, för att uppdatera webbplatsens innehåll i [Skapa innehåll och publicera](author-content-publish.md) kapitel. Lär dig hur atomiska komponenter kan konfigureras för att uppdatera innehåll. Förstå skillnaden mellan en AEM författare- och publiceringsmiljö och lär dig hur du publicerar uppdateringar till den publicerade webbplatsen.
