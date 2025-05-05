---
title: Använda CAPTCHA:er med AEM Adaptive Forms
description: Lägga till och använda en CAPTCHA med AEM Adaptive Forms.
feature: Adaptive Forms,Workflow
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
exl-id: 7e5dcc6e-fe56-49af-97e3-7dfaa9c8738f
last-substantial-update: 2019-06-09T00:00:00Z
duration: 260
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '196'
ht-degree: 0%

---

# Använda CAPTCHA:er med AEM Adaptive Forms{#using-captchas-with-aem-adaptive-forms}

Lägga till och använda en CAPTCHA med AEM Adaptive Forms.

>[!VIDEO](https://video.tv.adobe.com/v/18336?quality=12&learn=on)

*I den här videon går vi igenom hur du lägger till en CAPTCHA i ett AEM Adaptive Form med både den inbyggda tjänsten AEM CAPTCHA och Google reCAPTCHA.*

>[!NOTE]
>
>Den här funktionen är endast tillgänglig med AEM 6.3 eller senare.

>[!NOTE]
>
>**Följ stegen** för att konfigurera reCaptcha för publiceringsinstansen.
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
>* Kopiera HMAC- och mallfiler
>
>Öppna [felix-webbkonsolen](http://localhost:4502/system/console/bundles) på din publiceringsinstans. Sök efter paketet com.adobe.granite.crypto.file. Observera paket-ID
>
>Navigera till paket-ID:t i filsystemet för din publiceringsinstans
>
>* &lt;publish-aem-install-dir>/crx-quickstart/launchpad/felix/bundle20/data
>* ta bort befintliga HMAC- och mallfiler.
>* klistra in HMAC- och mallfiler som kopierats från författarinstansen
>
>Starta om AEM publiceringsserver

## Stödmaterial {#supporting-materials}

* [Google reCAPTCHA](https://www.google.com/recaptcha)
