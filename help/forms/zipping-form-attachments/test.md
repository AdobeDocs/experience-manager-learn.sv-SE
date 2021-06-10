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
source-git-commit: e82cc5e5de6db33e82b7c71c73bb606f16b98ea6
workflow-type: tm+mt
source-wordcount: '155'
ht-degree: 1%

---


# Testa lösningen


* Konfigurera [Day CQ Mail Service](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/notification.html?lang=en#configuring-the-mail-service) för att skicka e-post från AEM Forms-servern
* Distribuera [formulärbilagor](assets/formattachments.formattachments.core-1.0-SNAPSHOT.jar)-paketet med [felix-webbkonsolen](http://localhost:4502/system/console/bundles)
* Distribuera arbetsflödet [SendFormAttachmentsViaEmail.](assets/zipped-form-attachments-model.zip) I det här arbetsflödet används skicka e-postkomponent för att skicka filen zipped_attachments.zip, som sparas under nyttolastmappen i det anpassade processsteget. Konfigurera e-postadressen för avsändare och mottagare efter dina behov.
* Importera [exempelformuläret](assets/zip-form-attachments-form.zip) från [Forms- och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska ](http://localhost:4502/content/dam/formsanddocuments/zippformattachments/jcr:content?wcmmode=disabled) formuläret, lägg till några bilagor och skicka formuläret.
* Arbetsflödet bör aktiveras och ett e-postmeddelande med zip-filen skickas.

