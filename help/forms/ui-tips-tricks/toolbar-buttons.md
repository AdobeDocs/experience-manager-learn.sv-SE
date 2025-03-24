---
title: Placera nästa och föregående knappar i verktygsfältet
description: Placera knapparna i verktygsfältet
feature: Adaptive Forms
type: Tutorial
version: Experience Manager 6.5
topic: Development
role: Developer
level: Beginner
jira: KT-9291
exl-id: 1b55b6d2-3bab-4907-af89-c81a3b1a44cb
last-substantial-update: 2019-07-07T00:00:00Z
duration: 39
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '194'
ht-degree: 0%

---

# Placera verktygsfältsknappen

När du lägger till knapparna Nästa och Föregående i verktygsfältet i AEM Forms placeras knapparna som standard bredvid varandra. Du kanske vill trycka på Nästa-knappen längst till höger i verktygsfältet samtidigt som du håller knappen Föregående/Bakåt till vänster

![verktygsfält-spacing](assets/toolbar-spacing.png)


## Formatera verktygsfältet

Ovanstående användningssätt kan enkelt uppnås med formateditorn. När du har lagt till knappen Föregående/Nästa i verktygsfältet kontrollerar du att du har markerat stillagret på redigeringsmenyn. Markera formatläget och välj verktygsfältet för att öppna formatmallens egenskaper. Expandera avsnittet Dimensioner och position och se till att du ser alla egenskaper. Ange följande egenskaper
* Mått och position
   * Bredd: 100 %
   * Position: relativ

Spara ändringarna

## Formatera knappen Nästa

Markera knappen Nästa och se till att du öppnar formatmallarna för nästa knapp (inte nästa knapptext). Ange följande egenskaper
* Mått och position
   * position: absolut övre 1px höger 1px
* Kant
   * Kantradie: 4px(Överkant,Höger,Underkant,Vänster)

Spara ändringarna
