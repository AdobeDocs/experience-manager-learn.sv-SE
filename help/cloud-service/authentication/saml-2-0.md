---
title: SAML 2.0 på AEM som molntjänst
description: Lär dig hur du konfigurerar SAML 2.0-autentisering för AEM as a Cloud Service Publish-tjänsten.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Developer
level: Intermediate
jira: KT-9351
thumbnail: 343040.jpeg
last-substantial-update: 2024-05-15T00:00:00Z
exl-id: 461dcdda-8797-4a37-a0c7-efa7b3f1e23e
duration: 2200
source-git-commit: 2ed303e316577363f6d1c265ef7f9cd6d81491d8
workflow-type: tm+mt
source-wordcount: '4277'
ht-degree: 0%

---

# SAML 2.0-autentisering{#saml-2-0-authentication}

Lär dig hur du konfigurerar och autentiserar slutanvändare (inte författare till AEM) till en SAML 2.0-kompatibel IDP som du väljer.

## Vilken SAML för AEM as a Cloud Service?

SAML 2.0-integration med AEM Publish (eller Preview) gör det möjligt för slutanvändare av en AEM-baserad webbupplevelse att autentisera sig mot en icke-Adobe IDP (Identity Provider) och få tillgång till AEM som namngiven, auktoriserad användare.

|                       | AEM-författare | AEM Publish |
|-----------------------|:----------:|:-----------:|
| SAML 2.0-stöd | ✘ | ✔ |

+++ Förstå SAML 2.0-flödet med AEM

Det typiska flödet för en AEM Publish SAML-integration är följande:

1. Användaren gör en begäran om AEM Publish vilket indikerar att autentisering krävs.
   + Användaren begär en CUG/ACL-skyddad resurs.
   + Användaren begär en resurs som omfattas av ett autentiseringskrav.
   + Användaren följer en länk till AEM:s inloggningsslutpunkt (dvs. `/system/sling/login`) som uttryckligen begär inloggningsåtgärden.
1. AEM gör en AuthnRequest till IDP:n och begär att IDP ska starta autentiseringsprocessen.
1. Användaren autentiserar sig mot IDP.
   + Användaren blir tillfrågad av IDP:n om inloggningsuppgifter.
   + Användaren är redan autentiserad med IDP:n och behöver inte lämna ytterligare inloggningsuppgifter.
1. IDP genererar en SAML-assertion som innehåller användarens data och signerar den med IDP:ns privata certifikat.
1. IDP skickar SAML-assertionen via HTTP POST, via användarens webbläsare (RESPECTIVE_PROTECTED_PATH/saml_login), till AEM Publish.
1. AEM Publish tar emot SAML-assertionen och validerar SAML-assertionens integritet och äkthet med hjälp av IDP:s publika certifikat.
1. AEM Publish hanterar AEM-användarposten baserat på SAML 2.0 OSGi-konfigurationen och innehållet i SAML-assertionen.
   + Skapar användare
   + Synkroniserar användarattribut
   + Uppdaterar medlemskap i AEM-användargruppen
1. AEM Publish sätter AEM-cookien `login-token` på HTTP-svaret, som används för att autentisera efterföljande förfrågningar till AEM Publish.
1. AEM Publish omdirigerar användaren till URL på AEM Publish enligt cookien `saml_request_path` .

+++

## Konfigurationsgenomgång

