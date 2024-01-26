---
title: Generera dokument för utskriftskanaler med bevakad mapp
description: Det här är en del av 10 steg-självstudiekursen för att skapa ditt första interaktiva kommunikationsdokument för tryckkanalen. I den här delen genererar vi dokument i tryckkanaler med hjälp av bevakade mappfunktioner.
feature: Interactive Communication
doc-type: Tutorial
version: 6.4,6.5
contentOwner: gbedekar
discoiquuid: 23fbada3-d776-4b77-b381-22d3ec716ae9
topic: Development
role: Developer
level: Beginner
exl-id: 9bb05c94-2a7b-4149-b567-186eb08b1c66
duration: 87
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '351'
ht-degree: 0%

---

# Generera dokument för utskriftskanaler med bevakad mapp

I den här delen genererar vi dokument i tryckkanaler med hjälp av bevakade mappfunktioner.

När du har skapat och testat ditt dokument för tryckkanaler behöver vi en mekanism för att generera dessa dokument i gruppläge eller on demand. Vanligtvis genereras den här typen av dokument i gruppläge och den vanligaste mekanismen är bevakad mapp.

När du konfigurerar en bevakad mapp i AEM associerar du ett ECMA-skript eller en Java-kod som körs när en fil släpps i den bevakade mappen. I den här artikeln fokuserar vi på ECMA-skript som genererar dokument för tryckkanaler och sparar dem i filsystemet.

Den bevakade mappkonfigurationen och ECMA-skriptet är en del av de resurser du importerade på [början av den här självstudien](introduction.md)

Indatafilen som släpps i den bevakade mappen har följande struktur. ECMA-skript läser kontonumren och genererar dokument för utskriftskanaler för vart och ett av dessa konton.

Mer information om ECMA-skriptet för att generera dokument finns i [referera till den här artikeln](/help/forms/interactive-communications/generating-interactive-communications-print-document-using-api-tutorial-use.md)

```xml
<accountnumbers>
 <accountnumber>509840</accountnumber>
 <accountnumber>948576</accountnumber>
 <accountnumber>398762</accountnumber>
 <accountnumber>291723</accountnumber>
 <accountnumber>291724</accountnumber>
 <accountnumber>291725</accountnumber>
 <accountnumber>291726</accountnumber>
 <accountnumber>291727</accountnumber>
</accountnumbers>
```

Följ stegen nedan för att generera dokument för utskriftskanaler med hjälp av bevakade mappfunktioner:

* [Följ stegen som anges i det här dokumentet](/help/forms/adaptive-forms/service-user-tutorial-develop.md)

* Logga in på crx och navigera till /etc/fd/watchfolder/scripts/PrintPDF.ecma

* Kontrollera att sökvägen till interactiveCommunicationsDocument pekar på rätt dokument som du vill skriva ut.( Rad 1)
* Notera saveLocation(Line 2).Du kan ändra den efter behov.
* Kontrollera att indataparametern för formulärdatamodellen är bunden till Request Attribute och att dess bindningsvärde är inställt på AccountNumber. Se skärmbilden nedan.
  ![förfrågan](assets/requestattributeprintchannel.gif)

* Skapa filen accountNumbers.xml med följande innehåll

```xml
<accountnumbers>
<accountnumber>1</accountnumber>
<accountnumber>100</accountnumber>
<accountnumber>101</accountnumber>
<accountnumber>1009</accountnumber>
<accountnumber>10009</accountnumber>
<accountnumber>11990</accountnumber>
</accountnumbers>
```

* Släpp XML-filen i C:\RenderPrintChannel\input

* Kontrollera pdf-filerna på den plats där de sparats som anges i ECMA-skriptet.

## Nästa steg

[Öppnar agentens användargränssnitt när formulär skickas](./opening-agent-ui-on-form-submission.md)