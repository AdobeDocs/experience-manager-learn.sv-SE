---
title: AEM Forms med JSON-schema och data [del 4]
description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
feature: Adaptive Forms
doc-type: Tutorial
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: a8d8118d-f4a1-483f-83b4-77190f6a42a4
duration: 99
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '432'
ht-degree: 0%

---

# Frågar skickade data


Nästa steg är att fråga efter inskickade data och visa resultaten i tabellform. För att uppnå detta använder vi följande program:

[QueryBuilder](https://querybuilder.js.org/) - UI-komponent för att skapa frågor

[Datatabeller](https://datatables.net/)- Om du vill visa frågeresultaten i tabellformat.

Följande användargränssnitt har skapats för att aktivera frågor om skickade data. Endast de element som markerats som obligatoriska i JSON-schemat är tillgängliga för att fråga mot. På skärmbilden nedan frågar vi efter alla sändningar där deliverypref är SMS.

Det exempelgränssnitt som används för att fråga efter skickade data använder inte alla avancerade funktioner som finns i QueryBuilder. Du uppmuntras att prova dem själv.

![querybuilder](assets/querybuilderui.gif)

>[!NOTE]
>
>Den aktuella versionen av den här självstudiekursen stöder inte frågor i flera kolumner.

När du väljer ett formulär som ska utföra din fråga görs ett GET-anrop till **/bin/getdatakeysfromschema**. Det här GET-anropet returnerar de obligatoriska fält som är kopplade till formulärets schema. De obligatoriska fälten fylls sedan i i den nedrullningsbara listan i QueryBuilder så att du kan skapa frågan.

Följande kodfragment gör ett anrop till metoden getRequiredColumnsFromSchema i JSONSchemaOperations-tjänsten. Vi skickar egenskaperna och de nödvändiga elementen i schemat till det här metodanropet. Arrayen som returneras av det här funktionsanropet används sedan för att fylla i listrutan för frågebyggaren

```java
public JSONArray getData(String formName) throws SQLException, IOException {

  org.json.JSONArray arrayOfDataKeys = new org.json.JSONArray();
  JSONObject jsonSchema = jsonSchemaOperations.getJSONSchemaFromDataBase(formName);
  Map<String, String> refKeys = new HashMap<String, String>();

  try {
   JSONObject properties = jsonSchema.getJSONObject("properties");
   JSONArray requiredFields = jsonSchema.has("required") ? jsonSchema.getJSONArray("required") : null;
   jsonSchemaOperations.getRequiredColumnsFromSchema(properties, arrayOfDataKeys, "", jsonSchema, refKeys,
     requiredFields);
  } catch (JSONException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
  return arrayOfDataKeys;

 }
```

När du klickar på knappen GetResult görs ett Get-anrop till **/bin/querydata**. Vi skickar frågan som skapats av QueryBuilder-användargränssnittet till servern via frågeparametern. Servern masserar sedan frågan till SQL-fråga som kan användas för att fråga databasen. Om du till exempel söker efter alla produkter med namnet &quot;Mouse&quot; är frågesträngen i Query Builder `$.productname = 'Mouse'`. Den här frågan konverteras sedan till följande

VÄLJ &#42; från aemformswithjson .  formsending where JSON_EXTRACT( formsending.formdata,&quot;$.productName &quot;)= &#39;Mouse&#39;

Resultatet av den här frågan returneras för att fylla i tabellen i användargränssnittet.

Utför följande steg om du vill att exemplet ska köras på ditt lokala system:

1. [Kontrollera att du har följt alla steg som nämns här](part2.md)
1. [Importera Dashboard v2.zip med AEM Package Manager.](assets/dashboardv2.zip) Det här paketet innehåller alla nödvändiga paket, konfigurationsinställningar, anpassad sändning och exempelsida för att fråga efter data.
1. Skapa ett adaptivt formulär med exempelschema för json
1. Konfigurera det adaptiva formuläret att skicka till den anpassade åtgärden för att skicka till&quot;customSubmithelpx&quot;
1. Fyll i formuläret och skicka in
1. Peka webbläsaren på [dashboard.html](http://localhost:4502/content/AemForms/dashboard.html)
1. Markera formuläret och gör en enkel fråga
