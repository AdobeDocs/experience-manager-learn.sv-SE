---
title: AEM arbetsflöde vid HTML5-formuläröverföring
seo-title: AEM arbetsflödet vid inskickning av HTML5-formulär
description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
seo-description: Fortsätt fylla i mobilformulär i offlineläge och skicka mobilformulär för att aktivera AEM arbetsflöde
feature: mobilformulär
topics: development
audience: developer
doc-type: article
activity: implement
version: 6.4,6.5
translation-type: tm+mt
source-git-commit: b040bdf97df39c45f175288608e965e5f0214703
workflow-type: tm+mt
source-wordcount: '227'
ht-degree: 0%

---


# Ladda ned delvis ifyllda mobilformulär och skicka till AEM arbetsflöde

Ett vanligt användningsexempel är möjligheten att återge XDP som HTML för datainhämtningsaktiviteter. Detta fungerar bra när formulären är enkla och kan fyllas i och skickas online. Om formuläret är komplicerat och användarna kanske inte kan fylla i formuläret online, måste vi ge formuläranvändarna möjlighet att ladda ned interaktiv version av formuläret som ska fyllas i med Acrobat/Reader offline. När formuläret har fyllts i kan användaren vara online för att skicka formuläret.
För att uppnå detta måste vi utföra följande steg:

* Möjlighet att generera interaktiv/ifyllbar PDF med data som anges i mobilformuläret
* Hantera inskickade PDF-filer från Acrobat/Reader
* Starta arbetsflödet i Adobe Experience Manager (AEM) för att granska den inskickade PDF-filen

I den här självstudiekursen går du igenom de steg som krävs för att slutföra användningsfallet ovan. Exempelkod och resurser för den här självstudiekursen är [tillgängliga här.](part-four.md)

I följande video visas en översikt över användningsfallet

>[!VIDEO](https://video.tv.adobe.com/v/29677?quality=9&learn=on)

