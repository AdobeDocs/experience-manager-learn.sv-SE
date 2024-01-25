---
title: Variabler i AEM [del1]
description: Använda variabler av typen XML, JSON, ArrayList, Document i ett AEM arbetsflöde
feature: Adaptive Forms, Workflow
version: 6.5
topic: Development
role: Developer
level: Beginner
exl-id: f9782684-3a74-4080-9680-589d3f901617
duration: 570
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '404'
ht-degree: 0%

---

# XML-variabler i AEM

Variabler av typen XML används vanligtvis när du har ett XSD-baserat adaptivt formulär och vill extrahera värden från det adaptiva formuläret i arbetsflödet.

I följande video får du hjälp med att skapa variabler av typen String och XML och använda dem i arbetsflödet.

XML-variabeln kan användas för att i förväg fylla i det adaptiva formuläret eller lagra det adaptiva formulärets inskickningsdata i arbetsflödet.

Strängvariabeln kan fyllas i med XPthing till XML-variabeln. Den här strängvariabeln används sedan vanligtvis för att fylla i platshållare för e-postmallar i komponenten Skicka e-post

>[!NOTE]
>
>Om ditt adaptiva formulär inte är kopplat till XSD ser XPath för att hämta värdet för ett element ut som
>
>**/afData/afUnboundData/data/sändandeName**

De adaptiva formulärdata lagras under dataelementet som visas ovan. **_I ovanstående XPath-text är namnet på textfältet i det adaptiva formuläret._**

>[!NOTE]
>
>**AEM Forms 6.5.0** - När du skapar en variabel av typen XML för att hämta inskickade data i arbetsflödesmodellen ska du inte associera XSD med variabeln. Detta beror på att inskickade data inte är kompatibla med XSD när du skickar in XSD-baserade adaptiva formulär. XSD-data för klagomål omges av elementet /afData/afBoundData/.
>
>**AEM Forms 6.5.1** - Om du kopplar XSD till din XML-variabel kan du bläddra bland schemaelementen för att göra variabelmappningen. Du kommer inte att kunna komma åt formulärdata som inte är bundna till schemaelement. Om ditt användningsfall är att få tillgång till data som är bundna till schemaelement samt obundna data, ska du inte binda schemat till din XML-variabel i arbetsflödet.Du måste använda rätt XPath-uttryck för att få fram de data du behöver

## Skapa XML-variabler

>[!VIDEO](https://video.tv.adobe.com/v/26440?quality=12&learn=on)

### Använda schema med XML-variabel

**Mappa en XML-variabel med schema. Använd den här funktionen från och med AEM Forms 6.5.1**

>[!VIDEO](https://video.tv.adobe.com/v/28098?quality=12&learn=on)

#### Använda variabeln i skicka e-post

>[!VIDEO](https://video.tv.adobe.com/v/26441?quality=12&learn=on)

Följ de här stegen för att få resurserna att fungera i ditt system:

* [Hämta och importera resurser till AEM med hjälp av pakethanteraren](assets/xmlandstringvariable.zip)
* [Utforska arbetsflödesmodellen](http://localhost:4502/editor.html/conf/global/settings/workflow/models/vacationrequest.html) för att förstå variablerna som används i arbetsflödet
* [Konfigurera e-posttjänsten](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/notification.html#ConfiguringtheMailService)
* [Öppna det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/applicationfortimeoff/jcr:content?wcmmode=disabled)
* Fyll i uppgifterna och skicka in formuläret.
