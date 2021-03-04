---
title: Använda setValue i AEM Forms-arbetsflödet
seo-title: Använda setValue i AEM Forms Workflow
description: Ange värdet för element i adaptiva Forms-inskickade data i AEM Forms OSGI
seo-description: Ange värdet för element i adaptiva Forms-inskickade data i AEM Forms OSGI
uuid: fe431e48-f05b-4b23-94d2-95d34d863984
feature: Adaptiv Forms
topics: developing
audience: implementer
doc-type: article
activity: setup
discoiquuid: dbd87302-f770-4e61-b5ad-3fc5831b4613
topic: Utveckling
role: Developer
level: Erfaren
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '552'
ht-degree: 0%

---


# Använda setValue i AEM Forms-arbetsflödet

Ange värdet för ett XML-element i adaptiva Forms-data i AEM Forms OSGI-arbetsflöde.

![SetValue](assets/setvalue.png)

Tidigare hade LiveCycle en inställd värdekomponent som gjorde att du kunde ange ett XML-elements värde.

Baserat på det här värdet kan du dölja/inaktivera vissa fält eller paneler i formuläret när formuläret fylls i med XML.

I AEM Forms OSGI måste vi skriva ett anpassat OSGi-paket för att ange värdet i XML. Paketet ingår i kursen.
Vi använder Processsteg i AEM arbetsflöde. Vi kopplar OSGi-paketet&quot;Set Value of Element in XML&quot; till det här steget.
Vi måste skicka två argument till det angivna värdepaketet. Det första argumentet är XPath för XML-elementet vars värde måste anges. Det andra argumentet är värdet som måste anges.
På skärmbilden ovan anger vi till exempel värdet för elementet initialStega till&quot;N&quot;.
Baserat på detta värde döljs eller visas vissa paneler i Adaptive Forms.
I det här exemplet har vi ett enkelt formulär för att ställa in tid för begäran. Initieraren av det här formuläret fyller i sitt namn och anger datum. När formuläret skickas går det till&quot;admin&quot; för granskning. När administratören öppnar formuläret inaktiveras fälten på den första panelen. Detta eftersom vi har angett värdet för det inledande stegelementet i XML till &quot;N&quot;.

Baserat på fältvärdet i det inledande steget visar vi den andra panelen där administratören kan godkänna eller avvisa begäran

Ta en titt på reglerna som ställts in mot fältet&quot;Time Off Requested by&quot; med regelredigeraren.

Så här distribuerar du resurserna på ditt lokala system:

* [Distribuera Developing with service user bundle](/help/forms/assets/common-osgi-bundles/DevelopingWithServiceUser.jar)

* [Distribuera exempelpaketet](/help/forms/assets/common-osgi-bundles/SetValueApp.core-1.0-SNAPSHOT.jar). Det här är det anpassade OSGI-paketet som gör att du kan ange värden för ett element i skickade XML-data

* [Hämta och extrahera innehållet i zip-filen](assets/setvalueassets.zip)
* Peka webbläsaren på [pakethanteraren](http://localhost:4502/crx/packmgr/index.jsp)
* Importera och installera setValueWorkflow.zip. Detta är en exempelarbetsflödesmodell.
* Peka webbläsaren på [Forms och Documents](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa | Filöverföring
* Överför TimeOfRequestForm.zip
* Öppna [TimeOffRequestform](http://localhost:4502/content/dam/formsanddocuments/timeoffapplication/jcr:content?wcmmode=disabled)
* Fyll i de tre obligatoriska fälten och skicka
* Logga in som &#39;admin&#39; i AEM(om du inte redan gjort det)
* Gå till [&quot;AEM Inkorg&quot;](http://localhost:4502/aem/inbox)
* Öppna formuläret&quot;Granskningstid av begäran&quot;
* Observera att fälten på den första panelen är inaktiverade. Det beror på att formuläret öppnas av granskaren. Lägg märke till att panelen för att godkänna eller avvisa begäran nu visas

>[!NOTE]
>
>Du kan aktivera felsökningsloggning genom att aktivera loggning för
>com.aemforms.setvalue.core.SetValueinXml
>genom att peka din webbläsare till http://localhost:4502/system/console/slinglog

>[!NOTE]
>
>Kontrollera att sökvägen till datafilen i det adaptiva formulärets överföringsalternativ är inställd på &quot;Data.xml&quot;. Detta beror på att processsteget söker efter filen Data.xml under nyttolastmappen
