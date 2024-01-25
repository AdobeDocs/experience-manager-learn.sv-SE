---
title: Förstå InDesigner och resursmallar i AEM Assets
description: I den här videosjälvstudiekursen går du igenom hur du definierar en InDesign och alla tillhörande överväganden som ska användas i AEM Assets funktion Resursmallar.
version: 6.4, 6.5
topic: Content Management
feature: Templates
role: User
level: Intermediate
doc-type: Tutorial
exl-id: c418e94a-b18e-429a-b41c-2bf32e158598
duration: 925
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '482'
ht-degree: 0%

---

# Förstå InDesigner och resursmallar i AEM Assets {#understanding-indesign-files-and-asset-templates-in-aem-assets}

I den här videosjälvstudiekursen går du igenom hur du definierar en InDesign och alla tillhörande överväganden som ska användas i AEM Assets funktion Resursmallar.

## Skapa mallfilen för InDesign {#constructing-the-indesign-template-file}

>[!VIDEO](https://video.tv.adobe.com/v/19293?quality=12&learn=on)

1. Hämta och öppna [**InDesignens filmall**](assets/asset-templates-tutorial-video--supporting-files.zip)
2. **Öppna märkordspanelen** Granska namnkonventionen och notera att elementen som kan redigeras i InDesignen redan är taggade. Kom ihåg att bara taggade element kan redigeras i AEM.

   * **Fönster > Verktyg > Taggar**

3. På sidan lägger du till ett nytt textelement, anger texten&quot;Sidhuvud&quot; och använder kommandot **Rubrik** Styckeformat.

   * **Fönster > Format > Styckeformat**

   Skapa och använd sedan en ny tagg med namnet **Page2Heading.**

4. Lägg till FPO-logotypbilden ([anges i zip-filen](assets/asset-templates-tutorial-video--supporting-files.zip)) till Logo-elementet på mallsidan.

   * **Högerklicka** och markera **Passning > Passningsalternativ för ram.. > Innehållspassning > Fyll ram proportionellt**

   [Läs mer om rampassningsalternativ](https://helpx.adobe.com/indesign/using/frames-objects.html#fitting_objects_to_frames)och som passar ditt sätt att arbeta.

5. Kopiera rubriken (logotyp och företagsnamn) från mallmallen på sidan och sidan via Klistra in på plats.

   * På sidan 1 Skift-Cmd-klickar du på macOS eller Skift-Alt-klickar på Windows för att markera rubriken som visas på mallsidan och ta bort den.
   * Kopiera sidhuvudet från mallsidan till sidan 1 via Klistra in på plats
   * Upprepa stegen för sida 2

6. Öppna strukturpanelen genom att dubbelklicka på varje element. Kontrollera att alla strukturella element motsvarar verkliga element i InDesignen. Ta bort oanvända eller obehövliga element. Kontrollera att all taggning är semantisk och att elementen är taggade på rätt sätt.

   >[!NOTE]
   >
   >Kom ihåg att en dåligt konstruerad InDesign är den vanligaste orsaken till problem med AEM resursmallar, så att taggningen och strukturen är ren och korrekt.

## Skapa och redigera en resursmall i AEM Assets {#creating-and-authoring-an-asset-template-in-aem-assets}

>[!VIDEO](https://video.tv.adobe.com/v/19294?quality=12&learn=on)

1. **Starta InDesign Server** på hamn 8080.
2. Kontrollera **AEM Author-instansen är konfigurerad att interagera med InDesignen Server**(och vice versa).

   * [Konfiguration av IDS Worker-Cloud Service](http://localhost:4502/etc/cloudservices/proxy/ids.html)
   * [Konfiguration av proxyserver för molnet](http://localhost:4502/etc/cloudservices/proxy.html)
   * [AEM Externalizer OSGi-konfiguration](http://localhost:4502/system/console/configMgr)

3. **InDesignen har överförts till AEM Assets** så att AEM arbetsflöde och InDesign Server kan bearbeta materialet fullt ut.
4. **Skapa en ny mall** under **Resurser > Mallar** och markera den överförda InDesignen till AEM i steg 4.
5. **Redigera resursmallen** som skapats i steg 5 och författare till redigerbara fält.
6. Klicka **Klar** för att generera de slutliga återgivningarna av resursmallen med hög återgivning.
7. Klicka på resursmallkortet för att öppna och granska resursåtergivningarna för att hämta återgivningarna med hög återgivning.

## Ytterligare resurser {#additional-resources}

InDesign mallfil och bildstöd

Ladda ned [InDesign mallfil och bildstöd](assets/asset-templates-tutorial-video--supporting-files-1.zip)

* [Ladda ned testversion av InDesign CC](https://creative.adobe.com/products/download/indesign)
* Testversionen av InDesignen Server kan hämtas från [Adobe Prerelease site](https://www.adobeprerelease.com/) eller [CC Enterprise-kunder kan kontakta sin Account Executive för att begära en testlicens för InDesign Server](https://www.adobe.com/products/indesignserver/faq.html)
