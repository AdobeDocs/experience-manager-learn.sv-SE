---
title: Visar anpassade tillgångstyper i AEM Forms
seo-title: Visar anpassade tillgångstyper i AEM Forms
description: Del 2 i Lista anpassade tillgångstyper i AEM Forms
seo-description: Del 2 i Lista anpassade tillgångstyper i AEM Forms
uuid: 6467ec34-e452-4c21-9bb5-504f9630466a
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
discoiquuid: 4b940465-0bd7-45a2-8d01-e4d640c9aedf
translation-type: tm+mt
source-git-commit: defefc1451e2873e81cd81e3cccafa438aa062e3
workflow-type: tm+mt
source-wordcount: '611'
ht-degree: 0%

---


# Visar anpassade resurstyper i AEM Forms {#listing-custom-asset-types-in-aem-forms}

## Skapar anpassad mall {#creating-custom-template}


I den här artikeln kommer vi att skapa en anpassad mall som visar de anpassade resurstyperna och OOTB-resurstyperna på samma sida. Följ nedanstående instruktioner för att skapa en anpassad mall

1. Skapa en sling: under /apps. Ge den namnet &quot;myportalcomponent&quot;
1. Lägg till en fpContentType-egenskap. Ange värdet som **/libs/fd/ fp/formTemplate&quot;.**
1. Lägg till en title-egenskap och ställ in dess värde på &quot;custom template&quot;. Det här namnet visas i listrutan för sök- och listkomponenten
1. Skapa en&quot;template.html&quot; under den här mappen. Den här filen innehåller koden för att formatera och visa de olika resurstyperna.

![appsmapp](assets/appsfolder_.png)

I följande kod visas de olika typerna av resurser som använder söknings- och listkomponenten. Vi skapar separata html-element för varje typ av resurs, vilket visas med taggen data-type = &quot;videos&quot;. För resurstypen &quot;videor&quot; använder vi elementet &lt;video> för att spela upp den infogade videon. För resurstypen &quot;worddocuments&quot; använder vi olika html-markeringar.

```html
<div class="__FP_boxes-container __FP_single-color">
   <div  data-repeatable="true">
     <div class = "__FP_boxes-thumbnail" style="float:left;margin-right:20px;" data-type = "videos">
   <video width="400" controls>
       <source src="${path}" type="video/mp4">
    </video>
         <h3 class="__FP_single-color" title="${name}" tabindex="0">${name}</h3>
     </div>
     <div class="__FP_boxes-thumbnail" style="float:left;margin-right:20px;" data-type = "worddocuments">
       <a href="/assetdetails.html${path}" target="_blank">
           <img src ="/content/dam/worddocuments/worddocument.png/jcr:content/renditions/cq5dam.thumbnail.319.319.png"/>
          </a>
          <h3 class="__FP_single-color" title="${name}" tabindex="0">${name}</h3>
     </div>
  <div class="__FP_boxes-thumbnail" style="float:left;margin-right:20px;" data-type = "xfaForm">
       <a href="/assetdetails.html${path}" target="_blank">
           <img src ="${path}/jcr:content/renditions/cq5dam.thumbnail.319.319.png"/>
          </a>
          <h3 class="__FP_single-color" title="${name}" tabindex="0">${name}</h3>
                <a href="{formUrl}"><img src="/content/dam/html5.png"></a><p>

     </div>
  <div class="__FP_boxes-thumbnail" style="float:left;margin-right:20px;" data-type = "printForm">
       <a href="/assetdetails.html${path}" target="_blank">
           <img src ="${path}/jcr:content/renditions/cq5dam.thumbnail.319.319.png"/>
          </a>
          <h3 class="__FP_single-color" title="${name}" tabindex="0">${name}</h3>
                <a href="{pdfUrl}"><img src="/content/dam/pdf.png"></a><p>
     </div>
   </div>
</div>
```

>[!NOTE]
>
>Rad 11 - Ändra bildens src till att peka på en bild som du väljer i DAM.
>
>Om du vill visa Adaptiv Forms i den här mallen skapar du en ny div och ställer in dess datatypsattribut till &quot;guide&quot;. Du kan kopiera och klistra in den div vars data-type=&quot;printForm&quot; och ange datatypen för den nyligen kopierade div som &quot;guide&quot;

## Konfigurera sök- och listkomponenten {#configure-search-and-lister-component}

När vi har definierat den anpassade mallen måste vi nu koppla den anpassade mallen till komponenten Sök och visa. Peka webbläsaren [på den här URL:en ](http://localhost:4502/editor.html/content/AemForms/CustomPortal.html).

Växla till designläge och konfigurera styckesystemet så att det inkluderar Search and Lister-komponenten i den tillåtna komponentgruppen. Komponenten Sök och Lister ingår i Document Services-gruppen.

Växla till redigeringsläget och lägg till komponenten Sök och Lister i ParSys.

Öppna konfigurationsegenskaperna för komponenten &quot;Sök och visa&quot;. Kontrollera att fliken &quot;Resursmappar&quot; är markerad. Välj de mappar från vilka du vill visa resurserna i sök- och listkomponenten. I den här artikeln har jag valt

* /content/dam/VideosAndWordDocuments
* /content/dam/formsanddocuments/assettypes

![assetfolder](assets/selectingassetfolders.png)

Fliken till fliken &quot;Visa&quot;. Här väljer du den mall som du vill visa resurserna i sök- och listkomponenten.

Välj &quot;anpassad mall&quot; i listrutan enligt nedan.

![searchandlister](assets/searchandlistercomponent.gif)

Konfigurera de typer av resurser som du vill visa i portalen. Om du vill konfigurera resurstypernas flik till&quot;Resurslista&quot; och konfigurera resurstyperna. I det här exemplet har vi konfigurerat följande typer av resurser

1. MP4-filer
1. Word-dokument
1. Dokument (OOTB-tillgångstyp)
1. Formulärmall (OOTB-resurstyp)

I följande skärmbild visas resurstyperna som är konfigurerade för listning

![tillgångstyper](assets/assettypes.png)

Nu när du har konfigurerat söknings- och listportalkomponenten är det dags att se hur listan fungerar. Peka webbläsaren [på den här URL:en ](http://localhost:4502/content/AemForms/CustomPortal.html?wcmmode=disabled). Resultatet ska se ut ungefär som bilden nedan.

>[!NOTE]
>
>Om din portal listar anpassade resurstyper på en publiceringsserver ska du se till att du ger&quot;läsbehörighet&quot; till&quot;fd-service&quot;-användaren till noden **/apps/fd/fp/extensions/querybuilder**

![Resurstyper ](assets/assettypeslistings.png)
[Hämta och installera det här paketet med hjälp av pakethanteraren.](assets/customassettypekt1.zip) Detta innehåller exempel på mp4- och Word-dokument och xdp-filer som ska användas som resurstyper för att lista med hjälp av sök- och listkomponenten
