---
title: AEM Forms med JSON-schema och data[del2]
description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
feature: Adaptive Forms
doc-type: Tutorial
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 29195c70-af12-4a22-8484-3c87a1e07378
duration: 110
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '330'
ht-degree: 0%

---

# Lagra skickade data i databasen


>[!NOTE]
>
>Vi rekommenderar att du använder MySQL 8 som din databas eftersom den har stöd för JSON-datatyp. Du måste också installera rätt drivrutin för MySQL DB. Jag har använt drivrutinen som finns här https://mvnrepository.com/artifact/mysql/mysql-connector-java/8.0.12

Om du vill lagra skickade data i databasen skriver vi en serverlet som extraherar bundna data och formulärnamnet och arkivet. Den fullständiga koden för att hantera formuläröverföringen och lagra afBoundData i databasen anges nedan.

Vi har skapat en anpassad sändning för att hantera formuläröverföringen. I den här anpassade skickapostens post.POST.jsp vidarebefordrar vi begäran till vår tjänstserver.

Läs det här om du vill veta mer om anpassade inlämningsförfrågningar [artikel](https://helpx.adobe.com/experience-manager/kt/forms/using/custom-submit-aem-forms-article.html)

com.adobe.aemds.guide.utils.GuideSubmitUtils.setForwardPath(slingRequest,&quot;/bin/stoconfirmSubmit&quot;,null,null);

```java
package com.aemforms.json.core.servlets;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.sql.DataSource;

import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import org.json.JSONException;
import org.json.JSONObject;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(service = Servlet.class, property = {

"sling.servlet.methods=get", "sling.servlet.methods=post",

"sling.servlet.paths=/bin/storeafsubmission"

})
public class HandleAdaptiveFormSubmission extends SlingAllMethodsServlet {
 private static final Logger log = LoggerFactory.getLogger(HandleAdaptiveFormSubmission.class);
 private static final long serialVersionUID = 1L;
 @Reference(target = "(&(objectclass=javax.sql.DataSource)(datasource.name=aemformswithjson))")
 private DataSource dataSource;

 protected void doPost(SlingHttpServletRequest request, SlingHttpServletResponse response) throws ServletException {
  JSONObject afSubmittedData;
  try {
   afSubmittedData = new JSONObject(request.getParameter("jcr:data"));
   // we will only store the data bound to schema
   JSONObject dataToStore = afSubmittedData.getJSONObject("afData").getJSONObject("afBoundData")
     .getJSONObject("data");
   String formName = afSubmittedData.getJSONObject("afData").getJSONObject("afSubmissionInfo")
     .getString("afPath");
   log.debug("The form name is " + formName);
   insertData(dataToStore, formName);

  } catch (JSONException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }

 }

 public void insertData(org.json.JSONObject jsonData, String formName) {
  log.debug("The json object I got to insert was " + jsonData.toString());
  String insertTableSQL = "INSERT INTO aemformswithjson.formsubmissions(formdata,formname) VALUES(?,?)";
  log.debug("The query is " + insertTableSQL);
  Connection c = getConnection();
  PreparedStatement pstmt = null;
  try {
   pstmt = null;
   pstmt = c.prepareStatement(insertTableSQL);
   pstmt.setString(1, jsonData.toString());
   pstmt.setString(2, formName);
   log.debug("Executing the insert statment  " + pstmt.executeUpdate());
   c.commit();
  } catch (SQLException e) {

   log.error("Getting errors", e);
  } finally {
   if (pstmt != null) {
    try {
     pstmt.close();
    } catch (SQLException e) {
     // TODO Auto-generated catch block
     e.printStackTrace();
    }
   }
   if (c != null) {
    try {
     c.close();
    } catch (SQLException e) {
     // TODO Auto-generated catch block
     e.printStackTrace();
    }
   }
  }
 }

 public Connection getConnection() {
  log.debug("Getting Connection ");
  Connection con = null;
  try {

   con = dataSource.getConnection();
   log.debug("got connection");
   return con;
  } catch (Exception e) {
   log.error("not able to get connection ", e);
  }
  return null;
 }

}
```

![anslutningpool](assets/connectionpooled.gif)

Så här fungerar ditt system:

* [Ladda ned och zippa upp zip-filen](assets/aemformswithjson.zip)
* Skapa AdaptiveForm med JSON-schema. Du kan använda JSON-schemat som ingår i den här artikelresursen. Se till att du skickar in formuläret på rätt sätt. Åtgärden Skicka måste konfigureras till CustomSubmitHelpx.
* Skapa ett schema i MySQL-instansen genom att importera filen schema.sql med verktyget MySQL Workbench. Du får även filen schema.sql som en del av den här självstudiekursen.
* Konfigurera den poolade datakällan för Apache Sling-anslutningen från Felix webbkonsol
* Ge datakällan namnet&quot;aemformswithjson&quot;. Detta är namnet som används av det OSGi-exempelpaket som du får
* Se bilden ovan för mer information om egenskaper. Detta förutsätter att du kommer att använda MySQL som databas.
* Distribuera de OSGi-paket som ingår i den här artikelresursen.
* Förhandsgranska formuläret och skicka.
* JSON-data lagras i den databas som skapades när du importerade filen &quot;schema.sql&quot;.
