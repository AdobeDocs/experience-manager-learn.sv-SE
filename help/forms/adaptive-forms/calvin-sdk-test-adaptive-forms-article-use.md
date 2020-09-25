---
title: 'Använda automatiska tester med AEM Adaptive Forms '
seo-title: 'Använda automatiska tester med AEM Adaptive Forms '
description: Automatiserad testning av Adaptive Forms med Calvin SDK
seo-description: Automatiserad testning av Adaptive Forms med Calvin SDK
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: develop
version: 6.3,6.4,6.5
uuid: 3ad4e6d6-d3b1-4e4d-9169-847f74ba06be
translation-type: tm+mt
source-git-commit: a0e5a99408237c367ea075762ffeb3b9e9a5d8eb
workflow-type: tm+mt
source-wordcount: '460'
ht-degree: 0%

---


# Använda automatiska tester med AEM Adaptive Forms {#using-automated-tests-with-aem-adaptive-forms}

Automatiserad testning av Adaptive Forms med Calvin SDK

Calvin SDK är ett program-API för Adaptiva Forms-utvecklare som testar Adaptiv Forms. Calvin SDK är byggt ovanpå testmiljön [för](https://docs.adobe.com/docs/en/aem/6-3/develop/ref/test-api/index.html)Hobbes.js. Calvin SDK finns med AEM Forms 6.3 och senare.

I den här självstudiekursen skapar du följande:

* Test Suite
* Test Suite innehåller en eller flera testfall
* Testärenden innehåller en eller flera åtgärder

## Getting started {#getting-started}

[Hämta och installera resurserna med Package](assets/testingadaptiveformsusingcalvinsdk1.zip)ManagerPaketet innehåller exempelskript och flera adaptiva Forms.Dessa adaptiva Forms har byggts med AEM Forms 6.3. Vi rekommenderar att du skapar nya formulär som är specifika för din version av AEM Forms om du testar detta i AEM Forms 6.4 eller senare. Exempelskripten visar olika Calvin SDK API:er som finns för att testa Adaptive Forms. De allmänna stegen för testning AEM Adaptive Forms är:

* Navigera till formuläret som behöver testas
* Ange fältets värde
* Skicka det anpassade formuläret
* Sök efter felmeddelanden

Exempelskripten i paketet visar alla ovanstående åtgärder.
Låt oss utforska koden i `mortgageForm.js`

```javascript
var mortgageFormTS = new hobs.TestSuite("Mortgage Form Test", {
        path: '/etc/clientlibs/testingAFUsingCalvinSDK/mortgageForm.js',
        register: true
})
```

Koden ovan skapar en ny testsvit.

* Namnet på TestSuite är i det här fallet &#39; `Mortgage Form Test` &#39;.
* Anges som absolut sökväg i AEM till JS-filen som innehåller testsviten.
* Registerparametern när den är inställd på &#39; `true` &#39;, gör testsviten tillgänglig i testgränssnittet.

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

* Om du vill lägga till ett testfall för att testa en programsvit använder du metoden `addTestCase` i objektet TestSuite.
* Metoden tar ett TestCase-objekt som `addTestCase` parameter.
* Använd `hobs.TestCase(..)` metoden för att skapa TestCase.
* Obs! Den första parametern är namnet på det testfall som ska visas i användargränssnittet.
* När du har skapat ett testfall kan du lägga till åtgärder i testfallet.
* Åtgärder inklusive `navigateTo`, `asserts.isTrue` kan läggas till som åtgärder i testfallet.

## Köra automatiska tester {#running-the-automated-tests}

[Öppna](http://localhost:4502/libs/granite/testing/hobbes.html)testsvitenUtöka testsviten och kör testerna. Om allt fungerar som det ska visas följande utdata.

![kalvinsdk](assets/calvinimage.png)

## Testa testsviterna {#try-out-the-sample-test-suites}

Som en del av provpaketet finns det tre ytterligare testsviter. Du kan testa dem genom att inkludera lämpliga filer i filen js.txt i klientbiblioteket enligt nedan:

```javascript
#base=.

scriptingTest.js
validationTest.js
prefillTest.js
mortgageForm.js
```
