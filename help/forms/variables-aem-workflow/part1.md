---
title: Variabler i AEM [del1]
description: Använda variabler av typen XML, JSON, ArrayList, Document i ett AEM arbetsflöde
feature: Adaptiv Forms
version: 6.5
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '425'
ht-degree: 0%

---


# XML-variabler i AEM arbetsflöde

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
>**AEM Forms 6.5.1** - Om du associerar XSD med din XML-variabel kan du bläddra bland schemaelementen för att göra variabelmappningen. Du kommer inte att kunna komma åt formulärdata som inte är bundna till schemaelement. Om ditt användningsfall är att få tillgång till data som är bundna till schemaelement samt obundna data, ska du inte binda schemat till din XML-variabel i arbetsflödet.Du måste använda rätt XPath-uttryck för att få tillgång till de data som du behöver

## Skapa XML-variabler

>[!VIDEO](https://video.tv.adobe.com/v/26440?quality=12?autoplay=1)

### Använda schema med XML-variabel

**Mappa en XML-variabel med schema. Använd den här funktionen från och med AEM Forms 6.5.1**

>[!VIDEO](https://video.tv.adobe.com/v/28098?quality=9&learn=on)

#### Använda variabeln i skicka e-post

>[!VIDEO](https://video.tv.adobe.com/v/26441?quality=12&learn=on)

Följ de här stegen för att få resurserna att fungera i ditt system:

* [Hämta och importera resurser till AEM med hjälp av pakethanteraren](assets/xmlandstringvariable.zip)
* [Utforska arbetsflödesmodellen ](http://localhost:4502/editor.html/conf/global/settings/workflow/models/vacationrequest.html) för att förstå de variabler som används i arbetsflödet
* [Konfigurera e-posttjänsten](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/notification.html#ConfiguringtheMailService)
* [Öppna det adaptiva formuläret](http://localhost:4502/content/dam/formsanddocuments/applicationfortimeoff/jcr:content?wcmmode=disabled)
* Fyll i uppgifterna och skicka in formuläret.

