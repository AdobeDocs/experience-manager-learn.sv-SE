---
title: Placera nästa och föregående knappar i verktygsfältet
description: Placera knapparna i verktygsfältet
feature: Adaptive Forms
type: Tutorial
version: 6.5
topic: Development
role: Developer
level: Beginner
kt: 9291
source-git-commit: 84a0c78f89f78e161b460574b5927fc4aba2fe3a
workflow-type: tm+mt
source-wordcount: '196'
ht-degree: 0%

---

# Placera verktygsfältsknappen

När du lägger till knapparna Nästa och Föregående i verktygsfältet i AEM Forms placeras knapparna som standard bredvid varandra. Du kanske vill trycka på Nästa-knappen längst till höger i verktygsfältet samtidigt som du håller knappen Föregående/Bakåt till vänster

![verktygsfältsavstånd](assets/toolbar-spacing.png)


## Formatera verktygsfältet

Ovanstående användningssätt kan enkelt uppnås med formateditorn. När du har lagt till knappen Föregående/Nästa i verktygsfältet kontrollerar du att du har markerat stillagret på redigeringsmenyn. Markera formatläget och välj verktygsfältet för att öppna formatmallens egenskapssida. Expandera avsnittet Dimensioner och position och se till att du ser alla egenskaper. Ange följande egenskaper
* Dimensioner och position
   * Bredd: 100 %
   * Position: relativ

Spara ändringarna

## Formatera knappen Nästa

Markera knappen Nästa och se till att du öppnar formatmallarna för nästa knapp (inte nästa knapptext). Ange följande egenskaper
* Dimensioner och position
   * position: absolut övre 1px höger 1px
* Kantlinje
   * Kantradie: 4px(Överkant,Höger,Underkant,Vänster)

Spara ändringarna
