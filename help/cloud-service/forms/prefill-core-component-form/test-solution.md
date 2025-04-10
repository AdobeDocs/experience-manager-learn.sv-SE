---
title: Komponentbaserad adaptiv blankett för förifyllnad
description: Lär dig förifylla anpassningsbara formulär med data
feature: Adaptive Forms
type: Documentation
role: Developer
level: Beginner
version: Experience Manager as a Cloud Service
topic: Integrations
jira: KT-14675
duration: 23
exl-id: a94deebd-e86e-4360-b0ed-193f13197ee2
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '119'
ht-degree: 0%

---

# Testa lösningen

När koden har distribuerats skapar du ett adaptivt formulär baserat på kärnkomponenterna. Koppla det adaptiva formuläret till förifyllningstjänsten enligt skärmbilden nedan.
![prefill-service](assets/pre-fill-service.png)

Varje gång formuläret återges körs den tillhörande förifyllningstjänsten och formuläret fylls i med de data som returneras av förifyllningstjänsten.

Om du till exempel vill fylla i formuläret i förväg med data som är associerade med GUID **d815a2b3-5f4c-4422-8197-d0b73479bf0e** används följande URL.
Koden i förifyllningstjänsten extraherar värdet på guid-parametern och hämtar data som är associerade med guid från datakällan.

```html
http://localhost:4502/content/dam/formsanddocuments/contactus/jcr:content?wcmmode=disabled&guid=d815a2b3-5f4c-4422-8197-d0b73479bf0e
```
