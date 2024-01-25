---
title: SAML 2.0 på AEM as a Cloud Service
description: Lär dig hur du konfigurerar SAML 2.0-autentisering på AEM as a Cloud Service Publish-tjänst.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9351
thumbnail: 343040.jpeg
last-substantial-update: 2022-10-17T00:00:00Z
exl-id: 461dcdda-8797-4a37-a0c7-efa7b3f1e23e
duration: 2365
source-git-commit: 9fef4b77a2c70c8cf525d42686f4120e481945ee
workflow-type: tm+mt
source-wordcount: '3137'
ht-degree: 0%

---

# SAML 2.0-autentisering{#saml-2-0-authentication}

Lär dig hur du konfigurerar och autentiserar slutanvändare (inte AEM författare) till en SAML 2.0-kompatibel IDP som du väljer.

## Vilken SAML för AEM as a Cloud Service?

SAML 2.0-integrering med AEM Publish (eller Preview) gör att slutanvändare av en AEM-baserad webbupplevelse kan autentisera till en icke-Adobe IDP (Identity Provider) och få åtkomst AEM som namngiven, auktoriserad användare.

|                       | AEM | AEM Publish |
|-----------------------|:----------:|:-----------:|
| Stöd för SAML 2.0 | ✘ | ✔ |

+++ Förstå SAML 2.0-flödet med AEM

Det typiska flödet av en AEM-integration med publiceringsSAML är följande:

1. Användaren begär att AEM Publicera indikationen att autentisering krävs.
   + Användaren begär en CUG/ACL-skyddad resurs.
   + Användaren begär en resurs som är föremål för ett autentiseringskrav.
   + Användaren följer en länk AEM inloggningsslutpunkten (d.v.s. `/system/sling/login`) som uttryckligen begär inloggningsåtgärden.
1. AEM gör en AuthnRequest till IDP och begär att IDP ska starta autentiseringsprocessen.
1. Användaren autentiserar mot IDP.
   + Användaren uppmanas att ange autentiseringsuppgifter av IDP:n.
   + Användaren är redan autentiserad med IDP och behöver inte ange ytterligare autentiseringsuppgifter.
1. IDP genererar en SAML-försäkran som innehåller användarens data och signerar den med IDP:s privata certifikat.
1. IDP skickar SAML-försäkran via HTTP-POST via användarens webbläsare till AEM Publish.
1. AEM Publish får SAML-försäkran och validerar SAML-intygets integritet och autenticitet med IDP:s offentliga certifikat.
1. AEM Publish hanterar AEM användarpost baserat på SAML 2.0 OSGi-konfigurationen och innehållet i SAML Assertion.
   + Skapar användare
   + Synkroniserar användarattribut
   + Uppdateringar AEM användargruppsmedlemskap
1. AEM Publish anger AEM `login-token` cookie på HTTP-svaret, som används för att autentisera efterföljande begäranden till AEM.
1. AEM Publish dirigerar om användaren till URL vid AEM Publish enligt `saml_request_path` cookie.

+++

## Genomgång av konfiguration

