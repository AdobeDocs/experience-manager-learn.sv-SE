---
title: Utlösa AEM-arbetsflöde vid inskickning av PDF-formulär
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att starta AEM arbetsflöde
feature: Mobile Forms
doc-type: article
version: Experience Manager 6.4, Experience Manager 6.5
topic: Development
role: Developer
level: Experienced
exl-id: 88295af5-3022-4462-9194-46d8c979bc8b
last-substantial-update: 2021-04-07T00:00:00Z
jira: kt-16133
badgeVersions: label="AEM Forms 6.5" before-title="false"
duration: 342
source-git-commit: 03b68057748892c757e0b5315d3a41d0a2e4fc79
workflow-type: tm+mt
source-wordcount: '214'
ht-degree: 0%

---

# Ladda ned delvis ifyllda mobilformulär och skicka in för att starta ett AEM-arbetsflöde

Ett vanligt användningsexempel är möjligheten att återge XDP som HTML för datainhämtningsaktiviteter. Detta fungerar bra när formulären är enkla och kan fyllas i och skickas online. Om formuläret är komplicerat och användarna kanske inte kan fylla i formuläret online, måste vi ge formuläranvändarna möjlighet att ladda ned interaktiv version av formuläret som ska fyllas i med Acrobat/Reader offline. När formuläret har fyllts i kan användaren vara online för att skicka formuläret.
För att uppnå detta måste vi utföra följande steg:

* Möjlighet att generera interaktiva/ifyllbara PDF med data som anges i mobilformuläret
* Hantera inlämningen från Acrobat/Reader från PDF
* Starta arbetsflödet i Adobe Experience Manager (AEM) för att granska det inskickade PDF

I den här självstudiekursen går du igenom de steg som krävs för att slutföra användningsfallet ovan. Exempelkod och resurser för den här självstudiekursen är [tillgängliga här.](./deploy-assets.md)

I följande video visas en översikt över användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/29677?quality=12&learn=on)

## Nästa steg

[Skapa anpassad profil](./custom-profile.md)