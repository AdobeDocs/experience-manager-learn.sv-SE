---
title: Använda SSL-guiden i AEM
description: Adobe Experience Manager SSL-installationsguide gör det enklare att konfigurera en AEM som körs över HTTPS.
seo-description: Adobe Experience Manager SSL-installationsguide gör det enklare att konfigurera en AEM som körs över HTTPS.
version: 6.3, 6,4, 6.5
feature: null
topics: security, operations
activity: use
audience: administrator
doc-type: technical video
uuid: 82a6962e-3658-427a-bfad-f5d35524f93b
discoiquuid: 9e666741-0f76-43c9-ab79-1ef149884686
translation-type: tm+mt
source-git-commit: 67ca08bf386a217807da3755d46abed225050d02
workflow-type: tm+mt
source-wordcount: '213'
ht-degree: 0%

---


# Använda SSL-guiden i AEM

Adobe Experience Manager SSL-installationsguide gör det enklare att konfigurera en AEM som körs över HTTPS.

>[!VIDEO](https://video.tv.adobe.com/v/17993/?quality=12&learn=on)

>[!NOTE]
>
>I hanterade miljöer är det bäst för IT-avdelningen att tillhandahålla CA-tillförlitliga certifikat och nycklar.
>
>Självsignerade certifikat får endast användas i utvecklingssyfte.

## Privat nyckel och självsignerad certifikatnedladdning

Följande zip innehåller [!DNL DER]- och [!DNL CRT]-filer som krävs för att konfigurera AEM SSL på localhost och som endast är avsedda för lokal utveckling.

Filerna [!DNL DER] och [!DNL CERT] tillhandahålls av praktiska skäl och genereras enligt stegen som beskrivs i avsnittet Generera privat nyckel och Självsignerat certifikat nedan.

Vid behov är certifikatets lösenordsfras **admin**.

localhost - private key och self-signed certificate.zip (upphör i juli 2028)

[Hämta certifikatfilen](assets/use-the-ssl-wizard/certificate.zip)

## Skapa privata nycklar och självsignerade certifikat

I videon ovan visas konfigurationen och konfigurationen av SSL på en AEM författarinstans med självsignerade certifikat. Nedanstående kommandon som använder [[!DNL OpenSSL]](https://www.openssl.org/) kan generera en privat nyckel och ett certifikat som ska användas i steg 2 i guiden.

```shell
### Create Private Key
$ openssl genrsa -aes256 -out localhostprivate.key 4096

### Generate Certificate Signing Request using private key
$ openssl req -sha256 -new -key localhostprivate.key -out localhost.csr -subj '/CN=localhost'

### Generate the SSL certificate and sign with the private key, will expire one year from now
$ openssl x509 -req -days 365 -in localhost.csr -signkey localhostprivate.key -out localhost.crt

### Convert Private Key to DER format - SSL wizard requires key to be in DER format
$ openssl pkcs8 -topk8 -inform PEM -outform DER -in localhostprivate.key -out localhostprivate.der -nocrypt
```