>[!VIDEO](https://video.tv.adobe.com/v/343040?quality=12&learn=on)

Den här videon går igenom hur man sätter upp SAML 2.0-integration med AEM som en Cloud Service Publish-tjänst och använder Okta som IDP.

## Förkunskapskrav

Följande krävs vid installation av SAML 2.0-autentisering:

+ Tillgång till Cloud Manager för Distributionshanteraren
+ AEM Administrator-åtkomst till AEM as a Cloud Service-miljön
+ Administratörsåtkomst till IDP:n
+ Tillgång till ett offentligt/privat nyckelpar som används för att kryptera SAML-nyttolaster
+ AEM Sites-sidor (eller sidträd), publicerade till AEM Publish och [skyddade av stängda användargrupper (CUG)](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/sites/authoring/sites-console/page-properties#permissions)

SAML 2.0 stöds endast för att autentisera användning av AEM Publish eller Preview. Om du vill hantera autentiseringen av AEM Author med hjälp av och IDP [integrerar du IDP med Adobe IMS](https://helpx.adobe.com/se/enterprise/using/set-up-identity.html).


## Installera IDP publikt certifikat på AEM

IDP:ns publika certifikat läggs till i AEM:s Global Trust Store och används för att validera att SAML-assertionen som skickas av IDP:n är giltig.

+++SAML-assertionssigneringsflöde

![SAML 2.0 - IDP SAML-assertionssignering](./assets/saml-2-0/idp-signing-diagram.png)

1. Användaren autentiserar sig mot IDP.
1. IDP genererar en SAML-assertion som innehåller användarens data.
1. IDP undertecknar SAML-påståendet med IDP:ns privata certifikat.
1. IDP initierar en klientsida HTTP POST till AEM Publishs SAML-endpoint (`.../saml_login`) som inkluderar den signerade SAML-assertionen.
1. AEM Publish tar emot HTTP POST som innehåller den signerade SAML-assertionen, kan validera signaturen med IDP:s publika certifikat.

+++

![Lägg till IDP:s publika certifikat i Global Trust Store](./assets/saml-2-0/global-trust-store.png)

1. Hämta den publika __certifikatfilen__ från IDP:n. Detta certifikat gör det möjligt för AEM att validera SAML-assertionen som tillhandahålls AEM av IDP:n.

   Certifikatet är i PEM-format och bör likna:

   ```
   -----BEGIN CERTIFICATE-----
   MIIC4jCBAcoCCQC33wnybT5QZDANBgkqhkiG9w0BAQsFADAyMQswCQYDVQQGEwJV
   ...
   m0eo2USlSRTVl7QHRTuiuSThHpLKQQ==
   -----END CERTIFICATE-----
   ```

1. Logga in på AEM Author som AEM-administratör.
1. Navigera till __verktyg > säkerhet > Trust Store__.
1. Skapa eller öppna Global Trust Store. Om du skapar en Global Trust Store, spara lösenordet på en säker plats.
1. Expandera __Lägg till certifikat från CER-fil__.
1. Välj __Certifikatfil__ och ladda upp certifikatfilen som IDP:n tillhandahåller.
1. Lämna __kartcertifikatet tomt till användaren__ .
1. Välj __Skicka__.
1. Det nyligen tillagda certifikatet visas ovanför __avsnittet Lägg till certifikat från CRT-filen__ .
1. Notera __aliaset__, eftersom detta värde används i [SAML 2.0 Authentication Handler OSGi-konfigurationen](#saml-2-0-authentication-handler-osgi-configuration).
1. Välj __Spara &amp; Stäng.__

Global Trust Store har konfigurerats med IDP:s offentliga certifikat på AEM Author, men eftersom SAML bara används på AEM Publish måste Global Trust Store replikeras till AEM Publish för att IDP:s offentliga certifikat ska vara tillgängligt där.

![Replikera Global Trust Store till AEM Publish](./assets/saml-2-0/global-trust-store-replicate.png)

1. Navigera till __Verktyg > Distribution > Paket__.
1. Skapa ett paket
   + Paketnamn: `Global Trust Store`
   + Version: `1.0.0`
   + Grupp: `com.your.company`
1. Redigera det nya __Global Trust Store-paketet__ .
1. Välj fliken __Filter__ och lägg till ett filter för rotvägen `/etc/truststore`.
1. Välj __Klart och sedan__ Spara ____.
1. Välj __Bygg-knappen__ för __Global Trust Store-paketet__ .
1. När den är byggd, välj __More__ > __Replicate__ för att aktivera Global Trust Store-noden (`/etc/truststore`) till AEM Publish.

## Skapa autentiseringstjänst-nyckellagring{#authentication-service-keystore}

_Att skapa en nyckellagring för autentiseringstjänst krävs när [SAML 2.0-autentiseringshanterarens OSGi-konfigurationsegenskap `handleLogout` sätts till `true`](#saml-20-authenticationsaml-2-0-authentication) eller när [AuthnRequest-signering/SAML-assertionskryptering](#install-aem-public-private-key-pair) krävs_

1. Logga in på AEM Author som AEM-administratör för att ladda upp den privata nyckeln.
1. Gå till __Verktyg > Säkerhet > Användare__, välj __autentiseringstjänstanvändare__ , och välj __Egenskaper__ från den övre åtgärdsfältet.
1. Välj fliken Keystore ____.
1. Skapa eller öppna keystore. Om du skapar en nyckelbutik, förvara lösenordet säkert.
   + En [publik/privat keystore installeras i denna keystore](#install-aem-public-private-key-pair) endast om AuthnRequest-signering/SAML-assertionskryptering krävs.
   + Om denna SAML-integration stödjer utloggning, men inte AuthnRequest-signering/SAML-assertion, är en tom keystore tillräcklig.
1. Välj __Spara &amp; Stäng.__
1. Skapa ett paket som innehåller den uppdaterade __autentiseringsanvändaren__ .

   _Use följande tillfälliga lösning med hjälp av paket :_

   1. Gå till __verktyg > distribution > paket__.
   1. Skapa ett paket
      + Paketnamn: `Authentication Service`
      + Version: `1.0.0`
      + Grupp: `com.your.company`
   1. Redigera det nya __nyckelarkivet för autentiseringstjänsten__.
   1. Markera fliken __Filter__ och lägg till ett filter för rotsökvägen `/home/users/system/cq:services/internal/security/<AUTHENTICATION SERVICE UUID>/keystore`.
      + Du hittar `<AUTHENTICATION SERVICE UUID>` genom att gå till __Verktyg > Säkerhet > Användare__ och välja __authentication-service__-användare. UUID är den sista delen av URL:en.
   1. Välj __Klart och sedan__ Spara ____.
   1. Välj __Bygg-knappen__ för paketet __Authentication Service Key Store__ .
   1. När den är byggd, välj __More__ > __Replicate__ för att aktivera Authentication Service-nyckellagret till AEM Publish.

## Installera AEM offentlig/privat nyckelpar{#install-aem-public-private-key-pair}

_Installation av AEM:s publika/privata nyckelpar är valfritt_

AEM Publish kan konfigureras för att signera AuthnRequests (till IDP) och kryptera SAML-assertioner (till AEM). Detta uppnås genom att tillhandahålla en privat nyckel till AEM Publish, och dess publika nyckel matchar IDP:n.

+++ Förstå AuthnRequest-signeringsflödet (valfritt)

AuthnRequest (begäran till IDP från AEM Publish som initierar inloggningsprocessen) kan signeras av AEM Publish. För att göra detta signerar AEM Publish AuthnRequest med den privata nyckeln, som IDP:n sedan validerar signaturen med den publika nyckeln. Detta garanterar IDP att AuthnRequest initierades och begärdes av AEM Publish, och inte en illvillig tredje part.

![SAML 2.0 - SP AutothnRequest signering](./assets/saml-2-0/sp-authnrequest-signing-diagram.png)

1. Användaren gör en HTTP-förfrågan till AEM Publish som resulterar i en SAML-autentiseringsförfrågan till IDP:n.
1. AEM Publish genererar SAML-förfrågan som skickas till IDP:n.
1. AEM Publish signerar SAML-förfrågan med AEM:s privata nyckel.
1. AEM Publish initierar AuthnRequest, en HTTP-klientsidans omdirigering till IDP:n som innehåller den signerade SAML-förfrågan.
1. IDP tar emot AuthnRequest och validerar signaturen med AEM:s publika nyckel, vilket garanterar att AEM Publish initierade AuthnRequest.
1. AEM Publish validerar sedan den dekrypterade SAML-assertionens integritet och äkthet med hjälp av IDP:s publika certifikat.

+++

+++ Förstå SAML-assertionskrypteringsflödet (valfritt)

All HTTP-kommunikation mellan IDP och AEM Publish bör ske över HTTPS och därmed vara säker som standard. Men vid behov kan SAML-assertioner krypteras om extra sekretess krävs utöver det som ges av HTTPS. För att göra detta krypterar IDP:n SAML-assertionsdata med den privata nyckeln, och AEM Publish dekrypterar SAML-assertionen med den privata nyckeln.

![SAML 2.0 - SP SAML Assertionskryptering](./assets/saml-2-0/sp-samlrequest-encryption-diagram.png)

1. Användaren autentiserar sig mot IDP.
1. IDP genererar en SAML-assertion som innehåller användarens data och signerar den med IDP:ns privata certifikat.
1. IDP krypterar sedan SAML-assertionen med AEMs publika nyckel, vilket kräver att AEM:s privata nyckel dekrypteras.
1. Den krypterade SAML-assertionen skickas via användarens webbläsare till AEM Publish.
1. AEM Publish tar emot SAML-assertionen och dekrypterar den med AEM:s privata nyckel.
1. IDP uppmanar användaren att autentisera sig.

+++

Både AuthnRequest-signering och SAML-assertionskryptering är valfria, men båda är aktiverade, med hjälp av [SAML 2.0-autentiseringshanteraren OSGi-konfigurationsegenskapen `useEncryption`](#saml-20-authenticationsaml-2-0-authentication), vilket innebär att båda eller ingen kan användas.

![AEM-autentiseringsnyckellagring](./assets/saml-2-0/authentication-service-key-store.png)

1. Hämta den offentliga nyckeln, privata nyckeln (PKCS#8 i DER-format) och certifikatkedjefilen (detta kan vara den offentliga nyckeln) som används för att signera AuthnRequest och kryptera SAML-försäkran. Nycklarna tillhandahålls vanligtvis av IT-organisationens säkerhetsteam.

   + Ett självsignerat nyckelpar kan genereras med __openssl__:

   ```
   $ openssl req -x509 -sha256 -days 365 -newkey rsa:4096 -keyout aem-private.key -out aem-public.crt
   
   # Provide a password (keep in safe place), and other requested certificate information
   
   # Convert the keys to AEM's required format 
   $ openssl rsa -in aem-private.key -outform der -out aem-private.der
   $ openssl pkcs8 -topk8 -inform der -nocrypt -in aem-private.der -outform der -out aem-private-pkcs8.der
   ```

1. Överför den offentliga nyckeln till IDP.
   + Med metoden `openssl` ovan är den publika nyckeln filen `aem-public.crt` .
1. Logga in på AEM Author som AEM-administratör för att ladda upp den privata nyckeln.
1. Gå till __Verktyg > Säkerhet > Trust Store__, välj __autentiseringstjänstanvändare__ , och välj __Egenskaper__ från den övre åtgärdsfältet.
1. Gå till __Verktyg > Säkerhet > Användare__, välj __autentiseringstjänstanvändare__ , och välj __Egenskaper__ från den övre åtgärdsfältet.
1. Välj fliken Keystore ____.
1. Skapa eller öppna keystore. Om du skapar en nyckelbutik, förvara lösenordet säkert.
1. Välj __Lägg till privat nyckel från DER-filen__ och lägg till den privata nyckel- och kedjefilen i AEM:
   + __Alias__: Ge ett meningsfullt namn, ofta namnet på IDP:n.
   + __Privat nyckelfil__: Ladda upp filen för privat nyckel (PKCS#8 i DER-format).
      + Med metoden `openssl` ovan är `aem-private-pkcs8.der` detta filen
   + __Välj certifikatkedjefil:__ Ladda upp den tillhörande kedjefilen (detta kan vara den publika nyckeln).
      + Med metoden `openssl` ovan är `aem-public.crt` detta filen
   + Välj __Skicka in__
1. Det nyligen tillagda certifikatet visas ovanför __avsnittet Lägg till certifikat från CRT-filen__ .
   + Notera __aliaset__ eftersom detta används i [SAML 2.0-autentiseringshanteraren OSGi-konfigurationen](#saml-20-authentication-handler-osgi-configuration)
1. Välj __Spara &amp; Stäng.__
1. Skapa ett paket som innehåller den uppdaterade __autentiseringsanvändaren__ .

   _Use följande tillfälliga lösning med hjälp av paket :_

   1. Gå till __verktyg > distribution > paket__.
   1. Skapa ett paket
      + Paketnamn: `Authentication Service`
      + Version: `1.0.0`
      + Grupp: `com.your.company`
   1. Redigera det nya __nyckelarkivet för autentiseringstjänsten__.
   1. Markera fliken __Filter__ och lägg till ett filter för rotsökvägen `/home/users/system/cq:services/internal/security/<AUTHENTICATION SERVICE UUID>/keystore`.
      + Du hittar `<AUTHENTICATION SERVICE UUID>` genom att gå till __Verktyg > Säkerhet > Användare__ och välja __authentication-service__-användare. UUID är den sista delen av URL:en.
   1. Välj __Klar__ och sedan __Spara__.
   1. Välj knappen __Skapa__ för __nyckelarkivet för autentiseringstjänsten__-paketet.
   1. Välj __Mer__ > __Replikera__ när du har skapat autentiseringstjänstens nyckelarkiv för AEM Publish.

## Konfigurera autentiseringshanteraren för SAML 2.0{#configure-saml-2-0-authentication-handler}

AEM:s SAML-konfiguration utförs via __Adobe Granite SAML 2.0 Authentication Handler OSGi-konfigurationen__ .
Konfigurationen är en OSGi-fabrikskonfiguration, vilket innebär att en enskild AEM som Cloud Service Publish-tjänst kan ha flera SAML-konfigurationer som täcker diskreta resursträd i arkivet; detta är användbart för AEM-installationer på flera platser.

+++ SAML 2.0 Authentication Handler OSGi konfigurationsordlista

### Adobe Granite SAML 2.0 Authentication Handler OSGi-konfiguration{#configure-saml-2-0-authentication-handler-osgi-configuration}

|                                   | OSGi-egenskap | Obligatoriskt | Värdeformat | Standardvärde | Beskrivning |
|-----------------------------------|-------------------------------|:--------:|:---------------------:|---------------------------|-------------|
| Vägar | `path` | ✔ | Strängarray | `/` | AEM-vägar som denna autentiseringshanterare används för. |
| IDP-URL | `idpUrl` | ✔ | Sträng |                           | IDP-URL:en där SAML-autentiseringsförfrågan skickas. |
| IDP-certifikatalias | `idpCertAlias` | ✔ | Sträng |                           | Alias för IDP-certifikatet som hittades i AEM:s Global Trust Store |
| IDP HTTP-omdirigering | `idpHttpRedirect` | ✘ | Boolesk | `false` | Indikerar om en HTTP-omdirigering till IDP-URL:en istället för att skicka en AuthnRequest. Ställ in på `true` för IDP-initierad autentisering. |
| IDP-identifierare | `idpIdentifier` | ✘ | Sträng |                           | Unikt IDP-ID för att säkerställa AEM-användares och gruppens unikhet. Om tomt används istället för det `serviceProviderEntityId` . |
| Assertion konsumenttjänst-URL | `assertionConsumerServiceURL` | ✘ | Sträng |                           | URL-attributet `AssertionConsumerServiceURL` i AuthnRequest som anger var `<Response>`-meddelandet måste skickas till AEM. |
| SP-enhets-ID | `serviceProviderEntityId` | ✔ | Sträng |                           | Identifierar unikt AEM till IDP; vanligtvis AEM:s värdnamn. |
| SP-kryptering | `useEncryption` | ✘ | Boolesk | `true` | Indikerar om IDP:n krypterar SAML-påståenden. Kräver `spPrivateKeyAlias` och `keyStorePassword` måste vara satt. |
| SP privata nyckelalias | `spPrivateKeyAlias` | ✘ | Sträng |                           | Alias för den privata nyckeln i `authentication-service` användarens nyckellagring. Krävs om `useEncryption` är satt till `true`. |
| SP nyckellagringslösenord | `keyStorePassword` | ✘ | Sträng |                           | Lösenordet till användarens nyckel lagrar användarens nyckel i &#39;autentiseringstjänsten&#39;. Krävs om `useEncryption` är satt till `true`. |
| Standardomdirigering | `defaultRedirectUrl` | ✘ | Sträng | `/` | Den standardomdirigerade URL:en efter lyckad autentisering. Kan vara relativ till AEM-värden (till exempel, `/content/wknd/us/en/html`). |
| User Id-attributet | `userIDAttribute` | ✘ | Sträng | `uid` | Namnet på attributet SAML-assertion som innehåller användar-ID:t för AEM-användaren. Lämna tomt för att använda `Subject:NameId`. |
| Automatiskt skapa AEM-användare | `createUser` | ✘ | Boolesk | `true` | Indikerar om AEM-användare skapas vid lyckad autentisering. |
| AEM-användarintermediär väg | `userIntermediatePath` | ✘ | Sträng |                           | När du skapar AEM-användare används det här värdet som mellanliggande sökväg (till exempel `/home/users/<userIntermediatePath>/jane@wknd.com`). `createUser` måste anges till `true`. |
| AEM användarattribut | `synchronizeAttributes` | ✘ | Strängarray |                           | Lista över SAML-attributmappningar att lagra på AEM-användaren, i formatet `[ "saml-attribute-name=path/relative/to/user/node" ]` (till exempel `[ "firstName=profile/givenName" ]`). Se den [fullständiga listan över inbyggda AEM-attribut](#aem-user-attributes). |
| Lägg till användare i AEM-grupper | `addGroupMemberships` | ✘ | Boolesk | `true` | Indikerar om en AEM-användare automatiskt läggs till i AEM-användargrupper efter framgångsrik autentisering. |
| AEM-gruppmedlemskapsattributet | `groupMembershipAttribute` | ✘ | Sträng | `groupMembership` | Namnet på SAML-assertionsattributet som innehåller en lista över AEM-användargrupper som användaren bör läggas till i. Kräver `addGroupMemberships` att den sätts till `true`. |
| Standard AEM-grupper | `defaultGroups` | ✘ | Strängarray |                           | En lista över AEM-användargrupper som autentiserade användare alltid läggs till i (till exempel `[ "wknd-user" ]`). Kräver `addGroupMemberships` att den sätts till `true`. |
| NameIDPolicy-format | `nameIdFormat` | ✘ | Sträng | `urn:oasis:names:tc:SAML:2.0:nameid-format:transient` | Värdet på NamnIDPolicy-formatparametern som ska skickas in AuthnRequest-meddelandet. |
| Svar på Store SAML | `storeSAMLResponse` | ✘ | Boolesk | `false` | Indikerar om `samlResponse` värdet lagras på AEM-noden `cq:User` . |
| Hantera utloggning | `handleLogout` | ✘ | Boolesk | `false` | Indikerar om utloggningsbegäran hanteras av denna SAML-autentiseringshanterare. Måste `logoutUrl` vara inställd. |
| Loggout-URL | `logoutUrl` | ✘ | Sträng |                           | IDP:ns URL dit SAML-utloggningsförfrågan skickas till. Krävs om `handleLogout` är satt till `true`. |
| Klocktolerans | `clockTolerance` | ✘ | Heltal | `60` | IDP- och AEM (SP)-klocksnedvridningstolerans vid validering av SAML-påståenden. |
| Sammanfattningsmetod | `digestMethod` | ✘ | Sträng | `http://www.w3.org/2001/04/xmlenc#sha256` | Den sammandragsalgoritm som IDP använder vid signering av ett SAML-meddelande. |
| Signaturmetod | `signatureMethod` | ✘ | Sträng | `http://www.w3.org/2001/04/xmldsig-more#rsa-sha256` | Signaturalgoritmen som IDP:n använder när de signerar ett SAML-meddelande. |
| Identitetssynkroniseringstyp | `identitySyncType` | ✘ | `default` eller `idp` | `default` | Ändra `from` inte standarden för AEM som molntjänst. |
| Tjänsteranking | `service.ranking` | ✘ | Heltal | `5002` | Högre rankade konfigurationer föredras för samma `path`. |

### AEM-användarattribut{#aem-user-attributes}

AEM använder följande användarattribut, som kan fyllas i via egenskapen `synchronizeAttributes` i Adobe Granite SAML 2.0 Authentication Handler OSGi-konfigurationen.  Alla IDP-attribut kan synkroniseras med vilken AEM-användaregenskap som helst, men mappning till AEM-användningsattributegenskaper (listad nedan) gör att AEM naturligt kan använda dem.

| Användarattribut | Relativ egenskapsväg från `rep:User` nod |
|--------------------------------|--------------------------|
| Titel (till exempel, `Mrs`) | `profile/title` |
| Förnamn (dvs. förnamn) | `profile/givenName` |
| Familjenamn (dvs. efternamn) | `profile/familyName` |
| Jobbtitel | `profile/jobTitle` |
| E-postadress | `profile/email` |
| Gatuadress | `profile/street` |
| Stad | `profile/city` |
| Postnummer | `profile/postalCode` |
| Land | `profile/country` |
| Telefonnummer | `profile/phoneNumber` |
| Om mig | `profile/aboutMe` |

+++

1. Skapa en OSGi-konfigurationsfil i ditt projekt på `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.adobe.granite.auth.saml.SamlAuthenticationHandler~saml.cfg.json` och öppna i din IDE.
   + Ändra `/wknd-examples/` till din `/<project name>/`
   + Identifieraren efter `~` i filnamnet bör unikt identifiera den här konfigurationen, så det kan vara namnet på IDP:n, till exempel `...~okta.cfg.json`. Värdet ska vara alfanumeriskt med bindestreck.
1. Klistra in följande JSON i filen `com.adobe.granite.auth.saml.SamlAuthenticationHandler~...cfg.json` och uppdatera `wknd`-referenserna efter behov.

   ```json
   {
       "path": [ "/content/wknd", "/content/dam/wknd" ], 
       "idpCertAlias": "$[env:SAML_IDP_CERT_ALIAS;default=certalias___1652125559800]",
       "idpIdentifier": "$[env:SAML_IDP_ID;default=http://www.okta.com/exk4z55r44Jz9C6am5d7]",
       "idpUrl": "$[env:SAML_IDP_URL;default=https://dev-5511372.okta.com/app/dev-5511372_aemasacloudservice_1/exk4z55r44Jz9C6am5d7/sso/saml]",
       "serviceProviderEntityId": "$[env:SAML_AEM_ID;default=https://publish-p123-e456.adobeaemcloud.com]",
       "useEncryption": false,
       "createUser": true,
       "userIntermediatePath": "wknd/idp",
       "synchronizeAttributes":[
           "firstName=profile/givenName"
       ],
       "addGroupMemberships": true,
       "defaultGroups": [ 
           "wknd-users"
       ]
   }
   ```

1. Uppdatera de värden som krävs för projektet. Se __SAML 2.0 Authentication Handler OSGi-konfigurationsordlistan__ ovan för beskrivningar av konfigurationsegenskaper. De `path` bör innehålla innehållsträd som skyddas av slutna användargrupper (CUG) och kräver autentisering, och denna autentiseringshanterare bör ansvara för skyddet.
1. Vi rekommenderar, men behöver inte göra det, att du använder OSGi-miljövariabler och hemligheter när värdena kan ändras osynkroniserade med versionscykeln eller när värdena skiljer sig åt mellan liknande miljötyper/tjänstnivåer. Standardvärden kan ställas in med syntaxen `$[env:..;default=the-default-value]"` som visas ovan.

OSGi-konfigurationer per miljö (`config.publish.dev`, `config.publish.stage`, och `config.publish.prod`) kan definieras med specifika attribut om SAML-konfigurationen varierar mellan miljöer.

### Använd kryptering

Vid [kryptering av AuthnRequest- och SAML-assertionen](#encrypting-the-authnrequest-and-saml-assertion) krävs följande egenskaper: `useEncryption`, `spPrivateKeyAlias`, och `keyStorePassword`. Innehåller `keyStorePassword` ett lösenord, därför får värdet inte lagras i OSGi-konfigurationsfilen, utan istället injiceras med hjälp av [hemliga konfigurationsvärden](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html?lang=sv-SE#secret-configuration-values)

+++Eventuellt kan OSGi-konfigurationen uppdateras för att använda kryptering

1. Öppna `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.adobe.granite.auth.saml.SamlAuthenticationHandler~saml.cfg.json` i din IDE.
1. Lägg till de tre egenskaperna `useEncryption`, `spPrivateKeyAlias`, och `keyStorePassword` som visas nedan.

   ```json
   {
   "path": [ "/content/wknd", "/content/dam/wknd" ], 
   "idpCertAlias": "$[env:SAML_IDP_CERT_ALIAS;default=certalias___1234567890]",
   "idpIdentifier": "$[env:SAML_IDP_ID;default=http://www.okta.com/abcdef1235678]",
   "idpUrl": "$[env:SAML_IDP_URL;default=https://dev-5511372.okta.com/app/dev-123567890_aemasacloudservice_1/abcdef1235678/sso/saml]",
   "serviceProviderEntityId": "$[env:SAML_AEM_ID;default=https://publish-p123-e456.adobeaemcloud.com]",
   "useEncryption": true,
   "spPrivateKeyAlias": "$[env:SAML_AEM_KEYSTORE_ALIAS;default=aem-saml-encryption]",
   "keyStorePassword": "$[secret:SAML_AEM_KEYSTORE_PASSWORD]",
   "createUser": true,
   "userIntermediatePath": "wknd/idp"
   "synchronizeAttributes":[
       "firstName=profile/givenName"
   ],
   "addGroupMemberships": true,
   "defaultGroups": [ 
       "wknd-users"
   ]
   }
   ```

1. De tre OSGi-konfigurationsegenskaper som krävs för kryptering är:

+ `useEncryption` Ställ in på `true`
+ `spPrivateKeyAlias` innehåller nyckellagringsinskrymningsalias för den privata nyckel som används av SAML-integrationen.
+ `keyStorePassword` innehåller en [OSGi-hemlig konfigurationsvariabel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html?lang=sv-SE#secret-configuration-values) som innehåller `authentication-service` användarens nyckelstores lösenord.

+++

## Configure Referrer-filter

Under SAML-autentiseringsprocessen initierar IDP:n en klientsida HTTP POST till AEM Publishs `.../saml_login` slutpunkt. Om IDP och AEM Publish finns på en annan plats är AEM Publish __Referer-filter__ konfigurerat via OSGi-konfigurationen för att tillåta HTTP POST från IDP:ns ursprung.

1. Skapa (eller redigera) en OSGi-konfigurationsfil i ditt projekt på `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/org.apache.sling.security.impl.ReferrerFilter.cfg.json`.
   + Ändra `/wknd-examples/` till din `/<project name>/`
1. Kontrollera att värdet `allow.empty` är inställt på `true`, att `allow.hosts` (eller om du föredrar `allow.hosts.regexp`) innehåller IDP:ns ursprung och att `filter.methods` inkluderar `POST`. OSGi-konfigurationen ska vara som:

   ```json
   {
       "allow.empty": true,
       "allow.hosts.regexp": [ ],
       "allow.hosts": [ 
           "$[env:SAML_IDP_REFERRER;default=dev-123567890.okta.com]"
       ],
       "filter.methods": [
           "POST",
       ],
       "exclude.agents.regexp": [ ]
   }
   ```

AEM Publish har stöd för en enda konfiguration av referensfilter, så sammanfoga SAML-konfigurationskraven med befintliga konfigurationer.

OSGi-konfigurationer per miljö (`config.publish.dev`, `config.publish.stage` och `config.publish.prod`) kan definieras med specifika attribut om `allow.hosts` (eller `allow.hosts.regex`) varierar mellan miljöer.

## Konfigurera Cross-Origin Resource Sharing (CORS)

Under SAML-autentiseringsprocessen initierar IDP en HTTP POST på klientsidan till AEM Publish `.../saml_login`-slutpunkten. Om IDP och AEM Publish finns på olika värdar/domäner måste AEM Publish __CRoss-Origin Resource Sharing (CORS)__ konfigureras så att HTTP POST tillåts från IDP:s värd/domän.

HTTP POST-begärans `Origin`-huvud har vanligtvis ett annat värde än AEM Publish-värden, vilket kräver CORS-konfiguration.

När SAML-autentisering testas på det lokala AEM SDK:n (`localhost:4503`), kan IDP:n ställa in `Origin` headern till `null`. Om så är fallet, lägg till `"null"` på listan `alloworigin` .

1. Skapa en OSGi-konfigurationsfil i ditt projekt på `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.adobe.granite.cors.impl.CORSPolicyImpl~saml.cfg.json`
   + Byt `/wknd-examples/` namn på ditt projekt
   + Identifieraren efter i `~` filnamnet bör unikt identifiera denna konfiguration, så det kan vara namnet på IDP:n, såsom `...CORSPolicyImpl~okta.cfg.json`. Värdet ska vara alfanumeriskt med bindestreck.
1. Klistra in följande JSON i filen `com.adobe.granite.cors.impl.CORSPolicyImpl~...cfg.json`.

```json
{
    "alloworigin": [ 
        "$[env:SAML_IDP_ORIGIN;default=https://dev-1234567890.okta.com]", 
        "null"
    ],
    "allowedpaths": [ 
        ".*/saml_login"
    ],
    "supportedmethods": [ 
        "POST"
    ]
}
```

OSGi-konfigurationer per miljö (`config.publish.dev`, `config.publish.stage`, och `config.publish.prod`) kan definieras med specifika attribut om och `alloworigin` `allowedpaths` varierar mellan miljöer.

## Konfigurera AEM Dispatcher för att tillåta SAML HTTP POSTs

Efter framgångsrik autentisering till IDP:n kommer IDP:n att orkestrera en HTTP POST tillbaka till AEM:s registrerade `/saml_login` slutpunkt (konfigurerad i IDP:n). Denna HTTP POST till `/saml_login` blockeras som standard hos Dispatcher, så den måste uttryckligen tillåtas med följande Dispatcher-regel:

1. Öppna `dispatcher/src/conf.dispatcher.d/filters/filters.any` i din IDE.
1. Lägg till längst ner i filen en tillåt-regel för HTTP POSTs till URL:er som slutar på `/saml_login`.

```
...

# Allow SAML HTTP POST to ../saml_login end points
/0190 { /type "allow" /method "POST" /url "*/saml_login" }
```

>[!NOTE]
>När du distribuerar flera SAML-konfigurationer i AEM för olika skyddade vägar och olika IDP-endpoints, se till att IDP:n postar till RESPECTIVE_PROTECTED_PATH/saml_login-endpointen för att välja lämplig SAML-konfiguration på AEM-sidan. Om det finns dubbletter av SAML-konfigurationer för samma skyddade sökväg kommer valet av SAML-konfigurationen att ske slumpmässigt.

Om URL-omskrivning på Apache-webbservern är konfigurerad (`dispatcher/src/conf.d/rewrites/rewrite.rules`), se till att förfrågningar till `.../saml_login` slutpunkterna inte av misstag förstörs.

## Dynamiskt gruppmedlemskap

Dynamiskt gruppmedlemskap är en funktion i [Apache Jackrabbit Oak](https://jackrabbit.apache.org/oak/docs/security/authentication/external/dynamic.html) som ökar prestandan vid grupputvärdering och provisionering. Detta avsnitt beskriver hur användare och grupper lagras när denna funktion aktiveras och hur man kan ändra konfigurationen av SAML Authentication Handler för att möjliggöra den för nya eller befintliga miljöer.

### Hur man aktiverar dynamiskt gruppmedlemskap för SAML-användare i nya miljöer

För att avsevärt förbättra grupputvärderingsprestandan i nya AEM som molntjänst-miljöer rekommenderas aktivering av funktionen Dynamiskt gruppmedlemskap i nya miljöer.
Detta är också ett nödvändigt steg när datasynkronisering aktiveras. Mer information [här](https://experienceleague.adobe.com/sv/docs/experience-manager-cloud-service/content/sites/authoring/personalization/user-and-group-sync-for-publish-tier) .
För att göra detta, lägg till följande egenskap i OSGI-konfigurationsfilen:

`/apps/example/osgiconfig/config.publish/com.adobe.granite.auth.saml.SamlAuthenticationHandler~example.cfg.json`

Med denna konfiguration skapas användare och grupper som [Oak Externa användare](https://jackrabbit.apache.org/oak/docs/security/authentication/identitymanagement.html). I AEM har externa användare och grupper en standard `rep:principalName` komponerad av `[user name];[idp]` eller `[group name];[idp]`.
Observera att åtkomstkontrolllistor (ACL) är kopplade till användarnas eller gruppers huvudnamn.
När denna konfiguration distribueras i en befintlig distribution där det tidigare `identitySyncType` inte specificerades eller sattes till `default`, kommer nya användare och grupper att skapas och ACL måste tillämpas på dessa nya användare och grupper. Observera att externa grupper inte kan innehålla lokala användare. [Repoinit](https://sling.apache.org/documentation/bundles/repository-initialization.html) kan användas för att skapa ACL för SAML Externa grupper, även om de bara skapas när användaren gör en inloggning.
För att undvika denna omstrukturering på ACL har en standard [migreringsfunktion](#automatic-migration-to-dynamic-group-membership-for-existing-environments) implementerats.

### Hur medlemskap lagras i lokala och externa grupper med dynamiskt gruppmedlemskap

På lokala grupper lagras gruppmedlemmarna i ekattributet: `rep:members`. Attributet innehåller listan över uid för varje medlem i gruppen. Ytterligare detaljer finns [här](https://jackrabbit.apache.org/oak/docs/security/user/membership.html#member-representation-in-the-repository).
Exempel:

```
{
  "jcr:primaryType": "rep:Group",
  "rep:principalName": "operators",
  "rep:managedByIdp": "SAML",
  "rep:members": [
    "635afa1c-beeb-3262-83c4-38ea31e5549e",
    "5e496093-feb6-37e9-a2a1-7c87b1cec4b0",
    ...
  ],
   ...
}
```

Externa grupper med dynamiskt gruppmedlemskap lagrar ingen medlem i gruppposten.
Gruppmedlemskapet lagras istället i användarens poster. Ytterligare dokumentation finns [här](https://jackrabbit.apache.org/oak/docs/security/authentication/external/dynamic.html). Till exempel är detta OAK-noden för gruppen:

```
{
  "jcr:primaryType": "rep:Group",
  "jcr:mixinTypes": [
    "rep:AccessControllable"
  ],
  "jcr:createdBy": "",
  "jcr:created": "Tue Jul 16 2024 08:58:47 GMT+0000",
  "rep:principalName": "GROUP_1;aem-saml-idp-1",
  "rep:lastSynced": "Tue Jul 16 2024 08:58:47 GMT+0000",
  "jcr:uuid": "d9c6af8a-35c0-3064-899a-59af55455cd0",
  "rep:externalId": "GROUP_1;aem-saml-idp-1",
  "rep:authorizableId": "GROUP_1;aem-saml-idp-1"
}
```

Detta är noden för en användarmedlem i den gruppen:

```
{
  "jcr:primaryType": "rep:User",
  "jcr:mixinTypes": [
    "rep:AccessControllable"
  ],
  "surname": "Test",
  "rep:principalName": "testUser",
  "rep:externalId": "test;aem-saml-idp-1",
  "rep:authorizableId": "test",
  "rep:externalPrincipalNames": [
    "projects-users;aem-saml-idp-1",
    "GROUP_2;aem-saml-idp-1",
    "GROUP_1;aem-saml-idp-1",
    "operators;aem-saml-idp-1"
  ],
  ...
}
```

### Aktivera dynamiskt gruppmedlemskap för SAML-användare i befintliga miljöer

Som förklaras i föregående avsnitt skiljer sig formatet för externa användare och grupper något från formatet som används för lokala användare och grupper. Det går att definiera en ny åtkomstkontrollista för externa grupper och etablera nya externa användare, eller använda migreringsverktyget enligt beskrivningen nedan.

#### Aktivera dynamiskt gruppmedlemskap för befintliga miljöer med externa användare

Hanteraren för SAML-autentisering skapar externa användare när följande egenskap anges: `"identitySyncType": "idp"`. I detta fall kan dynamiskt gruppmedlemskap aktiveras genom att modifiera denna egenskap till: `"identitySyncType": "idp_dynamic"`. Ingen migration krävs.

#### Automatisk migrering till dynamiskt gruppmedlemskap för befintliga miljöer med lokala användare

SAML-autentiseringshanteraren skapar lokala användare när följande egenskap anges `"identitySyncType": "default"`: . Detta är också standardvärdet när egenskapen inte är specificerad. I detta avsnitt beskriver vi de steg som utförs av den automatiska migrationsproceduren.

När denna migrering är aktiverad utförs den under användarautentisering och består av följande steg:
1. Den lokala användaren migreras till en extern användare samtidigt som det ursprungliga användarnamnet bevaras. Det innebär att migrerade lokala användare, som nu fungerar som externa användare, behåller sitt ursprungliga användarnamn i stället för att följa den namnsyntax som nämndes i föregående avsnitt. Ytterligare en egenskap läggs till med namnet `rep:externalId` och värdet `[user name];[idp]`. Användaren `PrincipalName` har inte ändrats.
2. För varje extern grupp som tas emot i SAML-försäkran skapas en extern grupp. Om det finns en motsvarande lokal grupp läggs den externa gruppen till som medlem i den lokala gruppen.
3. Användaren läggs till som medlem i den externa gruppen.
4. Den lokala användaren tas sedan bort från alla lokala Saml-grupper han var medlem i. Saml lokala grupper identifieras av OAK-egenskapen: `rep:managedByIdp`. Den här egenskapen anges av hanteraren för Saml-autentisering när attributet `syncType` inte har angetts eller angetts till `default`.

Om migreringen `user1` till exempel är en lokal användare och medlem i den lokala gruppen `group1` sker följande ändringar efter migreringen:
`user1` blir en extern användare. Attributet `rep:externalId` har lagts till i den här profilen.
`user1` blir medlem i den externa gruppen: `group1;idp`
`user1` är inte längre en direkt medlem i den lokala gruppen: `group1`
`group1;idp` är medlem i den lokala gruppen: `group1`.
`user1` är sedan medlem i den lokala gruppen: `group1` genom arv

Gruppmedlemskapet för externa grupper lagras i användarprofilen i egenskapen `rep:externalPrincipalNames`

### Konfigurera automatisk migrering till dynamiskt gruppmedlemskap

1. Aktivera egenskapen `"identitySyncType": "idp_dynamic_simplified_id"` i SAML OSGi-konfigurationsfilen: `com.adobe.granite.auth.saml.SamlAuthenticationHandler~...cfg.json`:
2. Konfigurera den nya OSGi-tjänsten med Factory PID som börjar med: `com.adobe.granite.auth.saml.migration.SamlDynamicGroupMembershipMigration~`. Ett PID kan till exempel vara: `com.adobe.granite.auth.saml.migration.SamlDynamicGroupMembershipMigration~myIdP`. Ange följande egenskap:

```
{
  "idpIdentifier": "<value of IDP Identifier (idpIdentifier)" property from the "com.adobe.granite.auth.saml.SamlAuthenticationHandler" configuration to be migrated>"
}
```

Om du vill migrera flera SAML-konfigurationer måste du skapa flera OSGi-fabrikskonfigurationer för `com.adobe.granite.auth.saml.migration.SamlDynamicGroupMembershipMigration`, där var och en anger en `idpIdentifier` som ska migreras.

## Distribuera SAML-konfiguration

OSGi-konfigurationerna måste implementeras i Git och distribueras till AEM as a Cloud Service med Cloud Manager.

```
$ git remote -v            
adobe   https://git.cloudmanager.adobe.com/myOrg/myCloudManagerGit/ (fetch)
adobe   https://git.cloudmanager.adobe.com/myOrg/myCloudManagerGit/ (push)
$ git add .
$ git commit -m "SAML 2.0 configurations"
$ git push adobe saml-auth:develop
```

Distribuera Cloud Manager Git-målgrenen (i det här exemplet `develop`) med hjälp av en pipeline för distribution av Full Stack.

## Anropa SAML-autentisering

SAML-autentiseringsflödet kan anropas från en AEM-webbplats, genom att skapa särskilt utformade länkar eller knappar. De parametrar som beskrivs nedan kan programmatiskt ställas in vid behov, så till exempel kan en inloggningsknapp ställa in `saml_request_path`, vilket är där användaren tas vid lyckad SAML-autentisering, till olika AEM-sidor, baserat på knappens kontext.

## Säker cache medan jag använder SAML

På AEM publiceringsinstansen är de flesta sidor vanligtvis cachade. För SAML-skyddade vägar bör dock caching antingen inaktiveras eller säkrad caching aktiveras med auth_checker-konfigurationen. Mer information finns i [här](https://experienceleague.adobe.com/sv/docs/experience-manager-dispatcher/using/configuring/permissions-cache)

Observera att om du cachelagrar skyddade sökvägar utan att aktivera auth_checker kan du uppleva oförutsägbara beteenden.

### GET-begäran

SAML-autentisering kan anropas genom att skapa en HTTP GET-förfrågan i formatet:

`HTTP GET /system/sling/login`

och tillhandahåller frågeparametrar:

| Frågeparameterns namn | Fråga parametervärde |
|----------------------|-----------------------|
| `resource` | Varje JCR-väg, eller del-väg, som är SAML-autentiseringshanteraren lyssnar på, enligt definitionen i [Adobe Granite SAML 2.0 Authentication Handler OSGi-konfigurationens](#configure-saml-2-0-authentication-handler) `path` egenskap. |
| `saml_request_path` | URL-vägen som användaren ska ledas till efter lyckad SAML-autentisering. |

Till exempel kommer denna HTML-länk att trigga SAML:s inloggningsflöde, och när det lyckas tas användaren till `/content/wknd/us/en/protected/page.html`. Dessa frågeparametrar kan programmatiskt ställas in efter behov.

```html
<a href="/system/sling/login?resource=/content/wknd&saml_request_path=/content/wknd/us/en/protected/page.html">
    Log in using SAML
</a>
```

## POST-förfrågan

SAML-autentisering kan anropas genom att skapa en HTTP POST-förfrågan i formatet:

`HTTP POST /system/sling/login`

och tillhandahålla formulärdata:

| Formdatanamn | Formdatavärde |
|----------------------|-----------------------|
| `resource` | Varje JCR-väg, eller del-väg, som är SAML-autentiseringshanteraren lyssnar på, enligt definitionen i [Adobe Granite SAML 2.0 Authentication Handler OSGi-konfigurationens](#configure-saml-2-0-authentication-handler) `path` egenskap. |
| `saml_request_path` | URL-vägen som användaren ska ledas till efter lyckad SAML-autentisering. |


Till exempel använder denna HTML-knapp en HTTP POST för att trigga SAML-inloggningsflödet, och när det lyckas ta användaren till `/content/wknd/us/en/protected/page.html`. Dessa formulärdataparametrar kan programmatiskt ställas in efter behov.

```html
<form action="/system/sling/login" method="POST">
    <input type="hidden" name="resource" value="/content/wknd">
    <input type="hidden" name="saml_request_path" value="/content/wknd/us/en/protected/page.html">
    <input type="submit" value="Log in using SAML">
</form>
```

### Dispatcherkonfiguration

Både HTTP GET och POST-metoderna kräver klientåtkomst till AEM:s `/system/sling/login` endpoints, och därför måste de tillåtas via AEM Dispatcher.

Tillåt nödvändiga URL-mönster baserat på om GET eller POST används

```
# Allow GET-based SAML authentication invocation
/0191 { /type "allow" /method "GET" /url "/system/sling/login" /query "*" }

# Allow POST-based SAML authentication invocation
/0192 { /type "allow" /method "POST" /url "/system/sling/login" }
```
