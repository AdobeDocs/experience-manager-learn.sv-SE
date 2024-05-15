---
title: Metadatadrivna behörigheter i AEM Assets
description: Metadatadrivna behörigheter är en funktion som används för att begränsa åtkomst baserat på metadataegenskaper för resurser i stället för mappstruktur.
version: Cloud Service
topic: Administration, Security
feature: User and Groups
role: Admin
level: Intermediate
jira: KT-13757
doc-type: Tutorial
last-substantial-update: 2024-05-03T00:00:00Z
exl-id: 57478aa1-c9ab-467c-9de0-54807ae21fb1
duration: 158
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '738'
ht-degree: 0%

---

# Metadatadrivna behörigheter{#metadata-driven-permissions}

Metadatadrivna behörigheter är en funktion som används för att tillåta åtkomstkontrollsbeslut på AEM Assets Author att baseras på metadataegenskaper för resurser i stället för på mappstrukturen. Med den här funktionen kan du definiera åtkomstkontrollprinciper som utvärderar attribut som resursstatus, typ eller anpassade metadataegenskaper som du definierar.

Låt oss se ett exempel. Kreatörerna överför sitt arbete till AEM Assets till den kampanjrelaterade mappen. Det kan vara en pågående resurs som inte har godkänts för användning. Vi vill försäkra oss om att marknadsförarna bara ser godkända mediefiler för den här kampanjen. Vi kan använda metadataegenskaper för att ange att en mediefil har godkänts och kan användas av marknadsförarna.

## Så här fungerar det

Om du aktiverar metadatadrivna behörigheter måste du definiera vilka egenskaper för metadata för resurser som ska leda till åtkomstbegränsningar, till exempel&quot;status&quot; eller&quot;varumärke&quot;. Dessa egenskaper kan sedan användas för att skapa åtkomstkontrollposter som anger vilka användargrupper som har åtkomst till resurser med specifika egenskapsvärden.

## Förutsättningar

Åtkomst till en AEM as a Cloud Service miljö som har uppdaterats till den senaste versionen krävs för att konfigurera metadatadrivna behörigheter.

## OSGi-konfiguration {#configure-permissionable-properties}

För att implementera metadatadrivna behörigheter måste utvecklaren distribuera en OSGi-konfiguration till AEM as a Cloud Service, som möjliggör specifika metadata-egenskaper för resurser för att hantera metadatadrivna behörigheter.

1. Avgör vilka metadataegenskaper för resurser som ska användas för åtkomstkontroll. Egenskapsnamnen är JCR-egenskapsnamnen på resursens `jcr:content/metadata` resurs. I vårt fall blir det en egenskap som kallas `status`.
1. Skapa en OSGi-konfiguration `com.adobe.cq.dam.assetmetadatarestrictionprovider.impl.DefaultRestrictionProviderConfiguration.cfg.json` i ditt AEM Maven-projekt.
1. Klistra in följande JSON i den skapade filen:

   ```json
   {
     "restrictionPropertyNames":[
       "status",
       "brand"
     ],
     "enabled":true
   }
   ```

1. Ersätt egenskapsnamnen med obligatoriska värden.

## Återställ behörigheter för basresurs

Innan du lägger till restriktionsbaserade åtkomstkontrollposter bör en ny post på översta nivån läggas till för att först neka läsåtkomst till alla grupper som är föremål för behörighetsutvärdering för resurser (t.ex.&quot;medarbetare&quot; eller liknande):

1. Navigera till __Verktyg → Dokumentskydd → Behörigheter__ screen
1. Välj __Medarbetare__ grupp (eller annan anpassad grupp som alla användargrupper tillhör)
1. Klicka __Lägg till ACE__ i skärmens övre högra hörn
1. Välj `/content/dam` for __Bana__
1. Retur `jcr:read` for __Behörighet__
1. Välj `Deny` for __Behörighetstyp__
1. Under Begränsningar väljer du `rep:ntNames` och ange `dam:Asset` som __Begränsningsvärde__
1. Klicka __Spara__

