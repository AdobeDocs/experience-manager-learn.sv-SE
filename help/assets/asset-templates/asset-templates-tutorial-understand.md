---
title: 'Om InDesign-filer och resursmallar i AEM Assets '
description: I den här videosjälvstudiekursen går du igenom hur du definierar en InDesign-fil och alla tillhörande överväganden som du kan använda i funktionen Resursmallar för AEM Resurser.
version: 6.3, 6.4, 6.5
topic: Innehållshantering
role: Business Practitioner
level: Intermediate
source-git-commit: b4fa992abe22e3a546d651e465d6ffc9e415aee2
workflow-type: tm+mt
source-wordcount: '496'
ht-degree: 0%

---


# Om InDesign-filer och resursmallar i AEM Assets {#understanding-indesign-files-and-asset-templates-in-aem-assets}

I den här videosjälvstudiekursen går du igenom hur du definierar en InDesign-fil och alla tillhörande överväganden som du kan använda i funktionen Resursmallar för AEM Resurser.

## Skapar InDesign-mallfilen {#constructing-the-indesign-template-file}

>[!VIDEO](https://video.tv.adobe.com/v/19293/?quality=9&learn=on)

1. Hämta och öppna filmallen [**InDesign**](assets/asset-templates-tutorial-video--supporting-files.zip)
2. **Öppna märkordspanelen,** granska märkordsnamnkonventionen och observera att de element som kan redigeras i filen InDesign redan är formaterade. Kom ihåg att bara taggade element kan redigeras i AEM.

   * **Fönster > Verktyg > Taggar**

3. På sidan lägger du till ett nytt textelement, anger texten&quot;Sidhuvud&quot; och använder styckeformatet **Rubrik**.

   * **Fönster > Format > Styckeformat**

   Skapa och använd sedan en ny tagg med namnet **Page2Heading.**

4. Lägg till FPO-logotypbilden ([som finns i zip](assets/asset-templates-tutorial-video--supporting-files.zip)) i Logo-elementet på den Överordnad sidan.

   * **Högerklicka** och **välj Passning > Passningsalternativ för ram... > Innehållspassning > Fyll ram proportionellt**
   [Läs mer om rampassningsalternativ](https://helpx.adobe.com/indesign/using/frames-objects.html#fitting_objects_to_frames) och vilket som passar dig bäst.

5. Kopiera rubriken (logotyp och företagsnamn) från den Överordnad mallen på sidan och sidan via Klistra in på plats.

   * På sidan 1 håller du ned Skift-Cmd och klickar på macOS eller Skift-Alt och klickar i Windows för att markera rubriken som visas på den Överordnad sidan och ta bort den.
   * Kopiera sidhuvudet från den Överordnad sidan till sidan 1 via Klistra in på plats
   * Upprepa stegen för sida 2

6. Öppna strukturpanelen genom att dubbelklicka på varje element. Kontrollera att alla strukturella element motsvarar verkliga element i filen InDesign. Ta bort oanvända eller obehövliga element. Kontrollera att all taggning är semantisk och att elementen är taggade på rätt sätt.

   >[!NOTE]
   >
   >Kom ihåg att en dåligt konstruerad InDesign-fil är den vanligaste orsaken till problem med AEM resursmallar, så att taggningen och strukturen är ren och korrekt.

## Skapa och redigera en resursmall i AEM Assets {#creating-and-authoring-an-asset-template-in-aem-assets}

>[!VIDEO](https://video.tv.adobe.com/v/19294/?quality=9&learn=on)

1. **Starta InDesign** Serveron-port 8080.
2. Kontrollera att instansen **AEM Author är konfigurerad att interagera med InDesign Server**(och vice versa).

   * [Konfiguration av IDS Worker-Cloud Service](http://localhost:4502/etc/cloudservices/proxy/ids.html)
   * [Konfiguration av proxyserver för molnet](http://localhost:4502/etc/cloudservices/proxy.html)
   * [AEM Externalizer OSGi-konfiguration](http://localhost:4502/system/console/configMgr)

3. **InDesign-filen överfördes till AEM** resurser och AEM arbetsflöde och InDesign Server kan bearbeta materialet fullt ut.
4. **Skapa en ny** mall under  **Resurser >** Mallar och välj den InDesign-fil som ska överföras till AEM i steg 4.
5. **Redigera den** resursmall som skapades i steg 5 och redigera de redigerbara fälten.
6. Klicka på **Klar** för att generera de sista återgivningarna med hög återgivning av resursmallen.
7. Klicka på resursmallkortet för att öppna och granska resursåtergivningarna för att hämta återgivningarna med hög återgivning.

## Ytterligare resurser {#additional-resources}

InDesign-mallfil och bildstöd

Hämta [InDesign-mallfilen och bildstöd](assets/asset-templates-tutorial-video--supporting-files-1.zip)

* [Ladda ned testversion av InDesign CC](https://creative.adobe.com/products/download/indesign)
* [CC Enterprise-kunder kan kontakta sin Account Executive för att begära en provlicens för InDesign Server](https://www.adobe.com/products/indesignserver/faq.html)
