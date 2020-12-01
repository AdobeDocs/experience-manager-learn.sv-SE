---
title: Använd projektmallar i AEM
description: Project Masters förenklar användar- och teamhanteringen avsevärt med AEM.
version: 6.4, 6.5
feature: projects, users-and-groups
topics: administration, collaboration, performance
activity: use
audience: administrator, implementer, architect
doc-type: article
translation-type: tm+mt
source-git-commit: 22ccd6627a035b37edb180eb4633bc3b57470c0c
workflow-type: tm+mt
source-wordcount: '365'
ht-degree: 0%

---


# Använd projektmallar

Project Masters förenklar användar- och teamhanteringen avsevärt med [!DNL AEM Projects].

>[!VIDEO](https://video.tv.adobe.com/v/17740/?quality=9&learn=on)

Administratörer kan nu skapa en **[!DNL Master Project]** och tilldela användare till roller/behörigheter som en del av ett projektteam. Projekt kan skapas från ett Överordnad projekt och ärver automatiskt teammedlemskapet. Detta ger flera fördelar:

* Återanvänd befintliga team i flera projekt
* Snabbare projektframtagning eftersom team inte behöver återskapas manuellt
* Hantera teammedlemskap från en central plats och uppdateringar av team ärvs automatiskt av projekt
* undviker att skapa dubbletter av ACL:er som kan orsaka prestandaproblem

[!DNL Master Projects] kan skapas under  [!UICONTROL Masters] mappen under  [!UICONTROL AEM Projects]. När en [!DNL Master Project] har skapats visas den som ett alternativ tillsammans med tillgängliga mallar i guiden när nya projekt skapas.

[!DNL Project Masters] URL (lokal AEM Author instance):  [http://localhost:4502/projects.html/content/projects/masters](http://localhost:4502/projects.html/content/projects/masters)

## Ta bort [!DNL Project Masters]

Om du tar bort ett överordnad projekt blir det oanvändbara härledda projekt.

Innan du tar bort ett överordnad projekt måste du se till att alla härledda projekt är avslutade och borttagna från AEM. Spara alla nödvändiga projektdata innan du tar bort de härledda projekten. När alla härledda projekt har tagits bort från AEM kan det överordnad projektet tas bort.

## Markera [!DNL Project Masters] som Inaktiv

Genom att ändra det överordnad projektets status till inaktiv i projektets egenskaper försvinner de inaktiva överordnad projekten från listan med överordnad projekt.

Om du vill visa inaktiva överordnad projekt växlar du filterknappen &quot;visa aktivt&quot; i det övre fältet (bredvid alternativet för visning av lista). Om du vill aktivera det inaktiva projektet igen väljer du bara det inaktiva överordnad projektet, redigerar projektegenskaperna och anger det igen som aktivt.

## Förstå [!DNL Project Masters]

![Projektmallar, teknisk vy](assets/use-project-masters/project-masters-architecture.png)

[!DNL Project Masters] arbeta genom att definiera en uppsättning AEM användargrupper (ägare, redigerare och observatör) och tillåta härledda projekt att referera till och återanvända dessa centralt definierade användargrupper.

Detta minskar det totala antalet användargrupper som krävs i AEM. Före [!DNL Project Masters] skapade varje projekt tre användargrupper med de medföljande ACE:n för att framtvinga behörighetshantering, vilket innebar att 100 projekt genererade 300 användargrupper. Med Project Masters kan alla projekt återanvända samma tre grupper, förutsatt att det delade medlemskapet är anpassat efter företagets behov.
