---
title: Snabba upp materialets hastighet med AEM
description: Lär dig använda AEM Style Systems för att ge designers, innehållsförfattare och utvecklare i organisationen möjlighet att skapa och leverera upplevelser i den hastighet och i den omfattning som kunderna förväntar sig.
solution: Experience Manager
exl-id: 449cd133-6ab6-456e-a0ad-30e3dea9b75b
duration: 171
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '817'
ht-degree: 0%

---

# Snabba upp materialets hastighet med AEM

I den här artikeln får du lära dig hur du använder AEM system för att ge designers, innehållsförfattare och utvecklare i organisationen möjlighet att skapa och leverera upplevelser i den hastighet och i den omfattning som kunderna förväntar sig.

## Ökning

AEM Style Systems har fyra fördelar:

* Mallförfattare kan definiera formatklasser i en komponents eller sidas innehållsprincip
* Innehållsförfattare kan välja format som ska användas på en hel sida eller när en komponent på en sida redigeras
* Komponenter och mallar görs mer flexibla genom att författare kan återge alternativa visuella varianter
* Behovet av att utveckla anpassade komponenter och/eller komplexa dialogrutor för att presentera komponentvariationer minskar eller elimineras helt

## Inledande konfiguration och användning

Konfigurationen i fem steg liknar ett standardarbetsflöde för komponentutveckling.

| **Ledarskap** | **Designer** | **Utvecklare/arkitekt** | **Mallförfattare** | **Innehållsförfattare** |
| --- | --- | --- | --- | --- |
| Bestämmer innehåll och mål för den komponenten | Bestämmer visuell och upplevelsebaserad presentation av innehåll | Utvecklar CSS och JS för att ge stöd åt upplevelsen. Definierar och tillhandahåller klassnamn som ska användas | Konfigurerar mallprofiler för formaterade komponenter genom att lägga till CSS-klassnamn som definieras av utvecklare. Användarvänliga namn bör användas för varje format. | När du redigerar sidor används format för att få önskat utseende och känsla |

Detta är den första konfigurationen, men många av våra kunder har fått större flexibilitet genom att effektivisera den här processen, till exempel genom att överföra sin CSS till DAM, som tillåter uppdateringar av format utan att behöva distribueras. Andra kunder har en komplett uppsättning verktygsklasser, som gör att de kan utveckla komponenter och format som sedan kan utnyttjas utan driftsättning eller utveckling.

Stilsystem har några olika varianter:

1. Layoutstilar

   * Flera ändringar av design och layout

   * Används för väldefinierad och identifierbar återgivning

1. Visningsformat
   * Mindre variationer som inte ändrar formattens grundläggande karaktär

   * Du kan till exempel ändra färgschema, teckensnitt, bildorientering osv.

1. Informationsformat

   * Visa/dölj fält

>[!NOTE]
>
>Vi rekommenderar att du tittar på vårt [Customer Success-webbinarium](https://adobecustomersuccess.adobeconnect.com/pob610c9mffjmp4/) med Will Brisbane och Joseph Van Buskirk för en demonstration av de här funktionerna.

## God praxis

* Förstärk standardstil först
   * Layout och visning av komponent när den släpps på sidan innan formatsystem används
   * Det här bör vara den mest använda återgivningen
* Försök att bara visa formatalternativ som har en effekt när det är möjligt
   * Om ineffektiva kombinationer exponeras, se till att de inte orsakar negativa effekter
   * Exempel: en layoutstil som anger bildens placering och åtföljs av ett ineffektivt visningsformat som styr bildens placering
* Anpassa layoutstilar efter kombinerade visningsstilar
   * Minskar antalet permutationer som måste kvalitetskontrolleras
   * Ser till att varumärkesstandarderna följs
   * Förenklar redigering för innehållsförfattare
   * Hjälper till att skapa en enhetlig webbplatsidentitet
* Var försiktig med kombinerade format
   * Både mellan och inom kategorier
* Tilldela lämplig tid för att grundligt testa kombinerade format
   * Hjälper till att undvika oönskade effekter
* Minimera antalet stilalternativ och permutationer
   * Alltför många alternativ kan leda till bristande varumärkeskonsekvens för utseende och känsla
   * Kan skapa förvirring för innehållsförfattare som behöver kombinationer för att uppnå önskad effekt
   * Ökar de permutationer som måste kvalitetskontrolleras
* Använd användarvänliga etiketter och kategorier
   * &quot;Blue&quot; och &quot;Red&quot; i stället för &quot;Primary&quot; och &quot;Secondary
   * &quot;Card&quot; och &quot;Hero&quot; i stället för &quot;Variation A&quot; och &quot;Variation B&quot;
   * Detta kan vara mer generellt för vissa kunder. Designteamet, affärsteamet och innehållsteamet är mycket bekanta med vad deras primära och sekundära färger är eller vilka varianter de testar. Men för att flexibiliteten ska bli mer flexibel och för att eventuella framtida ändringar ska kunna ske kan det vara mer effektivt att använda specifika termer.

## Viktiga uppgifter

Style Systems minskar behovet av komplexa dialogrutor, men de är inte något dialogbyte. De förenklar saker, men det kan finnas tillfällen då du vill använda komponentegenskaper eller dialogrutor i stället för att skapa ett formatsystem för det.

De kan effektivisera processer ur ett utvecklingsperspektiv. Du kan få flera olika stilar av samma innehåll med ett och samma stilsystem. På samma sätt kan du, från ett redigeringsperspektiv, istället för att utbilda författare, och författare som måste komma ihåg vilken komponent som ska användas i vilket palats, snabba upp redigeringsprocessen.

Saker är helt enkelt renare. HTML i kärnkomponenterna är mycket detaljerade. Om du gör allt detta på CSS-nivå blir komponentbygget snabbare och koden blir också renare.

Slutligen är användningen av Style Systems mer konst än vetenskapen. Som vi har diskuterat finns det ett antal bästa metoder, men du får flexibilitet i hur du anpassar organisationens konfiguration.

Mer information finns på vårt [Customer Success Webinar](https://adobecustomersuccess.adobeconnect.com/pob610c9mffjmp4/) med Will Brisbane och Joseph Van Buskirk.

Läs mer om strategi och tankeledarskap på navet [Nöjda kunder](https://experienceleague.adobe.com/docs/customer-success/customer-success/overview.html).
