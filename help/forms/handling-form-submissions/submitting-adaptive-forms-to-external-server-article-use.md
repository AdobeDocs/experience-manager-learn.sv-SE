---
title: Skicka anpassat formulär till extern server
seo-title: Skicka anpassat formulär till extern server
description: Skicka anpassat formulär till REST-slutpunkt som körs på en extern server
seo-description: Skicka anpassat formulär till REST-slutpunkt som körs på en extern server
uuid: 1a46e206-6188-4096-816a-d59e9fb43263
feature: Adaptive Forms
topics: developing
audience: implementer
doc-type: article
activity: setup
version: 6.3,6.4,6.5
discoiquuid: 9e936885-4e10-4c05-b572-b8da56fcac73
topic: Development
role: Developer
level: Beginner
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '367'
ht-degree: 0%

---


# Skicka anpassat formulär till extern server {#submitting-adaptive-form-to-external-server}

Använd åtgärden Skicka till REST-slutpunkt för att skicka skickade data till en REST-URL. URL:en kan vara en intern (servern som formuläret återges på) eller en extern server.

Vanligtvis vill man skicka formulärdata till en extern server för vidare bearbetning.

Om du vill skicka data till en intern server anger du en sökväg till resursen. Data bokförs som resurssökväg. Till exempel &lt;/content/restEndPoint> . För sådana efterfrågningar används autentiseringsinformationen i förfrågan.

Ange en URL om du vill skicka data till en extern server. URL-adressen har formatet <http://host:port/path_to_rest_end_point>. Kontrollera att du har konfigurerat sökvägen så att den hanterar POSTENS begäran anonymt.

I den här artikeln har jag skrivit en enkel krigsfil som kan distribueras på din tomcat-instans. Om du antar att din tomcat körs på port 8080 kommer POST-URL:en att vara

<http://localhost:8080/AemFormsEnablement/HandleFormSubmission>

när du konfigurerar ditt adaptiva formulär att skicka till den här slutpunkten, formulärdata och eventuella bilagor som kan extraheras i serverleten med följande kod

```java
System.out.println("form was submitted");
Part attachment = request.getPart("attachments");
if(attachment!=null)
{
    System.out.println("The content type of the attachment added is "+attachment.getContentType());
}
Enumeration<String> params = request.getParameterNames();
while(params.hasMoreElements())
{
String paramName = params.nextElement();
System.out.println("The param Name is "+paramName);
String data = request.getParameter(paramName);System.out.println("The data  is "+data);
}
```

![skicka ](assets/formsubmission.gif)
formulärGör följande för att testa detta på servern

1. Installera Tomcat om du inte redan har det. [Instruktioner för att installera tomcat finns här](https://helpx.adobe.com/experience-manager/kt/forms/using/preparing-datasource-for-form-data-model-tutorial-use.html)
1. Hämta den [zip-fil](assets/aemformsenablement.zip) som är associerad med den här artikeln. Zippa upp filen för att få krigsfilen.
1. Distribuera krigsfilen på tomcat-servern.
1. Skapa ett enkelt adaptivt formulär med en bifogad fil och konfigurera dess skicka-åtgärd enligt skärmbilden ovan. POSTENS URL är <http://localhost:8080/AemFormsEnablement/HandleFormSubmission>. Om AEM och tomcat inte körs på localhost ska du ändra URL:en i enlighet med detta.
1. Om du vill att data från flera delar ska kunna skickas till tomcat ska du lägga till följande attribut i elementet context i &lt;tomcatInstallDir>\conf\context.xml och starta om Tomcat-servern.
1. **&lt;context allowCasualMultipartParsing=&quot;true&quot;>**
1. Förhandsgranska ditt adaptiva formulär, lägg till en bilaga och skicka. Kontrollera om det finns meddelanden i tomcat-konsolfönstret.

