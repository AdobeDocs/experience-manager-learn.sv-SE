---
title: Konfigurerar formulärdatamodell
description: Skapa formulärdatamodell baserad på RDBMS-datakälla
feature: Adaptive Forms
version: 6.4,6.5
kt: 5812
thumbnail: kt-5812.jpg
topic: Development
role: Developer
level: Beginner
exl-id: 5fa4638f-9faa-40e0-a20d-fdde3dbb528a
source-git-commit: b069d958bbcc40c0079e87d342db6c5e53055bc7
workflow-type: tm+mt
source-wordcount: '491'
ht-degree: 0%

---

# Konfigurerar formulärdatamodell

## Poolad datakälla för Apache Sling-anslutning

Det första steget för att skapa en RDBMS-baserad formulärdatamodell är att konfigurera Apache Sling Connection Pooled DataSource. Konfigurera datakällan genom att följa stegen nedan:

* Peka webbläsaren till [configMgr](http://localhost:4502/system/console/configMgr)
* Sök efter **Poolad datakälla för Apache Sling-anslutning**
* Lägg till en ny post och ange de värden som visas på skärmbilden.
* ![datakälla](assets/data-source.png)
* Spara ändringarna

>[!NOTE]
>URI:n, användarnamnet och lösenordet för JDBC-anslutningen ändras beroende på konfigurationen för MySQL-databasen.


## Skapar formulärdatamodell

* Peka webbläsaren till [Dataintegrering](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments-fdm)
* Klicka _Skapa_->_Formulärdatamodell_
* Ge formulärdatamodellen beskrivande namn och titel, t.ex. **Medarbetare**
* Klicka på _Nästa_
* Markera datakällan som skapades i det tidigare avsnittet (forumen)
* Klicka _Skapa_->Redigera för att öppna den nya formulärdatamodellen i redigeringsläge
* Expandera _forum_ nod för att se medarbetarschemat. Expandera medarbetarnoden för att se de två tabellerna

## Lägg till entiteter i din modell

* Kontrollera att medarbetarnoden är expanderad
* Välj enhet för nybörjare och mottagare och klicka på _Lägg till markerade_

## Lägg till lästjänsten till en ny enhet

* Välj en enhet
* Klicka på _Redigera egenskaper_
* Välj Hämta i listrutan Lästjänst
* Klicka på +-ikonen för att lägga till en parameter i tjänsten get
* Ange de värden som visas på skärmbilden
* ![get-service](assets/get-service.png)
>[!NOTE]
> get-tjänsten förväntar sig ett värde som mappas till empID-kolumnen för entiteten. Det finns flera sätt att skicka det här värdet och i den här självstudien skickas empID via frågeparametern empID.
* Klicka _Klar_ för att spara argumenten för get-tjänsten
* Klicka _Klar_ spara ändringar i formulärdatamodellen

## Lägg till association mellan två entiteter

Associationerna som definieras mellan databasentiteter skapas inte automatiskt i formulärdatamodellen. Associationerna mellan entiteter måste definieras med formulärdatamodellens redigerare. Varje enhet som kan ha en eller flera mottagare måste vi definiera en-till-många-associering mellan de nya och stödmottagande enheterna.
Följande steg visar hur du skapar en en-till-många-association

* Välj en enhet och klicka på _Lägg till association_
* Ange en meningsfull titel och identifierare för associationen och andra egenskaper enligt skärmbilden nedan
   ![association](assets/association-entities-1.png)

* Klicka på _redigera_ ikon under avsnittet Argument

* Ange de värden som visas på den här skärmbilden
* ![association-2](assets/association-entities.png)
* **Vi länkar de två enheterna med empID-kolumnen för mottagare och alla enheter.**
* Klicka på _Klar_ för att spara ändringarna

## Testa formulärdatamodellen

Vår formulärdatamodell har nu **_get_** tjänst som godkänner empID och returnerar uppgifter om nybörjaren och dess mottagare. Testa tjänsten genom att följa stegen nedan.

* Välj en enhet
* Klicka på _Testmodellobjekt_
* Ange ett giltigt empID och klicka på _Testa_
* Du bör få resultat enligt bilden nedan
* ![test-fdm](assets/test-form-data-model.png)
