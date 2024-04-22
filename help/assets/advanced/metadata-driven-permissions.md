---
title: Metadatadrivna behörigheter i AEM Assets
description: Metadatadrivna behörigheter är en funktion som används för att begränsa åtkomst baserat på metadataegenskaper för resurser i stället för mappstruktur.
version: Cloud Service
topic: Administration, Security
feature: User and Groups
role: Admin
level: Intermediate
jira: KT-13757
thumbnail: xx.jpg
doc-type: Tutorial
source-git-commit: 3b500873ee7307df590ac66dea541a1adf14d726
workflow-type: tm+mt
source-wordcount: '685'
ht-degree: 0%

---

# Metadatadrivna behörigheter{#metadata-driven-permissions}

Metadatadrivna behörigheter är en funktion som används för att tillåta åtkomstkontrollsbeslut på AEM Assets Author att baseras på metadataegenskaper för resurser i stället för på mappstrukturen. Med den här funktionen kan du definiera åtkomstkontrollprinciper som utvärderar attribut som resursstatus, typ eller anpassade metadataegenskaper som du definierar.

Låt oss se ett exempel. Kreatörerna överför sitt arbete till AEM Assets till den kampanjrelaterade mappen. Det kan vara en pågående resurs som inte har godkänts för användning. Vi vill försäkra oss om att marknadsförarna bara ser godkända mediefiler för den här kampanjen. Vi kan använda metadataegenskaper för att ange att en mediefil har godkänts och kan användas av marknadsförarna.

## Så här fungerar det

Om du aktiverar metadatadrivna behörigheter måste du definiera vilka egenskaper för metadata för resurser som ska leda till åtkomstbegränsningar, till exempel&quot;status&quot; eller&quot;varumärke&quot;. Dessa egenskaper kan sedan användas för att skapa åtkomstkontrollposter som anger vilka användargrupper som har åtkomst till resurser med specifika egenskapsvärden.

## Förutsättningar

Åtkomst till en AEM as a Cloud Service miljö som har uppdaterats till den senaste versionen krävs för att konfigurera metadatadrivna behörigheter.


## Utvecklingssteg

Så här implementerar du metadatadrivna behörigheter:

1. Avgör vilka metadataegenskaper för resurser som ska användas för åtkomstkontroll. I vårt fall blir det en egenskap som kallas `status`.
1. Skapa en OSGi-konfiguration `com.adobe.cq.dam.assetmetadatarestrictionprovider.impl.DefaultRestrictionProviderConfiguration.cfg.json` i ditt projekt.
1. Klistra in följande JSON i den skapade filen

   ```json
   {
     "restrictionPropertyNames":[
       "status"
     ],
     "restrictionPaths":[
       "/content/dam"
     ]
   }
   ```

1. Ersätt egenskapsnamnen och begränsningssökvägarna med de värden som krävs.


Innan du lägger till restriktionsbaserade åtkomstkontrollposter bör en ny post på översta nivån läggas till för att först neka läsåtkomst till alla grupper som är föremål för behörighetsutvärdering för resurser (t.ex.&quot;medarbetare&quot; eller liknande):

1. Navigera till fönstret Verktyg → Dokumentskydd → Behörigheter
1. Välj gruppen&quot;Medarbetare&quot; (eller någon annan anpassad grupp som alla användargrupper tillhör)
1. Klicka på Lägg till ACE i skärmens övre högra hörn
1. Välj /content/dam för sökväg
1. Ange jcr:läs för behörighet
1. Välj Neka för behörighetstyp
1. Under Begränsningar väljer du rep:ntNames och anger dam:Asset som begränsningsvärde
1. Klicka på Spara

![Neka åtkomst](./assets/metadata-driven-permissions/deny-access.png)

Åtkomstkontrollposter kan nu läggas till för att ge läsåtkomst till användargrupper baserat på egenskapsvärden för tillgångsmetadata.

1. Navigera till fönstret Verktyg → Dokumentskydd → Behörigheter
1. Markera önskad grupp
1. Klicka på Lägg till ACE i skärmens övre högra hörn
1. Välj /content/dam (eller en undermapp) som sökväg
1. Ange jcr:läs för behörighet
1. Välj Tillåt för behörighetstyp
1. Under Begränsningar väljer du ett av de konfigurerade egenskapsnamnen för tillgångsmetadata (egenskaperna som definieras i OSGi-konfigurationen inkluderas här)
1. Ange det obligatoriska egenskapsvärdet för metadata i fältet Begränsningsvärde
1. Klicka på plusikonen (+) för att lägga till begränsningen i åtkomstkontrollposten
1. Klicka på Spara

![Tillåt åtkomst](./assets/metadata-driven-permissions/allow-access.png)

Exempelmappen innehåller några resurser.

![Administratörsvy](./assets/metadata-driven-permissions/admin-view.png)

När du har konfigurerat behörigheter och angett metadataegenskaperna för resursen i enlighet med detta kommer användare (marknadsföringsanvändare i vårt fall) endast att se godkända resurser.

![Marknadsföringsvy](./assets/metadata-driven-permissions/marketeer-view.png)

## Fördelar och överväganden

Fördelarna med metadatadrivna behörigheter är bland annat:

- Detaljerad kontroll över åtkomsten till materialet baserat på specifika attribut.
- Frikoppling av åtkomstkontrollprinciper från mappstrukturen, vilket ger en mer flexibel resursorganisation.
- Möjlighet att definiera komplexa åtkomstkontrollsregler baserat på flera metadataegenskaper.

>[!NOTE]
>
> Observera:
> 
> - Metadataegenskaper utvärderas mot begränsningarna med hjälp av String-likhet (andra datatyper som ännu inte stöds, t.ex. datum)
> - Om du vill tillåta flera värden för en restriktionsegenskap kan du lägga till ytterligare begränsningar i åtkomstkontrollposten genom att välja samma egenskap i listrutan &quot;Välj typ&quot; och ange ett nytt begränsningsvärde (t.ex. `status=approved`, `status=wip`) och klicka på &quot;+&quot; för att lägga till begränsningen i posten
> ![Tillåt flera värden](./assets/metadata-driven-permissions/allow-multiple-values.png)
> - Flera begränsningar i en enda åtkomstkontrollpost med olika egenskapsnamn (t.ex. `status=approved`, `brand=Adobe`) utvärderas som ett AND-villkor, vilket innebär att den valda användargruppen ges läsåtkomst till resurser med `status=approved AND brand=Adobe`
> ![Tillåt flera begränsningar](./assets/metadata-driven-permissions/allow-multiple-restrictions.png)
> - Om du lägger till en ny åtkomstkontrollpost med en metadataegenskapsbegränsning skapas ett OR-villkor för posterna, t.ex. en enskild post med en begränsning `status=approved` och en enda post med `brand=Adobe` utvärderas som `status=approved OR brand=Adobe`
> ![Tillåt flera begränsningar](./assets/metadata-driven-permissions/allow-multiple-aces.png)
