---
title: Skriva en anpassad sändning i AEM Forms
seo-title: Skriva en anpassad sändning i AEM Forms
description: Ett snabbt och enkelt sätt att skapa en egen anpassad inskickningsåtgärd för anpassat formulär
seo-description: Ett snabbt och enkelt sätt att skapa en egen anpassad inskickningsåtgärd för anpassat formulär
feature: Adaptiv Forms
topics: integrations
audience: developer
doc-type: article
activity: implement
version: 6.3,6.4,6.5
uuid: a26db0b9-7db4-4e80-813d-5c0438fabd1e
discoiquuid: 28611011-2ff9-477e-b654-e62e7374096a
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '232'
ht-degree: 2%

---


# Skriva en anpassad sändning i AEM Forms {#writing-a-custom-submit-in-aem-forms}

Ett snabbt och enkelt sätt att skapa en egen anpassad inskickningsåtgärd för anpassat formulär

I den här artikeln får du hjälp med att skapa en anpassad sändningsåtgärd för hantering av adaptiv inlämning av Forms.

* Logga in på crx
* Skapa en nod av typen &quot;sling :folder&quot; under program. Anropa den här noden CustomSubmitHelpx.
* Spara den nyskapade noden.
* Lägg till följande två egenskaper i den nya noden
* PropertyName       | Egenskapsvärde
* guideComponentType | fd/af/components/guidepittype
* guideDataModel     | xfa,xsd,grundläggande
* jcr:description   | CustomSubmitHelpx
* Spara ändringarna
* Skapa en ny fil med namnet post.POST.jsp under noden CustomSubmitHelpx. När ett anpassat formulär skickas anropas denna JSP. Du kan skriva JSP-koden enligt dina önskemål i den här filen. Följande kod vidarebefordrar begäran till servern.

```java
<%
%><%@include file="/libs/foundation/global.jsp"%>
<%@taglib prefix="cq" uri="http://www.day.com/taglibs/cq/1.0"%>
<%@ page import="org.apache.sling.api.request.RequestParameter,com.day.cq.wcm.api.WCMMode,com.adobe.forms.common.submitutils.CustomParameterRequest,com.adobe.aemds.guide.submitutils.*" %>

<%@ page import="org.apache.sling.api.request.RequestParameter,com.day.cq.wcm.api.WCMMode" %>
<%@page session="false" %>
<%

   com.adobe.aemds.guide.utils.GuideSubmitUtils.setForwardPath(slingRequest,"/bin/storeafsubmission",null,null);

%>
```

* Skapa en fil med namnet addfields.jsp under noden CustomSubmitHelpx. Den här filen ger dig åtkomst till det signerade dokumentet.
* Lägg till följande kod i den här filen

```java
    <%@include file="/libs/fd/af/components/guidesglobal.jsp"%>

    <%@page import="org.slf4j.LoggerFactory" %>

    <%@page import="org.slf4j.Logger" %>

    <input type="hidden" id="useSignedPdf" name="_useSignedPdf" value=""/>;
```

* Spara ändringarna

Nu ska du se&quot;CustomSubmitHelpx&quot; i skicka-åtgärderna i ditt adaptiva formulär som i den här bilden.

![Anpassat formulär med anpassad inskickning](assets/capture-2.gif)

