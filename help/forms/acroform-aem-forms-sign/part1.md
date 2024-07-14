---
title: Acrobat med AEM Forms
description: Del 1 av Integrering av Acrobat med AEM Forms. Skapa ett adaptivt formulär med Acrobat och sammanfoga data för att få ett PDF.
feature: adaptive-forms
doc-type: Tutorial
version: 6.5
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
duration: 144
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '216'
ht-degree: 0%

---


# Skapa Acrobat

Acrobat är formulär som skapats med Acrobat. Du kan skapa ett nytt formulär från grunden med Acrobat eller ta ett befintligt formulär som har skapats i Microsoft Word och konvertera det till Acrobat med Acrobat. Följande steg måste följas för att konvertera ett formulär som har skapats i Microsoft Word till Acrobat.

* Öppna orddokument med Acrobat
* Använd Acrobat Förbered formulärverktyg för att identifiera formulärfälten i formuläret.
* Spara PDF-filen. Kontrollera att filnamnet inte innehåller några blanksteg.


>[!VIDEO](https://video.tv.adobe.com/v/22575?quality=12&learn=on)

>[!NOTE]
>
>Om du vill skicka det ifyllbara makroformuläret för signering med Acrobat Sign, måste du namnge fälten därefter. Du kan till exempel ge fältet namnet **`Sig_es_:signer1:signature`**. Det här är syntaxen som Acrobat Sign förstår.

>[!NOTE]
>
>Om du skickar ett XFA-baserat dokument måste du förenkla dokumentet och Acrobat Sign-signaturtaggarna måste finnas som statisk text i dokumentet.

[Acrobat Sign-texttaggdokument](https://helpx.adobe.com/sign/using/text-tag.html)

>[!NOTE]
>
>Se till att akrobat-filnamnet inte innehåller några blanksteg. Den aktuella exempelkoden hanterar inte blanksteg.
>
>Formulärfältsnamnen får endast innehålla följande:
>
>* enkelt blanksteg
>* understreck
>* alfanumeriska tecken
