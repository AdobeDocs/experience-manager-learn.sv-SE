---
title: Lagra och hämta formulärdata från MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptiv Forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '283'
ht-degree: 1%

---


# Distribuera detta på servern

>[!NOTE]
>
>Följande krävs för att köra detta på datorn
>
>* AEM Forms (version 6.3 eller senare)
>* MySQL-databas


Så här testar du den här funktionen på din AEM Forms-instans:

* Hämta och distribuera JAR-filer för MySQL-drivrutinen ](assets/mysqldriver.jar) med [felix-webbkonsolen](http://localhost:4502/system/console/bundles)[
* Hämta och distribuera [OSGi-paketet](assets/SaveAndContinue.SaveAndContinue.core-1.0-SNAPSHOT.jar) med [felix-webbkonsolen](http://localhost:4502/system/console/bundles)
* Hämta och installera [paketet som innehåller klientlib, adaptiv formulärmall och den anpassade sidkomponenten](assets/store-and-fetch-af-with-data.zip) med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Importera [exemplet Adaptiv form](assets/sample-adaptive-form.zip) med [gränssnittet FormsAndDocuments](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)

* Importera [form-data-db.sql](assets/form-data-db.sql) med MySql Workbench. Detta skapar de scheman och tabeller som behövs i databasen för att den här självstudiekursen ska fungera.
* Logga in på [configMgr.](http://localhost:4502/system/console/configMgr) Sök efter &quot;Apache Sling Connection Pooled DataSource. Skapa en ny post för den grupperade datakällan för Apache Sling-anslutningen med namnet **SaveAndContinue** med följande egenskaper:

| Egenskapsnamn | Värde |
------------------------|---------------------------------------
| Namn på datakälla | SparaOchFortsätt |
| JDBC-drivrutinsklass | com.mysql.cj.jdbc.Driver |
| JDBC-anslutnings-URI | jdbc:mysql://localhost:3306/aemformstutorial |


* Öppna [det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/demostoreandretrieveformdata/jcr:content?wcmmode=disabled)
* Fyll i viss information och klicka på knappen &quot;Spara och fortsätt senare&quot;.
* Du bör få tillbaka en URL med ett GUID.
* Kopiera URL-adressen och klistra in den på en ny flik i webbläsaren. **Kontrollera att det inte finns något tomt utrymme i slutet av URL-adressen.**
* Anpassat formulär ska fyllas i med data från föregående steg.
