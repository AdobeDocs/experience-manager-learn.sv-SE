---
title: Använda CAPTCHA med AEM Adaptive Forms
description: Lägga till och använda en CAPTCHA med AEM Adaptive Forms.
feature: Adaptiv Forms, arbetsflöde
version: 6.4,6.5
topic: Utveckling
role: Developer
level: Intermediate
source-git-commit: 462417d384c4aa5d99110f1b8dadd165ea9b2a49
workflow-type: tm+mt
source-wordcount: '232'
ht-degree: 0%

---


# Använda CAPTCHA med AEM Adaptive Forms{#using-captchas-with-aem-adaptive-forms}

Lägga till och använda en CAPTCHA med AEM Adaptive Forms.

På sidan [AEM Forms samples](https://forms.enablementadobe.com/content/samples/samples.html?query=0#collapse1) finns en länk till en live-demo av den här funktionen.

>[!VIDEO](https://video.tv.adobe.com/v/18336/?quality=9&learn=on)

*I den här videon går vi igenom processen att lägga till en CAPTCHA i ett AEM adaptivt formulär med både den inbyggda AEM CAPTCHA-tjänsten och Googles reCAPTCHA-tjänst.*

>[!NOTE]
>
>Den här funktionen är endast tillgänglig med AEM 6.3 och senare.

>[!NOTE]
>
>**Följ stegen för att konfigurera reCaptcha för publiceringsinstansen**
>
>Konfigurera reCaptach för författarinstans
>
>öppna Felix [webbkonsolen](http://localhost:4502/system/console/bundles) på författarinstansen
>
>sök efter com.adobe.granite.crypto.file bundle
>
>Observera paket-ID:t. I min instans är den 20
>
>Navigera till paket-ID:t i filsystemet på författarinstansen
>
>* &lt;author-aem-install-dir>/crx-quickstart/launchpad/felix/bundle20/data
* Kopiera HMAC-filer och överordnad filer

Öppna webbkonsolen [felix](http://localhost:4502/system/console/bundles) på din publiceringsinstans. Sök efter paketet com.adobe.granite.crypto.file. Observera paket-ID
Navigera till paket-ID:t i filsystemet för din publiceringsinstans
* &lt;publish-aem-install-dir>/crx-quickstart/launchpad/felix/bundle20/data
* ta bort befintliga HMAC- och överordnad filer.
* klistra in HMAC-filer och överordnad filer som kopierats från författarinstansen

Starta om AEM publiceringsserver

## Stödmaterial {#supporting-materials}

* [Google reCAPTCHA](https://www.google.com/recaptcha)

