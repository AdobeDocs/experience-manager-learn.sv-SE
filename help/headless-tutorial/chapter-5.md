---
title: Kapitel 5 - Sidor för redigering av innehållstjänster
description: Kapitel 5 i den AEM självstudiekursen Headless handlar om att skapa sidor från mallarna som definieras i kapitel 4. Dessa sidor fungerar som JSON HTTP-slutpunkter.
translation-type: tm+mt
source-git-commit: 22ccd6627a035b37edb180eb4633bc3b57470c0c
workflow-type: tm+mt
source-wordcount: '592'
ht-degree: 0%

---


# Kapitel 5 - Sidor för redigering av innehållstjänster

Kapitel 5 i den AEM självstudiekursen Headless handlar om att skapa sidan med hjälp av mallarna som definieras i kapitel 4. Den sida som skapas i det här kapitlet fungerar som JSON HTTP-slutpunkt för mobilappen.

>[!NOTE]
>
> Arkitekturen för sidinnehåll `/content/wknd-mobile/en/api` har förbyggts. Bassidorna i `en` och `api` tjänar ett arkitektoniskt och organisatoriskt syfte, men är inte absolut nödvändiga. Om API-innehåll kan lokaliseras är det bästa sättet att följa de vanliga metoderna för att organisera sidorna för Language Copy och Multi-site Manager, eftersom API-sidor kan lokaliseras precis som vilken AEM Sites-sida som helst.

## Skapa API-sidan för händelser

1. Navigera till **[!UICONTROL AEM]>[!UICONTROL Sites]>[!DNL WKND Mobile]>[!DNL English]>[!DNL API]**.
1. **Tryck på etiketten för API-sidan** och tryck sedan på knappen **Skapa** i det övre åtgärdsfältet och skapa en ny API-sida för händelser under API-sidan.
   1. Tryck på **Skapa** i det övre åtgärdsfältet
   1. Välj **händelsens API** -mall
   1. I fältet **Namn** anger du **händelser**
   1. I fältet **Titel** anger du API:t för **händelser**
   1. Tryck på **Skapa** i det övre åtgärdsfältet för att skapa sidan
   1. Tryck på **Klar** för att återgå till AEM Sites-administratören

>[!VIDEO](https://video.tv.adobe.com/v/28340/?quality=12&learn=on)

## Om du redigerar API-sidan för händelser

>[!NOTE]
>
> Projektet tillhandahåller CSS för att ge vissa grundläggande format för författarupplevelsen.

1. Redigera API-sidan för **händelser** genom att gå till **AEM > Webbplatser > WKND Mobile > Engelska > API**, markera API-sidan för **händelser** och trycka på **Redigera** i det övre åtgärdsfältet.
1. Lägg till en **logotypbild** som ska visas i appen genom att dra och släppa den från Resurssökning till bildkomponentens platshållare.
   * Använd den logotyp som finns på `/content/dam/wknd-mobile/images/wknd-logo.png`.

1. Lägg till **taggrad** som ska visas ovanför händelserna.
   1. Redigera **Text** -komponenten
   1. Ange texten:
      1. `The WKND is here.`

1. Markera de **händelser** som ska visas:
   1. Ange följande konfiguration på fliken **Egenskaper** :
      * Model: **Event**
      * Överordnad sökväg: **/content/dam/wknd-mobile/en/events**
      * Taggar: **&lt;Lämna tomt>**
   1. Ange följande konfiguration på fliken **Elements** :
      * Ta bort alla listade element för att se till att ALLA element i händelseinnehållet visas.

>[!VIDEO](https://video.tv.adobe.com/v/28339/?quality=12&learn=on)

## Granska JSON-utdata från API-sidan

JSON-utdata och dess format kan granskas genom att begära sidan med `.model.json` väljaren.

Denna JSON-struktur (eller detta schema) måste vara väl förstådd av konsumenterna av detta API. Det är viktigt att API-konsumenterna förstår vilka aspekter av strukturen som är fasta (dvs. Event-API:ts logotyp (bild) och tagg live (text) och som är flytande (dvs. de händelser som listas under komponenten Lista över innehållsfragment).

Om det här kontraktet bryts på ett publicerat API kan det leda till felaktigt beteende i de appar som används.

1. På nya webbläsarflikar begär du API-sidorna för händelser med hjälp av `.model.json` väljaren, som anropar AEM Content Services JSON Exporter, och serialiserar sidan och komponenterna i en normaliserad, väldefinierad JSON-struktur.

   Den JSON-struktur som skapas av dessa sidor är den struktur som förbrukande program måste anpassa sig till.

1. Begär API-sidan för **händelser** som **JSON**.

   * [http://localhost:4502/content/wknd-mobile/en/api/events.model.json](http://localhost:4502/content/wknd-mobile/en/api/events.model.tidy.json)

   Resultatet bör se ut ungefär som:

![AEM Content Services JSON-utdata](assets/chapter-5/json-output.png)

>[!NOTE]
>
> Denna JSON kan skrivas ut på ett **jämnt** (formaterat) sätt för läsbarhet genom att använda `.tidy` väljaren:
> * [http://localhost:4502/content/wknd-mobile/en/api/events.model.tidy.json](http://localhost:4502/content/wknd-mobile/en/api/events.model.tidy.json)


## Nästa steg

Du kan också installera [com.adobe.aem.guides.wknd-mobile.content.chapter-5.zip](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest) -innehållspaketet på AEM Author via [AEM Package Manager](http://localhost:4502/crx/packmgr/index.jsp). Det här paketet innehåller de konfigurationer och det innehåll som beskrivs i det här och föregående kapitel i självstudien.

* [Kapitel 6 - Visa innehållet i AEM Publish som JSON](./chapter-6.md)
