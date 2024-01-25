---
title: Lagra och hämta formulärdata från MySQL-databasen - distribuera
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptive Forms
topic: Development
role: Developer
level: Experienced
version: 6.4,6.5
exl-id: f520e7a4-d485-4515-aebc-8371feb324eb
duration: 59
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '249'
ht-degree: 0%

---

# Distribuera detta på servern

>[!NOTE]
>
>Följande krävs för att köra detta på datorn
>
>* AEM Forms (version 6.3 eller senare)
>* MySQL-databas

Så här testar du den här funktionen på din AEM Forms-instans:

* Hämta och distribuera [MySql Driver Jar](assets/mysqldriver.jar) filer med [felix-webbkonsol](http://localhost:4502/system/console/bundles)
* Hämta och distribuera [OSGi-paket](assets/SaveAndContinue.SaveAndContinue.core-1.0-SNAPSHOT.jar) med [felix-webbkonsol](http://localhost:4502/system/console/bundles)
* Hämta och installera [paket som innehåller klientlib, adaptiv formulärmall och den anpassade sidkomponenten](assets/store-and-fetch-af-with-data.zip) med [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* Importera [exempel på adaptiv form](assets/sample-adaptive-form.zip) med [Gränssnittet FormsAndDocuments](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)

* Importera [form-data-db.sql](assets/form-data-db.sql) med MySQL Workbench. Detta skapar de scheman och tabeller som behövs i databasen för att den här självstudiekursen ska fungera.
* Logga in på [configMgr.](http://localhost:4502/system/console/configMgr) Sök efter &quot;Apache Sling Connection Pooled DataSource. Skapa en ny post för den grupperade datakällan för Apache Sling-anslutningen med namnet **SparaOchFortsätt** med följande egenskaper:

| Egenskapsnamn | Värde |
| ------------------------|---------------------------------------|
| Namn på datakälla | SparaOchFortsätt |
| JDBC-drivrutinsklass | com.mysql.cj.jdbc.Driver |
| JDBC-anslutnings-URI | jdbc:mysql://localhost:3306/aemformstutorial |

* Öppna [Adaptiv form](http://localhost:4502/content/dam/formsanddocuments/demostoreandretrieveformdata/jcr:content?wcmmode=disabled)
* Fyll i viss information och klicka på knappen &quot;Spara och fortsätt senare&quot;.
* Du bör få tillbaka en URL med ett GUID.
* Kopiera URL-adressen och klistra in den på en ny flik i webbläsaren. **Kontrollera att det inte finns något tomt utrymme i slutet av URL-adressen.**
* Anpassat formulär ska fyllas i med data från föregående steg.
