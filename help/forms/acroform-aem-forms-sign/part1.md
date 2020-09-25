---
title: Acrobat med AEM Forms
seo-title: Sammanfoga data i anpassat format med Acrobat
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4
translation-type: tm+mt
source-git-commit: 1e615d1c51fa0c4c0db335607c29a8c284874c8d
workflow-type: tm+mt
source-wordcount: '204'
ht-degree: 0%

---


# Skapa Acrobat

Acrobat är formulär som skapats med Acrobat. Du kan skapa ett nytt formulär från grunden med Acrobat eller ta ett befintligt formulär som har skapats i Microsoft Word och konvertera det till Acrobat med Acrobat. Följande steg måste följas för att konvertera ett formulär som har skapats i Microsoft Word till Acrobat.

* Öppna orddokument med Acrobat
* Använd Acrobat Förbered formulärverktyg för att identifiera formulärfälten i formuläret.
* Spara PDF-filen. Kontrollera att filnamnet inte innehåller några blanksteg.


>[!VIDEO](https://video.tv.adobe.com/v/22575?quality=9&learn=on)

>[!NOTE]
>
>Om du vill skicka det ifyllbara makroformuläret för signering med Adobe Sign, måste du namnge fälten därefter. Du kan t.ex. ge fältet namnet **Sig_es_:signer1:signature**. Det här är syntaxen som Adobe Sign förstår.

>[!NOTE]
>
>Om du skickar ett XFA-baserat dokument måste du förenkla dokumentet och Adobe Sign-signaturtaggarna måste finnas som statisk text i dokumentet.

[Adobe Sign-dokument för texttaggar](https://helpx.adobe.com/sign/using/text-tag.html)

>[!NOTE]
Se till att akrobat-filnamnet inte innehåller några blanksteg. Den aktuella exempelkoden hanterar inte blanksteg.
Formulärfältsnamnen får endast innehålla följande
* enkelt blanksteg
* understreck
* alfanumeriska tecken