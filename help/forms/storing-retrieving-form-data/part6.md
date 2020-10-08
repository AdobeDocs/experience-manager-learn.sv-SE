---
title: Lagra och hämta formulärdata från MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
translation-type: tm+mt
source-git-commit: 3a3832a05ed9598d970915adbc163254c6eb83f1
workflow-type: tm+mt
source-wordcount: '248'
ht-degree: 0%

---


# Distribuera detta på servern

>[!NOTE]
>
>Följande krävs för att köra detta på datorn
>
>* AEM Forms (version 6.3 eller senare)
>* MYSQL-databas


Så här testar du den här funktionen på din AEM Forms-instans:

* Ladda ned och zippa upp [självstudieresurserna](assets/store-retrieve-form-data.zip) i ditt lokala system
* Driftsätt och starta techmarketingdemos.jar- och mysqldriver.jar-paketen med [Felix webbkonsol](http://localhost:4502/system/console/configMgr)
* Importera aemformstutorial.sql med MYSQL Workbench. Detta skapar de scheman och tabeller som behövs i databasen för att den här självstudiekursen ska fungera.
* Importera StoreAndRetrieve.zip med [AEM.](http://localhost:4502/crx/packmgr/index.jsp) Det här paketet innehåller mallen Adaptivt formulär, klientlib för sidkomponenter samt exempel på konfiguration av adaptivt formulär och datakälla.
* Logga in på [configMgr.](http://localhost:4502/system/console/configMgr) Sök efter &quot;Apache Sling Connection Pooled DataSource. Öppna den datakällpost som är associerad med en självstudiekurs och ange användarnamnet och lösenordet som är specifikt för din databasinstans.
* Öppna det [adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/demostoreandretrieveformdata/jcr:content?wcmmode=disabled)
* Fyll i viss information och klicka på knappen &quot;Spara och fortsätt senare&quot;
* Du bör få tillbaka en URL med ett GUID.
* Kopiera URL-adressen och klistra in den på en ny flik i webbläsaren. **Kontrollera att det inte finns något tomt utrymme i slutet av URL-adressen**
* Anpassat formulär ska fyllas i med data från föregående steg
