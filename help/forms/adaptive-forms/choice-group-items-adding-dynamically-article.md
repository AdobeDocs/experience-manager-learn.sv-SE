---
title: Lägga till objekt i urvalsgruppskomponenten
description: Lägg till objekt i urvalsgruppskomponenten dynamiskt
feature: Adaptive Forms
version: 6.5
topic: Development
role: User
level: Beginner
exl-id: 8fbea634-7949-417f-a4d6-9e551fff63f3
last-substantial-update: 2021-09-10T00:00:00Z
duration: 337
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '456'
ht-degree: 0%

---

# Lägga till objekt dynamiskt i alternativgruppskomponenten

I AEM Forms 6.5 introducerades möjligheten att lägga till objekt dynamiskt i en adaptiv Forms-valgruppkomponent som CheckBox, Radio Button och Image List.


Du kan lägga till objekt med den visuella redigeraren och kodredigeraren beroende på hur du använder dem.

**Med den visuella redigeraren:** Du kan fylla i alternativgruppens objekt från resultatet av ett funktionsanrop eller ett serviceanrop. Du kan till exempel ställa in objekten i urvalsgruppen genom att använda svaret på ett REST API-anrop.

På skärmbilden nedan ställer vi in alternativen för låneperiod(år) till resultatet av ett serviceanrop som kallas getLoanPeriods.

![Regelredigeraren](assets/ruleeditor.png)

**Använda kodredigeraren**: När du vill ange objekten i alternativgruppen dynamiskt baserat på de värden som anges i formuläret. Följande kodfragment ställer till exempel in kryssrutans objekt på de värden som anges i den sökandes namn och i makens fält i det adaptiva formuläret.

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
* Klicka på Skapa | Filöverföring och överföring av filen du laddade ned i föregående steg
* [Förhandsgranska formulären](http://localhost:4502/content/dam/formsanddocuments/simpleform/jcr:content?wcmmode=disabled)
* Ange den sökandes namn och välj civilstånd till gift
* Ange makens namn
* Klicka på Nästa
* Kryssrutan ska fyllas i med den sökandes namn och med makens namn om äktenskapsstatusen är gift

**Använda den visuella redigeraren för att lägga till objekt**

* [Hämta resurserna](assets/usingthevisualeditor.zip)
* Installera Tomcat om du inte redan har det. [Instruktioner för att installera tomcat finns här](https://experienceleague.adobe.com/docs/experience-manager-learn/forms/ic-print-channel-tutorial/introduction.html)
* [Distribuera filen SampleRest.war som finns i zip-filen i din Tomcat](assets/sample-rest.zip)
* [Öppna Forms och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa | Filöverföring och överföring av filen du laddade ned i föregående steg
* [Förhandsgranska formulären](http://localhost:4502/content/dam/formsanddocuments/amortizationschedule/jcr:content?wcmmode=disabled)
* Ange lånebelopp och tabba utanför fältet. Detta utlöser regeln som visar fältet för låneperiod.
* Välj lämplig låneperiod (artiklarna för låneperioden fylls i från resten av samtalet)
* Välj räntesatsen och klicka på&quot;Get Amortization Schedule&quot;
* Avskrivningstabellen ska fyllas i. Avskrivningsschemat hämtas med ett REST-anrop.

>[!NOTE]
> Det antas att tomcat körs på port 8080 och AEM på port 4502
