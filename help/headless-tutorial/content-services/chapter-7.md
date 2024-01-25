---
title: Kapitel 7 - Använda AEM innehållstjänster från en mobilapp - Innehållstjänster
description: Kapitel 7 i självstudiekursen innehåller Android-mobilappen som kan använda redigerat innehåll från AEM Content Services.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: d6b6d425-842a-43a9-9041-edf78e51d962
duration: 512
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '1350'
ht-degree: 0%

---

# Kapitel 7 - Använda AEM innehållstjänster från en mobilapp

I kapitel 7 i självstudiekursen används en Android-mobilapp för att förbruka innehåll från AEM Content Services.

## Android-mobilappen

I den här självstudiekursen används en **enkelt Android-mobilapp** för att förbruka och visa händelseinnehåll som exponeras av AEM Content Services.

Användning av [Android](https://developer.android.com/) är i stort sett oviktigt, och den förbrukande mobilappen kan skrivas i vilket ramverk som helst för vilken mobilplattform som helst, till exempel iOS.

Android används som självstudiekurs eftersom det går att köra en Android-emulator på Windows, macOS och Linux, dess popularitet och att det kan skrivas som Java, ett språk som utvecklarna förstår väl AEM.

*Självstudiekursens Android-mobilapp är **not**är avsedda att instruera dig hur du bygger Android-mobilappar eller förmedlar vedertagna standarder för Android-utveckling, men snarare att illustrera hur AEM Content Services kan användas från ett mobilprogram.*

### Hur AEM innehållstjänster driver mobilappsupplevelsen

![Mappning av mobilapp till innehållstjänster](assets/chapter-7/content-services-mapping.png)

1. The **logo** enligt definitionen i [!DNL Events API] sida **Bildkomponent**.
1. The **tagg** enligt definition i [!DNL Events API] sida **Textkomponent**.
1. Detta **Händelselista** härleds från serialiseringen av händelseinnehållsfragment som visas via den konfigurerade **Content Fragment List-komponent**.

## Demonstration av mobilappar

>[!VIDEO](https://video.tv.adobe.com/v/28345?quality=12&learn=on)

### Konfigurera mobilappen för icke-lokal värdanvändning

Om AEM inte körs **http://localhost:4503** värden och port kan uppdateras i mobilappens [!DNL Settings] för att peka på egenskapen AEM Publicera värd/port.

>[!VIDEO](https://video.tv.adobe.com/v/28344?quality=12&learn=on)

## Kör mobilappen lokalt

1. Hämta och installera [Android Studio](https://developer.android.com/studio/install) för att installera Android-emulatorn.
1. **Ladda ned** Android [!DNL APK] fil [GitHub > Assets > wknd-mobile.x.x.xapk](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
1. Öppna **Android Studio**
   * När Android Studio startas första gången uppmanas du att installera [!DNL Android SDK] kommer att presentera. Acceptera standardinställningarna och slutför installationen.
1. Öppna Android Studio och välj **Profil eller felsök APK**
1. Markera APK-filen (**wknd-mobile.x.x.x.apk**) nedladdad i steg 2 och klicka på **OK**
   * Om du uppmanas att göra det **Skapa en ny mapp**, eller **Använd befintlig**, markera **Använd befintlig**.
1. När du startar Android Studio första gången högerklickar du på **wknd-mobile.x.x.x** i projektlistan och välj **Öppna modulinställningar**.
   * Under **Moduler > wknd-mobile.x.x > fliken Beroenden**, markera **Android API 29-plattform**. Tryck på OK för att stänga och spara ändringarna.
   * Om du inte gör det visas ett felmeddelande om att välja Android SDK när du försöker starta emulatorn.
1. Öppna **AVD Manager** genom att välja **Verktyg > AVD Manager** eller knacka på **AVD Manager** i det övre fältet.
1. I **AVD Manager** fönster, klicka **+ Skapa virtuell enhet..** om du inte redan har registrerat enheten.
   1. Till vänster väljer du **Telefon** kategori.
   1. Välj en **Pixel 2**.
   1. Klicka på **Nästa** -knappen.
   1. Välj **Q** med **API-nivå 29**.
      * När du startar AVD Manager första gången ombeds du ladda ned det versionshanterade API:t. Klicka på nedladdningslänken bredvid Q-versionen och slutför nedladdningen och installationen.
   1. Klicka på **Nästa** -knappen.
   1. Klicka på **Slutför** -knappen.
1. Stäng **AVD Manager** -fönstret.
1. I det övre menyfältet väljer du **wknd-mobile.x.x.x** från **Kör/redigera konfigurationer** nedrullningsbar meny.
1. Tryck på **Kör** knapp intill markerad **Kör/redigera konfiguration**
1. I popup-fönstret väljer du den nyskapade **[!DNL Pixel 2 API 29]** virtuell enhet och knacka **OK**
1. Om [!DNL WKND Mobile] programmet inte laddas omedelbart, sök efter och tryck på **[!DNL WKND]** -ikon från Android-startskärmen i emulatorn.
   * Om emulatorn startas men emulatorns skärm förblir svart trycker du på **effekt** i emulatorns verktygsfönster intill emulatorfönstret.
   * Klicka och håll ned musknappen och dra om du vill bläddra i den virtuella enheten.
   * Uppdatera innehållet från AEM genom att dra nedåt från överkanten tills ikonen Uppdatera visas och sedan släppa.

>[!VIDEO](https://video.tv.adobe.com/v/28341?quality=12&learn=on)

## Koden för mobilappar

I det här avsnittet beskrivs den Android-kod för mobilappar som de flesta interagerar med och är beroende av AEM Content Services och JSON-utdata.

Vid inläsning skapar mobilappen `HTTP GET` till `/content/wknd-mobile/en/api/events.model.json` som är AEM Content Services slutpunkt konfigurerad att tillhandahålla innehållet som driver mobilappen.

På grund av den redigerbara mallen för API:t för händelser (`/content/wknd-mobile/en/api/events.model.json`) är låst kan mobilappen kodas för att söka efter specifik information på specifika platser i JSON-svaret.

### Kodflöde på hög nivå

1. Öppna [!DNL WKND Mobile] Appen anropar en `HTTP GET` begäran till AEM Publish `/content/wknd-mobile/en/api/events.model.json` för att samla in innehållet för att fylla i mobilappens användargränssnitt.
2. När du har tagit emot innehåll från AEM, var och en av de tre vyelementen i mobilappen, **logotyp, taggrad och händelselista**, initieras med innehåll från AEM.
   * För att binda AEM till visningselementet i mobilappen är det JSON som representerar varje AEM objekt mappat till ett Java POJO, som i sin tur är bundet till Android-visningselementet.
      * Image Component JSON → Logo POJO → Logo ImageView
      * Textkomponent JSON → TagLine POJO → Text ImageView
      * Content Fragment List JSON → Events POJO→Events RecyclerView
   * *Koden för mobilappen kan mappa JSON till POJO på grund av de välkända platserna i det större JSON-svaret. Kom ihåg att JSON-tangenterna för&quot;image&quot;,&quot;text&quot; och&quot;contentfragmentlist&quot; styrs av AEM komponenters nodnamn. Om dessa nodnamn ändras kommer mobilappen att brytas eftersom den inte kommer att kunna hämta nödvändigt innehåll från JSON-data.*

#### AEM Content Services-slutpunkten anropas

Nedan följer en destillation av koden i mobilappens `MainActivity` Ansvarig för att anropa AEM Content Services för att samla in innehåll som driver upplevelsen av mobilappar.

```
protected void onCreate(Bundle savedInstanceState) {
    ...
    // Create the custom objects that will map the JSON -> POJO -> View elements
    final List<ViewBinder> viewBinders = new ArrayList<>();

    viewBinders.add(new LogoViewBinder(this, getAemHost(), (ImageView) findViewById(R.id.logo)));
    viewBinders.add(new TagLineViewBinder(this, (TextView) findViewById(R.id.tagLine)));
    viewBinders.add(new EventsViewBinder(this, getAemHost(), (RecyclerView) findViewById(R.id.eventsList)));
    ...
    initApp(viewBinders);
}

private void initApp(final List<ViewBinder> viewBinders) {
    final String aemUrl = getAemUrl(); // -> http://localhost:4503/content/wknd-mobile/en/api/events.mobile.json
    JsonObjectRequest request = new JsonObjectRequest(aemUrl, null,
        new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                for (final ViewBinder viewBinder : viewBinders) {
                    viewBinder.bind(response);
                }
            }
        },
        ...
    );
}
```

`onCreate(..)` är initieringsgaffeln för mobilappen och registrerar de 3 anpassade `ViewBinders` ansvarar för parsning av JSON och bindning av värdena till `View` -element.

`initApp(...)` anropas sedan vilket gör att HTTP-GET-begäran skickas till AEM Content Services-slutpunkten vid AEM Publish för att samla in innehållet. När ett giltigt JSON-svar tas emot, skickas JSON-svaret till varje `ViewBinder` som ansvarar för att analysera JSON och binda den till mobilen `View` -element.

#### Tolka JSON-svaret

Nu ska vi titta på `LogoViewBinder`, vilket är enkelt, men tar upp flera viktiga saker att tänka på.

```
public class LogoViewBinder implements ViewBinder {
    ...
    public void bind(JSONObject jsonResponse) throws JSONException, IOException {
        final JSONObject components = jsonResponse.getJSONObject(":items").getJSONObject("root").getJSONObject(":items");

        if (components.has("image")) {
            final Image image = objectMapper.readValue(components.getJSONObject("image").toString(), Image.class);

            final String imageUrl = aemHost + image.getSrc();
            Glide.with(context).load(imageUrl).into(logo);
        } else {
            Log.d("WKND", "Missing Logo");
        }
    }
}
```

Den första raden i `bind(...)` navigerar nedåt i JSON-svaret via tangenterna **:items → root → :items** som representerar AEM Layoutbehållare som komponenterna lades till i.

Härifrån görs en kontroll av en nyckel med namnet **image**, som representerar bildkomponenten (återigen är det viktigt att det här nodnamnet → JSON-nyckeln är stabil). Om objektet finns läses det och mappas till [anpassad bild-POJO](#image-pojo) via Jackson `ObjectMapper` bibliotek. Bildens POJO utforskas nedan.

Till sist, logotypens `src` läses in i Android ImageView med [!DNL Glide] hjälpbibliotek.

Observera att vi måste tillhandahålla AEM schema, värd och port (via `aemHost`) till AEM Publish-instansen som AEM Content Services tillhandahåller bara JCR-sökvägen (dvs. `/content/dam/wknd-mobile/images/wknd-logo.png`) till det refererade innehållet.

#### Bild-POJO{#image-pojo}

Om det är valfritt används [Jackson ObjectMapper](https://fasterxml.github.io/jackson-databind/javadoc/2.9/com/fasterxml/jackson/databind/ObjectMapper.html) eller liknande funktioner från andra bibliotek som Gson, hjälper dig att mappa komplexa JSON-strukturer till Java-POJO:er utan att behöva arbeta direkt med de inbyggda JSON-objekten. I det här enkla fallet mappar vi `src` från `image` JSON-objekt, till `src` i Image POJO direkt via `@JSONProperty` anteckning.

```
package com.adobe.aem.guides.wknd.mobile.android.models;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Image {
    @JsonProperty(value = "src")
    private String src;

    public String getSrc() {
        return src;
    }
}
```

Event POJO, som kräver att du väljer många fler datapunkter från JSON-objektet, har fler fördelar än den här tekniken, som vi bara vill ha är `src`.

## Utforska upplevelsen av mobilappar

Nu när du har en förståelse för hur AEM Content Services kan skapa en mobil upplevelse kan du använda det du lärt dig för att utföra följande steg och se ändringarna återspeglas i mobilappen.

Uppdatera mobilappen efter varje steg och bekräfta uppdateringen av mobilupplevelsen.

1. Skapa och publicera **new [!DNL Event] Innehållsfragment**
1. Avpublicera **befintlig [!DNL Event] Innehållsfragment**
1. Publicera en uppdatering av **Tagg Line**

## Grattis

**Du är klar med den AEM självstudiekursen Headless!**

Läs mer om AEM Content Services och AEM som Headless CMS på Adobe i annan dokumentation och annat material:

* [Använda innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/content-fragments/understand-content-fragments-and-experience-fragments.html)
* [AEM Användarhandbok för WCM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
* [AEM WCM Core Components Components Library](https://opensource.adobe.com/aem-core-wcm-components/library.html)
* [AEM WCM Core Components GitHub Project](https://github.com/adobe/aem-core-wcm-components)
* [Kodexempel för komponentexport](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/core/src/main/java/com/adobe/acs/samples/models/SampleComponentExporter.java)
