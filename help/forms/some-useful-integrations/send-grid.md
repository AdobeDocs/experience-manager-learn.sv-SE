---
title: Integrera AEM Forms med SendGrid
description: Utnyttja den molnbaserade e-postleveransplattformen SengGrid med AEM Forms.
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-13605
topic: Development
role: Developer
level: Intermediate
last-substantial-update: 2023-07-14T00:00:00Z
exl-id: 62b73f4b-69d8-4ede-9d57-3d6472d25d5a
duration: 118
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '534'
ht-degree: 0%

---

# Integrera AEM Forms med SendGrid

Välkommen till den här tekniska guiden, där vi kommer att undersöka processen för att skicka e-postmeddelanden med dynamiska mallar för SendGrid från AEM Forms. Den här guiden ger dig en tydlig förståelse för hur du använder dynamiska mallar för att personalisera ditt e-postinnehåll effektivt.

Med dynamiska mallar kan du skapa e-postmallar som kan visa olika innehåll för mottagare baserat på de data som hämtas i det anpassade formuläret. Genom att använda personaliseringsvariabler kan ni leverera målinriktade och anpassade e-postupplevelser som får genklang hos er målgrupp.

Dessutom kommer vi att dra nytta av användningen av Swagger-filen, som gör att du kan anpassa dina e-postmeddelanden ytterligare genom att inkludera kundens namn och e-postadress samt välja lämplig dynamisk e-postmall.

Följ de stegvisa instruktionerna i det här dokumentet för att utnyttja de kraftfulla dynamiska SkickaGrid-mallarna och AEM Forms och lyft din e-postkommunikation till nya nivåer av engagemang och relevans. Låt oss börja!

## Förutsättningar

Innan du fortsätter med att skicka e-postmeddelanden med dynamiska mallar för SendGrid från AEM Forms måste du kontrollera att du har uppfyllt följande krav:

1. **SendGrid-konto**: Registrera ett SendGrid-konto på [https://sendgrid.com](https://sendgrid.com) för att få tillgång till deras e-postleveranstjänster. Du behöver kontoinloggningsuppgifterna för att kunna integrera SendGrid med AEM Forms.
1. **Bekanta dig med att skapa datakällor**: Lär dig att skapa datakällor i AEM Forms. Om det behövs finns detaljerade anvisningar i dokumentationen om [att skapa datakällor](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-web-channel-tutorial/parttwo.html?lang=sv-SE).
1. **Bekanta dig med formulärdatamodellen**: Förstå begreppet formulärdatamodell i AEM Forms. Om det behövs kan du läsa dokumentationen om [att skapa formulärdatamodeller](https://experienceleague.adobe.com/docs/experience-manager-65/forms/form-data-model/create-form-data-models.html?lang=sv-SE) för att kontrollera att du har den förståelse som krävs.

Genom att uppfylla dessa krav får du de kunskaper och resurser du behöver för att effektivt skicka e-postmeddelanden med dynamiska mallar för SendGrid från AEM Forms.

## Exempelresurser

Exemplen på resurser i den här artikeln är bland annat:

* **[Swagger-fil](assets/SendGridWithDynamicTemplate.yaml)**: Med den här filen kan du skicka e-postmeddelanden med en dynamisk e-postmall. Den innehåller de specifikationer och konfigurationer som krävs för att integreras med SendGrid och AEM Forms för smidig e-postleverans.

Du kan använda den medföljande Swagger-filen som referens eller utgångspunkt för att implementera e-postfunktioner med dynamiska mallar.

## Testinstruktioner

Följ de här stegen för att testa funktionen som beskrivs i den här handboken:

1. Hämta [swagger-filen](assets/SendGridWithDynamicTemplate.yaml) som finns i resursmappen.
2. Skapa en återställd datakälla med den hämtade swagger-filen och inloggningsuppgifterna för SendGrid.
3. Skapa en formulärdatamodell baserad på datakällan Restful.
4. Anropa POST-åtgärden `mail/send` för formulärdatamodellen enligt dina krav. Du kan till exempel utlösa e-postmeddelandet med en knapp genom att klicka eller ta med det i ditt AEM Forms-arbetsflöde.

Nyttolastexemplet för tjänsten är följande. Ersätt platshållarvärdena med dina egna data:

```json
{
    "sendgridpayload": {
        "from": {
            "email": "gs@xyz.com"
        },
        "personalizations": [{
            "to": [{
                "email": "johndoe@xyz.com"
            }],
            "dynamic_template_data": {
                "customerName": "John Doe"
            }
        }],
        "template_id": "d-72aau292a3bd60b5300c"
    }
}
```

Kontrollera att `template_id` motsvarar ID:t för den dynamiska e-postmallen för SendGrid, och att e-postadresserna är giltiga och verifierade av SendGrid. Med värdena i avsnittet `personalizations` kan du anpassa e-postmeddelandet med användarangivna data från det anpassade formuläret.

Genom att följa de här stegen och anpassa den tillhandahållna nyttolasten kan du effektivt testa integrationen av dynamiska mallar i SendGrid med AEM Forms.