![Neka åtkomst](./assets/metadata-driven-permissions/deny-access.png)

## Bevilja åtkomst till resurser via metadata

Åtkomstkontrollposter kan nu läggas till för att ge läsåtkomst till användargrupper baserat på [konfigurerade egenskapsvärden för tillgångsmetadata](#configure-permissionable-properties).

1. Navigera till __Verktyg → Dokumentskydd → Behörigheter__ screen
1. Välj de användargrupper som ska ha åtkomst till resurserna
1. Klicka __Lägg till ACE__ i skärmens övre högra hörn
1. Välj `/content/dam` (eller en undermapp) för __Bana__
1. Retur `jcr:read` for __Behörighet__
1. Välj `Allow` for __Behörighetstyp__
1. Under __Begränsningar__ väljer du en av [konfigurerade egenskapsnamn för tillgångsmetadata i OSGi-konfigurationen](#configure-permissionable-properties)
1. Ange det obligatoriska metadataegenskapsvärdet i dialogrutan __Begränsningsvärde__ fält
1. Klicka på __+__ om du vill lägga till begränsningen i åtkomstkontrollposten
1. Klicka __Spara__

![Tillåt åtkomst](./assets/metadata-driven-permissions/allow-access.png)

## Metadatadrivna behörigheter används

Exempelmappen innehåller några resurser.

![Administratörsvy](./assets/metadata-driven-permissions/admin-view.png)

När du har konfigurerat behörigheter och angett metadataegenskaperna för resursen i enlighet med detta kommer användare (marknadsföringsanvändare i vårt fall) endast att se godkända resurser.

![Marknadsföringsvy](./assets/metadata-driven-permissions/marketeer-view.png)

## Fördelar och överväganden

Fördelarna med metadatadrivna behörigheter är:

- Detaljerad kontroll över åtkomsten till materialet baserat på specifika attribut.
- Frikoppling av åtkomstkontrollprinciper från mappstrukturen, vilket ger en mer flexibel resursorganisation.
- Möjlighet att definiera komplexa åtkomstkontrollsregler baserat på flera metadataegenskaper.

>[!NOTE]
>
> Observera:
> 
> - Metadataegenskaper utvärderas mot begränsningar som använder __Stränglikhet__ (`=`) (andra datatyper eller operatorer stöds ännu inte, för större än (`>`) eller Date-egenskaper)
> - Om du vill tillåta flera värden för en restriktionsegenskap kan du lägga till ytterligare begränsningar i åtkomstkontrollposten genom att välja samma egenskap i listrutan &quot;Välj typ&quot; och ange ett nytt begränsningsvärde (t.ex. `status=approved`, `status=wip`) och klicka på &quot;+&quot; för att lägga till begränsningen i posten
> ![Tillåt flera värden](./assets/metadata-driven-permissions/allow-multiple-values.png)
> - __OCH begränsningar__ stöds, via flera begränsningar i en enda åtkomstkontrollpost med olika egenskapsnamn (t.ex. `status=approved`, `brand=Adobe`) utvärderas som ett AND-villkor, vilket innebär att den valda användargruppen ges läsåtkomst till resurser med `status=approved AND brand=Adobe`
> ![Tillåt flera begränsningar](./assets/metadata-driven-permissions/allow-multiple-restrictions.png)
> - __ELLER begränsningar__ stöds genom att lägga till en ny åtkomstkontrollpost med en metadataegenskapsbegränsning som skapar ett OR-villkor för posterna, t.ex. en enskild post med begränsningar `status=approved` och en enda post med `brand=Adobe` utvärderas som `status=approved OR brand=Adobe`
> ![Tillåt flera begränsningar](./assets/metadata-driven-permissions/allow-multiple-aces.png)
