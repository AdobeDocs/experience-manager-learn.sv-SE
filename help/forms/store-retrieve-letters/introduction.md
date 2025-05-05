---
title: Spara och återuppta brev
description: Lär dig hur du sparar och hämtar utkast
feature: Interactive Communication
doc-type: article
version: Experience Manager 6.5
topic: Development
role: Developer
level: Intermediate
jira: KT-10208
exl-id: e032070b-7332-4c2f-97ee-7e887a61aa7a
last-substantial-update: 2022-01-07T00:00:00Z
duration: 160
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '119'
ht-degree: 0%

---

# Introduktion

Med interaktiv kommunikation kan agenterna förbereda ad hoc-korrespondenser för att spara delvis ifyllda korrespondenser och hämta samma för att fortsätta arbeta. AEM Forms tillhandahåller [tjänstleverantörsgränssnittet](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/com/adobe/fd/ccm/ccr/ccrDocumentInstance/api/services/CCRDocumentInstanceService.html). Kunden förväntas implementera det här gränssnittet för att få funktionerna Spara och Fortsätt.

I den här artikeln används MySQL-databasen för att lagra metadata för bokstavsinstansen. Bokstaven lagras i filsystemet.

I följande videofilm visas hur du använder gemener/VERSALER:

>[!VIDEO](https://video.tv.adobe.com/v/3441444?quality=12&learn=on&captions=swe)

## Krav

Du behöver följande för att implementera lösningen efter dina behov

* Arbetsupplevelse med AEM Forms
* AEM Server 6.5 med Forms Add on
* Bör vara bekant med att bygga OSGI-paket
