---
title: AEM Forms med JSON-schema och data [del 1]
seo-title: AEM Forms med JSON-schema och data[del1]
description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
seo-description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
feature: Adaptive Forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
topic: Development
role: Developer
level: Experienced
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '299'
ht-degree: 0%

---


# Skapa anpassat formulär baserat på JSON-schema


Möjligheten att skapa Adaptiv Forms baserat på JSON-schema introducerades i AEM Forms 6.3. Detaljerad information om hur du skapar Adaptive Forms med JSON-schema finns i den här [artikeln](https://helpx.adobe.com/experience-manager/6-3/forms/using/adaptive-form-json-schema-form-model.html).

När du har skapat ett adaptivt formulär baserat på JSON-schema är nästa steg att lagra skickade data i databasen. I detta syfte kommer vi att använda den nya JSON-datatypen som introducerats av olika databasleverantörer. För den här artikeln använder vi MySQL 8-databasen för att lagra inskickade data.

MySql 8-databasen användes för den här artikeln. MySQL introducerade en ny datatyp som heter [JSON](https://dev.mysql.com/doc/refman/8.0/en/json.html). Detta gör det enklare att lagra och fråga JSON-objekt. Vi kommer att lagra inskickade data i en kolumn av typen JSON i vår databas.

Följande skärmbild visar de skickade formulärdata som lagras i datatypen JSON. Kolumnen &quot;formdata&quot; är av typen JSON. Vi lagrade också namnet på formuläret som är associerat med data i kolumnformulärnamnet

>[!NOTE]
>
>Kontrollera att json-schemafilen har rätt namn. Det måste till exempel namnges i följande format: &lt;name>schema.json. Din schemafil kan alltså vara pantbrev.schema.json eller credit.schema.json.


![datastyrd](assets/datastored.gif)


[Exempel på JSON-scheman som kan användas för att skapa Adaptiv Forms.](assets/samplejsonschemas.zip). Ladda ned och zippa upp zip-filen för att få JSON-scheman

