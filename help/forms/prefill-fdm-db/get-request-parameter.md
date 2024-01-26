---
title: Hämta begäranparameter
description: Åtkomst till begärandeparametern för en formulärdatamodell förifyllningstjänst
feature: Adaptive Forms
version: 6.4,6.5
jira: KT-5815
thumbnail: kt-5815.jpg
topic: Development
role: Developer
level: Beginner
exl-id: a640539d-c67f-4224-ad81-dd0b62e18c79
duration: 49
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '176'
ht-degree: 0%

---

# Hämta begäranparameter

## Hämta empID-parameter

Nästa steg är att få åtkomst till parametern empID från URL:en. Värdet för parametern empID-begäran skickas sedan till **_get_** tjänståtgärd för formulärdatamodellen.
För kursen har vi skapat följande

* Adaptiv formulärmall har anropats **_FDMDemo_**
* Page Component called **_fdmdemo_**
* Inkluderade vårt anpassade jsp med sidkomponenten
* Kopplade den adaptiva formulärmallen till sidkomponenten

Genom att göra detta kommer vår kod i den anpassade jsp endast att köras när anpassningsbara formulär baserade på den här anpassade mallen återges

* [Importera paketet](assets/template-page-component.zip) använda [pakethanterare](http://localhost:4502/crx/packmgr/index.jsp)
* [Öppna fdmrequest.jsp](http://localhost:4502/crx/de/index.jsp#/apps/fdmdemo/component/page/fdmdemo/fdmrequest.jsp)
* Avkommentera kommentarsraderna.
* Spara ändringarna

```java
if(request.getParameter("empID")!=null)
    {
      //System.out.println("Adobe !!!There is a empID parameter in the request "+request.getParameter("empID"));
      //java.util.Map paraMap = new java.util.HashMap();
      //paraMap.put("empID",request.getParameter("empID"));
      //slingRequest.setAttribute("paramMap",paraMap);
    }
```

Värdet för empID är associerat med nyckeln empID i paraMap. Mappningen skickas sedan till slingRequest

>[!NOTE]
>
>Nyckeln empID måste matcha bindningsvärdet för de entiteter som hämtar tjänsten

## Nästa steg

[Skapa ett anpassat formulär baserat på formulärdatamodellen](./create-adaptive-form.md)
