---
title: Lägga till DAM-mappobjekt i alternativgruppskomponenten
description: Lägg till objekt i urvalsgruppskomponenten dynamiskt
feature: Adaptive Forms
version: 6.5
topic: Development
role: User
level: Beginner
last-substantial-update: 2023-01-01T00:00:00Z
exl-id: 29f56d13-c2e2-4bc2-bfdc-664c848dd851
duration: 81
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '230'
ht-degree: 0%

---

# Lägga till objekt dynamiskt i alternativgruppskomponenten

I AEM Forms 6.5 introducerades möjligheten att lägga till objekt dynamiskt i en adaptiv Forms-valgruppkomponent som CheckBox, Radio Button och Image List. I den här artikeln ska vi titta på hur man fyller i en alternativgruppskomponent med innehållet i DAM-mappen. På skärmbilden finns de tre filerna i mappen newsletter. Varje gång ett nytt nyhetsbrev läggs till i mappen uppdateras urvalsgruppskomponenten och visar innehållet automatiskt. Användaren kan välja ett eller flera nyhetsbrev att hämta.

![Regelredigeraren](assets/newsletters-download.png)

## Skapa en server för att returnera innehållet i DAM-mappen

Följande kod skrevs för att returnera innehållet i DAM-mappen i JSON-format.

```java
package com.newsletters.core.servlets;
import static com.day.cq.commons.jcr.JcrConstants.JCR_CONTENT;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Servlet;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.resource.Resource;
import org.apache.sling.api.servlets.SlingSafeMethodsServlet;
import org.osgi.service.component.annotations.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Component(service = {
  Servlet.class
}, property = {
  "sling.servlet.methods=get",
  "sling.servlet.paths=/bin/listfoldercontents"
})
public class ListFolderContent extends SlingSafeMethodsServlet {
  private static final long serialVersionUID = 1 L;
  private static final Logger log = LoggerFactory.getLogger(ListFolderContent.class);
  protected void doGet(SlingHttpServletRequest request, SlingHttpServletResponse response) {
    Resource resource = request.getResourceResolver().getResource(request.getParameter("damFolder"));
    List < JsonObject > results = new ArrayList < > ();
    resource.getChildren().forEach(child -> {
      if (!JCR_CONTENT.equals(child.getName())) {
        JsonObject asset = new JsonObject();
        log.debug("##The child name is " + child.getName());
        asset.addProperty("assetname", child.getName());
        asset.addProperty("assetpath", child.getPath());
        results.add(asset);

      }
    });
    PrintWriter out = null;
    try {
      out = response.getWriter();
    } catch (IOException e) {

      log.debug(e.getMessage());
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    Gson gson = new Gson();
    out.print(gson.toJson(results));
    out.flush();
  }

}
```

## Skapa klientbibliotek med JavaScript-funktion

Servern anropas från en JavaScript-funktion. Funktionen returnerar ett arrayobjekt som används för att fylla i alternativgruppskomponenten

```javascript
/**
 * Populate drop down/choice group  with assets from specified folder
 * @return {string[]} 
 */
function getDAMFolderAssets(damFolder) {
   // strUrl is whatever URL you need to call
   var strUrl = '/bin/listfoldercontents?damFolder=' + damFolder;
   var documents = [];
   $.ajax({
      url: strUrl,
      success: function(jsonData) {
         for (i = 0; i < jsonData.length; i++) {
            documents.push(jsonData[i].assetpath + "=" + jsonData[i].assetname);
         }
      },
      async: false
   });
   return documents;
}
```

## Skapa anpassat formulär

Skapa ett anpassat formulär och koppla formuläret till klientbiblioteket **listormappresurser**. Lägg till en kryssrutekomponent i formuläret. Använd regelredigeraren för att fylla i alternativen för kryssrutan så som de visas på skärmbilden
![set-options](assets/set-options-newsletter.png)

Vi anropar javascript-funktionen som anropas **getDAMFolderAssets** och skickar sökvägen till resursen i DAM-mappen till listan i formuläret.

## Nästa steg

[Sammanställ markerade resurser](./assemble-selected-newsletters.md)
