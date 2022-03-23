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
source-git-commit: 012850e3fa80021317f59384c57adf56d67f0280
workflow-type: tm+mt
source-wordcount: '261'
ht-degree: 0%

---

# Steg som krävs för att testa de två metoderna

* Konfigurera [Dagens CQ-posttjänst](https://experienceleague.adobe.com/docs/experience-manager-65/administering/operations/notification.html?lang=en#configuring-the-mail-service) för att skicka e-post från AEM Forms server
* Distribuera [formulärbilagor](assets/formattachments.formattachments.core-1.0-SNAPSHOT.jar) paket med [felix-webbkonsol](http://localhost:4502/system/console/bundles)

## Skicka zip-fil som e-postbilaga



* Distribuera [Arbetsflödet SendFormAttachmentsViaEmail.](assets/zipped-form-attachments-model.zip) Det här arbetsflödet använder skicka-e-postkomponenten för att skicka filen zipped_attachments.zip, som sparas i nyttolastmappen i det anpassade processsteget. Konfigurera avsändarens och mottagarnas e-postadresser efter dina behov.
* Importera [exempelformulär](assets/zip-form-attachments-form.zip) från [Forms och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/zippformattachments/jcr:content?wcmmode=disabled) och lägg till några bilagor och skicka in formuläret.
* Arbetsflödet bör aktiveras och ett e-postmeddelande med zip-filen skickas.

## Skicka bilagor som enskilda filer

* Distribuera [Arbetsflöde för SendForm.](assets/send-form-attachments-model.zip) I det här arbetsflödet används skicka e-postkomponent för att skicka formulärbilagor som enskilda filer. Konfigurera e-postadressen för avsändare och mottagare efter dina behov.
* Importera [exempelformulär](assets/send-list-attachments-form.zip) från [Forms och dokumentgränssnittet](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/sendlistofattachments/jcr:content?wcmmode=disabled) och lägg till några bilagor och skicka in formuläret.
* Arbetsflödet bör utlösas och ett e-postmeddelande med de bifogade formulärfilerna skickas.
