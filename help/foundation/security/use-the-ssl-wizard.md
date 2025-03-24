---
title: Använda SSL-guiden i AEM
description: Adobe Experience Manager SSL-installationsguide gör det enklare att konfigurera en AEM-instans för att köra över HTTPS.
version: Experience Manager 6.5, Experience Manager as a Cloud Service
jira: KT-13839
doc-type: Technical Video
topic: Security
role: Developer
level: Beginner
exl-id: 4e69e115-12a6-4a57-90da-b91e345c6723
last-substantial-update: 2023-08-08T00:00:00Z
duration: 564
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '448'
ht-degree: 0%

---

# Använda SSL-guiden i AEM

Lär dig hur du konfigurerar SSL i Adobe Experience Manager så att det körs över HTTPS med den inbyggda SSL-guiden.

>[!VIDEO](https://video.tv.adobe.com/v/17993?quality=12&learn=on)


>[!NOTE]
>
>I hanterade miljöer är det bäst för IT-avdelningen att tillhandahålla CA-tillförlitliga certifikat och nycklar.
>
>Självsignerade certifikat får endast användas i utvecklingssyfte.

## Använda SSL-konfigurationsguiden

Navigera till __AEM Author > Tools > Security > SSL Configuration__ och öppna __SSL Configuration Wizard__.

![SSL-konfigurationsguiden](assets/use-the-ssl-wizard/ssl-config-wizard.png)

### Skapa autentiseringsuppgifter för butik

Om du vill skapa ett _nyckelarkiv_ som är associerat med `ssl-service`-systemanvändaren och ett globalt _förtroendearkiv_ använder du guidesteget __Lagra autentiseringsuppgifter__.

1. Ange lösenordet och bekräfta lösenordet för __Key Store__ som är associerat med `ssl-service`-systemanvändaren.
1. Ange lösenordet och bekräfta lösenordet för den globala __Trust Store__. Observera att det är ett systemomfattande förtroendearkiv och om det redan har skapats ignoreras det angivna lösenordet.

   ![SSL-inställning - Lagra autentiseringsuppgifter](assets/use-the-ssl-wizard/store-credentials.png)

### Överför privat nyckel och certifikat

Om du vill överföra den _privata nyckeln_ och _SSL-certifikatet_ använder du guidesteget __Nyckel och certifikat__.

Vanligtvis tillhandahåller din IT-avdelning det certifikat och den nyckel som är betrodda av certifikatutfärdaren, men självsignerade certifikat kan användas för __utveckling__- och __testning__-syften.

Mer information om hur du skapar eller hämtar det självsignerade certifikatet finns i den [självsignerade privata nyckeln och certifikatet](#self-signed-private-key-and-certificate).

1. Överför den __privata nyckeln__ i DER-formatet (Distinguished Encoding Rules). Till skillnad från PEM innehåller DER-kodade filer inte vanliga textsatser som `-----BEGIN CERTIFICATE-----`
1. Överför det associerade __SSL-certifikatet__ i formatet `.crt`.

   ![SSL-inställning - privat nyckel och certifikat](assets/use-the-ssl-wizard/privatekey-and-certificate.png)

### Uppdatera SSL-anslutningsinformation

Om du vill uppdatera _värdnamnet_ och _porten_ använder du guidesteget __SSL Connector__.

1. Uppdatera eller verifiera värdet __HTTPS-värdnamn__, det ska matcha värdet `Common Name (CN)` från certifikatet.
1. Uppdatera eller verifiera värdet för __HTTPS-port__.

   ![SSL-installation - SSL-anslutningsinformation](assets/use-the-ssl-wizard/ssl-connector-details.png)

### Verifiera SSL-konfigurationen

1. Verifiera SSL genom att klicka på knappen __Gå till HTTPS-URL__ .
1. Om du använder självsignerat certifikat visas `Your connection is not private`-fel.

   ![SSL-inställningar - Verifiera AEM via HTTPS](assets/use-the-ssl-wizard/verify-aem-over-ssl.png)

## Självsignerad privat nyckel och certifikat

Följande ZIP-fil innehåller [!DNL DER]- och [!DNL CRT]-filer som krävs för att konfigurera AEM SSL lokalt och som endast är avsedda för lokal utveckling.

Filerna [!DNL DER] och [!DNL CERT] tillhandahålls av praktiska skäl och genereras med de steg som beskrivs i avsnittet Generera privat nyckel och Självsignerat certifikat nedan.

Om det behövs är certifikatets lösenordsfras **admin**.

Den här lokala värden - privat nyckel och självsignerat certifikat.zip (upphör att gälla i juli 2028)

[Hämta certifikatfilen](assets/use-the-ssl-wizard/certificate.zip)

### Skapa privata nycklar och självsignerade certifikat

I videon ovan visas konfigurationen och konfigurationen av SSL på en AEM-författarinstans med självsignerade certifikat. Nedanstående kommandon som använder [[!DNL OpenSSL]](https://www.openssl.org/) kan generera en privat nyckel och ett certifikat som ska användas i steg 2 i guiden.

```shell
### Create Private Key
$ openssl genrsa -aes256 -out localhostprivate.key 4096

### Generate Certificate Signing Request using private key
$ openssl req -sha256 -new -key localhostprivate.key -out localhost.csr -subj '/CN=localhost'

### Generate the SSL certificate and sign with the private key, will expire one year from now
$ openssl x509 -req -extfile <(printf "subjectAltName=DNS:localhost") -days 365 -in localhost.csr -signkey localhostprivate.key -out localhost.crt

### Convert Private Key to DER format - SSL wizard requires key to be in DER format
$ openssl pkcs8 -topk8 -inform PEM -outform DER -in localhostprivate.key -out localhostprivate.der -nocrypt
```
