---
title: Skapa MyAccountForm
description: Skapa myaccount-formuläret för att hämta det delvis ifyllda formuläret vid lyckad verifiering av program-ID och telefonnummer.
feature: Adaptiv Forms
type: Tutorial
version: 6.4,6.5
kt: 6599
thumbnail: 6599.jpg
topic: Utveckling
role: User
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '258'
ht-degree: 0%

---



# Skapa MyAccountForm

Formuläret **MyAccountForm** används för att hämta det delvis ifyllda adaptiva formuläret efter att användaren har verifierat program-ID:t och det mobilnummer som är associerat med program-ID:t.

![mitt kontoformulär](assets/6599.JPG)

När användaren anger program-ID:t och klickar på knappen **Hämta program** hämtas det mobilnummer som är associerat med program-ID:t från databasen med åtgärden Hämta i formulärdatamodellen.

I det här formuläret används POSTENS anrop av formulärdatamodellen för att verifiera mobilnumret med hjälp av engångslösenord. Formulärets sändningsåtgärd aktiveras när mobilnumret har verifierats med följande kod. Vi utlöser klickhändelsen för skicka-knappen **submitForm**.

>[!NOTE]
> Du måste ange API-nyckeln och API-hemlighetsvärdena som är specifika för ditt [Nexmo](https://dashboard.nexmo.com/)-konto i fälten i MyAccountForm

![trigger-submit](assets/trigger-submit.JPG)



Det här formuläret är kopplat till en anpassad skickaåtgärd som vidarebefordrar formuläröverföringen till serverleten som är monterad på **/bin/renderaf**

```java
com.adobe.aemds.guide.utils.GuideSubmitUtils.setForwardPath(slingRequest,"/bin/renderaf",null,null);
```

Koden i serverutrymmet som är monterad på **/bin/renderaf** vidarebefordrar begäran om att återge butiken med bilagor i adaptiv form ifyllda med sparade data.


* MyAccountForm kan [laddas ned här](assets/my-account-form.zip)

* Exempelformulär baseras på [en anpassad adaptiv formulärmall](assets/custom-template-with-page-component.zip) som måste importeras till AEM för att exempelformulären ska återges korrekt.

* [En anpassad ](assets/custom-submit-my-account-form.zip) hanterare som är associerad med MyAccountForm-överföringen måste importeras till AEM.
