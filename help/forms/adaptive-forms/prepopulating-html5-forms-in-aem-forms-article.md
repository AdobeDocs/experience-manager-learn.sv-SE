---
title: PreFyll i HTML5 Forms med dataattribut.
description: Fylla i HTML5-formulär genom att hämta data från backend-källan.
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: ab0f5282-383b-4be6-9c57-cded6ab37528
last-substantial-update: 2020-01-09T00:00:00Z
duration: 94
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '449'
ht-degree: 0%

---

# PrePopulate HTML5 Forms using data attribute {#prepopulate-html-forms-using-data-attribute}


XDP-mallar som återges i HTML-format med AEM Forms kallas HTML5 eller Mobile Forms. Ett vanligt användningssätt är att fylla i dessa formulär i förväg när de återges.

Det finns två sätt att sammanfoga data med xdp-mallen när den återges som HTML.

**dataRef**: Du kan använda parametern dataRef i URL:en. Den här parametern anger den absoluta sökvägen för den datafil som sammanfogas med mallen. Den här parametern kan vara en URL till en vilotjänst som returnerar data i XML-format.

**data**: Den här parametern anger de UTF-8-kodade databyte som sammanfogas med mallen. Om den här parametern anges ignorerar HTML5-formuläret parametern dataRef. Vi rekommenderar att du använder datametoden som bästa praxis.

Det rekommenderade sättet är att ange dataattributet i begäran med de data som du vill fylla i formuläret i förväg.

slingRequest.setAttribute(&quot;data&quot;, innehåll);

I det här exemplet ställer vi in data-attributet med innehållet. Innehållet representerar de data som du vill fylla i formuläret i förväg. Vanligtvis hämtar du innehållet genom att göra ett REST-anrop till en intern tjänst.

För att uppnå detta måste du skapa en anpassad profil. Information om hur du skapar en anpassad profil finns tydligt dokumenterad i [AEM Forms-dokumentation här](https://helpx.adobe.com/aem-forms/6/html5-forms/custom-profile.html).

När du har skapat din anpassade profil skapar du sedan en JSP-fil som hämtar data genom att anropa ditt serverdelssystem. När data har hämtats använder du slingRequest.setAttribute(&quot;data&quot;, innehåll); för att fylla i formuläret i förväg

När XDP-filen återges kan du även skicka vissa parametrar till xdp och utifrån parameterns värde kan du hämta data från backend-systemet.

[Den här URL:en har en name-parameter](http://localhost:4502/content/dam/formsanddocuments/PrepopulateMobileForm.xdp/jcr:content?name=john)

Den JSP som du skriver har åtkomst till name-parametern via request.getParameter(&quot;name&quot;). Du kan sedan skicka värdet för den här parametern till backend-processen för att hämta nödvändiga data.
Följ stegen nedan för att få den här funktionen att fungera i ditt system:

* [Hämta och importera resurser till AEM med pakethanteraren](assets/prepopulatemobileform.zip)
Paketet installerar följande

   * CustomProfile
   * Exempel på XDP
   * Exempel på POSTENS slutpunkt som returnerar data för att fylla i formuläret

>[!NOTE]
>
>Om du vill fylla i formuläret genom att anropa workbench-processen kanske du vill inkludera callWorkbenchProcess.jsp i /apps/AEMFormsDemoListings/customprofiles/PrepopulateForm/html.jsp i stället för setdata.jsp

* [Peka din favoritwebbläsare till denna URL](http://localhost:4502/content/dam/formsanddocuments/PrepopulateMobileForm.xdp/jcr:content?name=Adobe%20Systems). Formuläret ska fyllas i i förväg med värdet för name-parametern
