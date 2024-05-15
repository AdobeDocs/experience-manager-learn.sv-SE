---
title: AEM Forms med JSON-schema och data [del 1]
description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
feature: Adaptive Forms
doc-type: Tutorial
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: c588bdca-b8a8-4de2-97e0-ba08b195699f
duration: 50
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '258'
ht-degree: 0%

---

# Skapa anpassat formulär baserat på JSON-schema


Möjligheten att skapa Adaptiv Forms baserat på JSON-schema introducerades i AEM Forms 6.3. Detaljerad information om hur du skapar Adaptive Forms med JSON-schema finns i detta [artikel](https://experienceleague.adobe.com/docs/experience-manager-65/forms/adaptive-forms-advanced-authoring/adaptive-form-json-schema-form-model.html).

När du har skapat ett adaptivt formulär baserat på JSON-schema är nästa steg att lagra skickade data i databasen. I detta syfte kommer vi att använda den nya JSON-datatypen som introducerats av olika databasleverantörer. För den här artikeln använder vi MySQL 8-databasen för att lagra inskickade data.

MySql 8-databasen användes för den här artikeln. MySQL introducerade en ny datatyp som heter [JSON](https://dev.mysql.com/doc/refman/8.0/en/json.html). Detta gör det enklare att lagra och fråga JSON-objekt. Vi lagrar inskickade data i en kolumn av typen JSON i vår databas.

Följande skärmbild visar de skickade formulärdata som lagras i datatypen JSON. Kolumnen &quot;formdata&quot; är av typen JSON. Vi lagrade också namnet på formuläret som är associerat med data i kolumnformulärnamnet

>[!NOTE]
>
>Kontrollera att json-schemafilen har rätt namn. Det måste till exempel namnges i följande format &lt;name>schema.json. Din schemafil kan alltså vara pantbrev.schema.json eller credit.schema.json.


![datastyrd](assets/datastored.gif)


[Exempel på JSON-scheman som kan användas för att skapa Adaptiv Forms.](assets/samplejsonschemas.zip). Ladda ned och zippa upp zip-filen för att få JSON-scheman
