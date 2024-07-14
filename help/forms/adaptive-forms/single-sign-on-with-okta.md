---
title: Konfigurera OKTA med AEM
description: Förstå olika konfigurationsinställningar för att använda enkel inloggning med okta
feature: Adaptive Forms
version: 6.5
topic: Administration
role: Admin
level: Experienced
exl-id: 85c9b51e-92bb-4376-8684-57c9c3204b2f
last-substantial-update: 2021-06-09T00:00:00Z
duration: 153
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '733'
ht-degree: 0%

---

# Autentisera till AEM författare med OKTA

Det första steget är att konfigurera appen på OKTA-portalen. När appen har godkänts av din OKTA-administratör har du tillgång till IdP-certifikatet och URL:en för enkel inloggning. Följande inställningar används vanligtvis för att registrera nya program.

* **Programnamn:** Detta är ditt programnamn. Se till att du ger programmet ett unikt namn.
* **SAML-mottagare:** Efter autentisering från OKTA är det här den URL som skulle drabba din AEM med SAML-svaret. SAML-autentiseringshanteraren fångar vanligtvis alla URL:er med / saml_login, men det är bättre att lägga till dem efter programroten.
* **SAML-målgrupp**: Detta är programmets domän-URL. Använd inte protocol(http eller https) i domänens URL.
* **SAML-namn-ID:** Välj E-post i listrutan.
* **Miljö**: Välj lämplig miljö.
* **Attribut**: Detta är de attribut du får om användaren i SAML-svaret. Specificera dem efter behov.


![okta-program](assets/okta-app-settings-blurred.PNG)


## Lägg till OKTA-certifikatet (IdP) i AEM Trust Store

Eftersom SAML-bekräftelser krypteras måste vi lägga till IdP-certifikatet (OKTA) i AEM förtroendearkiv för att möjliggöra säker kommunikation mellan OKTA och AEM.
[Initiera förtroendearkivet](http://localhost:4502/libs/granite/security/content/truststore.html), om det inte redan har initierats.
Kom ihåg lösenordet för förtroendearkivet. Vi måste använda det här lösenordet senare i den här processen.

* Navigera till [Global Trust Store](http://localhost:4502/libs/granite/security/content/truststore.html).
* Klicka på Lägg till certifikat från CER-fil. Lägg till IdP-certifikatet från OKTA och klicka på skicka.

  >[!NOTE]
  >
  >Koppla inte certifikatet till någon användare

När du lägger till certifikatet i förtroendearkivet bör du få certifikatalias, vilket visas i skärmbilden nedan. Aliasnamnet kan vara ett annat i ditt fall.

![Certifikatalias](assets/cert-alias.PNG)

**Anteckna certifikataliaset. Du behöver det här i de senare stegen.**

### Konfigurera SAML-autentiseringshanterare

Navigera till [configMgr](http://localhost:4502/system/console/configMgr).
Sök och öppna Adobe Granite SAML 2.0 Authentication Handler.
Ange följande egenskaper enligt nedan
Följande nyckelegenskaper måste anges:

* **sökväg** - Det här är sökvägen där autentiseringshanteraren aktiveras
* **IdP-URL**:Detta är din IdP-URL som tillhandahålls av OKTA
* **Alias för IDP-certifikat**:Detta alias du fick när du lade till IdP-certifikatet i AEM förtroendearkiv
* **Tjänstleverantörens enhets-ID**:Det här är namnet på AEM server
* **Lösenord för nyckelbehållaren**:Det här är lösenordet för förtroendearkivet som du använde
* **Standardomdirigering**:Det här är den URL som du vill omdirigera till när autentiseringen lyckades
* **UserID-attribut**:uid
* **Använd kryptering**:false
* **Skapa CRX-användare automatiskt**:true
* **Lägg till i grupper**:true
* **Standardgrupper**:oktausers(Detta är den grupp som användarna läggs till i. Du kan ange en befintlig grupp i AEM)
* **NamedIDPolicy**: Anger begränsningar för den namnidentifierare som ska användas för att representera det begärda ämnet. Kopiera och klistra in följande markerade sträng **urn:oasis:names:tc:SAML:2.0:nameidformat:emailAddress**
* **Synkroniserade attribut** - Dessa attribut lagras från SAML-försäkran i AEM profil

![saml-authentication-handler](assets/saml-authentication-settings-blurred.PNG)

### Konfigurera filtret Apache Sling Referer

Navigera till [configMgr](http://localhost:4502/system/console/configMgr).
Sök efter och öppna &quot;Apache Sling Referrer Filter&quot;.Ange följande egenskaper enligt nedan:

* **Tillåt tom**: falskt
* **Tillåt värdar**: IdP:s värdnamn (detta är annorlunda i ditt fall)
* **Tillåt Regexp-värd**: IdP:s värdnamn (detta är annorlunda i ditt fall)
Referensegenskaperna för Sling-referensfiltret, bild

![referrer-filter](assets/okta-referrer.png)

#### Konfigurera DEBUG-loggning för OKTA-integrering

När du konfigurerar OKTA-integreringen på AEM kan det vara praktiskt att granska DEBUG-loggarna för att AEM SAML-autentiseringshanteraren. Om du vill ställa in loggnivån på DEBUG skapar du en ny Sling Logger-konfiguration via AEM OSGi Web Console.

Kom ihåg att ta bort eller inaktivera den här loggboken på scenen och produktionen för att minska loggbruset.

När du konfigurerar OKTA-integreringen på AEM kan det vara praktiskt att granska DEBUG-loggar för att AEM SAML Authentication-hanteraren. Om du vill ställa in loggnivån på DEBUG skapar du en ny Sling Logger-konfiguration via AEM OSGi Web Console.
**Kom ihåg att ta bort eller inaktivera den här loggen på scenen och i produktionen för att minska loggbruset.**
* Navigera till [configMgr](http://localhost:4502/system/console/configMgr)

* Sök och öppna &quot;Apache Sling Logging Logger Configuration&quot;
* Skapa en loggare med följande konfiguration:
   * **Loggnivå**: Felsökning
   * **Loggfil**: logs/saml.log
   * **Logger**: com.adobe.granite.auth.saml
* Klicka på Spara för att spara inställningarna

#### Testa din OKTA-konfiguration

Logga ut från din AEM. Försök komma åt länken. Du borde se OKTA SSO in action.
