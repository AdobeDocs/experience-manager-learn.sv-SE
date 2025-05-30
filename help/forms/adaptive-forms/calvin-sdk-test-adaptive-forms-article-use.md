---
title: Använda automatiska tester med AEM Adaptive Forms
description: Automatiserad testning av Adaptive Forms med Calvin SDK
feature: Adaptive Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
exl-id: 5a1364f3-e81c-4c92-8972-4fdc24aecab1
last-substantial-update: 2020-09-10T00:00:00Z
duration: 101
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '436'
ht-degree: 0%

---

# Använda automatiska tester med AEM Adaptive Forms {#using-automated-tests-with-aem-adaptive-forms}

Automatiserad testning av Adaptive Forms med Calvin SDK

Calvin SDK är ett program-API för att testa adaptiva Forms-utvecklare. Calvin SDK är byggt ovanpå testramverket [Hobbes.js](https://experienceleague.adobe.com/docs/experience-manager-release-information/aem-release-updates/previous-updates/aem-previous-versions.html?lang=sv-SE). Calvin SDK finns med AEM Forms 6.3 och senare.

I den här självstudiekursen skapar du följande:

* Test Suite
* Test Suite innehåller en eller flera testfall
* Testärenden innehåller en eller flera åtgärder

## Komma igång {#getting-started}

[Hämta och installera Assets med Package Manager](assets/testingadaptiveformsusingcalvinsdk1.zip)Paketet innehåller exempelskript och flera adaptiva Forms. Dessa adaptiva Forms har skapats med AEM Forms 6.3. Vi rekommenderar att du skapar nya formulär som är specifika för din version av AEM Forms om du testar detta i AEM Forms 6.4 eller senare. Exempelskripten visar olika Calvin SDK-API:er som finns för att testa adaptiv Forms. De allmänna stegen för testning av AEM Adaptive Forms är:

* Navigera till formuläret som behöver testas
* Ange fältets värde
* Skicka det anpassade formuläret
* Sök efter felmeddelanden

Exempelskripten i paketet visar alla ovanstående åtgärder.
Låt oss utforska koden för `mortgageForm.js`

```javascript
var mortgageFormTS = new hobs.TestSuite("Mortgage Form Test", {
        path: '/etc/clientlibs/testingAFUsingCalvinSDK/mortgageForm.js',
        register: true
})
```

Koden ovan skapar en ny testsvit.

* Namnet på TestSuite i det här fallet är `Mortgage Form Test`.
* Anges som den absoluta sökvägen i AEM till js-filen som innehåller testsviten.
* Registerparametern när den anges till `true` gör testsviten tillgänglig i testgränssnittet.

```javascript
.addTestCase(new hobs.TestCase("Calculate amount to borrow")
        // navigate to the mortgage form  which is to be tested
        .navigateTo("/content/forms/af/cal/mortgageform.html?wcmmode=disabled")
  .asserts.isTrue(function () {
            return calvin.isFormLoaded()
        })
```

>[!NOTE]
>
>Om du testar den här funktionen i AEM Forms 6.4 eller senare bör du skapa ett nytt adaptivt formulär och använda det för att göra testningen.Det adaptiva formulär som medföljer paketet rekommenderas inte.

Testfall kan läggas till för testsviten som ska köras mot en adaptiv form.

* Om du vill lägga till ett testfall till testsviten använder du metoden `addTestCase` i TestSuite-objektet.
* Metoden `addTestCase` tar ett TestCase-objekt som parameter.
* Använd metoden `hobs.TestCase(..)` om du vill skapa TestCase.
* Obs! Den första parametern är namnet på det testfall som visas i användargränssnittet.
* När du har skapat ett testfall kan du lägga till åtgärder i testfallet.
* Åtgärder som omfattar `navigateTo`, `asserts.isTrue` kan läggas till som åtgärder i testfallet.

## Köra automatiska tester {#running-the-automated-tests}

[Öppna testsviten](http://localhost:4502/libs/granite/testing/hobbes.html)Utöka testsviten och kör testerna. Om allt fungerar som det ska visas följande utdata.

![calvinsdk](assets/calvinimage.png)

## Testa testsviterna {#try-out-the-sample-test-suites}

Som en del av provpaketet finns det tre ytterligare testsviter. Du kan testa dem genom att inkludera lämpliga filer i filen js.txt i klientbiblioteket enligt nedan:

```javascript
#base=.

scriptingTest.js
validationTest.js
prefillTest.js
mortgageForm.js
```
