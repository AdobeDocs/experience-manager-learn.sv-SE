---
title: Konfigurera Reader-tillägg i AEM Forms OSGi
description: Lägg till autentiseringsuppgifter för Reader-tillägg i förtroendearkivet i AEM Forms OSGi
feature: Reader Extensions
feature-set: Reader Extensions
topics: development
audience: developer
doc-type: Tutorial
activity: implement
version: 6.4,6.5
topic: Administration
role: Admin
level: Beginner
source-git-commit: 2fc4f748fd3b8f820d1451d08c5fe01d11892029
workflow-type: tm+mt
source-wordcount: '212'
ht-degree: 0%

---


# Lägg till autentiseringsuppgifter för Reader-tillägg{#configuring-reader-extension-osgi}

DocAssurance-tjänsten kan tillämpa användningsrättigheter på PDF-dokument. Konfigurera certifikaten om du vill tillämpa användningsbehörighet för PDF-dokument.

## Skapa nyckelbehållare för användare av fd-service

Autentiseringsuppgifterna för läsartillägg är kopplade till användaren av fd-service. Följ de här stegen för att lägga till autentiseringsuppgifterna för användaren av fd-tjänsten. Om du redan har skapat nyckelbehållaren för användaren av tjänsten hoppar du över det här avsnittet

* Logga in på din AEM Author-instans som administratör
* Gå till Verktyg-Säkerhet-Användare
* Bläddra nedåt i listan över användare tills du hittar användarkontot för tjänsten
* Klicka på användaren av fd-tjänsten
* Klicka på fliken för nyckelbehållaren
* Klicka på Create KeyStore
* Ange lösenordet för KeyStore-åtkomst och spara inställningarna för att skapa KeyStore-lösenordet

### Lägg till autentiseringsuppgifter i nyckelbehållaren för användaren av fd-tjänsten

Följ videon för att lägga till inloggningsuppgifterna till användaren av fd-tjänsten

>[!VIDEO](https://video.tv.adobe.com/v/335849?quality=9&learn=on)


Kommandot som listar information om pfx-filen är. Följande kommando förutsätter att du finns i samma katalog som pfx-filen.

**keytool -v -list -storetype pkcs12 -keystore  &lt;name of=&quot;&quot; your=&quot;&quot;>**

Exempel: keytool -v -list -storetype pkcs12 -keystore 1005566.pfx där 1005566.pfx är namnet på min pfx-fil













