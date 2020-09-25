---
title: Verktyg för beräkning av tillgångar
description: Verktyget Resursberäkning är en lokal webbenhet som gör det möjligt för utvecklare att konfigurera och köra Assets Computer-arbetare lokalt, utanför den AEM SDK:n mot Assets Compute-resurserna i Adobe I/O Runtime.
feature: asset-compute
topics: renditions, development
version: cloud-service
activity: develop
audience: developer
doc-type: tutorial
kt: 6283
thumbnail: 40241.jpg
translation-type: tm+mt
source-git-commit: a71c61304bbc9d54490086b3313c823225fbe2e0
workflow-type: tm+mt
source-wordcount: '700'
ht-degree: 0%

---


# Verktyg för beräkning av tillgångar

Verktyget Resursberäkning är en lokal webbenhet som gör det möjligt för utvecklare att konfigurera och köra Assets Computer-arbetare lokalt, utanför den AEM SDK:n mot Assets Compute-resurserna i Adobe I/O Runtime.

## Kör verktyget Resursberäkning

Verktyget Resursberäkningsutveckling kan köras från roten av projektet Resursberäkning via terminalkommandot:

```
$ aio app run
```

Utvecklingsverktyget startas på __http://localhost:9000__ och öppnas automatiskt i ett webbläsarfönster. För att utvecklingsverktyget ska kunna köras måste [en giltig, autogenererad devToolToken anges via en frågeparameter](#troubleshooting__devtooltoken).

## Förstå gränssnittet för verktyg för utveckling av tillgångsberäkning{#interface}

![Verktyg för beräkning av tillgångar](./assets/development-tool/asset-compute-dev-tool.png)

1. __Källfil:__ Välja källfil används för att:
   + Markerade resursens binärfil som kommer att vara den `source` binära fil som skickas till Asset Compute-arbetaren
   + Överför källfiler
1. __Profildefinition för tillgångsberäkning:__ Definierar den Asset Compute-arbetare som ska köras inklusive parametrar: inklusive arbetarens URL-slutpunkt, det resulterande återgivningsnamnet och eventuella parametrar
1. __Kör:__ Knappen Kör kör profilen Resursberäkning enligt definitionen i redigeraren för konfigurationsprofilen Resursberäkning
1. __Avbryt:__ Knappen Avbryt avbryter en körning som initierats från att trycka på knappen Kör
1. __Begäran/svar:__ Tillhandahåller HTTP-begäran och svar till/från det program för beräkning av tillgångar som körs i Adobe Runtime. Detta kan vara användbart vid felsökning
1. __Aktiveringsloggar:__ Loggarna som beskriver hur resursberäkningsprogrammet körs, tillsammans med eventuella fel. Den här informationen finns även i `aio app run` standardversionen
1. __Återgivningar:__ Visar alla återgivningar som genererats av körningen av programmet Resursberäkning
1. __devToolToken-frågeparameter:__ En giltig `devToolToken` frågeparameter måste finnas för token för verktyget Resursberäkning. Denna token genereras automatiskt varje gång ett nytt utvecklingsverktyg skapas

### Kör en anpassad arbetare

>[!VIDEO](https://video.tv.adobe.com/v/40241?quality=12&learn=on)
_Klicka igenom hur du kör en inventeringsfunktion i utvecklingsverktyget (inget ljud)_

1. Kontrollera att verktyget Resursberäkning har startats från projektets rot med hjälp av `aio app run` kommandot.
1. Överför eller välj en [exempelbildfil i verktyget Resursberäkning](../assets/samples/sample-file.jpg)
   + Kontrollera att filen är markerad i listrutan __Källfil__
1. Granska textområdet för definition __av__ resursberäkningsprofil
   + Nyckeln definierar `worker` URL:en till den distribuerade resurshanteringspersonen
   + Nyckeln definierar namnet på den återgivning som ska genereras. `name`
   + Andra nycklar/värden kan anges i det här JSON-objektet och är tillgängliga i arbetaren under `rendition.instructions` objektet
      + Om du vill kan du lägga till värden för `size`, `contrast` och `brightness`:

         ```json
         {
             "renditions": [
                 {
                     "worker": "...",
                     "name": "rendition.png",
                     "size":"800",
                     "contrast": "0.30",
                     "brightness": "-0.15"
                 }
             ]
         }
         ```

1. Tryck på knappen __Kör__
1. Avsnittet ____ Återgivningar fylls i med en platshållare för återgivningar
1. När arbetaren är klar visas den genererade återgivningen i platshållaren för återgivningen

Om du ändrar koden för arbetaren medan utvecklingsverktyget körs kommer ändringarna att distribueras under körning. &quot;hot deploy&quot; (hot-driftsättning) tar flera sekunder, så låt distributionen slutföras innan arbetaren körs om från utvecklingsverktyget.

## Felsökning

### Felaktig listruta för källfiler{#troubleshooting__dev-tool-application-cache}

Verktyget Resursberäkning kan försättas i ett läge där inaktuella data hämtas och är mest märkbart i listrutan __Källfil__ med felaktiga objekt.

+ __Fel:__ I listrutan Källfil visas felaktiga objekt.
+ __Orsak:__ Inaktuellt cachelagrat webbläsarläge orsakar
+ __Upplösning:__ I webbläsaren rensar du helt webbläsarflikens programtillstånd, webbläsarcachen, lokal lagring och servicearbetare.

### Frågeparameter för devToolToken saknas{#troubleshooting__devtooltoken}

+ __Fel:__ Meddelande om&quot;obehörig&quot; i verktyget Resursberäkning
+ __Orsak:__ `devToolToken` saknas eller är ogiltigt
+ __Upplösning:__ Stäng webbläsarfönstret för verktyget Resursberäkning, avsluta alla processer som körs i utvecklingsverktyget och som har initierats via `aio app run` kommandot samt starta om utvecklingsverktyget (med `aio app run`).

### Det går inte att ta bort källfiler{#troubleshooting__remove-source-files}

+ __Fel:__ Det finns inget sätt att ta bort tillagda källfiler från utvecklingsverktygets användargränssnitt
+ __Orsak:__ Den här funktionen har inte implementerats
+ __Upplösning:__ Logga in på din molnlagringsleverantör med de autentiseringsuppgifter som anges i `.env`. Leta reda på den behållare som används av utvecklingsverktygen (anges även i `.env`), navigera till __källmappen__ och ta bort alla källbilder. Du kan behöva utföra de steg som beskrivs i [källfilslistan felaktigt](#troubleshooting__dev-tool-application-cache) om de borttagna källfilerna fortfarande visas i listrutan eftersom de kan cachas lokalt i utvecklingsverktygets programläge.

   ![Microsoft Azure Blob Storage](./assets/development-tool/troubleshooting__remove-source-files.png)
