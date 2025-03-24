---
title: Skapa ny sidkomponent
description: Skapa en ny sidkomponent
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Experience Manager as a Cloud Service
topic: Integrations
jira: KT-13717
exl-id: 7469aa7f-1794-40dd-990c-af5d45e85223
duration: 67
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '273'
ht-degree: 0%

---

# Sidkomponent

En sidkomponent är en vanlig komponent som återger en sida. Vi ska skapa en ny sidkomponent och kommer att koppla den här sidkomponenten till en ny adaptiv formulärmall. Detta garanterar att koden bara körs när ett anpassningsbart formulär är baserat på just den här mallen.

## Skapa sidkomponent

Logga in på din lokala molnförberedda AEM Forms-instans. Skapa följande struktur under mappen Apps
![sidkomponent](./assets/page-component1.png)

1. Högerklicka på sidmappen och skapa en nod med namnet storeandfetch av typen cq:Component
1. Spara ändringarna
1. Lägg till följande egenskaper i noden `storeandfetch` och spara

| **Egenskapsnamn** | **Egenskapstyp** | **Egenskapsvärde** |
|-------------------------|-------------------|----------------------------------------|
| componentGroup | Sträng | dold |
| jcr:description | Sträng | Sidtyp för anpassad formulärmall |
| jcr:title | Sträng | Sida för anpassad formulärmall |
| sling:resourceSuperType | Sträng | `fd/af/components/page2/aftemplatedpage` |

Kopiera `/libs/fd/af/components/page2/aftemplatedpage/aftemplatedpage.jsp` och klistra in den under noden `storeandfetch`. Byt namn på `aftemplatedpage.jsp` till `storeandfetch.jsp`.

Öppna `storeandfetch.jsp` och lägg till följande rad:

```jsp
<cq:include script="azureportal.jsp"/>
```

under

```jsp
<cq:include script="fallbackLibrary.jsp"/>
```

Den färdiga koden ska se ut så här

```jsp
<cq:include script="fallbackLibrary.jsp"/>
<cq:include script="azureportal.jsp"/>
```

Skapa en fil med namnet azureportal.jsp under noden storeandfetch
kopiera följande kod till azureportal.jsp och spara ändringarna

```jsp
<%@page session="false" %>
<%@include file="/libs/fd/af/components/guidesglobal.jsp" %>
<%@ page import="org.apache.commons.logging.Log" %>
<%@ page import="org.apache.commons.logging.LogFactory" %>
<%
    if(request.getParameter("guid")!=null) {
            logger.debug( "Got Guid in the request" );
            String BlobId = request.getParameter("guid");
            java.util.Map paraMap = new java.util.HashMap();
            paraMap.put("BlobId",BlobId);
            slingRequest.setAttribute("paramMap",paraMap);
    } else {
            logger.debug( "There is no Guid in the request " );
    }            
%>
```

I den här koden hämtar vi värdet för begärandeparametern **guid** och lagrar den i en variabel som kallas BlobId. Detta BlobId skickas sedan till försäljningsbegäran med attributet paramMap. För att den här koden ska fungera antas det att du har ett formulär som är baserat på en Azure Storage-baserad formulärdatamodell och att lästjänsten för formulärdatamodellen är bunden till ett begärandeattribut som kallas BlobId, vilket visas i skärmbilden nedan.

![fdm-request-attribute](./assets/fdm-request-attribute.png)

### Nästa steg

[Koppla sidkomponenten till mallen](./associate-page-component.md)
