---
title: Konfigurera åtkomst till AEM as a Cloud Service
description: AEM as a Cloud Service är det molnbaserade sättet att utnyttja AEM-programmen och utnyttjar därför Adobe IMS (Identity Management System) för att underlätta inloggning av användare, både administratörer och vanliga användare, i AEM Author. Läs om hur Adobe IMS-användare, användargrupper och produktprofiler används tillsammans med AEM-grupper och behörigheter för att ge specifik åtkomst till AEM Author.
version: Experience Manager as a Cloud Service
topic: Administration, Security
feature: User and Groups
role: Admin
level: Beginner
jira: KT-5882
thumbnail: KT-5882.jpg
last-substantial-update: 2022-10-06T00:00:00Z
exl-id: 4846a394-cf8e-4d52-8f8b-9e874f2f457b
duration: 113
source-git-commit: 48433a5367c281cf5a1c106b08a1306f1b0e8ef4
workflow-type: tm+mt
source-wordcount: '598'
ht-degree: 0%

---

# Konfigurera åtkomst till AEM as a Cloud Service {#configuring-access-to-aem-as-a-cloud-service}

>[!CONTEXTUALHELP]
>id="aemcloud_adobeims_overview"
>title="Introduktion till Adobe IMS"
>abstract="AEM as a Cloud Service använder Adobe IMS (Identity Management System) för att underlätta inloggningen för användare, både administratörer och vanliga användare, i AEM Author. Läs om hur användare, grupper och produktprofiler i Adobe IMS används tillsammans med AEM-grupper och behörigheter för att ge detaljerad åtkomst till tjänsten AEM Author."

AEM as a Cloud Service är det molnbaserade sättet att utnyttja AEM-programmen och utnyttjar därför Adobe IMS (Identity Management System) för att underlätta inloggningen för användare, både administratörer och vanliga användare, till tjänsten AEM Author.

![Adobe Admin Console](./assets/hero.png)

Läs om hur användare, grupper och produktprofiler i Adobe IMS används tillsammans med AEM-grupper och behörigheter för att ge detaljerad åtkomst till tjänsten AEM Author.

## Adobe IMS-användare

Användare som behöver åtkomst till AEM Author-tjänsten hanteras som [Adobe IMS-användare](https://helpx.adobe.com/se/enterprise/using/set-up-identity.html) i [Adobe AdminConsole](https://adminconsole.adobe.com). Lär dig mer om vad Adobe IMS-användare är och hur de nås och hanteras i Admin Console.

>[!NOTE]
>
>När en IMS-användare tas bort från AdminConsole tas den inte automatiskt bort från AEM, men när AEM session(token) har gått ut kan de INTE logga in på AEM.


[Läs om Adobe IMS-användare](./adobe-ims-users.md)

## Adobe IMS-användargrupper

Användare som har åtkomst till AEM Author-tjänsten bör ordnas i logiska grupper med hjälp av [Adobe IMS-användargrupper](https://helpx.adobe.com/se/enterprise/using/user-groups.html) i [Adobe AdminConsole](https://adminconsole.adobe.com). Adobe IMS-användargrupper ger inte direkt behörighet eller åtkomst till AEM (det här är jobbet för [Adobe IMS-produktprofiler](#adobe-ims-product-profiles)), men det är ett bra sätt att definiera logiska användargrupper som i sin tur kan översättas till specifika åtkomstnivåer i AEM Author-tjänsten, med hjälp av AEM-grupper och behörigheter.

[Läs om Adobe IMS-användargrupper](./adobe-ims-user-groups.md)

## Produktprofiler för Adobe IMS

[Adobes IMS-produktprofiler](https://helpx.adobe.com/se/enterprise/using/manage-permissions-and-roles.html), som hanteras i [Adobe AdminConsole](https://adminconsole.adobe.com), är den mekanism som ger [Adobe IMS-användare](#adobe-ims-users) tillgång till AEM Author-tjänsten med grundläggande åtkomstnivå.

+ Med produktprofilen __AEM Users__ får användare skrivskyddad åtkomst till AEM via medlemskap i AEM Contributors-gruppen.
+ Med produktprofilen __AEM-administratörer__ får användare fullständig, administrativ åtkomst till AEM.

[Läs om produktprofiler för Adobe IMS](./adobe-ims-product-profiles.md)

## AEM användargrupper och behörigheter

Adobe Experience Manager bygger på Adobe IMS-användare, användargrupper och produktprofiler för att ge användarna anpassningsbar åtkomst till AEM. Lär dig hur du skapar AEM-grupper och behörigheter och hur de fungerar tillsammans med abstraktioner i Adobe IMS för att ge smidig och anpassningsbar åtkomst till AEM.

[Läs om AEM användare, grupper och behörigheter](./aem-users-groups-and-permissions.md)

## Genomgång av åtkomst och behörigheter

En förkortad genomgång som konfigurerar Adobe IMS-användare, användargrupper och produktprofiler i Adobe AdminConsole, och hur du använder dessa Adobe IMS-abstraktioner i AEM Author för att definiera och hantera specifika gruppbaserade behörigheter.

[AEM åtkomst och behörigheter genomgående](./walk-through.md)

## Fler Adobe Admin Console-resurser

I följande dokumentation beskrivs [Adobe Admin Console](https://adminconsole.adobe.com) -specifik information och problem som kan hjälpa till att få en bättre förståelse för Adobe Admin Console och använda det för att hantera användare och komma åt mellan Experience Cloud-produkter.

+ [Adobe Admin Console Identity - översikt](https://helpx.adobe.com/se/enterprise/using/identity.html)
+ [Adobe Admin Console Admin-roller](https://helpx.adobe.com/se/enterprise/using/admin-roles.html)
+ [Adobe Admin Console Developer roles](https://helpx.adobe.com/se/enterprise/using/manage-developers.html)
