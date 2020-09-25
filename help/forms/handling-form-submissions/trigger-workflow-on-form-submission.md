---
title: AEM arbetsflöde när formulär skickas
description: Konfigurera adaptiv form för att aktivera AEM.
sub-product: formulär
feature: workflow
topics: integrations
audience: developer
doc-type: article
activity: setup
version: 6.4,6.5
kt: 5407
thumbnail: kt-5407.jpg
translation-type: tm+mt
source-git-commit: 738e356c4e72e0c3518bb5fd4ad6a076522e9f5c
workflow-type: tm+mt
source-wordcount: '149'
ht-degree: 0%

---


# Konfigurera anpassat formulär som utlöser AEM

* Ladda ned [adaptiv blankett](assets/time-off-application.zip)
* Bläddra till [formulär och dokument](http://localhost:4502/aem/forms.html/content/dam/formsanddocuments)
* Klicka på Skapa -> Filöverföring. Välj det nedladdade formuläret i steg 1
* Öppna [anpassat formulär i redigeringsläge](http://localhost:4502/editor.html/content/forms/af/timeofapplication.html).
* Öppna innehållsutforskaren
   ![Content Explorer](assets/af-workflow-submission.PNG)
* Markera noden Formulärbehållare och öppna dess konfigurationsegenskaper
   ![Inlämning](assets/af-workflow-submission1.PNG)
* Expandera panelen Skicka
* Ange formulärets Skicka-åtgärd enligt skärmbilden ovan.
   _Observera värdet som anges i fältet Sökväg till datafil. Detta värde måste matcha det värde som du anger i avsnittet i förväg ifyllt i i komponenten Tilldela uppgift i arbetsflödet._

När du fyller i och skickar in det adaptiva formuläret kommer arbetsflödet som är kopplat till att skicka formuläret att aktiveras.
