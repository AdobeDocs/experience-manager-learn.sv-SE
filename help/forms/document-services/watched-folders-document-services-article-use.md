---
title: Använda bevakade mappar i AEM Forms
seo-title: Använda bevakade mappar i AEM Forms
description: Konfigurera och använda bevakade mappar i AEM Forms
seo-description: Konfigurera och använda bevakade mappar i AEM Forms
uuid: 32c4bda2-363d-4294-925e-405a176f7f8d
feature: Utdatatjänst
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
discoiquuid: a40e2381-0dc8-4784-9b80-15e27b244035
topic: Utveckling
role: Developer
level: Mellanliggande
translation-type: tm+mt
source-git-commit: 7d7034026826a5a46a91b6425a5cebfffab2934d
workflow-type: tm+mt
source-wordcount: '444'
ht-degree: 0%

---


# Använda bevakade mappar i AEM Forms{#using-watched-folders-in-aem-forms}

En administratör kan konfigurera en nätverksmapp, en s.k. bevakad mapp, så att när en användare monterar en fil (t.ex. en PDF-fil) i den bevakade mappen så startas ett förkonfigurerat arbetsflöde, en tjänst eller ett skript för att bearbeta den tillagda filen. När tjänsten har utfört den angivna åtgärden sparas resultatfilen i en angiven utdatamapp. Mer information om arbetsflöde, tjänst och skript.

[Klicka här](https://helpx.adobe.com/experience-manager/6-4/forms/using/Creating-Configure-watched-folder.html) om du vill veta mer om hur du skapar en bevakad mapp

Bevakade mappar används för att generera dokument i gruppläge. Med bevakad mappfunktion kan du generera interaktiv kommunikation för utskriftskanalen eller använda utdatatjänsten för att sammanfoga data med mallen.

I den här artikeln beskrivs hur du sammanfogar data med en mall med hjälp av utdatatjänsten via bevakad mapp.

Utdatatjänsten är en OSGi-tjänst som ingår i AEM Document Services. Utdatatjänsten har stöd för olika utformat och utformningsfunktioner i AEM Forms Designer. Output Service kan konvertera XFA-mallar och XML-data för att generera utskriftsdokument i olika format.

Om du vill veta mer om utdatatjänsten [klickar du här](https://helpx.adobe.com/aem-forms/6/output-service.html).
Följ stegen nedan för att konfigurera bevakade mappar på datorn:
* [Ladda ned och extrahera innehållet i zip-filen](assets/outputservicewatchedfolderkt.zip).Den här zip-filen innehåller paket för att skapa bevakad mapp och exempelfiler för att testa utdatatjänsten med hjälp av bevakad mapp
   * Windows-system

      * Importera outputServiceWatchedfolder.zip till AEM med hjälp av pakethanteraren
      * Detta skapar en bevakad mapp som heter outputservicewatchedfolder på C-enheten.
   * System utanför Windows
      * [Öppna konfigurationsinställningen för den bevakade mappen](http://localhost:4502/crx/de/index.jsp#/etc/fd/watchfolder/config/outputservice)
      * Ange mappsökvägsegenskapen för noden outservice så att den pekar på en lämplig plats
      * Spara ändringarna
      * Platsen som nämns ovan är din bevakade mapp.

Släpp mapparna SamplePdfFile och SampleXdpFile i indatamappen för den bevakade mappen. När filerna har bearbetats placeras resultaten i resultatmappen i den bevakade mappen.


>[!NOTE]
>
>Om skriptet som är associerat med den bevakade mappen behöver mer än en fil, måste du skapa en mapp och placera alla nödvändiga filer i mappen och släppa mappen i indatamappen för den bevakade mappen.
>
>Om skriptet som är associerat med den bevakade mappen endast behöver en indatafil, kan du släppa filen direkt i indatamappen i den bevakade mappen

