---
title: Använda formatsystem i AEM Forms
description: Bygg temaprojektet
solution: Experience Manager, Experience Manager Forms
type: Documentation
role: Developer
level: Beginner, Intermediate
version: Cloud Service
topic: Development
feature: Adaptive Forms
badgeVersions: label="AEM Forms as a Cloud Service" before-title="false"
jira: KT-16276
source-git-commit: 86d282b426402c9ad6be84e9db92598d0dc54f85
workflow-type: tm+mt
source-wordcount: '219'
ht-degree: 0%

---


# Testa ändringarna

Skapa ett anpassat formulär baserat på mallen **&quot;Tom med kärnkomponenter&quot;**. Dra och släpp 3 knappar på formuläret och etikettera dem som&quot;Företag&quot;,&quot;Marknadsföring&quot; och&quot;Standard&quot;.
Tilldela passande stilvarianter till knapparna för företag och marknadsföring genom att välja målarpenseln som visas

![format](assets/marketing-variation.png)

## Bygg temaprojektet

Nästa steg är att skapa temaprojektet. Navigera till rotmappen för temaprojektet och kör kommandot _**npm, kör build**_ enligt skärmbilden nedan

![build-theme](assets/build-theme.png)

När temaprojektet har byggts är du redo att testa ändringarna.

## Snabbt och enkelt sätt att testa din CSS

* Öppna filen tema.css under mappen dist i temaprojektet.Markera och kopiera hela filinnehållet.
* Förhandsgranska formuläret som skapades i det tidigare steget.
* Högerklicka på någon av knapparna och välj Inspect för att öppna utvecklarkonsolen.
* Klicka på temat.css i utvecklarkonsolen för att öppna temat.css
* Markera och ta bort hela innehållet i temat.css med hjälp av CTR-A och tryck på knappen Ta bort.
* Kopiera och klistra in innehållet i temat.css som du skapade i det tidigare steget.
* Knapparna bör uppdateras med rätt format enligt nedan.

![final-buttons](assets/final-state-buttons.png)

