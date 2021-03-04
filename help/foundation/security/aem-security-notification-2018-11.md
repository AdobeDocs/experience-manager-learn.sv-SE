---
title: AEM säkerhetsmeddelande (november 2018)
seo-title: AEM säkerhetsmeddelande (november 2018)
description: AEM Experience Manager Security Notification Dispatcher
seo-description: AEM Experience Manager Security Notification Dispatcher
version: 6.4
feature: avsändare
topics: security
activity: understand
audience: all
doc-type: article
uuid: 3ccf7323-4061-49d7-ae95-eb003099fd77
discoiquuid: 9d181b3e-fbd5-476d-9e97-4452176e495c
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '439'
ht-degree: 0%

---


# AEM säkerhetsmeddelande (november 2018)

## Sammanfattning

I den här artikeln behandlas några av de senaste och gamla säkerhetsluckorna som nyligen har rapporterats i AEM. Observera att de flesta identifierade säkerhetsluckorna var kända problem för den AEM produkten och att en begränsning tidigare har identifierats. Det finns en ny dispatcherversion för de nya säkerhetsluckorna. Adobe uppmanar också sina kunder att fylla i [AEM Security Checklist](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-checklist.html) och följa riktlinjerna.

## Åtgärd krävs

* AEM ska börja använda den senaste Dispatcher-versionen.
* Distribuerarens säkerhetsregler måste tillämpas enligt den rekommenderade konfigurationen.
* [AEM Security Checklist](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-checklist.html) ska fyllas i för AEM distributioner.

## Sårbarheter och lösningar

| Problem | Upplösning | Länkar |
|-------|------------|-------|
| Åsidosätta AEM Dispatcher-regler | Installera den senaste versionen av Dispatcher (4.3.1) och följ den rekommenderade dispatcherkonfigurationen. | Se [AEM Dispatcher Release Notes](https://helpx.adobe.com/experience-manager/dispatcher/release-notes.html) och [Konfigurera Dispatcher](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html). |
| URL-filteråsidosättningsfel som kan användas för att kringgå dispatcherregler - CVE-2016-0957 | Detta har korrigerats i en äldre version av Dispatcher, men nu rekommenderas att du installerar den senaste versionen av Dispatcher (4.3.1) och följer den rekommenderade Dispatcher-konfigurationen. | Se [AEM Dispatcher Release Notes](https://helpx.adobe.com/experience-manager/dispatcher/release-notes.html) och [Konfigurera Dispatcher](https://helpx.adobe.com/experience-manager/dispatcher/using/dispatcher-configuration.html). |
| XSS-sårbarhet relaterad till lagrade SWF-filer | Detta har åtgärdats med säkerhetskorrigeringar som släppts tidigare. | Se [AEM Säkerhetsbulletin APSB18-10](https://helpx.adobe.com/security/products/experience-manager/apsb18-10.html). |
| Lösenordsrelaterade explosioner | Följ rekommendationen i checklistan för säkerhet om du vill ha starkare lösenord. | Se [AEM Säkerhetschecklista](https://helpx.adobe.com/experience-manager/6-5/sites/administering/using/security-checklist.html) |
| Diskanvändningsexponering för anonyma användare | Problemet har åtgärdats för AEM 6.1 och senare, för AEM 6.0 kan behörigheterna som anges som ej ifyllda ändras till mer restriktiva. | Se [versionsinformation](https://helpx.adobe.com/experience-manager/aem-previous-versions.html)för AEM 6.1 och äldre. |
| Exponering av Open Social Proxy för anonyma användare | Detta har lösts i versioner från och med 6.0 SP2. | Se [versionsinformation](https://helpx.adobe.com/experience-manager/aem-previous-versions.html) för AEM 6.1 och äldre. |
| CRX Explorer Access på produktionsinstanser | Åtkomsten till CRX Explorer hanteras redan i checklistan, CRX Explorer ska tas bort från författaren och publiceras och säkerhetshälsokontrollen rapporterar om den inte tas bort. | Se [AEM Säkerhetschecklista](https://helpx.adobe.com/experience-manager/6-4/sites/administering/using/security-checklist.html). |
| BGServlets är exponerade | Detta har lösts sedan AEM 6.2. | Se [AEM 6.2 Versionsinformation](https://helpx.adobe.com/experience-manager/6-2/release-notes.html) |

>[!MORELIKETHIS]
>
>* [Användarhandbok för AEM Dispatcher](https://helpx.adobe.com/experience-manager/dispatcher/user-guide.html)
>* [AEM Dispatcher Release Notes](https://helpx.adobe.com/experience-manager/dispatcher/release-notes.html)
>* [AEM säkerhetsbulletiner](https://helpx.adobe.com/security.html#experience-manager)

