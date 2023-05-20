---
title: Vad är "The Dispatcher"?
description: Förstå vad en Dispatcher egentligen är.
version: 6.5
topic: Administration
feature: Dispatcher
role: Admin
level: Beginner
thumbnail: xx.jpg
exl-id: 96c8dd09-e0a7-4abc-b04b-a805aaa67502
source-git-commit: da0b536e824f68d97618ac7bce9aec5829c3b48f
workflow-type: tm+mt
source-wordcount: '256'
ht-degree: 1%

---

# Vad är &quot;The Dispatcher&quot;?

[Innehållsförteckning](./overview.md)

Börja med den grundläggande beskrivningen av vad som medför en AEM Dispatcher.

## Apache Web Server

Börja med en grundläggande installation av Apache Web Server på en Linux-server.

Grundläggande förklaring av vad en Apache-server gör:

- Följ enkla regler för att skicka filer över HTTP(s)-protokollen från dess statiska dokumentkatalog (`DocumentRoot`)
- Filer som lagras på en standardplats (`/var/www/html`) matchas på begäranden och återges i den begärande klientens webbläsare




## AEM specifik modulfil (`mod_dispatcher.so`)

Lägg sedan till ett plugin-program till Apache-webbservern som kallas Dispatcher-modulen

Grundläggande förklaring av vad gör Adobe AEM Dispatcher-modulen:

- Augments the default file handler
- Filtrerar bort felaktiga begäranden/Skyddar AEM mjuk näsa/slutpunkter
- Läs in saldon om det finns mer än en renderare
- Tillåter en cachekatalog i realtid/stöder tömning av mellanlagringsfiler
- Det är ytterdörren till alla AMS-installationer och levererar webbplatser och material till klientens webbläsare
- Den cachelagrar begäranden om återanvändning i mycket snabbare takt än en AEM kan göra på egen hand
- Mycket mer...

## Arbetsflöde för webbtrafik

Genom att förstå vilka delar som installeras tillsammans för att skapa en grundläggande Dispatcher-server får du en förståelse för det grundläggande arbetsflödet för webbtrafik för en Adobe Manager Services-konfiguration.
Detta bör hjälpa er att förstå vilken roll det spelar i systemkedjan som levererar innehåll till besökare av ert AEM innehåll.

<b>Serverar redan cachelagrat innehåll</b>

```
End User's Browser request 
    → Cloud Provider Load Balancer 
        → "The Dispatcher" 
            → Checks for cached request locally if found 
                → return request 
                    → End User
```

<b>Färskt innehåll från AEM</b>

```
End User's Browser request 
    → Cloud Provider Load Balancer 
        → "The Dispatcher" 
            → Checks for cached request locally if NOT found 
                → requests content from publisher 
                    → publisher sends content 
                        → Dispatcher adds content to cache and replies 
                            → End User
```

<b>Publicera och ändra innehåll</b>

```
AEM Author User activates content 
    → Triggers content to be replicated to Publisher 
        → Publisher gets content and triggers the flush request to Dispatcher 
            → Dispatcher invalidates changed content 
            * Next request for that content will request fresh copy from publisher *
```

[Nästa -> Grundläggande fillayout](./basic-file-layout.md)
