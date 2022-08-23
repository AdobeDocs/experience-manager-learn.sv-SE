---
title: Hämta felmeddelanden i formulärdatamodelltjänsten som ett steg i arbetsflödet
description: Från och med AEM Forms 6.5.1 har vi nu möjlighet att samla in felmeddelanden som genererats när vi använder anropa tjänsten Form Data Model som ett steg i AEM Workflow. Arbetsflöde.
feature: Workflow
version: 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 8cae155c-c393-4ac3-a412-bf14fc411aac
source-git-commit: 307ed6cd25d5be1e54145406b206a78ec878d548
workflow-type: tm+mt
source-wordcount: '246'
ht-degree: 0%

---

# Hämta felmeddelanden i steget Anropa formulärdatamodelltjänst

Från och med AEM Forms 6.5.1 har vi nu möjlighet att samla in felmeddelanden och ange valideringsalternativ. Stegen Anropa Form Data Model Service har förbättrats för att ge följande funktioner.

* Tillhandahåller ett alternativ för 3-nivåvalidering (&quot;AV&quot;,&quot;BASIC&quot; och&quot;FULL&quot;) för att hantera undantag som påträffas vid anrop av Form Data Model Service. De tre alternativen betecknar successivt en striktare version av databaspecifika krav.
   ![valideringsnivåer](assets/validation-level.PNG)

* Ange en kryssruta för att anpassa arbetsflödets körning. Användaren kan alltså nu gå vidare med arbetsflödeskörningen, även om steget Anropa formulärdatamodell genererar undantag.

* Lagra viktig information om fel som uppstått på grund av valideringsundantag. Tre variabelväljare av typen Autocomplete har införlivats för att välja relevanta variabler för lagring av ErrorCode(String), ErrorMessage(String) och ErrorDetails(JSON). ErrorDetails ställs dock in på null om undantaget inte är ett DermisValidationException.
   ![hämta felmeddelanden](assets/fdm-error-details.PNG)

Med de här ändringarna kontrollerar steget Anropa formulärdatamodelltjänst att indatavärdena följer databegränsningarna i swagger-filen. Följande felmeddelande visas till exempel när värdena accountId och balance inte är kompatibla med de databegränsningar som anges i swagger-filen.

```json
{

"errorCode": "AEM-FDM-001-049"

"errorMessage": "Input validations failed during operation execution"

"violations": {

"/accountId": ["numeric instance is greater than the required maximum (maximum: 20, found: 97)"],

"/newAccount/balance": ["instance type (string) does not match any allowed primitive type (allowed: [\"integer\",\"number\"])"]

}

}
```
