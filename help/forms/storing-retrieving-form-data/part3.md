---
title: Lagra och hämta formulärdata från MySQL-databasen
description: Flera delar av en självstudiekurs som visar hur du arbetar med att lagra och hämta formulärdata
feature: Adaptive Forms
type: Tutorial
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 9cce47e7-07b4-43c3-8746-197620855c3f
duration: 62
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '93'
ht-degree: 0%

---

# Skapa OSGi-tjänst för att hämta data

Följande kod skrevs för att lagra och hämta lagrade data för adaptiva formulär. En enkel fråga används för att hämta data för adaptiva formulär som är kopplade till ett givet GUID. Hämtade data returneras sedan till det anropande programmet. Samma datakälla som skapades i det tidigare steget refereras i koden


```java
package com.aemforms.saveandcontinue.core.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.UUID;

import javax.sql.DataSource;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component(immediate = true)
public class FetchFormData implements com.aemforms.saveandcontinue.core.FetchStoredFormData {
  private final Logger log = LoggerFactory.getLogger(getClass());@Reference(target = "(&(objectclass=javax.sql.DataSource)(datasource.name=SaveAndContinue))")
  private DataSource dataSource;@Override
  public String getData(String guid) {
    log.debug("### inside my getData of AemformWithDB");
    Connection con = getConnection();
    try {
      Statement st = con.createStatement();
      String query = "SELECT afdata FROM aemformstutorial.formdata where guid = '" + guid + "'" + "";
      log.debug(" Got Result Set" + query);
      ResultSet rs = st.executeQuery(query);
      while (rs.next()) {
        return rs.getString("afdata");
      }
    } catch(SQLException e) {
      // TODO Auto-generated catch block
      log.debug(e.getMessage());
    }

    return null;
  }
  public Connection getConnection() {
    log.debug("Getting Connection ");
    Connection con = null;
    try {

      con = dataSource.getConnection();
      log.debug("got connection");
      return con;
    } catch(Exception e) {
      log.debug("not able to get connection " + e.getMessage());

    }
    return null;
  }

  public String storeFormData(String formData) {
    // TODO Auto-generated method stub
    log.debug("******Inside my AEMFormsWith DB service*****");
    log.debug("### Inserting data ... " + formData);

    String insertRowSQL = "INSERT INTO aemformstutorial.formdata(guid,afdata) VALUES(?,?)";
    UUID uuid = UUID.randomUUID();
    String randomUUIDString = uuid.toString();
    log.debug("The insert query is " + insertRowSQL);
    Connection c = getConnection();
    PreparedStatement pstmt = null;
    try {
      pstmt = null;
      pstmt = c.prepareStatement(insertRowSQL);
      pstmt.setString(1, randomUUIDString);
      pstmt.setString(2, formData);
      log.debug("Executing the insert statment  " + pstmt.executeUpdate());
      c.commit();
    } catch(SQLException e) {

      log.error("unable to insert data in the table", e.getMessage());
    } finally {
      if (pstmt != null) {
        try {
          pstmt.close();
        } catch(SQLException e) {
          log.debug("error in closing prepared statement " + e.getMessage());
        }
      }
      if (c != null) {
        try {
          c.close();
        } catch(SQLException e) {
          log.debug("error in closing connection " + e.getMessage());
        }
      }
    }
    return randomUUIDString;
  }@Override
  public String updateData(String guid, String afData) {
    String updateTableSQL = "update aemformstutorial.formdata set afdata= ? where guid = ?";
    Connection c = getConnection();
    PreparedStatement pstmt = null;
    try {

      pstmt = null;
      pstmt = c.prepareStatement(updateTableSQL);
      pstmt.setString(1, afData);
      pstmt.setString(2, guid);
      log.debug("Executing the insert statment  " + pstmt.executeUpdate());

    } catch(SQLException e) {

      log.debug("Getting errors", e.getMessage());
    } finally {
      if (pstmt != null) {
        try {
          pstmt.close();
        } catch(SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }
      if (c != null) {
        try {
          c.close();
        } catch(SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
        }
      }
    }
    return guid;

  }

}
```

## Gränssnitt

Följande är gränssnittsdeklarationen som användes

```java
package com.aemforms.saveandcontinue.core;

public interface FetchStoredFormData 
{public String getData(String guid);
public String storeFormData(String formData);
public String updateData(String guid,String afData);

}
```
