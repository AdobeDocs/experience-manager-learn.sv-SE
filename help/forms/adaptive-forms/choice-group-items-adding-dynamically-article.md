---
title: Lägga till objekt i urvalsgruppskomponenten
seo-title: Lägga till objekt i urvalsgruppskomponenten
description: Lägg till objekt i urvalsgruppskomponenten dynamiskt
seo-description: Lägg till objekt i urvalsgruppskomponenten dynamiskt
feature: adaptiva formulär
topics: authoring
audience: developer
doc-type: tutorial
activity: understand
version: 6.5
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '528'
ht-degree: 0%

---



# Lägga till objekt dynamiskt till urvalskomponenten för grupp

I AEM Forms 6.5 introducerades möjligheten att lägga till objekt dynamiskt i en adaptiv Forms-valgruppkomponent som CheckBox, Radio Button och Image List.

[Den här funktionen är tillgänglig live på Samples Server](https://forms.enablementadobe.com/content/samples/samples.html?query=0). Sök efter objektkort för dynamiska kryssrutor och klicka på Testa.


Du kan lägga till objekt med den visuella redigeraren och kodredigeraren beroende på hur du använder dem.

**Använda den visuella redigeraren:** Du kan fylla i alternativgruppens objekt från resultatet av ett funktionsanrop eller ett serviceanrop. Du kan till exempel ställa in objekten i urvalsgruppen genom att använda svaret på ett REST API-anrop.

På skärmbilden nedan ställer vi in alternativen för låneperiod(år) till resultatet av ett serviceanrop som kallas getLoanPeriods.

![Regelredigeraren](assets/ruleeditor.png)

**Använda kodredigeraren**: När du vill ange objekten i urvalsgruppen dynamiskt baserat på de värden som anges i formuläret. Följande kodfragment ställer till exempel in kryssrutans objekt på de värden som anges i den sökandes namn och i makens fält i det adaptiva formuläret.

I kodfragmentet anger vi objekten för WorkingMembers, som är en kryssrutekomponent. Arrayen för objekten byggs dynamiskt genom att hämta värdena för sökandeName- och make-textfälten i de adaptiva formulären

```javascript
 
 if(MaritalStatus.value=="Married")
  {
WorkingMembers.items =["spouse="+spouse.value,"applicant="+applicantName.value];
  }
else
  {
    WorkingMembers.items =["applicant="+applicantName.value];
  }
```

De inlämnade uppgifterna är följande

```xml
<afUnboundData>

<data>

<applicantName>John Jacobs</applicantName>

<MaritalStatus>Married</MaritalStatus>

<spouse>Gloria Rios</spouse>

<WorkingMembers>spouse,applicant</WorkingMembers>

</data>

</afUnboundData>
```

**Lägga till objekt med regelredigeraren**

>[!VIDEO](https://video.tv.adobe.com/v/26847?quality=12&learn=on)

**Lägga till objekt med kodredigeraren**

>[!VIDEO](https://video.tv.adobe.com/v/26848?quality=12&learn=on)

Så här provar du det på datorn:

**Lägga till objekt med kodredigeraren**

* [Hämta resurserna](assets/usingthecodeeditor.zip)
* [Öppna Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa | Filöverföring och ladda upp filen som du laddade ned i föregående steg
* [Förhandsgranska formulären](http://localhost:4502/content/dam/formsanddocuments/simpleform/jcr:content?wcmmode=disabled)
* Ange den sökandes namn och välj civilstånd till gift
* Ange makens namn
* Klicka på Nästa
* Kryssrutan ska fyllas i med den sökandes namn och med makens namn om äktenskapsstatusen är gift

**Använda den visuella redigeraren för att lägga till objekt**

* [Hämta resurserna](assets/usingthevisualeditor.zip)
* Installera Tomcat om du inte redan har det. [Instruktioner för att installera tomcat finns här](https://docs.adobe.com/content/help/en/experience-manager-learn/forms/ic-print-channel-tutorial/introduction.html)
* [Distribuera filen SampleRest.war i Tomcat](https://forms.enablementadobe.com/content/DemoServerBundles/SampleRest.war)
* [Öppna Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa | Filöverföring och ladda upp filen som du laddade ned i föregående steg
* [Förhandsgranska formulären](http://localhost:4502/content/dam/formsanddocuments/amortizationschedule/jcr:content?wcmmode=disabled)
* Ange lånebelopp och tabba utanför fältet. Detta aktiverar regeln som visar fältet för låneperiod.
* Välj lämplig låneperiod (artiklarna för låneperioden fylls i från resten av samtalet)
* Välj räntesatsen och klicka på&quot;Get Amortization Schedule&quot;
* Avskrivningstabellen ska fyllas i. Avskrivningsschemat hämtas med ett REST-anrop.

>[!NOTE]
> Det antas att tomcat körs på port 8080 och AEM på port 4502
