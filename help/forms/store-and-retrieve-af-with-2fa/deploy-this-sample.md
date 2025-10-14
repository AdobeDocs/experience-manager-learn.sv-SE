---
title: Distribuera exemplet
description: Hämta användningsfall som körs på den lokala AEM Forms-instansen
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.4, Experience Manager 6.5
jira: KT-6602
thumbnail: 6602.jpg
topic: Development
role: Developer
level: Intermediate
exl-id: cdfae631-86d7-438f-9baf-afd621802723
duration: 186
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '373'
ht-degree: 0%

---

# Distribuera exemplet

Följ följande anvisningar för att få det här användningsfallet att fungera i ditt system:

>[!NOTE]
>Du måste köra AEM Forms på port 4502.


## Skapa databas

I det här exemplet används MySQL-databasen för att lagra data för anpassade formulär. Du måste skapa databasschemat [genom att importera schemafilen &#x200B;](assets/data-base-schema.sql) till MySQL workbench.

## Skapa datakälla

Du måste skapa en sammanslagen datakälla för Apache Sling-anslutningen med namnet **StoreAndRetrieveAfData** som pekar på databasschemat som skapades i det tidigare steget. Koden i OSGi-paketet använder det här datakällnamnet.

## Skapa formulärdatamodell

Formulärdatamodell måste skapas baserat på den här datakällan med namnet **StoreAndRetrieveAfData**. Den här formulärdatamodellen används för att hämta det mobiltelefonnummer som är kopplat till program-ID:t. Formulärdatamodellen kan [hämtas härifrån.](assets/2-Factor-Authentication-DataSource-and-FDM.zip)

## Skapa utvecklarkonto med nexmo

Skapa ett utvecklarkonto med [Nexmo](https://dashboard.nexmo.com/) för att skicka och verifiera engångskoder. Anteckna API-nyckeln och API-hemlig nyckel. Datakällan och formulärdatamodellen har redan skapats för dig mot den här tjänsten och ingår i de tillgångar som nämns i föregående steg.

## Distribuera följande OSGi-paket

Distribuera det paket som innehåller [koden för att lagra och hämta data från databasen &#x200B;](assets/SaveAndResume.core-1.0.0-SNAPSHOT.jar)
Ladda ned och zippa upp [developingwith serviceUser.zip](https://experienceleague.adobe.com/docs/experience-manager-learn/assets/developingwithserviceuser.zip?lang=sv-SE) .
Distribuera filen DevelopingWithServiceUser.jar med Felix webbkonsol.

## Distribuera klientbiblioteket

Exemplet använder två klientbibliotek. Importera dessa [klientbibliotek](assets/store-af-with-attachments-client-lib.zip) till AEM.

## Importera en anpassad formulärmall

Exempelformulären som används i den här demon är baserade på en anpassad mall. Importera den anpassade mallen [till AEM](assets/custom-template-with-page-component.zip)

## Importera exempeladaptiva formulär

De två formulär som utgör det här exemplet måste importeras till AEM. Exempelformulären kan [hämtas här](assets/sample-forms.zip)

Öppna [MyAccountForm](http://localhost:4502/editor.html/content/forms/af/myaccountform.html) i redigeringsläge. Ange Vonage API Key- och API Secret-värden i lämpliga fält i det adaptiva formuläret.

## Testa lösningen

Förhandsgranska [StoreAFWithAttachments](http://localhost:4502/content/dam/formsanddocuments/storeafwithattachments/jcr:content?wcmmode=disabled)
Ange ditt mobilnummer inklusive landskoden, fyll i dina användaruppgifter och lägg till några bilagor. Klicka på knappen &quot;Spara och avsluta&quot; för att spara det adaptiva formuläret och dess bilagor


## Demonstration av användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/327122?quality=12&learn=on)
