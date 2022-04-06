---
title: E-posttjänst
description: Lär dig hur du konfigurerar AEM as a Cloud Service att ansluta till en e-posttjänst med hjälp av utgångsportar.
version: Cloud Service
feature: Security
topic: Development, Security
role: Architect, Developer
level: Intermediate
kt: 9353
thumbnail: KT-9353.jpeg
exl-id: 5f919d7d-e51a-41e5-90eb-b1f6a9bf77ba
source-git-commit: 4d3256cee67183803692cccc7f17ca1a0820e05d
workflow-type: tm+mt
source-wordcount: '268'
ht-degree: 0%

---

# E-posttjänst

Skicka e-post från AEM as a Cloud Service genom att konfigurera AEM `DefaultMailService` för att använda avancerade nätverksportar.

Eftersom (de flesta) e-posttjänster inte körs via HTTP/HTTPS måste anslutningar till e-posttjänster från AEM as a Cloud Service proxideras.

+ `smtp.host` är inställd på OSGi-miljövariabeln `$[env:AEM_PROXY_HOST;default=proxy.tunnel]` så den slussas genom utgången.
+ `smtp.port` är inställt på `portForward.portOrig` port som mappar till e-posttjänstens målvärd och port. I det här exemplet används mappningen: `AEM_PROXY_HOST:30002` → `smtp.sendgrid.com:465`.

Eftersom hemligheter inte får lagras i kod bör e-posttjänstens användarnamn och lösenord anges med [hemlig OSGi-konfigurationsvariabel](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/implementing/deploying/configuring-osgi.html#secret-configuration-values), anges med AIO CLI eller Cloud Manager API.

Vanligtvis [flexibel portutgång](../flexible-port-egress.md) används för att underlätta integrering med en e-posttjänst, såvida det inte är nödvändigt att `allowlist` IP-adressen Adobe, i vilket fall [IP-adress för dedikerad egress](../dedicated-egress-ip-address.md) kan användas.

## Avancerat nätverksstöd

Följande kodexempel stöds av följande avancerade nätverksalternativ.

| Inga avancerade nätverk | [Flexibel portutgång](../flexible-port-egress.md) | [Dedikerad IP-adress för utgångar](../dedicated-egress-ip-address.md) | [Virtuellt privat nätverk](../vpn.md) |
|:-----:|:-----:|:------:|:---------:|
| ✘ | ✔ | ✔ | ✔ |

## OSGi-konfiguration

I det här OSGi-konfigurationsexemplet konfigureras AEM Mail OSGi-tjänsten att använda en extern e-posttjänst med hjälp av följande Cloud Manager `portForwards` regel för [enableEnvironmentAdvancedNetworkingConfiguration](https://www.adobe.io/experience-cloud/cloud-manager/reference/api/#operation/enableEnvironmentAdvancedNetworkingConfiguration) operation.

```json
...
"portForwards": [{
    "name": "smtp.sendgrid.com",
    "portDest": 465,
    "portOrig": 30002
}]
...
```

+ `ui.config/src/jcr_root/apps/wknd-examples/osgiconfig/config/com.day.cq.mailer.DefaultMailService.cfg.json`

Konfigurera AEM [DefaultMailService](https://experienceleague.adobe.com/docs/experience-manager-cloud-service/content/implementing/developing/development-guidelines.html#sending-email) som din e-postleverantör kräver (t.ex. `smtp.ssl`, osv.).

```json
{
    "smtp.host": "$[env:AEM_PROXY_HOST;default=proxy.tunnel]",
    "smtp.port": "30002",
    "smtp.user": "$[env:EMAIL_USERNAME;default=emailapikey]",
    "smtp.password": "$[secret:EMAIL_PASSWORD]",
    "from.address": "noreply@wknd.site",
    "smtp.ssl": true,
    "smtp.starttls": false, 
    "smtp.requiretls": false,
    "debug.email": false,
    "oauth.flow": false
}
```

Följande `aio CLI` kommandot kan användas för att ange OSGi-hemligheter per miljö:

```shell
$ aio cloudmanager:set-environment-variables --programId=<PROGRAM_ID> <ENVIRONMENT_ID> --secret EMAIL_USERNAME "apikey" --secret EMAIL_PASSWORD "password123"
```
