---
title: E-posttjänst
description: Lär dig hur du konfigurerar AEM as a Cloud Service att ansluta till en e-posttjänst med hjälp av utgångsportar.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
jira: KT-9353
thumbnail: KT-9353.jpeg
exl-id: 5f919d7d-e51a-41e5-90eb-b1f6a9bf77ba
duration: 76
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '334'
ht-degree: 0%

---

# E-posttjänst

Skicka e-post från AEM as a Cloud Service genom att konfigurera AEM `DefaultMailService` för att använda avancerade nätverksportar.

Eftersom (de flesta) e-posttjänster inte körs via HTTP/HTTPS måste anslutningar till e-posttjänster från AEM as a Cloud Service proxideras.

+ `smtp.host` är inställd på OSGi-miljövariabeln `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` så den slussas genom utgången.
   + `$[env:AEM_PROXY_HOST]` är en reserverad variabel som AEM as a Cloud Service mappar till den interna `proxy.tunnel` värd.
   + Försök INTE att ställa in `AEM_PROXY_HOST` via Cloud Manager.
+ `smtp.port` är inställt på `portForward.portOrig` port som mappar till e-posttjänstens målvärd och port. I det här exemplet används mappningen: `AEM_PROXY_HOST:30465` → `smtp.sendgrid.com:465`.
   + The `smpt.port` är inställt på `portForward.portOrig` och INTE SMTP-serverns faktiska port. Mappningen mellan `smtp.port` och `portForward.portOrig` porten har upprättats av Cloud Manager `portForwards` rule (enligt nedan).

Eftersom hemligheter inte får lagras i kod bör e-posttjänstens användarnamn och lösenord anges med [hemlig OSGi-konfigurationsvariabel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#secret-configuration-values), anges med AIO CLI eller Cloud Manager API.

Vanligtvis [flexibel portutgång](../flexible-port-egress.md) används för att underlätta integrering med en e-posttjänst, såvida det inte är nödvändigt att `allowlist` Adobe IP, i vilket fall [IP-adress för dedikerad egress](../dedicated-egress-ip-address.md) kan användas.

Läs även AEM dokumentation om [skicka e-post](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/development-guidelines.html#sending-email).

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

Kontrollera att [lämplig](../advanced-networking.md#advanced-networking) avancerad nätverkskonfiguration har konfigurerats innan du följer den här självstudiekursen.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✔ | ✔ |

## OSGi-konfiguration

I det här OSGi-konfigurationsexemplet konfigureras AEM Mail OSGi-tjänsten att använda en extern e-posttjänst med hjälp av följande Cloud Manager `portForwards` regel för [enableEnvironmentAdvancedNetworkingConfiguration](https://www.adobe.io/experience-cloud/cloud-manager/reference/api/#operation/enableEnvironmentAdvancedNetworkingConfiguration) operation.

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

Konfigurera AEM [DefaultMailService](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/development-guidelines.html#sending-email) som din e-postleverantör kräver (t.ex. `smtp.ssl`, osv.).

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

The `EMAIL_USERNAME` och `EMAIL_PASSWORD` OSGi-variabeln och hemligheten kan anges per miljö med antingen:

+ [Miljökonfiguration för Cloud Manager](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/using-cloud-manager/environment-variables.html)
+ eller med `aio CLI` kommando

  ```shell
  $ aio cloudmanager:set-environment-variables --programId=<PROGRAM_ID> <ENVIRONMENT_ID> --secret EMAIL_USERNAME "myApiKey" --secret EMAIL_PASSWORD "password123"
  ```