>[!VIDEO](https://video.tv.adobe.com/v/343040?quality=12&learn=on)

I den här videon går vi igenom hur man konfigurerar SAML 2.0-integrering med AEM as a Cloud Service Publish-tjänst och använder Okta som IDP.

## Förutsättningar

Följande krävs när du konfigurerar SAML 2.0-autentisering:

+ Åtkomst till Cloud Manager för Distributionshanteraren
+ AEM administratörsåtkomst till AEM as a Cloud Service miljö
+ Administratörsåtkomst till IDP:n
+ Tillgång till ett offentligt/privat nyckelpar som används för att kryptera SAML-nyttolaster

SAML 2.0 stöds endast för att autentisera användning för AEM publicera eller förhandsgranska. Om du vill hantera autentiseringen av AEM författare med och IDP [integrera IDP med Adobe IMS](https://helpx.adobe.com/enterprise/using/set-up-identity.html).


## Installera det offentliga IDP-certifikatet på AEM

IDP:s offentliga certifikat läggs till i AEM Global Trust Store och används för att validera att SAML-försäkran som skickas av IDP är giltig.

+++SAML-kontrollsigneringsflöde

![SAML 2.0 - IDP SAML Assertion signing](./assets/saml-2-0/idp-signing-diagram.png)

1. Användaren autentiserar mot IDP.
1. IDP genererar en SAML-försäkran som innehåller användarens data.
1. IDP signerar SAML-försäkran med IDP:s privata certifikat.
1. IDP initierar en HTTP-POST på klientsidan AEM Publish SAML-slutpunkt (`.../saml_login`) som innehåller den signerade SAML-försäkran.
1. AEM Publish tar emot HTTP-POSTEN som innehåller den signerade SAML-försäkran, kan validera signaturen med det offentliga IDP-certifikatet.

+++

![Lägg till det offentliga IDP-certifikatet i Global Trust Store](./assets/saml-2-0/global-trust-store.png)

1. Hämta __offentligt certifikat__ från IDP. Det här certifikatet gör att AEM kan validera SAML-försäkran som tillhandahålls AEM av IDP.

   Certifikatet är i PEM-format och bör likna:

   ```
   -----BEGIN CERTIFICATE-----
   MIIC4jCBAcoCCQC33wnybT5QZDANBgkqhkiG9w0BAQsFADAyMQswCQYDVQQGEwJV
   ...
   m0eo2USlSRTVl7QHRTuiuSThHpLKQQ==
   -----END CERTIFICATE-----
   ```

1. Logga in AEM författare som AEM administratör.
1. Navigera till __Verktyg > Säkerhet > Trust Store__.
1. Skapa eller öppna Global Trust Store. Om du skapar en Global Trust Store ska du spara lösenordet på ett säkert ställe.
1. Expandera __Lägg till certifikat från CER-fil__.
1. Välj __Välj certifikatfil__ och överför certifikatfilen från IDP.
1. Lämna __Mappa certifikat till användare__ tom.
1. Välj __Skicka__.
1. Det nya certifikatet visas ovanför __Lägg till certifikat från CRT-fil__ -avsnitt.
1. Anteckna __alias__, eftersom det här värdet används i [SAML 2.0 Authentication Handler OSGi configuration](#saml-2-0-authentication-handler-osgi-configuration).
1. Välj __Spara och stäng__.

Global Trust Store är konfigurerad med IDP:s offentliga certifikat på AEM Author, men eftersom SAML bara används vid AEM Publish måste Global Trust Store replikeras till AEM Publish för att IDP:s offentliga certifikat ska vara tillgängligt där.

![Replikera det globala förtroendearkivet för att AEM publicera](./assets/saml-2-0/global-trust-store-replicate.png)

1. Navigera till __Verktyg > Distribution > Paket__.
1. Skapa ett paket
   + Paketnamn: `Global Trust Store`
   + Version: `1.0.0`
   + Grupp: `com.your.company`
1. Redigera det nya __Global Trust Store__ paket.
1. Välj __Filter__ och lägga till ett filter för rotsökvägen `/etc/truststore`.
1. Välj __Klar__ och sedan __Spara__.
1. Välj __Bygge__ för __Global Trust Store__ paket.
1. Välj __Mer__ > __Replikera__ för att aktivera noden Global Trust Store (`/etc/truststore`) till AEM Publish.

## Skapa nyckelbehållare för autentiseringstjänster{#authentication-service-keystore}

_Du måste skapa en nyckelbehållare för autentiseringstjänsten när [SAML 2.0-autentiseringshanterare OSGi-konfigurationsegenskap `handleLogout` är inställd på `true`](#saml-20-authenticationsaml-2-0-authentication) eller när [AuthnRequest signing/SAML assertion ecryption](#install-aem-public-private-key-pair) krävs_

1. Logga in på AEM författare som AEM administratör för att överföra den privata nyckeln.
1. Navigera till __Verktyg > Säkerhet > Användare__ och markera __authentication-service__ användare och markera __Egenskaper__ i det övre åtgärdsfältet.
1. Välj __Nyckelbehållare__ -fliken.
1. Skapa eller öppna nyckelbehållaren. Om du skapar en nyckelbehållare ska du se till att lösenordet är säkert.
   + A [offentlig/privat nyckelbehållare har installerats i den här nyckelbehållaren](#install-aem-public-private-key-pair) endast om AuthnRequest-kryptering för signering/SAML-försäkran krävs.
   + Om den här SAML-integreringen stöder utloggning, men inte AuthnRequest-signering/SAML-kontroll, räcker det med en tom nyckelbehållare.
1. Välj __Spara och stäng__.
1. Skapa ett paket som innehåller den uppdaterade __authentication-service__ användare.

   _Använd följande tillfälliga lösning med paket:_

   1. Navigera till __Verktyg > Distribution > Paket__.
   1. Skapa ett paket
      + Paketnamn: `Authentication Service`
      + Version: `1.0.0`
      + Grupp: `com.your.company`
   1. Redigera det nya __Nyckelarkiv för autentiseringstjänst__ paket.
   1. Välj __Filter__ och lägga till ett filter för rotsökvägen `/home/users/system/cq:services/internal/security/<AUTHENTICATION SERVICE UUID>/keystore`.
      + The `<AUTHENTICATION SERVICE UUID>` kan hittas genom att navigera till __Verktyg > Säkerhet > Användare__ och markera __authentication-service__ användare. UUID är den sista delen av URL:en.
   1. Välj __Klar__ och sedan __Spara__.
   1. Välj __Bygge__ för __Nyckelarkiv för autentiseringstjänst__ paket.
   1. Välj __Mer__ > __Replikera__ för att aktivera autentiseringstjänstens nyckelarkiv för AEM publicering.

## Installera AEM publika/privata nyckelpar{#install-aem-public-private-key-pair}

_Det är valfritt att installera det offentliga/privata nyckelparet AEM_

AEM Publish kan konfigureras för att signera AuthnRequests (till IDP) och kryptera SAML-bekräftelser (till AEM). Detta uppnås genom att tillhandahålla en privat nyckel för att AEM publicera, och den matchar den offentliga nyckeln till IDP.

+++ Förstå signeringsflödet för AuthnRequest (valfritt)

AuthnRequest (begäran till IDP från AEM Publish som initierar inloggningsprocessen) kan signeras av AEM Publish. För att göra detta signerar AEM Publish AuthnRequest med hjälp av den privata nyckeln, som IDP sedan validerar signaturen med den offentliga nyckeln. Detta garanterar IDP att AuthnRequest initierades och begärdes av AEM Publish och inte av en skadlig tredje part.

![SAML 2.0 - SP AuthnRequest-signering](./assets/saml-2-0/sp-authnrequest-signing-diagram.png)

1. Användaren gör en HTTP-begäran om att AEM publicera som resulterar i en SAML-autentiseringsbegäran till IDP:n.
1. AEM Publish genererar SAML-begäran som ska skickas till IDP.
1. AEM Publish signerar SAML-begäran med AEM privata nyckel.
1. AEM Publish initierar AuthnRequest, en omdirigering på HTTP-klienten till IDP:n som innehåller den signerade SAML-begäran.
1. IDP tar emot AuthnRequest och validerar signaturen med AEM publika nyckel, vilket garanterar AEM Publish initierade AuthnRequest.
1. AEM Publish validerar sedan den dekrypterade SAML-kontrollens integritet och autenticitet med det offentliga IDP-certifikatet.

+++

+++ Förstå krypteringsflödet för SAML-försäkran (valfritt)

All HTTP-kommunikation mellan IDP och AEM Publish ska ske via HTTPS och därmed vara säker som standard. Om det behövs kan SAML-kontroller krypteras om extra sekretess krävs utöver HTTPS. För att göra detta krypterar IDP SAML-kontrolldata med den privata nyckeln och AEM Publish dekrypterar SAML-försäkran med den privata nyckeln.

![SAML 2.0 - SP SAML Assertion encryption](./assets/saml-2-0/sp-samlrequest-encryption-diagram.png)

1. Användaren autentiserar mot IDP.
1. IDP genererar en SAML-försäkran som innehåller användarens data och signerar den med IDP:s privata certifikat.
1. IDP krypterar sedan SAML-försäkran med AEM publika nyckel, vilket kräver att den AEM privata nyckeln dekrypteras.
1. Den krypterade SAML-kontrollen skickas via användarens webbläsare till AEM Publicera.
1. AEM Publish tar emot SAML-försäkran och dekrypterar den med AEM privata nyckel.
1. IDP uppmanar användaren att autentisera.

+++

Både AuthnRequest-signering och SAML-verifieringskryptering är valfria, men båda är aktiverade med [SAML 2.0-autentiseringshanterare OSGi-konfigurationsegenskap `useEncryption`](#saml-20-authenticationsaml-2-0-authentication), vilket innebär att båda eller inget av dem kan användas.

![AEM nyckelarkiv för autentiseringstjänst](./assets/saml-2-0/authentication-service-key-store.png)

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
   + Använda `openssl` metoden ovan är den offentliga nyckeln `aem-public.crt` -fil.
1. Logga in på AEM författare som AEM administratör för att överföra den privata nyckeln.
1. Navigera till __Verktyg > Säkerhet > Trust Store__ och markera __authentication-service__ användare och markera __Egenskaper__ i det övre åtgärdsfältet.
1. Navigera till __Verktyg > Säkerhet > Användare__ och markera __authentication-service__ användare och markera __Egenskaper__ i det övre åtgärdsfältet.
1. Välj __Nyckelbehållare__ -fliken.
1. Skapa eller öppna nyckelbehållaren. Om du skapar en nyckelbehållare ska du se till att lösenordet är säkert.
1. Välj __Lägg till privat nyckel från DER-fil__ och lägg till den privata nyckeln och kedjefilen i AEM:
   + __Alias__: Ange ett beskrivande namn, ofta namnet på IDP.
   + __Privat nyckelfil__: Överför den privata nyckelfilen (PKCS#8 i DER-format).
      + Använda `openssl` metoden ovan är detta `aem-private-pkcs8.der` fil
   + __Välj certifikatkedjefil__: Överför den medföljande kedjefilen (det kan vara den offentliga nyckeln).
      + Använda `openssl` metoden ovan är detta `aem-public.crt` fil
   + Välj __Skicka__
1. Det nya certifikatet visas ovanför __Lägg till certifikat från CRT-fil__ -avsnitt.
   + Anteckna __alias__ eftersom detta används i [SAML 2.0-autentiseringshanterare OSGi-konfiguration](#saml-20-authentication-handler-osgi-configuration)
1. Välj __Spara och stäng__.
1. Skapa ett paket som innehåller den uppdaterade __authentication-service__ användare.

   _Använd följande tillfälliga lösning med paket:_

   1. Navigera till __Verktyg > Distribution > Paket__.
   1. Skapa ett paket
      + Paketnamn: `Authentication Service`
      + Version: `1.0.0`
      + Grupp: `com.your.company`
   1. Redigera det nya __Nyckelarkiv för autentiseringstjänst__ paket.
   1. Välj __Filter__ och lägga till ett filter för rotsökvägen `/home/users/system/cq:services/internal/security/<AUTHENTICATION SERVICE UUID>/keystore`.
      + The `<AUTHENTICATION SERVICE UUID>` kan hittas genom att navigera till __Verktyg > Säkerhet > Användare__ och markera __authentication-service__ användare. UUID är den sista delen av URL:en.
   1. Välj __Klar__ och sedan __Spara__.
   1. Välj __Bygge__ för __Nyckelarkiv för autentiseringstjänst__ paket.
   1. Välj __Mer__ > __Replikera__ för att aktivera autentiseringstjänstens nyckelarkiv för AEM publicering.

## Konfigurera autentiseringshanteraren för SAML 2.0{#configure-saml-2-0-authentication-handler}

AEM SAML-konfiguration utförs via __Autentiseringshanterare för Adobe Granite SAML 2.0__ OSGi-konfiguration.
Konfigurationen är en OSGi-fabrikskonfiguration, vilket innebär att en enda AEM as a Cloud Service Publish-tjänst kan ha flera SAML-konfigurationsträd som täcker diskreta resursträd i databasen. Detta är användbart för AEM på flera platser.

+++ Konfigurationsordlista för SAML 2.0 Authentication Handler OSGi

### Adobe Granite SAML 2.0 Authentication Handler OSGi configuration{#configure-saml-2-0-authentication-handler-osgi-configuration}

|                                   | OSGi, egenskap | Obligatoriskt | Värdeformat | Standardvärde | Beskrivning |
|-----------------------------------|-------------------------------|:--------:|:---------------------:|---------------------------|-------------|
| Banor | `path` | ✔ | Strängarray | `/` | AEM sökvägar som den här autentiseringshanteraren används för. |
| IDP-URL | `idpUrl` | ✔ | Sträng |                           | IDP-URL som SAML-autentiseringsbegäran skickas till. |
| ID-certifikatalias | `idpCertAlias` | ✔ | Sträng |                           | Aliaset för IDP-certifikatet som finns i AEM Global Trust Store |
| IDP HTTP-omdirigering | `idpHttpRedirect` | ✘ | Boolean | `false` | Anger om en HTTP-omdirigering till IDP-URL:en används i stället för att en AuthnRequest skickas. Ange till `true` för IDP-initierad autentisering. |
| IDP-identifierare | `idpIdentifier` | ✘ | Sträng |                           | Unikt ID för att säkerställa att AEM användare och grupper är unika. Om den är tom visas `serviceProviderEntityId` används i stället. |
| URL för konsumenttjänst för försäkran | `assertionConsumerServiceURL` | ✘ | Sträng |                           | The `AssertionConsumerServiceURL` URL-attributet i AuthnRequest anger var `<Response>` meddelandet måste skickas till AEM. |
| SP-enhets-ID | `serviceProviderEntityId` | ✔ | Sträng |                           | Identifierar AEM till IDP, vanligtvis det AEM värdnamnet. |
| SP-kryptering | `useEncryption` | ✘ | Boolean | `true` | Anger om IDP krypterar SAML-försäkringar. Kräver `spPrivateKeyAlias` och `keyStorePassword` som ska anges. |
| Lösenordsalias för privat nyckel | `spPrivateKeyAlias` | ✘ | Sträng |                           | Aliaset för den privata nyckeln i `authentication-service` användarens nyckelbehållare. Obligatoriskt om `useEncryption` är inställd på `true`. |
| Lösenord för SP-nyckelarkiv | `keyStorePassword` | ✘ | Sträng |                           | Lösenordet för användarens nyckellager för authentication-service. Obligatoriskt om `useEncryption` är inställd på `true`. |
| Standardomdirigering | `defaultRedirectUrl` | ✘ | Sträng | `/` | Standardomdirigerings-URL efter lyckad autentisering. Kan vara relativ till AEM (t.ex. `/content/wknd/us/en/html`). |
| Användar-ID-attribut | `userIDAttribute` | ✘ | Sträng | `uid` | Namnet på SAML-kontrollattributet som innehåller användar-ID:t för den AEM användaren. Lämna tomt om du vill använda `Subject:NameId`. |
| Skapa AEM användare automatiskt | `createUser` | ✘ | Boolean | `true` | Anger om AEM användare skapas vid lyckad autentisering. |
| AEM användarmellanliggande sökväg | `userIntermediatePath` | ✘ | Sträng |                           | När du skapar AEM användare används det här värdet som mellanliggande sökväg (till exempel `/home/users/<userIntermediatePath>/jane@wknd.com`). Kräver `createUser` som ska anges till `true`. |
| AEM | `synchronizeAttributes` | ✘ | Strängarray |                           | Lista över SAML-attributmappningar som ska lagras på den AEM användaren i formatet `[ "saml-attribute-name=path/relative/to/user/node" ]` (till exempel `[ "firstName=profile/givenName" ]`). Se [fullständig lista över AEM](#aem-user-attributes). |
| Lägg till användare i AEM | `addGroupMemberships` | ✘ | Boolean | `true` | Anger om en AEM automatiskt läggs till i AEM användargrupper efter lyckad autentisering. |
| AEM | `groupMembershipAttribute` | ✘ | Sträng | `groupMembership` | Namnet på SAML-kontrollattributet som innehåller en lista AEM användargrupper som användaren ska läggas till i. Kräver `addGroupMemberships` som ska anges till `true`. |
| AEM | `defaultGroups` | ✘ | Strängarray |                           | En lista AEM användargrupper som autentiserats läggs alltid till i (till exempel `[ "wknd-user" ]`). Kräver `addGroupMemberships` som ska anges till `true`. |
| NameIDPolicy-format | `nameIdFormat` | ✘ | Sträng | `urn:oasis:names:tc:SAML:2.0:nameid-format:transient` | Värdet på formatparametern NameIDPolicy som ska skickas i AuthnRequest-meddelandet. |
| Spara SAML-svar | `storeSAMLResponse` | ✘ | Boolean | `false` | Anger om `samlResponse` värdet lagras på AEM `cq:User` nod. |
| Hantera utloggning | `handleLogout` | ✘ | Boolean | `false` | Anger om utloggningsbegäran hanteras av den här SAML-autentiseringshanteraren. Kräver `logoutUrl` som ska anges. |
| Utloggnings-URL | `logoutUrl` | ✘ | Sträng |                           | IDP:s URL dit SAML-utloggningsbegäran skickas. Obligatoriskt om `handleLogout` är inställd på `true`. |
| Klocktolerans | `clockTolerance` | ✘ | Heltal | `60` | IDP och AEM (SP), klockskevningstolerans vid validering av SAML-försäkran. |
| Sammanfattningsmetod | `digestMethod` | ✘ | Sträng | `http://www.w3.org/2001/04/xmlenc#sha256` | Den sammandragsalgoritm som IDP använder vid signering av ett SAML-meddelande. |
| Signaturmetod | `signatureMethod` | ✘ | Sträng | `http://www.w3.org/2001/04/xmldsig-more#rsa-sha256` | Den signaturalgoritm som IDP använder när ett SAML-meddelande signeras. |
| Identitetssynkroniseringstyp | `identitySyncType` | ✘ | `default` eller `idp` | `default` | Ändra inte `from` standard för AEM as a Cloud Service. |
| Servicerankning | `service.ranking` | ✘ | Heltal | `5002` | Högre rangordningskonfigurationer rekommenderas för samma `path`. |

### AEM{#aem-user-attributes}

AEM använder följande användarattribut, som kan fyllas i med `synchronizeAttributes` i Adobe Granite SAML 2.0 Authentication Handler OSGi-konfigurationen.  Alla IDP-attribut kan synkroniseras med valfri AEM användaregenskap, men mappning till AEM använd attributegenskaper (som listas nedan) gör att AEM kan använda dem på ett naturligt sätt.

| Användarattribut | Relativ egenskapssökväg från `rep:User` nod |
|--------------------------------|--------------------------|
| Titel (till exempel `Mrs`) | `profile/title` |
| Förnamn (dvs förnamn) | `profile/givenName` |
| Efternamn (t.ex. efternamn) | `profile/familyName` |
| Befattning | `profile/jobTitle` |
| E-postadress | `profile/email` |
| Gatuadress | `profile/street` |
| Ort | `profile/city` |
| Postnummer | `profile/postalCode` |
| Land | `profile/country` |
| Telefonnummer | `profile/phoneNumber` |
| Om mig | `profile/aboutMe` |

+++

1. Skapa en OSGi-konfigurationsfil i ditt projekt på `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.adobe.granite.auth.saml.SamlAuthenticationHandler~saml.cfg.json` och öppnas i din utvecklingsmiljö.
   + Ändra `/wknd-examples/` till `/<project name>/`
   + Identifieraren efter `~` i filnamnet ska unikt identifiera konfigurationen, så det kan vara namnet på IDP:n, som `...~okta.cfg.json`. Värdet ska vara alfanumeriskt med bindestreck.
1. Klistra in följande JSON i `com.adobe.granite.auth.saml.SamlAuthenticationHandler~...cfg.json` och uppdatera `wknd` referenser efter behov.

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

1. Uppdatera de värden som krävs för projektet. Se __Konfigurationsordlista för SAML 2.0 Authentication Handler OSGi__ ovan för beskrivningar av konfigurationsegenskaper
1. Vi rekommenderar, men behöver inte göra det, att du använder OSGi-miljövariabler och hemligheter när värdena kan ändras osynkroniserade med versionscykeln eller när värdena skiljer sig åt mellan liknande miljötyper/tjänstnivåer. Standardvärden kan anges med `$[env:..;default=the-default-value]"` syntax enligt ovan.

OSGi-konfigurationer per miljö (`config.publish.dev`, `config.publish.stage`och `config.publish.prod`) kan definieras med specifika attribut om SAML-konfigurationen varierar mellan olika miljöer.

### Använd kryptering

När [kryptera AuthnRequest och SAML-försäkran](#encrypting-the-authnrequest-and-saml-assertion)krävs följande egenskaper: `useEncryption`, `spPrivateKeyAlias`och `keyStorePassword`. The `keyStorePassword` innehåller ett lösenord och därför får värdet inte lagras i OSGi-konfigurationsfilen, utan injiceras med [hemliga konfigurationsvärden](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html#secret-configuration-values)

+++Som tillval kan du uppdatera OSGi-konfigurationen så att kryptering används

1. Öppna `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.adobe.granite.auth.saml.SamlAuthenticationHandler~saml.cfg.json` i din utvecklingsmiljö.
1. Lägg till de tre egenskaperna `useEncryption`, `spPrivateKeyAlias`och `keyStorePassword` enligt nedan.

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

1. De tre OSGi-konfigurationsegenskaperna som krävs för kryptering är:

+ `useEncryption` ange till `true`
+ `spPrivateKeyAlias` innehåller nyckelbehållarens postalias för den privata nyckel som används av SAML-integreringen.
+ `keyStorePassword` innehåller en [OSGi hemlig konfigurationsvariabel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/deploying/configuring-osgi.html#secret-configuration-values) innehåller `authentication-service` användarens lösenord.

+++

## Konfigurera referensfilter

Under SAML-autentiseringsprocessen initierar IDP en HTTP-POST på klientsidan för att AEM publiceringens `.../saml_login` slutpunkt. Om IDP och AEM Publish finns på olika ursprung AEM Publish&#39;s __Referensfilter__ har konfigurerats via OSGi-konfiguration för att tillåta HTTP POST från IDP:s ursprung.

1. Skapa (eller redigera) en OSGi-konfigurationsfil i ditt projekt på `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/org.apache.sling.security.impl.ReferrerFilter.cfg.json`.
   + Ändra `/wknd-examples/` till `/<project name>/`
1. Kontrollera `allow.empty` värdet är inställt på `true`, `allow.hosts` (eller om du vill, `allow.hosts.regexp`) innehåller IDP:ns ursprung, och `filter.methods` inkluderar `POST`. OSGi-konfigurationen ska vara som:

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

AEM Publish har stöd för en enda konfiguration för refererarfilter, så sammanfoga SAML-konfigurationskraven med befintliga konfigurationer.

OSGi-konfigurationer per miljö (`config.publish.dev`, `config.publish.stage`och `config.publish.prod`) kan definieras med specifika attribut om `allow.hosts` (eller `allow.hosts.regex`) varierar mellan olika miljöer.

## Konfigurera Cross-Origin Resource Sharing (CORS)

Under SAML-autentiseringsprocessen initierar IDP en HTTP-POST på klientsidan för att AEM publiceringens `.../saml_login` slutpunkt. Om IDP och AEM Publish finns på olika värdar/domäner AEM Publish&#39;s __CRoss-Origin Resource Sharing (CORS)__ måste vara konfigurerat för att tillåta HTTP POST från IDP:s värd/domän.

Denna begäran om HTTP-POST `Origin` huvudet har vanligtvis ett annat värde än AEM Publish-värden, vilket kräver CORS-konfiguration.

Vid testning av SAML-autentisering på lokal AEM SDK (`localhost:4503`) kan IDP ange `Origin` sidhuvud till `null`. Om så är fallet, lägg till `"null"` till `alloworigin` lista.

1. Skapa en OSGi-konfigurationsfil i ditt projekt på `/ui.config/src/main/content/jcr_root/wknd-examples/osgiconfig/config.publish/com.adobe.granite.cors.impl.CORSPolicyImpl~saml.cfg.json`
   + Ändra `/wknd-examples/` till ditt projektnamn
   + Identifieraren efter `~` i filnamnet ska unikt identifiera konfigurationen, så det kan vara namnet på IDP:n, som `...CORSPolicyImpl~okta.cfg.json`. Värdet ska vara alfanumeriskt med bindestreck.
1. Klistra in följande JSON i `com.adobe.granite.cors.impl.CORSPolicyImpl~...cfg.json` -fil.

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

OSGi-konfigurationer per miljö (`config.publish.dev`, `config.publish.stage`och `config.publish.prod`) kan definieras med specifika attribut om `alloworigin` och `allowedpaths` olika miljöer.

## Konfigurera AEM Dispatcher för att tillåta SAML HTTP POST

Efter lyckad autentisering till IDP kommer IDP att dirigera en HTTP-POST tillbaka till AEM registrerade `/saml_login` slutpunkt (konfigurerad i IDP). Den här HTTP-POSTEN till `/saml_login` är som standard blockerad vid Dispatcher, så den måste uttryckligen tillåtas med följande Dispatcher-regel:

1. Öppna `dispatcher/src/conf.dispatcher.d/filters/filters.any` i din utvecklingsmiljö.
1. Lägg till en Tillåt-regel för HTTP POST i URL:er som slutar med `/saml_login`.

```
...

# Allow SAML HTTP POST to ../saml_login end points
/0190 { /type "allow" /method "POST" /url "*/saml_login" }
```

Om URL-omskrivning på Apache-webbservern är konfigurerad (`dispatcher/src/conf.d/rewrites/rewrite.rules`) måste du se till att `.../saml_login` ändpunkter inte av misstag bemästras.

## Aktivera datasynkronisering och kapsla in tokens

När SAML-autentiseringsflödet skapar en användare i AEM Publish kan AEM användarnod autentiseras i AEM.
Detta kräver [datasynkronisering](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/personalization/user-and-group-sync-for-publish-tier.html#data-synchronization) och [inkapslade tokens](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/sites/authoring/personalization/user-and-group-sync-for-publish-tier.html#sticky-sessions-and-encapsulated-tokens) aktiveras av Adobe Support på AEM Publish Service.

Skicka en förfrågan till Adobe kundsupport (via [AdminConsole](https://adminconsole.adobe.com) > Support) begär:

> Datasynkronisering och inkapslade tokens är aktiverade AEM publiceringstjänsten för program X och miljö Y.

## Distribuera SAML-konfiguration

OSGi-konfigurationerna måste implementeras i Git och distribueras till AEM as a Cloud Service med hjälp av Cloud Manager.

```
$ git remote -v            
adobe   https://git.cloudmanager.adobe.com/myOrg/myCloudManagerGit/ (fetch)
adobe   https://git.cloudmanager.adobe.com/myOrg/myCloudManagerGit/ (push)
$ git add .
$ git commit -m "SAML 2.0 configurations"
$ git push adobe saml-auth:develop
```

Distribuera målmolnhanterarens Git-gren (i det här exemplet) `develop`), med ett fullständigt produktionsflöde för stackdistribution.
