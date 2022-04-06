---
title: Spara och återuppta brev
seo-title: Save and resume letters
description: Lär dig hur du sparar och hämtar utkast
seo-description: Learn how to save and retrieve draft letters
feature: Interactive Communication
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.5
topic: Development
role: Developer
level: Intermediate
kt: 10208
source-git-commit: 0a52ea9f5a475814740bb0701a09f1a6735c6b72
workflow-type: tm+mt
source-wordcount: '223'
ht-degree: 0%

---

# Spara utkast

Följande kod används för att spara bokstavsinstansen. Bokstavsinstansens metadata lagras i _utkast_ tabell. En unik sträng (draftID) genereras och returneras. Den här unika strängen används sedan för att hämta den sparade bokstavsinstansen.

```java
public String save(CCRDocumentInstance letterToSave) throws CCRDocumentException {
  String insertRowSQL = "INSERT INTO aemformstutorial.icdrafts(draftID,documentID,status,owner,name) VALUES(?,?,?,?,?)";
  log.debug(" in save IC Draft" + letterToSave.getDocumentId() + letterToSave.getName());
  UUID uuid = UUID.randomUUID();
  String uuidString = uuid.toString();
  Connection connection = getConnection();
  PreparedStatement pstmt = null;
  Document icData = letterToSave.getData();
  try {
    pstmt = connection.prepareStatement(insertRowSQL);
    pstmt.setString(1, uuidString);
    pstmt.setString(2, letterToSave.getDocumentId());
    pstmt.setString(3, "DRAFT");
    pstmt.setString(4, letterToSave.getCreatedBy());
    pstmt.setString(5, letterToSave.getName());
    icData.copyToFile(new File(uuidString + ".xml"));
    log.debug("Executing the insert statment  " + pstmt.executeUpdate());
    connection.commit();
  } catch (IOException | SQLException e) {
    log.debug("The error is " + e.getMessage());
  } finally {
    if (pstmt != null) {
      try {
        pstmt.close();
      } catch (SQLException e) {
        log.debug("Error in closing prepared statment" + e.getMessage());
      }
    }
    if (connection != null) {
      try {
        log.debug("Closing the connection in Save Letter Draft");
        connection.close();
      } catch (SQLException e) {
        log.debug("Error in closing connection" + e.getMessage());
      }
    }

  }

  return uuidString;
}
```

## Hämta brev

Följande kod skrevs för att hämta det sparade utkastet av brevet.
Om du vill läsa in en sparad bokstav måste du ange draftID. Baserat på detta draftID frågar vi databasen för att få ytterligare metadata om brevet. Samma draftID används för att skapa brevets data genom att läsa rätt XML från filsystemet. Ett CCRDocumentInstance-objekt konstrueras och returneras sedan.


```java
@Override
public CCRDocumentInstance get(String draftID) throws CCRDocumentException {

  String selectStatement = "Select documentID from aemformstutorial.icdrafts where draftID='" + draftID + "'";
  log.debug("The select statement is " + selectStatement);
  Connection connection = getConnection();
  Statement statement = null;
  String documentID = "";
  try {
    statement = connection.createStatement();
    ResultSet rs = statement.executeQuery(selectStatement);
    while (rs.next()) {
      documentID = rs.getString("documentID");

    }
  } catch (SQLException e) {
    log.debug("The error is " + e.getMessage());
  }
  Document draftData = new Document(new File(draftID + ".xml"));
  CCRDocumentInstance draftInstance = new CCRDocumentInstance(draftData, "abc", documentID, CCRDocumentInstance.Status.DRAFT);
  draftInstance.setId(draftID);
  return draftInstance;
}
```

### Uppdatera brev

Följande kod användes för att uppdatera den sparade bokstavsinstansen. Den uppdaterade bokstaven data skrivs till filsystemet med bokstaven-ID.

```java
public void update(CCRDocumentInstance letterInstanceToUpdate) throws CCRDocumentException {
		Document icData = letterInstanceToUpdate.getData();
		String draftID = letterInstanceToUpdate.getId();
		log.debug("updating letter instance with draft id =  "+draftID);
		try
			{
				icData.copyToFile(new File(draftID+".xml"));
			} 
		catch (IOException e)
			{
				log.debug("Error updating "+e.getMessage());;
			}
		
	}
```

### Hämta alla sparade brev

AEM Forms tillhandahåller inget användargränssnitt som listar de sparade bokstäverna. I den här artikeln listas de sparade bokstavsinstanserna i ett tabellformat med hjälp av ett adaptivt formulär.
Du kan anpassa frågan för att hämta de sparade bokstavsinstanserna. I det här exemplet frågar jag efter en förekomst av ett sparat brev av&quot;admin&quot;.

```java
	public List < CCRDocumentInstance > getAll(String arg0, Date arg1, Date arg2, Map < String, Object > arg3) throws CCRDocumentException {
	  String selectStatement = "Select * from aemformstutorial.icdrafts where owner = 'admin'";
	  Connection connection = getConnection();
	  Statement statement = null;
	  String documentID = "";
	  List < CCRDocumentInstance > listOfDrafts = new ArrayList < CCRDocumentInstance > ();
	  String draftID;
	  String savedInstanceName = "";
	  try {
	    statement = connection.createStatement();
	    ResultSet rs = statement.executeQuery(selectStatement);
	    while (rs.next()) {
	      documentID = rs.getString("documentID");
	      draftID = rs.getString("draftID");
	      savedInstanceName = rs.getString("name");
	      Document draftData = new Document(new File(draftID + ".xml"));
	      CCRDocumentInstance draftLetter = new CCRDocumentInstance(draftData, savedInstanceName, documentID, CCRDocumentInstance.Status.DRAFT);
	      listOfDrafts.add(draftLetter);
	    }
	  } catch (SQLException e) {
	    log.debug("The error is " + e.getMessage());
	  } finally {
	    if (statement != null) {
	      try {
	        statement.close();
	      } catch (SQLException e) {
	        log.debug("error in closing statement" + e.getMessage());
	      }
	    }
	    if (connection != null) {
	      try {
	        connection.close();
	      } catch (SQLException e) {
	        log.debug("error in closing connection" + e.getMessage());
	      }
	    }
	  }

	  return listOfDrafts;
	}
```

### Eclipse-projekt

Det explicita projektet med exempelimplementering kan [hämtad härifrån](assets/icdrafts-eclipse-project.zip)

