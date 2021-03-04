---
title: Ställ in social bokföring med AEM Experience Fragments
description: Med Experience Fragments kan marknadsförare lägga upp upplevelser som skapats i AEM till plattformar för sociala medier. I videon nedan visas de inställningar och konfigurationer som krävs för att publicera Experience Fragments på Facebook och Pinterest.
sub-product: webbplatser, innehållstjänster
feature: Experience Fragments
topics: integrations, content-delivery
audience: administrator, implementer, developer
doc-type: setup
activity: use
version: 6.3, 6.4, 6.5
topic: Innehållshantering
role: Administratör, utvecklare
level: Mellanliggande
translation-type: tm+mt
source-git-commit: d9714b9a291ec3ee5f3dba9723de72bb120d2149
workflow-type: tm+mt
source-wordcount: '169'
ht-degree: 1%

---


# Konfigurera social bokföring med Experience Fragments {#set-up-social-posting-with-experience-fragments}

Med Experience Fragments kan marknadsförare lägga upp upplevelser som skapats i AEM till plattformar för sociala medier. I videon nedan visas de inställningar och konfigurationer som krävs för att publicera Experience Fragments på Facebook och Pinterest.

>[!VIDEO](https://video.tv.adobe.com/v/20592/?quality=9&learn=on)

*[Experience Fragments]  - konfigurera och konfigurera sociala inlägg på Facebook och Pinterest*

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

