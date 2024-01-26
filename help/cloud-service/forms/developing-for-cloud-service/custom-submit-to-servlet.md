---
title: Skapa en anpassad hanterare för åtgärden skicka
description: Skicka anpassat formulär till en anpassad inskickningshanterare
solution: Experience Manager
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Developer Tools
jira: KT-8852
exl-id: 983e0394-7142-481f-bd5e-6c9acefbfdd0
duration: 58
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '203'
ht-degree: 0%

---

# Skapa en servlet för att bearbeta skickade data

Starta aem-Banking-projektet i IntelliJ.
Skapa en enkel server för att skicka data till loggfilen.Kontrollera att koden finns i kärnprojektet enligt skärmbilden nedan
![create-servlet](assets/create-servlet.png)

```java
package com.aem.bankingapplication.core.servlets;
import org.apache.sling.api.SlingHttpServletRequest;
import org.apache.sling.api.SlingHttpServletResponse;
import org.apache.sling.api.servlets.SlingAllMethodsServlet;
import javax.servlet.Servlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.osgi.service.component.annotations.Component;
@Component(service = { Servlet.class}, property = {"sling.servlet.methods=post","sling.servlet.paths=/bin/formstutorial"})
public class HandleFormSubmissison extends SlingAllMethodsServlet {
    private static final Logger log = LoggerFactory.getLogger(HandleFormSubmissison.class);
    protected void doPost(SlingHttpServletRequest request,SlingHttpServletResponse response) {
        log.debug("Inside my formstutorial servlet");
        log.debug("The form data I got was "+request.getParameter("jcr:data"));
    }
}
```

## Skapa anpassad överföringshanterare

Skapa en anpassad sändningsåtgärd i `apps/bankingapplication` på samma sätt som i [tidigare versioner av AEM Forms](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/adaptive-forms/custom-submit-aem-forms-article.html?lang=en). I den här självstudiekursen skapar jag en mapp med namnet SubmitToAEMServlet under `apps/bankingapplication` i CRX-databasen.

Följande kod i post.POST.jsp vidarebefordrar enkelt begäran till den server som är monterad på /bin/formstutorial. Det här är samma server som skapades i det tidigare steget

```java
com.adobe.aemds.guide.utils.GuideSubmitUtils.setForwardPath(slingRequest,"/bin/formstutorial",null,null);
```

I ditt AEM i IntelliJ högerklickar du på `apps/bankingapplication` och välj Ny | Paketera och skriv i SubmitToAEMServlet efter apps.bankingapplication i den nya paketdialogrutan. Högerklicka på noden SubmitToAEMServlet och välj repo | Hämta kommando för att synkronisera AEM projekt med AEM serverdatabas.


## Konfigurera anpassat formulär

Nu kan du konfigurera alla adaptiva formulär att skicka till den här anpassade överföringshanteraren som kallas **Skicka till AEM**

## Nästa steg

[Registrera servlet med resurstyp](./registering-servlet-using-resourcetype.md)
