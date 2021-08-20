---
title: Förifyll HTML5 Forms med hjälp av dataattribut.
description: Fylla i HTML5-formulär genom att hämta data från backend-källan.
feature: Adaptiv Forms
version: 6.3,6.4,6.5.
topic: Utveckling
role: Developer
level: Experienced
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '497'
ht-degree: 0%

---


# Förifyll HTML5 Forms med dataattribut {#prepopulate-html-forms-using-data-attribute}

På sidan [AEM Forms samples](https://forms.enablementadobe.com/content/samples/samples.html?query=0) finns en länk till en live-demo av den här funktionen.

XDP-mallar som återges i HTML-format med AEM Forms kallas HTML5 eller Mobile Forms. Ett vanligt användningssätt är att fylla i dessa formulär i förväg när de återges.

Det finns två sätt att sammanfoga data med xdp-mallen när den återges som HTML.

**dataRef**: Du kan använda parametern dataRef i URL:en. Den här parametern anger den absoluta sökvägen för den datafil som sammanfogas med mallen. Den här parametern kan vara en URL till en vilotjänst som returnerar data i XML-format.

**data**: Den här parametern anger de UTF-8-kodade databyte som sammanfogas med mallen. Om den här parametern anges ignorerar HTML5-formuläret parametern dataRef. Vi rekommenderar att du använder datametoden som bästa praxis.

Det rekommenderade sättet är att ange dataattributet i begäran med de data som du vill fylla i formuläret i förväg.

slingRequest.setAttribute(&quot;data&quot;, innehåll);

I det här exemplet ställer vi in data-attributet med innehållet. Innehållet representerar de data som du vill fylla i formuläret i förväg. Vanligtvis hämtar du innehållet genom att göra ett REST-anrop till en intern tjänst.

För att uppnå detta måste du skapa en anpassad profil. Mer information om hur du skapar en anpassad profil finns i [AEM Forms-dokumentationen här](https://helpx.adobe.com/aem-forms/6/html5-forms/custom-profile.html).

När du har skapat din anpassade profil skapar du sedan en JSP-fil som hämtar data genom att anropa ditt serverdelssystem. När data har hämtats använder du slingRequest.setAttribute(&quot;data&quot;, innehåll); fylla i formuläret i förväg

När XDP-filen återges kan du även skicka vissa parametrar till xdp och utifrån parameterns värde kan du hämta data från backend-systemet.

[Den här URL:en har en name-parameter](http://localhost:4502/content/dam/formsanddocuments/PrepopulateMobileForm.xdp/jcr:content?name=john)

Den JSP som du skriver har åtkomst till name-parametern via request.getParameter(&quot;name&quot;). Du kan sedan skicka värdet för den här parametern till backend-processen för att hämta nödvändiga data.
Följ stegen nedan för att få den här funktionen att fungera i ditt system:

* [Hämta och importera resurserna till AEM med hjälp av ](assets/prepopulatemobileform.zip)
pakethanterarenPaketet installerar följande

   * CustomProfile
   * Exempel på XDP
   * Exempel på POSTENS slutpunkt som returnerar data för att fylla i formuläret

>[!NOTE]
>
>Om du vill fylla i formuläret genom att anropa workbench-processen kan du inkludera callWorkbenchProcess.jsp i /apps/AEMFormsDemoListings/customprofiles/PrepopulateForm/html.jsp i stället för setdata.jsp

* [Peka din favoritwebbläsare mot den här URL:en](http://localhost:4502/content/dam/formsanddocuments/PrepopulateMobileForm.xdp/jcr:content?name=Adobe%20Systems). Formuläret ska fyllas i i förväg med värdet för name-parametern
