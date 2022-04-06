---
title: Spara och återuppta brev
seo-title: Save and resume letters
description: Lär dig hur du sparar och hämtar utkast
seo-description: Learn how to save and retrieve draft letters
feature: Interactive Communication
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.5
topic: Development
role: Developer
level: Intermediate
kt: 10208
source-git-commit: 0a52ea9f5a475814740bb0701a09f1a6735c6b72
workflow-type: tm+mt
source-wordcount: '132'
ht-degree: 0%

---

# Introduktion

Med interaktiv kommunikation kan agenterna förbereda ad hoc-korrespondenser för att spara delvis ifyllda korrespondenser och hämta samma för att fortsätta arbeta. AEM Forms ger dig [Tjänstleverantörsgränssnitt](https://developer.adobe.com/experience-manager/reference-materials/6-5/forms/javadocs/com/adobe/fd/ccm/ccr/ccrDocumentInstance/api/services/CCRDocumentInstanceService.html). Kunden förväntas implementera det här gränssnittet för att få funktionerna Spara och Återuppta.

I den här artikeln används MySQL-databasen för att lagra metadata för bokstavsinstansen. Bokstaven lagras i filsystemet.

I följande videofilm visas hur du använder gemener/VERSALER:

>[!VIDEO](https://video.tv.adobe.com/v/342129/quality=9)

## Krav

Du behöver följande för att implementera lösningen efter dina behov

* Arbetsupplevelse med AEM Forms
* AEM Server 6.5 med Forms Add on
* Bör vara bekant med att bygga OSGI-paket
