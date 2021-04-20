---
title: Öppnar användargränssnittet för agenten när POST skickas
seo-title: Öppnar användargränssnittet för agenten när POST skickas
description: Detta är en del av en självstudiekurs i flera steg som du kan använda för att skapa ditt första interaktiva kommunikationsdokument för tryckkanalen. I den här delen startar vi gränssnittet för agenten för att skapa ad hoc-korrespondens när formulär skickas.
seo-description: Detta är en del av en självstudiekurs i flera steg som du kan använda för att skapa ditt första interaktiva kommunikationsdokument för tryckkanalen. I den här delen startar vi gränssnittet för agenten för att skapa ad hoc-korrespondens när formulär skickas.
uuid: 96f34986-a5c3-400b-b51b-775da5d2cbd7
feature: Interactive Communication
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.4,6.5
kt: 6168
thumbnail: 40122.jpg
topic: Development
role: Developer
level: Intermediate
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '369'
ht-degree: 0%

---


# Öppnar användargränssnittet för agenten när POST skickas

I den här delen startar vi gränssnittet för agenten för att skapa ad hoc-korrespondens när formulär skickas.

I den här artikeln får du hjälp att gå igenom de steg som ingår i gränssnittet för att öppna agentens användargränssnitt när du skickar ett formulär. Ett typiskt användningsexempel är att kundtjänstagenten fyller i ett formulär med vissa indataparametrar och att agenten för formulärinlämning öppnas med data förifyllda från förifyllningstjänsten för formulärdatamodellen. Indataparametrarna till förifyllningstjänsten för formulärdatamodellen extraheras från formuläröverföringen.

I följande video visas exempel

>[!VIDEO](https://video.tv.adobe.com/v/40122/?quality=9&learn=on)

```java
String accountNumber = request.getParameter("accountnumber"))
ParameterMap parameterMap = new ParameterMap();
RequestParameter icLetterId[] = new RequestParameter[1];
icLetterId[0] = new FormFieldRequestParameter("/content/dam/formsanddocuments/retirementstatementprint");
parameterMap.put("documentId", icLetterId);
RequestParameter Random[] = new RequestParameter[1];
Random[0] = new FormFieldRequestParameter("209457");
parameterMap.put("Random", Random);
Map map = new HashMap();
map.put("accountnumber",accountNumber);
slingRequest.setAttribute("paramMap",map);
CustomParameterRequest wrapperRequest = new CustomParameterRequest(slingRequest,parameterMap,"GET");
wrapperRequest.getRequestDispatcher("/aem/forms/createcorrespondence.html").include(wrapperRequest, response);
```

Rad 1: Hämta kontonumret från begärandeparametern

Rad 2-8: Skapa parametermappning och ange lämpliga nycklar och värden för att återspegla documentId,Random.

Rad 9-10: Skapa ett annat kartobjekt för indataparametern som är definierad i formulärdatamodellen.

Rad 11: Ange attributet &quot;paramMap&quot; för slingRequest

Rad 12-13: Vidarebefordra begäran till servern

Testa den här funktionen på servern

* [Importera och installera resurser som är relaterade till den här artikeln med hjälp av pakethanteraren.](assets/launch-agent-ui.zip)
* [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
* Sök efter _Adobe Granite CSRF-filter_
* Lägg till _/content/getprintchannel_ i Uteslutna sökvägar
* Spara ändringarna.
* [Öppna POST.jsp](http://localhost:4502/apps/AEMForms/openprintchannel/POST.jsp). Kontrollera att strängen som skickas till FormFieldRequestParameter är ett giltigt documentId.(Rad 19).
* [Öppna ](http://localhost:4502/content/OpenPrintChannel.html) webbsidan, ange kontonummer och skicka formuläret.
* Användargränssnittet för agenten ska öppnas med data som är förifyllda och specifika för det kontonummer som anges i formuläret.

>[!NOTE]
>
>Kontrollera att formulärdatamodellens Get-åtgärdsparameter är bunden till Request Attribute med namnet &quot;accountNumber&quot; för att detta ska fungera. Om du ändrar namnet på bindningsvärdet till något annat namn måste ändringen återspeglas på rad 25 i POST.jsp

