---
title: Konfigurera Reader-tillägg i AEM Forms OSGi
description: Lägg till autentiseringsuppgifter för Reader Extensions i förtroendearkivet i AEM Forms OSGi
feature: Reader Extensions
type: Tutorial
version: 6.4,6.5
topic: Administration
role: Admin
level: Beginner
exl-id: 1f16acfd-e8fd-4b0d-85c4-ed860def6d02
last-substantial-update: 2020-08-01T00:00:00Z
duration: 308
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '209'
ht-degree: 0%

---

# Lägg till autentiseringsuppgifter för Reader-tillägg{#configuring-reader-extension-osgi}

DocAssurance-tjänsten kan tillämpa användarrättigheter på PDF-dokument. Konfigurera certifikaten om du vill tillämpa användarrättigheter på PDF-dokument.

## Skapa nyckelbehållare för användare av fd-service

Autentiseringsuppgifterna för läsartillägg är kopplade till användaren av fd-service. Följ de här stegen för att lägga till autentiseringsuppgifterna för användaren av fd-tjänsten. Om du redan har skapat nyckelbehållaren för användaren av tjänsten hoppar du över det här avsnittet

* Logga in på AEM Author-instansen som administratör
* Gå till Verktyg-Säkerhet-Användare
* Bläddra nedåt i listan över användare tills du hittar användarkontot för tjänsten
* Klicka på användaren av fd-tjänsten
* Klicka på fliken för nyckelbehållaren
* Klicka på Create KeyStore
* Ange lösenordet för KeyStore-åtkomst och spara inställningarna för att skapa KeyStore-lösenordet

### Lägg till autentiseringsuppgifter i nyckelbehållaren för användaren av fd-tjänsten

Följ videon för att lägga till inloggningsuppgifterna till användaren av fd-tjänsten

>[!VIDEO](https://video.tv.adobe.com/v/335849?quality=12&learn=on)


Kommandot som listar information om pfx-filen är. Följande kommando förutsätter att du finns i samma katalog som pfx-filen.

**keytool -v -list -storetype pkcs12 -keystore &lt;namn på pfx-filen>**

Exempel: keytool -v -list -storetype pkcs12 -keystore 1005566.pfx där 1005566.pfx är namnet på min pfx-fil
