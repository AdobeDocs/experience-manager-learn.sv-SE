---
title: Skriva en anpassad sändning i AEM Forms
description: Ett snabbt och enkelt sätt att skapa en egen anpassad inskickningsåtgärd för anpassat formulär
feature: Adaptive Forms
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 64b586a6-e9ef-4a3d-8528-55646ab03cc4
last-substantial-update: 2021-04-09T00:00:00Z
duration: 51
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '232'
ht-degree: 0%

---

# Skriva en anpassad sändning i AEM Forms {#writing-a-custom-submit-in-aem-forms}

Ett snabbt och enkelt sätt att skapa en egen anpassad inskickningsåtgärd för anpassat formulär

>[!NOTE]
>Koden i den här artikeln fungerar inte med grundläggande komponentbaserade adaptiva formulär.
>[Motsvarande artikel för grundläggande komponentbaserad adaptiv form finns här](https://experienceleague.adobe.com/docs/experience-manager-learn/cloud-service/forms/custom-submit-headless-forms/custom-submit-service.html?lang=sv-SE)


I den här artikeln får du hjälp med att skapa en anpassad sändningsåtgärd för hantering av adaptiv inlämning av Forms.

* Logga in på crx
* Skapa en nod av typen&quot;sling :folder&quot; under program. Anropa den här noden CustomSubmitHelpx.
* Spara den nyskapade noden.
* Lägg till följande tre egenskaper i den nya noden

| Egenskapsnamn | Egenskapsvärde |
|----------------    | ---------------------------------|
| guideComponentType | fd/af/components/guidepittype |
| guideDataModel | xfa,xsd,grundläggande |
| jcr:description | CustomSubmitHelp |


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
* Lägg till följande kod i filen

```java
    <%@include file="/libs/fd/af/components/guidesglobal.jsp"%>

    <%@page import="org.slf4j.LoggerFactory" %>

    <%@page import="org.slf4j.Logger" %>

    <input type="hidden" id="useSignedPdf" name="_useSignedPdf" value=""/>;
```

* Spara ändringarna

Nu ska du se&quot;CustomSubmitHelpx&quot; i skicka-åtgärderna i ditt adaptiva formulär som i den här bilden.

![Anpassat formulär med anpassad sändning](assets/capture-2.gif)
