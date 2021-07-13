---
title: Ange mappstruktur och namngivningskonvention för filer
description: Filnamngivning är kanske det viktigaste beslutet när du implementerar Dynamic Media Classic. Mappstrukturen är också viktig. Lär dig varför det är så viktigt och möjligt att använda metoder för mappstruktur och filnamn.
sub-product: dynamiska medier
feature: Dynamic Media Classic
doc-type: tutorial
activity: develop
topics: development, authoring, configuring, architecture
audience: all
topic: Innehållshantering
role: User
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '1216'
ht-degree: 0%

---


# Ange mappstruktur och namngivningskonvention för filer {#folder-structure-filenaming}

Innan du börjar ladda upp allt ditt innehåll är det klokt att fundera över mappstrukturen du ska använda och i synnerhet namnkonventionen. Det sparar antagligen tid och du behöver göra om uppgifter senare. Det är bäst att samordna dessa beslut i alla grupper.

## Mapphierarki och namngivningskonvention för filer

Namngivning är vanligtvis det viktigaste beslutet när det gäller implementering av Dynamic Media Classic. Men för att förstå varför det är viktigt måste vi först prata om mappstrukturen.

### Mapphierarki

Mapphierarkin är bara viktig för dig och ditt företag i organiseringssyfte - dina Dynamic Media Classic-URL:er refererar bara till resursnamnet, inte mappen eller sökvägen. Oavsett var du överför en fil kommer URL:en att vara densamma. Detta skiljer sig helt från hur de flesta organiserar sina bilder och sitt innehåll för webben, men med Dynamic Media Classic spelar det ingen roll.

En annan viktig faktor är antalet resurser eller mappar som ska lagras i varje mapp. Om många resurser lagras i en mapp försämras prestanda när du visar resurser i Dynamic Media Classic. Lagra inte tusentals resurser i en mapp. Utveckla i stället en organisationshierarki med färre än ca 500 resurser eller mappar inom en viss gren i hierarkin. Detta är inte ett strikt krav, men det hjälper till att behålla godtagbara svarstider vid visning eller sökning av resurser. Rekommendationen är i själva verket att skapa hierarkier som är breda och tunna snarare än smala och djupa.

Det enklaste sättet att skapa mappar är att överföra hela mappstrukturen med FTP och aktivera alternativet **Inkludera undermappar**. Med det här alternativet återskapar Dynamic Media Classic mappstrukturen på FTP-platsen i Dynamic Media Classic.

Vi vill att du ska tänka på mappstrukturen innan du börjar överföra alla filer, eftersom det är mycket enklare att ordna och hantera filer och mappar lokalt på datorn än i Dynamic Media Classic. Du kan till exempel bara dra och släppa filer, men inte hela mappar, inuti Dynamic Media Classic.

### Mappstrategier

För er mappstrategi bör ni fundera över vad som passar er organisation bäst. Här är några vanliga scenarier för mappnamngivning:

- Spegla webbplats- eller produktinformation. Om du till exempel har sålt kläder kan du ha mappar för Män, Kvinnor och tillbehör samt undermappar för Skisar och skor.
- SKU- eller produkt-ID-baserad strategi. Om återförsäljarna till exempel har tusentals objekt kan det vara bra att använda SKU-nummer eller produkt-ID som mappnamn.
- Varumärkesstrategi. Tillverkare som har flera varumärken kan till exempel välja sina märkesnamn som mappar på den översta nivån.

## Konvention om namngivning av filer

Det sätt du väljer att namnge filerna är kanske det viktigaste beslutet du kommer att fatta när det gäller Dynamic Media Classic. Detta beror på att alla resurser i Dynamic Media Classic måste ha unika namn, oavsett var de lagras på kontot.

Alla URL:er och transaktioner i Dynamic Media Classic styrs av ett tillgångs-ID, som är en tillgångs unika identifierare i databasen. När du överför en fil skapas resurs-ID:t genom att filnamnet tas bort och tillägget tas bort. Till exempel _896649.jpg_ hämtar resurs _ID 896649_.

Regler för tillgångs-ID:

