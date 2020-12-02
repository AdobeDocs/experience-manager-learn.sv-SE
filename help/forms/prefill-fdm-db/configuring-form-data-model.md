---
title: Konfigurerar formulärdatamodell
description: Skapa formulärdatamodell baserad på RDBMS-datakälla
feature: adaptive-forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
kt: 5812
thumbnail: kt-5812.jpg
translation-type: tm+mt
source-git-commit: e99779b5d42bb9a3b258e2bbe815defde9d40bf7
workflow-type: tm+mt
source-wordcount: '492'
ht-degree: 0%

---



# Konfigurerar formulärdatamodell

## Poolad datakälla för Apache Sling-anslutning

Det första steget för att skapa en RDBMS-baserad formulärdatamodell är att konfigurera Apache Sling Connection Pooled DataSource. Konfigurera datakällan genom att följa stegen nedan:

* Peka webbläsaren på [configMgr](http://localhost:4502/system/console/configMgr)
* Sök efter **Sammanslagen datakälla för Apache Sling-anslutning**
* Lägg till en ny post och ange de värden som visas på skärmbilden.
* ![datakälla](assets/data-source.png)
* Spara ändringarna

>[!NOTE]
>URI:n, användarnamnet och lösenordet för JDBC-anslutningen ändras beroende på konfigurationen för MySQL-databasen.


## Skapar formulärdatamodell

* Peka webbläsaren på [Dataintegrering](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments-fdm)
* Klicka på _Skapa_->_Formulärdatamodell_
* Ange beskrivande namn och titel för formulärdatamodell som **Medarbetare**
* Klicka på _Nästa_
* Markera datakällan som skapades i det tidigare avsnittet (forumen)
* Klicka på _Skapa_->Redigera om du vill öppna den nya formulärdatamodellen i redigeringsläge
* Expandera noden _forum_ för att se medarbetarschemat. Expandera medarbetarnoden för att se de två tabellerna

## Lägg till entiteter i din modell

* Kontrollera att medarbetarnoden är expanderad
* Välj enhet för nybörjare och mottagare och klicka på _Lägg till markerat_

## Lägg till lästjänsten till en ny enhet

* Välj en enhet
* Klicka på _Redigera egenskaper_
* Välj Hämta i listrutan Lästjänst
* Klicka på +-ikonen för att lägga till en parameter i tjänsten get
* Ange de värden som visas på skärmbilden
* ![get-service](assets/get-service.png)
>[!NOTE]
> get-tjänsten förväntar sig ett värde som mappas till empID-kolumnen för entiteten. Det finns flera sätt att skicka det här värdet och i den här självstudien skickas empID via frågeparametern empID.
* Klicka på _Klar_ för att spara argumenten för get-tjänsten
* Klicka på _Klart_ om du vill spara ändringar i formulärdatamodellen

## Lägg till association mellan två entiteter

Associationerna som definieras mellan databasentiteter skapas inte automatiskt i formulärdatamodellen. Associationerna mellan entiteter måste definieras med formulärdatamodellens redigerare. Varje enhet som kan ha en eller flera mottagare måste vi definiera en-till-många-associering mellan de nya och stödmottagande enheterna.
Följande steg visar hur du skapar en en-till-många-association

* Välj en entitet och klicka på _Lägg till association_
* Ange en meningsfull titel och identifierare för associationen och andra egenskaper enligt skärmbilden nedan
   ![association](assets/association-entities-1.png)

* Klicka på ikonen _redigera_ under avsnittet Argument

* Ange de värden som visas på den här skärmbilden
* ![association-2](assets/association-entities.png)
* **Vi länkar de två enheterna med empID-kolumnen för mottagare och alla enheter.**
* Klicka på _Klart_ för att spara ändringarna

## Testa formulärdatamodellen

Vår formulärdatamodell har nu **_get_**-tjänst som godkänner empID och returnerar information om newhere och dess mottagare. Testa tjänsten genom att följa stegen nedan.

* Välj en enhet
* Klicka på _Testmodellobjekt_
* Ange ett giltigt empID och klicka på _Test_
* Du bör få resultat enligt bilden nedan
* ![test-fdm](assets/test-form-data-model.png)
