---
title: Konfigurera konton och tjänster för utbyggbarhet för Asset compute
description: För att kunna utveckla Asset compute-arbetare måste du ha tillgång till konton och tjänster, inklusive AEM som Cloud Service, Adobe Project Fire och molnlagring från Microsoft eller Amazon.
feature: Asset Compute Microservices
topics: renditions, development
version: Cloud Service
activity: develop
audience: developer
doc-type: tutorial
kt: 6264
thumbnail: 40377.jpg
topic: Integrations, Development
role: Developer
level: Intermediate, Experienced
exl-id: 707657ad-221e-4dab-ac2a-46a4fcbc55bc
source-git-commit: ad203d7a34f5eff7de4768131c9b4ebae261da93
workflow-type: tm+mt
source-wordcount: '627'
ht-degree: 1%

---

# Ställ in konton och tjänster

Den här självstudiekursen kräver att följande tjänster är provisioneringstjänster och tillgängliga via elevens Adobe ID.

Alla Adobe-tjänster måste vara tillgängliga via samma Adobe Org, med din Adobe ID.

+ [AEM as a Cloud Service](#aem-as-a-cloud-service)
+ [Adobe Project FireFly](#adobe-project-firefly)
   + Etableringen kan ta mellan 2 och 10 dagar
+ molnlagring
   + [Azure Blob Storage](https://azure.microsoft.com/en-us/services/storage/blobs/)
   + eller [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&amp;trk=ft_card)

>[!WARNING]
>
>Se till att du har tillgång till alla de ovannämnda tjänsterna innan du fortsätter med kursen.
> 
> Se avsnitten nedan om hur du ställer in och tillhandahåller de tjänster som krävs.

## AEM som en Cloud Service{#aem-as-a-cloud-service}

Du måste ha tillgång till en AEM som Cloud Service för att kunna konfigurera AEM Assets bearbetningsprofiler så att den anpassade Asset compute-arbetaren anropas.

Helst är ett sandlådeprogram eller en icke-sandlådeutvecklingsmiljö tillgänglig för användning.

Observera att en lokal AEM SDK inte räcker till för att slutföra den här självstudiekursen, eftersom den lokala AEM SDK inte kan kommunicera med Asset compute-mikrotjänster, i stället krävs en AEM som Cloud Service.

## Adobe Project Fire{#adobe-project-firefly}

[Adobe Project Fire](https://www.adobe.io/apis/experienceplatform/project-firefly.html)-ramverket används för att skapa och distribuera anpassade åtgärder till Adobe I/O Runtime, Adobe serverless-plattformen. AEM Asset compute är särskilt byggda Firerefly-projekt som integreras med AEM Assets via Bearbetningsprofiler och som ger möjlighet att komma åt och bearbeta resurbinärfiler.

Registrera dig för förhandsgranskningen om du vill få åtkomst till Project Fire.

1. [Registrera dig för Project Fire Preview](https://adobeio.typeform.com/to/obqgRm).
1. Vänta i cirka 2-10 dagar tills du får ett e-postmeddelande om att du har etablerat dig innan du fortsätter med självstudiekursen.
   + Om du är osäker på om du har etablerat dig fortsätter du med nästa steg och om du inte kan skapa ett __Project Firefly__-projekt i [Adobe Developer Console](https://console.adobe.io) har du fortfarande inte etablerats.

## molnlagring

Molnlagring krävs för lokal utveckling av Asset compute-projekt.

När arbetare i Asset compute distribueras till Adobe I/O Runtime för direkt användning av AEM som Cloud Service krävs inte detta molnlagringsutrymme eftersom AEM tillhandahåller det molnlagringsutrymme som resursen läses från och återgivningen skrivs till.

### Microsoft Azure Blob Storage{#azure-blob-storage}

Om du inte redan har tillgång till Microsoft Azure Blob Storage registrerar du dig för ett [kostnadsfritt 12-månaderskonto](https://azure.microsoft.com/en-us/free/).

I den här självstudiekursen används Azure Blob Storage, men [Amazon S3](#amazon-s3) kan bara användas med mindre variationer av självstudiekursen.

>[!VIDEO](https://video.tv.adobe.com/v/40377/?quality=12&learn=on)

_Klicka igenom etableringen av Azure Blob Storage (inget ljud)_


1. Logga in på ditt [Microsoft Azure-konto](https://azure.microsoft.com/en-us/account/).
1. Gå till avsnittet __Lagringskonton__ Azure-tjänster
1. Tryck på __+ Lägg till__ för att skapa ett nytt Blob Storage-konto
1. Skapa en ny __resursgrupp__ efter behov, till exempel: `aem-as-a-cloud-service`
1. Ange ett __lagringskontonamn__, till exempel: `aemguideswkndassetcomput`
   + __Lagringskontots namn__ kommer att användas för [konfigurering av molnlagring](../develop/environment-variables.md) för det lokala utvecklingsverktyget i Asset compute
   + __Åtkomstnycklarna__ som är associerade med lagringskontot krävs också när [molnlagring](../develop/environment-variables.md) konfigureras.
1. Lämna allt annat som standard och tryck på knappen __Granska + skapa__
   + Du kan också markera den __plats__ som är nära dig.
1. Granska begäran om etablering och kontrollera om den är korrekt och tryck på __Skapa__ om den är godkänd

### Amazon S3{#amazon-s3}

Du bör använda [Microsoft Azure Blob Storage](#azure-blob-storage) för att slutföra den här självstudiekursen, men [Amazon S3](https://aws.amazon.com/s3/?did=ft_card&amp;trk=ft_card) kan också användas.

Om du använder Amazon S3-lagring anger du inloggningsuppgifterna för Amazon S3-molnlagring när [du konfigurerar projektets miljövariabler](../develop/environment-variables.md#amazon-s3).

Om du behöver tillhandahålla molnlagring särskilt för den här självstudiekursen rekommenderar vi att du använder [Azure Blob Storage](#azure-blob-storage).
