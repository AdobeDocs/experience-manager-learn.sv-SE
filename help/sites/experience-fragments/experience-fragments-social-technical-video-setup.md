---
title: Ställ in social bokföring med AEM Experience Fragments
description: Med Experience Fragments kan marknadsförare lägga upp upplevelser som skapats i AEM till plattformar för sociala medier. I videon nedan visas de inställningar och konfigurationer som krävs för att publicera Experience Fragments på Facebook och Pinterest.
sub-product: webbplatser, innehållstjänster
feature: experience-fragments
topics: integrations, content-delivery
audience: administrator, implementer, developer
doc-type: setup
activity: use
version: 6.3, 6.4, 6.5
translation-type: tm+mt
source-git-commit: 22ccd6627a035b37edb180eb4633bc3b57470c0c
workflow-type: tm+mt
source-wordcount: '162'
ht-degree: 0%

---


# Konfigurera social bokföring med Experience Fragments {#set-up-social-posting-with-experience-fragments}

Med Experience Fragments kan marknadsförare lägga upp upplevelser som skapats i AEM till plattformar för sociala medier. I videon nedan visas de inställningar och konfigurationer som krävs för att publicera Experience Fragments på Facebook och Pinterest.

>[!VIDEO](https://video.tv.adobe.com/v/20592/?quality=9&learn=on)
*[Experience Fragments]- konfigurera och konfigurera för sociala inlägg på Facebook och Pinterest*

## Checklista för konfiguration av Experience Fragments som ska publiceras på Facebook och Pinterest

1. AEM Author Instance körs på HTTPS
2. Facebook-konto + Facebook Developer App
3. Pinterest-konto + Pinterest Developer App
4. [!UICONTROL AEM Cloud Services] Konfiguration - Facebook
5. [!UICONTROL AEM Cloud Services] Konfiguration - Pinterest
6. AEM Experience Fragment med Cloud Services för Facebook + Pinterest
7. Upplev fragmentvariationer med Facebook-mall
8. Upplev fragmentvariationer med Pinterest-mall

## Omdirigerings-URI för Experience Fragment

Denna URI används för Facebook- och Pinterest-appar som en del av Oauth-flödet.

```plain
 /* replace localhost:8443 with your aem host info */

 https://localhost:8443/libs/cq/experience-fragments/components/redirect
```

