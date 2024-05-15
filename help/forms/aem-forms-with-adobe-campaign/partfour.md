---
title: Skapa kampanjprofil med hjälp av formulärdatamodell
description: Steg som används för att skapa Adobe Campaign Standard-profil med AEM Forms Form Data Model
feature: Adaptive Forms
version: 6.4,6.5
topic: Integrations, Development
role: Developer
level: Experienced
badgeIntegration: label="Integrering" type="positive"
badgeVersions: label="AEM Forms 6.5" before-title="false"
exl-id: 59d5ba6d-91c1-48c7-8c87-8e0caf4f2d7e
duration: 110
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '431'
ht-degree: 0%

---

# Skapa kampanjprofil med hjälp av formulärdatamodell {#create-campaign-profile-using-form-data-model}

Steg som används för att skapa Adobe Campaign Standard-profil med AEM Forms Form Data Model

## Skapa anpassad autentisering {#create-custom-authentication}

När du skapar en datakälla med swagger-filen har AEM Forms stöd för följande typer av autentisering

* Ingen
* OAuth 2.0
* Grundläggande autentisering
* API-nyckel
* Anpassad autentisering

![campaingfdm](assets/campaignfdm.gif)

Vi måste använda anpassad autentisering för att göra REST-anrop till Adobe Campaign Standard.

För att kunna använda anpassad autentisering måste vi utveckla en OSGi-komponent som implementerar IAuthentication-gränssnittet

Metoden getAuthDetails måste implementeras. Den här metoden returnerar AuthenticationDetails-objektet. Det här AuthenticationDetails-objektet har de HTTP-huvuden som krävs för att REST API-anropa Adobe Campaign.

Följande kod användes för att skapa anpassad autentisering. Metoden getAuthDetails utför allt arbete. Vi skapar AuthenticationDetails-objektet. Sedan lägger vi till lämpliga HttpHeaders till det här objektet och returnerar det här objektet.

```java
package aemfd.campaign.core;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.adobe.aemfd.dermis.authentication.api.IAuthentication;
import com.adobe.aemfd.dermis.authentication.exception.AuthenticationException;
import com.adobe.aemfd.dermis.authentication.model.AuthenticationDetails;
import com.adobe.aemfd.dermis.authentication.model.Configuration;

import aemforms.campaign.core.CampaignService;
import formsandcampaign.demo.CampaignConfigurationService;
@Component(service=IAuthentication.class,immediate=true)

public class CampaignAuthentication implements IAuthentication {
 @Reference
 CampaignService campaignService;
  @Reference
     CampaignConfigurationService config;
private Logger log = LoggerFactory.getLogger(CampaignAuthentication.class);
 @Override
 public AuthenticationDetails getAuthDetails(Configuration arg0) throws AuthenticationException {
 try {
   AuthenticationDetails auth = new AuthenticationDetails();
   auth.addHttpHeader("Cache-Control", "no-cache");
   auth.addHttpHeader("Content-Type", "application/json");
   auth.addHttpHeader("X-Api-Key",config.getApiKey() );
         auth.addHttpHeader("Authorization", "Bearer "+campaignService.getAccessToken());
         log.debug("Returning auth");
         return auth;
   
  } catch (NoSuchAlgorithmException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  } catch (InvalidKeySpecException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  } catch (IOException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
  }
  return null;
  
 }

 @Override
 public String getAuthenticationType() {
  // TODO Auto-generated method stub
  return "Campaign Custom Authentication";
 }

}
```

## Skapa datakälla {#create-data-source}

Det första steget är att skapa swagger-filen. Swagger-filen definierar REST API som ska användas för att skapa en profil i Adobe Campaign Standard. Swagger-filen definierar indataparametrarna och utdataparametrarna för REST API.

En datakälla skapas med swagger-filen. När du skapar en datakälla kan du ange autentiseringstypen. I det här fallet ska vi använda anpassad autentisering för att autentisera mot Adobe Campaign. Koden som anges ovan användes för att autentisera mot Adobe Campaign.

Du får en exempelfil som en del av resursens relaterade artikel.**Kontrollera att du ändrar host och basePath i swagger-filen så att den matchar ACS-instansen**

## Testa lösningen {#test-the-solution}

Följ följande steg för att testa lösningen:
* [Kontrollera att du har följt de steg som beskrivs här](aem-forms-with-campaign-standard-getting-started-tutorial.md)
* [Hämta och zippa upp den här filen för att hämta swagger-filen](assets/create-acs-profile-swagger-file.zip)
* Skapa datakälla med swagger-filen Skapa formulärdatamodell och basera den på datakällan som skapades i föregående steg
* Skapa ett anpassat formulär baserat på den formulärdatamodell som skapades i det tidigare steget.
* Dra och släpp följande element från fliken Datakällor till det adaptiva formuläret

   * E-post
   * Förnamn
   * Efternamn
   * Mobiltelefon

* Konfigurera skicka-åtgärden till&quot;Skicka med formulärdatamodell&quot;.
* Konfigurera datamodellen så att den skickas korrekt.
* Förhandsgranska formuläret. Fyll i fälten och skicka.
* Kontrollera att profilen har skapats i Adobe Campaign Standard.
