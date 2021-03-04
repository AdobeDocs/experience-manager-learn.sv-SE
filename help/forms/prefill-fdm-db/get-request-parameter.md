---
title: Hämta begäranparameter
description: Åtkomst till begärandeparametern för en formulärdatamodell förifyllningstjänst
feature: adaptiva formulär
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5815
thumbnail: kt-5815.jpg
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '180'
ht-degree: 0%

---

# Hämta begäranparameter

## Hämta empID-parameter

Nästa steg är att få åtkomst till parametern empID från URL:en. Värdet på parametern empID-begäran skickas sedan till **_get_**-tjänståtgärden för formulärdatamodellen.
För kursen har vi skapat och tillhandahållit följande

* Adaptiv formulärmall med namnet **_FDMDemo_**
* Page Component called **_fdmdemo_**
* Inkluderade vårt anpassade jsp med sidkomponenten
* Kopplade den adaptiva formulärmallen till sidkomponenten

Genom att göra detta kommer vår kod i den anpassade jsp endast att köras när anpassningsbara formulär som är baserade på den här anpassade mallen återges

* [Importera ](assets/template-page-component.zip) paketet med hjälp av  [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
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
