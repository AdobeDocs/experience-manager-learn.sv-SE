---
title: Skicka anpassade formulärbilagor
description: Skicka adaptiva formulärbilagor med skicka-e-postkomponent
feature: Adaptive Forms
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
kt: kt-8049
exl-id: bd9e1fc1-2fc7-452c-9a4a-2e16f6821760
last-substantial-update: 2020-07-07T00:00:00Z
duration: 28
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '136'
ht-degree: 0%

---

# Introduktion



Ett vanligt användningsexempel är att skicka anpassade formulärbilagor med hjälp av skicka e-postkomponent i ett AEM-arbetsflöde.
Kunderna skulle normalt packa de bifogade filerna eller skicka dem som enskilda filer med hjälp av en skicka-e-postkomponent.

## Skicka formulärbilagor i en ZIP-fil

Ett anpassat arbetsflödesprocessteg skrevs för att slutföra användningsfallet. I det här anpassade steget skapar och lagrar en ZIP-fil med formulärbilagor i en fil med namnet *zipped_attachments.zip* under nyttolastmappen

![send-form-attachments](assets/send-form-attachments.JPG)

## Skicka formulärbilagorna individuellt

Ett anpassat arbetsflödesprocesssteg har skrivits för att det här användningsexemplet ska kunna användas. I det här anpassade steget fyller vi i arbetsflödesvariabler av typen ArrayList of Documents and ArrayList of Strings.

![send-list-of-documents](assets/send-list-of-documents.JPG)

## Nästa steg

[Bifogade postformulär](./custom-process-step.md)
