---
title: Använda bevakade mappar i AEM Forms
description: Konfigurera och använda bevakade mappar i AEM Forms
feature: Output Service
version: 6.4,6.5
topic: Development
role: Developer
level: Intermediate
exl-id: abb74d44-d1b9-44d6-a49f-36c01acfecb4
last-substantial-update: 2020-07-07T00:00:00Z
duration: 107
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '406'
ht-degree: 0%

---

# Använda bevakade mappar i AEM Forms{#using-watched-folders-in-aem-forms}

En administratör kan konfigurera en nätverksmapp, en så kallad bevakad mapp, så att när en användare placerar en fil (till exempel en PDF-fil) i den bevakade mappen så startas ett förkonfigurerat arbetsflöde, en tjänst eller en skriptåtgärd för att bearbeta den tillagda filen. När tjänsten har utfört den angivna åtgärden sparas resultatfilen i en angiven utdatamapp. Mer information om arbetsflöde, tjänst och skript.

Om du vill veta mer om hur du skapar en bevakad mapp [klicka här](https://helpx.adobe.com/experience-manager/6-4/forms/using/Creating-Configure-watched-folder.html)

Bevakade mappar används för att generera dokument i gruppläge. Med bevakad mappfunktion kan du generera interaktiv kommunikation för utskriftskanalen eller använda utdatatjänsten för att sammanfoga data med mallen.

I den här artikeln beskrivs hur du sammanfogar data med en mall med hjälp av utdatatjänsten via bevakad mapp.

Utdatatjänsten är en OSGi-tjänst som ingår i AEM Document Services. Utdatatjänsten har stöd för olika utformat och utformningsfunktioner i AEM Forms Designer. Output Service kan konvertera XFA-mallar och XML-data för att generera utskriftsdokument i olika format.

Om du vill veta mer om utdatatjänsten [klicka här](https://helpx.adobe.com/aem-forms/6/output-service.html).
Följ stegen nedan för att konfigurera bevakade mappar på datorn:
* [Hämta och extrahera innehållet i zip-filen](assets/outputservicewatchedfolderkt.zip).Den här ZIP-filen innehåller ett paket för att skapa bevakad mapp och exempelfiler för att testa utdatatjänsten med hjälp av en bevakad mappmekanism
   * Windows-system

      * Importera outputServiceWatchedfolder.zip till AEM med pakethanteraren
      * Då skapas en bevakad mapp som heter outputservicewatchedfolder på C-enheten.
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
