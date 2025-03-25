---
title: Lagra och hämta formulärdata från MySQL-databasen - distribuera
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptive Forms
topic: Development
role: Developer
level: Experienced
version: Experience Manager 6.4, Experience Manager 6.5
exl-id: f520e7a4-d485-4515-aebc-8371feb324eb
duration: 47
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '243'
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

* Hämta och distribuera [JAR](assets/mysqldriver.jar)-filerna för MySQL-drivrutinen med webbkonsolen [felix](http://localhost:4502/system/console/bundles)
* Hämta och distribuera [OSGi-paketet](assets/SaveAndContinue.SaveAndContinue.core-1.0-SNAPSHOT.jar) med webbkonsolen [felix](http://localhost:4502/system/console/bundles)
* Hämta och installera det [paket som innehåller klientlib, adaptiv formulärmall och den anpassade sidkomponenten](assets/store-and-fetch-af-with-data.zip) med hjälp av [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Importera det adaptiva [exemplet ](assets/sample-adaptive-form.zip) med gränssnittet [FormsAndDocuments](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)

* Importera [form-data-db.sql](assets/form-data-db.sql) med MySQL Workbench. Detta skapar de scheman och tabeller som behövs i databasen för att den här självstudiekursen ska fungera.
* Logga in på [configMgr.](http://localhost:4502/system/console/configMgr) Sök efter &quot;Apache Sling Connection Pooled DataSource. Skapa en ny post för datakällan för anslutningen till Apache Sling med namnet **SaveAndContinue** med följande egenskaper:

| Egenskapsnamn | Värde |
| ------------------------|---------------------------------------|
| Namn på datakälla | `SaveAndContinue` |
| JDBC-drivrutinsklass | `com.mysql.cj.jdbc.Driver` |
| JDBC-anslutnings-URI | `jdbc:mysql://localhost:3306/aemformstutorial` |

* Öppna det [adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/demostoreandretrieveformdata/jcr:content?wcmmode=disabled)
* Fyll i viss information och klicka på knappen &quot;Spara och fortsätt senare&quot;.
* Du bör få tillbaka en URL med ett GUID.
* Kopiera URL-adressen och klistra in den på en ny flik i webbläsaren. **Kontrollera att det inte finns något tomt utrymme i slutet av URL:en.**
* Anpassat formulär ska fyllas i med data från föregående steg.
