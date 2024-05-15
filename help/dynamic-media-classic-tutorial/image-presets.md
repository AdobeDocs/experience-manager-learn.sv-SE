---
title: Bildförinställningar
description: Bildförinställningar i Dynamic Media Classic innehåller alla inställningar som behövs för att skapa en bild med en viss storlek, format, kvalitet och skärpa. Bildförinställningar är en nyckelkomponent för dynamisk storleksanpassning. När du tittar på en URL i Dynamic Media Classic kan du enkelt se om en bildförinställning används. Lär dig mer om bildförinställningar, varför de är så användbara och hur du skapar en.
feature: Dynamic Media Classic, Image Presets
topic: Content Management
role: User
level: Beginner
doc-type: Tutorial
exl-id: e472db7c-ac3f-4f66-85af-5a4c68ba609e
duration: 127
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '648'
ht-degree: 0%

---

# Bildförinställningar {#image-presets}

En bildförinställning är i princip ett recept som innehåller alla inställningar som behövs för att skapa en bild med en viss storlek, format, kvalitet och skärpa. Bildförinställningar är en nyckelkomponent för dynamisk storleksanpassning.

Om du tittar på webbadresserna för nästan alla Dynamic Media Classic-kunder ser du antagligen en bildförinställning som används. Sök bara efter $name$ i slutet av URL:en (med ord eller ord som har ersatts med namn).

Med Bildförinställningar förkortas URL-adressen, så i stället för att skriva ut flera instruktioner för bildvisning per begäran kan du skriva en enda bildförinställning. Dessa två URL-adresser skapar till exempel samma bild på 300 x 300 JPEG med skärpa, men den andra använder en bildförinställning:

![bild](assets/image-presets/image-preset-2.png)

Det verkliga värdet för bildförinställningar är att alla företagsadministratörer kan uppdatera definitionen för den bildförinställningen och påverka alla bilder som använder det formatet - utan att ändra någon webbkod. När cacheminnet för URL:en har rensats visas resultatet av eventuella ändringar i en bildförinställning.

>[!IMPORTANT]
>
>När du ändrar storlek på en bild bör proportionerna för bildens bredd och höjd alltid hållas proportionella så att bilden inte förvrängs.

En bildförinställning har ett dollartecken ($) på båda sidor om namnet och följer efter frågetecknet (?) avgränsare.

>[!TIP]
>
>Skapa en bildförinställning per unik bildstorlek på webbplatsen. Om du till exempel behöver en bild på 350 x 350 för produktinformationssidan, en bild på 120 x 120 för bläddrings-/söksidorna och en bild på 90 x 90 för korsförsäljning/aktuellt objekt behöver du tre förinställningar, oavsett om du har 500 bilder eller 500 000.

- Läs mer om [Bildförinställningar](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/image-sizing/setting-image-presets.html).
- Lär dig hur [Skapa en bildförinställning](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/image-sizing/setting-image-presets.html#creating-an-image-preset).

## Bildförinställningar och skärpa

Bildförinställningar ändrar vanligtvis storlek på en bild och när du ändrar storlek på en bild från den ursprungliga storleken bör du lägga till skärpa. Det beror på att storleksändring gör att många pixlar sammanfogas och blandas i ett mindre utrymme, vilket gör att bilden ser mjuk och oskarp ut. Skärpa ökar kontrasten mellan kanter och områden med hög kontrast i en bild.

Vi förväntar oss att de högupplösta bilder du överför till Dynamic Media Classic inte behöver skärpa när de visas i full storlek - när de zoomas in. Men i alla mindre storlekar är skärpa vanligtvis önskvärd.

>[!TIP]
>
>Öka alltid skärpan när du ändrar storlek på bilder! Det innebär att du måste lägga till skärpa i alla bildförinställningar (och visningsförinställningar, som vi kommer att diskutera senare).
>
>Om bilderna inte ser bra ut är det troligt att de behöver skärpa eller att kvaliteten var dålig till att börja med.

Hur mycket skärpa du ska lägga till är helt subjektiv. Vissa gillar mjukare bilder, medan andra tycker om dem väldigt skarpa. Det är enkelt att förbättra en bild genom att köra en kombination av skärpefilter på en bild. Men det är också enkelt att lägga över och göra en bild för skarp.

I följande bild visas tre nivåer av skärpa. Från höger till vänster har du ingen skärpa, bara rätt mängd och för mycket.

![bild](assets/image-presets/image-presets-1.jpg)

I Dynamic Media Classic finns det tre typer av skärpa: Enkel skärpa, Omsamplingsläge och Oskarp mask.

Läs mer om [Dynamic Media Classic skärpealternativ](https://experienceleague.adobe.com/docs/dynamic-media-classic/using/master-files/sharpening-image.html#sharpening_an_image).

## Ytterligare resurser

[Guide för bildförinställningar](https://www.adobe.com/content/dam/www/us/en/experience-manager/pdfs/dynamic-media-image-preset-guide.pdf). Inställningar som ska användas för att optimera bildkvalitet och inläsningshastighet.

[Bilden är allt som är del 2: Det är aldrig bara en oskärpa - kvalitet jämfört med hastighet](https://theblog.adobe.com/image-is-everything-part-2-its-never-just-a-blur-quality-versus-speed/). Ett blogginlägg där man diskuterar hur man använder bildförinställningar för att leverera högkvalitativa, snabba bilder.
