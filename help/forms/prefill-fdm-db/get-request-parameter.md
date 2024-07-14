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
duration: 40
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '176'
ht-degree: 0%

---

# Hämta begäranparameter

## Hämta empID-parameter

Nästa steg är att få åtkomst till parametern empID från URL:en. Värdet på parametern empID-begäran skickas sedan till tjänståtgärden **_get_** i formulärdatamodellen.
För kursen har vi skapat följande

* Den adaptiva formulärmallen **_FDMDemo_** har anropats
* Sidkomponenten anropade **_fdmdemo_**
* Inkluderade vårt anpassade jsp med sidkomponenten
* Kopplade den adaptiva formulärmallen till sidkomponenten

Genom att göra detta kommer vår kod i den anpassade jsp endast att köras när anpassningsbara formulär baserade på den här anpassade mallen återges

* [Importera paketet](assets/template-page-component.zip) med [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
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
