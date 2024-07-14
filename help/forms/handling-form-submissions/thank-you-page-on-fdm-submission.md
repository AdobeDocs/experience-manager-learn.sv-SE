---
title: Visa överförings-ID för formulärinlämning
description: Visa svaret på en formulärdatamodell som skickas på din tacksida
feature: Adaptive Forms
doc-type: article
version: 6.4,6.5
topic: Development
role: Developer
level: Beginner
jira: KT-13900
last-substantial-update: 2023-09-09T00:00:00Z
exl-id: 18648914-91cc-470d-8f27-30b750eb2f32
duration: 72
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '330'
ht-degree: 0%

---

# Anpassa tacksidan

När du skickar ett anpassat formulär till en REST-slutpunkt vill du visa ett bekräftelsemeddelande som informerar användaren om att formuläröverföringen lyckades. POSTENS svar innehåller information om inlämnings-ID och ett väldesignat bekräftelsemeddelande innehåller inlämnings-ID som bidrar till en bättre användarupplevelse. Svaret kan visas på tacksidan som är konfigurerad med ditt adaptiva formulär.

Följande skärmbild visar att ett formulär skickas med åtgärden Skicka i formulärdatamodell med en tacksida konfigurerad

![tacksida](./assets/thank-you-page-fdm-submit.png)

POSTEN för en formulärdatamodell returnerar alltid ett JSON-objekt i svaret. Denna JSON är tillgänglig på Tack-sidans URL som en frågeparameter med namnet _fdmSubmitResult_. Du kan tolka den här frågeparametern och visa JSON-elementen på tacksidan.
Följande exempelkod tolkar JSON-svaret för att extrahera värdet för nummerfältet. Lämplig XML skapas sedan och skickas i slingRequest för att fylla i formuläret. Den här koden skrivs vanligtvis i jsp för den sidkomponent som är kopplad till mallen Adaptivt formulär.

```java
if(request.getParameter("fdmSubmitResult")!=null)
{
    String fdmSubmitResult =  request.getParameter("fdmSubmitResult");
    String status = request.getParameter("status");
    com.google.gson.JsonObject jsonObject = com.google.gson.JsonParser.parseString(fdmSubmitResult).getAsJsonObject();
    String caseNumber = jsonObject.get("result").getAsJsonObject().get("number").getAsString();
    slingRequest.setAttribute("data","<afData><afUnboundData><data><caseNumber>"+caseNumber+"</caseNumber><status>"+status+"</status></data></afUnboundData></afData>");
}
```

Vi rekommenderar att du baserar din tack-sida på en ny adaptiv formulärmall där du kan skriva den anpassade koden för att extrahera svaret från frågeparametrarna.

## Testa lösningen

Skapa ett adaptivt formulär och konfigurera för att skicka formuläret med formulärdatamodellens överföringsåtgärd.
[Distribuera exempelmallen för anpassningsbara formulär](assets/thank-you-page-template.zip)
Skapa ett tackformulär baserat på den här mallen
Koppla den här tacksidan till huvudformuläret
Ändra jsp-koden i [ createXml.jsp ](http://localhost:4502/apps/thank-you-page-template/component/page/thankyoupage/createxml.jsp) för att skapa den XML som behövs för att förifylla ditt adaptiva formulär.
Förhandsgranska och skicka in ditt anpassningsbara formulär.
Tacka-sidan ska visas och fyllas i i förväg med data som anges i XML
