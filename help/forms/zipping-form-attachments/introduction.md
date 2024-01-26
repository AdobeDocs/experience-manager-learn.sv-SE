---
title: Skicka anpassade formulärbilagor
description: Skicka adaptiva formulärbilagor med skicka-e-postkomponent
feature: Adaptive Forms
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-8049
exl-id: bd9e1fc1-2fc7-452c-9a4a-2e16f6821760
last-substantial-update: 2020-07-07T00:00:00Z
duration: 35
source-git-commit: f23c2ab86d42531113690df2e342c65060b5c7cd
workflow-type: tm+mt
source-wordcount: '136'
ht-degree: 0%

---

# Introduktion



Ett vanligt användningsexempel är att skicka de anpassade formulärbilagorna med hjälp av skicka e-postkomponent i ett AEM arbetsflöde.
Kunderna skulle normalt packa de bifogade filerna eller skicka dem som enskilda filer med hjälp av en skicka-e-postkomponent.

## Skicka formulärbilagor i en ZIP-fil

Ett anpassat arbetsflödesprocessteg skrevs för att slutföra användningsfallet. I det här anpassade steget skapas en ZIP-fil med de bifogade formulären och lagras under nyttolastmappen i en fil med namnet *zipped_attachments.zip*

![send-form-attachments](assets/send-form-attachments.JPG)

## Skicka formulärbilagorna individuellt

Ett anpassat arbetsflödesprocesssteg har skrivits för att det här användningsexemplet ska kunna användas. I det här anpassade steget fyller vi i arbetsflödesvariabler av typen ArrayList of Documents and ArrayList of Strings.

![skicka-lista-för-dokument](assets/send-list-of-documents.JPG)

## Nästa steg

[Bifogade postformulär](./custom-process-step.md)
