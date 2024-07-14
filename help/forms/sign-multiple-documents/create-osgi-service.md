---
title: Skapa OSGi-tjänst
description: Skapa OSGi-tjänst för att lagra formulären som ska signeras
feature: Workflow
version: 6.4,6.5
thumbnail: 6886.jpg
jira: KT-6886
topic: Development
role: Developer
level: Experienced
exl-id: 49e7bd65-33fb-44d4-aaa2-50832dffffb0
duration: 150
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '364'
ht-degree: 0%

---

# Skapa OSGi-tjänst

Följande kod skrevs för att lagra de formulär som behöver signeras. Varje formulär som ska signeras är associerat med ett unikt GUID och ett kund-ID. Ett eller flera formulär kan alltså kopplas till samma kund-ID, men har ett unikt GUID tilldelat till formuläret.

## Gränssnitt

Följande är gränssnittsdeklarationen som användes

```java
package com.aem.forms.signmultipleforms;
import com.adobe.granite.workflow.WorkflowSession;
import com.adobe.granite.workflow.exec.WorkItem;
public interface SignMultipleForms
{
    public void insertData(String []formNames,String formData,String serverURL,WorkItem workItem, WorkflowSession workflowSession);
    public String getNextFormToSign(int customerID);
    public void updateSignatureStatus(String formData,String guid);
    public String getFormData(String guid);
}
```



## Infoga data

Metoden Infoga data infogar en rad i databasen som identifieras av datakällan. Varje rad i databasen motsvarar ett formulär och identifieras unikt av ett GUID och ett kund-ID. Formulärdatat och formulärets URL lagras också på den här raden. Statuskolumnen anger om formuläret har fyllts i och signerats. Värdet 0 anger att formuläret ännu inte har signerats.

```java
@Override
public void insertData(String[] formNames, String formData, String serverURL, WorkItem workItem, WorkflowSession workflowSession) {
  String insertTableSQL = "INSERT INTO aemformstutorial.signingforms(formName,formData,guid,status,customerID) VALUES(?,?,?,?,?)";
  Random r = new Random();
  Connection con = getConnection();
  PreparedStatement pstmt = null;
  int customerIDGnerated = r.nextInt((1000 - 1) + 1) + 1;
  log.debug("The number of forms to insert are  " + formNames.length);
  try {
    for (int i = 0; i < formNames.length; i++) {
      log.debug("Inserting form name " + formNames[i]);
      UUID uuid = UUID.randomUUID();
      String randomUUIDString = uuid.toString();
      String formUrl = serverURL + "/content/dam/formsanddocuments/formsandsigndemo/" + formNames[i] + "/jcr:content?wcmmode=disabled&guid=" + randomUUIDString + "&customerID=" + customerIDGnerated;
      pstmt = con.prepareStatement(insertTableSQL);
      pstmt.setString(1, formUrl);
      pstmt.setString(2, formData.replace("<guid>3938</guid>", "<guid>" + uuid + "</guid>"));
      pstmt.setString(3, uuid.toString());
      pstmt.setInt(4, 0);
      pstmt.setInt(5, customerIDGnerated);
      log.debug("customerIDGnerated the insert statment  " + pstmt.execute());
      if (i == 0) {
        WorkflowData wfData = workItem.getWorkflowData();
        wfData.getMetaDataMap().put("formURL", formUrl);
        workflowSession.updateWorkflowData(workItem.getWorkflow(), wfData);
        log.debug("$$$$ Done updating the map");

}

}
    con.commit();
  }
  catch(Exception e) {
    log.debug(e.getMessage());
  }
  finally {
    if (pstmt != null) {
      try {
        pstmt.close();
      } catch(SQLException e) {

log.debug(e.getMessage());
      }
    }
    if (con != null) {
      try {
        con.close();
      } catch(SQLException e) {
        log.debug(e.getMessage());
      }
    }
  }

}
```


## Hämta formulärdata

Följande kod används för att hämta adaptiva formulärdata som är associerade med det angivna GUID:t. Formulärdatat används sedan för att fylla i det anpassade formuläret i förväg.

```java
@Override
public String getFormData(String guid) {
  log.debug("### Getting form data asscoiated with guid " + guid);
  Connection con = getConnection();
  try {
    Statement st = con.createStatement();
    String query = "SELECT formData FROM aemformstutorial.signingforms where guid = '" + guid + "'" + "";
    log.debug(" The query being consrtucted " + query);
    ResultSet rs = st.executeQuery(query);
    while (rs.next()) {
      return rs.getString("formData");
    }
  } catch(SQLException e) {
    // TODO Auto-generated catch block
    log.debug(e.getMessage());
  }

  return null;

}
```

## Uppdatera signaturstatus

Underteckningsceremonin har slutförts och ett AEM som är kopplat till formuläret har startats. Det första steget i arbetsflödet är ett processsteg som uppdaterar statusen i databasen för raden som identifieras av GUID och kund-ID. Vi ställer också in värdet för det signerade elementet i formulärdata på Y för att ange att formuläret har fyllts i och signerats. Det adaptiva formuläret fylls i med dessa data och värdet för det signerade dataelementet i XML-data används för att visa rätt meddelande. Koden updateSignatureStatus anropas från det anpassade processsteget.


```java
public void updateSignatureStatus(String formData, String guid) {
  String updateStatment = "update aemformstutorial.signingforms SET formData = ?, status = ? where guid = ?";
  PreparedStatement updatePS = null;
  Connection con = getConnection();
  try {
    updatePS = con.prepareStatement(updateStatment);
    updatePS.setString(1, formData.replace("<signed>N</signed>", "<signed>Y</signed>"));
    updatePS.setInt(2, 1);
    updatePS.setString(3, guid);
    log.debug("Updated the signature status " + String.valueOf(updatePS.execute()));
  } catch(SQLException e) {
    log.debug(e.getMessage());
  }
  finally {
    try {
      con.commit();
      updatePS.close();
      con.close();
    } catch(SQLException e) {
      
      log.debug(e.getMessage());
    }

  }

}
```

## Hämta nästa formulär att signera

Följande kod användes för att hämta nästa formulär för signering för ett givet customerID med statusen 0. Om SQL-frågan inte returnerar några rader returnerar vi strängen **&quot;AllDone&quot;** som anger att det inte finns fler formulär för signering för angivet kund-ID.

```java
@Override
public String getNextFormToSign(int customerID) {
  System.out.println("### inside my next form to sign " + customerID);
  String selectStatement = "SELECT formName FROM aemformstutorial.signingforms where status = 0 and customerID=" + customerID;
  Connection con = getConnection();
  try
   {
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(selectStatement);
    while (rs.next()) {
      log.debug("Got result set object");
      return rs.getString("formName");
    }
    if (!rs.next()) {
      return "AllDone";
    }
  } catch(SQLException e) {
    log.debug(e.getMessage());
  }
  finally {
    try {
      con.close();
    } catch(SQLException e) {
      // TODO Auto-generated catch block
      log.debug(e.getMessage());
    }
  }

  return null;

}
```



## Assets

OSGi-paketet med de ovannämnda tjänsterna kan [hämtas här](assets/sign-multiple-forms.jar)

## Nästa steg

[Skapa ett huvudarbetsflöde för att hantera den inledande formuläröverföringen](./create-main-workflow.md)
