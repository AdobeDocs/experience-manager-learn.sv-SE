---
title: E-posttjänst
description: Lär dig hur du konfigurerar AEM as a Cloud Service att ansluta till en e-posttjänst med hjälp av utgångsportar.
version: Experience Manager as a Cloud Service
feature: Security
topic: Development, Security
role: Developer
level: Intermediate
jira: KT-9353
thumbnail: KT-9353.jpeg
exl-id: 5f919d7d-e51a-41e5-90eb-b1f6a9bf77ba
duration: 76
source-git-commit: 8f3e8313804c8e1b8cc43aff4dc68fef7a57ff5c
workflow-type: tm+mt
source-wordcount: '330'
ht-degree: 0%

---

# E-posttjänst

Skicka e-postmeddelanden från AEM as a Cloud Service genom att konfigurera AEM `DefaultMailService` så att den använder avancerade portar för nätverksutgångar.

Eftersom (de flesta) e-posttjänster inte körs via HTTP/HTTPS måste anslutningar till e-posttjänster från AEM as a Cloud Service proxideras.

+ `smtp.host` är inställd på OSGi-miljövariabeln `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` så den dirigeras genom utgången.
   + `$[env:AEM_PROXY_HOST]` är en reserverad variabel som AEM as a Cloud Service mappar till den interna `proxy.tunnel`-värden.
   + Försök INTE att ange `AEM_PROXY_HOST` via Cloud Manager.
+ `smtp.port` är inställd på porten `portForward.portOrig` som mappar till målets e-posttjänst och port. I det här exemplet används mappningen: `AEM_PROXY_HOST:30465` → `smtp.sendgrid.com:465`.
   + `smpt.port` är inställd på porten `portForward.portOrig` och INTE på SMTP-serverns faktiska port. Mappningen mellan `smtp.port` och `portForward.portOrig`-porten upprättas av Cloud Manager `portForwards`-regeln (som visas nedan).

Eftersom hemligheter inte får lagras i kod bör e-posttjänstens användarnamn och lösenord anges med [hemliga OSGi-konfigurationsvariabler](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#secret-configuration-values), som anges med AIO CLI eller Cloud Manager API.

[Flexibel portutgång](../flexible-port-egress.md) används vanligtvis för att underlätta integrering med en e-posttjänst, såvida det inte är nödvändigt att `allowlist` Adobe IP, vilket innebär att [dedikerad IP-adress](../dedicated-egress-ip-address.md) kan användas.

Läs även AEM-dokumentationen om att [skicka e-post](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/development-guidelines.html#sending-email).

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Kontrollera att den [lämpliga](../advanced-networking.md#advanced-networking) avancerade nätverkskonfigurationen har konfigurerats innan du följer den här självstudien.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✔ | ✔ |

## OSGi-konfiguration

I det här OSGi-konfigurationsexemplet konfigureras AEM Mail OSGi-tjänsten till att använda en extern e-posttjänst med hjälp av följande Cloud Manager `portForwards`-regel i åtgärden [&#x200B; enableEnvironmentAdvancedNetworkingConfiguration &#x200B;](https://www.adobe.io/experience-cloud/cloud-manager/reference/api/#operation/enableEnvironmentAdvancedNetworkingConfiguration) .

```json
...
"portForwards": [{
    "name": "smtp.mymail.com",
    "portDest": 465,
    "portOrig": 30465
}]
...
```

+ `ui.config/src/jcr_root/apps/wknd-examples/osgiconfig/config/com.day.cq.mailer.DefaultMailService.cfg.json`

Konfigurera AEM [DefaultMailService](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/development-guidelines.html#sending-email) enligt e-postleverantörens behov (t.ex. `smtp.ssl`).

```json
{
    "smtp.host": "$[env:AEM_PROXY_HOST;default=proxy.tunnel]",
    "smtp.port": "30465",
    "smtp.user": "$[env:EMAIL_USERNAME;default=myApiKey]",
    "smtp.password": "$[secret:EMAIL_PASSWORD]",
    "from.address": "noreply@wknd.site",
    "smtp.ssl": true,
    "smtp.starttls": false, 
    "smtp.requiretls": false,
    "debug.email": false,
    "oauth.flow": false
}
```

Variabeln och hemligheten `EMAIL_USERNAME` och `EMAIL_PASSWORD` OSGi kan anges per miljö, antingen med:

+ [Cloud Manager-miljökonfiguration](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables.html)
+ eller med kommandot `aio CLI`

  ```shell
  $ aio cloudmanager:set-environment-variables --programId=<PROGRAM_ID> <ENVIRONMENT_ID> --secret EMAIL_USERNAME "myApiKey" --secret EMAIL_PASSWORD "password123"
  ```
