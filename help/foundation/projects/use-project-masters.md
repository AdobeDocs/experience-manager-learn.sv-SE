---
title: Så här använder du Project Masters i AEM
description: Project Masters förenklar användar- och teamhanteringen avsevärt med AEM Projects.
version: Experience Manager 6.4, Experience Manager 6.5, Experience Manager as a Cloud Service
topic: Content Management, Collaboration
feature: Projects
level: Intermediate
role: User
jira: KT-256
thumbnail: 17740.jpg
doc-type: Feature Video
exl-id: 78ff62ad-1017-4a02-80e9-81228f9e01eb
duration: 260
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '358'
ht-degree: 0%

---

# Använd projektmallar

Project Masters förenklar användar- och teamhanteringen avsevärt med [!DNL AEM Projects].

>[!VIDEO](https://video.tv.adobe.com/v/17740?quality=12&learn=on)

Administratörer kan nu skapa en **[!DNL Master Project]** och tilldela användare till roller/behörigheter som en del av ett projektteam. Du kan skapa projekt från ett huvudprojekt och automatiskt ärva teammedlemskapet. Detta ger flera fördelar:

* Återanvänd befintliga team i flera projekt
* Snabbare projektframtagning eftersom team inte behöver återskapas manuellt
* Hantera teammedlemskap från en central plats och uppdateringar av team ärvs automatiskt av projekt
* undviker att skapa dubbletter av ACL:er som kan orsaka prestandaproblem

[!DNL Master Projects] kan skapas under mappen [!UICONTROL Masters] under [!UICONTROL AEM Projects]. När du har skapat ett huvudprojekt visas det som ett alternativ tillsammans med tillgängliga mallar i guiden när nya projekt skapas.

[!DNL Project Masters] URL (lokal instans av AEM Author): [http://localhost:4502/projects.html/content/projects/masters](http://localhost:4502/projects.html/content/projects/masters)

## Ta bort [!DNL Project Masters]

Om du tar bort ett huvudprojekt blir det oanvändbara härledda projekt.

Innan du tar bort ett huvudprojekt måste du se till att alla härledda projekt är avslutade och borttagna från AEM. Spara alla nödvändiga projektdata innan du tar bort de härledda projekten. När alla härledda projekt har tagits bort från AEM kan huvudprojektet tas bort.

## Markera [!DNL Project Masters] som inaktiv

Genom att ändra huvudprojektets status till inaktiv i projektets egenskaper, försvinner de inaktiva huvudprojekten från huvudprojektlistan.

Om du vill visa inaktiva huvudprojekt växlar du till filterknappen &quot;visa aktivt&quot; i det övre fältet (bredvid alternativet för att visa listan). Om du vill göra det inaktiva projektet aktivt igen väljer du bara det inaktiva huvudprojektet, redigerar projektegenskaperna och anger det igen som aktivt.

## Förstå [!DNL Project Masters]

![Projektmallar, teknisk vy](assets/use-project-masters/project-masters-architecture.png)

[!DNL Project Masters] fungerar genom att definiera en uppsättning AEM-användargrupper (ägare, redigerare och observatör) och tillåter härledda projekt att referera till och återanvända dessa centralt definierade användargrupper.

Detta minskar det totala antalet användargrupper som krävs i AEM. Före [!DNL Project Masters] skapade varje projekt tre användargrupper med de medföljande ACE:n för att framtvinga behörighet, vilket innebar att 100 projekt genererade 300 användargrupper. Med Projektmallar kan valfritt antal projekt återanvända samma tre grupper, förutsatt att det delade medlemskapet är anpassat till företagets krav i hela projektet.
