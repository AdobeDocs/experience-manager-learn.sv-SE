---
title: Skicka anpassat formulär till extern server
description: Skicka anpassat formulär till REST-slutpunkt som körs på en extern server
feature: Adaptive Forms
doc-type: article
version: 6.4,6.5
discoiquuid: 9e936885-4e10-4c05-b572-b8da56fcac73
topic: Development
role: Developer
level: Beginner
exl-id: 5363c3f7-9006-4430-b647-f3283a366a64
last-substantial-update: 2020-07-07T00:00:00Z
duration: 87
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '340'
ht-degree: 0%

---

# Skicka anpassat formulär till extern server {#submitting-adaptive-form-to-external-server}

Använd åtgärden Skicka till REST-slutpunkt för att skicka skickade data till en REST-URL. URL:en kan vara en intern (servern som formuläret återges på) eller en extern server.

Normalt vill man skicka blankettdata till en extern server för vidare bearbetning.

Om du vill skicka data till en intern server anger du en sökväg till resursen. Data bokförs som resurssökväg. Till exempel: &lt;/content restendpoint=&quot;&quot;> . För sådana efterfrågningar används autentiseringsinformationen i förfrågan.

Ange en URL om du vill skicka data till en extern server. URL-formatet är <http://host:port/path_to_rest_end_point>. Kontrollera att du har konfigurerat sökvägen så att den hanterar POSTENS begäran anonymt.

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

![formulärinlämning](assets/formsubmission.gif)
Gör så här för att testa detta på servern

1. Installera Tomcat om du inte redan har det. [Instruktioner för att installera tomcat finns här](https://helpx.adobe.com/experience-manager/kt/forms/using/preparing-datasource-for-form-data-model-tutorial-use.html)
1. Ladda ned [zip-fil](assets/aemformsenablement.zip) som är kopplad till den här artikeln. Zippa upp filen för att få krigsfilen.
1. Distribuera krigsfilen på tomcat-servern.
1. Skapa ett enkelt adaptivt formulär med en bifogad fil och konfigurera dess skicka-åtgärd enligt skärmbilden ovan. POSTENS URL är <http://localhost:8080/AemFormsEnablement/HandleFormSubmission>. Om AEM och tomcat inte körs på localhost ska du ändra URL:en i enlighet med detta.
1. Om du vill att data från flera formulär ska kunna skickas till tomcat ska du lägga till följande attribut i elementet context i &lt;tomcatinstalldir>\conf\context.xml och starta om Tomcat-servern.
1. **&lt;Context allowCasualMultipartParsing=&quot;true&quot;>**
1. Förhandsgranska ditt adaptiva formulär, lägg till en bilaga och skicka. Kontrollera om det finns meddelanden i tomcat-konsolfönstret.
