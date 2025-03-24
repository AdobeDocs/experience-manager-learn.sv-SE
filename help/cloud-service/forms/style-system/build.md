---
title: Använda formatsystem i AEM Forms
description: Bygg temaprojektet
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Experience Manager as a Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16276
exl-id: 4a02f494-ca0e-42d4-bbb9-6223ff8685e3
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '253'
ht-degree: 0%

---

# Testa ändringarna

Skapa ett anpassat formulär baserat på mallen **&quot;Tom med kärnkomponenter&quot;**. Dra och släpp 3 knappar på formuläret och etikettera dem som&quot;Företag&quot;,&quot;Marknadsföring&quot; och&quot;Standard&quot;.
Tilldela lämpliga stilvarianter till knapparna för företag och marknadsföring genom att välja målarpenseln enligt nedan.

![format](assets/marketing-variation.png)

Standardformatet används för den tredje knappen.

## Bygg temaprojektet

Nästa steg är att skapa temaprojektet. Navigera till rotmappen för temaprojektet och kör kommandot _**npm, kör build**_ enligt skärmbilden nedan.

![build-theme](assets/build-theme.png)

När temaprojektet har byggts är du redo att testa ändringarna.

## Snabbt och enkelt sätt att testa din CSS

* Öppna filen tema.css under mappen dist i temaprojektet.Markera och kopiera hela filinnehållet.
* Förhandsgranska formuläret som skapades i det tidigare steget.
* Högerklicka på någon av knapparna och välj Inspektera för att öppna utvecklarkonsolen.
* Klicka på temat.css i utvecklarkonsolen för att öppna temat.css
* Markera och ta bort hela innehållet i temat.css med hjälp av CTR-A och tryck på knappen Ta bort.
* Kopiera och klistra in innehållet i temat.css som du skapade i det tidigare steget.
* Knapparna bör uppdateras med rätt format enligt nedan.

![final-buttons](assets/final-state-buttons.png)

## Skjut ändringarna

Om du är nöjd med ändringarna kan du överföra ändringarna till din molninstans med [front-end-pipeline](https://experienceleague.adobe.com/en/docs/experience-manager-learn/getting-started-wknd-tutorial-develop/enable-frontend-pipeline-devops/create-frontend-pipeline)
