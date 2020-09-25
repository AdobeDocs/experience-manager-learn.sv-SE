---
title: Skicka anpassat formulär till AEM arbetsflöde
seo-title: Skicka anpassat formulär till AEM arbetsflöde
description: Dölja och visa anpassade formulärpaneler i AEM arbetsflöde
seo-description: Dölj och visa anpassade formulärpaneler i AEM.
uuid: 28ceb72b-24d9-488e-92af-7e85775dc682
feature: integrations
topics: workflow
audience: developer
doc-type: article
activity: use
version: 6.4,6.5
discoiquuid: 1c4822e6-76ce-446b-98cb-408900d68b24
translation-type: tm+mt
source-git-commit: f07680e73316efb859a675f4b2212d8c3e03f6a0
workflow-type: tm+mt
source-wordcount: '347'
ht-degree: 0%

---


# Skicka anpassat formulär till AEM arbetsflöde

I den här artikeln ska vi titta på ett enkelt arbetsflöde som används för att begära betald tid av. Affärskraven är följande:

* Användare En efterfrågar en viss tid genom att fylla i ett anpassat formulär.
* Formuläret dirigeras till AEM admin-användare (i verkligheten dirigeras det till den som skickar in formuläret)
* Administratören öppnar formuläret. Administratören ska inte kunna redigera någon information som fyllts i av den som skickar in formuläret.
* Godkännaravsnittet ska vara synligt för godkännaren (i det här fallet är det AEM adminanvändaren).

För att uppfylla ovanstående krav använder vi ett dolt fält som kallas **initialsteg** i formuläret och dess standardvärde är inställt på Ja. När formuläret skickas anges värdet för initialsteget med det första steget i arbetsflödet till Nej. Formuläret har affärsregler för att dölja och visa lämpliga avsnitt baserat på det initiala stegvärdet.

**Konfigurera formuläret för att utlösa AEM arbetsflöde**

>[!VIDEO](https://video.tv.adobe.com/v/28406?quality=9&learn=on)

**Genomgång av arbetsflöden**

>[!VIDEO](https://video.tv.adobe.com/v/28407?quality=9&learn=on)

**Avsändarens vy över formuläret Tid för avbeställning**

![initialsteg](assets/initialstep.gif)

**Godkännarvy för formuläret**

![godkännare](assets/approversview.gif)

I godkännarvyn kan godkännaren inte redigera skickade data. Det finns också ett nytt avsnitt som bara är avsett för godkännare.

Följ stegen nedan för att testa det här arbetsflödet i ditt system:
* [Hämta och distribuera DevelopingWitheServiceUserBundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* [Hämta och distribuera det anpassade paketet SetValue OSGI](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)
* [Importera resurser som hör till den här artikeln till AEM](assets/helpxworkflow.zip)
* Öppna formuläret [Time Off Request](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled)
* Fyll i uppgifterna och skicka in
* Öppna [inkorgen](http://localhost:4502/mnt/overlay/cq/inbox/content/inbox.html). Du bör se en ny uppgift tilldelad. Öppna formuläret. Den som skickar uppgifterna ska vara skrivskyddade och ett nytt godkännaravsnitt ska vara synligt.
* Utforska [arbetsflödesmodellen](http://localhost:4502/editor.html/conf/global/settings/workflow/models/helpxworkflow.html)
* Utforska processteget. Detta är steget som ställer in värdet för initialsteget till Nej.
