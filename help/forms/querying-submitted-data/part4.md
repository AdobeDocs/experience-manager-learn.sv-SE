---
title: AEM Forms med JSON-schema och data [del 4]
seo-title: AEM Forms med JSON-schema och data [del 4]
description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
seo-description: Självstudiekurs med flera delar för att vägleda dig genom stegen som ingår i att skapa ett adaptivt formulär med JSON-schema och fråga om skickade data.
feature: adaptive-forms
topics: development
audience: developer
doc-type: tutorial
activity: implement
version: 6.3,6.4,6.5
translation-type: tm+mt
source-git-commit: a0e5a99408237c367ea075762ffeb3b9e9a5d8eb
workflow-type: tm+mt
source-wordcount: '475'
ht-degree: 0%

---


# Frågar skickade data


Nästa steg är att fråga efter skickade data och visa resultaten i tabellform. För att uppnå detta kommer vi att använda följande programvara

[QueryBuilder](https://querybuilder.js.org/) - UI-komponent för att skapa frågor

[Datatabeller](https://datatables.net/)- Visar frågeresultaten i tabellformat.

Följande användargränssnitt har skapats för att aktivera frågor om skickade data. Endast de element som markerats som obligatoriska i JSON-schemat är tillgängliga för att fråga mot. På skärmbilden nedan frågar vi efter alla sändningar där deliverypref är SMS.

Det exempelgränssnitt som används för att fråga efter skickade data använder inte alla avancerade funktioner som finns i QueryBuilder. Du uppmuntras att prova dem själv.

![querybuilder](assets/querybuilderui.gif)

>[!NOTE]
>
>Den aktuella versionen av den här självstudiekursen stöder inte frågor i flera kolumner.

När du väljer ett formulär som ska utföra din fråga görs ett GET-anrop till **/bin/getdatasfromschema**. Det här GET-anropet returnerar de obligatoriska fält som är kopplade till formulärets schema. De obligatoriska fälten fylls sedan i i den nedrullningsbara listan i QueryBuilder så att du kan skapa frågan.

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

När du klickar på knappen GetResult görs ett Get-anrop till **&quot;/bin/querydata&quot;**. Vi skickar frågan som skapats av QueryBuilder-användargränssnittet till servern via frågeparametern. Servern masserar sedan frågan till SQL-fråga som kan användas för att fråga databasen. Om du till exempel söker efter alla produkter med namnet &quot;Mouse&quot; kommer frågesträngen i Query Builder att vara $.productname = &quot;Mouse&quot;. Den här frågan kommer sedan att konverteras till följande

SELECT * from aemformswithjson .  formsending where JSON_EXTRACT( formsending.formdata,&quot;$.productName &quot;)= &#39;Mouse&#39;

Resultatet av den här frågan returneras för att fylla i tabellen i användargränssnittet.

Utför följande steg om du vill att exemplet ska köras på ditt lokala system

1. [Se till att du har följt alla steg som nämns här](part2.md)
1. [Importera Dashboardv2.zip med AEM Package Manager.](assets/dashboardv2.zip) Det här paketet innehåller alla nödvändiga paket, konfigurationsinställningar, anpassad sändning och exempelsida för att fråga efter data.
1. Skapa ett adaptivt formulär med JSON-exempelschemat
1. Konfigurera det adaptiva formuläret att skicka till den anpassade åtgärden för att skicka till&quot;customSubmitPx&quot;
1. Fyll i formuläret och skicka in
1. Peka webbläsaren på [dashboard.html](http://localhost:4502/content/AemForms/dashboard.html)
1. Markera formuläret och gör en enkel fråga

