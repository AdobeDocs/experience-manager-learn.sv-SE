---
title: Anpassa komponenten Sammanfattning
description: Utöka komponenten för sammanfattningssteg så att den kan navigera till nästa formulär i paketet.
feature: Adaptive Forms
version: 6.4,6.5
kt: 6894
thumbnail: 6894.jpg
topic: Development
role: Developer
level: Experienced
exl-id: fb68579d-241c-414d-92f4-13194f4d1923
source-git-commit: 48d9ddb870c0e4cd001ae49a3f0e9c547407c1e8
workflow-type: tm+mt
source-wordcount: '185'
ht-degree: 0%

---

# Anpassa sammanfattningssteg

Sammanfattningsstegskomponenten används för att visa sammanfattningen av formulärinlämningen med en länk för att hämta det signerade formuläret. Sammanfattningssteget placeras vanligtvis på den sista panelen i formuläret.
I det här exemplet har vi skapat en ny komponent som baseras på den färdiga delen av Sammanfattning och utökat möjligheten att inkludera anpassade clientlib.

Den här komponenten identifieras av etiketten Signera flera formulär

I följande skärmbild visas den nya komponenten som skapades för att visa meddelandet när signeringsceremonin slutfördes

![sammanfattningskomponent](assets/summary.PNG)

Den nya komponenten är baserad på komponenten out of the box summary.
![component-prop](assets/componentprop.PNG)

Vi har lagt till en knapp för att navigera till nästa formulär för signering
![template-code](assets/template-code.PNG)

Summary.jsp har följande kod. Den har en referens till klientbiblioteket som identifieras av kategori-ID **getnextform**

```java
<%--
  Guide Summary Component
--%>
<%@include file="/libs/fd/af/components/guidesglobal.jsp"%>
<%@include file="/libs/fd/afaddon/components/summary/summary.jsp"%>
<ui:includeClientLib categories="getnextform"/>
```

## Assets

Den anpassade sammanfattningskomponenten kan [hämtad härifrån](assets/custom-summary-step.zip)

## Nästa steg

[Hämta nästa formulär för signering](./create-client-lib.md)