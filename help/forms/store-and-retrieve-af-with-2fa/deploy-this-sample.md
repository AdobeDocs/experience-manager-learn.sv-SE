---
title: Distribuera exemplet
description: Hämta användningsfall som körs på din lokala AEM Forms-instans
feature: Adaptiv Forms
type: Tutorial
version: 6.4,6.5
kt: 6602
thumbnail: 6602.jpg
topic: Utveckling
role: Developer
level: Intermediate
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '371'
ht-degree: 0%

---



# Distribuera exemplet

Följ följande anvisningar för att få det här användningsfallet att fungera i ditt system:

>[!NOTE]
>Du måste köra AEM Forms på port 4502.


## Skapa databas

I det här exemplet används MySQL-databasen för att lagra data för anpassade formulär. Du måste skapa databasschemat [genom att importera schemafilen](assets/data-base-schema.sql) till MySQL workbench.

## Skapa datakälla

Du måste skapa en datakälla med namnet **StoreAndRetrieveAfData**. Koden i OSGi-paketet använder det här datakällans namn

## Skapa formulärdatamodell

Formulärdatamodell måste skapas baserat på den här datakällan med namnet **StoreAndRetrieveAfData**. Den här formulärdatamodellen används för att hämta det mobiltelefonnummer som är kopplat till program-ID:t. Formulärdatamodellen kan hämtas [härifrån.](assets/2-Factor-Authentication-DataSource-and-FDM.zip)

## Skapa utvecklarkonto med nexmo

Skapa ett utvecklarkonto med [Nexmo](https://dashboard.nexmo.com/) för att skicka och verifiera OTP-koder. Anteckna API-nyckeln och API-hemlig nyckel. Datakällan och formulärdatamodellen har redan skapats för dig mot den här tjänsten och ingår i de tillgångar som nämns i föregående steg.

## Distribuera följande OSGi-paket

Distribuera paketet som har [koden för att lagra och hämta data från databasen](assets/FetchPartiallyCompletedForm.PartiallyCompletedForm.core-1.0-SNAPSHOT.jar)
Distribuera [DevelopingWithServiceUser Bundle](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar).

## Distribuera klientbiblioteket

Exemplet använder två klientbibliotek. Importera dessa [klientbibliotek](assets/client-libraries.zip) till AEM.

## Importera en anpassad formulärmall

Exempelformulären som används i den här demon är baserade på en anpassad mall. Importera den anpassade [mallen till AEM](assets/custom-template-with-page-component.zip)

## Importera exempeladaptiva formulär

De två formulär som utgör det här exemplet måste importeras till AEM. Exempelformulären kan [hämtas här](assets/sample-forms.zip)

Öppna [MyAccountForm](http://localhost:4502/editor.html/content/forms/af/myaccountform.html) i redigeringsläge. Ange API-nyckel och API-hemlighet i lämpliga fält i det adaptiva formuläret.

## Testa lösningen

Förhandsgranska [StoreAFWithAttachments](http://localhost:4502/content/dam/formsanddocuments/storeafwithattachments/jcr:content?wcmmode=disabled)
Ange ditt mobilnummer inklusive landskoden, fyll i dina användaruppgifter och lägg till några bilagor. Klicka på knappen &quot;Spara och avsluta&quot; för att spara det adaptiva formuläret och dess bilagor


## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/327122?quality=9&learn=on)
