---
title: Arbetsflöde för enkel betald tid på begäran
description: Dölja och visa anpassade formulärpaneler i AEM Workflow
feature: Adaptive Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
discoiquuid: 1c4822e6-76ce-446b-98cb-408900d68b24
topic: Development
role: Developer
level: Experienced
exl-id: 9342bd2f-2ba9-42ee-9224-055649ac3c90
last-substantial-update: 2020-07-07T00:00:00Z
duration: 592
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '305'
ht-degree: 0%

---

# Arbetsflöde för enkel betald tid på begäran

I den här artikeln tittar vi på ett enkelt arbetsflöde som används för att begära betald tid av. Affärskraven är följande:

* Användare En efterfrågar en viss tid genom att fylla i ett anpassat formulär.
* Formuläret dirigeras till AEM admin-användare (i verkligheten dirigeras det till den som skickar in formuläret)
* Administratören öppnar formuläret. Administratören ska inte kunna redigera någon information som fyllts i av den som skickar in formuläret.
* Godkännaravsnittet ska vara synligt för godkännaren (i det här fallet är det AEM-administratörsanvändaren).

För att uppfylla ovanstående krav använder vi ett dolt fält med namnet **initialstep** i formuläret och dess standardvärde är inställt på Ja. När formuläret skickas anges värdet för initialsteget med det första steget i arbetsflödet till Nej. Formuläret har affärsregler för att dölja och visa lämpliga avsnitt baserat på det initiala stegvärdet.

**Konfigurera formuläret för att utlösa AEM Workflow**

>[!VIDEO](https://video.tv.adobe.com/v/28406?quality=12&learn=on)

**Genomgång av arbetsflöde**

>[!VIDEO](https://video.tv.adobe.com/v/28407?quality=12&learn=on)

**Avsändarens vy över formuläret Tid för avbegäran**

![initialstep](assets/initialstep.gif)

**Godkännarvy för formuläret**

![godkännare](assets/approversview.gif)

I godkännarvyn kan godkännaren inte redigera skickade data. Det finns också ett nytt avsnitt som bara är avsett för godkännare.

Följ stegen nedan för att testa det här arbetsflödet i ditt system:
* [Hämta och distribuera DevelopingWitheServiceUserBundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)
* [Hämta och distribuera det anpassade paketet SetValue OSGI](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar)
* [Importera resurser som hör till den här artikeln till AEM](assets/helpxworkflow.zip)
* Öppna formuläret [Tid kvar på begäran](http://localhost:4502/content/dam/formsanddocuments/helpx/timeoffrequestform/jcr:content?wcmmode=disabled)
* Fyll i uppgifterna och skicka in
* Öppna [inkorgen](http://localhost:4502/mnt/overlay/cq/inbox/content/inbox.html). Du bör se en ny uppgift som har tilldelats. Öppna formuläret. Den som skickar uppgifterna ska vara skrivskyddade och ett nytt godkännaravsnitt ska vara synligt.
* Utforska [arbetsflödesmodellen](http://localhost:4502/editor.html/conf/global/settings/workflow/models/helpxworkflow.html)
* Utforska processteget. Detta är steget som ställer in värdet för initialsteget till Nej.
