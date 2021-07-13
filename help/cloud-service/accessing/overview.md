---
title: Konfigurera åtkomst till AEM som en Cloud Service
description: 'AEM som Cloud Service är det molnbaserade sättet att utnyttja de AEM programmen, och utnyttjar därför Adobe IMS (Identity Management System) för att underlätta inloggningen av användare, både administratörer och vanliga användare, i AEM Author. Läs om hur Adobe IMS-användare, användargrupper och produktprofiler används tillsammans med AEM och behörigheter för att ge specifik åtkomst till AEM Author.  '
feature: 'Användare och grupper '
topics: authentication
version: cloud-service
activity: setup
audience: administrator
doc-type: article
kt: 5882
thumbnail: KT-5882.jpg
topic: Administration, säkerhet
role: Admin
level: Beginner
source-git-commit: b0bca57676813bd353213b4808f99c463272de85
workflow-type: tm+mt
source-wordcount: '600'
ht-degree: 1%

---


# Konfigurera åtkomst till AEM som en Cloud Service

>[!CONTEXTUALHELP]
>id="aemcloud_adobeims_overview"
>title="Introduktion till Adobe IMS"
>abstract="AEM som Cloud Service använder Adobe IMS (Identity Management System) för att underlätta inloggningen för sina användare, både administratörer och vanliga användare, till tjänsten AEM Author. Se hur användare, grupper och produktprofiler i Adobe IMS används tillsammans med AEM grupper och behörigheter för att ge detaljerad åtkomst till tjänsten AEM Author."

AEM som Cloud Service är det molnbaserade sättet att utnyttja de AEM programmen, och utnyttjar därför Adobe IMS (Identity Management System) för att underlätta inloggningen för användare, både administratörer och vanliga användare, till tjänsten AEM Author. Se hur användare, grupper och produktprofiler i Adobe IMS används tillsammans med AEM grupper och behörigheter för att ge detaljerad åtkomst till tjänsten AEM Author.

## Adobe IMS-användare

Användare som behöver åtkomst till AEM Author-tjänsten hanteras som [Adobe IMS-användare](https://helpx.adobe.com/enterprise/using/set-up-identity.html) i [Adobe AdminConsole](https://adminconsole.adobe.com). Lär dig mer om vad Adobe IMS-användare är och hur de nås och hanteras i Admin Console.

[Läs om Adobe IMS-användare](./adobe-ims-users.md)

## Adobe IMS-användargrupper

Användare som använder AEM Author-tjänsten bör organiseras i logiska grupper med [Adobe IMS-användargrupper](https://helpx.adobe.com/enterprise/using/user-groups.html) i [Adobe AdminConsole](https://adminconsole.adobe.com). Användargrupper för Adobe IMS ger inte direkt behörighet eller åtkomst till AEM (det här är jobbet för [Adobe IMS-produktprofiler](#adobe-ims-product-profiles)), men det är ett bra sätt att definiera logiska användargrupper som i sin tur kan översättas till specifika åtkomstnivåer i AEM Author-tjänsten, med hjälp av AEM grupper och behörigheter.

[Läs om användargrupper i Adobe IMS](./adobe-ims-user-groups.md)

## Adobe IMS-produktprofiler

[Adobe IMS-produktprofiler](https://helpx.adobe.com/enterprise/using/manage-permissions-and-roles.html), som hanteras i  [Adobe AdminConsole](https://adminconsole.adobe.com), är den mekanism som ger  [Adobe IMS-](#adobe-ims-users) användare tillgång till tjänsten AEM Author med grundläggande åtkomstnivå.

+ Med produktprofilen __AEM Användare__ får användare skrivskyddad åtkomst till AEM via medlemskap i AEM Contributors-grupp.
+ __AEM Administratörer__-produktprofilen ger användarna fullständig, administrativ åtkomst till AEM.

[Läs om produktprofiler för Adobe IMS](./adobe-ims-product-profiles.md)

## AEM användargrupper och behörigheter

Adobe Experience Manager bygger på användare av Adobe IMS, användargrupper och produktprofiler för att ge användare anpassningsbar åtkomst till AEM. Lär dig hur du skapar AEM grupper och behörigheter och hur de fungerar tillsammans med Adobe IMS-abstraktioner för att ge smidig och anpassningsbar åtkomst till AEM.

[Läs mer om AEM användare, grupper och behörigheter](./aem-users-groups-and-permissions.md)

## Genomgång av åtkomst och behörigheter

En förkortad genomgång som konfigurerar IMS-användare i Adobe, användargrupper och produktprofiler i Adobe AdminConsole, och hur du använder dessa IMS-abstraktioner i Adobe i AEM Author för att definiera och hantera specifika gruppbaserade behörigheter.

[AEM och behörigheter](./walk-through.md)

## Fler Adobe Admin Console-resurser

Följande dokumentation handlar om [Adobe Admin Console](https://adminconsole.adobe.com)-specifik information och frågor som kan hjälpa till att få en bättre förståelse för Adobe Admin Console och använda det för att hantera användare och få åtkomst till olika Experience Cloud-produkter.

+ [Adobe Admin Console Identity - översikt](https://helpx.adobe.com/enterprise/using/identity.html)
+ [Adobe Admin Console Admin-roller](https://helpx.adobe.com/enterprise/using/admin-roles.html)
+ [Adobe Admin Console Developer roles](https://helpx.adobe.com/enterprise/using/manage-developers.html)