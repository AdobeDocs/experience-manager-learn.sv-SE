---
title: Testa lösningen - Steg som krävs för att testa de två inriktningarna
description: Testa lösningen genom att lägga till bilagor i formuläret och utlösa arbetsflödet för att skicka e-postmeddelandet.
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-8049
exl-id: ce9b9203-b44c-4a52-821c-ae76e93312d2
duration: 41
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '216'
ht-degree: 0%

---

# Steg som krävs för att testa de två metoderna

* Konfigurera [Day CQ Mail Service](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/notification.html?lang=en#configuring-the-mail-service) för att skicka e-post från AEM Forms-servern
* Distribuera paketet [formulärbilagor](assets/formattachments.formattachments.core-1.0-SNAPSHOT.jar) med webbkonsolen [felix](http://localhost:4502/system/console/bundles)

## Skicka zip-fil som e-postbilaga



* Distribuera arbetsflödet [SendFormAttachmentsViaEmail.](assets/zipped-form-attachments-model.zip) Det här arbetsflödet använder skicka-e-postkomponenten för att skicka filen zipped_attachments.zip som sparas under nyttolastmappen i det anpassade processsteget. Konfigurera avsändarens och mottagarnas e-postadresser efter dina behov.
* Importera [exempelformuläret](assets/zip-form-attachments-form.zip) från [Forms och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/zippformattachments/jcr:content?wcmmode=disabled) och lägg till några bilagor och skicka formuläret.
* Arbetsflödet bör aktiveras och ett e-postmeddelande med zip-filen skickas.

## Skicka bilagor som enskilda filer

* Distribuera arbetsflödet [SendForm.](assets/send-form-attachments-model.zip) Det här arbetsflödet använder skicka e-postkomponent för att skicka formulärbilagor som enskilda filer. Konfigurera e-postadressen för avsändare och mottagare efter dina behov.
* Importera [exempelformuläret](assets/send-list-attachments-form.zip) från [Forms och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/sendlistofattachments/jcr:content?wcmmode=disabled) och lägg till några bilagor och skicka formuläret.
* Arbetsflödet bör utlösas och ett e-postmeddelande med de bifogade formulärfilerna skickas.
