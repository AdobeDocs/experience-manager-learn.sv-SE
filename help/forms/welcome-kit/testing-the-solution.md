---
title: Testa välkomstpaketlösningen
description: Distribuera lösningsresurserna för att testa lösningen
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
last-substantial-update: 2022-12-14T00:00:00Z
exl-id: 07a1a9fc-7224-4e2d-8b6d-d935b1125653
duration: 29
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '144'
ht-degree: 0%

---

# Distribuera och testa exempelresurserna

[Installera välkomstpaketet](assets/welcomekit.zip). Det här paketet innehåller sidmallen, en anpassad komponent som listar resurserna, exempelarbetsflödet, e-postmallen och exempeldokument som ska inkluderas i välkomstpaketet.
[Installera välkomstpaketet](assets/welcomekit.core-1.0.0-SNAPSHOT.jar). Paketet innehåller koden som skapar sidan och klassen java som returnerar resurserna som ska visas på webbsidan.
[Installera exempelformuläret för adaptiv installation](assets/account-openeing-form.zip)
Konfigurera Day CQ Mail Service. Arbetsflödet skickar välkomstpaketlänken till den formuläravsändare som behöver SMTP konfigurerat korrekt.
Konfigurera Skicka e-post-komponenten för arbetsflödet enligt dina krav
[Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/co-operators/accountopeningform/jcr:content?wcmmode=disabled)
Ange dina uppgifter och välj en eller flera gemensamma fonder och skicka in formuläret Du bör få ett e-postmeddelande med en länk till välkomstpaketet
