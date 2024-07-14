---
title: Kapitel 7 - Använda AEM innehållstjänster från en mobilapp - Innehållstjänster
description: I kapitel 7 i självstudiekursen körs Android mobilapp med vilket innehåll som ska redigeras från AEM innehållstjänster kan användas.
feature: Content Fragments, APIs
topic: Headless, Content Management
role: Developer
level: Beginner
doc-type: Tutorial
exl-id: d6b6d425-842a-43a9-9041-edf78e51d962
duration: 467
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '1350'
ht-degree: 0%

---

# Kapitel 7 - Använda AEM innehållstjänster från en mobilapp

I kapitel 7 i självstudiekursen används en Android-mobilapp för att förbruka innehåll från AEM Content Services.

## Android mobilapp

I den här självstudien används en **enkel inbyggd Android-mobilapp** för att förbruka och visa händelseinnehåll som exponeras av AEM Content Services.

Användningen av [Android](https://developer.android.com/) är i stort sett oviktig, och den förbrukande mobilappen kan skrivas i vilket ramverk som helst för vilken mobilplattform som helst, till exempel iOS.

Android används som självstudiekurs eftersom det går att köra en Android Emulator i Windows, macOs och Linux, dess popularitet och att det kan skrivas som Java, ett språk som utvecklarna förstår väl AEM.

*Självstudiekursens Android-mobilapp är **inte**avsedd att instruera dig att skapa Android-mobilappar eller förmedla bästa praxis för Android-utveckling, utan snarare att illustrera hur AEM innehållstjänster kan användas från ett mobilprogram.*

### Hur AEM innehållstjänster driver mobilappsupplevelsen

![Mappning av mobilapp till innehållstjänster](assets/chapter-7/content-services-mapping.png)

1. **logotypen** som den definieras av **bildkomponenten** på sidan [!DNL Events API].
1. **Taggraden** som den definieras på **Text-komponenten** för sidan [!DNL Events API].
1. Den här **händelselistan** härleds från serialiseringen av händelseinnehållsfragment som visas via den konfigurerade **listkomponenten för innehållsfragment**.

## Demonstration av mobilappar

>[!VIDEO](https://video.tv.adobe.com/v/28345?quality=12&learn=on)

### Konfigurera mobilappen för icke-lokal värdanvändning

Om AEM Publish inte körs på **http://localhost:4503** kan värden och portar uppdateras i mobilappens [!DNL Settings] så att de pekar på egenskapen AEM Publish värd/port.

>[!VIDEO](https://video.tv.adobe.com/v/28344?quality=12&learn=on)

## Kör mobilappen lokalt

1. Hämta och installera [Android Studio](https://developer.android.com/studio/install) för att installera Android Emulator.
1. **Hämta** Android [!DNL APK]-filen [GitHub > Assets > wknd-mobile.x.x.xapk](https://github.com/adobe/aem-guides-wknd-mobile/releases/latest)
1. Öppna **Android Studio**
   * När Android Studio startas första gången visas en uppmaning om att installera [!DNL Android SDK]. Acceptera standardinställningarna och slutför installationen.
1. Öppna Android Studio och välj **Profil eller Felsök APK**
1. Markera APK-filen (**wknd-mobile.x.x.apk**) som hämtades i steg 2 och klicka på **OK**
   * Om du uppmanas att **skapa en ny mapp**, eller **använda befintlig**, väljer du **Använd befintlig**.
1. När du startar Android Studio första gången högerklickar du på **wknd-mobile.x.x** i projektlistan och väljer **Öppna modulinställningar**.
   * Under **Moduler > wknd-mobile.x.x.x > fliken Beroenden** väljer du **Android API 29 Platform**. Tryck på OK för att stänga och spara ändringarna.
   * Om du inte gör det visas ett felmeddelande om att välja Android SDK när du försöker starta emulatorn.
1. Öppna **AVD Manager** genom att välja **Verktyg > AVD Manager** eller trycka på ikonen **AVD Manager** i det övre fältet.
1. I fönstret **AVD Manager** klickar du på **+ Skapa virtuell enhet..** om du inte redan har registrerat enheten.
   1. Välj kategorin **Telefon** till vänster.
   1. Välj en **pixel 2**.
   1. Klicka på knappen **Nästa**.
   1. Välj **Q** med **API Level 29**.
      * När du startar AVD Manager första gången ombeds du ladda ned det versionshanterade API:t. Klicka på nedladdningslänken bredvid Q-versionen och slutför nedladdningen och installationen.
   1. Klicka på knappen **Nästa**.
   1. Klicka på knappen **Slutför**.
1. Stäng fönstret **AVD Manager**.
1. I det övre menyfältet väljer du **wknd-mobile.x.x** i listrutan **Kör/redigera konfigurationer**.
1. Tryck på knappen **Kör** bredvid den markerade **Kör/redigera konfiguration**
1. I popup-fönstret markerar du den nya virtuella enheten **[!DNL Pixel 2 API 29]** och trycker på **OK**
1. Om appen [!DNL WKND Mobile] inte läses in omedelbart söker du efter och trycker på ikonen **[!DNL WKND]** från Android hemskärm i emulatorn.
   * Om emulatorn startas men emulatorns skärm förblir svart trycker du på knappen **power** i emulatorns verktygsfönster bredvid emulatorfönstret.
   * Klicka och håll ned musknappen och dra om du vill bläddra i den virtuella enheten.
   * Uppdatera innehållet från AEM genom att dra nedåt från överkanten tills ikonen Uppdatera
och publicera.

>[!VIDEO](https://video.tv.adobe.com/v/28341?quality=12&learn=on)

## Koden för mobilappar

I det här avsnittet beskrivs den Android Mobile App-kod som de flesta interagerar med och som är beroende av AEM Content Services och JSON-utdata.

Vid inläsning skapar mobilappen `HTTP GET` till `/content/wknd-mobile/en/api/events.model.json`, som är AEM Content Services-slutpunkt konfigurerad för att tillhandahålla innehållet som ska driva mobilappen.

Eftersom den redigerbara mallen för händelse-API:t (`/content/wknd-mobile/en/api/events.model.json`) är låst kan mobilappen kodas för att söka efter specifik information på specifika platser i JSON-svaret.

### Kodflöde på hög nivå

1. När appen [!DNL WKND Mobile] öppnas anropas en `HTTP GET`-begäran till AEM Publish på `/content/wknd-mobile/en/api/events.model.json` för att samla in innehållet för att fylla i användargränssnittet för mobilappen.
2. När du tar emot innehåll från AEM initieras vart och ett av de tre vyelementen i mobilappen, **logotypen, taggraden och händelselistan**, med innehållet från AEM.
   * För att binda AEM till visningselementet i mobilappen är det JSON som representerar varje AEM objekt mappat till en Java POJO, som i sin tur är bundet till elementet Android View.
      * Image Component JSON → Logo POJO → Logo ImageView
      * Textkomponent JSON → TagLine POJO → Text ImageView
      * Content Fragment List JSON → Events POJO→Events RecyclerView
   * *Koden för mobilappen kan mappa JSON till POJO på grund av de välkända platserna i det större JSON-svaret. Kom ihåg att JSON-tangenterna för&quot;image&quot;,&quot;text&quot; och&quot;contentfragmentlist&quot; styrs av AEM komponenters nodnamn. Om dessa nodnamn ändras kommer mobilappen att brytas eftersom den inte kan hämta nödvändigt innehåll från JSON-data.*

#### AEM Content Services-slutpunkten anropas

Nedan följer en destillation av koden i mobilappens `MainActivity` som anropar AEM Content Services för att samla in innehållet som driver upplevelsen av mobilappen.

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

`onCreate(..)` är initieringsgaffeln för mobilappen och registrerar de 3 anpassade `ViewBinders` som ansvarar för parsning av JSON och bindning av värdena till elementen `View`.

`initApp(...)` anropas sedan, vilket gör HTTP-GET-begäran till AEM Content Services-slutpunkten på AEM Publish för att samla in innehållet. När ett giltigt JSON-svar tas emot, skickas JSON-svaret till varje `ViewBinder` som ansvarar för att parsa JSON och binda det till de mobila `View` -elementen.

#### Tolka JSON-svaret

Därefter ska vi titta på `LogoViewBinder`, som är enkel, men flera viktiga saker att tänka på.

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

Den första raden i `bind(...)` navigerar nedåt i JSON-svaret via tangenterna **:items → root → :items** som representerar den AEM Layoutbehållare som komponenterna lades till i.

Härifrån görs en kontroll för en nyckel med namnet **image** som representerar Image-komponenten (återigen är det viktigt att det här nodnamnet → JSON-nyckeln är stabil). Om det här objektet finns, läses det och mappas till [anpassad bild-POJO](#image-pojo) via Jackson `ObjectMapper`-biblioteket. Bildens POJO utforskas nedan.

Slutligen läses logotypens `src` in i Android ImageView med hjälp av hjälpbiblioteket [!DNL Glide].

Observera att vi måste tillhandahålla AEM schema, värd och port (via `aemHost`) till den AEM Publish-instansen eftersom AEM Content Services bara tillhandahåller JCR-sökvägen (dvs. `/content/dam/wknd-mobile/images/wknd-logo.png`) till det refererade innehållet.

#### Bild-POJO{#image-pojo}

Om du väljer det här alternativet kan du använda [Jackson ObjectMapper](https://fasterxml.github.io/jackson-databind/javadoc/2.9/com/fasterxml/jackson/databind/ObjectMapper.html) eller liknande funktioner från andra bibliotek, som Gson, för att mappa komplexa JSON-strukturer till Java-POJO:er utan att behöva arbeta direkt med de inbyggda JSON-objekten. I det här enkla fallet mappar vi `src`-nyckeln från `image` JSON-objektet till `src`-attributet i Image POJO direkt via `@JSONProperty`-anteckningen.

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

Händelse-POJO, som kräver att du väljer många fler datapunkter från JSON-objektet, utnyttjar den här tekniken mer än den enkla bilden, som bara är `src`.

## Utforska upplevelsen av mobilappar

Nu när du har en förståelse för hur AEM Content Services kan skapa en mobil upplevelse kan du använda det du lärt dig för att utföra följande steg och se ändringarna återspeglas i mobilappen.

Uppdatera mobilappen efter varje steg och bekräfta uppdateringen av mobilupplevelsen.

1. Skapa och publicera **nytt [!DNL Event] innehållsfragment**
1. Avpublicera ett **befintligt [!DNL Event] innehållsfragment**
1. Publish kan uppdatera **taggraden**

## Grattis

**Du har slutfört den AEM självstudiekursen Headless!**

Läs mer om AEM Content Services och AEM som Headless CMS på Adobe i annan dokumentation och annat material:

* [Använda innehållsfragment](https://experienceleague.adobe.com/docs/experience-manager-learn/sites/content-fragments/understand-content-fragments-and-experience-fragments.html)
* [AEM Användarhandbok för WCM Core Components](https://experienceleague.adobe.com/docs/experience-manager-core-components/using/introduction.html)
* [AEM WCM Core Components Component Library](https://opensource.adobe.com/aem-core-wcm-components/library.html)
* [AEM WCM Core Components GitHub Project](https://github.com/adobe/aem-core-wcm-components)
* [Kodexempel för komponentexport](https://github.com/Adobe-Consulting-Services/acs-aem-samples/blob/master/core/src/main/java/com/adobe/acs/samples/models/SampleComponentExporter.java)
