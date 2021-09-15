---
title: asset compute Development Tool
description: Asset compute Development Tool är en lokal webbenhet som gör det möjligt för utvecklare att konfigurera och köra Assets Computer Workers lokalt, utanför AEM SDK mot Asset compute-resurserna i Adobe I/O Runtime.
feature: Asset Compute Microservices
topics: renditions, development
version: Cloud Service
activity: develop
audience: developer
doc-type: tutorial
kt: 6283
thumbnail: 40241.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: cbe08570-e353-4daf-94d1-a91a8d63406d
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '536'
ht-degree: 0%

---

# asset compute Development Tool

Asset compute Development Tool är en lokal webbenhet som gör det möjligt för utvecklare att konfigurera och köra Assets Computer Workers lokalt, utanför AEM SDK mot Asset compute-resurserna i Adobe I/O Runtime.

## Kör utvecklingsverktyget Asset compute

Asset compute Development Tool kan köras från Asset compute-projektets rot via terminalkommandot:

```
$ aio app run
```

Utvecklingsverktyget startas på __http://localhost:9000__ och öppnas automatiskt i ett webbläsarfönster. För att utvecklingsverktyget ska kunna köras måste [en giltig, autogenererad devToolToken anges via en frågeparameter](#troubleshooting__devtooltoken).

## Förstå gränssnittet för Asset compute Development Tools{#interface}

![asset compute Development Tool](./assets/development-tool/asset-compute-dev-tool.png)

1. __Källfil:__ Källfilsvalet används för att:
   + Markerade resursens binärfil som ska vara den `source`-binärfil som skickas till Asset compute-arbetaren
   + Överför källfiler
1. __definition av Asset compute-profil(er):__ Definierar den Asset compute-arbetare som ska köras inklusive parametrar: inklusive arbetarens URL-slutpunkt, det resulterande återgivningsnamnet och eventuella parametrar
1. __Kör:__ Knappen Kör kör den Asset compute-profil som definierats i Asset compute konfigurationsprofilredigerare
1. __Avbryt:__ Knappen Avbryt avbryter en körning som initierats från att trycka på knappen Kör
1. __Begäran/svar:__ Tillhandahåller HTTP-begäran och svar till/från den Asset compute-arbetare som körs i Adobe I/O Runtime. Detta kan vara användbart vid felsökning
1. __Aktiveringsloggar:__ Loggarna som beskriver Asset compute-arbetarens körning, tillsammans med eventuella fel. Den här informationen finns även i `aio app run`-standarden
1. __Återgivningar:__ Visar alla återgivningar som genererats av körningen av Asset compute-arbetaren
1. __devToolToken-frågeparameter:__ Asset compute Development Tool-token kräver att det finns en giltig  `devToolToken` frågeparameter. Denna token genereras automatiskt varje gång ett nytt utvecklingsverktyg skapas

### Kör en anpassad arbetare

>[!VIDEO](https://video.tv.adobe.com/v/40241?quality=12&learn=on)

_Klicka igenom hur du kör ett Asset compute-arbete i utvecklingsverktyget (inget ljud)_

1. Kontrollera att utvecklingsverktyget Asset compute har startats från projektets rot med kommandot `aio app run`.
1. Ladda upp eller välj en [exempelbildfil](../assets/samples/sample-file.jpg) i Asset compute Development Tool
   + Kontrollera att filen är markerad i listrutan __Källfil__
1. Granska textområdet __Asset compute-profildefinition__
   + `worker`-nyckeln definierar URL:en till den distribuerade Asset compute-arbetaren
   + `name`-nyckeln definierar namnet på återgivningen som ska genereras
   + Andra nycklar/värden kan anges i det här JSON-objektet och är tillgängliga i arbetaren under objektet `rendition.instructions`
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
1. Avsnittet __Återgivningar__ fylls i med en platshållare för återgivningar
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
