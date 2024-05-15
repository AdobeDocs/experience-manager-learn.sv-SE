---
title: Distribuera exempelresurserna
description: Distribuera exempelresurserna på ditt lokala molnklara system.
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Cloud Service
topic: Integrations
jira: KT-13717
exl-id: ae8104fa-7af2-49c2-9e6b-704152d49149
duration: 38
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '188'
ht-degree: 0%

---

# Distribuera exempelresurserna

Distribuera följande resurser på ditt lokala molnförberedda system för att få det här användningsfallet att fungera på ditt system.

* Se till att du har skapat alla konfigurationer/konton som krävs enligt[introduktionsdokument](./introduction.md)

* [Installera den anpassade formulärmallen och den tillhörande sidkomponenten](./assets/azure-portal-template-page-component.zip)

* [Installera formulärdatamodellen SendGrid](./assets/send-grid-form-data-model.zip). Du måste ange API-nyckeln och SendGrid verifieras från adressen för att den här formulärdatamodellen ska fungera. Testa formulärdatamodellen i formulärdatamodellens redigerare

* [Installera den Azure-baserade formulärdatamodellen](./assets/azure-storage-fdm.zip). Du måste ange autentiseringsuppgifter för ditt Azure Storage-konto för att formulärdatamodellen ska fungera. Testa formulärdatamodellen i formulärdatamodellens redigerare.

* [Importera det adaptiva exempelformuläret](./assets/credit-applications-af.zip)
* [Importera klientbiblioteket](./assets/client-lib.zip)
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/azureportalstorage/creditapplications/jcr:content?wcmmode=disabled). Ange ett giltigt e-postmeddelande och klicka på knappen Spara. Formulärdata bör lagras i Azure Storage och ett e-postmeddelande med en länk till det sparade formuläret skickas till den angivna e-postadressen.
