---
title: Konfigurera åtkomst till AEM as a Cloud Service
description: AEM as a Cloud Service är det molnbaserade sättet att utnyttja de AEM programmen, och utnyttjar därför Adobe IMS (Identity Management System) för att underlätta inloggning av användare, både administratörer och vanliga användare, AEM författartjänsten. Läs om hur Adobe IMS-användare, användargrupper och produktprofiler används tillsammans med AEM och behörigheter för att ge specifik åtkomst till AEM författare.
version: Cloud Service
topic: Administration, Security
feature: User and Groups
role: Admin
level: Beginner
jira: KT-5882
thumbnail: KT-5882.jpg
last-substantial-update: 2022-10-06T00:00:00Z
exl-id: 4846a394-cf8e-4d52-8f8b-9e874f2f457b
duration: 113
source-git-commit: f4c621f3a9caa8c2c64b8323312343fe421a5aee
workflow-type: tm+mt
source-wordcount: '598'
ht-degree: 0%

---

# Konfigurera åtkomst till AEM as a Cloud Service {#configuring-access-to-aem-as-a-cloud-service}

>[!CONTEXTUALHELP]
>id="aemcloud_adobeims_overview"
>title="Introduktion till Adobe IMS"
>abstract="AEM as a Cloud Service använder Adobe IMS (Identity Management System) för att underlätta inloggningen för användare, både administratörer och vanliga användare, AEM tjänsten Author. Läs om hur användare, grupper och produktprofiler i Adobe IMS används tillsammans med AEM och behörigheter för att ge detaljerad åtkomst till AEM Author-tjänsten."

AEM as a Cloud Service är det molnbaserade sättet att utnyttja de AEM programmen, och utnyttjar därför Adobe IMS (Identity Management System) för att underlätta inloggningen för användare, både administratörer och vanliga användare, till AEM författartjänsten.

![Adobe Admin Console](./assets/hero.png)

Läs om hur användare, grupper och produktprofiler i Adobe IMS används tillsammans med AEM och behörigheter för att ge detaljerad åtkomst till AEM Author-tjänsten.

## Adobe IMS-användare

Användare som behöver åtkomst till AEM Author-tjänsten hanteras som [Adobe IMS-användare](https://helpx.adobe.com/enterprise/using/set-up-identity.html) in [Adobe AdminConsole](https://adminconsole.adobe.com). Lär dig mer om vad Adobe IMS-användare är och hur de nås och hanteras i Admin Console.

>[!NOTE]
>
>När en IMS-användare tas bort från AdminConsole tas den inte automatiskt bort från AEM, men när AEM session(token) har gått ut kan de INTE logga in på AEM.


[Läs om Adobe IMS-användare](./adobe-ims-users.md)

## Adobe IMS-användargrupper

Användare som har åtkomst till AEM Author-tjänsten ska organiseras i logiska grupper med hjälp av [Adobe IMS-användargrupper](https://helpx.adobe.com/enterprise/using/user-groups.html) in [Adobe AdminConsole](https://adminconsole.adobe.com). Adobe IMS-användargrupper ger inte direkt behörighet eller åtkomst till AEM (det här är jobbet för [Produktprofiler för Adobe IMS](#adobe-ims-product-profiles)) är de dock ett bra sätt att definiera logiska användargrupper som i sin tur kan översättas till specifika åtkomstnivåer i AEM Author-tjänsten, med hjälp av AEM grupper och behörigheter.

[Läs om Adobe IMS-användargrupper](./adobe-ims-user-groups.md)

## Produktprofiler för Adobe IMS

[Produktprofiler för Adobe IMS](https://helpx.adobe.com/enterprise/using/manage-permissions-and-roles.html), hanteras i [Adobe AdminConsole](https://adminconsole.adobe.com), är den mekanik som ger [Adobe IMS-användare](#adobe-ims-users) behörighet att logga in på AEM Author-tjänsten med en basåtkomstnivå.

+ The __AEM__ Med produktprofilen får användare skrivskyddad åtkomst till AEM via medlemskap i AEM Contributors-gruppen.
+ The __AEM administratörer__ produktprofilen ger användarna full, administrativ åtkomst till AEM.

[Läs om produktprofiler för Adobe IMS](./adobe-ims-product-profiles.md)

## AEM användargrupper och behörigheter

Adobe Experience Manager bygger på Adobe IMS-användare, användargrupper och produktprofiler för att ge användarna anpassningsbar åtkomst till AEM. Lär dig hur du skapar AEM grupper och behörigheter och hur de fungerar tillsammans med abstraktioner i Adobe IMS för att ge smidig och anpassningsbar åtkomst till AEM.

[Läs mer om AEM användare, grupper och behörigheter](./aem-users-groups-and-permissions.md)

## Genomgång av åtkomst och behörigheter

En förkortad genomgång som konfigurerar Adobe IMS-användare, användargrupper och produktprofiler i Adobe AdminConsole, och hur du använder dessa Adobe IMS-abstraktioner i AEM Author för att definiera och hantera specifika gruppbaserade behörigheter.

[AEM åtkomst och behörigheter](./walk-through.md)

## Fler Adobe Admin Console-resurser

Följande dokumentationsmaterial [Adobe Admin Console](https://adminconsole.adobe.com)-specifik information och frågor som kan hjälpa till att få en bättre förståelse för Adobe Admin Console och använda det för att hantera användare och få tillgång till det mellan Experience Cloud-produkter.

+ [Adobe Admin Console Identity - översikt](https://helpx.adobe.com/enterprise/using/identity.html)
+ [Adobe Admin Console Admin-roller](https://helpx.adobe.com/enterprise/using/admin-roles.html)
+ [Adobe Admin Console Developer roles](https://helpx.adobe.com/enterprise/using/manage-developers.html)
