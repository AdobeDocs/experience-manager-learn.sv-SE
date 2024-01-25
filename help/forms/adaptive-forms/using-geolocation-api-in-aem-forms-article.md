---
title: Använda Geolocation-API:er i Adaptive Forms
description: Fyll i adressfält i formuläret med hjälp av API:n för geopositionering
feature: Adaptive Forms
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 50db6155-ee83-4ddb-9e3a-56e8709222db
last-substantial-update: 2020-03-20T00:00:00Z
duration: 104
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '366'
ht-degree: 0%

---

# Använda Geolocation-API:er i Adaptive Forms{#using-geolocation-api-s-in-adaptive-forms}

I den här artikeln ska vi titta närmare på hur du använder Google Geolocation API för att fylla i fält i ett adaptivt formulär. Detta är vanligt när du vill fylla i aktuella adressfält i ett formulär.

Följande steg har utförts för att använda Geolocation-API:t i Adaptive Forms.

1. [Hämta API-nyckel](https://developers.google.com/maps/documentation/javascript/get-api-key) från Google till Google Maps. Du kan få en provnyckel som gäller i ett år.

1. Anpassat formulärfragment skapades med fält för den aktuella adressen

1. Geolocation-API:t anropades för click-händelsen för image-objektet i det adaptiva formuläret

1. JSON-data som returnerades av API-anropet parsades och värdena för anpassade formulärfält ställdes in i enlighet med detta.

```javascript
navigator.geolocation.getCurrentPosition(showPosition);
function showPosition(position) 
{
console.log(" I am inside the showPosition in fragment");
console.log("Latitude: " + position.coords.latitude + "Longitude " + position.coords.longitude);
var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+position.coords.latitude+","+position.coords.longitude+"&key=<your_api_key>";
  console.log(url);
  
  $.getJSON(url,function (data, textStatus){
    
    var location=data.results[0].formatted_address;
    console.log(location);
    
    for(i=0;i<data.results[0].address_components.length;i++)
        {
          if(data.results[0].address_components[i].types[0] == "street_number")
            {
              streetNumber.value = data.results[0].address_components[i].long_name;
            }
          if(data.results[0].address_components[i].types[0] == "route")
            {
              streetName.value = data.results[0].address_components[i].long_name;
            }
            if(data.results[0].address_components[i].types[0] == "postal_code")
            {
              
              zipCode.value = data.results[0].address_components[i].long_name;
            }
            if(data.results[0].address_components[i].types[0] == "locality")
            {
              
              city.value = data.results[0].address_components[i].long_name;
            }
          if(data.results[0].address_components[i].types[0] == "administrative_area_level_1")
            {
              
              state.value = data.results[0].address_components[i].long_name;
            }
        }
    
  });
}
```

![Fälten fylls i med geoloaction API](assets/capture-4.gif)

På rad 1 används HTML Geolocation API för att hämta den aktuella platsen. När den aktuella platsen har hämtats skickar vi den aktuella platsen till funktionen showPosition.

I funktionen showPosition använder vi Google-API:t för att hämta adressinformation för den angivna latituden och longituden.

Den JSON som returneras av API tolkas sedan för att ange fälten för adaptiv form.

>[!NOTE]
>
>I testsyfte kan du använda HTTP-protokollet med localhost i URL:en.
>
>För produktionsservern måste du aktivera SSL för din AEM Server för att få den här funktionen.
>
>Exemplet som är kopplat till den här artikeln har testats med den amerikanska adressen. Om du vill använda den här funktionen på andra geografiska platser kan du behöva justera JSON-tolkningen.

Så här aktiverar du den här funktionen på servern:

* Installera och starta AEM Forms-servern.
> Den här funktionen testades i AEM Forms 6.3 och senare
* [Hämta Google API-nyckel](https://developers.google.com/maps/documentation/javascript/get-api-key).
* [Importera resurser som hör till den här artikeln till AEM.](assets/geolocationapi.zip)
* [Öppna det adaptiva formulärfragmentet i redigeringsläge.](http://localhost:4502/editor.html/content/forms/af/currentaddressfragment.html)
* Öppna regelredigeraren för komponenten Bildval.
* Ersätt &lt;your_api_key> med Google API Key.
* Spara ändringarna.
* [Förhandsgranska formuläret](http://localhost:4502/content/dam/formsanddocuments/currentaddressfragment/jcr:content?wcmmode=disabled).
* Klicka på ikonen &quot;geolocation&quot; (geopositionering).
* Formuläret ska fyllas i med den aktuella platsen.
