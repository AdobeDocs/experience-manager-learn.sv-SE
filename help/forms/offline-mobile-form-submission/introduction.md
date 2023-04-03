---
title: AEM arbetsflöde vid introduktion av HTML5-formulärskickning
seo-title: Trigger AEM Workflow on HTML5 Form Submission
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
seo-description: Continue filling mobile form in offline mode and submit mobile form to trigger AEM workflow
feature: Mobile Forms
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
topic: Development
role: Developer
level: Experienced
exl-id: 88295af5-3022-4462-9194-46d8c979bc8b
last-substantial-update: 2021-04-07T00:00:00Z
source-git-commit: b3e9251bdb18a008be95c1fa9e5c79252a74fc98
workflow-type: tm+mt
source-wordcount: '205'
ht-degree: 0%

---

# Ladda ned delvis ifyllda mobilformulär och skicka till AEM arbetsflöde

Ett vanligt användningsexempel är möjligheten att återge XDP som HTML för datainhämtningsaktiviteter. Detta fungerar bra när formulären är enkla och kan fyllas i och skickas online. Om formuläret är komplicerat och användarna kanske inte kan fylla i formuläret online, måste vi ge formuläranvändarna möjlighet att ladda ned interaktiv version av formuläret som ska fyllas i med Acrobat/Reader offline. När formuläret har fyllts i kan användaren vara online för att skicka formuläret.
För att uppnå detta måste vi utföra följande steg:

* Möjlighet att generera interaktivt/ifyllbart PDF med data som anges i mobilformuläret
* Hantera PDF inlämningen från Acrobat/Reader
* Utlösa arbetsflödet för Adobe Experience Manager (AEM) för att granska det inskickade PDF

I den här självstudiekursen går du igenom de steg som krävs för att slutföra användningsfallet ovan. Exempelkod och resurser för den här självstudiekursen är [finns här.](part-four.md)

I följande video visas en översikt över användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/29677?quality=12&learn=on)
