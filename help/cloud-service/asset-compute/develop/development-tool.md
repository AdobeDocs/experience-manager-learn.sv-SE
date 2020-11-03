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
source-git-commit: 6f5df098e2e68a78efc908c054f9d07fcf22a372
workflow-type: tm+mt
source-wordcount: '536'
ht-degree: 0%

---


# Verktyg för beräkning av tillgångar

Verktyget Resursberäkning är en lokal webbenhet som gör det möjligt för utvecklare att konfigurera och köra Assets Computer-arbetare lokalt, utanför den AEM SDK:n mot Assets Compute-resurserna i Adobe I/O Runtime.

## Kör verktyget Resursberäkning

Verktyget Resursberäkning kan köras från roten av projektet Resursberäkning via det terminala kommandot:

```
$ aio app run
```

Utvecklingsverktyget startas på __http://localhost:9000__ och öppnas automatiskt i ett webbläsarfönster. För att utvecklingsverktyget ska kunna köras måste [en giltig, autogenererad devToolToken anges via en frågeparameter](#troubleshooting__devtooltoken).

## Förstå gränssnittet för verktyg för utveckling av tillgångsberäkning{#interface}

![Verktyg för beräkning av tillgångar](./assets/development-tool/asset-compute-dev-tool.png)

1. __Källfil:__ Välja källfil används för att:
   + Markerade resursens binärfil som kommer att vara den `source` binära fil som skickas till Asset Compute-arbetaren
   + Överför källfiler
1. __Definition av tillgångsberäkningsprofil(er):__ Definierar den Asset Compute-arbetare som ska köras inklusive parametrar: inklusive arbetarens URL-slutpunkt, det resulterande återgivningsnamnet och eventuella parametrar
1. __Kör:__ Knappen Kör kör profilen Resursberäkning enligt definitionen i redigeraren för konfigurationsprofilen Resursberäkning
1. __Avbryt:__ Knappen Avbryt avbryter en körning som initierats från att trycka på knappen Kör
1. __Begäran/svar:__ Tillhandahåller HTTP-begäran och svar till/från Asset Compute-arbetaren som körs i Adobe I/O Runtime. Detta kan vara användbart vid felsökning
1. __Aktiveringsloggar:__ Loggarna som beskriver hur resursberäkningsarbetaren körs, tillsammans med eventuella fel. Den här informationen finns även i `aio app run` standardversionen
1. __Återgivningar:__ Visar alla återgivningar som genererats av körningen av Asset Compute-arbetaren
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

+ [Felaktigt YAML-indrag](../troubleshooting.md#incorrect-yaml-indentation)
+ [gränsen för memorySize är för låg](../troubleshooting.md#memorysize-limit-is-set-too-low)
+ [Utvecklingsverktyget kan inte starta eftersom private.key saknas](../troubleshooting.md#missing-private-key)
+ [Felaktig listruta för källfiler](../troubleshooting.md#source-files-dropdown-incorrect)
+ [Frågeparametern devToolToken saknas eller är ogiltig](../troubleshooting.md#missing-or-invalid-devtooltoken-query-parameter)
+ [Det går inte att ta bort källfiler](../troubleshooting.md#unable-to-remove-source-files)
+ [Återgivningen returnerade delvis ritad/skadad](../troubleshooting.md#rendition-returned-partially-drawn-or-corrupt)
