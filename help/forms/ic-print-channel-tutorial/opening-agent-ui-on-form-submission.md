---
title: Öppnar användargränssnittet för agenten när POST skickas
description: Detta är en del av en självstudiekurs i flera steg som du kan använda för att skapa ditt första interaktiva kommunikationsdokument för tryckkanalen. I den här delen startar vi gränssnittet för agenten för att skapa ad hoc-korrespondens när formulär skickas.
feature: Interactive Communication
doc-type: Tutorial
version: 6.4,6.5
jira: KT-6168
thumbnail: 40122.jpg
topic: Development
role: Developer
level: Intermediate
exl-id: 509b4d0d-9f3c-46cb-8ef7-07e831775086
duration: 183
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '322'
ht-degree: 0%

---

# Öppnar användargränssnittet för agenten när POST skickas

I den här delen startar vi gränssnittet för agenten för att skapa ad hoc-korrespondens när formulär skickas.

I den här artikeln får du hjälp att gå igenom de steg som ingår i gränssnittet för att öppna agentens användargränssnitt när du skickar ett formulär. Ett typiskt användningsexempel är att kundtjänstagenten fyller i ett formulär med vissa indataparametrar och att agenten för formulärinlämning öppnas med data förifyllda från förifyllningstjänsten för formulärdatamodellen. Indataparametrarna till förifyllningstjänsten för formulärdatamodellen extraheras från formuläröverföringen.

I följande videofilm visas exempel på användning

>[!VIDEO](https://video.tv.adobe.com/v/40122?quality=12&learn=on)

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

Rad 1: Hämta kontonumret från den begärande parametern

Rad 2-8: Skapa parametermappning och ange lämpliga nycklar och värden för att återspegla documentId,Random.

Rad 9-10: Skapa ett annat Map-objekt för indataparametern som definieras i formulärdatamodellen.

Rad 1: Ange attributet slingRequest &quot;paramMap&quot;

Rad 12-13: Vidarebefordra begäran till serverleten

Testa den här funktionen på servern

* [Importera och installera resurser som är relaterade till den här artikeln med hjälp av pakethanteraren.](assets/launch-agent-ui.zip)
* [Logga in på configMgr](http://localhost:4502/system/console/configMgr)
* Sök efter _Adobe Granite CSRF-filter_
* Lägg till _/content/getprintchannel_ i de uteslutna banorna
* Spara ändringarna.
* [Öppna POST.jsp](http://localhost:4502/apps/AEMForms/openprintchannel/POST.jsp). Kontrollera att strängen som skickas till FormFieldRequestParameter är ett giltigt documentId.(Rad 19).
* [Öppna webbsidan](http://localhost:4502/content/OpenPrintChannel.html) och ange kontonummer och skicka in formuläret.
* Användargränssnittet för agenten ska öppnas med data som är förifyllda och specifika för det kontonummer som anges i formuläret.

>[!NOTE]
>
>Kontrollera att formulärdatamodellens Get-åtgärdsparameter är bunden till Request Attribute med namnet &quot;accountNumber&quot; för att detta ska fungera. Om du ändrar namnet på bindningsvärdet till något annat namn måste ändringen återspeglas på rad 25 i POST.jsp
