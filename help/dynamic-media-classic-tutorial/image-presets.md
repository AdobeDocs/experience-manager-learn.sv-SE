---
title: Bildförinställningar
description: Bildförinställningar i Dynamic Media Classic innehåller alla inställningar som behövs för att skapa en bild med en viss storlek, format, kvalitet och skärpa. Bildförinställningar är en nyckelkomponent för dynamisk storleksändring. När du tittar på en URL i Dynamic Media Classic kan du enkelt se om en bildförinställning används. Lär dig mer om bildförinställningar, varför de är så användbara och hur du skapar en.
sub-product: dynamiska medier
feature: Dynamic Media Classic, bildförinställningar
doc-type: tutorial
topics: development, authoring, configuring
audience: all
activity: use
topic: Innehållshantering
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '712'
ht-degree: 0%

---


# Bildförinställningar {#image-presets}

En bildförinställning är i princip ett recept som innehåller alla inställningar som behövs för att skapa en bild med en viss storlek, format, kvalitet och skärpa. Bildförinställningar är en nyckelkomponent för dynamisk storleksändring.

Om du tittar på webbadresserna för nästan alla Dynamic Media Classic-kunder ser du antagligen en bildförinställning som används. Sök bara efter $name$ i slutet av URL:en (med ord eller ord som har ersatts med namn).

Med Bildförinställningar förkortas webbadressen, så i stället för att skriva ut flera instruktioner för bildvisning per begäran kan du skriva en enda bildförinställning. Dessa två URL-adresser skapar till exempel samma 300 x 300 JPEG-bild med skärpa, men den andra använder en bildförinställning:

![bild](assets/image-presets/image-preset-2.png)

Det verkliga värdet för bildförinställningar är att alla företagsadministratörer kan uppdatera definitionen för den bildförinställningen och påverka alla bilder som använder det formatet - utan att ändra någon webbkod. När cacheminnet för URL:en har rensats visas resultatet av eventuella ändringar i en bildförinställning.

>[!IMPORTANT]
>
>När du ändrar storlek på en bild bör proportionerna för bildens bredd och höjd alltid hållas proportionella så att bilden inte förvrängs.

En bildförinställning har ett dollartecken ($) på båda sidor om namnet och följer efter frågetecknet (?) avgränsare.

>[!TIP]
>
>Skapa en bildförinställning per unik bildstorlek på webbplatsen. Om du till exempel behöver en bild på 350 x 350 för produktinformationssidan, en bild på 120 x 120 för bläddrings-/söksidorna och en bild på 90 x 90 för korsförsäljning/aktuellt objekt behöver du tre förinställda bilder, oavsett om du har 500 bilder eller 500 0 000.

- Läs mer om [Bildförinställningar](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/image-sizing/setting-image-presets.html).
- Lär dig hur du [skapar en bildförinställning](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/image-sizing/setting-image-presets.html#creating-an-image-preset).

## Bildförinställningar och skärpa

Bildförinställningar ändrar vanligtvis storlek på en bild och när du ändrar storlek på en bild från den ursprungliga storleken bör du lägga till skärpa. Det beror på att storleksändring gör att många pixlar sammanfogas och blandas i ett mindre utrymme, vilket gör att bilden ser mjuk och oskarp ut. Skärpa ökar kontrasten mellan kanter och områden med hög kontrast i en bild.

Vi förväntar oss att de högupplösta bilder du överför till Dynamic Media Classic inte behöver skärpan när de visas i full storlek - när de zoomas in. Men i alla mindre storlekar är skärpa vanligtvis önskvärd.

>[!TIP]
>
>Öka alltid skärpan när du ändrar storlek på bilder! Det innebär att du måste lägga till skärpa i alla bildförinställningar (och visningsförinställningar, som vi kommer att diskutera senare).
>
>Om bilderna inte ser bra ut är det troligt att de behöver skärpa eller att kvaliteten var dålig till att börja med.

Hur mycket skärpa du ska lägga till är helt subjektiv. Vissa gillar mjukare bilder, medan andra tycker om dem väldigt skarpa. Det är enkelt att förbättra en bild genom att köra en kombination av skärpefilter på en bild. Men det är också enkelt att lägga över och göra en bild för skarp.

I följande bild visas tre nivåer av skärpa. Från höger till vänster har du ingen skärpa, bara rätt mängd och för mycket.

![bild](assets/image-presets/image-presets-1.jpg)

I Dynamic Media Classic kan du göra tre typer av skärpa: Enkel skärpa, omsamplingsläge och Oskarp mask.

Läs mer om [Dynamic Media Classic Sharpening Options](https://docs.adobe.com/content/help/en/dynamic-media-classic/using/master-files/sharpening-image.html#sharpening_an_image).

## Ytterligare resurser

[Förinställningsguide](https://www.adobe.com/content/dam/www/us/en/experience-manager/pdfs/dynamic-media-image-preset-guide.pdf) för bild. Inställningar som ska användas för att optimera bildkvalitet och inläsningshastighet.

[Bilden är allt del 2: Det är aldrig bara oskärpa - kvalitet jämfört med hastighet](https://theblog.adobe.com/image-is-everything-part-2-its-never-just-a-blur-quality-versus-speed/). Ett blogginlägg där man diskuterar hur man använder bildförinställningar för att leverera högkvalitativa, snabba bilder.

[Bild är allt som är webbinarier](https://dynamicmediaseries2019.enterprise.adobeevents.com/). Länkar till inspelningar av alla tre webbinarierna i _Image Is everything_-serien. [I webbinarium 2 ](https://seminars.adobeconnect.com/p6lqaotpjnd3) behandlas bildförinställningar.
