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
source-git-commit: 55a6ff5d01898b994aee60f214126c5c18a06a5e
workflow-type: tm+mt
source-wordcount: '158'
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











