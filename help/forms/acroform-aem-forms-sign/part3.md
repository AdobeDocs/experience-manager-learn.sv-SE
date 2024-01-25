---
title: Acrobat med AEM Forms
description: Del 3 i en självstudiekurs som integrerar Acrobat med AEM Forms. Testa arbetsflödet och det adaptiva formuläret på datorn.
feature: adaptive-forms
doc-type: Tutorial
version: 6.5
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
duration: 49
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '228'
ht-degree: 1%

---


# Testa den här funktionen på datorn

[Hämta och importera det här paketet till AEM](assets/acro-form-aem-form.zip)
Det här paketet innehåller exempelarbetsflödet och HTML-sidan som gör att du kan skapa schemat från det överförda Acrobat.

## Konfigurera arbetsflöde

1. [Öppna arbetsflödesmodellen i redigeringsläge](http://localhost:4502/editor.html/conf/global/settings/workflow/models/MergeAcroformData.html).
2. Öppna konfigurationsegenskaperna för steget MergeAcrobatData.
3. Klicka på fliken Process.
4. Kontrollera att argumenten du skickar är en giltig mapp på servern.
5. Spara ändringarna.

## Skapa anpassat formulär

1. Skapa ett anpassat formulär med det schema som skapades i det tidigare steget.
2. Dra och släpp några schemaelement i det adaptiva formuläret.
3. Konfigurera skicka-åtgärden för det adaptiva formuläret som ska skickas till AEM (MergeAcrobatData).
4. **Se till att du anger sökvägen till datafilen som &quot;Data.xml&quot;. Detta är mycket viktigt eftersom exempelkoden söker efter filen Data.xml i arbetsflödets nyttolast.**
5. Förhandsgranska anpassat formulär, fyll i formuläret och skicka in det.
6. Du bör se PDF med data som sammanfogats sparade i den mapp som anges i steg 4 under konfigurationsarbetsflödet

>[!NOTE]
>
>Den PDF-fil som skapas genom att data sammanfogas med acroform sparas som pdfdocument.pdf i arbetsflödets nyttolastmapp. Dokumentet kan sedan användas för vidare bearbetning som en del av arbetsflödet
