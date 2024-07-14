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
duration: 909
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '482'
ht-degree: 0%

---

# Förstå InDesigner och resursmallar i AEM Assets {#understanding-indesign-files-and-asset-templates-in-aem-assets}

I den här videosjälvstudiekursen går du igenom hur du definierar en InDesign och alla tillhörande överväganden som ska användas i AEM Assets funktion Resursmallar.

## Skapa mallfilen för InDesign {#constructing-the-indesign-template-file}

>[!VIDEO](https://video.tv.adobe.com/v/19293?quality=12&learn=on)

1. Hämta och öppna [**InDesignens filmall**](assets/asset-templates-tutorial-video--supporting-files.zip)
2. **Öppna märkordspanelen,** granska märkordsnamnkonventionen och observera att de element som kan redigeras i InDesignen redan är taggade. Kom ihåg att bara taggade element kan redigeras i AEM.

   * **Fönster > Verktyg > Taggar**

3. På sidan lägger du till ett nytt textelement, anger texten&quot;Sidhuvud&quot; och använder styckeformatet **Rubrik**.

   * **Fönster > Format > Styckeformat**

   Skapa och använd sedan en ny tagg med namnet **Page2Heading.**

4. Lägg till FPO-logotypbilden ([som finns i zip](assets/asset-templates-tutorial-video--supporting-files.zip)) i Logo-elementet på mallsidan.

   * **Högerklicka** och välj **Passning > Passningsalternativ för ram.. > Innehållspassning > Fyll ram proportionellt**

   [Läs mer om rampassningsalternativ](https://helpx.adobe.com/indesign/using/frames-objects.html#fitting_objects_to_frames) och vilket som passar dig bäst.

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

1. **Starta InDesign Server** på port 8080.
2. Kontrollera att författarinstansen **AEM har konfigurerats för att interagera med InDesignen Server** (och vice versa).

   * [IDS Worker-Cloud Servicens konfiguration](http://localhost:4502/etc/cloudservices/proxy/ids.html)
   * [Konfiguration av proxyserver i molnet](http://localhost:4502/etc/cloudservices/proxy.html)
   * [AEM OSGi-konfiguration för Externalizer](http://localhost:4502/system/console/configMgr)

3. **InDesignen har överförts till AEM Assets** och AEM arbetsflöde och InDesign Server kan bearbeta resurserna till fullo.
4. **Skapa en ny mall** under **Assets > Mallar** och markera den InDesign som har överförts till AEM i steg 4.
5. **Redigera resursmallen** som skapats i steg 5 och redigera de redigerbara fälten.
6. Klicka på **Klar** för att generera de slutliga återgivningarna med hög återgivning av resursmallen.
7. Klicka på resursmallkortet för att öppna och granska resursåtergivningarna för att hämta återgivningarna med hög återgivning.

## Ytterligare resurser {#additional-resources}

InDesign mallfil och bildstöd

Hämta [InDesignens mallfil och bildstöd](assets/asset-templates-tutorial-video--supporting-files-1.zip)

* [Hämta testversion av InDesign CC](https://creative.adobe.com/products/download/indesign)
* Testversionen av InDesignen Server kan hämtas från [Adobe Prerelease-webbplatsen](https://www.adobeprerelease.com/) eller [CC Enterprise-kunder kan kontakta sin Account Executive för att begära en provlicens av InDesignen Server](https://www.adobe.com/products/indesignserver/faq.html)
