---
title: Skapa strukturen för komponenten countries
description: Skapa komponentstrukturen i crx
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16517
exl-id: 87e790c9-6ef6-4337-90b8-687ca576b21a
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '215'
ht-degree: 1%

---

# Skapa strukturen för komponenten countries

Logga in på din AEM Forms-instans och följ de här stegen för att skapa en ny komponent baserat på den färdiga listrutan:

1. Navigera till /apps//components/adaptiveForm/dropdown i CRXDE Lite.
2. Kopiera den nedrullningsbara komponenten och klistra in den på samma katalognivå.
3. Byt namn på den kopierade komponenten till länder.
4. Uppdatera egenskapen jcr:title för cq:template-noden till countries.
5. Spara ändringarna.

Nu har du en ny komponent som heter countries, som är en exakt kopia av den färdiga listrutan. Detta är grunden för ytterligare anpassning.

## Skapa HTML-filen

Så här skapar du en HTML-fil för komponenten countries:

1. Navigera till mappen countries i crx-databasen
2. Skapa en ny fil med namnet countries.html.
3. Öppna /apps/core/fd/components/form/dropdown/v1/dropdown/dropdown.html i crx-databasen och kopiera dess innehåll.
4. Klistra in det kopierade innehållet i countries.html.
5. Ändra koden så att den använder den nya sling-modellen som visas på skärmbilden
6. Spara ändringarna.

![sling-model](assets/countriesdropdown.png)

Synka slutligen projektet med dessa uppdateringar för att säkerställa att ändringarna i CRX-databasen återspeglas i ditt AEM-projekt.


## Nästa steg

[Skapa cq-dialog](./dialog.md)
