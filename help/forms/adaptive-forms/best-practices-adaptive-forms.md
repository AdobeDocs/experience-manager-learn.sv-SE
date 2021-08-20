---
title: Namngivningskonventioner och bästa praxis som ska följas när man skapar anpassningsbara formulär
description: Namngivningskonventioner och bästa praxis som ska följas när man skapar anpassningsbara formulär
feature: Adaptiv Forms
version: 6.3,6.4,6.5
topic: Utveckling
role: Developer
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '290'
ht-degree: 2%

---

# Bästa praxis

Adobe Experience Manager (AEM)-formulär kan hjälpa er att omvandla komplexa transaktioner till enkla, roliga digitala upplevelser. I följande dokument beskrivs några ytterligare metodtips som behöver följas när du utvecklar Adaptive Forms. Det här dokumentet är avsett att användas tillsammans med [det här dokumentet](https://helpx.adobe.com/experience-manager/6-3/forms/using/adaptive-forms-best-practices.html#Overview)

## Namnkonventioner

* **Paneler**
   * Panelnamn är från och med en versal.

* **Formulärfält**
   * Fältnamn är versaler och börjar med gemener.
   * Starta inte fältnamn med siffror
   * Inkludera inte bindestreck &quot;-&quot; i dina namn. Dessa motsvarar ett minustecken i koden och fungerar som operatorer i koden.
   * Namn kan innehålla bokstäver, siffror, understreck och dollartecken.
   * Namn måste börja med en bokstav
   * Namnen är skiftlägeskänsliga
   * Reserverade ord (som JavaScript-nyckelord) kan inte användas som namn. Håll utkik efter andra AF-specifika reserverade ord, som   som &quot;panel&quot;,&quot;name&quot;.
   * Inkludera inte bindestreck &quot;-&quot; i dina namn
* **Utveckla Forms**
   * Formulärfragment bör beaktas vid utveckling av stora formulär. Aktivera lazy loading av formulärfragment för snabbare inläsning   gånger
   * **DataModel**
      * Vi rekommenderar att adaptiv form kopplas till lämplig datamodell
   * **Objekthändelser**
      * Kod som rör ett objekts synlighet ska alltid placeras i synlighetshändelsen för det objektet.
   * **Skript**
      * Om koden som du skriver i ett adaptivt formulär sträcker sig över mer än fem synliga rader måste du flytta koden till ett klientbibliotek. Bäst är att lägga till funktionen i klientbiblioteket och sedan lägga till lämpliga jsdoc-taggar så att funktionen kan visas i regelredigeraren för adaptiv form.


