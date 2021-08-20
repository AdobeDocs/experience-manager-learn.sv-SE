---
title: Skapa anpassat formulär
description: Skapa och konfigurera anpassningsbara formulär att använda formulärdatamodellens förifyllningstjänst
feature: Adaptiv Forms
version: 6.4,6.5
kt: 5813
thumbnail: kt-5813.jpg
topic: Utveckling
role: User
level: Beginner
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '609'
ht-degree: 0%

---


# Skapa anpassat formulär

Hittills har vi skapat följande

* Databas med 2 tabeller - `newhire` och `beneficiaries`
* Konfigurerad datakälla för anslutningen för Apache Sling
* RDBMS-baserad formulärdatamodell

Nästa steg är att skapa och konfigurera ett adaptivt formulär för att använda formulärdatamodellen.  Om du vill få förstartsfunktionen kan du [hämta och importera](assets/fdm-demo-af.zip) exempelformulär. Exempelformuläret innehåller ett avsnitt som visar information om medarbetarna och ett annat avsnitt som visar medarbetarnas mottagare.

## Koppla formulär till formulärdatamodell

Exempelformuläret som ingår i kursen är inte kopplat till någon formulärdatamodell. För att konfigurera formuläret så att det använder formulärdatamodellen måste vi göra följande:

* Välj FDMDemo-formuläret
* Klicka på _Egenskaper_->_Formulärmodell_
* Välj Formulärdatamodell i listrutan
* Sök efter och välj den formulärdatamodell som skapades i den tidigare lektionen.
* Klicka på _Spara och stäng_

## Konfigurera förifyllningstjänst

Det första steget är att koppla förifyllningstjänsten för formuläret. Följ stegen nedan för att associera förifyllningstjänsten

* Välj formuläret `FDMDemo`
* Klicka på _Redigera_ för att öppna formuläret i redigeringsläge
* Välj Formulärbehållare i innehållshierarkin och klicka på skiftnyckelsikonen för att öppna dess egenskapssida
* Välj _Förifyllningstjänsten för formulärdatamodell_ i listrutan Förifyll tjänst
* Klicka på den blå ☑ för att spara ändringarna

* ![prefill-service](assets/fdm-prefill.png)

## Konfigurera medarbetarinformation

Nästa steg är textfälten i det adaptiva formuläret som binds till elementen i formulärdatamodellen. Du måste öppna egenskapsbladet för följande fält och ange dess bindRef enligt nedan


| Fältnamn | Bind ref |
|------------|--------------------|
| FirstName | /newhire/FirstName |
| LastName | /newhire/lastName |

>[!NOTE]
>
>Du kan lägga till ytterligare textfält och binda dem till lämpliga element i formulärdatamodellen

## Konfigurera mottagarregister

Nästa steg är att visa de anställdas förmånstagare i tabellform. Exempelformuläret innehåller en tabell med 4 kolumner och en rad. Vi måste konfigurera tabellen så att den växer beroende på antalet mottagare.

* Öppna formuläret i redigeringsläge.
* Expandera rotpanelen->Dina mottagare->Tabell
* Välj Rad1 och klicka på skiftnyckelsikonen för att öppna egenskapsbladet.
* Ange bindningsreferensen till **/newhere/GetEmployeeBeneficiaries**
* Ange inställningarna för Upprepa - Minsta antal till 1 och Högsta antal till 5.
* Din konfiguration av Row1 bör se ut som skärmbilden nedan
   ![radkonfigurera](assets/configure-row.PNG)
* Klicka på den blå ☑ för att spara ändringarna

## Bind radceller

Slutligen måste vi binda radcellerna till elementen i formulärdatamodellen.

* Expandera rotpanelen->Dina mottagare->Tabell->Rad1
* Ange bindningsreferens för varje radcell enligt tabellen nedan

| Radcell | Bindningsreferens |
|------------|----------------------------------------------|
| Förnamn | /newhire/GetEmployeeBeneficiaries/firstName |
| Efternamn | /newhire/GetEmployeeBeneficiaries/lastname |
| Relation | /newhire/GetEmployeeBeneficiaries/relation |
| Procent | /newhire/GetEmployeeBeneficiaries/percentage |

* Klicka på den blå ☑ för att spara ändringarna

## Testa formuläret

Vi måste nu öppna formuläret med rätt empID i URL:en. Följande två länkar fyller i formulär med information från databasen
[Formulär med empID=207](http://localhost:4502/content/dam/formsanddocuments/fdmdemo/jcr:content?wcmmode=disabled&amp;empID=207)
[Formulär med empID=208](http://localhost:4502/content/dam/formsanddocuments/fdmdemo/jcr:content?wcmmode=disabled&amp;empID=208)

## Felsökning

Mitt formulär är tomt och har inga data

* Kontrollera att formulärdatamodellen returnerar rätt resultat.
* Formuläret är associerat med rätt formulärdatamodell
* Kontrollera fältbindningarna
* Kontrollera stdout-loggfilen. Du bör se att empID skrivs till filen.Om du inte ser det här värdet kanske formuläret inte använder den anpassade mallen som angavs.

Tabellen är inte ifylld

* Kontrollera bindningen för rad1
* Kontrollera att upprepade inställningar för Rad1 har angetts korrekt (Min =1 och Max = 5 eller fler)

