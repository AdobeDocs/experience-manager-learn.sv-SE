---
title: Anpassade funktioner i AEM Forms
description: Skapa och använda anpassade funktioner i Adaptiv form
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: User
level: Beginner
jira: KT-9685
exl-id: 07fed661-0995-41ab-90c4-abde35a14a4c
last-substantial-update: 2021-06-09T00:00:00Z
duration: 286
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '319'
ht-degree: 0%

---

# Anpassade funktioner

I AEM Forms 6.5 introducerades möjligheten att definiera JavaScript-funktioner som kan användas för att definiera komplexa affärsregler med regelredigeraren.
AEM Forms har ett antal anpassade funktioner som du kan använda, men du måste definiera egna funktioner och använda dem i flera formulär.

Så här definierar du din första anpassade funktion:
* [Logga in på crx](http://localhost:4502/crx/de/index.jsp#/apps/experience-league/clientlibs)
* Skapa en ny mapp under program som kallas upplevelsegrupp (mappnamnet kan vara ett namn du väljer)
* Spara ändringarna.
* I mappen experience-leag skapar du en ny nod av typen cq:ClientLibraryFolder som kallas clientlibs.
* Markera mappen clientlibs och lägg till egenskaperna allowProxy och categories som visas på skärmbilden. Spara ändringarna.

![client-lib](assets/custom-functions.png)
* Skapa en mapp med namnet **js** under mappen **clientlibs**
* Skapa en fil med namnet **functions.js** i mappen **js**
* Skapa en fil med namnet **js.txt** under mappen **clientlibs**. Spara ändringarna.
* Mappstrukturen bör se ut som skärmbilden nedan.

![Regelredigeraren](assets/folder-structure.png)

* Dubbelklicka på functions.js för att öppna redigeraren.
Kopiera följande kod till functions.js och spara ändringarna.

```javascript
/**
* Get List of County names
* @name getCountyNamesList Get list of county names
* @returns {string[]} An array of county names
 */
function getCountyNamesList()
{
    return ["Santa Clara", "Alameda", "Buxor", "Contra Costa", "Merced"];

}
/**
* Covert UTC to Local Time
* @name convertUTC Convert UTC Time to Local Time
* @param {string} strUTCString in Stringformat
* @return {string}
*/
function convertUTC(strUTCString)
{
    var dt = new Date(strUTCString);
    console.log(dt.toLocaleString());
    return dt.toLocaleString();
}
```

Mer information om att anteckna javascript-funktioner finns i [jsdoc](https://jsdoc.app/index.html).
Koden ovan har två funktioner:
**getCountyNamesList** - returnerar en array med strängar
**convertUTC** - Konverterar UTC-tidsstämpel till lokal tidszon

Öppna js.txt och klistra in följande kod och spara ändringarna.

```javascript
#base=js
functions.js
```

Raden #base=js anger i vilken katalog JavaScript-filerna finns.
Raderna nedan anger platsen för JavaScript-filen i förhållande till basplatsen.

Om du har problem med att skapa anpassade funktioner kan du [hämta och installera det här paketet](assets/custom-functions.zip) i din AEM-instans.

## Använda anpassade funktioner

I följande video får du hjälp med att använda den anpassade funktionen i regelredigeraren för ett anpassat formulär
>[!VIDEO](https://video.tv.adobe.com/v/3445845?quality=12&learn=on&captions=swe)