- Två resurser kan inte ha samma namn i Dynamic Media Classic, oavsett i vilken mapp resurserna finns.
- Namnen är skiftlägeskänsliga. Till exempel skulle stol.jpg, stol.jpg och CHAIR.jpg skapa tre olika resurs-ID:n.
- Ett tips är att resurs-ID:n inte får innehålla blanksteg eller symboler. Användningen av blanksteg och symboler gör implementeringen svårare eftersom du måste URL-koda dessa tecken. Ett blanksteg &quot; blir till exempel &quot;%20&quot;.

Namnkonventionen är i stort sett hur du integrerar med Dynamic Media Classic. Du integrerar vanligtvis inte dina datasystem i Dynamic Media Classic eftersom det är ett slutet system. Det är en passiv partner som väntar på instruktioner i form av URL-adresser.

De flesta användare baserar sina namnkonventioner på sin interna SKU eller produkt-ID så att sidan automatiskt kan söka efter en bild med ett liknande namn när en webbsida anropas med information om den aktuella SKU:n. Om det inte finns någon koppling mellan filnamnet och SKU:n eller ID:t måste datasystemet manuellt hålla reda på varje filnamn, och en person måste hålla reda på associationerna - kort och gott - för både IT-avdelningen och innehållsteamet.

### Filnamnsstrategier

Namngivningsstrategin bör vara flexibel för framtida expansion så att du slipper byta namn efter att du startat programmet. Här är några typiska namngivningsstrategier:

**Inga alternativa bilder.** I det här scenariot har du bara en bild per produkt och inga alternativa eller färgade vyer. Du ska namnge varje bild enligt dess unika SKU- eller produkt-ID-nummer. När sidan läses in anropar sidmallen tillgångs-ID med samma SKU-nummer.

| SKU/PID | Filnamn | Tillgångs-ID |
| ------- | ---------- | -------- |
| 896649 | 896649.jpg | 896649 |
| SKU123 | SKU123.png | SKU123 |

Detta är ett mycket enkelt system och bra om du har blygsamma behov. Den är dock inte särskilt flexibel. Bara för att du inte har några alternativa bilder idag betyder det inte att du inte har de bilderna i morgon. Nästa scenario ger större flexibilitet.

**Använd bilden, alternativa vyer, färgversioner och färgrutor.** Den här strategin tillåter alternativa vyer och/eller färgade vyer, om du har dem. I stället för att bara namnge bilden efter SKU:n lägger du till en modifierare som &quot;_1&quot; och &quot;_2&quot; för alternativa vyer och färgkoden &quot;_RED&quot; eller &quot;_BLU&quot; för färgade vyer. Om du har både färgbilder och alternativa vyer för samma produkt kanske du lägger till&quot;_RED_1&quot; och&quot;_RED_2&quot; för den första och andra röda vyn. Färgrutor får då SKU-namnet, färgkoden och tillägget&quot;_SW&quot;.

| SKU/PID | Kategori | Filnamn | Tillgångs-ID |
| ------- | ----------------------- | ------------------------------------------- | ------------------------------- |
| AA123 | Alt-vyer | AA123_1.tif AA123_2.tif AA123_3.tif | AA123_1 AA123_2 AA123_3 |
|  | Färgade vyer | AA123_BLU.tif AA123_RED.tif AA123_BROWN.tif | AA123_BLU AA123_RED AA123_BROWN |
|  | Färgrutor | AA123_BLU_SW.tif | AA123_BLU_SW |
|  | Bilduppsättning eller uppsättning med färgrutor |  | AA123 eller AA123_SET | — |

När du arbetar med uppsatta samlingar, som bilduppsättningar och färgruteuppsättningar, måste själva uppsättningen också ha ett unikt namn. I det här fallet kan uppsättningen få bas-SKU:n som namn, eller SKU:n med tillägget&quot;_SET&quot;.

### Namngivningskonvention och automatisering

Ett sista ord om vikten av namnkonvention. Om du vill använda uppsättningar (t.ex. bilduppsättningar eller färgruteuppsättningar) kan du använda en förutsägbar namnkonvention för att automatisera skapandet av dem. Alla skriptbaserade metoder, till exempel en gruppuppsättningsförinställning, som du kommer att lära dig om i ett separat avsnitt i den här självstudiekursen, kan köras av en namnkonvention.

Den alternativa metoden är att skapa uppsättningar manuellt. Även om det inte är ett stort jobb att manuellt skapa bilduppsättningar för 200 bilder kan du tänka dig att du har fler än 100 000 bilder. Detta är när automatisering av set creation blir avgörande.
