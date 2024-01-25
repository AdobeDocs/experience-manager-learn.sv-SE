---
title: Ange värde för Json-dataelement i AEM Forms Workflow
description: Eftersom ett anpassat formulär dirigeras till olika användare i AEM arbetsflöde finns det krav på att dölja eller inaktivera vissa fält eller paneler baserat på den person som granskar formuläret. För att tillgodose dessa användningsområden brukar vi ange ett värde för ett dolt fält. Baserat på det här dolda fältets värdeaffärsregler kan du skapa för att dölja/inaktivera lämpliga paneler eller fält.
feature: Adaptive Forms
version: 6.4
topic: Development
role: Developer
level: Experienced
exl-id: fbe6d341-7941-46f5-bcd8-58b99396d351
last-substantial-update: 2021-06-09T00:00:00Z
duration: 142
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '656'
ht-degree: 0%

---

# Ställa in värdet för JSON-dataelement i AEM Forms Workflow {#setting-value-of-json-data-element-in-aem-forms-workflow}

Eftersom ett anpassat formulär dirigeras till olika användare i AEM arbetsflöde finns det krav på att dölja eller inaktivera vissa fält eller paneler baserat på den person som granskar formuläret. För att tillgodose dessa användningsområden brukar vi ange ett värde för ett dolt fält. Baserat på det här dolda fältets värdeaffärsregler kan du skapa för att dölja/inaktivera lämpliga paneler eller fält.

![Ställa in värdet för ett element i json-data](assets/capture-3.gif)

I AEM Forms OSGi måste vi skapa ett anpassat OSGi-paket för att ställa in JSON-dataelementets värde. Paketet ingår i kursen.

Vi använder Processsteg i AEM arbetsflöde. Vi associerar OSGi-paketet&quot;Set Value of Element in Json&quot; med det här steget.

Vi måste skicka två argument till det angivna värdepaketet. Det första argumentet är sökvägen till elementet vars värde måste anges. Det andra argumentet är värdet som måste anges.

I skärmbilden ovan anger vi till exempel värdet för initialStep-elementet till &quot;N&quot;

afData.afUnboundData.data.initialStep,N

I det här exemplet har vi ett enkelt formulär för att ställa in tid för begäran. Initieraren av det här formuläret fyller i sitt namn och anger datum. När formuläret skickas går det till&quot;manager&quot; för granskning. När hanteraren öppnar formuläret inaktiveras fälten på den första panelen. Detta eftersom vi har angett värdet för det inledande stegelementet i JSON-data till N.

Baserat på fältvärdet för det inledande steget visar vi godkännarpanelen där&quot;hanteraren&quot; kan godkänna eller avvisa begäran.

Ta en titt på reglerna som ställts in mot&quot;Inledande steg&quot;. Baserat på värdet i fältet initialStep hämtar vi användarinformationen med hjälp av formulärdatamodellen, fyller i rätt fält och döljer/inaktiverar lämpliga paneler.

Så här distribuerar du resurser på ditt lokala system:

* [Hämta och distribuera DevelopingWitheServiceUserBundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

* [Hämta och distribuera setvalue-paketet](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar). Detta är det anpassade OSGI-paketet som gör att du kan ange värden för ett element i skickade JSON-data.

* [Hämta och extrahera innehållet i zip-filen](assets/set-value-jsondata.zip)
   * Peka webbläsaren till [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
      * Importera och installera SetValueOfElementInJSONDataWorkflow.zip.Det här paketet har den exempelarbetsflödesmodell och formulärdatamodell som är associerad med formuläret.

* Peka webbläsaren till [Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa | Filöverföring
* Ladda upp filen TimeOffRequestForm.zip
  **Det här formuläret har skapats med AEM Forms 6.4. Kontrollera att du använder AEM Forms 6.4 eller senare**
* Öppna [formulär](http://localhost:4502/content/dam/formsanddocuments/timeoffrequest/jcr:content?wcmmode=disabled)
* Fyll i start- och slutdatum och skicka formuläret.
* Gå till [&quot;Inkorg&quot;](http://localhost:4502/aem/inbox)
* Öppna formuläret som är associerat med uppgiften.
* Observera att fälten på den första panelen är inaktiverade.
* Lägg märke till att panelen för att godkänna eller avvisa begäran nu visas.

>[!NOTE]
>
>Eftersom vi fyller i det adaptiva formuläret i förväg med hjälp av användarprofilen bör du kontrollera att administratören [användarprofilinformation](http://localhost:4502/security/users.html). Kontrollera att du har angett fälten FirstName, LastName och Email som minst.
>Du kan aktivera felsökningsloggning genom att aktivera loggning för com.aemforms.setvalue.core.SetValueInJson [härifrån](http://localhost:4502/system/console/slinglog)

>[!NOTE]
>
>OSGi-paketet för att ställa in värdet för dataelement i JSON-data stöder för närvarande möjligheten att ställa in ett elementvärde åt gången. Om du vill ange flera elementvärden måste du använda processsteg flera gånger.
>
>Kontrollera att sökvägen till datafilen i det adaptiva formulärets överföringsalternativ är inställd på &quot;Data.xml&quot;. Detta beror på att koden i processsteget söker efter filen Data.xml under nyttolastmappen.
