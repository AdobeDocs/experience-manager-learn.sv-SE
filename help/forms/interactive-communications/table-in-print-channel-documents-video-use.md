---
title: Använda tabellkomponent i AEM Forms Print Channel-dokument
seo-title: Använda tabellkomponent i AEM Forms Print Channel-dokument
description: I följande videofilm visas de steg som krävs för att använda tabellkomponenten i Interactive Communications för dokument i tryckkanaler.
feature: Interactive Communication
topics: development
audience: developer
doc-type: technical video
activity: implement
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '281'
ht-degree: 0%

---


# Använda tabellkomponent i AEM Forms Print Channel-dokument {#using-table-component-in-aem-forms-print-channel-document}

I följande videofilm visas de steg som krävs för att använda tabellkomponenten i Interactive Communications för dokument i tryckkanaler.

>[!VIDEO](https://video.tv.adobe.com/v/27769?quality=9&learn=on)

Tabeller används för att visa data i tabelläge. Raderna i tabellen måste förstoras eller förminskas beroende på vilka data som returneras av datakällan. Om du vill använda en tabell i ett dokument för tryckkanaler måste du skapa en layoutfil (xdp-fil) med AEM Forms Designer. I den här layoutfilen lägger vi till tabellen med det antal kolumner som krävs. Kontrollera att kolumnfältets objekttyp är antingen TextField eller Numeric Field beroende på dina krav. För var och en av kolumnerna ska du kontrollera att databindningen är inställd på Använd namn.

>[!NOTE]
>
>Om du vill göra tabellen dynamisk måste du markera raden som upprepad.

**Prova på din egen server**

* [Ladda ned och zippa upp resursfilen på hårddisken](assets/usingtablesinprintchannel.zip)

* Importera de två ZIP-filerna till AEM med hjälp av pakethanteraren

* Följande resurser ingår i den här artikeln:

   * Layoutfragment

   * Modal för formulärdata

   * Interaktivt kommunikationsdokument
   * sampleretirementaccountdata.json

* Öppna dokumentet för interaktiv kommunikation i [redigeringsläge](http://localhost:4502/editor.html/content/forms/af/401kstatement/tablesinprintdocument/channels/print.html).

* Lägg till layoutfragmentet TableDemo i sektionen för bidrag.
* Binda tabellcellerna till lämpliga formulärets datamodellelement som de visas i videon

* Förhandsgranska interaktivt kommunikationsdokument med JSON-exempeldatafilen som du har fått

