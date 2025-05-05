---
title: Fyll i Adaptiv Forms med frågeparametrar.
description: Fyll i Adaptiv Forms med data från frågeparametrar.
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
jira: KT-11470
last-substantial-update: 2020-11-12T00:00:00Z
exl-id: 14ac6ff9-36b4-415e-a878-1b01ff9d3888
duration: 49
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '199'
ht-degree: 0%

---

# PreFyll i anpassad Forms med frågeparametrar

En av våra kunder behövde fylla i anpassningsbara formulär med frågeparametrarna. I följande url är fälten FirstName och LastName i det adaptiva formuläret inställda på John respektive Doe

```html
https://forms.enablementadobe.com/content/forms/af/testingxml.html?FirstName=John&LastName=Doe
```

För att uppnå detta skapades en ny adaptiv formulärmall som är kopplad till en sidkomponent. I den här sidkomponenten har vi en jsp som kan hämta information om frågeparametrarna och skapa en XML-struktur som kan användas för att fylla i det adaptiva formuläret.

Information om hur du skapar en ny mall och sidkomponent för adaptiva formulär [förklaras i den här videon.](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/storing-and-retrieving-form-data/part5.html?lang=sv-SE)

Följande kod används på jsp-sidan

```java
java.util.Enumeration enumeration = request.getParameterNames();
String dataXml = "<afData><afUnboundData><data>";
while (enumeration.hasMoreElements())
{
   String parameterName = (String) enumeration.nextElement();
   dataXml = dataXml + "<" + parameterName + ">" + request.getParameter(parameterName) + "</" + parameterName + ">";

}

dataXml = dataXml + "</data></afUnboundData></afData>";
//System.out.println("The data xml is "+dataXml);
slingRequest.setAttribute("data", dataXml);
```

>[!NOTE]
>
>Om ditt formulär använder ett schema kommer XML-strukturen att vara annorlunda och du måste skapa XML utifrån detta.


## Distribuera resurserna på ditt system

* [Hämta och installera den adaptiva formulärmallen med hjälp av Package Manager](assets/populate-with-xml.zip)
* [Hämta och installera exempelformuläret för adaptiv installation](assets/populate-af-with-query-paramters-form.zip)

* [Förhandsgranska det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/testingxml/jcr:content?wcmmode=disabled&amp;FirstName=John&amp;LastName=Doe)
Du bör se det adaptiva formuläret ifyllt med värdet John och Doe
