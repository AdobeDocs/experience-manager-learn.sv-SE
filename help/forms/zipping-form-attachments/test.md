---
title: Testa lösningen
description: Testa lösningen genom att lägga till bilagor i formuläret och utlösa arbetsflödet för att skicka e-postmeddelandet.
sub-product: formulär
feature: Arbetsflöde
topics: adaptive forms
audience: developer
doc-type: article
activity: develop
version: 6.5
topic: Utveckling
role: Developer
level: Beginner
kt: kt-8049
source-git-commit: 540e11c0861eacc795122328b2359c7db6378aec
workflow-type: tm+mt
source-wordcount: '257'
ht-degree: 0%

---


# Steg som krävs för att testa de två metoderna

* Konfigurera [Day CQ Mail Service](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/notification.html?lang=en#configuring-the-mail-service) för att skicka e-post från AEM Forms-servern
* Distribuera [formulärbilagor](assets/formattachments.formattachments.core-1.0-SNAPSHOT.jar)-paketet med [felix-webbkonsolen](http://localhost:4502/system/console/bundles)

## Skicka zip-fil som e-postbilaga



* Distribuera arbetsflödet [SendFormAttachmentsViaEmail.](assets/zipped-form-attachments-model.zip) Det här arbetsflödet använder skicka-e-postkomponenten för att skicka filen zipped_attachments.zip, som sparas i nyttolastmappen i det anpassade processsteget. Konfigurera avsändarens och mottagarnas e-postadresser efter dina behov.
* Importera [exempelformuläret](assets/zip-form-attachments-form.zip) från [Forms- och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska ](http://localhost:4502/content/dam/formsanddocuments/zippformattachments/jcr:content?wcmmode=disabled) formuläret, lägg till några bilagor och skicka formuläret.
* Arbetsflödet bör aktiveras och ett e-postmeddelande med zip-filen skickas.

## Skicka bilagor som enskilda filer

* Distribuera arbetsflödet [SendForm.](assets/send-form-attachments-model.zip) I det här arbetsflödet används skicka e-postkomponent för att skicka formulärbilagor som enskilda filer. Konfigurera e-postadressen för avsändare och mottagare efter dina behov.
* Importera [exempelformuläret](assets/send-list-attachments-form.zip) från [Forms- och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska ](http://localhost:4502/content/dam/formsanddocuments/sendlistofattachments/jcr:content?wcmmode=disabled) formuläret, lägg till några bilagor och skicka formuläret.
* Arbetsflödet bör utlösas och ett e-postmeddelande med de bifogade formulärfilerna skickas.
