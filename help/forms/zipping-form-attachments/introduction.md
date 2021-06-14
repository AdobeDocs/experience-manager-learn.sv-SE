---
title: Skicka anpassade formulärbilagor
description: Skicka adaptiva formulärbilagor med skicka-e-postkomponent
feature: anpassningsbara formulär
topics: adaptive forms
audience: developer
doc-type: article
activity: setup
version: 6.5
topic: Utveckling
role: Developer
level: Beginner
kt: kt-8049
source-git-commit: 540e11c0861eacc795122328b2359c7db6378aec
workflow-type: tm+mt
source-wordcount: '135'
ht-degree: 1%

---


# Introduktion



Ett vanligt användningsexempel är att skicka de anpassade formulärbilagorna med skicka e-postkomponenten i ett AEM arbetsflöde.
Kunderna skulle normalt packa de bifogade filerna eller skicka dem som enskilda filer med hjälp av en skicka-e-postkomponent.

## Skicka formulärbilagor i en ZIP-fil

Ett anpassat arbetsflödesprocessteg skrevs för att slutföra användningsfallet. I det här anpassade steget skapas en ZIP-fil med formulärbilagor i och lagras under nyttolastmappen i en fil med namnet *zipped_attachments.zip*

![send-form-attachments](assets/send-form-attachments.JPG)

## Skicka formulärbilagorna individuellt

Ett anpassat arbetsflödesprocesssteg har skrivits för att det här användningsexemplet ska kunna användas. I det här anpassade steget fyller vi i arbetsflödesvariabler av typen ArrayList of Documents and ArrayList of Strings.

![skicka-lista-för-dokument](assets/send-list-of-documents.JPG)



